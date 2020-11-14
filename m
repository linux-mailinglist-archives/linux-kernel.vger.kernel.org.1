Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7214E2B2C60
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Nov 2020 10:16:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726634AbgKNJQY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Nov 2020 04:16:24 -0500
Received: from mx2.suse.de ([195.135.220.15]:43660 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726356AbgKNJQX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Nov 2020 04:16:23 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1605345380; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iY5IcyZi5RPf2fuXmL85HUsFGdyXPav2+3vSgmjhOzw=;
        b=FjbN4WIgla4oKsEhKkQqrAkyJzjYFyA254PnQ6AQXkJp77QM9T6edWEpwOVdAAXdEDBbF9
        wI5xurwGw6nofEv84uE7F+HO0MTaz8B3GDSJ5dRPjcmorQ05JQdPhrGp2fezxTH1Pqi2J0
        n/oLopR/DGn1aKBxHIQsrdM55F66djI=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 62969ABF4;
        Sat, 14 Nov 2020 09:16:20 +0000 (UTC)
To:     Andy Lutomirski <luto@kernel.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        X86 ML <x86@kernel.org>
References: <20201106060414.edtcb7nrbzm4a32t@shindev.dhcp.fujisawa.hgst.com>
 <20201111170536.arx2zbn4ngvjoov7@treble>
 <20201111174736.GH2628@hirez.programming.kicks-ass.net>
 <20201111181328.mbxcz2uap2vnqpxq@treble>
 <33843b7f-ed8a-8fcb-19bc-c76cf00f453d@citrix.com>
 <20201111194206.GK2628@hirez.programming.kicks-ass.net>
 <20201111195900.2x7kfce2ejkmrzi3@treble>
 <20201111200730.GM2628@hirez.programming.kicks-ass.net>
 <20201111201506.bftpmx4svxn376tn@treble>
 <61b2538f-7be6-8f4a-9395-03071b5cc6f0@citrix.com>
 <CALCETrXcTKB_j9MQC1mcZobKGt_cZ5ivDPjU3zwRBmj7DAUCsA@mail.gmail.com>
From:   =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Subject: Re: WARNING: can't access registers at asm_common_interrupt
Message-ID: <7afed057-111a-9a21-c114-44987184b683@suse.com>
Date:   Sat, 14 Nov 2020 10:16:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <CALCETrXcTKB_j9MQC1mcZobKGt_cZ5ivDPjU3zwRBmj7DAUCsA@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="YlSgQPm0iu0oMEDpYLSEgpaD9DFFB534r"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--YlSgQPm0iu0oMEDpYLSEgpaD9DFFB534r
Content-Type: multipart/mixed; boundary="DUaNUmdrYAdILv9pSztnaMktaQ8psDwLA";
 protected-headers="v1"
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
To: Andy Lutomirski <luto@kernel.org>,
 Andrew Cooper <andrew.cooper3@citrix.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Nicholas Piggin <npiggin@gmail.com>, Damien Le Moal <Damien.LeMoal@wdc.com>,
 X86 ML <x86@kernel.org>
Message-ID: <7afed057-111a-9a21-c114-44987184b683@suse.com>
Subject: Re: WARNING: can't access registers at asm_common_interrupt
References: <20201106060414.edtcb7nrbzm4a32t@shindev.dhcp.fujisawa.hgst.com>
 <20201111170536.arx2zbn4ngvjoov7@treble>
 <20201111174736.GH2628@hirez.programming.kicks-ass.net>
 <20201111181328.mbxcz2uap2vnqpxq@treble>
 <33843b7f-ed8a-8fcb-19bc-c76cf00f453d@citrix.com>
 <20201111194206.GK2628@hirez.programming.kicks-ass.net>
 <20201111195900.2x7kfce2ejkmrzi3@treble>
 <20201111200730.GM2628@hirez.programming.kicks-ass.net>
 <20201111201506.bftpmx4svxn376tn@treble>
 <61b2538f-7be6-8f4a-9395-03071b5cc6f0@citrix.com>
 <CALCETrXcTKB_j9MQC1mcZobKGt_cZ5ivDPjU3zwRBmj7DAUCsA@mail.gmail.com>
In-Reply-To: <CALCETrXcTKB_j9MQC1mcZobKGt_cZ5ivDPjU3zwRBmj7DAUCsA@mail.gmail.com>

--DUaNUmdrYAdILv9pSztnaMktaQ8psDwLA
Content-Type: multipart/mixed;
 boundary="------------1B0D2AFE9B07F9B495B0378F"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------1B0D2AFE9B07F9B495B0378F
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable

On 13.11.20 18:34, Andy Lutomirski wrote:
> On Wed, Nov 11, 2020 at 12:25 PM Andrew Cooper
> <andrew.cooper3@citrix.com> wrote:
>>
>> On 11/11/2020 20:15, Josh Poimboeuf wrote:
>>> On Wed, Nov 11, 2020 at 09:07:30PM +0100, Peter Zijlstra wrote:
>>>> On Wed, Nov 11, 2020 at 01:59:00PM -0600, Josh Poimboeuf wrote:
>>>>> On Wed, Nov 11, 2020 at 08:42:06PM +0100, Peter Zijlstra wrote:
>>>>>>> Would objtool have an easier time coping if this were implemented=
 in
>>>>>>> terms of a static call?
>>>>>> I doubt it, the big problem is that there is no visibility into th=
e
>>>>>> actual alternative text. Runtime patching fragments into static ca=
ll
>>>>>> would have the exact same problem.
>>>>>>
>>>>>> Something that _might_ maybe work is trying to morph the immediate=

>>>>>> fragments into an alternative. That is, instead of this:
>>>>>>
>>>>>> static inline notrace unsigned long arch_local_save_flags(void)
>>>>>> {
>>>>>>     return PVOP_CALLEE0(unsigned long, irq.save_fl);
>>>>>> }
>>>>>>
>>>>>> Write it something like:
>>>>>>
>>>>>> static inline notrace unsigned long arch_local_save_flags(void)
>>>>>> {
>>>>>>     PVOP_CALL_ARGS;
>>>>>>     PVOP_TEST_NULL(irq.save_fl);
>>>>>>     asm_inline volatile(ALTERNATIVE(paravirt_alt(PARAVIRT_CALL),
>>>>>>                                     "PUSHF; POP _ASM_AX",
>>>>>>                                     X86_FEATURE_NATIVE)
>>>>>>                         : CLBR_RET_REG, ASM_CALL_CONSTRAINT
>>>>>>                         : paravirt_type(irq.save_fl.func),
>>>>>>                           paravirt_clobber(PVOP_CALLEE_CLOBBERS)
>>>>>>                         : "memory", "cc");
>>>>>>     return __eax;
>>>>>> }
>>>>>>
>>>>>> And then we have to teach objtool how to deal with conflicting
>>>>>> alternatives...
>>>>>>
>>>>>> That would remove most (all, if we can figure out a form that deal=
s with
>>>>>> the spinlock fragments) of paravirt_patch.c
>>>>>>
>>>>>> Hmm?
>>>>> I was going to suggest something similar.  Though I would try to ta=
ke it
>>>>> further and replace paravirt_patch_default() with static calls.
>>>> Possible, we just need to be _really_ careful to not allow changing
>>>> those static_call()s. So maybe we need DEFINE_STATIC_CALL_RO() which=

>>>> does a __ro_after_init on the whole thing.
>>> But what if you want to live migrate to another hypervisor ;-)
>>
>> The same as what happens currently.  The user gets to keep all the
>> resulting pieces ;)
>>
>>>>> Either way it doesn't make objtool's job much easier.  But it would=
 be
