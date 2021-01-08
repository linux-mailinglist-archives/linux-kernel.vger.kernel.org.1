Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 652EB2EEA9C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 01:56:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729724AbhAHA4N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 19:56:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729502AbhAHA4N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 19:56:13 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBA45C0612F6
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jan 2021 16:55:32 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id 30so6540649pgr.6
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jan 2021 16:55:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Mzp+TKeYFNUCiao7ntDagpd86LmNj82kXWV1cqQ1gNI=;
        b=JeJ1X0pCi75b4g3kj1TGG6/QZXo7nahPOMSU99vr/5fWNWQzc8j8qvv5Abn/cPgiMe
         29wPh9yxax0MhLxicw0fS9B4dACTTtrPJURsBfa8BFNFgE8VxoZglovipeft/ILmyiS9
         ntuNx5mysRoXl6Lb/CHC4FHcTrsBzs8KgARelCj2SIqGaWInEj6XUjIftItKoO9k9zmm
         IOH24gnezg8of17ZuvACN2z9DghDEULLUHTCdOWS+2dENlTITRPRIDF+tLkEeGzARXVG
         IreZ/WS0k5u8Vz89TMPxcfX+C332ScQR2AwQBmlUqPRnRqNI5FKxr5g07njeH+pT04Al
         wU8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Mzp+TKeYFNUCiao7ntDagpd86LmNj82kXWV1cqQ1gNI=;
        b=WhSMJPqdcsrawavkaiaem70/A/7chrRzBHrKPLYgILr4PNLlciTwHA8zI2xU4wzTGq
         iSjOkzI+l+TXsUBidqYSvj48mBgelexMSVBWl96mQvDpPfJW9NWaje5D31lDXDaQQp35
         T+F3bJxfV0W5gc4JwZrw0Ul/mHWWGGAJ3ipJkiLSxTbCUY1c2EsVV+oIjwLnDHvVrKug
         xYYheTN5PejXv/HSCR3kSUnAGQ5wixzjJdtIUOg1NYdF6KU+NhFPm4gmjAGPNyGcbeAF
         KaZ4N5fv1pfxQgGL0/itOQJZ76qs9uRJox29hsofHG5nUYpZ35ZZ2onD1zgUzKEqHj82
         K18A==
X-Gm-Message-State: AOAM530kq02YzNNwYtUZesdbqehqb9XYw8gZl3/Epv9qwpVrk26dANl4
        6eBPxIHTwTyR2F3zWtO6fYSoY81v/xi+QQ==
X-Google-Smtp-Source: ABdhPJzrM7Mp9eqqFecmQeZMe9QR7J6u4/eKLpiMSe8b2309T4WQ1gv3hByU9Msd3unojKGQQrZNLg==
X-Received: by 2002:a63:1322:: with SMTP id i34mr4417255pgl.282.1610067332432;
        Thu, 07 Jan 2021 16:55:32 -0800 (PST)
