Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 696F62B928D
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 13:29:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727016AbgKSM3B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 07:29:01 -0500
Received: from mx2.suse.de ([195.135.220.15]:53374 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726052AbgKSM25 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 07:28:57 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1605788936; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9G/X2w48PWTSHGmi+MEwCMkVBiBHwEwu7LhkIHmrQis=;
        b=fgR9VQj/knrYQJX2xzqKFIUeB22sy4heU/4jXlJfM3L57rUgzjv7Z8ukPOXQY/k303ElUQ
        2gQCQjoOoxHlWmL/PA0w8dONIrT9Um8rLTails017MFKdh7llH3B+3fru7pazjIqreQ0gP
        Uj3dZT3D0EKVEHn5Ogi0uS3/B+04snA=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 288ABABDE;
        Thu, 19 Nov 2020 12:28:56 +0000 (UTC)
Subject: Re: WARNING: can't access registers at asm_common_interrupt
To:     Peter Zijlstra <peterz@infradead.org>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        X86 ML <x86@kernel.org>
References: <20201111195900.2x7kfce2ejkmrzi3@treble>
 <20201111200730.GM2628@hirez.programming.kicks-ass.net>
 <20201111201506.bftpmx4svxn376tn@treble>
 <61b2538f-7be6-8f4a-9395-03071b5cc6f0@citrix.com>
 <CALCETrXcTKB_j9MQC1mcZobKGt_cZ5ivDPjU3zwRBmj7DAUCsA@mail.gmail.com>
 <f105a63d-6b51-3afb-83e0-e899ea40813e@suse.com>
 <20201116130413.GC3121392@hirez.programming.kicks-ass.net>
 <e1ca6c8c-e32d-879a-1972-5605f0892176@suse.com>
 <20201118082254.GH3121378@hirez.programming.kicks-ass.net>
 <20201119115059.dns4hvull3l3dwx3@shindev.dhcp.fujisawa.hgst.com>
 <20201119120122.GJ3121392@hirez.programming.kicks-ass.net>
From:   =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Message-ID: <69717baf-2f2c-bc53-b8c5-36552855fa99@suse.com>
Date:   Thu, 19 Nov 2020 13:28:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201119120122.GJ3121392@hirez.programming.kicks-ass.net>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="78ARcIMfVNv2kJYfagpSQwkhpmIL7rsPJ"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--78ARcIMfVNv2kJYfagpSQwkhpmIL7rsPJ
Content-Type: multipart/mixed; boundary="HKekEh6HbUBELgAZjmPraRq9S5INDFAQD";
 protected-headers="v1"
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
To: Peter Zijlstra <peterz@infradead.org>,
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: Andy Lutomirski <luto@kernel.org>,
 Andrew Cooper <andrew.cooper3@citrix.com>,
 Josh Poimboeuf <jpoimboe@redhat.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Nicholas Piggin <npiggin@gmail.com>, Damien Le Moal <Damien.LeMoal@wdc.com>,
 X86 ML <x86@kernel.org>
Message-ID: <69717baf-2f2c-bc53-b8c5-36552855fa99@suse.com>
Subject: Re: WARNING: can't access registers at asm_common_interrupt
References: <20201111195900.2x7kfce2ejkmrzi3@treble>
 <20201111200730.GM2628@hirez.programming.kicks-ass.net>
 <20201111201506.bftpmx4svxn376tn@treble>
 <61b2538f-7be6-8f4a-9395-03071b5cc6f0@citrix.com>
 <CALCETrXcTKB_j9MQC1mcZobKGt_cZ5ivDPjU3zwRBmj7DAUCsA@mail.gmail.com>
 <f105a63d-6b51-3afb-83e0-e899ea40813e@suse.com>
 <20201116130413.GC3121392@hirez.programming.kicks-ass.net>
 <e1ca6c8c-e32d-879a-1972-5605f0892176@suse.com>
 <20201118082254.GH3121378@hirez.programming.kicks-ass.net>
 <20201119115059.dns4hvull3l3dwx3@shindev.dhcp.fujisawa.hgst.com>
 <20201119120122.GJ3121392@hirez.programming.kicks-ass.net>
In-Reply-To: <20201119120122.GJ3121392@hirez.programming.kicks-ass.net>

--HKekEh6HbUBELgAZjmPraRq9S5INDFAQD
Content-Type: multipart/mixed;
 boundary="------------967A5E938EC1036BF5C5820B"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------967A5E938EC1036BF5C5820B
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable

On 19.11.20 13:01, Peter Zijlstra wrote:
> On Thu, Nov 19, 2020 at 11:51:00AM +0000, Shinichiro Kawasaki wrote:
>> I tried Peter's patch in my test system and result looks good. The war=
ning is
>> still observed with 5.10-rc4. With the patch on top of 5.10-rc4, the w=
arning
>> disappeared.
>=20
> The patch on its own is not sufficient to fix things; there needs to be=

> an accompanying objtool patch to generate the correct unwind
> information.
>=20
> This patch only ensures objtool has enough information to be able to
> dtrt, but as it stands it shouldn't even compile, it should complain
> about an alternative trying to modify the stack and bail.
>=20

It complains, but doesn't bail.

I'm nearly ready with my series replacing all the custom code paravirt
patches by ALTERNATIVEs. Quite some paravirt macro cruft turned out to
be unused, so there is a rather large cleanup patch included. :-)


