Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E31332A4DC9
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 19:04:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728855AbgKCSEC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 13:04:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727688AbgKCSEB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 13:04:01 -0500
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA5C4C0613D1
        for <linux-kernel@vger.kernel.org>; Tue,  3 Nov 2020 10:04:01 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id t14so14300033pgg.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Nov 2020 10:04:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=eYEcKeGaEtZ9zZmugfVVOA+TtHVoaqu4rWB1l432yS8=;
        b=kN3nTRqzozLcJv+vSGfDOB3MRpgY5uiFC+9Xvh7nSMexLfoLgnoxlWP1WSkoL/bcFM
         z/6N9fEFgW7vMaF096I8sr5KkE/de4r/Zhrfv49Ea5ZipVQufBl4O2HnLMfkmodXgHdJ
         VIR1XaQ+s9bdGCKd5xVDE31JdbbXMEmEcqgzD7fvloou0wcI2jaq75a16fjwhVEI2zis
         t0994ul7Vj35N4ybheOoPAUZzeggS0J7WTa432Y7FnM1eKpFbKOPSr14qXa1LLbcNgm1
         FwJ4YtODOnLXMKkf2xBxJZ7Mm8GhO04a43dYPd6dE9gbzTJep25atbMn7wKGQoaUH/lb
         On9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eYEcKeGaEtZ9zZmugfVVOA+TtHVoaqu4rWB1l432yS8=;
        b=C3Wj3q8JJ9q+U81tha1C/UGDIY/f9nDQv/p/4pIcWmQdVV+XeXOq6fCSvkZw82AjNS
         6ejv5McxQPhYrgk9Wjvayx0eWMWuuO3xj8KznPWmLf4brbJ4gbSPdxw84lGB8GuWlOsr
         /32vP37VOCOPPk360ABDT+a94TlNld5CIIEs73U1WeEO6x8YfYR5/LZV6ct93XutaIaP
         gAeEkBTN0FOcnXPMDZVsf0k/yYaEK4F4giSrF9q/KqabZ6liYC1wjg+phl84rA0MfwML
         QEgwVcOynz5zABPHItsW1Gfs6OIkG++mM0fldtqM+uKVMtq7dkGK08bY18jA5gU+iwd7
         5D0g==
X-Gm-Message-State: AOAM530nwx/MLQCrmDDp1nqhAvffknvjVHK660ZQhNk4KZHT/OQkLj7I
        SRe7qYCv7bN5fQGF4Vij4D7OGw==
X-Google-Smtp-Source: ABdhPJxJUwHsVoHb8HmtWX8jqU8vQFKcfwsrEIZSv27of9zYUNhYzy1IudadB/UAjQ9coNtX7Xud8g==
X-Received: by 2002:a63:1d53:: with SMTP id d19mr18352187pgm.289.1604426641178;
        Tue, 03 Nov 2020 10:04:01 -0800 (PST)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id n15sm17256727pgt.75.2020.11.03.10.04.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2020 10:04:00 -0800 (PST)
Date:   Tue, 3 Nov 2020 11:03:58 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, mike.leach@linaro.org,
        coresight@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 08/26] coresight: tpiu: Prepare for using coresight
 device access abstraction
Message-ID: <20201103180358.GC2855763@xps15>
References: <20201028220945.3826358-1-suzuki.poulose@arm.com>
 <20201028220945.3826358-10-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201028220945.3826358-10-suzuki.poulose@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 28, 2020 at 10:09:27PM +0000, Suzuki K Poulose wrote:
> Prepare the TPIU driver to make use of the CoreSight device access
> abstraction layer. The driver touches the device even before the
> coresight device is registered. Thus we could be accessing the
> devices without a csdev. As we are about to use the abstraction
> layer for accessing the device, pass in the access directly
> to avoid having to deal with the un-initialised csdev.
> 
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: Mike Leach <mike.leach@linaro.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  drivers/hwtracing/coresight/coresight-tpiu.c | 30 +++++++++-----------
>  1 file changed, 13 insertions(+), 17 deletions(-)

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

