Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C1052EEA7B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 01:40:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729593AbhAHAjM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 19:39:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727235AbhAHAjM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 19:39:12 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8144C0612F4
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jan 2021 16:38:31 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id b5so5206247pjl.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jan 2021 16:38:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7BrDWbaU7M4IhUHiUIN+sg1lcJNZeyjj5w02xt93uGA=;
        b=Trk5fD3NRVR2qXCdhNpKefNa/+fNCT6AjXKcPxxrAhCK+JNsuZvn/3cwqrnHER4bDH
         pfH/49pemwGqlqydQ+a5DLvbmb2+UezOnK+mWKXNMlTGEiVFRC+mVInAYlNSmchyphbu
         uHHCVHS63c6AnACPie79x6iFuMhuKU4s5KPYsgaDZpVe3/Y3xIjd13ak7O0/PLBuLFik
         SUcokOE4OQnhwe7vX8ab1Qptb3pE80kssCsbGvGQc0N8cLZ7NWi3p9l9IkYemYQoYUmW
         +nHVoKEK8Cqd4CvWR1ECugYshHsxbD+ZM4JGdlX04YlG+g3Ry0t5/UMoCGpTmFdTxZU6
         ZT0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7BrDWbaU7M4IhUHiUIN+sg1lcJNZeyjj5w02xt93uGA=;
        b=TcQqi8yySkJaCZCZmDKbNLglUqnYpq04N+6DLccCegWLBTWDui5TDj7GfuDfGAf4Mn
         8oAE1Ew/MYjcoolcrgYl6uSQM38uz3EsqkI1TNGS0Y4HjnaiJGcJnfuA0YSXbqLRpJWK
         u4fVMoPygEhTxpl83ArdK0VTuQqv5FuJPKvXCN2S8WVfCWhse3eoV7lLO9JyGtec2U8o
         fV43/qDDB0vp8ZCckqFZt7NudnhNGFwzIyqPTdUXSC0f4ugK8E8pBZHmXz/mGO7xMCG6
         VEeASZTRFGMp+uNpMSVpRrVl9eVZeUwYbGlgsJDd+mJUgqR72Wujwx9zn/qtA54NuBm9
         UL8Q==
X-Gm-Message-State: AOAM5304zimW3Pr6pitwJQEATdyoKg8/PyFX5z0bMQmXZO/DTqX7tlCm
        CLww60Yq87+hOHO0Rb+cGJjaLg==
X-Google-Smtp-Source: ABdhPJzlWIeRCrwrXupNXnaC1pGPC/d3pHGqLYUDlIPNxw5lg90Lw0tdpsJD15rGK07yKIRDim4auA==
X-Received: by 2002:a17:902:b717:b029:dc:3e69:6dd5 with SMTP id d23-20020a170902b717b02900dc3e696dd5mr1304505pls.70.1610066311330;
        Thu, 07 Jan 2021 16:38:31 -0800 (PST)
