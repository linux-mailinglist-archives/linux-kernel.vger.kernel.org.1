Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 748982C904E
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 22:55:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730190AbgK3Vxy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 16:53:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbgK3Vxy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 16:53:54 -0500
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 614A2C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 13:53:14 -0800 (PST)
Received: by mail-pj1-x1042.google.com with SMTP id hk16so419575pjb.4
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 13:53:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mNK/ZInb4X8QzeOfsYGlWtaquG9qKMwOrvA+mghxlSw=;
        b=ZQSww9DblVEGxfZEmCwMlt/VyayH8dqjE5Zr0e9KnAUD5YG1lICPyN4BZNiWU5YFxL
         k3foUTLUIled26tlB4Xmu3zpq30DHBWTv5M+rkIWIKhnJgPs/qjBrca5mO5DIwVgRzYK
         cHmnZF88mDc/GnQ6RudH34D3jmk2dUDFCwAnXIXxOHO0GdRFCUCqieaHkD7atQzWXGAq
         3YKUi8kbDOWJCNuEXuq4O09xDBiLiNYED8csW7szdK5N+TOT4ut4IZq2nvrDRM8ATlCk
         qBPOArSUhBmIlcc78t/C4Qx3j/4LXZKWluhls7LkuhNPk/oGx9oWLhc2u8WdaufDGoyR
         UZ7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mNK/ZInb4X8QzeOfsYGlWtaquG9qKMwOrvA+mghxlSw=;
        b=DQdk7KqDJeoHTEp2j9/9Iq6Fz0o+KJL6NVfhO0TAGsS5JVYy4vTx2l7QhCkizz9/dK
         Qwz4InkbVbCiXXOe2+kRXlTayXqo7KNnRjtWTYDpIZpS8uChwH50orSKmYLZYD7s/b0c
         EfTZSirluiXvegIB5dcFwdJPh4dXdLdKldSqtqVkRk9wL37HXnwlYfvRQybTPqvDf2Nf
         fsZ2tJuXL6FxHfBJcpvoIO6HAabTHgPBY8Vj4fca/L2YUeHkKzkXpZtL2OPlciWgYQVi
         kZfQnD+8mStsKdpy0RJBAC75z7Ai/nwFWn47DgHjaE6VkH39Kr6RLMHdryCNvzbsBZvZ
         9BbQ==
X-Gm-Message-State: AOAM533D38oqk6O4mTrYHkYk5bU7KLIaFNPgZUPuSQwfac7Nnme3MXgg
        LzQ3YP9r9l/jvC/RufgJqu/Smw==
X-Google-Smtp-Source: ABdhPJzcEw6TmnB9b0M719t7Z+og3PX3RaYyZxMmAtpOAr85dJUW4MYXrQxtY9Et2dUMC/0wsQkPlg==
X-Received: by 2002:a17:902:b116:b029:d8:f5d7:5fe5 with SMTP id q22-20020a170902b116b02900d8f5d75fe5mr20817834plr.48.1606773193898;
        Mon, 30 Nov 2020 13:53:13 -0800 (PST)
