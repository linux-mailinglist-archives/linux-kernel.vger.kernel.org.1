Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7680928EA87
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 03:55:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732470AbgJOBzA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 21:55:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732392AbgJOByh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 21:54:37 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83CD5C0613BC
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 15:19:24 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id 32so1169738otm.3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 15:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RRjGeO/tlzjrZ9J3RrPGuGS/1yOeW5L71HWGM1q9PqM=;
        b=mv4K9pQTVn31rCM+RtELHJJEN9cJcDk1Vd6rueXFN+ur+DaBM9Qq6TK1m1WezBf4hr
         MQc4sM/fZNpoQKwJNk0jefV/29a2Gbpvzk8lFhkPydaWTLr63a2DTl1r3yhg6YPa/3X7
         GMmiNAEf3/5wkoQNpNIufrrELvJm1hzUZ4d5PU3Jto2lwEFOoxAzKXsFath4PAacm8Rk
         ZlO1sQURY4EWIvlOqPlPAW3Y0R6KtQ9uEyAF0kwX1a/HsEDfF9f3sScPa4odkSIEPkkR
         oQt72Sd4vg9XkFEeqhqZrGx1AchS1N4vkcJYy7b4nnFinyY/IYoOdPvA8MVmt/JKcj4Z
         llKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RRjGeO/tlzjrZ9J3RrPGuGS/1yOeW5L71HWGM1q9PqM=;
        b=iNWf7hr00VsKCrUDNYdLAB8uGI1djuU7QUs/615/NBC7I95yy40nSHeBfoL4qvzi6k
         r5rJyODfiduuiyq9sQ4Tq6A+T+Mnjp2XAWa2xrZnkhJZzDeN5peEn95RC9M6aajwsh1K
         MXpEf8ueVCBY/J9/C/B1VEKQulIegCL68M8M6tQKKnuaZ+5uwJRRXApilZKGKU/MUA/X
         e1fHgGj7V+nReJ80xW64ZP9bENeS6UoqTA/RBTXRnEepo50kVYuYXeOgwkCYt9nOrq/8
         2Shp/RQ8/j9cCjADEdfp+cgQxT5Ri05a8JKT9m5AJ5imN4YVdpDsuL2rP9Bdv8X4w68S
         sGKA==
X-Gm-Message-State: AOAM533h/6gtGeKrt2vff7wyUk3ZCpalf9dKd5tMUx1OJG4yx7JphHBD
        4Coetsw5C1zDunZ/FAEWlAkwDg==
X-Google-Smtp-Source: ABdhPJxDI9ig5Teru80krEOu8rMTShtx9klUW2MoC+kc1i2hN5KpLmX7EJYBnDsiZFyWnkmRIXuaHQ==
X-Received: by 2002:a9d:6a55:: with SMTP id h21mr607071otn.297.1602713963840;
        Wed, 14 Oct 2020 15:19:23 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id q81sm337035oia.46.2020.10.14.15.19.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2020 15:19:23 -0700 (PDT)
Date:   Wed, 14 Oct 2020 17:14:40 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     kholk11@gmail.com
Cc:     will@kernel.org, robin.murphy@arm.com, joro@8bytes.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        marijns95@gmail.com, konradybcio@gmail.com,
        martin.botka1@gmail.com, linux-arm-msm@vger.kernel.org,
        phone-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 8/8] iommu/arm-smmu-qcom: Add stream_mapping_reset detail
 to QCOM SMMUv2
Message-ID: <20201014221440.GA299663@builder.lan>
References: <20200926130004.13528-1-kholk11@gmail.com>
 <20200926130004.13528-9-kholk11@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200926130004.13528-9-kholk11@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 26 Sep 08:00 CDT 2020, kholk11@gmail.com wrote:

> From: AngeloGioacchino Del Regno <kholk11@gmail.com>
> 
> On some Qualcomm SoCs with certain hypervisor configurations,
> some context banks are hyp-protected and cannot be disabled,
> nor the relative S2CRs can be set as bypass, or a hyp-fault
> will be triggered and the system will hang.
> 
> This is seen on at least Qualcomm SDM630, SDM636 and SDM660.
> 
> Signed-off-by: AngeloGioacchino Del Regno <kholk11@gmail.com>
> ---
>  drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> index b18e70bddf29..364908cc2adf 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> @@ -85,6 +85,18 @@ static int qcom_smmuv2_cfg_probe(struct arm_smmu_device *smmu)
>  	return 0;
>  }
>  
> +static void qcom_smmuv2_stream_mapping_reset(struct arm_smmu_device *smmu)
> +{
> +	/*
> +	 * Broken firmware quirk:
> +	 * On some Qualcomm SoCs with certain hypervisor configurations,
> +	 * some context banks are hyp-protected and cannot be disabled,

Wouldn't you run into the same problem when init_domain_context() later
comes along and "accidentally" pick one of these context banks?

Do we have any way of knowing which banks this is, so we can mark them
as busy?

> +	 * nor the relative S2CRs can be set as bypass, or a hyp-fault

On platforms such as SDM845, SM8150, SM8250 etc, writing S2CR of type
BYPASS is trapped by the hypervisor and FAULT is actually written to the
hardware - resulting in a system reset when the associated hardware
tries to perform a memory access.


Is it the actual S2CR write that causes the problem you're seeing or the
fact that it happens to be that you shoot down the display stream as
soon as you touch these registers?

Regards,
Bjorn

> +	 * will be triggered and the system will hang.
> +	 */
> +	return;
> +}
> +
>  static void qcom_smmuv2_test_smr_masks(struct arm_smmu_device *smmu)
>  {
>  	/*
> @@ -99,6 +111,7 @@ static void qcom_smmuv2_test_smr_masks(struct arm_smmu_device *smmu)
>  
>  static const struct arm_smmu_impl qcom_smmuv2_impl = {
>  	.cfg_probe = qcom_smmuv2_cfg_probe,
> +	.stream_mapping_reset = qcom_smmuv2_stream_mapping_reset,
>  	.test_smr_masks = qcom_smmuv2_test_smr_masks,
>  };
>  
> -- 
> 2.28.0
> 