Received: from xps15 (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id w63sm6676089pfc.20.2021.01.07.16.38.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jan 2021 16:38:30 -0800 (PST)
Date:   Thu, 7 Jan 2021 17:38:28 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        coresight@lists.linaro.org, leo.yan@linaro.org,
        mike.leach@linaro.org, anshuman.khandual@arm.com
Subject: Re: [PATCH v6 21/26] coresight: etm4x: Refactor probing routine
Message-ID: <20210108003828.GE43045@xps15>
References: <20210107123859.674252-1-suzuki.poulose@arm.com>
 <20210107123859.674252-22-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210107123859.674252-22-suzuki.poulose@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 07, 2021 at 12:38:54PM +0000, Suzuki K Poulose wrote:
> CoreSight ETM with system register access may not have a
> memory mapped i/o access. Refactor the ETM specific probing
> into a common routine to allow reusing the code for such ETMs.
> 
> Cc: Mike Leach <mike.leach@linaro.org>
> Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

In V5 you told me to review this again...  I just did so at my tag stand.

> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
> Changes since v4:
>  - Refactor the "remove" callback for AMBA driver, for reuse by
>    platform_driver to follow
> ---
>  .../coresight/coresight-etm4x-core.c          | 62 ++++++++++++-------
>  1 file changed, 39 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> index f5bbb6131d77..228845f6fdd8 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> @@ -1708,14 +1708,11 @@ static void etm4_pm_clear(void)
>  	}
>  }
>  
> -static int etm4_probe(struct amba_device *adev, const struct amba_id *id)
> +static int etm4_probe(struct device *dev, void __iomem *base, u32 etm_pid)
>  {
>  	int ret;
> -	void __iomem *base;
> -	struct device *dev = &adev->dev;
>  	struct coresight_platform_data *pdata = NULL;
>  	struct etmv4_drvdata *drvdata;
> -	struct resource *res = &adev->res;
>  	struct coresight_desc desc = { 0 };
>  	struct etm4_init_arg init_arg = { 0 };
>  
> @@ -1739,11 +1736,6 @@ static int etm4_probe(struct amba_device *adev, const struct amba_id *id)
>  	if (fwnode_property_present(dev_fwnode(dev), "qcom,skip-power-up"))
>  		drvdata->skip_power_up = true;
>  
> -	/* Validity for the resource is already checked by the AMBA core */
> -	base = devm_ioremap_resource(dev, res);
> -	if (IS_ERR(base))
> -		return PTR_ERR(base);
> -
>  	drvdata->base = base;
>  
>  	spin_lock_init(&drvdata->spinlock);
> @@ -1773,7 +1765,7 @@ static int etm4_probe(struct amba_device *adev, const struct amba_id *id)
>  	if (IS_ERR(pdata))
>  		return PTR_ERR(pdata);
>  
> -	adev->dev.platform_data = pdata;
> +	dev->platform_data = pdata;
>  
>  	desc.type = CORESIGHT_DEV_TYPE_SOURCE;
>  	desc.subtype.source_subtype = CORESIGHT_DEV_SUBTYPE_SOURCE_PROC;
> @@ -1793,7 +1785,6 @@ static int etm4_probe(struct amba_device *adev, const struct amba_id *id)
>  
>  	etmdrvdata[drvdata->cpu] = drvdata;
>  
> -	pm_runtime_put(&adev->dev);
>  	dev_info(&drvdata->csdev->dev, "CPU%d: ETM v%d.%d initialized\n",
>  		 drvdata->cpu, ETM_ARCH_MAJOR_VERSION(drvdata->arch),
>  		 ETM_ARCH_MINOR_VERSION(drvdata->arch));
> @@ -1803,11 +1794,30 @@ static int etm4_probe(struct amba_device *adev, const struct amba_id *id)
>  		drvdata->boot_enable = true;
>  	}
>  
> -	etm4_check_arch_features(drvdata, id->id);
> +	etm4_check_arch_features(drvdata, etm_pid);
>  
>  	return 0;
>  }
>  
> +static int etm4_probe_amba(struct amba_device *adev, const struct amba_id *id)
> +{
> +	void __iomem *base;
> +	struct device *dev = &adev->dev;
> +	struct resource *res = &adev->res;
> +	int ret;
> +
> +	/* Validity for the resource is already checked by the AMBA core */
> +	base = devm_ioremap_resource(dev, res);
> +	if (IS_ERR(base))
> +		return PTR_ERR(base);
> +
> +	ret = etm4_probe(dev, base, id->id);
> +	if (!ret)
> +		pm_runtime_put(&adev->dev);
> +
> +	return ret;
> +}
> +
>  static struct amba_cs_uci_id uci_id_etm4[] = {
>  	{
>  		/*  ETMv4 UCI data */
> @@ -1824,15 +1834,12 @@ static void clear_etmdrvdata(void *info)
>  	etmdrvdata[cpu] = NULL;
>  }
>  
> -static int etm4_remove(struct amba_device *adev)
> +static int __exit etm4_remove_dev(struct etmv4_drvdata *drvdata)
>  {
> -	struct etmv4_drvdata *drvdata = dev_get_drvdata(&adev->dev);
> -
>  	etm_perf_symlink(drvdata->csdev, false);
> -
>  	/*
> -	 * Taking hotplug lock here to avoid racing between etm4_remove and
> -	 * CPU hotplug call backs.
> +	 * Taking hotplug lock here to avoid racing between etm4_remove_dev()
> +	 * and CPU hotplug call backs.
>  	 */
>  	cpus_read_lock();
>  	/*
> @@ -1851,6 +1858,15 @@ static int etm4_remove(struct amba_device *adev)
>  	return 0;
>  }
>  
> +static int __exit etm4_remove_amba(struct amba_device *adev)
> +{
> +	struct etmv4_drvdata *drvdata = dev_get_drvdata(&adev->dev);
> +
> +	if (drvdata)
> +		return etm4_remove_dev(drvdata);
> +	return 0;
> +}
> +
>  static const struct amba_id etm4_ids[] = {
>  	CS_AMBA_ID(0x000bb95d),			/* Cortex-A53 */
>  	CS_AMBA_ID(0x000bb95e),			/* Cortex-A57 */
> @@ -1872,14 +1888,14 @@ static const struct amba_id etm4_ids[] = {
>  
>  MODULE_DEVICE_TABLE(amba, etm4_ids);
>  
> -static struct amba_driver etm4x_driver = {
> +static struct amba_driver etm4x_amba_driver = {
>  	.drv = {
>  		.name   = "coresight-etm4x",
>  		.owner  = THIS_MODULE,
>  		.suppress_bind_attrs = true,
>  	},
> -	.probe		= etm4_probe,
> -	.remove         = etm4_remove,
> +	.probe		= etm4_probe_amba,
> +	.remove         = etm4_remove_amba,
>  	.id_table	= etm4_ids,
>  };
>  
> @@ -1893,7 +1909,7 @@ static int __init etm4x_init(void)
>  	if (ret)
>  		return ret;
>  
> -	ret = amba_driver_register(&etm4x_driver);
> +	ret = amba_driver_register(&etm4x_amba_driver);
>  	if (ret) {
>  		pr_err("Error registering etm4x driver\n");
>  		etm4_pm_clear();
> @@ -1904,7 +1920,7 @@ static int __init etm4x_init(void)
>  
>  static void __exit etm4x_exit(void)
>  {
> -	amba_driver_unregister(&etm4x_driver);
> +	amba_driver_unregister(&etm4x_amba_driver);
>  	etm4_pm_clear();
>  }
>  
> -- 
> 2.24.1
> 
