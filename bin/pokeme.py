#!/usr/bin/env python
"""Notify yourself of an event
ENV variables:
    POKEME_PUSHOVER_TOKEN
    POKEME_PUSHOVER_USER
    POKEME_NC (anything non empty)
    POKEME_GROWL (anything non empty)
"""
import httplib, urllib
import argparse
import os
import socket

try:
    import gntp.notifier
    growl = True
except ImportError:
    growl = False

try:
    import pync
    nc = True
except ImportError:
    nc = False

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description="Notify!")
    parser.add_argument("message")
    args = parser.parse_args()
    # Add hostname
    message = "%s: %s" % (socket.gethostname(), args.message)
    # Pushover
    token, user = os.getenv('POKEME_PUSHOVER_TOKEN'), os.getenv('POKEME_PUSHOVER_USER')
    if token and user:
        conn = httplib.HTTPSConnection("api.pushover.net:443")
        conn.request("POST", "/1/messages.json",
        urllib.urlencode({
            "token": token,
            "user": user,
            "message": message,
        }), { "Content-type": "application/x-www-form-urlencoded" })
        conn.getresponse()
    # Notification Center
    if nc and os.getenv("POKEME_NC"):
        pync.Notifier.notify(message)
    # Growl
    if growl and os.getenv("POKEME_GROWL"):
        gntp.notifier.mini(message)

