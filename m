Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A6213037B9
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 09:19:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389771AbhAZITG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 03:19:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726515AbhAYSlg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 13:41:36 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64F0EC0613ED
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 10:40:00 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id i63so8902216pfg.7
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 10:40:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=810IMXBV1/7mh3IkPVy/heX6P4WxI70MgM5s4wu77lk=;
        b=u4B/C7BEtW7GmGqfQghiovSJn8gO99Pb5HExxzSjMZqc8cbA0s/22qK3vj85LwJ0wg
         PHxgfkU6fg1Y0GKPRujmkXWB00lGaqM0mn34g8DjKHj/NhbH76rs2qvDBbU1w4nZuRpU
         +3YX+gC7rUamoxyK8ByJtLqNZutVJkMyfUJpXdUsw7ujcfDCpPJsagf5gq3UJQX/Z375
         heG7MTIvnaQvLNtg50+1k1agjJD56f8bDYxVVLhUxpCQdK5MxVMCHpLeilveMyn5YRVV
         9OkRrDjn5Vtg9ucs65M7Vk56qf5RJsbAa5n45ocKZuGFsrX+PbA3cVDupA10Rm6ECXdk
         crcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=810IMXBV1/7mh3IkPVy/heX6P4WxI70MgM5s4wu77lk=;
        b=RX88WUcpywilaWSxmlVYzHtdGnkuFojs0cml7yyt9chjg6cl1ZPqM5BAnDTI0T1DTX
         SydqmEBJqxxcmYCtmMwoZAJ3CO8frrOWBjE/AQ//MuYc/o7TtuzDX7tV9RLuQ1v0BF9Z
         QVJZPv218//1d7Zhhiw3rDpfn7FeH1P2o28wdMKDAlJSUdYyM+PHx1pcooXUW3tRRleX
         xk7LD4h0kNejTEQ0IDEYhZA/nGHKQCNTnS8Z5ZwQRtyFpSJNQkcQcLsTWrEqIZWLCQ//
         pegydpn8FGUukYuEBSVBZyXiM+j/4LksT4I2V3zfyZlbeibGhMsyngfwdWphqr0bHxlA
         d6fQ==
X-Gm-Message-State: AOAM533Y7N1hitv7dw6iS4nph1NVx6CLLNxdT1pOmcGdi+4O4nAiWERi
        WE0WLZgg5+a/MhPpH7x+9b4PeQ==
X-Google-Smtp-Source: ABdhPJxajfRLmXuLMz8O2NxSLlOGCAw1FB3G6FN+5k8IuapA0+LLhqa+zHE51dDR6HVowNwr4seRrw==
X-Received: by 2002:a63:dc06:: with SMTP id s6mr1873867pgg.358.1611599999924;
        Mon, 25 Jan 2021 10:39:59 -0800 (PST)
Received: from xps15 (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id h23sm5023016pgh.64.2021.01.25.10.39.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 10:39:59 -0800 (PST)
Date:   Mon, 25 Jan 2021 11:39:57 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
        anshuman.khandual@arm.com, mike.leach@linaro.org,
        leo.yan@linaro.org, linux-kernel@vger.kernel.org,
        jonathan.zhouwen@huawei.com, catalin.marinas@arm.com,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Tingwei Zhang <tingwei@codeaurora.org>
Subject: Re: [PATCH v7 02/28] coresight: etm4x: Skip accessing TRCPDCR in
 save/restore
Message-ID: <20210125183957.GA894394@xps15>
References: <20210110224850.1880240-1-suzuki.poulose@arm.com>
 <20210110224850.1880240-3-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210110224850.1880240-3-suzuki.poulose@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 10, 2021 at 10:48:24PM +0000, Suzuki K Poulose wrote:
> When the ETM is affected by Qualcomm errata, modifying the
> TRCPDCR could cause the system hang. Even though this is
> taken care of during enable/disable ETM, the ETM state
> save/restore could still access the TRCPDCR. Make sure
> we skip the access during the save/restore.
> 
> Found by code inspection.
> 
> Fixes: 02510a5aa78df45 ("coresight: etm4x: Add support to skip trace unit power up")

The SHA1 should be 12 character long, something I commented on in V4.  I fixed
it.

> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: Mike Leach <mike.leach@linaro.org>
> Cc: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
> Cc: Tingwei Zhang <tingwei@codeaurora.org>
> Reviewed-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
> Tested-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  drivers/hwtracing/coresight/coresight-etm4x-core.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> index 76526679b998..cce65fc0c9aa 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> @@ -1373,7 +1373,8 @@ static int etm4_cpu_save(struct etmv4_drvdata *drvdata)
>  
>  	state->trcclaimset = readl(drvdata->base + TRCCLAIMCLR);
>  
> -	state->trcpdcr = readl(drvdata->base + TRCPDCR);
> +	if (!drvdata->skip_power_up)
> +		state->trcpdcr = readl(drvdata->base + TRCPDCR);
>  
>  	/* wait for TRCSTATR.IDLE to go up */
>  	if (coresight_timeout(drvdata->base, TRCSTATR, TRCSTATR_IDLE_BIT, 1)) {
> @@ -1391,9 +1392,9 @@ static int etm4_cpu_save(struct etmv4_drvdata *drvdata)
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
> @@ -1488,7 +1489,8 @@ static void etm4_cpu_restore(struct etmv4_drvdata *drvdata)
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
