#!/usr/bin/env python
"""
Usage: cnvt <src> <dest>
"""

import asyncio
import os
import sys
from docopt import docopt
from pathlib import Path
from playwright.async_api import async_playwright

async def html_to_pdf(input_path: str, output_path: str):
    input_file = Path(input_path).resolve()
    url = f"file://{input_file}"

    async def handle_route(route, request):
        url = request.url

        # Handle the prefixed '/' in style ref
        if "/style" in url:
            new_url = url.replace(
                "/style", os.path.join(os.getcwd(), "public") + "/style", 1
            )
            await route.continue_(url=new_url)
        else:
            await route.continue_()

    async with async_playwright() as p:
        browser = await p.chromium.launch(
            headless=True, args=["--disable-web-security"]
        )
        context = await browser.new_context()
        page = await context.new_page()
        await page.route("**/*", handle_route)

        await page.goto(url, wait_until="networkidle")
        await page.emulate_media(media="screen")

        await page.pdf(
            path=output_path,
            page_ranges="1-1",
            width="8.5in",
            height="19in",
            print_background=True,
            margin={"top": "0in", "bottom": "0in", "left": "0in", "right": "0in"},
        )

        await browser.close()

if __name__ == '__main__':
    arguments = docopt(__doc__, version='1.0')
    input_html = arguments['<src>']
    output_pdf = arguments['<dest>']

    if not os.path.exists(input_html):
        print(f"Source file {input_html} does not exist")
        sys.exit()

    asyncio.run(html_to_pdf(input_html, output_pdf))