> 
> diff --git a/drivers/hwtracing/coresight/coresight-tpiu.c b/drivers/hwtracing/coresight/coresight-tpiu.c
> index dfa3b91d0281..98c4a029854c 100644
> --- a/drivers/hwtracing/coresight/coresight-tpiu.c
> +++ b/drivers/hwtracing/coresight/coresight-tpiu.c
> @@ -60,49 +60,45 @@ struct tpiu_drvdata {
>  	struct coresight_device	*csdev;
>  };
>  
> -static void tpiu_enable_hw(struct tpiu_drvdata *drvdata)
> +static void tpiu_enable_hw(struct csdev_access *csa)
>  {
> -	CS_UNLOCK(drvdata->base);
> +	CS_UNLOCK(csa->base);
>  
>  	/* TODO: fill this up */
>  
> -	CS_LOCK(drvdata->base);
> +	CS_LOCK(csa->base);
>  }
>  
>  static int tpiu_enable(struct coresight_device *csdev, u32 mode, void *__unused)
>  {
> -	struct tpiu_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
> -
> -	tpiu_enable_hw(drvdata);
> +	tpiu_enable_hw(&csdev->access);
>  	atomic_inc(csdev->refcnt);
>  	dev_dbg(&csdev->dev, "TPIU enabled\n");
>  	return 0;
>  }
>  
> -static void tpiu_disable_hw(struct tpiu_drvdata *drvdata)
> +static void tpiu_disable_hw(struct csdev_access *csa)
>  {
> -	CS_UNLOCK(drvdata->base);
> +	CS_UNLOCK(csa->base);
>  
>  	/* Clear formatter and stop on flush */
> -	writel_relaxed(FFCR_STOP_FI, drvdata->base + TPIU_FFCR);
> +	csdev_access_relaxed_write32(csa, FFCR_STOP_FI, TPIU_FFCR);
>  	/* Generate manual flush */
> -	writel_relaxed(FFCR_STOP_FI | FFCR_FON_MAN, drvdata->base + TPIU_FFCR);
> +	csdev_access_relaxed_write32(csa, FFCR_STOP_FI | FFCR_FON_MAN, TPIU_FFCR);
>  	/* Wait for flush to complete */
> -	coresight_timeout(drvdata->base, TPIU_FFCR, FFCR_FON_MAN_BIT, 0);
> +	coresight_timeout(csa->base, TPIU_FFCR, FFCR_FON_MAN_BIT, 0);
>  	/* Wait for formatter to stop */
> -	coresight_timeout(drvdata->base, TPIU_FFSR, FFSR_FT_STOPPED_BIT, 1);
> +	coresight_timeout(csa->base, TPIU_FFSR, FFSR_FT_STOPPED_BIT, 1);
>  
> -	CS_LOCK(drvdata->base);
> +	CS_LOCK(csa->base);
>  }
>  
>  static int tpiu_disable(struct coresight_device *csdev)
>  {
> -	struct tpiu_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
> -
>  	if (atomic_dec_return(csdev->refcnt))
>  		return -EBUSY;
>  
> -	tpiu_disable_hw(drvdata);
> +	tpiu_disable_hw(&csdev->access);
>  
>  	dev_dbg(&csdev->dev, "TPIU disabled\n");
>  	return 0;
> @@ -152,7 +148,7 @@ static int tpiu_probe(struct amba_device *adev, const struct amba_id *id)
>  	desc.access = CSDEV_ACCESS_IOMEM(base);
>  
>  	/* Disable tpiu to support older devices */
> -	tpiu_disable_hw(drvdata);
> +	tpiu_disable_hw(&desc.access);
>  
>  	pdata = coresight_get_platform_data(dev);
>  	if (IS_ERR(pdata))
> -- 
> 2.24.1
> 
