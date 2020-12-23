Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8640A2E1A02
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 09:34:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728248AbgLWIc4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Dec 2020 03:32:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727794AbgLWIcz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 03:32:55 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4F27C0613D6
        for <linux-kernel@vger.kernel.org>; Wed, 23 Dec 2020 00:32:14 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id n25so4666491pgb.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Dec 2020 00:32:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=f6z2jHWOUsdwvkW1sMAfQ+uPvAPsBSWtcQYM5UeGKOQ=;
        b=R1Dtuprupk5qqiUMugbruG8tuTkprsynKgHI6FENUZDJPwteKI/RPbhP1u7CXwuf4u
         L2eZUc5xoe1egZtRKXhxLNCysC2nfWPgQ798UT68SUdKJM28lGqsh3znYrwyyn9m3a/x
         4vpCIEXdsq/TxF/e/vNFR3MLDzRxVnPS19Kls=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=f6z2jHWOUsdwvkW1sMAfQ+uPvAPsBSWtcQYM5UeGKOQ=;
        b=A7EkLj17AMUhvVkCX0xUWbAIK3LHYKTOJFuVROdbT7Ftj5kBylmAe1Xfk/iTTQEywe
         NZEpnnexLvKfzYFWb6idhQIm+cckQP9T9jupNatpSC4tvTucSWazwscQ8ebt6EqLOcK6
         R3DydDew7LFdMkP4kbuVi2piFPmuk43jIUS0sXpof442CA+b+CYf7XXOzGjI/yJRaVbT
         xtA17yyWAapQtpPmMHD9p0ulRiJkayd95QqHq3AH0d7KW9+UHJlalrwrbU5np1i0bgyK
         ngC0f6NzHzS0NfIfyNIXpZAYZPvQlPB7q/T7ZieOtYKpsEMNH4WV//A9Lag0WoJo/Tdi
         3gWw==
X-Gm-Message-State: AOAM5321CyYFTUQ0C6gLTNhQqH+9+EfkM6IBXmfYUTMW5XQmoAX+Idso
        /I7TdN8AvsY5aTQH8fIMkdXmqQ==
X-Google-Smtp-Source: ABdhPJxRY0t2ecrt0qdbX6wNZyK5FMit7yNVCixLg3SFVanvhZuz5z5iGFCyfF9mG3ZV++F089pKQw==
X-Received: by 2002:a62:9208:0:b029:19e:a15f:169e with SMTP id o8-20020a6292080000b029019ea15f169emr23179186pfd.71.1608712334434;
        Wed, 23 Dec 2020 00:32:14 -0800 (PST)
Received: from chromium.org ([2401:fa00:8f:2:a28c:fdff:fef0:43bf])
        by smtp.gmail.com with ESMTPSA id p187sm21556047pfp.60.2020.12.23.00.32.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Dec 2020 00:32:13 -0800 (PST)
Date:   Wed, 23 Dec 2020 17:32:07 +0900
From:   Tomasz Figa <tfiga@chromium.org>
To:     Yong Wu <yong.wu@mediatek.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, youlin.pei@mediatek.com,
        devicetree@vger.kernel.org,
        Nicolas Boichat <drinkcat@chromium.org>,
        srv_heupstream@mediatek.com, chao.hao@mediatek.com,
        linux-kernel@vger.kernel.org, Evan Green <evgreen@chromium.org>,
        Tomasz Figa <tfiga@google.com>,
        iommu@lists.linux-foundation.org,
        linux-mediatek@lists.infradead.org,
        Krzysztof Kozlowski <krzk@kernel.org>, anan.sun@mediatek.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5 17/27] iommu/mediatek: Add pm runtime callback
Message-ID: <X+MAh87dFsY2p8vF@chromium.org>
References: <20201209080102.26626-1-yong.wu@mediatek.com>
 <20201209080102.26626-18-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201209080102.26626-18-yong.wu@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 09, 2020 at 04:00:52PM +0800, Yong Wu wrote:
> This patch adds pm runtime callback.
> 
> In pm runtime case, all the registers backup/restore and bclk are
> controlled in the pm_runtime callback, then pm_suspend is not needed in
> this case.
> 
> runtime PM is disabled when suspend, thus we call
> pm_runtime_status_suspended instead of pm_runtime_suspended.
> 
> And, m4u doesn't have its special pm runtime domain in previous SoC, in
> this case dev->power.runtime_status is RPM_SUSPENDED defaultly,

This sounds wrong and could lead to hard to debug errors when the driver
is changed in the future. Would it be possible to make the behavior
consistent across the SoCs instead, so that runtime PM status is ACTIVE
when needed, even on SoCs without an IOMMU PM domain?

> thus add
> a "dev->pm_domain" checking for the SoC that has pm runtime domain.
> 
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
>  drivers/iommu/mtk_iommu.c | 22 ++++++++++++++++++++--
>  1 file changed, 20 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> index 5614015e5b96..6fe3ee2b2bf5 100644
> --- a/drivers/iommu/mtk_iommu.c
> +++ b/drivers/iommu/mtk_iommu.c
> @@ -808,7 +808,7 @@ static int mtk_iommu_remove(struct platform_device *pdev)
>  	return 0;
>  }
>  
> -static int __maybe_unused mtk_iommu_suspend(struct device *dev)
> +static int __maybe_unused mtk_iommu_runtime_suspend(struct device *dev)
>  {
>  	struct mtk_iommu_data *data = dev_get_drvdata(dev);
>  	struct mtk_iommu_suspend_reg *reg = &data->reg;
> @@ -826,7 +826,7 @@ static int __maybe_unused mtk_iommu_suspend(struct device *dev)
>  	return 0;
>  }
>  
> -static int __maybe_unused mtk_iommu_resume(struct device *dev)
> +static int __maybe_unused mtk_iommu_runtime_resume(struct device *dev)
>  {
>  	struct mtk_iommu_data *data = dev_get_drvdata(dev);
>  	struct mtk_iommu_suspend_reg *reg = &data->reg;
> @@ -853,7 +853,25 @@ static int __maybe_unused mtk_iommu_resume(struct device *dev)
>  	return 0;
>  }
>  
> +static int __maybe_unused mtk_iommu_suspend(struct device *dev)
> +{
> +	/* runtime PM is disabled when suspend in pm_runtime case. */
> +	if (dev->pm_domain && pm_runtime_status_suspended(dev))
> +		return 0;
> +
> +	return mtk_iommu_runtime_suspend(dev);
> +}
> +
> +static int __maybe_unused mtk_iommu_resume(struct device *dev)
> +{
> +	if (dev->pm_domain && pm_runtime_status_suspended(dev))
> +		return 0;
> +
> +	return mtk_iommu_runtime_resume(dev);
> +}

Wouldn't it be enough to just use pm_runtime_force_suspend() and
pm_runtime_force_resume() as system sleep ops?

> +
>  static const struct dev_pm_ops mtk_iommu_pm_ops = {
> +	SET_RUNTIME_PM_OPS(mtk_iommu_runtime_suspend, mtk_iommu_runtime_resume, NULL)
>  	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(mtk_iommu_suspend, mtk_iommu_resume)
>  };
>  
> -- 
> 2.18.0
> 
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
