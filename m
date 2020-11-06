Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C6702A9EAE
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 21:46:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728470AbgKFUqx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 15:46:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727559AbgKFUqx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 15:46:53 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE4DBC0613CF
        for <linux-kernel@vger.kernel.org>; Fri,  6 Nov 2020 12:46:51 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id z24so1882745pgk.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 Nov 2020 12:46:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=eNgghEz1mYX/bJ2cjckJAUQAeVwCGxBsecpojcnHypQ=;
        b=lp7Ot25zfCZihYpuko12ICgok6mxZgoD3AQocsaCgoqxNsU70LkJ4UpP0t36CNhxJe
         j9nQv8D3BDpXX46lnkJU7RySc5Ciui+uWs+myTXddSHI9WcqU3O0patZ97G0UblfB4Yi
         3QNmm+k3Ddh8ZCeuuWK9j8urpXLV4VKIOmuOOw6uvMfJS/+WjdkYtaNS6VbVDf2WKtsO
         4JD+Q+AKuni3ifYEsKBOPfr5ky5y/oGcM3Xe3ruuqWPDZnsPDFIQn+cMUP8/lT21LniZ
         acymgyhzZsvzRdBct0nKzjo7h4uwvrWXSLzjUwlT2Egk3XBcYWTuM+82R1hOjYmAGIvi
         ToBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eNgghEz1mYX/bJ2cjckJAUQAeVwCGxBsecpojcnHypQ=;
        b=Vkqfc3YWvKGyesp1EXAkgexw9hlSGovJ95H3AnKFgquqTyU6IrzkVqN4F7hFSXlTsw
         0GFQrrkrq/FA0Njj60jh5RVJWKPz0qAEX3K4cFa0p1B2wQq7oDNbgm1P1wg82cEt5hAx
         RO/+Vy+gymIrz0+gtrOkvatFU8mlBKDHyCm1UPT28gUnmHcc39+W8lhfx7LCofVOWRcb
         Zb0eFH4JSd8r9W70bl68H8BddiiZUOrv2Kz3fG2luyBMdGxETKtBqnc8lJbogsF7FGhu
         4jQzDuW1Yf1Fg0MN+sG/7yCXppDLV/5fu+jqABpcMzAvUD8hNKp1j+j7T3MkiKfrR8kl
         79KQ==
X-Gm-Message-State: AOAM5320QGCdHP0be/K11p3UCUqkuID/PEvmtIxEbmSshjY1jB/8IpCc
        kW4CORqo6XhlFaZVNMLmIjM6lvoNzlHGHA==
X-Google-Smtp-Source: ABdhPJyoHvKfq8eXPNIkT+TVBZ58/fgyw5PlRwnnHpml05JwvKlWx2npYd5UcHBdZvw+KYhQICjB4Q==
X-Received: by 2002:a17:90b:783:: with SMTP id l3mr1497715pjz.122.1604695611372;
        Fri, 06 Nov 2020 12:46:51 -0800 (PST)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id z5sm3822055pjr.22.2020.11.06.12.46.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2020 12:46:50 -0800 (PST)
Date:   Fri, 6 Nov 2020 13:46:49 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, mike.leach@linaro.org,
        coresight@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 19/26] coresight: etm4x: Detect access early on the
 target CPU
Message-ID: <20201106204649.GC3299843@xps15>
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

I would also prefix the above two functions with "etm4_" rather than "etm_" to
follow what is already done in this file. 

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
