from xkcdpass import xkcd_password as xp

def make_name(): 
    
    return('-'.join(
            xp.generate_xkcdpassword(
                xp.generate_wordlist(
                    xp.locate_wordfile(), min_length=3, max_length=5, valid_chars='[a-z]'),
                numwords=2
            ).split(' ')
        )
    )


# names.py
# Copyright (c) 2017 Christopher DeMarco
# Licensed under Apache License v2.0
