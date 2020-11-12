Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FF0C2B07E3
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 15:55:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728579AbgKLOzS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 09:55:18 -0500
Received: from foss.arm.com ([217.140.110.172]:52346 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728467AbgKLOzS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 09:55:18 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A0C96139F;
        Thu, 12 Nov 2020 06:55:17 -0800 (PST)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D5C643F73C;
        Thu, 12 Nov 2020 06:55:16 -0800 (PST)
Date:   Thu, 12 Nov 2020 14:55:14 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        LAKML <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 1/2] arm64: cpufeature: Add GIC CPUIF v4.1 detection
Message-ID: <20201112145514.GB24454@e121166-lin.cambridge.arm.com>
References: <20201111162841.3151-1-lorenzo.pieralisi@arm.com>
 <20201111162841.3151-2-lorenzo.pieralisi@arm.com>
 <89291c496e6e868c442f5763db53d22d@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <89291c496e6e868c442f5763db53d22d@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 12, 2020 at 11:20:08AM +0000, Marc Zyngier wrote:
> On 2020-11-11 16:28, Lorenzo Pieralisi wrote:
> > GIC v4.1 introduced changes to the GIC CPU interface; systems that
> > integrate CPUs that do not support GIC v4.1 features (as reported in
> > the
> > ID_AA64PFR0_EL1.GIC bitfield) and a GIC v4.1 controller must disable in
> > software virtual SGIs support since the CPUIF and GIC controller
> > version
> > mismatch results in CONSTRAINED UNPREDICTABLE behaviour at
> > architectural
> > level.
> > 
> > Add a cpufeature and related capability to detect GIC v4.1 CPUIF
> > features so that the GIC driver can probe it to detect GIC CPUIF
> > hardware configuration and take action accordingly.
> > 
> > Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > Cc: Will Deacon <will@kernel.org>
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Marc Zyngier <maz@kernel.org>
> > ---
> >  arch/arm64/include/asm/cpucaps.h |  3 ++-
> >  arch/arm64/kernel/cpufeature.c   | 10 ++++++++++
> >  2 files changed, 12 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm64/include/asm/cpucaps.h
> > b/arch/arm64/include/asm/cpucaps.h
> > index 42868dbd29fd..35ef0319f422 100644
> > --- a/arch/arm64/include/asm/cpucaps.h
> > +++ b/arch/arm64/include/asm/cpucaps.h
> > @@ -65,7 +65,8 @@
> >  #define ARM64_HAS_ARMv8_4_TTL			55
> >  #define ARM64_HAS_TLB_RANGE			56
> >  #define ARM64_MTE				57
> > +#define ARM64_HAS_GIC_CPUIF_VSGI		58
> > 
> > -#define ARM64_NCAPS				58
> > +#define ARM64_NCAPS				59
> > 
> >  #endif /* __ASM_CPUCAPS_H */
> > diff --git a/arch/arm64/kernel/cpufeature.c
> > b/arch/arm64/kernel/cpufeature.c
> > index dcc165b3fc04..9eabbaddfe5e 100644
> > --- a/arch/arm64/kernel/cpufeature.c
> > +++ b/arch/arm64/kernel/cpufeature.c
> > @@ -2136,6 +2136,16 @@ static const struct arm64_cpu_capabilities
> > arm64_features[] = {
> >  		.cpu_enable = cpu_enable_mte,
> >  	},
> >  #endif /* CONFIG_ARM64_MTE */
> > +	{
> > +		.desc = "GIC CPUIF virtual SGI",
> 
> nit: that's not really what this feature is. It only means that the
> sysreg interface complies to v4.1. Which on its own is totally rubbish,
> because the sysreg don't change behaviour between 3.0/4.0 and 4.1.

True.

> > +		.capability = ARM64_HAS_GIC_CPUIF_VSGI,
> > +		.type = ARM64_CPUCAP_BOOT_CPU_FEATURE,
> > +		.matches = has_cpuid_feature,
> > +		.sys_reg = SYS_ID_AA64PFR0_EL1,
> > +		.field_pos = ID_AA64PFR0_GIC_SHIFT,
> > +		.sign = FTR_UNSIGNED,
> > +		.min_field_value = 3,
> > +	},
> 
> Do we really need a new cap for that? Or can we rely on simply looking
> at the sanitised feature set? I'm not overly keen on advertising a
> feature
> at CPU boot time if we discover later on that we cannot use it because
> all
> we have in a non-4.1 GIC.

Yes I thought about that, posted exactly to get this feedback.

You have a point. It is also wrong to force secondaries to die if
they mismatch with the boot CPU without knowing what *actual* GIC
controller we have in the system.

> Another thing is that we currently assume that *all* CPUs will be the
> same
> at the point where we setup the GIC (we only have a single CPU booted at
> that
> point).

Yes - we would taint (?) if that's not the case right ? So using a
sanitised feature looks sane to me, certainly saner than using a new
cap and I think that's all we can and should do.

Thanks,
Lorenzo
