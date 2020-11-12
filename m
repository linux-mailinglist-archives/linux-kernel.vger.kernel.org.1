Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30CF22B0208
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 10:36:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727147AbgKLJgO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 04:36:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:38004 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726776AbgKLJgN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 04:36:13 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E609D21D40;
        Thu, 12 Nov 2020 09:36:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605173773;
        bh=IWrr3gWzH4Y+LNmpog/FIqpytYgijVvbwS9XC3NUZYM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=08bxS8kEId0/cxycTo3GayW37MOv7t1RXFUTmF+5bR3BQHLE4Mhqw0GQ8/pQOtwoW
         ZT16e+GkrJ7CNSk0ARQZKT6r0x468qHx3F6l/T21OGy9G94oX1yVYwwLRkqWnxNXUv
         kwrsf0Aj2XcmASzfyGqyCLJ2b8owiidyDnQWeVeA=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1kd91W-009zpH-Mv; Thu, 12 Nov 2020 09:36:10 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 12 Nov 2020 09:36:10 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        LAKML <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 2/2] irqchip/gic-v3-its: Disable vSGI upon (CPUIF < v4.1)
 detection
In-Reply-To: <20201111162841.3151-3-lorenzo.pieralisi@arm.com>
References: <20201111162841.3151-1-lorenzo.pieralisi@arm.com>
 <20201111162841.3151-3-lorenzo.pieralisi@arm.com>
User-Agent: Roundcube Webmail/1.4.9
Message-ID: <ebaa2698ac2bbb90ab46f18221617c43@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: lorenzo.pieralisi@arm.com, linux-kernel@vger.kernel.org, catalin.marinas@arm.com, will@kernel.org, linux-arm-kernel@lists.infradead.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lorenzo,

On 2020-11-11 16:28, Lorenzo Pieralisi wrote:
> GIC CPU interfaces versions predating GIC v4.1 were not built to
> accommodate vINTID within the vSGI range; as reported in the GIC
> specifications (8.2 "Changes to the CPU interface"), it is
> CONSTRAINED UNPREDICTABLE to deliver a vSGI to a PE with
> ID_AA64PFR0_EL1.GIC == b0001.

Hmmm. This goes against the very reason v4.1 was designed the way
it is, which was that all existing implementation supporting GICv4.0
would seamlessly let virtual SGIs in, and it would "just work".

If we start enforcing this, I question the very design of the 
architecture,
because we could have done so much better by changing the CPU interface.

What has changed in two years? Have you spotted a fundamental problem?
My concern is that if we prevent it, we're going to end-up with quirks
allowing it anyway, because people will realise that it actually works.

In the meantime, to the meat of the change:

> 
> Check the GIC CPUIF version through the arm64 capabilities
> infrastructure and disable vSGIs if a CPUIF version < 4.1 is
> detected to prevent using vSGIs on systems where they may
> misbehave.
> 
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Marc Zyngier <maz@kernel.org>
> ---
>  drivers/irqchip/irq-gic-v3-its.c | 20 +++++++++++++++++++-
>  1 file changed, 19 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/irqchip/irq-gic-v3-its.c 
> b/drivers/irqchip/irq-gic-v3-its.c
> index 0fec31931e11..6ed4ba60ba7e 100644
> --- a/drivers/irqchip/irq-gic-v3-its.c
> +++ b/drivers/irqchip/irq-gic-v3-its.c
> @@ -39,6 +39,20 @@
> 
>  #include "irq-gic-common.h"
> 
> +#ifdef CONFIG_ARM64
> +#include <asm/cpufeature.h>
> +
> +static inline bool gic_cpuif_has_vsgi(void)
> +{
> +	return cpus_have_const_cap(ARM64_HAS_GIC_CPUIF_VSGI);
> +}
> +#else
> +static inline bool gic_cpuif_has_vsgi(void)
> +{
> +	return false;
> +}
> +#endif
> +
>  #define ITS_FLAGS_CMDQ_NEEDS_FLUSHING		(1ULL << 0)
>  #define ITS_FLAGS_WORKAROUND_CAVIUM_22375	(1ULL << 1)
>  #define ITS_FLAGS_WORKAROUND_CAVIUM_23144	(1ULL << 2)
> @@ -5415,7 +5429,11 @@ int __init its_init(struct fwnode_handle
> *handle, struct rdists *rdists,
>  	if (has_v4 & rdists->has_vlpis) {
>  		const struct irq_domain_ops *sgi_ops;
> 
> -		if (has_v4_1)
> +		/*
> +		 * Enable vSGIs only if the ITS and the
> +		 * GIC CPUIF support them.
> +		 */
> +		if (has_v4_1 && gic_cpuif_has_vsgi())
>  			sgi_ops = &its_sgi_domain_ops;
>  		else
>  			sgi_ops = NULL;

Is that enough?

KVM is still going to expose GICD_TYPER2.nASSGIcap, making things even
more confusing for the guest: it will be able to select active-less SGIs
via GICD_CTLR.nASSGIreq, and if I'm not mistaken, we'd still try to 
switch
to HW-backed SGIs, leading to some *very* unpleasant things in
gic_v4_enable_vsgis().

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
