Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F0F42B828B
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 18:03:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727862AbgKRRCu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 12:02:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:42106 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727207AbgKRRCt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 12:02:49 -0500
Received: from trantor (unknown [2.26.170.190])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 846B42487D;
        Wed, 18 Nov 2020 17:02:44 +0000 (UTC)
Date:   Wed, 18 Nov 2020 17:02:41 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Steven Price <steven.price@arm.com>
Cc:     Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Dave Martin <Dave.Martin@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>, qemu-devel@nongnu.org,
        Juan Quintela <quintela@redhat.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        Peter Maydell <peter.maydell@linaro.org>,
        Haibo Xu <Haibo.Xu@arm.com>, Andrew Jones <drjones@redhat.com>
Subject: Re: [PATCH v4 1/2] arm64: kvm: Save/restore MTE registers
Message-ID: <X7VTsaO/7+Izqm8/@trantor>
References: <20201026155727.36685-1-steven.price@arm.com>
 <20201026155727.36685-2-steven.price@arm.com>
 <b8f2fe15e0cab5c24094915b8c000930@kernel.org>
 <98eaa539-0ae8-ce4c-8886-3040542ede80@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <98eaa539-0ae8-ce4c-8886-3040542ede80@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 18, 2020 at 04:01:18PM +0000, Steven Price wrote:
> On 17/11/2020 19:20, Marc Zyngier wrote:
> > On 2020-10-26 15:57, Steven Price wrote:
> > > diff --git a/arch/arm64/include/asm/sysreg.h
> > > b/arch/arm64/include/asm/sysreg.h
> > > index d52c1b3ce589..7727df0bc09d 100644
> > > --- a/arch/arm64/include/asm/sysreg.h
> > > +++ b/arch/arm64/include/asm/sysreg.h
> > > @@ -565,7 +565,8 @@
> > >  #define SCTLR_ELx_M    (BIT(0))
> > > 
> > >  #define SCTLR_ELx_FLAGS    (SCTLR_ELx_M  | SCTLR_ELx_A | SCTLR_ELx_C | \
> > > -             SCTLR_ELx_SA | SCTLR_ELx_I | SCTLR_ELx_IESB)
> > > +             SCTLR_ELx_SA | SCTLR_ELx_I | SCTLR_ELx_IESB | \
> > > +             SCTLR_ELx_ITFSB)
> > > 
> > >  /* SCTLR_EL2 specific flags. */
> > >  #define SCTLR_EL2_RES1    ((BIT(4))  | (BIT(5))  | (BIT(11)) |
> > > (BIT(16)) | \
> > > diff --git a/arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h
> > > b/arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h
> > > index 7a986030145f..a124ffa49ba3 100644
> > > --- a/arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h
> > > +++ b/arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h
> > > @@ -18,6 +18,11 @@
> > >  static inline void __sysreg_save_common_state(struct
> > > kvm_cpu_context *ctxt)
> > >  {
> > >      ctxt_sys_reg(ctxt, MDSCR_EL1)    = read_sysreg(mdscr_el1);
> > > +    if (system_supports_mte()) {
> > > +        ctxt_sys_reg(ctxt, RGSR_EL1)    = read_sysreg_s(SYS_RGSR_EL1);
> > > +        ctxt_sys_reg(ctxt, GCR_EL1)    = read_sysreg_s(SYS_GCR_EL1);
> > > +        ctxt_sys_reg(ctxt, TFSRE0_EL1)    =
> > > read_sysreg_s(SYS_TFSRE0_EL1);
> > 
> > As far as I can tell, HCR_EL2.ATA is still clear when running a guest.
> > So why, do we save/restore this state yet?
> > 
> > Also, I wonder whether we should keep these in the C code. If one day
> > we enable MTE in the kernel, we will have to move them to the assembly
> > part, much like we do for PAuth. And I fear that "one day" is pretty
> > soon:
> > 
> > https://lore.kernel.org/linux-arm-kernel/cover.1605046192.git.andreyknvl@google.com/
> 
> Good point. Although for MTE we do have the option of setting TCO in PSTATE
> so this could remain in C if we're not bothered about the 'gap' in KASAN
> coverage. I haven't yet got my head around how (or indeed if) that series
> handles guests.

I think we should be fine with the currently proposed in-kernel MTE
support. However, setting GCR_EL1 can get in the way if stack tagging is
ever enabled (it breaks single image). The compiler uses GCR_EL1 to
generate different colours for variables on the stack and changing it in
the middle of a function may cause confusion. You'd have to set
PSTATE.TCO for the whole function, either from the caller or, if the
compiler gets smarter, some function attribute.

-- 
Catalin
