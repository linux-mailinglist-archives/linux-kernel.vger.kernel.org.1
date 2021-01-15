Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93F012F7201
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 06:19:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731702AbhAOFSO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 00:18:14 -0500
Received: from mx2.suse.de ([195.135.220.15]:49990 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726634AbhAOFSN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 00:18:13 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1610687846; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=y+EEM5p4J6HAj0K86gGJsuaTuVxaPbz2acsMV1JwTEk=;
        b=gMRvbYFgv5Suw/SzgaTg+BBNbbowakwEZd0qTO7f0Br+Xbk8iE7suQqgP/duTRiOmgr5EE
        lhlaWFTRMP8uACeaC7+42WawYR4M9b7U5XTssxOEYdellCSu87etFGPbB0dLGajo78MlwB
        49oC30iUwoLUioal48g8XV5gVolhUbM=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 9A849AE61;
        Fri, 15 Jan 2021 05:17:26 +0000 (UTC)
Subject: Re: [PATCH 14/21] x86/xen: Support objtool vmlinux.o validation in
 xen-head.S
To:     Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com,
        Miroslav Benes <mbenes@suse.cz>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>
References: <cover.1610652862.git.jpoimboe@redhat.com>
 <02a3b646aa20035c9c700c5b6d7897a9f898ba24.1610652862.git.jpoimboe@redhat.com>
From:   =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Message-ID: <43d47af1-6735-6651-db11-4489c86c62a2@suse.com>
Date:   Fri, 15 Jan 2021 06:17:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <02a3b646aa20035c9c700c5b6d7897a9f898ba24.1610652862.git.jpoimboe@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="2YhinrR0QVR3BdE4MEf3ELoBpe54uf0wZ"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--2YhinrR0QVR3BdE4MEf3ELoBpe54uf0wZ
Content-Type: multipart/mixed; boundary="vKOsGyGWEuckNKaORjGB8A10DjxiUpUmV";
 protected-headers="v1"
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
To: Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
 Sami Tolvanen <samitolvanen@google.com>, Sedat Dilek
 <sedat.dilek@gmail.com>, Kees Cook <keescook@chromium.org>,
 Nick Desaulniers <ndesaulniers@google.com>,
 clang-built-linux@googlegroups.com, Miroslav Benes <mbenes@suse.cz>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>
Message-ID: <43d47af1-6735-6651-db11-4489c86c62a2@suse.com>
Subject: Re: [PATCH 14/21] x86/xen: Support objtool vmlinux.o validation in
 xen-head.S
References: <cover.1610652862.git.jpoimboe@redhat.com>
 <02a3b646aa20035c9c700c5b6d7897a9f898ba24.1610652862.git.jpoimboe@redhat.com>
In-Reply-To: <02a3b646aa20035c9c700c5b6d7897a9f898ba24.1610652862.git.jpoimboe@redhat.com>

--vKOsGyGWEuckNKaORjGB8A10DjxiUpUmV
Content-Type: multipart/mixed;
 boundary="------------BBA3C57DDCB4B42CF384FC97"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------BBA3C57DDCB4B42CF384FC97
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable

On 14.01.21 20:40, Josh Poimboeuf wrote:
> The Xen hypercall page is filled with zeros, causing objtool to fall
> through all the empty hypercall functions until it reaches a real
> function, resulting in a stack state mismatch.
>=20
> The build-time contents of the hypercall page don't matter, since it
> gets mapped to the hypervisor.

This sentence is technically wrong: the contents don't matter, as the
page will be rewritten by the hypervisor.


Juergen


--------------BBA3C57DDCB4B42CF384FC97
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

--------------BBA3C57DDCB4B42CF384FC97--

--vKOsGyGWEuckNKaORjGB8A10DjxiUpUmV--

--2YhinrR0QVR3BdE4MEf3ELoBpe54uf0wZ
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmABJWUFAwAAAAAACgkQsN6d1ii/Ey+u
Wwf+L7Wc4s2VSdkGP4TziiAQOPyXLMzZtIadL+AffpeLjPyuvSLrrlb2OW9B4GrVLpk8LXEbEKv/
NsewZGlR97vLwqnq8r8P5RUxOLYGZ2arjm+h1je5f0f+OnvHbVbWEqgx+qqjeoWfJwjj1bmve40g
+UPpgxpe6Yyyvg+MYrHBjBqDOFIkSDEX7eGdM7b3qKDJZtVbOSn3uWGcO+C1G/VxPnfdKznCoWN4
KfSaF58zU1YeiEzhL/5I9mdQRwFu9sELPl3zqfDzDkkJPd6ejqT5/1KlX7tVrmdz8CU6KyDbwgVo
rdGK4lP+tKKUoVUA6aM5qk0jNXkzAhZ5y/L3Y8VHtw==
=EbbS
-----END PGP SIGNATURE-----

--2YhinrR0QVR3BdE4MEf3ELoBpe54uf0wZ--