Juergen

--------------967A5E938EC1036BF5C5820B
Content-Type: application/pgp-keys;
 name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="OpenPGP_0xB0DE9DD628BF132F.asc"

-----BEGIN PGP PUBLIC KEY BLOCK-----

xsBNBFOMcBYBCACgGjqjoGvbEouQZw/ToiBg9W98AlM2QHV+iNHsEs7kxWhKMjrioyspZKOBy=
cWx
w3ie3j9uvg9EOB3aN4xiTv4qbnGiTr3oJhkB1gsb6ToJQZ8uxGq2kaV2KL9650I1SJvedYm8O=
f8Z
d621lSmoKOwlNClALZNew72NjJLEzTalU1OdT7/i1TXkH09XSSI8mEQ/ouNcMvIJNwQpd369y=
9bf
IhWUiVXEK7MlRgUG6MvIj6Y3Am/BBLUVbDa4+gmzDC9ezlZkTZG2t14zWPvxXP3FAp2pkW0xq=
G7/
377qptDmrk42GlSKN4z76ELnLxussxc7I2hx18NUcbP8+uty4bMxABEBAAHNHEp1ZXJnZW4gR=
3Jv
c3MgPGpnQHBmdXBmLm5ldD7CwHkEEwECACMFAlOMcBYCGwMHCwkIBwMCAQYVCAIJCgsEFgIDA=
QIe
AQIXgAAKCRCw3p3WKL8TL0KdB/93FcIZ3GCNwFU0u3EjNbNjmXBKDY4FUGNQH2lvWAUy+dnyT=
hpw
dtF/jQ6j9RwE8VP0+NXcYpGJDWlNb9/JmYqLiX2Q3TyevpB0CA3dbBQp0OW0fgCetToGIQrg0=
MbD
1C/sEOv8Mr4NAfbauXjZlvTj30H2jO0u+6WGM6nHwbh2l5O8ZiHkH32iaSTfN7Eu5RnNVUJbv=
oPH
Z8SlM4KWm8rG+lIkGurqqu5gu8q8ZMKdsdGC4bBxdQKDKHEFExLJK/nRPFmAuGlId1E3fe10v=
5QL
+qHI3EIPtyfE7i9Hz6rVwi7lWKgh7pe0ZvatAudZ+JNIlBKptb64FaiIOAWDCx1SzR9KdWVyZ=
2Vu
IEdyb3NzIDxqZ3Jvc3NAc3VzZS5jb20+wsB5BBMBAgAjBQJTjHCvAhsDBwsJCAcDAgEGFQgCC=
QoL
BBYCAwECHgECF4AACgkQsN6d1ii/Ey/HmQf/RtI7kv5A2PS4RF7HoZhPVPogNVbC4YA6lW7Dr=
Wf0
teC0RR3MzXfy6pJ+7KLgkqMlrAbN/8Dvjoz78X+5vhH/rDLa9BuZQlhFmvcGtCF8eR0T1v0nC=
/nu
AFVGy+67q2DH8As3KPu0344TBDpAvr2uYM4tSqxK4DURx5INz4ZZ0WNFHcqsfvlGJALDeE0Lh=
ITT
d9jLzdDad1pQSToCnLl6SBJZjDOX9QQcyUigZFtCXFst4dlsvddrxyqT1f17+2cFSdu7+ynLm=
XBK
7abQ3rwJY8SbRO2iRulogc5vr/RLMMlscDAiDkaFQWLoqHHOdfO9rURssHNN8WkMnQfvUewRz=
80h
SnVlcmdlbiBHcm9zcyA8amdyb3NzQG5vdmVsbC5jb20+wsB5BBMBAgAjBQJTjHDXAhsDBwsJC=
AcD
AgEGFQgCCQoLBBYCAwECHgECF4AACgkQsN6d1ii/Ey8PUQf/ehmgCI9jB9hlgexLvgOtf7PJn=
FOX
gMLdBQgBlVPO3/D9R8LtF9DBAFPNhlrsfIG/SqICoRCqUcJ96Pn3P7UUinFG/I0ECGF4EvTE1=
jnD
kfJZr6jrbjgyoZHiw/4BNwSTL9rWASyLgqlA8u1mf+c2yUwcGhgkRAd1gOwungxcwzwqgljf0=
N51
N5JfVRHRtyfwq/ge+YEkDGcTU6Y0sPOuj4Dyfm8fJzdfHNQsWq3PnczLVELStJNdapwPOoE+l=
otu
fe3AM2vAEYJ9rTz3Cki4JFUsgLkHFqGZarrPGi1eyQcXeluldO3m91NK/1xMI3/+8jbO0tsn1=
tqS
EUGIJi7ox80eSnVlcmdlbiBHcm9zcyA8amdyb3NzQHN1c2UuZGU+wsB5BBMBAgAjBQJTjHDrA=
hsD
BwsJCAcDAgEGFQgCCQoLBBYCAwECHgECF4AACgkQsN6d1ii/Ey+LhQf9GL45eU5vOowA2u5N3=
g3O
ZUEBmDHVVbqMtzwlmNC4k9Kx39r5s2vcFl4tXqW7g9/ViXYuiDXb0RfUpZiIUW89siKrkzmQ5=
dM7
wRqzgJpJwK8Bn2MIxAKArekWpiCKvBOB/Cc+3EXE78XdlxLyOi/NrmSGRIov0karw2RzMNOu5=
D+j
LRZQd1Sv27AR+IP3I8U4aqnhLpwhK7MEy9oCILlgZ1QZe49kpcumcZKORmzBTNh30FVKK1Evm=
V2x
AKDoaEOgQB4iFQLhJCdP1I5aSgM5IVFdn7v5YgEYuJYx37IoN1EblHI//x/e2AaIHpzK5h88N=
Eaw
QsaNRpNSrcfbFmAg987ATQRTjHAWAQgAyzH6AOODMBjgfWE9VeCgsrwH3exNAU32gLq2xvjpW=
nHI
s98ndPUDpnoxWQugJ6MpMncr0xSwFmHEgnSEjK/PAjppgmyc57BwKII3sV4on+gDVFJR6Y8ZR=
wgn
BC5mVM6JjQ5xDk8WRXljExRfUX9pNhdE5eBOZJrDRoLUmmjDtKzWaDhIg/+1Hzz93X4fCQkNV=
bVF
LELU9bMaLPBG/x5q4iYZ2k2ex6d47YE1ZFdMm6YBYMOljGkZKwYde5ldM9mo45mmwe0icXKLk=
pEd
IXKTZeKDO+Hdv1aqFuAcccTg9RXDQjmwhC3yEmrmcfl0+rPghO0Iv3OOImwTEe4co3c1mwARA=
QAB
wsBfBBgBAgAJBQJTjHAWAhsMAAoJELDendYovxMvQ/gH/1ha96vm4P/L+bQpJwrZ/dneZcmEw=
Tbe
8YFsw2V/Buv6Z4Mysln3nQK5ZadD534CF7TDVft7fC4tU4PONxF5D+/tvgkPfDAfF77zy2AH1=
vJz
Q1fOU8lYFpZXTXIHb+559UqvIB8AdgR3SAJGHHt4RKA0F7f5ipYBBrC6cyXJyyoprT10EMvU8=
VGi
wXvTyJz3fjoYsdFzpWPlJEBRMedCot60g5dmbdrZ5DWClAr0yau47zpWj3enf1tLWaqcsuylW=
svi
uGjKGw7KHQd3bxALOknAp4dN3QwBYCKuZ7AddY9yjynVaD5X7nF9nO5BjR/i1DG86lem3iBDX=
zXs
ZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------967A5E938EC1036BF5C5820B--

--HKekEh6HbUBELgAZjmPraRq9S5INDFAQD--

--78ARcIMfVNv2kJYfagpSQwkhpmIL7rsPJ
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAl+2ZQcFAwAAAAAACgkQsN6d1ii/Ey9e
Agf/Xk6hEFAxIdNitEP0kGLTMoD0bJ9GPtOntl9ybFpF2xjyTR6NbSE1iuWYsHJSGWC/1Z8hSXd3
/RBQ/HVUznMWLQREqjktgJ+uwBbQyoDzFCe5lp/vZAKMBgao7V8lWUS0qM/R6nW46DODojFbRIdd
fJQW3FApbzVKuT3n+YbmoRN8tKtsnUuT/gi6vgZG/hWgLYAxGS6FgQeXklIYQsYBioCKis218ThR
QeYH3uKYEN2jmjBp+7CU5ZpxwIftN71DBH2ZIckbwv9URpY9hHmT+4Z+pE1SgzfCr9Dltm5WNDxk
xYG6KLqWa/mk4oCvIZ6lSoXLiWtKpsnJYPtLID77HA==
=5fMD
-----END PGP SIGNATURE-----

--78ARcIMfVNv2kJYfagpSQwkhpmIL7rsPJ--
