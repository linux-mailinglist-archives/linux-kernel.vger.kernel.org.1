Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD7BF2B18EF
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 11:21:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726308AbgKMKVj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 05:21:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726176AbgKMKVi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 05:21:38 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6FDBC0613D1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 02:21:38 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id 19so7627004wmf.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 02:21:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=D2LiQWHiFLDNR+pZMPreik2uIEh56WtRjv1+qdCwDuQ=;
        b=gIzsijjaG6RJ8YYvNizhxyG1nNBB8WMIs9DL2LYalNg+siSAfNYVeXE0lNEvPj9ykJ
         aEr3gPIMciEGd/f2dvwXxLZqGj0B4gjbRXxdZROm/JDvlqH3Z/3Wq28LvIWMV2FNzO0b
         /Dm8ArjAMkvubkLzvmUmvuOM1o10iEMGEGGjfy1DLc267B01LFIGqESFTi2k9F0gULWi
         idRmMW6ud1T5BCiTQUqyEX/oo+C7Az0W1+xry3aNK2Y51WTFL90SmAR8N5x9/+69qzd7
         KF4l6m4hh05AwRqyzl/s1JYWLVBmJmyptvClPOZYFqNAY6cBHetTVef2LFCmlVHt0IQS
         GNoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=D2LiQWHiFLDNR+pZMPreik2uIEh56WtRjv1+qdCwDuQ=;
        b=fX9aTy/vFi5U26IeKnok1ZiJ23nasfMtHUrQBoQ35FrbDMjkRQG7EG2Wv1iiqM0vug
         7bKPS84chLiBuSyTrN4yWCFrr2xZ1l87UgsV3PECVPdHA0ah86RrCfa3/PqmAAXsiaDb
         0odEkQeEMIwhr4PaOEu0sW1mfCevoH+TFMFP229SchnZMZFrcmBVEvJeTNiEKdRO2opv
         WYwaLWj9eoOsZ6Gqz2uDmxySnfftYNjTCgQqxC7oYQFqm2bPs/7FVnT9rAmj1X29g5U1
         T9YH+2AUQK99j+LHgfPXVZxl8+4Bv8yrF64prwpg07Yelmx7VtzxslQhkPkxwZJpYbzK
         /fzw==
X-Gm-Message-State: AOAM533cddQzxef5sMzIUJVW3NQq+CLiIyKCLOm7bR1U8HDtadcbIXJT
        iVd7xMoGLP6G8TCv/0eCz1YGFg==
X-Google-Smtp-Source: ABdhPJxNxm/I0nc/H7MhT4CFqJfviVLTYdwKM5yaCiZ9FZIASH+oSG1mOM8ZeHxeISgnkSGwCZoEew==
X-Received: by 2002:a1c:4144:: with SMTP id o65mr1821514wma.39.1605262897428;
        Fri, 13 Nov 2020 02:21:37 -0800 (PST)
Received: from dell ([91.110.221.159])
        by smtp.gmail.com with ESMTPSA id v6sm11480170wrb.53.2020.11.13.02.21.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2020 02:21:36 -0800 (PST)
Date:   Fri, 13 Nov 2020 10:21:34 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Tony Lindgren <tony@atomide.com>
Cc:     linux-kernel@vger.kernel.org,
        Carl Philipp Klemm <philipp@uvos.xyz>,
        Laxminath Kasam <lkasam@codeaurora.org>,
        Merlijn Wajer <merlijn@wizzup.org>,
        Mark Brown <broonie@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Sebastian Reichel <sre@kernel.org>,
        Tim Harvey <tharvey@gateworks.com>
Subject: Re: [PATCH] mfd: cpcap: Fix interrupt regression with regmap
 clear_ack
Message-ID: <20201113102134.GI3718728@dell>
References: <20201111170613.46057-1-tony@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201111170613.46057-1-tony@atomide.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Nov 2020, Tony Lindgren wrote:

> With commit 3a6f0fb7b8eb ("regmap: irq: Add support to clear ack
> registers"), the cpcap interrupts are no longer getting acked properly
> leading to a very unresponsive device with CPUs fully loaded spinning
> in the threaded IRQ handlers.
> 
> To me it looks like the clear_ack commit above actually fixed a long
> standing bug in regmap_irq_thread() where we unconditionally acked the
> interrupts earlier without considering ack_invert. And the issue with
> cpcap started happening as we now also consider ack_invert.
> 
> Tim Harvey <tharvey@gateworks.com> tried to fix this issue earlier with
> "[PATCH v2] regmap: irq: fix ack-invert", but the reading of the ack
> register was considered unnecessary for just ack_invert, and we did not
> have clear_ack available yet. As the cpcap irqs worked both with and
> without ack_invert earlier because of the unconditional ack, the
> problem remained hidden until now.
> 
> Also, looks like the earlier v3.0.8 based Motorola Android Linux kernel
> does clear_ack style read-clear-write with "ireg_val & ~mreg_val" instead
> of just ack_invert style write. So let's switch cpcap to use clear_ack
> to fix the issue.
> 
> Fixes: 3a6f0fb7b8eb ("regmap: irq: Add support to clear ack registers")
> Cc: Carl Philipp Klemm <philipp@uvos.xyz>
> Cc: Laxminath Kasam <lkasam@codeaurora.org>
> Cc: Merlijn Wajer <merlijn@wizzup.org>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Pavel Machek <pavel@ucw.cz>
> Cc: Sebastian Reichel <sre@kernel.org>
> Cc: Tim Harvey <tharvey@gateworks.com>

It would be nice to have you review this Tim.

> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  drivers/mfd/motorola-cpcap.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mfd/motorola-cpcap.c b/drivers/mfd/motorola-cpcap.c
> --- a/drivers/mfd/motorola-cpcap.c
> +++ b/drivers/mfd/motorola-cpcap.c
> @@ -97,7 +97,7 @@ static struct regmap_irq_chip cpcap_irq_chip[CPCAP_NR_IRQ_CHIPS] = {
>  		.ack_base = CPCAP_REG_MI1,
>  		.mask_base = CPCAP_REG_MIM1,
>  		.use_ack = true,
> -		.ack_invert = true,
> +		.clear_ack = true,
>  	},
>  	{
>  		.name = "cpcap-m2",
> @@ -106,7 +106,7 @@ static struct regmap_irq_chip cpcap_irq_chip[CPCAP_NR_IRQ_CHIPS] = {
>  		.ack_base = CPCAP_REG_MI2,
>  		.mask_base = CPCAP_REG_MIM2,
>  		.use_ack = true,
> -		.ack_invert = true,
> +		.clear_ack = true,
>  	},
>  	{
>  		.name = "cpcap1-4",
> @@ -115,7 +115,7 @@ static struct regmap_irq_chip cpcap_irq_chip[CPCAP_NR_IRQ_CHIPS] = {
>  		.ack_base = CPCAP_REG_INT1,
>  		.mask_base = CPCAP_REG_INTM1,
>  		.use_ack = true,
> -		.ack_invert = true,
> +		.clear_ack = true,
>  	},
>  };
>  

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
