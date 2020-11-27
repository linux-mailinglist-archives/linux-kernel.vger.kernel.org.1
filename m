Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DCFB2C6B96
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 19:29:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727736AbgK0S2l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 13:28:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726316AbgK0S2k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 13:28:40 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B39E0C0613D1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 10:28:40 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id w16so4931087pga.9
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 10:28:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=eKW8WcVr/82nRiyRTpfMhfTMZLPFWsp5WF0w44m48Do=;
        b=RxhiPbiMBG4sV1g/h2LTHaabzdqwB9d0nH1X3rxVZPG+erpd63gwIdbYKXEpvUb5mm
         SrpEOJVmIFw2/Zu5/UoTnkbmM1L1JwfoMNdNRx0LkXLUnUut5WLW+tjEVX6genvWAcn8
         gNh94n9FCUZGcmCMihTg8xHf3hb0mA4KRaDjg9UFr3ZyN8Wh+jZC2Eh3MmPsiWvhQLVf
         o+5e2PiH3PRyWp7nSK+Gyn/D/+vUjaA1CxWUgLFfCH+1LghL2KD43y3xUJyFTN1LjQ9v
         QwyCS0qB6ZaiJqB/wg7hSrEb7CGqxRlXbT4J99+8w0x46WoAme+pOCYcf4G9mZPIYFGr
         fB1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eKW8WcVr/82nRiyRTpfMhfTMZLPFWsp5WF0w44m48Do=;
        b=Y0XnJ6BI0eIy7zuwygwOs/oKm1FOvFVYn91+Lhn1q4LNJuM03NGJYncCQKePezZW3b
         2WlKJ67MdOoFFs7PATV3oQyEaz5DF6e9zhwFPYWN5Z4hOEA2SYUP8/3kM2UbRN8moqDK
         jV6qxRAh73kHBdk+Rir8tL5vd63AgXfkqaxLBxJTccy2AJadnXfHeCBJO1ZcqbDiREOv
         xwEa6qzpGPuCQqWoESzr//MiwcV4KQN0bmVCRuiDQsSFhceFTmx83MmmcI8nV9lOHN1e
         FGHrFGh7Ej/XLTCnpNYUyAUY+v0nZixF86z8QicOf9B75qztsodmqTjQ5+UbvhnCOPo0
         uzrg==
X-Gm-Message-State: AOAM5331qUUL63uKAiP3zIO2bVo/cI4FZQZNvJRp7uJVUdmTJOig/jYY
        0yprr6TaNWLIkAEgtFB7pihqTQ==
X-Google-Smtp-Source: ABdhPJz+wBRQKXG3yFLkcMzsZt1QjJENUfb856if2lYxObUBKR4Xsub5c+GPqPgyNrAkKLPE0wDa2w==
X-Received: by 2002:a17:90b:1901:: with SMTP id mp1mr8588154pjb.233.1606501720301;
        Fri, 27 Nov 2020 10:28:40 -0800 (PST)