Received: from xps15 (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id x15sm6524892pfn.118.2021.01.07.16.55.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jan 2021 16:55:31 -0800 (PST)
Date:   Thu, 7 Jan 2021 17:55:30 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        coresight@lists.linaro.org, leo.yan@linaro.org,
        mike.leach@linaro.org, anshuman.khandual@arm.com
Subject: Re: [PATCH v6 23/26] coresight: etm4x: Add support for sysreg only
 devices
Message-ID: <20210108005530.GG43045@xps15>
References: <20210107123859.674252-1-suzuki.poulose@arm.com>
 <20210107123859.674252-24-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210107123859.674252-24-suzuki.poulose@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 07, 2021 at 12:38:56PM +0000, Suzuki K Poulose wrote:
> Add support for devices with system instruction access only.
> They don't have a memory mapped interface and thus are not
> AMBA devices. System register access is not permitted to
> TRCPDCR and thus skip access to them.
> 
> Cc: Mike Leach <mike.leach@linaro.org>
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
> Changes since v5:
>  - Rebased to accommodate check_arch_features().
>    Added comments to explain why we don't pass PID for system
>    register based devices.
> Changes since v4
>  - Add "remove" callback for platform_driver.
>  - Dropped Reviewed-by tag from Mathieu due to the above
> 
> Changes since v3
>  - Improve comment over "TRCPDCR" usage with sysreg
>  - Rename etm_xx => etm4_xx
>  - Update the compatible to "arm,coresight-etm4x-sysreg"
> ---
>  .../coresight/coresight-etm4x-core.c          | 68 +++++++++++++++++--
>  1 file changed, 63 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> index f4fbb65b4cc1..34a6cdff75e7 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> @@ -27,6 +27,7 @@
>  #include <linux/seq_file.h>
>  #include <linux/uaccess.h>
>  #include <linux/perf_event.h>
> +#include <linux/platform_device.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/property.h>
>  
> @@ -1736,9 +1737,6 @@ static int etm4_probe(struct device *dev, void __iomem *base, u32 etm_pid)
>  			return -ENOMEM;
>  	}
>  
> -	if (fwnode_property_present(dev_fwnode(dev), "qcom,skip-power-up"))
> -		drvdata->skip_power_up = true;
> -
>  	drvdata->base = base;
>  
>  	spin_lock_init(&drvdata->spinlock);
> @@ -1762,6 +1760,11 @@ static int etm4_probe(struct device *dev, void __iomem *base, u32 etm_pid)
>  	if (!drvdata->arch)
>  		return -EINVAL;
>  
> +	/* TRCPDCR is not accessible with system instructions. */
> +	if (!desc.access.io_mem ||
> +	    fwnode_property_present(dev_fwnode(dev), "qcom,skip-power-up"))
> +		drvdata->skip_power_up = true;
> +
>  	etm4_init_trace_id(drvdata);
>  	etm4_set_default(&drvdata->config);
>  
> @@ -1820,6 +1823,25 @@ static int etm4_probe_amba(struct amba_device *adev, const struct amba_id *id)
>  	return ret;
>  }
>  
> +static int etm4_probe_platform_dev(struct platform_device *pdev)
> +{
> +	int ret;
> +
> +	pm_runtime_get_noresume(&pdev->dev);
> +	pm_runtime_set_active(&pdev->dev);
> +	pm_runtime_enable(&pdev->dev);
> +
> +	/*
> +	 * System register based devices could match the
> +	 * HW by reading appropriate registers on the HW
> +	 * and thus we could skip the PID.
> +	 */
> +	ret = etm4_probe(&pdev->dev, NULL, 0);
> +
> +	pm_runtime_put(&pdev->dev);
> +	return ret;
> +}
> +
>  static struct amba_cs_uci_id uci_id_etm4[] = {
>  	{
>  		/*  ETMv4 UCI data */
> @@ -1869,6 +1891,17 @@ static int __exit etm4_remove_amba(struct amba_device *adev)
>  	return 0;
>  }
>  
> +static int __exit etm4_remove_platform_dev(struct platform_device *pdev)
> +{
> +	int ret = 0;
> +	struct etmv4_drvdata *drvdata = dev_get_drvdata(&pdev->dev);
> +
> +	if (drvdata)
> +		ret = etm4_remove_dev(drvdata);
> +	pm_runtime_disable(&pdev->dev);
> +	return ret;
> +}
> +
>  static const struct amba_id etm4_ids[] = {
>  	CS_AMBA_ID(0x000bb95d),			/* Cortex-A53 */
>  	CS_AMBA_ID(0x000bb95e),			/* Cortex-A57 */
> @@ -1901,6 +1934,21 @@ static struct amba_driver etm4x_amba_driver = {
>  	.id_table	= etm4_ids,
>  };
>  
> +static const struct of_device_id etm4_sysreg_match[] = {
> +	{ .compatible	= "arm,coresight-etm4x-sysreg" },
> +	{}
> +};
> +
> +static struct platform_driver etm4_platform_driver = {
> +	.probe		= etm4_probe_platform_dev,
> +	.remove		= etm4_remove_platform_dev,
> +	.driver			= {
> +		.name			= "coresight-etm4x",
> +		.of_match_table		= etm4_sysreg_match,
> +		.suppress_bind_attrs	= true,
> +	},
> +};
> +
>  static int __init etm4x_init(void)
>  {
>  	int ret;
> @@ -1913,16 +1961,26 @@ static int __init etm4x_init(void)
>  
>  	ret = amba_driver_register(&etm4x_amba_driver);
>  	if (ret) {
> -		pr_err("Error registering etm4x driver\n");
> -		etm4_pm_clear();
> +		pr_err("Error registering etm4x AMBA driver\n");
> +		goto clear_pm;
>  	}
>  
> +	ret = platform_driver_register(&etm4_platform_driver);
> +	if (!ret)
> +		return 0;
> +
> +	pr_err("Error registering etm4x platform driver\n");
> +	amba_driver_unregister(&etm4x_amba_driver);
> +
> +clear_pm:
> +	etm4_pm_clear();
>  	return ret;
>  }
>  
>  static void __exit etm4x_exit(void)
>  {
>  	amba_driver_unregister(&etm4x_amba_driver);
> +	platform_driver_unregister(&etm4_platform_driver);

Good catch.

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

>  	etm4_pm_clear();
>  }
>  
> -- 
> 2.24.1
> 
