Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 491232B361D
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Nov 2020 17:27:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727061AbgKOQN7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Nov 2020 11:13:59 -0500
Received: from mx2.suse.de ([195.135.220.15]:36718 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726876AbgKOQN7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Nov 2020 11:13:59 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1605456836; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6dSz82MlnBOzbF4QtAoyGe4Yw3fLEUf95Sr0kwUiMUY=;
        b=kJsu6TqPrNYWxosG64gqUgq5ObZB3l028FdJuOQVvvKs6aN52pkLEPz/DM4Tfb2pWSyGle
        vyvdcR3WdWeaSJxmmO3whEqf0LbJvzDAT5gZSSj+hyauaKellbCiSJAg15XTAizahH1dEK
        osmHb8aOJpe1VPyqwDq8HhlM94oZ0rQ=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B3B24ABD6;
        Sun, 15 Nov 2020 16:13:56 +0000 (UTC)
Subject: Re: WARNING: can't access registers at asm_common_interrupt
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        linux-kernel@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        X86 ML <x86@kernel.org>
References: <01c2234c-39a3-2227-25b9-854144c6eb27@suse.com>
 <53DCD372-A847-4B74-A034-330E372B4EB5@amacapital.net>
From:   =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Message-ID: <65373524-6c5f-cd55-9146-cf3e947bd423@suse.com>
Date:   Sun, 15 Nov 2020 17:13:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <53DCD372-A847-4B74-A034-330E372B4EB5@amacapital.net>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="SI4yprRupZ5DmQUjlpYteZ8xMJNiaPTPB"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--SI4yprRupZ5DmQUjlpYteZ8xMJNiaPTPB
Content-Type: multipart/mixed; boundary="9hfXDvMysQabT6vOjljTYFWKDBXhsrath";
 protected-headers="v1"
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
To: Andy Lutomirski <luto@amacapital.net>
Cc: Andy Lutomirski <luto@kernel.org>,
 Andrew Cooper <andrew.cooper3@citrix.com>,
 Josh Poimboeuf <jpoimboe@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 linux-kernel@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>,
 Damien Le Moal <Damien.LeMoal@wdc.com>, X86 ML <x86@kernel.org>
Message-ID: <65373524-6c5f-cd55-9146-cf3e947bd423@suse.com>
Subject: Re: WARNING: can't access registers at asm_common_interrupt
References: <01c2234c-39a3-2227-25b9-854144c6eb27@suse.com>
 <53DCD372-A847-4B74-A034-330E372B4EB5@amacapital.net>
In-Reply-To: <53DCD372-A847-4B74-A034-330E372B4EB5@amacapital.net>

--9hfXDvMysQabT6vOjljTYFWKDBXhsrath
Content-Type: multipart/mixed;
 boundary="------------1EBCA15DD09CF3B407B0DC04"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------1EBCA15DD09CF3B407B0DC04
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable

On 15.11.20 17:05, Andy Lutomirski wrote:
>=20
>> On Nov 14, 2020, at 10:33 PM, J=C3=BCrgen Gro=C3=9F <jgross@suse.com> =
wrote:
>>
>> =EF=BB=BFOn 14.11.20 19:10, Andy Lutomirski wrote:
>>>> On Sat, Nov 14, 2020 at 1:16 AM J=C3=BCrgen Gro=C3=9F <jgross@suse.c=
om> wrote:
>>>>
>>>> On 13.11.20 18:34, Andy Lutomirski wrote:
>>>>> On Wed, Nov 11, 2020 at 12:25 PM Andrew Cooper
>>>>> <andrew.cooper3@citrix.com> wrote:
>>>>>
>>>>> So I think there is at most one of these that wants anything more
>>>>> complicated than a plain ALTERNATIVE.  Any volunteers to make it so=
?
>>>>> Juergen, if you do all of them except USERGS_SYSRET64, I hereby
>>>>> volunteer to do that one.
>>>>
>>>> Why is a plain alternative (either swapgs; sysretq or a jmp xen_sysr=
et64
>>>> depending on X86_FEATURE_XENPV) no option?
>>>>
>>>> Its not as if this code would run before alternative patching.
>>> ALTERNATIVE would "work" in the sense that it would function and be
>>> just about as nonsensical as the current code.  Fundamentally, Xen
>>> PV's sysret feature is not a drop-in replacement for SYSRET64, and
>>> pretending that it is seems unlikely to work well.  I suspect that th=
e
>>> current code is some combination of exceedingly slow, non-functional,=

>>> and incorrect in subtle ways.
>>> We should just have a separate Xen PV exit path the same way we have =
a
>>> separate entry path in recent kernels.  *This* is what I'm
>>> volunteering to do.
>>
>> I don't think there is much work needed. Xen PV does basically a retur=
n
>> to user mode via IRET. I think it might work just to use
>> swapgs_restore_regs_and_return_to_usermode() unconditionally for Xen P=
V.
>>
>=20
> I=E2=80=99m quite confident that will work, but I was hoping to get it =
to work quickly too :)

The PV interface requires to use the iret hypercall, because there
is no sysret equivalent.


Juergen

--------------1EBCA15DD09CF3B407B0DC04
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

--------------1EBCA15DD09CF3B407B0DC04--

--9hfXDvMysQabT6vOjljTYFWKDBXhsrath--

--SI4yprRupZ5DmQUjlpYteZ8xMJNiaPTPB
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAl+xU8MFAwAAAAAACgkQsN6d1ii/Ey8s
ZQf/YR/o8S+84ct16PO6Md4tlAuiWFS5EPTTYGY9NYNv/SDojaItkNVRgPmjvaOg5XphgghBcdB/
UsWTTzGFFo3SZ1fOWl6VDm9nN4EijVyH6gR4uL7lgkiVxlRu7vmwlz6llAJQiVamFxalX06ackEQ
lsd4550EClphxldjfaKSg/0YV9weyV2lPmEUnRwZrEFKv2Crux2sDVKfDxa1HDmgUY5lbGo40vIt
dDmsxodJLRG8MK6KWS/y64XoWC+pxQ6eysuSFeXlRujrhEZiHe1O6ZwVpLdqTQJWFMsBDimxAoJL
w7WfQIsolQCEoi5TLFJEUKpuvxLwxsTfPTH/83H8oQ==
=eQqr
-----END PGP SIGNATURE-----

--SI4yprRupZ5DmQUjlpYteZ8xMJNiaPTPB--
