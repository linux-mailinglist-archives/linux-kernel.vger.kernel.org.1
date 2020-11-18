Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB0CA2B767B
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 07:50:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726533AbgKRGrl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 01:47:41 -0500
Received: from mx2.suse.de ([195.135.220.15]:43082 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725794AbgKRGrk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 01:47:40 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1605682058; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vXmb6ImY1e7MmFUdXEFYeKg82TCxxkRv6KvUUeq00rs=;
        b=faLONW1JIciNkI2EvBmOAzCZBdxXyw3KBV/TADyaFI672wm2xLk1dVFenBMufvLNWUMk8g
        Dc/+mN5G14O9+rrVeK0R4xA8OPf9ql0pwMIdShOPMd3AlwiVUUf56nwmNRlFnhmHSTv0OB
        DHu/wKpKjj+kRy6x87O3DvtLr48O+QU=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 04D4AAC1F;
        Wed, 18 Nov 2020 06:47:38 +0000 (UTC)
Subject: Re: WARNING: can't access registers at asm_common_interrupt
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        X86 ML <x86@kernel.org>
References: <20201111174736.GH2628@hirez.programming.kicks-ass.net>
 <20201111181328.mbxcz2uap2vnqpxq@treble>
 <33843b7f-ed8a-8fcb-19bc-c76cf00f453d@citrix.com>
 <20201111194206.GK2628@hirez.programming.kicks-ass.net>
 <20201111195900.2x7kfce2ejkmrzi3@treble>
 <20201111200730.GM2628@hirez.programming.kicks-ass.net>
 <20201111201506.bftpmx4svxn376tn@treble>
 <61b2538f-7be6-8f4a-9395-03071b5cc6f0@citrix.com>
 <CALCETrXcTKB_j9MQC1mcZobKGt_cZ5ivDPjU3zwRBmj7DAUCsA@mail.gmail.com>
 <f105a63d-6b51-3afb-83e0-e899ea40813e@suse.com>
 <20201116130413.GC3121392@hirez.programming.kicks-ass.net>
From:   =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Message-ID: <e1ca6c8c-e32d-879a-1972-5605f0892176@suse.com>
Date:   Wed, 18 Nov 2020 07:47:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201116130413.GC3121392@hirez.programming.kicks-ass.net>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="g4vDDDtQo3MpkrUJ4vCmdo74yr0iRqQ9A"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--g4vDDDtQo3MpkrUJ4vCmdo74yr0iRqQ9A
Content-Type: multipart/mixed; boundary="uOtI8IPVW1vmmiZwKeI0oNxGQZE2E9Isp";
 protected-headers="v1"
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Andy Lutomirski <luto@kernel.org>,
 Andrew Cooper <andrew.cooper3@citrix.com>,
 Josh Poimboeuf <jpoimboe@redhat.com>,
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Nicholas Piggin <npiggin@gmail.com>, Damien Le Moal <Damien.LeMoal@wdc.com>,
 X86 ML <x86@kernel.org>
Message-ID: <e1ca6c8c-e32d-879a-1972-5605f0892176@suse.com>
Subject: Re: WARNING: can't access registers at asm_common_interrupt
References: <20201111174736.GH2628@hirez.programming.kicks-ass.net>
 <20201111181328.mbxcz2uap2vnqpxq@treble>
 <33843b7f-ed8a-8fcb-19bc-c76cf00f453d@citrix.com>
 <20201111194206.GK2628@hirez.programming.kicks-ass.net>
 <20201111195900.2x7kfce2ejkmrzi3@treble>
 <20201111200730.GM2628@hirez.programming.kicks-ass.net>
 <20201111201506.bftpmx4svxn376tn@treble>
 <61b2538f-7be6-8f4a-9395-03071b5cc6f0@citrix.com>
 <CALCETrXcTKB_j9MQC1mcZobKGt_cZ5ivDPjU3zwRBmj7DAUCsA@mail.gmail.com>
 <f105a63d-6b51-3afb-83e0-e899ea40813e@suse.com>
 <20201116130413.GC3121392@hirez.programming.kicks-ass.net>
In-Reply-To: <20201116130413.GC3121392@hirez.programming.kicks-ass.net>

--uOtI8IPVW1vmmiZwKeI0oNxGQZE2E9Isp
Content-Type: multipart/mixed;
 boundary="------------F0575B0C7143D60C1740F74E"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------F0575B0C7143D60C1740F74E
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: quoted-printable

On 16.11.20 14:04, Peter Zijlstra wrote:
> On Mon, Nov 16, 2020 at 12:56:32PM +0100, J=FCrgen Gro=DF wrote:
>>>>>>>> static inline notrace unsigned long arch_local_save_flags(void)
>>>>>>>> {
>>>>>>>>      PVOP_CALL_ARGS;
>>>>>>>>      PVOP_TEST_NULL(irq.save_fl);
>>>>>>>>      asm_inline volatile(ALTERNATIVE(paravirt_alt(PARAVIRT_CALL)=
,
>>>>>>>>                                      "PUSHF; POP _ASM_AX",
>>>>>>>>                                      X86_FEATURE_NATIVE)
>>
>> I am wondering whether we really want a new feature (basically "not
>> XENPV). We could use ~X86_FEATURE_XENPV and teach apply_alternatives()=

>> to understand negated features (yes, this limits the number of feature=
s
>> to 32767, but I don't think this is a real problem for quite some time=
).
>>
>> Thoughts?
>=20
> I went with the simple thing for now... If we ever want/need another
> negative alternative I suppose we can do as you suggest...
>=20
> I was still poking at objtool to actually dtrt though..

I'd like to include this part in my series (with a different solution
for the restore_fl part, as suggested by Andy before).

Peter, are you fine with me taking your patch and adding your SoB?


Juergen

>=20
> ---
> diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/=
cpufeatures.h
> index dad350d42ecf..cc88f358bac5 100644
> --- a/arch/x86/include/asm/cpufeatures.h
> +++ b/arch/x86/include/asm/cpufeatures.h
> @@ -237,6 +237,7 @@
>   #define X86_FEATURE_VMCALL		( 8*32+18) /* "" Hypervisor supports the =
VMCALL instruction */
>   #define X86_FEATURE_VMW_VMMCALL		( 8*32+19) /* "" VMware prefers VMMC=
ALL hypercall instruction */
>   #define X86_FEATURE_SEV_ES		( 8*32+20) /* AMD Secure Encrypted Virtua=
lization - Encrypted State */
> +#define X86_FEATURE_NOT_XENPV		( 8*32+21) /* "" inverse of X86_FEATURE=
_XENPV */
>  =20
>   /* Intel-defined CPU features, CPUID level 0x00000007:0 (EBX), word 9=
 */
>   #define X86_FEATURE_FSGSBASE		( 9*32+ 0) /* RDFSBASE, WRFSBASE, RDGSB=
ASE, WRGSBASE instructions*/
> diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/par=
avirt.h
> index d25cc6830e89..e2a9d3e6b7ad 100644
> --- a/arch/x86/include/asm/paravirt.h
> +++ b/arch/x86/include/asm/paravirt.h
> @@ -645,22 +645,56 @@ bool __raw_callee_save___native_vcpu_is_preempted=
(long cpu);
>   #ifdef CONFIG_PARAVIRT_XXL
>   static inline notrace unsigned long arch_local_save_flags(void)
>   {
> -	return PVOP_CALLEE0(unsigned long, irq.save_fl);
> +	PVOP_CALL_ARGS;
> +	PVOP_TEST_NULL(irq.save_fl);
> +	asm_inline volatile(ALTERNATIVE(paravirt_alt(PARAVIRT_CALL),
> +					"pushf; pop %%" _ASM_AX ";",
> +					X86_FEATURE_NOT_XENPV)
> +			    : PVOP_CALLEE_CLOBBERS, ASM_CALL_CONSTRAINT
> +			    : paravirt_type(irq.save_fl.func),
> +			      paravirt_clobber(CLBR_RET_REG)
> +			    : "memory", "cc");
> +	return __eax;
>   }
>  =20
>   static inline notrace void arch_local_irq_restore(unsigned long f)
>   {
> -	PVOP_VCALLEE1(irq.restore_fl, f);
> +	PVOP_CALL_ARGS;
> +	PVOP_TEST_NULL(irq.restore_fl);
> +	asm_inline volatile(ALTERNATIVE(paravirt_alt(PARAVIRT_CALL),
> +					"push %%" _ASM_ARG1 "; popf;",
> +					X86_FEATURE_NOT_XENPV)
> +			    : PVOP_VCALLEE_CLOBBERS, ASM_CALL_CONSTRAINT
> +			    : paravirt_type(irq.restore_fl.func),
> +			      paravirt_clobber(CLBR_RET_REG),
> +			      PVOP_CALL_ARG1(f)
> +			    : "memory", "cc");
>   }
>  =20
>   static inline notrace void arch_local_irq_disable(void)
>   {
> -	PVOP_VCALLEE0(irq.irq_disable);
> +	PVOP_CALL_ARGS;
> +	PVOP_TEST_NULL(irq.irq_disable);
> +	asm_inline volatile(ALTERNATIVE(paravirt_alt(PARAVIRT_CALL),
> +					"cli;",
> +					X86_FEATURE_NOT_XENPV)
> +			    : PVOP_VCALLEE_CLOBBERS, ASM_CALL_CONSTRAINT
> +			    : paravirt_type(irq.irq_disable.func),
> +			      paravirt_clobber(CLBR_RET_REG)
> +			    : "memory", "cc");
>   }
>  =20
>   static inline notrace void arch_local_irq_enable(void)
>   {
> -	PVOP_VCALLEE0(irq.irq_enable);
> +	PVOP_CALL_ARGS;
> +	PVOP_TEST_NULL(irq.irq_enable);
> +	asm_inline volatile(ALTERNATIVE(paravirt_alt(PARAVIRT_CALL),
> +					"sti;",
> +					X86_FEATURE_NOT_XENPV)
> +			    : PVOP_VCALLEE_CLOBBERS, ASM_CALL_CONSTRAINT
> +			    : paravirt_type(irq.irq_enable.func),
> +			      paravirt_clobber(CLBR_RET_REG)
> +			    : "memory", "cc");
>   }
>  =20
>   static inline notrace unsigned long arch_local_irq_save(void)
> diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternativ=
e.c
> index 2400ad62f330..5bd8f5503652 100644
> --- a/arch/x86/kernel/alternative.c
> +++ b/arch/x86/kernel/alternative.c
> @@ -723,6 +723,19 @@ void __init alternative_instructions(void)
>   	 * patching.
>   	 */
>  =20
> +	if (!boot_cpu_has(X86_FEATURE_XENPV))
> +		setup_force_cpu_cap(X86_FEATURE_NOT_XENPV);
> +
> +	/*
> +	 * First patch paravirt functions, such that we overwrite the indirec=
t
> +	 * call with the direct call.
> +	 */
> +	apply_paravirt(__parainstructions, __parainstructions_end);
> +
> +	/*
> +	 * Then patch alternatives, such that those paravirt calls that are i=
n
> +	 * alternatives can be overwritten by their immediate fragments.
> +	 */
>   	apply_alternatives(__alt_instructions, __alt_instructions_end);
>  =20
>   #ifdef CONFIG_SMP
> @@ -741,8 +754,6 @@ void __init alternative_instructions(void)
>   	}
>   #endif
>  =20
> -	apply_paravirt(__parainstructions, __parainstructions_end);
> -
>   	restart_nmi();
>   	alternatives_patched =3D 1;
>   }
> diff --git a/arch/x86/kernel/paravirt_patch.c b/arch/x86/kernel/paravir=
t_patch.c
> index ace6e334cb39..867498db53ad 100644
> --- a/arch/x86/kernel/paravirt_patch.c
> +++ b/arch/x86/kernel/paravirt_patch.c
> @@ -33,13 +33,9 @@ struct patch_xxl {
>   };
>  =20
>   static const struct patch_xxl patch_data_xxl =3D {
> -	.irq_irq_disable	=3D { 0xfa },		// cli
> -	.irq_irq_enable		=3D { 0xfb },		// sti
> -	.irq_save_fl		=3D { 0x9c, 0x58 },	// pushf; pop %[re]ax
>   	.mmu_read_cr2		=3D { 0x0f, 0x20, 0xd0 },	// mov %cr2, %[re]ax
>   	.mmu_read_cr3		=3D { 0x0f, 0x20, 0xd8 },	// mov %cr3, %[re]ax
>   	.mmu_write_cr3		=3D { 0x0f, 0x22, 0xdf },	// mov %rdi, %cr3
> -	.irq_restore_fl		=3D { 0x57, 0x9d },	// push %rdi; popfq
>   	.cpu_wbinvd		=3D { 0x0f, 0x09 },	// wbinvd
>   	.cpu_usergs_sysret64	=3D { 0x0f, 0x01, 0xf8,
>   				    0x48, 0x0f, 0x07 },	// swapgs; sysretq
> @@ -76,11 +72,6 @@ unsigned int native_patch(u8 type, void *insn_buff, =
unsigned long addr,
>   	switch (type) {
>  =20
>   #ifdef CONFIG_PARAVIRT_XXL
> -	PATCH_CASE(irq, restore_fl, xxl, insn_buff, len);
> -	PATCH_CASE(irq, save_fl, xxl, insn_buff, len);
> -	PATCH_CASE(irq, irq_enable, xxl, insn_buff, len);
> -	PATCH_CASE(irq, irq_disable, xxl, insn_buff, len);
> -
>   	PATCH_CASE(mmu, read_cr2, xxl, insn_buff, len);
>   	PATCH_CASE(mmu, read_cr3, xxl, insn_buff, len);
>   	PATCH_CASE(mmu, write_cr3, xxl, insn_buff, len);
>=20


--------------F0575B0C7143D60C1740F74E
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

--------------F0575B0C7143D60C1740F74E--

--uOtI8IPVW1vmmiZwKeI0oNxGQZE2E9Isp--

--g4vDDDtQo3MpkrUJ4vCmdo74yr0iRqQ9A
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAl+0w4kFAwAAAAAACgkQsN6d1ii/Ey+o
RAf/S5GYUCCTYfZgZnWFJHmx9f+Ry7x1DOsbs0lUAc29kDqLnO3q0yX16YtBbXHFk1Hk347X/QbB
eCMY0e8X4aP5Iz2EZCwp/4Ng8dg5Vj2nPO6FwHletCKxZhRcKGiW9b5O/20OFAidZcFJd3YDn9sE
JdZXWW2t+mK7esNMv/1F2pQbocR5vdrH/DboJppGzpOJkna3LxKdAV0xZwYng9ftCH1Mu/a2zNiZ
5L2piSwrs+hF1dprQp+B8y8oj4GlTBBCDNyPL1KrIt2bOjjyzQYtxTYlCBrhMxbA/gu29yWE/fRf
mTZcd9SMy/4hb8fOO8brf7gMlOW2k/w7r56qMokzpw==
=FSZs
-----END PGP SIGNATURE-----

--g4vDDDtQo3MpkrUJ4vCmdo74yr0iRqQ9A--
