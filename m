Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F64C2FFBFF
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 06:11:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726686AbhAVFLJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 00:11:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726647AbhAVFLC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 00:11:02 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFADFC0613ED
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 21:10:21 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id i5so2922968pgo.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 21:10:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Dnd5Lmoa7qG/mekK/QsrLWb7/Ux/XM9dIbFRQBx8804=;
        b=uYSu4y26VifN1OwinqfjeWLsTzuucqM+IaRLgeUL6gAbyyYeUgmhW8GHKwEDH2lwzC
         YFLbL9GhLE6SkyhQeQVoVPKOfuAQSmWfp+tlpiGgUnePkM9YAWJyh+JuGIT6ojpUcTbn
         QqTLxGBUwPp3sStKx/N4jOTWR/H4MCfFD7/7LAEAHmlj5nE1AqSK3HoaEB17eVqk8grC
         BZf7EFEC79NTdLv04tXPq4E2EaDfOCM/Xl883serZkWKzIlGi0s04RjP+zxS+ASBfdOU
         UcM/zJcpCTuPK+mPTrsIE7Otmpv69qyVOM12HwjwPyj5l5zrAFs8R4Ma6sIV1fmwgtkx
         LYYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Dnd5Lmoa7qG/mekK/QsrLWb7/Ux/XM9dIbFRQBx8804=;
        b=dk4NElY66/gTFmcm9orgrLrMZIPhCYtXHxZtq9JJUXvfea29TsrutS0bJKnW5eWN5+
         x841yrNZ69GvY6HX/YG0Yf7GahW5Jw3F8sZ5wXSmLLttkY4+TCF1jug9lRAi5fvru0Qr
         yHn2e5gic3CTY8ObjdsYin0ztDuBH59K5W+EWFdqgu8s0m85G41aJJzCENgmHvveBhPp
         IOZrTAtagDhfNaSKFEJczTwsd7Vo5IJ3JAY1vXWTDayFvwgOvetgdSIVTKu4t8TJ1CRd
         9KE42Yj4qo5Nyo571twzuiyC68tGRx/AqIoNp2MBLKEm1qJf4n+ryOd+s4mFQAhNMhVJ
         CGyw==
X-Gm-Message-State: AOAM532dd1gL8u7r1Tm/VlnlSKKr2Q7VWpaumwsGawwN1sDOwwgn1FF0
        6EVOKp3/KualNLBGEqHc76vEpJ9QSDmwmS4i
X-Google-Smtp-Source: ABdhPJxrVqHG2MzVfQiwcXFk6yRa8jL+kIbN2oObVj9raOE0wukKGVEuijKUieN4a/96gA/wu1POtg==
X-Received: by 2002:a63:c444:: with SMTP id m4mr2942946pgg.420.1611292221096;
        Thu, 21 Jan 2021 21:10:21 -0800 (PST)
Received: from dragon (80.251.214.228.16clouds.com. [80.251.214.228])
        by smtp.gmail.com with ESMTPSA id q12sm7034796pgj.24.2021.01.21.21.10.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Jan 2021 21:10:20 -0800 (PST)
Date:   Fri, 22 Jan 2021 13:10:14 +0800
From:   Shawn Guo <shawn.guo@linaro.org>
To:     Thara Gopinath <thara.gopinath@linaro.org>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org,
        dan.j.williams@intel.com, vkoul@kernel.org,
        srinivas.kandagatla@linaro.org, linux-arm-msm@vger.kernel.org,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers: dma: qcom: bam_dma: Manage clocks when
 controlled_remotely is set
Message-ID: <20210122051013.GE2479@dragon>
References: <20210122025251.3501362-1-thara.gopinath@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210122025251.3501362-1-thara.gopinath@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 21, 2021 at 09:52:51PM -0500, Thara Gopinath wrote:
> When bam dma is "controlled remotely", thus far clocks were not controlled
> from the Linux. In this scenario, Linux was disabling runtime pm in bam dma
> driver and not doing any clock management in suspend/resume hooks.
> 
> With introduction of crypto engine bam dma, the clock is a rpmh resource
> that can be controlled from both Linux and TZ/remote side.  Now bam dma
> clock is getting enabled during probe even though the bam dma can be
> "controlled remotely". But due to clocks not being handled properly,
> bam_suspend generates a unbalanced clk_unprepare warning during system
> suspend.
> 
> To fix the above issue and to enable proper clock-management, this patch
> enables runtim-pm and handles bam dma clocks in suspend/resume hooks if
> the clock node is present irrespective of controlled_remotely property.

Shouldn't the following probe code need some update?  Now we have both
controlled_remotely and clocks handle for cryptobam node.  For example,
if devm_clk_get() returns -EPROBE_DEFER, we do not want to continue with
bamclk forcing to be NULL, right?

        bdev->bamclk = devm_clk_get(bdev->dev, "bam_clk");
        if (IS_ERR(bdev->bamclk)) {
                if (!bdev->controlled_remotely)
                        return PTR_ERR(bdev->bamclk);

                bdev->bamclk = NULL;
        }

> 
> Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
> ---
>  drivers/dma/qcom/bam_dma.c | 20 +++++++++++---------
>  1 file changed, 11 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/dma/qcom/bam_dma.c b/drivers/dma/qcom/bam_dma.c
> index 88579857ca1d..b3a34be63e99 100644
> --- a/drivers/dma/qcom/bam_dma.c
> +++ b/drivers/dma/qcom/bam_dma.c
> @@ -1350,7 +1350,7 @@ static int bam_dma_probe(struct platform_device *pdev)
>  	if (ret)
>  		goto err_unregister_dma;
>  
> -	if (bdev->controlled_remotely) {
> +	if (!bdev->bamclk) {
>  		pm_runtime_disable(&pdev->dev);
>  		return 0;
>  	}
> @@ -1438,10 +1438,10 @@ static int __maybe_unused bam_dma_suspend(struct device *dev)
>  {
>  	struct bam_device *bdev = dev_get_drvdata(dev);
>  
> -	if (!bdev->controlled_remotely)
> +	if (bdev->bamclk) {
>  		pm_runtime_force_suspend(dev);
> -
> -	clk_unprepare(bdev->bamclk);
> +		clk_unprepare(bdev->bamclk);
> +	}
>  
>  	return 0;
>  }
> @@ -1451,12 +1451,14 @@ static int __maybe_unused bam_dma_resume(struct device *dev)
>  	struct bam_device *bdev = dev_get_drvdata(dev);
>  	int ret;
>  
> -	ret = clk_prepare(bdev->bamclk);
> -	if (ret)
> -		return ret;
> +	if (bdev->bamclk) {
> +		ret = clk_prepare(bdev->bamclk);
> +		if (ret)
> +			return ret;
>  
> -	if (!bdev->controlled_remotely)
> -		pm_runtime_force_resume(dev);
> +		if (!bdev->controlled_remotely)

Why do we still need controlled_remotely check here?

Shawn

> +			pm_runtime_force_resume(dev);
> +	}
>  
>  	return 0;
>  }
> -- 
> 2.25.1
> 
