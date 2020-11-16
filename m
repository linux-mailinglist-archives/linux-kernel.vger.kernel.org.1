Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 278842B4AD3
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 17:24:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731993AbgKPQWT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 11:22:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728871AbgKPQWS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 11:22:18 -0500
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C1DBC0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 08:22:18 -0800 (PST)
Received: by mail-qt1-x841.google.com with SMTP id j31so13224434qtb.8
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 08:22:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=u+yg2qRnwunpXobvzpTUDRpnlMSmAnGlsUkATXGRFqQ=;
        b=Du40fP9tGWWTX3RrY9l6IliLCotryPMOrsdD9rT5ffXgDJGBsH+TmFdmY/VZuTCdqE
         QYMlQCNU18FlSzr8EGf1+sjjez3fiOtpBSOMwiIn3u6iD/0joCEYQWHFxmRKtjbqFGdV
         O+ZPulvsLNP08jc/Bbe/gpyYDuWpZYmU6xJpNLPkPdjsEwv+G8r7oNiYTi98716Nyg7m
         tD6tUICOeNkwyWE8pbK7Fyfw7hZfWpPYflQsc+Pu11WgiZiXyRodVTmuWHaVOcWEJJ1p
         xWhsFWu9PAoNlE2qGx4GDVOG6ZnJ8XpwnboWJpV7yl5aIQ+ejX3CeUc3Nl4ptSwAtonP
         fqDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=u+yg2qRnwunpXobvzpTUDRpnlMSmAnGlsUkATXGRFqQ=;
        b=r2F01VRqzugyOcKLYS9iSSthsVFgJrZFKJv28ZfNguoFN7aJMvniTW4xtTfOiYt6hF
         q7pSuXEo03epu1RyaINxESfklZVx+V/UPvUvnWF/tkLVSRhi5s+DrV/C6I/P52g2xQns
         dZ1A1OfQpyqo/3qoUXUll1shnF9S7+u+KP2Dpa8GV3yObyzDcVabqbR0yxmtMxxxnENG
         DBTwa5RzAXdb1pWBn/ggTYufkgvzkpje5H2IKu3naSUAM0ID0A2aOiFfos9gUGXVoate
         yGTiXi6gnl15ZdOkXGAI94OaKs9I2BO7y7nDBL8+1Z7yQkAvnciZneeS5f6XwrR0UAYx
         iaqw==
X-Gm-Message-State: AOAM531BExh/JetIVuB80miT3ehfddTK/gYvd4IsLwW/Sn601Y5HVCVh
        +sFwa1Mmc0PtdmmKUHU6XA==
X-Google-Smtp-Source: ABdhPJz6ICjG9Oq98anaUMeRP6EpHzqcQ6rdu2O9aoaq4FeTooapVFMcZIq/utQe3fKjwkWfx8gYnA==
X-Received: by 2002:a05:622a:15:: with SMTP id x21mr15205954qtw.323.1605543737471;
        Mon, 16 Nov 2020 08:22:17 -0800 (PST)
Received: from gabell (209-6-122-159.s2973.c3-0.arl-cbr1.sbo-arl.ma.cable.rcncustomer.com. [209.6.122.159])
        by smtp.gmail.com with ESMTPSA id v16sm12932266qka.72.2020.11.16.08.22.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 16 Nov 2020 08:22:16 -0800 (PST)
Date:   Mon, 16 Nov 2020 11:22:14 -0500
From:   Masayoshi Mizuma <msys.mizuma@gmail.com>
To:     Yuichi Ito <ito-yuichi@fujitsu.com>
Cc:     maz@kernel.org, sumit.garg@linaro.org, tglx@linutronix.de,
        jason@lakedaemon.net, catalin.marinas@arm.com, will@kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 1/3] irqchip/gic-v3: Enable support for SGIs to act as
 NMIs
Message-ID: <20201116162214.jpqhjmxcualblr72@gabell>
References: <20201104080539.3205889-1-ito-yuichi@fujitsu.com>
 <20201104080539.3205889-2-ito-yuichi@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201104080539.3205889-2-ito-yuichi@fujitsu.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yuichi-san,

This patch is under review here:
https://lore.kernel.org/linux-arm-kernel/1604317487-14543-3-git-send-email-sumit.garg@linaro.org/

