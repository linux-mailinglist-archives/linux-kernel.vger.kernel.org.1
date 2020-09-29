Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 747FC27C05D
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 11:02:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727870AbgI2JCK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 05:02:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727838AbgI2JCJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 05:02:09 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7BA4C0613D0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 02:02:07 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id o5so4406006wrn.13
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 02:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/A7aNSm3cdga1VZaRmJ05RVUoqJfegPG8Brx5Ka5WGE=;
        b=DO2qH4j9aG8GSMVOMJ14DMKAPsmoURMiGLFD2cXSDA+rFlLU3RUvtnvdUxZyjZEWoE
         hUeYHGiMv8zI1FteDtN13NQhpVyXsnmryARr5aCX2SHQHKCrHFpsy5qcO3ciYgZZFlKD
         mF+l+dH3+fPIN80ML1NEtd0s11s9qbDf7Qw4Ffik03AAY7VthUMA0Rac32EEO8lN4q59
         zqxhasPIrscXXMn/fuRFuWHNk3ams+hG4O1HKi39AjFLCJYLObl/2mm5qG60vub7QOPY
         mdG/7YxhwmCg5aSRqrr9IkdXIIHMXmE9KlKEWOJyHPnYO+v56Rf+xHaeFfEUPzEVrgvR
         0J/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/A7aNSm3cdga1VZaRmJ05RVUoqJfegPG8Brx5Ka5WGE=;
        b=WjCGisor/XFZZjy8GIaY/sJtqEoPgAlgry2+KT0Dff0GmxRbKnFJE3ZKQ+9KIl7NMO
         J24Hv2UYulCpoHq1Rx9LZCFsDbc1eHiclBq3WTYtxOC9s1f15fi/rz5XekZXJlmI4C5T
         SWZTwU3D4rf/WE1hRvdGuHn3iORP3zBXBTv1W4/t20n1fn5oooAvijrXPQHPxvC8qmGu
         UBLhHILG/bf4rk6DKaWP7mDhr+VPZbn7PT+OICRFzuJ8YC+oEitk4dKgp97YFPn3/+om
         6l00riMv6YxG13RZBBNgtVOGAECifexh85tvqmTMITIY7TqbV7GOdMZP8AS/ZQnLNhyS
         FTNQ==
X-Gm-Message-State: AOAM530CknlVnCSkTZpbTADNXM4pMy+JrVbIuniBcrzvoEqwz6WBWnHz
        AY64EplhJ2L4IzD/fKyUd390Tg==
X-Google-Smtp-Source: ABdhPJzQKyr2tz/uJM9dF4tNkWt1NDTUANm3HQkHYNhXxHlAf3Gx3/6+nhwrh7etV+RVPrZyqC407Q==
X-Received: by 2002:adf:c188:: with SMTP id x8mr3236405wre.201.1601370126436;
        Tue, 29 Sep 2020 02:02:06 -0700 (PDT)
Received: from [192.168.86.34] (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.googlemail.com with ESMTPSA id u12sm5199475wrt.81.2020.09.29.02.02.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Sep 2020 02:02:05 -0700 (PDT)
Subject: Re: [PATCH v7 4/6] Asoc: qcom: lpass:Update lpaif_dmactl members
 order
To:     Srinivasa Rao Mandadapu <srivasam@codeaurora.org>,
        agross@kernel.org, bjorn.andersson@linaro.org, lgirdwood@gmail.com,
        broonie@kernel.org, robh+dt@kernel.org, plai@codeaurora.org,
        bgoswami@codeaurora.org, perex@perex.cz, tiwai@suse.com,
        rohitkr@codeaurora.org, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     V Sujith Kumar Reddy <vsujithk@codeaurora.org>
References: <1601286811-25962-1-git-send-email-srivasam@codeaurora.org>
 <1601286811-25962-5-git-send-email-srivasam@codeaurora.org>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <8059e28b-39c5-d71b-3e22-357d4d121f7e@linaro.org>
Date:   Tue, 29 Sep 2020 10:02:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1601286811-25962-5-git-send-email-srivasam@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 28/09/2020 10:53, Srinivasa Rao Mandadapu wrote:
> From: V Sujith Kumar Reddy <vsujithk@codeaurora.org>
> 
> Update the lpaif_dmactl struct members order to match
> HDMI reg map members sequence. Separate Interface reg map
> as it is used for I2S control but not for HDMI control,
> to make use of bulk API, which makes code more readable.
> 
> Signed-off-by: V Sujith Kumar Reddy <vsujithk@codeaurora.org>
> Signed-off-by: Srinivasa Rao Mandadapu <srivasam@codeaurora.org>

Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

> ---
>   sound/soc/qcom/lpass-platform.c | 8 ++++----
>   sound/soc/qcom/lpass.h          | 6 +++---
>   2 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/sound/soc/qcom/lpass-platform.c b/sound/soc/qcom/lpass-platform.c
> index e7cf4e5..db0d959 100644
> --- a/sound/soc/qcom/lpass-platform.c
> +++ b/sound/soc/qcom/lpass-platform.c
> @@ -71,13 +71,13 @@ static int lpass_platform_alloc_dmactl_fields(struct device *dev,
>   	rd_dmactl = drvdata->rd_dmactl;
>   	wr_dmactl = drvdata->wr_dmactl;
>   
> -	rval = devm_regmap_field_bulk_alloc(dev, map, &rd_dmactl->bursten,
> -					    &v->rdma_bursten, 6);
> +	rval = devm_regmap_field_bulk_alloc(dev, map, &rd_dmactl->intf,
> +					    &v->rdma_intf, 6);
>   	if (rval)
>   		return rval;
>   
> -	return devm_regmap_field_bulk_alloc(dev, map, &wr_dmactl->bursten,
> -					    &v->wrdma_bursten, 6);
> +	return devm_regmap_field_bulk_alloc(dev, map, &wr_dmactl->intf,
> +					    &v->wrdma_intf, 6);
>   }
>   
>   static int lpass_platform_pcmops_open(struct snd_soc_component *component,
> diff --git a/sound/soc/qcom/lpass.h b/sound/soc/qcom/lpass.h
> index 51c9991..7089d4c 100644
> --- a/sound/soc/qcom/lpass.h
> +++ b/sound/soc/qcom/lpass.h
> @@ -31,9 +31,9 @@ struct lpaif_i2sctl {
>   
>   
>   struct lpaif_dmactl {
> +	struct regmap_field *intf;
>   	struct regmap_field *bursten;
>   	struct regmap_field *wpscnt;
> -	struct regmap_field *intf;
>   	struct regmap_field *fifowm;
>   	struct regmap_field *enable;
>   	struct regmap_field *dyncclk;
> @@ -110,17 +110,17 @@ struct lpass_variant {
>   	struct reg_field bitwidth;
>   
>   	/* RD_DMA Register fields */
> +	struct reg_field rdma_intf;
>   	struct reg_field rdma_bursten;
>   	struct reg_field rdma_wpscnt;
> -	struct reg_field rdma_intf;
>   	struct reg_field rdma_fifowm;
>   	struct reg_field rdma_enable;
>   	struct reg_field rdma_dyncclk;
>   
>   	/* WR_DMA Register fields */
> +	struct reg_field wrdma_intf;
>   	struct reg_field wrdma_bursten;
>   	struct reg_field wrdma_wpscnt;
> -	struct reg_field wrdma_intf;
>   	struct reg_field wrdma_fifowm;
>   	struct reg_field wrdma_enable;
>   	struct reg_field wrdma_dyncclk;
> 
