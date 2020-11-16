Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEE382B445F
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 14:06:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728352AbgKPNEY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 08:04:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728150AbgKPNEX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 08:04:23 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADC57C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 05:04:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=y2+fePX5s1q400ecLa/bc0q1bI+HAKuYouqlzj1WmqA=; b=L2N7MUiqrObpZu6hdCCzthzLag
        NOfFaoANDLtYiv6dHoIf8M/O/zxRbZMnhWv6NuKU6WMjccjkipv1ipajCK661hNcMW/V/jGI8/nwN
        D2nvtFkad8RTwqOtCNFhJOiJAGigYHC1nku2PBlvN3VVn6opUttXHSuNgCpy+FLRFWtOucaeHEBRB
        /MeiK5AXddM8n1CCLumoStPQbKshh65Tc1fkgL2qmLVJAwzVnP9hGPO4PUVIsva4w9ju3SxAqttUU
        IoqbPqYAsq1c3C/ms+iJeriMmxeddZ2egLPhxLZEaE4fFNa5Y1cr67z2bOAIUA9AA8P8vDD0VUmxJ
        HvqRdmUw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1keeB4-0005Cg-2j; Mon, 16 Nov 2020 13:04:14 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7727A3012C3;
        Mon, 16 Nov 2020 14:04:13 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5382720282DFC; Mon, 16 Nov 2020 14:04:13 +0100 (CET)
