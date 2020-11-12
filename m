Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEDFA2B07AD
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 15:40:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728463AbgKLOki (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 09:40:38 -0500
Received: from foss.arm.com ([217.140.110.172]:52086 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727035AbgKLOki (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 09:40:38 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7CA7D139F;
        Thu, 12 Nov 2020 06:40:37 -0800 (PST)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AFA203F6CF;
        Thu, 12 Nov 2020 06:40:36 -0800 (PST)
Date:   Thu, 12 Nov 2020 14:40:31 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        LAKML <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 2/2] irqchip/gic-v3-its: Disable vSGI upon (CPUIF < v4.1)
 detection
Message-ID: <20201112144031.GA24454@e121166-lin.cambridge.arm.com>
References: <20201111162841.3151-1-lorenzo.pieralisi@arm.com>
 <20201111162841.3151-3-lorenzo.pieralisi@arm.com>
 <ebaa2698ac2bbb90ab46f18221617c43@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ebaa2698ac2bbb90ab46f18221617c43@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 12, 2020 at 09:36:10AM +0000, Marc Zyngier wrote:
> Hi Lorenzo,
> 
> On 2020-11-11 16:28, Lorenzo Pieralisi wrote:
> > GIC CPU interfaces versions predating GIC v4.1 were not built to
> > accommodate vINTID within the vSGI range; as reported in the GIC
> > specifications (8.2 "Changes to the CPU interface"), it is
> > CONSTRAINED UNPREDICTABLE to deliver a vSGI to a PE with
> > ID_AA64PFR0_EL1.GIC == b0001.
> 
> Hmmm. This goes against the very reason v4.1 was designed the way
> it is, which was that all existing implementation supporting GICv4.0
> would seamlessly let virtual SGIs in, and it would "just work".
> 
> If we start enforcing this, I question the very design of the architecture,
> because we could have done so much better by changing the CPU interface.
> 
> What has changed in two years? Have you spotted a fundamental problem?

Hi Marc,

long story short: there are systems being designed with this
configuration, vSGIs may or may not work on them, to prevent
*potential* misbehaviour I am disabling vSGIs, I am not fixing
anything, it is belt and braces.

> My concern is that if we prevent it, we're going to end-up with quirks
> allowing it anyway, because people will realise that it actually works.

We may wait and fix it *if* this breaks, I would argue though that at
that point it is not a quirk since architecturally we know that vSGIs
may not work in this configuration.

> In the meantime, to the meat of the change:
> 
> > 
> > Check the GIC CPUIF version through the arm64 capabilities
> > infrastructure and disable vSGIs if a CPUIF version < 4.1 is
> > detected to prevent using vSGIs on systems where they may
> > misbehave.
> > 
> > Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > Cc: Marc Zyngier <maz@kernel.org>
> > ---
> >  drivers/irqchip/irq-gic-v3-its.c | 20 +++++++++++++++++++-
> >  1 file changed, 19 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/irqchip/irq-gic-v3-its.c
> > b/drivers/irqchip/irq-gic-v3-its.c
> > index 0fec31931e11..6ed4ba60ba7e 100644
> > --- a/drivers/irqchip/irq-gic-v3-its.c
> > +++ b/drivers/irqchip/irq-gic-v3-its.c
> > @@ -39,6 +39,20 @@
> > 
> >  #include "irq-gic-common.h"
> > 
> > +#ifdef CONFIG_ARM64
> > +#include <asm/cpufeature.h>
> > +
> > +static inline bool gic_cpuif_has_vsgi(void)
> > +{
> > +	return cpus_have_const_cap(ARM64_HAS_GIC_CPUIF_VSGI);
> > +}
> > +#else
> > +static inline bool gic_cpuif_has_vsgi(void)
> > +{
> > +	return false;
> > +}
> > +#endif
> > +
> >  #define ITS_FLAGS_CMDQ_NEEDS_FLUSHING		(1ULL << 0)
> >  #define ITS_FLAGS_WORKAROUND_CAVIUM_22375	(1ULL << 1)
> >  #define ITS_FLAGS_WORKAROUND_CAVIUM_23144	(1ULL << 2)
> > @@ -5415,7 +5429,11 @@ int __init its_init(struct fwnode_handle
> > *handle, struct rdists *rdists,
> >  	if (has_v4 & rdists->has_vlpis) {
> >  		const struct irq_domain_ops *sgi_ops;
> > 
> > -		if (has_v4_1)
> > +		/*
> > +		 * Enable vSGIs only if the ITS and the
> > +		 * GIC CPUIF support them.
> > +		 */
> > +		if (has_v4_1 && gic_cpuif_has_vsgi())
> >  			sgi_ops = &its_sgi_domain_ops;
> >  		else
> >  			sgi_ops = NULL;
> 
> Is that enough?

No, I obviously missed the VGIC bits built on top of
GICD_TYPER2.nASSGIcap.

> KVM is still going to expose GICD_TYPER2.nASSGIcap, making things even
> more confusing for the guest: it will be able to select active-less SGIs
> via GICD_CTLR.nASSGIreq, and if I'm not mistaken, we'd still try to switch
> to HW-backed SGIs, leading to some *very* unpleasant things in
> gic_v4_enable_vsgis().

Yes (AFAICS GICD_TYPER2.nASSGIcap is not in the public specs though,
that's why I missed it while vetting architectural state that is
affecting vSGIs).

I should change the logic in vgic_mmio_{uaccess}_write_v3_misc() to
handle it properly - to redefine the logic around

kvm_vgic_global_state.has_gicv4_1

somehow.

Thanks for the review.

Lorenzo