Received: from xps15 (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id q126sm18561441pfc.168.2020.11.30.13.53.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Nov 2020 13:53:13 -0800 (PST)
Date:   Mon, 30 Nov 2020 14:53:11 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, mike.leach@linaro.org,
        linux-kernel@vger.kernel.org, anshuman.khandual@arm.com,
        jonathan.zhouwen@huawei.com, coresight@lists.linaro.org
Subject: Re: [PATCH v4 16/25] coresight: etm4x: Detect access early on the
 target CPU
Message-ID: <20201130215311.GK1092947@xps15>
References: <20201119164547.2982871-1-suzuki.poulose@arm.com>
 <20201119164547.2982871-17-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201119164547.2982871-17-suzuki.poulose@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 19, 2020 at 04:45:38PM +0000, Suzuki K Poulose wrote:
> In preparation to detect the support for system instruction
> support, move the detection of the device access to the target
> CPU.
> 
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: Mike Leach <mike.leach@linaro.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
> Changes since v3
>  - Name constructs etm4_xx instead of etm_** (Mathieu)
> ---
>  .../coresight/coresight-etm4x-core.c          | 45 ++++++++++++++++---
>  1 file changed, 40 insertions(+), 5 deletions(-)
>

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> index a91e7de77ab9..d3b009c3724e 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> @@ -56,6 +56,11 @@ static u64 etm4_get_access_type(struct etmv4_config *config);
>  
>  static enum cpuhp_state hp_online;
>  
> +struct etm4_init_arg {
> +	struct etmv4_drvdata	*drvdata;
> +	struct csdev_access	*csa;
> +};
> +
>  /*
>   * Check if TRCSSPCICRn(i) is implemented for a given instance.
>   *
> @@ -678,6 +683,22 @@ static const struct coresight_ops etm4_cs_ops = {
>  	.source_ops	= &etm4_source_ops,
>  };
>  
> +static bool etm4_init_iomem_access(struct etmv4_drvdata *drvdata,
> +				   struct csdev_access *csa)
> +{
> +	*csa = CSDEV_ACCESS_IOMEM(drvdata->base);
> +	return true;
> +}
> +
> +static bool etm4_init_csdev_access(struct etmv4_drvdata *drvdata,
> +				   struct csdev_access *csa)
> +{
> +	if (drvdata->base)
> +		return etm4_init_iomem_access(drvdata, csa);
> +
> +	return false;
> +}
> +
>  static void etm4_init_arch_data(void *info)
>  {
>  	u32 etmidr0;
> @@ -686,11 +707,22 @@ static void etm4_init_arch_data(void *info)
>  	u32 etmidr3;
>  	u32 etmidr4;
>  	u32 etmidr5;
> -	struct etmv4_drvdata *drvdata = info;
> -	struct csdev_access tmp_csa = CSDEV_ACCESS_IOMEM(drvdata->base);
> -	struct csdev_access *csa = &tmp_csa;
> +	struct etm4_init_arg *init_arg = info;
> +	struct etmv4_drvdata *drvdata;
> +	struct csdev_access *csa;
>  	int i;
>  
> +	drvdata = init_arg->drvdata;
> +	csa = init_arg->csa;
> +
> +	/*
> +	 * If we are unable to detect the access mechanism,
> +	 * or unable to detect the trace unit type, fail
> +	 * early.
> +	 */
> +	if (!etm4_init_csdev_access(drvdata, csa))
> +		return;
> +
>  	/* Make sure all registers are accessible */
>  	etm4_os_unlock_csa(drvdata, csa);
>  	etm4_cs_unlock(drvdata, csa);
> @@ -1536,6 +1568,7 @@ static int etm4_probe(struct amba_device *adev, const struct amba_id *id)
>  	struct etmv4_drvdata *drvdata;
>  	struct resource *res = &adev->res;
>  	struct coresight_desc desc = { 0 };
> +	struct etm4_init_arg init_arg = { 0 };
>  
>  	drvdata = devm_kzalloc(dev, sizeof(*drvdata), GFP_KERNEL);
>  	if (!drvdata)
> @@ -1563,7 +1596,6 @@ static int etm4_probe(struct amba_device *adev, const struct amba_id *id)
>  		return PTR_ERR(base);
>  
>  	drvdata->base = base;
> -	desc.access = CSDEV_ACCESS_IOMEM(base);
>  
>  	spin_lock_init(&drvdata->spinlock);
>  
> @@ -1575,8 +1607,11 @@ static int etm4_probe(struct amba_device *adev, const struct amba_id *id)
>  	if (!desc.name)
>  		return -ENOMEM;
>  
> +	init_arg.drvdata = drvdata;
> +	init_arg.csa = &desc.access;
> +
>  	if (smp_call_function_single(drvdata->cpu,
> -				etm4_init_arch_data,  drvdata, 1))
> +				etm4_init_arch_data,  &init_arg, 1))
>  		dev_err(dev, "ETM arch init failed\n");
>  
>  	if (etm4_arch_supported(drvdata->arch) == false)
> -- 
> 2.24.1
> 
