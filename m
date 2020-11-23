Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 948CF2C00F3
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 09:00:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbgKWH6k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 02:58:40 -0500
Received: from m42-4.mailgun.net ([69.72.42.4]:19686 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725998AbgKWH6j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 02:58:39 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1606118319; h=In-Reply-To: Content-Type: MIME-Version:
 References: Message-ID: Subject: Cc: To: From: Date: Sender;
 bh=nJ5OnoAx/fC20E6YT2rnGuLn7tNdq6SkijU63iSx5Vo=; b=qS4BXVMhPiysywgg6N+mEiD+mGNnN8gdDU8A9AkMcBshd7LmV3v398LtX9nKuOYMYTAHCAr0
 lz+d8PCWhXGl0dTr1rf0H9vaEdNZvUOuIBTFFJaetVh9VkDAohtUN0s37pRFojr/TE9/JD1z
 98D3yRVbB1av9bEWwW8I/GarguQ=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-east-1.postgun.com with SMTP id
 5fbb6baefa67d9becf5b5aaa (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 23 Nov 2020 07:58:38
 GMT
Sender: tingweiz=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id D6731C43461; Mon, 23 Nov 2020 07:58:37 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from codeaurora.org (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tingwei)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 54731C433C6;
        Mon, 23 Nov 2020 07:58:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 54731C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=tingweiz@codeaurora.org
Date:   Mon, 23 Nov 2020 15:58:27 +0800
From:   Tingwei Zhang <tingweiz@codeaurora.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, anshuman.khandual@arm.com,
        coresight@lists.linaro.org, linux-kernel@vger.kernel.org,
        jonathan.zhouwen@huawei.com, mike.leach@linaro.org
Subject: Re: [PATCH v4 20/25] coresight: etm4x: Detect system instructions
 support
Message-ID: <20201123075827.GA18352@codeaurora.org>
References: <20201119164547.2982871-1-suzuki.poulose@arm.com>
 <20201119164547.2982871-21-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201119164547.2982871-21-suzuki.poulose@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Suzuki,

On Fri, Nov 20, 2020 at 12:45:42AM +0800, Suzuki K Poulose wrote:
> ETM v4.4 onwards adds support for system instruction access
> to the ETM. Detect the support on an ETM and switch to using the
> mode when available.
> 
> Cc: Mike Leach <mike.leach@linaro.org>
> Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  .../coresight/coresight-etm4x-core.c          | 39 +++++++++++++++++++
>  1 file changed, 39 insertions(+)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c 
> b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> index 7ac0a185c146..5cbea9c27f58 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> @@ -684,6 +684,37 @@ static const struct coresight_ops etm4_cs_ops = {
>  	.source_ops	= &etm4_source_ops,
>  };
> 
> +static inline bool cpu_supports_sysreg_trace(void)
> +{
> +	u64 dfr0 = read_sysreg_s(SYS_ID_AA64DFR0_EL1);
> +
> +	return ((dfr0 >> ID_AA64DFR0_TRACEVER_SHIFT) & 0xfUL) > 0;
> +}
> +
> +static bool etm4_init_sysreg_access(struct etmv4_drvdata *drvdata,
> +				    struct csdev_access *csa)
> +{
> +	u32 devarch;
> +
> +	if (!cpu_supports_sysreg_trace())
> +		return false;
> +
> +	/*
> +	 * ETMs implementing sysreg access must implement TRCDEVARCH.
> +	 */
> +	devarch = read_etm4x_sysreg_const_offset(TRCDEVARCH);
> +	if ((devarch & ETM_DEVARCH_ID_MASK) != ETM_DEVARCH_ETMv4x_ARCH)

Is this driver suppose to work on ETM 5.0/ETE trace unit before ETE driver
is ready?

Thanks,
Tingwei

> +		return false;
> +	*csa = (struct csdev_access) {
> +		.io_mem	= false,
> +		.read	= etm4x_sysreg_read,
> +		.write	= etm4x_sysreg_write,
> +	};
> +
> +	drvdata->arch = etm_devarch_to_arch(devarch);
> +	return true;
> +}
> +
>  static bool etm4_init_iomem_access(struct etmv4_drvdata *drvdata,
>  				   struct csdev_access *csa)
>  {
> @@ -714,9 +745,17 @@ static bool etm4_init_iomem_access(struct etmv4_drvdata 
> *drvdata,
>  static bool etm4_init_csdev_access(struct etmv4_drvdata *drvdata,
>  				   struct csdev_access *csa)
>  {
> +	/*
> +	 * Always choose the memory mapped io, if there is
> +	 * a memory map to prevent sysreg access on broken
> +	 * systems.
> +	 */
>  	if (drvdata->base)
>  		return etm4_init_iomem_access(drvdata, csa);
> 
> +	if (etm4_init_sysreg_access(drvdata, csa))
> +		return true;
> +
>  	return false;
>  }
> 
> -- 
> 2.24.1
> 
> _______________________________________________
> CoreSight mailing list
> CoreSight@lists.linaro.org
> https://lists.linaro.org/mailman/listinfo/coresight