Received: from xps15 (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id g5sm11503187pju.9.2020.11.27.10.28.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2020 10:28:39 -0800 (PST)
Date:   Fri, 27 Nov 2020 11:28:37 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, mike.leach@linaro.org,
        linux-kernel@vger.kernel.org, anshuman.khandual@arm.com,
        jonathan.zhouwen@huawei.com, coresight@lists.linaro.org
Subject: Re: [PATCH v4 17/25] coresight: etm4x: Use TRCDEVARCH for component
 discovery
Message-ID: <20201127182837.GA1092947@xps15>
References: <20201119164547.2982871-1-suzuki.poulose@arm.com>
 <20201119164547.2982871-18-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201119164547.2982871-18-suzuki.poulose@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 19, 2020 at 04:45:39PM +0000, Suzuki K Poulose wrote:
> We have been using TRCIDR1 for detecting the ETM version. This
> is in preparation for the future IP support.
> 
> Cc: Mike Leach <mike.leach@linaro.org>
> Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>

You have reviewed your own code - that's great!

I had a good giggle on that one.  I have started reviewing this set...

> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  .../coresight/coresight-etm4x-core.c          | 46 +++++++++----------
>  1 file changed, 23 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> index d3b009c3724e..f1908e6f2180 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> @@ -150,18 +150,6 @@ static void etm4_cs_unlock(struct etmv4_drvdata *drvdata,
>  		CS_UNLOCK(csa->base);
>  }
>  
> -static bool etm4_arch_supported(u8 arch)
> -{
> -	/* Mask out the minor version number */
> -	switch (arch & 0xf0) {
> -	case ETM_ARCH_V4:
> -		break;
> -	default:
> -		return false;
> -	}
> -	return true;
> -}
> -
>  static int etm4_cpu_id(struct coresight_device *csdev)
>  {
>  	struct etmv4_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
> @@ -686,6 +674,26 @@ static const struct coresight_ops etm4_cs_ops = {
>  static bool etm4_init_iomem_access(struct etmv4_drvdata *drvdata,
>  				   struct csdev_access *csa)
>  {
> +	u32 devarch = readl_relaxed(drvdata->base + TRCDEVARCH);
> +	u32 idr1 = readl_relaxed(drvdata->base + TRCIDR1);
> +
> +	/*
> +	 * All ETMs must implement TRCDEVARCH to indicate that
> +	 * the component is an ETMv4. To support any broken
> +	 * implementations we fall back to TRCIDR1 check, which
> +	 * is not really reliable.
> +	 */
> +	if ((devarch & ETM_DEVARCH_ID_MASK) == ETM_DEVARCH_ETMv4x_ARCH) {
> +		drvdata->arch = etm_devarch_to_arch(devarch);
> +	} else {
> +		pr_warn("CPU%d: ETM4x incompatible TRCDEVARCH: %x, falling back to TRCIDR1\n",
> +			smp_processor_id(), devarch);
> +
> +		if (ETM_TRCIDR1_ARCH_MAJOR(idr1) != ETM_TRCIDR1_ARCH_ETMv4)
> +			return false;
> +		drvdata->arch = etm_trcidr_to_arch(idr1);
> +	}
> +
>  	*csa = CSDEV_ACCESS_IOMEM(drvdata->base);
>  	return true;
>  }
> @@ -702,7 +710,6 @@ static bool etm4_init_csdev_access(struct etmv4_drvdata *drvdata,
>  static void etm4_init_arch_data(void *info)
>  {
>  	u32 etmidr0;
> -	u32 etmidr1;
>  	u32 etmidr2;
>  	u32 etmidr3;
>  	u32 etmidr4;
> @@ -767,14 +774,6 @@ static void etm4_init_arch_data(void *info)
>  	/* TSSIZE, bits[28:24] Global timestamp size field */
>  	drvdata->ts_size = BMVAL(etmidr0, 24, 28);
>  
> -	/* base architecture of trace unit */
> -	etmidr1 = etm4x_relaxed_read32(csa, TRCIDR1);
> -	/*
> -	 * TRCARCHMIN, bits[7:4] architecture the minor version number
> -	 * TRCARCHMAJ, bits[11:8] architecture major versin number
> -	 */
> -	drvdata->arch = BMVAL(etmidr1, 4, 11);
> -
>  	/* maximum size of resources */
>  	etmidr2 = etm4x_relaxed_read32(csa, TRCIDR2);
>  	/* CIDSIZE, bits[9:5] Indicates the Context ID size */
> @@ -1614,7 +1613,7 @@ static int etm4_probe(struct amba_device *adev, const struct amba_id *id)
>  				etm4_init_arch_data,  &init_arg, 1))
>  		dev_err(dev, "ETM arch init failed\n");
>  
> -	if (etm4_arch_supported(drvdata->arch) == false)
> +	if (!drvdata->arch)
>  		return -EINVAL;
>  
>  	etm4_init_trace_id(drvdata);
> @@ -1646,7 +1645,8 @@ static int etm4_probe(struct amba_device *adev, const struct amba_id *id)
>  
>  	pm_runtime_put(&adev->dev);
>  	dev_info(&drvdata->csdev->dev, "CPU%d: ETM v%d.%d initialized\n",
> -		 drvdata->cpu, drvdata->arch >> 4, drvdata->arch & 0xf);
> +		 drvdata->cpu, ETM_ARCH_MAJOR_VERSION(drvdata->arch),
> +		 ETM_ARCH_MINOR_VERSION(drvdata->arch));
>  
>  	if (boot_enable) {
>  		coresight_enable(drvdata->csdev);
> -- 
> 2.24.1
> 