So, it would be great if you could send your feedback to the
thread; testing, code review.

Thanks,
Masa

On Wed, Nov 04, 2020 at 05:05:37PM +0900, Yuichi Ito wrote:
> From: From: Sumit Garg <sumit.garg@linaro.org>
> 
> Add support to handle SGIs as pseudo NMIs. As SGIs or IPIs default to a
> special flow handler: handle_percpu_devid_fasteoi_ipi(), so skip NMI
> handler update in case of SGIs.
> 
> Also, enable NMI support prior to gic_smp_init() as allocation of SGIs
> as IRQs/NMIs happen as part of this routine.
> 
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> ---
>  drivers/irqchip/irq-gic-v3.c | 29 +++++++++++++++++++++--------
>  1 file changed, 21 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
> index 16fecc0..7010ae2 100644
> --- a/drivers/irqchip/irq-gic-v3.c
> +++ b/drivers/irqchip/irq-gic-v3.c
> @@ -461,6 +461,7 @@ static u32 gic_get_ppi_index(struct irq_data *d)
>  static int gic_irq_nmi_setup(struct irq_data *d)
>  {
>  	struct irq_desc *desc = irq_to_desc(d->irq);
> +	u32 idx;
>  
>  	if (!gic_supports_nmi())
>  		return -EINVAL;
> @@ -478,16 +479,22 @@ static int gic_irq_nmi_setup(struct irq_data *d)
>  		return -EINVAL;
>  
>  	/* desc lock should already be held */
> -	if (gic_irq_in_rdist(d)) {
> -		u32 idx = gic_get_ppi_index(d);
> +	switch (get_intid_range(d)) {
> +	case SGI_RANGE:
> +		break;
> +	case PPI_RANGE:
> +	case EPPI_RANGE:
> +		idx = gic_get_ppi_index(d);
>  
>  		/* Setting up PPI as NMI, only switch handler for first NMI */
>  		if (!refcount_inc_not_zero(&ppi_nmi_refs[idx])) {
>  			refcount_set(&ppi_nmi_refs[idx], 1);
>  			desc->handle_irq = handle_percpu_devid_fasteoi_nmi;
>  		}
> -	} else {
> +		break;
> +	default:
>  		desc->handle_irq = handle_fasteoi_nmi;
> +		break;
>  	}
>  
>  	gic_irq_set_prio(d, GICD_INT_NMI_PRI);
> @@ -498,6 +505,7 @@ static int gic_irq_nmi_setup(struct irq_data *d)
>  static void gic_irq_nmi_teardown(struct irq_data *d)
>  {
>  	struct irq_desc *desc = irq_to_desc(d->irq);
> +	u32 idx;
>  
>  	if (WARN_ON(!gic_supports_nmi()))
>  		return;
> @@ -515,14 +523,20 @@ static void gic_irq_nmi_teardown(struct irq_data *d)
>  		return;
>  
>  	/* desc lock should already be held */
> -	if (gic_irq_in_rdist(d)) {
> -		u32 idx = gic_get_ppi_index(d);
> +	switch (get_intid_range(d)) {
> +	case SGI_RANGE:
> +		break;
> +	case PPI_RANGE:
> +	case EPPI_RANGE:
> +		idx = gic_get_ppi_index(d);
>  
>  		/* Tearing down NMI, only switch handler for last NMI */
>  		if (refcount_dec_and_test(&ppi_nmi_refs[idx]))
>  			desc->handle_irq = handle_percpu_devid_irq;
> -	} else {
> +		break;
> +	default:
>  		desc->handle_irq = handle_fasteoi_irq;
> +		break;
>  	}
>  
>  	gic_irq_set_prio(d, GICD_INT_DEF_PRI);
> @@ -1708,6 +1722,7 @@ static int __init gic_init_bases(void __iomem *dist_base,
>  
>  	gic_dist_init();
>  	gic_cpu_init();
> +	gic_enable_nmi_support();
>  	gic_smp_init();
>  	gic_cpu_pm_init();
>  
> @@ -1719,8 +1734,6 @@ static int __init gic_init_bases(void __iomem *dist_base,
>  			gicv2m_init(handle, gic_data.domain);
>  	}
>  
> -	gic_enable_nmi_support();
> -
>  	return 0;
>  
>  out_free:
> -- 
> 1.8.3.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
