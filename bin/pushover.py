#!/usr/bin/env python
import httplib, urllib
import argparse
import os

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description="Pushover!")
    parser.add_argument("--message","-m", required=True)
    args = parser.parse_args()
    token, user = os.getenv('PUSHOVER_TOKEN'), os.getenv('PUSHOVER_USER')
    if token is None or user is None:
        raise Exception("Missing PUSHOVER_TOKEN or PUSHOVER_USER")

    conn = httplib.HTTPSConnection("api.pushover.net:443")
    conn.request("POST", "/1/messages.json",
    urllib.urlencode({
        "token": token,
        "user": user,
        "message": args.message,
    }), { "Content-type": "application/x-www-form-urlencoded" })
    conn.getresponse()