>>>>> nice to consolidate runtime patching mechanisms and get rid of
>>>>> .parainstructions.
>>>> I think the above (combining alternative and paravirt/static_call) d=
oes
>>>> make objtool's job easier, since then we at least have the actual
>>>> alternative instructions available to inspect, or am I mis-understan=
ding
>>>> things?
>>> Right, it makes objtool's job a _little_ easier, since it already kno=
ws
>>> how to read alternatives.  But it still has to learn to deal with the=

>>> conflicting stack layouts.
>>
>> I suppose the needed abstraction is "these blocks will start and end
>> with the same stack layout", while allowing the internals to diverge.
>>
>=20
> How much of this stuff is actually useful anymore?  I'm wondering if
> we can move most or all of this crud to
> cpu_feature_enabled(X86_FEATURE_XENPV) and its asm equivalent.  The
> full list, annotated, appears to be:
>=20
>          const unsigned char     irq_irq_disable[1];
>=20
> This is CLI or CALL, right?

Yes.

>=20
>          const unsigned char     irq_irq_enable[1];
>=20
> STI or CALL.

Yes.

>=20
>          const unsigned char     irq_save_fl[2];
>=20
> PUSHF; POP %r/eax.  I *think* I read the paravirt mess correctly and
> this also turns into CALL.

