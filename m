Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 883C928E9E8
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 03:24:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731954AbgJOBYi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 21:24:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728127AbgJOBYh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 21:24:37 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 299ABC045707
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 18:16:08 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id l8so2193620ioh.11
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 18:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tVdoKNi6CDA3oy1vcQG9KtgdbV05kDOzZC+L7q8Ac3k=;
        b=IGDdXD8rRTcME1ZCmTTfJ4lQaP4iI1mFbqYpnWxCGvVGVaYgLhflPiiAS9MIFJ+rLN
         8u6s/43uMEnOXFaKOCsAQBfnKoYZpRxUxvRCECUmiSnOaGR0fDd04xHgevlJx3rtyKZp
         C+YGRVnuxcN/K4EfNaaxmbzvEO6dgwYDNcoiwphItBMXzvOZIC/FV4qlMZ7MdXqwg0m9
         2r7Gn1cd0ZiDSGqJ/PelTaaAngsrOYH5EVGs4MKtqBdpx/wqEA2URnzWgTavNZ/gTplw
         JlMpGhasb6wfHGAfvZofpSXwf92cHfFCmmTf350iMdFsz2OlczvyCtel4j34j+moNgok
         e32Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tVdoKNi6CDA3oy1vcQG9KtgdbV05kDOzZC+L7q8Ac3k=;
        b=MNDKo9o3+9ROjDUZ5NiogZDmlCHkH9YhmhHlQW3lqRaaSOizlBymCc8Dmer3cPxHPg
         G9OnSZg5TwZkFRxVSuId2cUdYPfKkjiW9YwonSp266ZwbB9/vVdsjTu0CKhR6LZhs3sx
         FB4ClXiAwtZNUtkwM3usj7blBlGmZVO3tctA0OiU7cPUQGpGqBmDnpy0PFdvJWaCe2Kn
         yzo/f5QtbT+itB+0aI8fhUCYvsIm5AFeXi4hlZ23KgRxPfWsfA5Oflo7KXRCUJtMEF1f
         yMvx8GBbZPIloknOrnf2pSS7sTcw42cbCcqkKf1QvvEb/BdI0SV8vgdcVYu+EPna1RP7
         09yw==
X-Gm-Message-State: AOAM533FrXMX1tcFtbKZ3MGWrso724g9o1BF4EDsR1K/6fffv41t3tSG
        Mli0AWtknH0HZFDAEsMDGg==
X-Google-Smtp-Source: ABdhPJyzjy0u4JM0XQEC75drvBuz4Tg9Dl1F4JxQlCjD8m3vu+7kP8DfjFUkkFR7mIXnXbn2t/v1vw==
X-Received: by 2002:a05:6638:1189:: with SMTP id f9mr1805122jas.10.1602724567593;
        Wed, 14 Oct 2020 18:16:07 -0700 (PDT)
Received: from gabell (209-6-122-159.s2973.c3-0.arl-cbr1.sbo-arl.ma.cable.rcncustomer.com. [209.6.122.159])
        by smtp.gmail.com with ESMTPSA id r204sm1408693iod.25.2020.10.14.18.16.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 14 Oct 2020 18:16:06 -0700 (PDT)
Date:   Wed, 14 Oct 2020 21:16:04 -0400
From:   Masayoshi Mizuma <msys.mizuma@gmail.com>
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     maz@kernel.org, catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, tglx@linutronix.de,
        jason@lakedaemon.net, mark.rutland@arm.com,
        julien.thierry.kdev@gmail.com, dianders@chromium.org,
        daniel.thompson@linaro.org, jason.wessel@windriver.com,
        ito-yuichi@fujitsu.com, kgdb-bugreport@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/5] irqchip/gic-v3: Enable support for SGIs to act as
 NMIs
Message-ID: <20201015011604.ixmx2e2cbn5zsu5j@gabell>
References: <1602673931-28782-1-git-send-email-sumit.garg@linaro.org>
 <1602673931-28782-3-git-send-email-sumit.garg@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1602673931-28782-3-git-send-email-sumit.garg@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 14, 2020 at 04:42:08PM +0530, Sumit Garg wrote:
> Add support to handle SGIs as regular NMIs. As SGIs or IPIs defaults to a
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
> diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
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
>  	/* desc lock should already be held */
>  	if (gic_irq_in_rdist(d)) {
>  		u32 idx = gic_get_ppi_index(d);
> @@ -514,6 +519,11 @@ static void gic_irq_nmi_teardown(struct irq_data *d)
>  	if (WARN_ON(gic_irq(d) >= 8192))
>  		return;
>  
> +	if (get_intid_range(d) == SGI_RANGE) {
> +		gic_irq_set_prio(d, GICD_INT_DEF_PRI);
> +		return;
> +	}
> +
>  	/* desc lock should already be held */
>  	if (gic_irq_in_rdist(d)) {
>  		u32 idx = gic_get_ppi_index(d);
> @@ -1708,6 +1718,7 @@ static int __init gic_init_bases(void __iomem *dist_base,
>  
>  	gic_dist_init();
>  	gic_cpu_init();
> +	gic_enable_nmi_support();
>  	gic_smp_init();
>  	gic_cpu_pm_init();
>  
> @@ -1719,8 +1730,6 @@ static int __init gic_init_bases(void __iomem *dist_base,
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
