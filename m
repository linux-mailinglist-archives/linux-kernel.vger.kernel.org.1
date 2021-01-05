Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE4732EB504
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 22:47:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731573AbhAEVpP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 16:45:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731554AbhAEVpO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 16:45:14 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FC02C0617A0
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jan 2021 13:44:14 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id t22so517323pfl.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jan 2021 13:44:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NwFxWchxK+9q/lw5BsjyZ2MIIGZIQylr+hrEjtL9KKU=;
        b=LIKDqWU4UOYxfB2A57EAwB7Tdv3pVXY9jiD6SiElP+lLjSIvOnh8mlOHlfXQaThRSE
         YYMdiiaJyqI/H+MjRLcT0g47OpEHL+97eu8/NF4oKd66E7g4daOwifLDYGldLlTaOKtJ
         LZzlAP/KZHDlpBCkAE1DDeUeuG5sxNR2frs88x8/PMMqAyYYcA/f8GdF54pbwuTFWVYf
         Zb/tZAQ76mWDZuXmw1nkuH4J/N/iAgnbDEqZ1skBvoSqM5+2hPjMD6c1EmUr/zLz02ew
         GAlk6CW8/VwrfMuerN//uzBHmcJgcn0qmvKd5onMtxf3ORYocTd6r1bxUPa+K/QIB1zI
         sniQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NwFxWchxK+9q/lw5BsjyZ2MIIGZIQylr+hrEjtL9KKU=;
        b=fb/gUK10fdXfTSrnJJhzhOkLZYI9c93lHmipg2SiXxgPqvuuIYQCVXyX5gZ1DEtn+O
         NJLZyDLwCXKVAIN2+ZFI39ReY3bMHI2mYzHR5tTidgt4XOxYmLBACs/JNGqEoA+Ccw9/
         Z71bhrsBgCyojS3RSTM3sAv7E9KJeVBP6LvubG/rwdTe9W6IgmZ4MLq4Xrv3vy+gAo0K
         zrXtaRp4Bxo5GqyupjcSziZ0PzF1cmYGeZtpfgaS5V6VRmq/cZovhZDOg6LCM/+TIHQl
         Fb1sssI2JM7d44xqOBRW+wYybWQNoRz+cxyZ9wF27E3ekaEgMMG5tuWKead41iaS5mhO
         oQhw==
X-Gm-Message-State: AOAM531ctSNPwoKvgWqoHOvyQSWXJkjFU0rWz0jdaBH2AoMtn6TyxmVo
        ax1Kcv8HnFpAGRj0GlRKXES5bQ==
X-Google-Smtp-Source: ABdhPJw0lapnq0hCUTRBKepVSqNhYwqAHIH3awvJBgb5qA8ejoVN2VnRV4RNJ481p4t0fC46EoA2AQ==
X-Received: by 2002:a65:6405:: with SMTP id a5mr1136989pgv.389.1609883053575;
        Tue, 05 Jan 2021 13:44:13 -0800 (PST)
Received: from xps15 (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id b129sm146991pgc.52.2021.01.05.13.44.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jan 2021 13:44:12 -0800 (PST)
Date:   Tue, 5 Jan 2021 14:44:10 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        catalin.marinas@arm.com, mike.leach@linaro.org, leo.yan@linaro.org,
        jonathan.zhouwen@huawei.com
Subject: Re: [PATCH v5 21/25] coresight: etm4x: Refactor probing routine
Message-ID: <20210105214410.GA2789330@xps15>
References: <20201214173731.302520-1-suzuki.poulose@arm.com>
 <20201214173731.302520-22-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201214173731.302520-22-suzuki.poulose@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Suzuki,

On Mon, Dec 14, 2020 at 05:37:27PM +0000, Suzuki K Poulose wrote:
> CoreSight ETM with system register access may not have a
> memory mapped i/o access. Refactor the ETM specific probing
> into a common routine to allow reusing the code for such ETMs.
> 
> Cc: Mike Leach <mike.leach@linaro.org>
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
> Changes since v4:
>  - Refactor the "remove" callback for AMBA driver, for reuse by
>    platform_driver to follow
>  - Removed Reviewed-by from Mathieu, due to the above
> ---
>  .../coresight/coresight-etm4x-core.c          | 60 ++++++++++++-------
>  1 file changed, 38 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> index 25eb42c95527..89bb5a424a2b 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> @@ -1610,14 +1610,11 @@ static void etm4_pm_clear(void)
>  	}
>  }
>  
> -static int etm4_probe(struct amba_device *adev, const struct amba_id *id)
> +static int etm4_probe(struct device *dev, void __iomem *base)

Please rebase this set to the latest coresight-next (new location on
git.kernel.org).  There is about half a dozen patches that don't apply anymore,
including this one where remove @id results in a compilation error due to Liu's
changes.

Thanks,
Mathieu

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
> @@ -1641,11 +1638,6 @@ static int etm4_probe(struct amba_device *adev, const struct amba_id *id)
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
> @@ -1675,7 +1667,7 @@ static int etm4_probe(struct amba_device *adev, const struct amba_id *id)
>  	if (IS_ERR(pdata))
>  		return PTR_ERR(pdata);
>  
> -	adev->dev.platform_data = pdata;
> +	dev->platform_data = pdata;
>  
>  	desc.type = CORESIGHT_DEV_TYPE_SOURCE;
>  	desc.subtype.source_subtype = CORESIGHT_DEV_SUBTYPE_SOURCE_PROC;
> @@ -1695,7 +1687,6 @@ static int etm4_probe(struct amba_device *adev, const struct amba_id *id)
>  
>  	etmdrvdata[drvdata->cpu] = drvdata;
>  
> -	pm_runtime_put(&adev->dev);
>  	dev_info(&drvdata->csdev->dev, "CPU%d: ETM v%d.%d initialized\n",
>  		 drvdata->cpu, ETM_ARCH_MAJOR_VERSION(drvdata->arch),
>  		 ETM_ARCH_MINOR_VERSION(drvdata->arch));
> @@ -1708,6 +1699,25 @@ static int etm4_probe(struct amba_device *adev, const struct amba_id *id)
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
> +	ret = etm4_probe(dev, base);
> +	if (!ret)
> +		pm_runtime_put(&adev->dev);
> +
> +	return ret;
> +}
> +
>  static struct amba_cs_uci_id uci_id_etm4[] = {
>  	{
>  		/*  ETMv4 UCI data */
> @@ -1724,15 +1734,12 @@ static void clear_etmdrvdata(void *info)
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
> @@ -1751,6 +1758,15 @@ static int etm4_remove(struct amba_device *adev)
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
> @@ -1772,14 +1788,14 @@ static const struct amba_id etm4_ids[] = {
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
> @@ -1793,7 +1809,7 @@ static int __init etm4x_init(void)
>  	if (ret)
>  		return ret;
>  
> -	ret = amba_driver_register(&etm4x_driver);
> +	ret = amba_driver_register(&etm4x_amba_driver);
>  	if (ret) {
>  		pr_err("Error registering etm4x driver\n");
>  		etm4_pm_clear();
> @@ -1804,7 +1820,7 @@ static int __init etm4x_init(void)
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
