Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CD082A9E98
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 21:34:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728409AbgKFUem (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 15:34:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728140AbgKFUem (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 15:34:42 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6B22C0613CF
        for <linux-kernel@vger.kernel.org>; Fri,  6 Nov 2020 12:34:41 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id g12so1839514pgm.8
        for <linux-kernel@vger.kernel.org>; Fri, 06 Nov 2020 12:34:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2KkxLBPEW3Bs3fGukbxI8lyHUIDDucrAm1orqPYuJAo=;
        b=lWoh3SdhQyLLcHfEZt+CX9NH2HIoW5TjSsyk6+DC1RTgYcVXCUhAxW/l+oAKy5c8NN
         PraVCVN8XoRu1sP8QbHvPz2vtbrW5fcQvUX1kQK6dk4F0DLXaEbzID8PmixICzG9kizO
         KwtmRB5gHJIZe17eOcuixQDgR4+NiP7idZNTl2S6GkqCqkLHuCXEfKopKCuXPOtDu867
         xbvxKVVHpZAh5J47zImkM4PUKXGGFCB2lzGrN3uH7URITKcZIZb2/1A4V0tYK04mKzHa
         Tvbt034gyxcXEOFVtxFtmwIilAxw8Lo7DQtseixS2W+GAbYXYiRAp3gOk/zk+kQV/UfI
         QUwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2KkxLBPEW3Bs3fGukbxI8lyHUIDDucrAm1orqPYuJAo=;
        b=qd0l/LJdpJIqY7Y9oYCGsHAMaLru2cFUWU+9zdMBrLgmUT8h64gmFEW19OxnMZpJzy
         g+W9AsjoTsMm/AFKiZytmmCEReYWlc8uZOly+MvDuse1qVO9oyJ/MDvPMMoljpdye/AW
         D/sjciYPuoo8dJpXLuhB36oFhpea8PF+fmWrCIYFDE5CGL/510xchZFdlEh9ikCwH9+q
         RpJnjnsumPvp27lsnMhSE5vGNrAAcPmEPZDWo20fWVr+3JNU0njwva4xiLDnm2ZyryDn
         ebJ9EW2Y450Q+XTESkhSpb+Z2rhWTxs/vxUOb+1TH5AM9WaHJxoVpRNoeDIBwqH7awOY
         U/3A==
X-Gm-Message-State: AOAM530Xdj97P511SFkcaWf4xT4BpqZJ6RGzBY3W+dJem7G8xVXURzD9
        TPiWMDZ9F0wwyQbyBFspr/Znyw==
X-Google-Smtp-Source: ABdhPJzZvlRJNgQe9ztrxNrZsQvU9Rj1m2vXE53gBtkxweeX5ZPuHFK3ShkhcAGXF3+2X0lYdNprrg==
X-Received: by 2002:a17:90b:e14:: with SMTP id ge20mr1363483pjb.78.1604694880658;
        Fri, 06 Nov 2020 12:34:40 -0800 (PST)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id q23sm3243713pfg.18.2020.11.06.12.34.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2020 12:34:40 -0800 (PST)
Date:   Fri, 6 Nov 2020 13:34:38 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, mike.leach@linaro.org,
        coresight@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 19/26] coresight: etm4x: Detect access early on the
 target CPU
Message-ID: <20201106203438.GB3299843@xps15>
References: <20201028220945.3826358-1-suzuki.poulose@arm.com>
 <20201028220945.3826358-21-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201028220945.3826358-21-suzuki.poulose@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 28, 2020 at 10:09:38PM +0000, Suzuki K Poulose wrote:
> In preparation to detect the support for system instruction
> support, move the detection of the device access to the target
> CPU.
> 
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  .../coresight/coresight-etm4x-core.c          | 45 ++++++++++++++++---
>  1 file changed, 40 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> index f038bb10bc78..308674ab746c 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> @@ -56,6 +56,11 @@ static u64 etm4_get_access_type(struct etmv4_config *config);
>  
>  static enum cpuhp_state hp_online;
>  
> +struct etm_init_arg {

s/etm_init_arg/etm4_init_arg

> +	struct etmv4_drvdata	*drvdata;
> +	struct csdev_access	*csa;
> +};
> +
>  u64 etm4x_sysreg_read(struct csdev_access *csa,
>  		      u32 offset,
>  		      bool _relaxed,
> @@ -669,6 +674,22 @@ static const struct coresight_ops etm4_cs_ops = {
>  	.source_ops	= &etm4_source_ops,
>  };
>  
> +static bool etm_init_iomem_access(struct etmv4_drvdata *drvdata,
> +				  struct csdev_access *csa)
> +{
> +	*csa = CSDEV_ACCESS_IOMEM(drvdata->base);
> +	return true;
> +}
> +
> +static bool etm_init_csdev_access(struct etmv4_drvdata *drvdata,
> +				  struct csdev_access *csa)
> +{
> +	if (drvdata->base)
> +		return etm_init_iomem_access(drvdata, csa);
> +
> +	return false;
> +}

Returning a boolean rather than an int for the above two functions seems odd to
me.

> +
>  static void etm4_init_arch_data(void *info)
>  {
>  	u32 etmidr0;
> @@ -677,11 +698,22 @@ static void etm4_init_arch_data(void *info)
>  	u32 etmidr3;
>  	u32 etmidr4;
>  	u32 etmidr5;
> -	struct etmv4_drvdata *drvdata = info;
> -	struct csdev_access tmp_csa = CSDEV_ACCESS_IOMEM(drvdata->base);
> -	struct csdev_access *csa = &tmp_csa;
> +	struct etm_init_arg *init_arg = info;
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
> +	if (!etm_init_csdev_access(drvdata, csa))
> +		return;
> +
>  	/* Make sure all registers are accessible */
>  	etm4_os_unlock_csa(drvdata, csa);
>  	etm4_cs_unlock(drvdata, csa);
> @@ -1524,6 +1556,7 @@ static int etm4_probe(struct amba_device *adev, const struct amba_id *id)
>  	struct etmv4_drvdata *drvdata;
>  	struct resource *res = &adev->res;
>  	struct coresight_desc desc = { 0 };
> +	struct etm_init_arg init_arg = { 0 };
>  
>  	drvdata = devm_kzalloc(dev, sizeof(*drvdata), GFP_KERNEL);
>  	if (!drvdata)
> @@ -1551,7 +1584,6 @@ static int etm4_probe(struct amba_device *adev, const struct amba_id *id)
>  		return PTR_ERR(base);
>  
>  	drvdata->base = base;
> -	desc.access = CSDEV_ACCESS_IOMEM(base);
>  
>  	spin_lock_init(&drvdata->spinlock);
>  
> @@ -1563,8 +1595,11 @@ static int etm4_probe(struct amba_device *adev, const struct amba_id *id)
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
