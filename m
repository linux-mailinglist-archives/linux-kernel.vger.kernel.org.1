Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 523E329A73D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 10:05:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2895293AbgJ0JDz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 05:03:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:56528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2895286AbgJ0JDy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 05:03:54 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2243A206DC;
        Tue, 27 Oct 2020 09:03:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603789434;
        bh=9i3xc1N4T9XdkH48tZRMTBAeFg4Bk4OEANGgtVvnDdI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=h2mq+Cuc2s83ZF+bFsQzu9jFiVGTXPUgBa6LgqKTBFFODBpbYVumjct1cxTwWrrJ7
         xQY66ASydgWd2v2Vmg8mI9c7O4MfawBsD8KJeVBt6rQrt5VRkgDl1RNogKsy81W+Kw
         XJr0XmhYaK83GVtpqcK8ycox8kpn+z/I5cMoeYv4=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1kXKtT-004cie-TM; Tue, 27 Oct 2020 09:03:52 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 27 Oct 2020 09:03:51 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     balbi@kernel.org
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] irqchip: bcm2836: fix section mismatch warning
In-Reply-To: <20201027085157.1964906-3-balbi@kernel.org>
References: <20201027085157.1964906-1-balbi@kernel.org>
 <20201027085157.1964906-3-balbi@kernel.org>
User-Agent: Roundcube Webmail/1.4.9
Message-ID: <49f17502445e5ae5b35df15577957ae6@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: balbi@kernel.org, mathieu.poirier@linaro.org, tglx@linutronix.de, jason@lakedaemon.net, alexander.shishkin@linux.intel.com, suzuki.poulose@arm.com, f.fainelli@gmail.com, rjui@broadcom.com, sbranden@broadcom.com, bcm-kernel-feedback-list@broadcom.com, coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-10-27 08:51, balbi@kernel.org wrote:
> From: Felipe Balbi <balbi@kernel.org>
> 
> Fix the following warning:
> 
> WARNING: modpost: vmlinux.o(.text.unlikely+0x17b2c): Section mismatch
> in reference from the function bcm2836_arm_irqchip_smp_init() to the
> function .init.text:set_smp_ipi_range()
> The function bcm2836_arm_irqchip_smp_init() references
> the function __init set_smp_ipi_range().
> This is often because bcm2836_arm_irqchip_smp_init lacks a __init
> annotation or the annotation of set_smp_ipi_range is wrong.
> 
> Signed-off-by: Felipe Balbi <balbi@kernel.org>
> ---
>  drivers/irqchip/irq-bcm2836.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/irqchip/irq-bcm2836.c 
> b/drivers/irqchip/irq-bcm2836.c
> index 97838eb705f9..cbc7c740e4dc 100644
> --- a/drivers/irqchip/irq-bcm2836.c
> +++ b/drivers/irqchip/irq-bcm2836.c
> @@ -244,7 +244,7 @@ static int bcm2836_cpu_dying(unsigned int cpu)
> 
>  #define BITS_PER_MBOX	32
> 
> -static void bcm2836_arm_irqchip_smp_init(void)
> +static void __init bcm2836_arm_irqchip_smp_init(void)
>  {
>  	struct irq_fwspec ipi_fwspec = {
>  		.fwnode		= intc.domain->fwnode,

I already have a fix for this one[1], which should be in -next.

Thanks,

         M.

[1] 
https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git/commit/?h=irq/irqchip-next&id=57733e009f0c7e0526e10a18be12f56996c5460e
-- 
Jazz is not dead. It just smells funny...
