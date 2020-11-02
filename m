Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1C402A2F7D
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 17:17:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726945AbgKBQRK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 11:17:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726713AbgKBQRK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 11:17:10 -0500
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42375C0617A6
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 08:17:10 -0800 (PST)
Received: by mail-qv1-xf41.google.com with SMTP id q1so4245882qvn.5
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 08:17:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YeEey2vkBTNmp8sl+JT7BFlPeTSJgF0pPyztQBHkjgU=;
        b=cADYsIgm7vmYEaWL0V7aONlTnr7fawBMY5eDc+08xjg9CnKskh8Zhjtzeip4GGgEy1
         0ofmzTPtjWSI4oovnj3xQiqaEFd211XER6siB2eOlPi9M38d6oe/6YgdItmqrnL1T5QA
         N3k86hXDOcCkb8YquvPE0ocSoPysRQqqE/Ol9zjr9MZXjDwT2dlYz40YXmRulKGYzdcz
         Dd824lDFfi3Fz3Q2foAvvGT7m414yjQScJL9xFZ0eVgbKBg3S38CaosbSj1z2RcX2bDY
         JI814zdEdX/zDzwQ2KOo66SPdD5pFzFslaqkdzbbdBpxUP2wpfBseoHdygzJffY4SjsJ
         y6ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YeEey2vkBTNmp8sl+JT7BFlPeTSJgF0pPyztQBHkjgU=;
        b=XwV9zQp907v/Djk2cpih8SzAyQilBIKzSBsyIwS6ZwX2QIMHPRYMey+xoy2F41zLr5
         BWLrqADl8uNrm8EF92FN+Gyy5Z3UZE/kZy+5qZs1p+W5gnvY+OqftA6J9XErJA9VORHq
         dc2tffukp2T6q/a4ip7s3zbIrADfN3XfGVGgm9DMOM02kBfBT7MUVOA5U8orxfSKZzDI
         svUZ2riGwPYebl5inOML6XY44D2EBTNCK6vXxz2h+PH/M+5awyZWvf96SQ6pDPnJL0l6
         KtOnCC+2iiToiOCUafxXbpZC7nZlFYBCFfobDyOWrNQGeRQbII/uF0njxURxe94VSusd
         FPCg==
X-Gm-Message-State: AOAM533QJpNGrvdZt3yJp548r7jfnL+s6+Iceym2EYuMglSabAK1SD5W
        4Z/caS+2Mj6vkS2LrbEWQmr46GwKMA==
X-Google-Smtp-Source: ABdhPJz4HEYQmREMM2lRBxTpTBosLijiIh6hDzV+KakGyEepCDW7g7H/fyol1LOnYxiWseehdxuUBw==
X-Received: by 2002:a0c:b207:: with SMTP id x7mr22781268qvd.39.1604333829522;
        Mon, 02 Nov 2020 08:17:09 -0800 (PST)
Received: from gabell (209-6-122-159.s2973.c3-0.arl-cbr1.sbo-arl.ma.cable.rcncustomer.com. [209.6.122.159])
        by smtp.gmail.com with ESMTPSA id i18sm8187020qtv.38.2020.11.02.08.17.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 02 Nov 2020 08:17:08 -0800 (PST)
Date:   Mon, 2 Nov 2020 11:17:06 -0500
From:   Masayoshi Mizuma <msys.mizuma@gmail.com>
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     maz@kernel.org, catalin.marinas@arm.com, will@kernel.org,
        daniel.thompson@linaro.org, linux-arm-kernel@lists.infradead.org,
        tglx@linutronix.de, jason@lakedaemon.net, linux@armlinux.org.uk,
        tsbogend@alpha.franken.de, mpe@ellerman.id.au, davem@davemloft.net,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        mark.rutland@arm.com, julien.thierry.kdev@gmail.com,
        dianders@chromium.org, jason.wessel@windriver.com,
        ito-yuichi@fujitsu.com, kgdb-bugreport@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 2/7] irqchip/gic-v3: Enable support for SGIs to act as
 NMIs
Message-ID: <20201102161706.xfqdsro7q7k65ybb@gabell>
References: <1604317487-14543-1-git-send-email-sumit.garg@linaro.org>
 <1604317487-14543-3-git-send-email-sumit.garg@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1604317487-14543-3-git-send-email-sumit.garg@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 02, 2020 at 05:14:42PM +0530, Sumit Garg wrote:
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

Looks good to me. Please feel free to add:

	Reviewed-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>

Thanks!
Masa
