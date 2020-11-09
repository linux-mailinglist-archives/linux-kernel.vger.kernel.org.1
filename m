Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 687FB2AC623
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 21:47:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730008AbgKIUrB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 15:47:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729452AbgKIUrA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 15:47:00 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A397DC0613CF
        for <linux-kernel@vger.kernel.org>; Mon,  9 Nov 2020 12:47:00 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id r186so8177997pgr.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Nov 2020 12:47:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Iin0vDUK3sevQI2bAvaPfD3H/W4vZ+Pqy7XQDqW23fY=;
        b=DOFz7xZ/ueIU8DDLtiktNgoKvoTu7cz/YyeBYMzuuQFVEfvPWbAm8Djo1KFovcE1gU
         MG+zMJVNHqmMpmxbHm9g3E3Vqc3HnqQlL2YNtnbvK23DkvRKTUgGgOqFdUbDhlsZv4nf
         Ui8fDrJIbijZ+JqXK64ym4YMLl4X4bH5i0lcRED8B+ZnGjZK0QJ0lvwD8PDEJcYY7Ptg
         pJzjgrqN1sRaB0OZfukknG0QzBwzkK/oLsCC6M24Gh1p4+p1Ep8QKQRLa+y82/fu692e
         pvjW2sf4FhxhfuEcDrK7QXoULZDbNDEUumn1f65Ws+2CsTdmBnyuDaEuerVk0s5J3H6Y
         U3Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Iin0vDUK3sevQI2bAvaPfD3H/W4vZ+Pqy7XQDqW23fY=;
        b=jcxwCR9ZbyuYpDKBkWm7Ycg8rW4b7naWIqepuvyYhvxjg53cpkTjLeWS8KkARR/6Y1
         EC9PKdi5dzhhuhn1JRQaDlU8JKxBMC99gG/TDSpM9lc1NQXGWuUao7/xKl5drOWuCq7Z
         qNF6Z0az3YgwNn4ru9NlEk0X/xEftJUao9akyPlbhE6VbhyL1siojhYGRBqC+9pUVkA5
         inPwU/4lE4q0aOjJyFihcHksQA0ikw8DKzpw4TK/1tFDOH235AcA8Iu2nRM4zExNkrV2
         BeYoyBOKv5yUhUjDSIAlqS/FF7CSUChRjr2GCoTpVf0MYt0pKTLUSzLJuegnJRaxT56M
         noIw==
X-Gm-Message-State: AOAM530hWmCLkLqWmi1BysnEZ06Z5J6PmqNwMwZ2/NITZjCm2/WYb16X
        aMG+nbRkzo9q2X0ZJlpummVuzA==
X-Google-Smtp-Source: ABdhPJw2aEoDsjVndg890wcwXHA9V4CYUoL2EPjvRTtNqf6adlFuky9F0/slPmytSKWL4vBupYiCyQ==
X-Received: by 2002:a63:3202:: with SMTP id y2mr13744540pgy.97.1604954820247;
        Mon, 09 Nov 2020 12:47:00 -0800 (PST)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id a24sm12294500pfl.174.2020.11.09.12.46.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2020 12:46:59 -0800 (PST)
Date:   Mon, 9 Nov 2020 13:46:57 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, mike.leach@linaro.org,
        coresight@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 25/26] coresight: etm4x: Add support for sysreg only
 devices
Message-ID: <20201109204657.GD3396611@xps15>
References: <20201028220945.3826358-1-suzuki.poulose@arm.com>
 <20201028220945.3826358-27-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201028220945.3826358-27-suzuki.poulose@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 28, 2020 at 10:09:44PM +0000, Suzuki K Poulose wrote:
> Add support for devices with system instruction access only.
> They don't have a memory mapped interface and thus are not
> AMBA devices.
> 
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: Mike Leach <mike.leach@linaro.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  .../coresight/coresight-etm4x-core.c          | 50 +++++++++++++++++--
>  1 file changed, 45 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> index 25fab5513604..50a574228866 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> @@ -26,6 +26,7 @@
>  #include <linux/seq_file.h>
>  #include <linux/uaccess.h>
>  #include <linux/perf_event.h>
> +#include <linux/platform_device.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/property.h>
>  #include <asm/sections.h>
> @@ -1623,9 +1624,6 @@ static int etm4_probe(struct device *dev, void __iomem *base)
>  			return -ENOMEM;
>  	}
>  
> -	if (fwnode_property_present(dev_fwnode(dev), "qcom,skip-power-up"))
> -		drvdata->skip_power_up = true;
> -
>  	drvdata->base = base;
>  
>  	spin_lock_init(&drvdata->spinlock);
> @@ -1648,6 +1646,11 @@ static int etm4_probe(struct device *dev, void __iomem *base)
>  	if (!drvdata->arch)
>  		return -EINVAL;
>  
> +	/* Skip programming TRCPDCR for system instructions. */

It would be nice to mention that TRCPDCR is not available in system instruction
mode.

> +	if (!desc.access.io_mem ||
> +	    fwnode_property_present(dev_fwnode(dev), "qcom,skip-power-up"))
> +		drvdata->skip_power_up = true;
> +
>  	etm4_init_trace_id(drvdata);
>  	etm4_set_default(&drvdata->config);
>  
> @@ -1706,6 +1709,20 @@ static int etm4_probe_amba(struct amba_device *adev, const struct amba_id *id)
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
> +	ret = etm4_probe(&pdev->dev, NULL);
> +
> +	pm_runtime_put(&pdev->dev);
> +	return ret;
> +}
> +
>  static struct amba_cs_uci_id uci_id_etm4[] = {
>  	{
>  		/*  ETMv4 UCI data */
> @@ -1781,6 +1798,20 @@ static struct amba_driver etm4x_amba_driver = {
>  	.id_table	= etm4_ids,
>  };
>  
> +static const struct of_device_id etm_sysreg_match[] = {

s/etm_sysreg_match/etm4_sysreg_match

> +	{ .compatible	= "arm,coresight-etm-sysreg" },

See my comment in the next patch.

With the above:

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

> +	{}
> +};
> +
> +static struct platform_driver etm4_platform_driver = {
> +	.probe		= etm4_probe_platform_dev,
> +	.driver			= {
> +		.name			= "coresight-etm4x",
> +		.of_match_table		= etm_sysreg_match,
> +		.suppress_bind_attrs	= true,
> +	},
> +};
> +
>  static int __init etm4x_init(void)
>  {
>  	int ret;
> @@ -1793,10 +1824,19 @@ static int __init etm4x_init(void)
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
> -- 
> 2.24.1
> 
