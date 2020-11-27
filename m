Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 586942C6BC2
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 19:58:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729672AbgK0S5f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 13:57:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728995AbgK0Sz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 13:55:26 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2644C0613D1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 10:55:25 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id b10so3898594pfo.4
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 10:55:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yJTRVdDNQqRXteS6C4CSN6L/mZ0HsZqIw2wpYC2Y4Nk=;
        b=WY4TtJ8lwdsb/VO6jjdOniSR5/Yozemb4j+lPih07WiohM/l6zC72nIURAUS39025/
         BO/rnTYM/qz4IWFDgt/ZruCjVjchsJJKzpOw+sHaPHU8WypOj4pM+TZMKqzu5QHAo1uU
         PCnhakcrzmBKDCFLSdL5z+J4lTHKv0sGSX+9Ks+2mNI09+ptD2UFk1kWhStfX8+CzGMZ
         /vJQ6lVvzkgBVNL8NESvyUIHS7paDa4BY2m7IvcCbn6ApSbfYqMKfn0UMvPKYONAGiSC
         dnx/YEaeMir2d/EwFEuvi0Khq3sHKlglwhJtDNfTC7QhT5OE2PLFy2w9uMfJ/yByTFHi
         w8jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yJTRVdDNQqRXteS6C4CSN6L/mZ0HsZqIw2wpYC2Y4Nk=;
        b=WMPObdNAqmU3lvADTKzq03yh8awWiW8uvLJHo+CMDk1QAnLE6r557g90V3BVciWN76
         eIZxoapKUU232OzkTRb3NBC5dVO5wT/o3kVZDM25t5tPV0JoTtFbbBAYpYi7Tt9FI+Ex
         JjC6vReuNdvZ1bd/CQOKY0waiYvl3ukd+qga0/rbPwLg0wlFs/jXioytjCyYc6BFshB5
         WwS5gnICODxjsE4bDcGGMk22BtlDDT7TMQMOs2Yw0C1DinfPqm48KSlhmlXAb/NC1tLu
         zBl7ztsKK2p8Ycljb8+jBQyfRopXRYZA1wnjVEUDgy58vt4zwbZCYZjiYSMr8vROiNE4
         D0Ng==
X-Gm-Message-State: AOAM531hpE2MSsv+jme5ga13ZpOwfPWBFAOKjtdtASX0LNvCu0iEtFRS
        xmgYp/hHEIzQEo4qheAJDSgw7g==
X-Google-Smtp-Source: ABdhPJxTrC0RvbLtFiAW35o115Eg0hf2nd2q832b9E4WeQUW4iLLChSzvW3sr5S6e4D+SRTOmBK4BA==
X-Received: by 2002:a62:7905:0:b029:197:f300:5a2a with SMTP id u5-20020a6279050000b0290197f3005a2amr8612452pfc.30.1606503325198;
        Fri, 27 Nov 2020 10:55:25 -0800 (PST)
Received: from xps15 (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id 64sm8363944pfe.0.2020.11.27.10.55.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2020 10:55:24 -0800 (PST)
Date:   Fri, 27 Nov 2020 11:55:22 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, mike.leach@linaro.org,
        linux-kernel@vger.kernel.org, anshuman.khandual@arm.com,
        jonathan.zhouwen@huawei.com, coresight@lists.linaro.org,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Tingwei Zhang <tingwei@codeaurora.org>
Subject: Re: [PATCH v4 02/25] coresight: etm4x: Skip accessing TRCPDCR in
 save/restore
Message-ID: <20201127185522.GB1092947@xps15>
References: <20201119164547.2982871-1-suzuki.poulose@arm.com>
 <20201119164547.2982871-3-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201119164547.2982871-3-suzuki.poulose@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 19, 2020 at 04:45:24PM +0000, Suzuki K Poulose wrote:
> When the ETM is affected by Qualcomm errata, modifying the
> TRCPDCR could cause the system hang. Even though this is
> taken care of during enable/disable ETM, the ETM state
> save/restore could still access the TRCPDCR. Make sure
> we skip the access during the save/restore.
> 
> Found by code inspection.
> 
> Fixes: commit 02510a5aa78df45 ("coresight: etm4x: Add support to skip trace unit power up")

https://elixir.bootlin.com/linux/v5.10-rc5/source/Documentation/process/submitting-patches.rst#L121

> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: Mike Leach <mike.leach@linaro.org>
> Cc: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
> Cc: Tingwei Zhang <tingwei@codeaurora.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  drivers/hwtracing/coresight/coresight-etm4x-core.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> index 59a4a166adf4..ea2e317ddb7d 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> @@ -1277,7 +1277,8 @@ static int etm4_cpu_save(struct etmv4_drvdata *drvdata)
>  
>  	state->trcclaimset = readl(drvdata->base + TRCCLAIMCLR);
>  
> -	state->trcpdcr = readl(drvdata->base + TRCPDCR);
> +	if (!drvdata->skip_power_up)
> +		state->trcpdcr = readl(drvdata->base + TRCPDCR);
>  
>  	/* wait for TRCSTATR.IDLE to go up */
>  	if (coresight_timeout(drvdata->base, TRCSTATR, TRCSTATR_IDLE_BIT, 1)) {
> @@ -1295,9 +1296,9 @@ static int etm4_cpu_save(struct etmv4_drvdata *drvdata)
>  	 * potentially save power on systems that respect the TRCPDCR_PU
>  	 * despite requesting software to save/restore state.
>  	 */
> -	writel_relaxed((state->trcpdcr & ~TRCPDCR_PU),
> -			drvdata->base + TRCPDCR);
> -
> +	if (!drvdata->skip_power_up)
> +		writel_relaxed((state->trcpdcr & ~TRCPDCR_PU),
> +				drvdata->base + TRCPDCR);
>  out:
>  	CS_LOCK(drvdata->base);
>  	return ret;
> @@ -1392,7 +1393,8 @@ static void etm4_cpu_restore(struct etmv4_drvdata *drvdata)
>  
>  	writel_relaxed(state->trcclaimset, drvdata->base + TRCCLAIMSET);
>  
> -	writel_relaxed(state->trcpdcr, drvdata->base + TRCPDCR);
> +	if (!drvdata->skip_power_up)
> +		writel_relaxed(state->trcpdcr, drvdata->base + TRCPDCR);
>  
>  	drvdata->state_needs_restore = false;
>  
> -- 
> 2.24.1
> 