It does.

>=20
>          const unsigned char     mmu_read_cr2[3];
>          const unsigned char     mmu_read_cr3[3];
>          const unsigned char     mmu_write_cr3[3];
>=20
> The write CR3 is so slow that I can't imagine us caring.  Reading CR3
> should already be fairly optimized because it's slow on old non-PV
> hypervisors, too.  Reading CR2 is rare and lives in asm.  These also
> appear to just switch between MOV and CALL, anyway.

Correct.

>=20
>          const unsigned char     irq_restore_fl[2];
>=20
> Ugh, this one sucks.  IMO it should be, for native and PV:
>=20
> if (flags & X86_EFLAGS_IF) {
>    local_irq_enable();  /* or raw? */
> } else {
>    if (some debugging option) {
>      WARN_ON_ONCE(save_fl() & X86_EFLAGS_IF);
>    }
> }

Seems sensible.

>=20
> POPF is slooooow.
>=20
>          const unsigned char     cpu_wbinvd[2];
>=20
> This is hilariously slow no matter what.  static_call() or even just a
> plain old indirect call should be fine.

I'd go with the static_call().

>=20
>          const unsigned char     cpu_usergs_sysret64[6];
>=20
> This is in the asm and we shouldn't be doing it at all for Xen PV.
> IOW we should just drop this patch site entirely.  I can possibly find
> some time to get rid of it, and maybe someone from Xen land can help.
> I bet that we can gain a lot of perf on Xen PV by cleaning this up,
> and I bet it will simplify everything.
>=20
>          const unsigned char     cpu_swapgs[3];
>=20
> This is SWAPGS or nop, unless I've missed some subtlety.
>=20
>          const unsigned char     mov64[3];
>=20
> This is some PTE magic, and I haven't deciphered it yet.

Either a mov or a call.

>=20
> So I think there is at most one of these that wants anything more
> complicated than a plain ALTERNATIVE.  Any volunteers to make it so?
> Juergen, if you do all of them except USERGS_SYSRET64, I hereby
> volunteer to do that one.

Why is a plain alternative (either swapgs; sysretq or a jmp xen_sysret64
depending on X86_FEATURE_XENPV) no option?

Its not as if this code would run before alternative patching.

>=20
> BTW, if y'all want to live migrate between Xen PV and anything else,
> you are nuts.
>=20

That's no option. Xen PV is a guest property, not one of the hypervisor.


Juergen

--------------1B0D2AFE9B07F9B495B0378F
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

--------------1B0D2AFE9B07F9B495B0378F--

--DUaNUmdrYAdILv9pSztnaMktaQ8psDwLA--

--YlSgQPm0iu0oMEDpYLSEgpaD9DFFB534r
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAl+voGIFAwAAAAAACgkQsN6d1ii/Ey+e
RAf9F/C1+vutADibMemPe4bQ73rHcFQhHSwSZehrrBCMavDITUEhZvoOArZblI0WDypEYROlLlQB
oigo7DwxMnYuMsLvZlRVvQnpOk9XBETpv7ovrjopim60uWuBsRdD2V3ZMfYrTzjuaMZ1MOmeGh4t
ApZCM3Rd/gy23PRoW5fJkSAYM/vLG2FSbws99fnkjc6GJoH41jVbh6vx0AoT7DV8KIG9M+RneV1a
MYNalqfWnNDNPSr6DcHV1CjetAmntQhvAQtfLwF86timJ/BzCPwA7TBSzy5YYiE503mReCd0B6TL
/6icY4eBoCZTPgQhGBVtu91r7ltepPbEs81yDgbbDQ==
=CDEy
-----END PGP SIGNATURE-----

--YlSgQPm0iu0oMEDpYLSEgpaD9DFFB534r--
