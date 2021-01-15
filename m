Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BB522F722F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 06:26:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731767AbhAOFZa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 00:25:30 -0500
Received: from mx2.suse.de ([195.135.220.15]:51184 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726634AbhAOFY7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 00:24:59 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1610688252; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=J2xnywbZmgxwNYeVJp6k6b1c5mAHJeCdKgFgbMlcff8=;
        b=QydJfn0zsx88F986+4L4w5uez3WRcDdsq85a44PDCA0+pocPMTdNFcA42uFSNmjJ21KOD1
        KFRCrbzrJvMZJxxv0VDPVMnHLd9ffVKIwkWrfiuYjy9j5XRPJU8WguIFWpELa2PEcbleGP
        qHSb9I7hUuJ5Wwe7XVmXrDKvJ1WjGvY=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D4484AB7A;
        Fri, 15 Jan 2021 05:24:11 +0000 (UTC)
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
 <adfa2afe5ddc831017222db9f48ad0fbff17c807.1610652862.git.jpoimboe@redhat.com>
From:   =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Subject: Re: [PATCH 15/21] x86/xen/pvh: Convert indirect jump to retpoline
Message-ID: <12afb52c-f555-656e-d544-c2965a616bdc@suse.com>
Date:   Fri, 15 Jan 2021 06:24:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <adfa2afe5ddc831017222db9f48ad0fbff17c807.1610652862.git.jpoimboe@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="tcEbDVrouNxRCQT6V6Z5mmVZzjxADZESG"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--tcEbDVrouNxRCQT6V6Z5mmVZzjxADZESG
Content-Type: multipart/mixed; boundary="BghqoVWYJFtxav4Rjq1fhrg7lEQgeEz5i";
 protected-headers="v1"
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
To: Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
 Sami Tolvanen <samitolvanen@google.com>, Sedat Dilek
 <sedat.dilek@gmail.com>, Kees Cook <keescook@chromium.org>,
 Nick Desaulniers <ndesaulniers@google.com>,
 clang-built-linux@googlegroups.com, Miroslav Benes <mbenes@suse.cz>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>
Message-ID: <12afb52c-f555-656e-d544-c2965a616bdc@suse.com>
Subject: Re: [PATCH 15/21] x86/xen/pvh: Convert indirect jump to retpoline
References: <cover.1610652862.git.jpoimboe@redhat.com>
 <adfa2afe5ddc831017222db9f48ad0fbff17c807.1610652862.git.jpoimboe@redhat.com>
In-Reply-To: <adfa2afe5ddc831017222db9f48ad0fbff17c807.1610652862.git.jpoimboe@redhat.com>

--BghqoVWYJFtxav4Rjq1fhrg7lEQgeEz5i
Content-Type: multipart/mixed;
 boundary="------------50C7AC22B88B580CBA5BADB1"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------50C7AC22B88B580CBA5BADB1
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable

On 14.01.21 20:40, Josh Poimboeuf wrote:
> It's kernel policy to not have (unannotated) indirect jumps because of
> Spectre v2.  This one's probably harmless, but better safe than sorry.
> Convert it to a retpoline.
>=20
> Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
> Cc: Juergen Gross <jgross@suse.com>
> Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
> ---
>   arch/x86/platform/pvh/head.S | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/x86/platform/pvh/head.S b/arch/x86/platform/pvh/head.=
S
> index 43b4d864817e..d87cebd08d32 100644
> --- a/arch/x86/platform/pvh/head.S
> +++ b/arch/x86/platform/pvh/head.S
> @@ -16,6 +16,7 @@
>   #include <asm/boot.h>
>   #include <asm/processor-flags.h>
>   #include <asm/msr.h>
> +#include <asm/nospec-branch.h>
>   #include <xen/interface/elfnote.h>
>  =20
>   	__HEAD
> @@ -105,7 +106,7 @@ SYM_CODE_START_LOCAL(pvh_start_xen)
>   	/* startup_64 expects boot_params in %rsi. */
>   	mov $_pa(pvh_bootparams), %rsi
>   	mov $_pa(startup_64), %rax
> -	jmp *%rax
> +	JMP_NOSPEC rax

I'd rather have it annotated only.

Using ALTERNATIVE in very early boot code is just adding needless
clutter, as the retpoline variant won't ever be active.


Juergen

--------------50C7AC22B88B580CBA5BADB1
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

--------------50C7AC22B88B580CBA5BADB1--

--BghqoVWYJFtxav4Rjq1fhrg7lEQgeEz5i--

--tcEbDVrouNxRCQT6V6Z5mmVZzjxADZESG
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmABJvoFAwAAAAAACgkQsN6d1ii/Ey98
dwf9FKFxh6mblBLmXpWbnobv8fq1R9wat7m3z2UhO6kyOlwBeFJzVvmE6IbT6pwaaT5n3ZfCnQuA
EOnNel9tEAzJoc0hfaFkugTaS+ptIzX1qKfIJvmM1B4JSqcWMpNdf46eqBdIQpwGfopHN0QqCqR0
tK6k/nHWkSBuhIGzwvb1NjbcIiqxggT8NwS/kNhkpRS1hXAA/zVHbg3o4kyJMeKcT8l7/+sEni5/
5NxrVrw2kdJVKK2ll1n1NiWzMJgZUocgeY5hRMKn2x51hgYNOBBrsu8nZY7NYxGjrJ7A6WqX/zAF
YPd/+5rkMJ9LD3AfPdwQJpFoo61c/1nieAsOfXAvew==
=wtac
-----END PGP SIGNATURE-----

--tcEbDVrouNxRCQT6V6Z5mmVZzjxADZESG--
