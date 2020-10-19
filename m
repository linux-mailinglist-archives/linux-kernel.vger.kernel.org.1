Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24A162926FB
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 14:07:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726503AbgJSMH4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 08:07:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:58132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725924AbgJSMH4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 08:07:56 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3FD8022268;
        Mon, 19 Oct 2020 12:07:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603109275;
        bh=3noPGpjp762hGnSUK70UPaaIzFQ7lKiB2FH5eZtTlDA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=M5/YtPqHbtKAUgR3DwCSgfAQrTvVxmEmF1S2YqDLubx0IY5tVxtoFsssvrSZACO+a
         beI8MXzHo4/ZVTJTiOsBExKnM9w5CnxFSTovxPz1GuV0u0NjeCFzhvs5uE96RIvHD+
         ZCItI/8nzgIoheRq36gteJpuqNH6LkVi86aleRZ8=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1kUTxB-002PXG-Bu; Mon, 19 Oct 2020 13:07:53 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 19 Oct 2020 13:07:53 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, tglx@linutronix.de,
        jason@lakedaemon.net, mark.rutland@arm.com,
        julien.thierry.kdev@gmail.com, dianders@chromium.org,
        daniel.thompson@linaro.org, jason.wessel@windriver.com,
        msys.mizuma@gmail.com, ito-yuichi@fujitsu.com,
        kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/5] irqchip/gic-v3: Enable support for SGIs to act as
 NMIs
In-Reply-To: <1602673931-28782-3-git-send-email-sumit.garg@linaro.org>
References: <1602673931-28782-1-git-send-email-sumit.garg@linaro.org>
 <1602673931-28782-3-git-send-email-sumit.garg@linaro.org>
User-Agent: Roundcube Webmail/1.4.9
Message-ID: <294754db12f4cd8a8ec9329a44e1cf02@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: sumit.garg@linaro.org, catalin.marinas@arm.com, will@kernel.org, linux-arm-kernel@lists.infradead.org, tglx@linutronix.de, jason@lakedaemon.net, mark.rutland@arm.com, julien.thierry.kdev@gmail.com, dianders@chromium.org, daniel.thompson@linaro.org, jason.wessel@windriver.com, msys.mizuma@gmail.com, ito-yuichi@fujitsu.com, kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-10-14 12:12, Sumit Garg wrote:
> Add support to handle SGIs as regular NMIs. As SGIs or IPIs defaults to 
> a

There is nothing "regular" about NMIs. Drop "or IPIs". 
s/defaults/default/

> special flow handler: handle_percpu_devid_fasteoi_ipi(), so skip NMI
> handler update in case of SGIs.
> 
> Also, enable NMI support prior to gic_smp_init() as allocation of SGIs
> as IRQs/NMIs happen as part of this routine.
> 
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> ---
>  drivers/irqchip/irq-gic-v3.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/irqchip/irq-gic-v3.c 
> b/drivers/irqchip/irq-gic-v3.c
> index 16fecc0..5efc865 100644
> --- a/drivers/irqchip/irq-gic-v3.c
> +++ b/drivers/irqchip/irq-gic-v3.c
> @@ -477,6 +477,11 @@ static int gic_irq_nmi_setup(struct irq_data *d)
>  	if (WARN_ON(gic_irq(d) >= 8192))
>  		return -EINVAL;
> 
> +	if (get_intid_range(d) == SGI_RANGE) {
> +		gic_irq_set_prio(d, GICD_INT_NMI_PRI);
> +		return 0;
> +	}
> +

Please follow the existing control flow, or rework it to be organised by 
range.

>  	/* desc lock should already be held */
>  	if (gic_irq_in_rdist(d)) {
>  		u32 idx = gic_get_ppi_index(d);
> @@ -514,6 +519,11 @@ static void gic_irq_nmi_teardown(struct irq_data 
> *d)
>  	if (WARN_ON(gic_irq(d) >= 8192))
>  		return;
> 
> +	if (get_intid_range(d) == SGI_RANGE) {
> +		gic_irq_set_prio(d, GICD_INT_DEF_PRI);
> +		return;
> +	}

Same here.

> +
>  	/* desc lock should already be held */
>  	if (gic_irq_in_rdist(d)) {
>  		u32 idx = gic_get_ppi_index(d);
> @@ -1708,6 +1718,7 @@ static int __init gic_init_bases(void __iomem 
> *dist_base,
> 
>  	gic_dist_init();
>  	gic_cpu_init();
> +	gic_enable_nmi_support();
>  	gic_smp_init();
>  	gic_cpu_pm_init();
> 
> @@ -1719,8 +1730,6 @@ static int __init gic_init_bases(void __iomem 
> *dist_base,
>  			gicv2m_init(handle, gic_data.domain);
>  	}
> 
> -	gic_enable_nmi_support();
> -
>  	return 0;
> 
>  out_free:

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