Date:   Mon, 16 Nov 2020 14:04:13 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     =?iso-8859-1?Q?J=FCrgen_Gro=DF?= <jgross@suse.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        X86 ML <x86@kernel.org>
Subject: Re: WARNING: can't access registers at asm_common_interrupt
Message-ID: <20201116130413.GC3121392@hirez.programming.kicks-ass.net>
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
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6c2NcOVqGQ03X4Wi"
Content-Disposition: inline
In-Reply-To: <f105a63d-6b51-3afb-83e0-e899ea40813e@suse.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6c2NcOVqGQ03X4Wi
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 16, 2020 at 12:56:32PM +0100, J=FCrgen Gro=DF wrote:
> > > > > > > static inline notrace unsigned long arch_local_save_flags(voi=
d)
> > > > > > > {
> > > > > > >     PVOP_CALL_ARGS;
> > > > > > >     PVOP_TEST_NULL(irq.save_fl);
> > > > > > >     asm_inline volatile(ALTERNATIVE(paravirt_alt(PARAVIRT_CAL=
L),
> > > > > > >                                     "PUSHF; POP _ASM_AX",
> > > > > > >                                     X86_FEATURE_NATIVE)
>=20
> I am wondering whether we really want a new feature (basically "not
> XENPV). We could use ~X86_FEATURE_XENPV and teach apply_alternatives()
> to understand negated features (yes, this limits the number of features
> to 32767, but I don't think this is a real problem for quite some time).
>=20
> Thoughts?

I went with the simple thing for now... If we ever want/need another
negative alternative I suppose we can do as you suggest...

I was still poking at objtool to actually dtrt though..

---
diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpuf=
eatures.h
index dad350d42ecf..cc88f358bac5 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -237,6 +237,7 @@
 #define X86_FEATURE_VMCALL		( 8*32+18) /* "" Hypervisor supports the VMCAL=
L instruction */
 #define X86_FEATURE_VMW_VMMCALL		( 8*32+19) /* "" VMware prefers VMMCALL h=
ypercall instruction */
 #define X86_FEATURE_SEV_ES		( 8*32+20) /* AMD Secure Encrypted Virtualizat=
ion - Encrypted State */
+#define X86_FEATURE_NOT_XENPV		( 8*32+21) /* "" inverse of X86_FEATURE_XEN=
PV */
=20
 /* Intel-defined CPU features, CPUID level 0x00000007:0 (EBX), word 9 */
 #define X86_FEATURE_FSGSBASE		( 9*32+ 0) /* RDFSBASE, WRFSBASE, RDGSBASE, =
WRGSBASE instructions*/
diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravir=
t.h
index d25cc6830e89..e2a9d3e6b7ad 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -645,22 +645,56 @@ bool __raw_callee_save___native_vcpu_is_preempted(lon=
g cpu);
 #ifdef CONFIG_PARAVIRT_XXL
 static inline notrace unsigned long arch_local_save_flags(void)
 {
-	return PVOP_CALLEE0(unsigned long, irq.save_fl);
+	PVOP_CALL_ARGS;
+	PVOP_TEST_NULL(irq.save_fl);
+	asm_inline volatile(ALTERNATIVE(paravirt_alt(PARAVIRT_CALL),
+					"pushf; pop %%" _ASM_AX ";",
+					X86_FEATURE_NOT_XENPV)
+			    : PVOP_CALLEE_CLOBBERS, ASM_CALL_CONSTRAINT
+			    : paravirt_type(irq.save_fl.func),
+			      paravirt_clobber(CLBR_RET_REG)
+			    : "memory", "cc");
+	return __eax;
 }
=20
 static inline notrace void arch_local_irq_restore(unsigned long f)
 {
-	PVOP_VCALLEE1(irq.restore_fl, f);
+	PVOP_CALL_ARGS;
+	PVOP_TEST_NULL(irq.restore_fl);
+	asm_inline volatile(ALTERNATIVE(paravirt_alt(PARAVIRT_CALL),
+					"push %%" _ASM_ARG1 "; popf;",
+					X86_FEATURE_NOT_XENPV)
+			    : PVOP_VCALLEE_CLOBBERS, ASM_CALL_CONSTRAINT
+			    : paravirt_type(irq.restore_fl.func),
+			      paravirt_clobber(CLBR_RET_REG),
+			      PVOP_CALL_ARG1(f)
+			    : "memory", "cc");
 }
=20
 static inline notrace void arch_local_irq_disable(void)
 {
-	PVOP_VCALLEE0(irq.irq_disable);
+	PVOP_CALL_ARGS;
+	PVOP_TEST_NULL(irq.irq_disable);
+	asm_inline volatile(ALTERNATIVE(paravirt_alt(PARAVIRT_CALL),
+					"cli;",
+					X86_FEATURE_NOT_XENPV)
+			    : PVOP_VCALLEE_CLOBBERS, ASM_CALL_CONSTRAINT
+			    : paravirt_type(irq.irq_disable.func),
+			      paravirt_clobber(CLBR_RET_REG)
+			    : "memory", "cc");
 }
=20
 static inline notrace void arch_local_irq_enable(void)
 {
-	PVOP_VCALLEE0(irq.irq_enable);
+	PVOP_CALL_ARGS;
+	PVOP_TEST_NULL(irq.irq_enable);
+	asm_inline volatile(ALTERNATIVE(paravirt_alt(PARAVIRT_CALL),
+					"sti;",
+					X86_FEATURE_NOT_XENPV)
+			    : PVOP_VCALLEE_CLOBBERS, ASM_CALL_CONSTRAINT
+			    : paravirt_type(irq.irq_enable.func),
+			      paravirt_clobber(CLBR_RET_REG)
+			    : "memory", "cc");
 }
=20
 static inline notrace unsigned long arch_local_irq_save(void)
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 2400ad62f330..5bd8f5503652 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -723,6 +723,19 @@ void __init alternative_instructions(void)
 	 * patching.
 	 */
=20
+	if (!boot_cpu_has(X86_FEATURE_XENPV))
+		setup_force_cpu_cap(X86_FEATURE_NOT_XENPV);
+
+	/*
+	 * First patch paravirt functions, such that we overwrite the indirect
+	 * call with the direct call.
+	 */
+	apply_paravirt(__parainstructions, __parainstructions_end);
+
+	/*
+	 * Then patch alternatives, such that those paravirt calls that are in
+	 * alternatives can be overwritten by their immediate fragments.
+	 */
 	apply_alternatives(__alt_instructions, __alt_instructions_end);
=20
 #ifdef CONFIG_SMP
@@ -741,8 +754,6 @@ void __init alternative_instructions(void)
 	}
 #endif
=20
-	apply_paravirt(__parainstructions, __parainstructions_end);
-
 	restart_nmi();
 	alternatives_patched =3D 1;
 }
diff --git a/arch/x86/kernel/paravirt_patch.c b/arch/x86/kernel/paravirt_pa=
tch.c
index ace6e334cb39..867498db53ad 100644
--- a/arch/x86/kernel/paravirt_patch.c
+++ b/arch/x86/kernel/paravirt_patch.c
@@ -33,13 +33,9 @@ struct patch_xxl {
 };
=20
 static const struct patch_xxl patch_data_xxl =3D {
-	.irq_irq_disable	=3D { 0xfa },		// cli
-	.irq_irq_enable		=3D { 0xfb },		// sti
-	.irq_save_fl		=3D { 0x9c, 0x58 },	// pushf; pop %[re]ax
 	.mmu_read_cr2		=3D { 0x0f, 0x20, 0xd0 },	// mov %cr2, %[re]ax
 	.mmu_read_cr3		=3D { 0x0f, 0x20, 0xd8 },	// mov %cr3, %[re]ax
 	.mmu_write_cr3		=3D { 0x0f, 0x22, 0xdf },	// mov %rdi, %cr3
-	.irq_restore_fl		=3D { 0x57, 0x9d },	// push %rdi; popfq
 	.cpu_wbinvd		=3D { 0x0f, 0x09 },	// wbinvd
 	.cpu_usergs_sysret64	=3D { 0x0f, 0x01, 0xf8,
 				    0x48, 0x0f, 0x07 },	// swapgs; sysretq
@@ -76,11 +72,6 @@ unsigned int native_patch(u8 type, void *insn_buff, unsi=
gned long addr,
 	switch (type) {
=20
 #ifdef CONFIG_PARAVIRT_XXL
-	PATCH_CASE(irq, restore_fl, xxl, insn_buff, len);
-	PATCH_CASE(irq, save_fl, xxl, insn_buff, len);
-	PATCH_CASE(irq, irq_enable, xxl, insn_buff, len);
-	PATCH_CASE(irq, irq_disable, xxl, insn_buff, len);
-
 	PATCH_CASE(mmu, read_cr2, xxl, insn_buff, len);
 	PATCH_CASE(mmu, read_cr3, xxl, insn_buff, len);
 	PATCH_CASE(mmu, write_cr3, xxl, insn_buff, len);

--6c2NcOVqGQ03X4Wi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEv3OU3/byMaA0LqWJdkfhpEvA5LoFAl+yeM0ACgkQdkfhpEvA
5LoVvA/8COySXr0EN+4h9VezrN3m/QpzN5gFUhdh7hIC5xQ36QrCrihUVUFf5RWa
OC3HcgoTXfU0zyClCbA/VKty9HQ5srqr0ASnxvISc+xZe+1flvkBGlF60jQf3qOA
AAwCEUFFXLt8UYZfYQp+/p5FjyuCyaJspFM2OqYKWy3ZUmLc4VP0rPI6/wndEO8r
Hw2WSct4uHVQd7CWx636mWkK4sJls9SC68Ql3zPAFKpj4t+bXyGKQSExabZyMTY8
NuuVTAHaRVCad8/IElVekt/8/K6muu/CH9keeUygqEl4OdbF5Fe0Dcvk2QI8m8XE
B4XcNmEzcF2f4J7BtLfmNiGU4Yfiom6ekQZ89KWq3t+c0atlzIrjwSwCZQAt7H9M
LTKbVuMEeIBKGt30nrivDOIJ9BOnud+HSsWA1Cl8dUuQPeqG3+ZFvfjnnStUfXiv
GPqqBmIpPvlhpJvqKnf8gyMcJaYfl6vx78KquZYiFzrhdWQNforxeQxL9EfBRwbP
l15ohEelXl2vd7+TU5A+HYs8YTR/fjBBj3AHVlLDAEDYzLhK55AdtTXbNvKZ0jH7
+KP67RyS+SJ8B/UrqJWq+ekupkS+mzRM/hPogP32uXziHYw8n4WDh9/ZqXitnBR8
uuYmr3lPGfNOJCsbfZvHbFKoPm5kjjVls/CuKVHk6pQkNtUKAl0=
=dfCz
-----END PGP SIGNATURE-----

--6c2NcOVqGQ03X4Wi--
