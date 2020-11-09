Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A50722AC614
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 21:43:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729913AbgKIUnu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 15:43:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbgKIUnu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 15:43:50 -0500
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31128C0613CF
        for <linux-kernel@vger.kernel.org>; Mon,  9 Nov 2020 12:43:50 -0800 (PST)
Received: by mail-pl1-x641.google.com with SMTP id t6so5307465plq.11
        for <linux-kernel@vger.kernel.org>; Mon, 09 Nov 2020 12:43:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2o3jpI0FQrHtcHWDW1qDzIPliaaiJ7Npip1LYgFzqJI=;
        b=dn5MnfEbu8y3LW3TPYLY3VnN65Wn3bk1Mp3LlpSRsexiGcYuYKrhToFsoaUd3DiGCi
         dLvgvsHJDtBNPyOLuqPiRbujnblRVNw0bLABxpzcla7DQ/NypVVD7gHaIWY59yWTSkLa
         jLbqoPx6779284kH7NuBEFFzt6nSkTL8DJVpR/6ooEt4EQyFkEjWJQn9iPkLZ/SRFZtM
         +vnjNF4JQsjn66P+Wtrr8QEZ/0DeLuQwOnunV+zJNI0Ly2Oz+shyvoCVVoRaG8AexhSM
         DfduaH3Fc7XdV8o6AB4m+IwYuHr2Ke0dckxhmtgh/dWqrWIMq52FIHIIjjx6ogfuZsLj
         /0zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2o3jpI0FQrHtcHWDW1qDzIPliaaiJ7Npip1LYgFzqJI=;
        b=O8R6E8JqtrGnG3n7JTWqo81EvRQzETPDHr9wBJMA3Ae01wMMHgKcGMrUJ6qVPvb5ru
         qIXooV0dBZz6LfEcNGeWRa1BQInOcdyryGp1KbToutj+3GIagP4mHlmn2mNW08LXHKxT
         451nrHX8bIBXNemf4nc9tN/vRgnU1QsivrHcgH/lpV8fUtlHLxgx7kcDydKZRgsiAFBt
         NRBGBdUSkr0992lUXtsmOz6U6rSRo+gz3fPOVHAAe8x2HfLF0QaTDL2CXlfPUSEY5M2i
         70jZlVzO6Sw9f1gSSA+VD3Sc9yA0rhbV2iJVQeZchH0x8D7QwIMq5+IXRTDn+ss5swAa
         FmDQ==
X-Gm-Message-State: AOAM532f0DoKwV4cJk+x18CHh2VeoDeluVmhMctiW9pU27otaak9T2WM
        BNDG4egA+fmJ8VB1YXErgzlAtg==
X-Google-Smtp-Source: ABdhPJwxIB2fkv+Cv6Xd4g8hfOdmf24HogzPQWYOLYYBG7e4bCphm/NchKFP1mg/9CMahgWV4SKx3g==
X-Received: by 2002:a17:902:b192:b029:d7:ca4a:4ec1 with SMTP id s18-20020a170902b192b02900d7ca4a4ec1mr11750733plr.76.1604954629590;
        Mon, 09 Nov 2020 12:43:49 -0800 (PST)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id w22sm11107187pge.25.2020.11.09.12.43.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2020 12:43:49 -0800 (PST)
Date:   Mon, 9 Nov 2020 13:43:47 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, mike.leach@linaro.org,
        coresight@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 24/26] coresight: etm4x: Refactor probing routine
Message-ID: <20201109204347.GC3396611@xps15>
References: <20201028220945.3826358-1-suzuki.poulose@arm.com>
 <20201028220945.3826358-26-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201028220945.3826358-26-suzuki.poulose@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 28, 2020 at 10:09:43PM +0000, Suzuki K Poulose wrote:
> CoreSight ETM with system register access may not have a
> memory mapped i/o access. Refactor the ETM specific probing
> into a common routine to allow reusing the code for such ETMs.
> 
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: Mike Leach <mike.leach@linaro.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  .../coresight/coresight-etm4x-core.c          | 48 +++++++++++--------
>  1 file changed, 29 insertions(+), 19 deletions(-)

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

> 
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> index dc537b5612eb..25fab5513604 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> @@ -1598,14 +1598,11 @@ static void etm4_pm_clear(void)
>  	}
>  }
>  
> -static int etm4_probe(struct amba_device *adev, const struct amba_id *id)
> +static int etm4_probe(struct device *dev, void __iomem *base)
>  {
>  	int ret;
> -	void __iomem *base;
> -	struct device *dev = &adev->dev;
>  	struct coresight_platform_data *pdata = NULL;
>  	struct etmv4_drvdata *drvdata;
> -	struct resource *res = &adev->res;
>  	struct coresight_desc desc = { 0 };
>  	struct etm_init_arg init_arg = { 0 };
>  
> @@ -1629,11 +1626,6 @@ static int etm4_probe(struct amba_device *adev, const struct amba_id *id)
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
> @@ -1663,7 +1655,7 @@ static int etm4_probe(struct amba_device *adev, const struct amba_id *id)
>  	if (IS_ERR(pdata))
>  		return PTR_ERR(pdata);
>  
> -	adev->dev.platform_data = pdata;
> +	dev->platform_data = pdata;
>  
>  	desc.type = CORESIGHT_DEV_TYPE_SOURCE;
>  	desc.subtype.source_subtype = CORESIGHT_DEV_SUBTYPE_SOURCE_PROC;
> @@ -1683,7 +1675,6 @@ static int etm4_probe(struct amba_device *adev, const struct amba_id *id)
>  
>  	etmdrvdata[drvdata->cpu] = drvdata;
>  
> -	pm_runtime_put(&adev->dev);
>  	dev_info(&drvdata->csdev->dev, "CPU%d: ETM v%d.%d initialized\n",
>  		 drvdata->cpu, ETM_ARCH_MAJOR_VERSION(drvdata->arch),
>  		 ETM_ARCH_MINOR_VERSION(drvdata->arch));
> @@ -1696,6 +1687,25 @@ static int etm4_probe(struct amba_device *adev, const struct amba_id *id)
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
> @@ -1712,15 +1722,15 @@ static void __exit clear_etmdrvdata(void *info)
>  	etmdrvdata[cpu] = NULL;
>  }
>  
> -static int __exit etm4_remove(struct amba_device *adev)
> +static int __exit etm4_remove_amba(struct amba_device *adev)
>  {
>  	struct etmv4_drvdata *drvdata = dev_get_drvdata(&adev->dev);
>  
>  	etm_perf_symlink(drvdata->csdev, false);
>  
>  	/*
> -	 * Taking hotplug lock here to avoid racing between etm4_remove and
> -	 * CPU hotplug call backs.
> +	 * Taking hotplug lock here to avoid racing between etm4_remove_amba()
> +	 * and CPU hotplug call backs.
>  	 */
>  	cpus_read_lock();
>  	/*
> @@ -1760,14 +1770,14 @@ static const struct amba_id etm4_ids[] = {
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
> @@ -1781,7 +1791,7 @@ static int __init etm4x_init(void)
>  	if (ret)
>  		return ret;
>  
> -	ret = amba_driver_register(&etm4x_driver);
> +	ret = amba_driver_register(&etm4x_amba_driver);
>  	if (ret) {
>  		pr_err("Error registering etm4x driver\n");
>  		etm4_pm_clear();
> @@ -1792,7 +1802,7 @@ static int __init etm4x_init(void)
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
