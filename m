Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF7EA2EEA41
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 01:19:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729516AbhAHATI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 19:19:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727858AbhAHATH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 19:19:07 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AADDEC0612F4
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jan 2021 16:18:27 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id m6so5113529pfm.6
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jan 2021 16:18:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1ZxG8zG2j5D126ZUTvLvre/qhsxCph/TuN6OSwhoxuw=;
        b=la6tlvOXFGN22ubndJWz4KrJ7Q2WMqZqbmJj8Ajc8HMAEwFjjzsTjflG0BxQubQh2l
         Oe1vqWk4yEq8h9kVKGMYlCLGiIWui1fdSFoOD03L1JeMaHXI+VkkSTyrj0YPvDvYuSuz
         xlXjJjAvlKVUz3sNNVuzIUvPVIqsDLXlbSsqidl8saNyoUjhaT0V1G6VEwZvFOC9nNWD
         ksX+A+U9ASEaZDdCdd4yF/l8IvBsPhAtF2UNqXmsYa9mTfdBF+u/DU4724ME4tR0hS6h
         OBVMj/z+wj10mXcfZPraQ1tJDVJ9TNcXUGDd0L0Xq3h0j2COC8VbJzau3VEvK4YTdCOk
         sEEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1ZxG8zG2j5D126ZUTvLvre/qhsxCph/TuN6OSwhoxuw=;
        b=sACao/Ig3MLs5/1wuOE9CXQcEdkcUmH+Ggivd+lG/YuV7aq2XnY4qG+iPrcviX3Elw
         Lzn/Eq+YhMEwk8DBz/CO1VIKxM65pK6xHHTdUIh9mH+jopqpPNYtbhrFlBIliwBD6srz
         GG8l9s/WSr7dTtgpGiawvyxgQxpyxh8st6mmSbzuaDkmkJqr5O49mzQ72zvAZSFRDhIs
         EvtRmLuwI7HDLMB/3+m1F6bJZkXrBFroOe2ALvSxY4Gys3TXwEUQwSy03a5LwsjwtVCa
         vobo1fNVVQgb05OgiS6zerUiM6rB4a1M0PTYNZaqIhs8xioZwiHtSouWz32Dr5xLbZkq
         71Ow==
X-Gm-Message-State: AOAM5321GWjkvI/Eh5+VY60oaR3AfpSo7HgfLlLGAaHrrSXaUNR5eeLd
        RlMLcxGlKNIoToiR3br3WV5g2wgTXUZjyw==
X-Google-Smtp-Source: ABdhPJzZ+2IpJvuPCQBEQXFNaeoRVv7HyrZGfamDUYQeDZ9IX847wnvW9y02EA8NkVWg1jFfOadhIA==
X-Received: by 2002:a62:e213:0:b029:19e:59d3:a76a with SMTP id a19-20020a62e2130000b029019e59d3a76amr1133651pfi.53.1610065107172;
        Thu, 07 Jan 2021 16:18:27 -0800 (PST)
Received: from xps15 (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id o11sm6455241pjs.36.2021.01.07.16.18.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jan 2021 16:18:26 -0800 (PST)
Date:   Thu, 7 Jan 2021 17:18:23 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        coresight@lists.linaro.org, leo.yan@linaro.org,
        mike.leach@linaro.org, anshuman.khandual@arm.com
Subject: Re: [PATCH v6 12/26] coresight: etm4x: Check for Software Lock
Message-ID: <20210108001823.GD43045@xps15>
References: <20210107123859.674252-1-suzuki.poulose@arm.com>
 <20210107123859.674252-13-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210107123859.674252-13-suzuki.poulose@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 07, 2021 at 12:38:45PM +0000, Suzuki K Poulose wrote:
> The Software lock is not implemented for system instructions
> based accesses. So, skip the lock register access in such
> cases.
> 
> Cc: Mike Leach <mike.leach@linaro.org>
> Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  .../coresight/coresight-etm4x-core.c          | 40 ++++++++++++-------
>  1 file changed, 26 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> index da0b64dd51d0..f947d6ddf9e3 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> @@ -133,6 +133,21 @@ static void etm4_os_lock(struct etmv4_drvdata *drvdata)
>  	isb();
>  }
>  
> +static void etm4_cs_lock(struct etmv4_drvdata *drvdata,
> +			 struct csdev_access *csa)
> +{
> +	/* Software Lock is only accessible via memory mapped interface */
> +	if (csa->io_mem)
> +		CS_LOCK(csa->base);
> +}
> +
> +static void etm4_cs_unlock(struct etmv4_drvdata *drvdata,
> +			 struct csdev_access *csa)

Indentation

> +{
> +	if (csa->io_mem)
> +		CS_UNLOCK(csa->base);
> +}
> +
>  static bool etm4_arch_supported(u8 arch)
>  {
>  	/* Mask out the minor version number */
> @@ -263,7 +278,8 @@ static int etm4_enable_hw(struct etmv4_drvdata *drvdata)
>  	struct device *etm_dev = &csdev->dev;
>  	struct csdev_access *csa = &csdev->access;
>  
> -	CS_UNLOCK(drvdata->base);
> +
> +	etm4_cs_unlock(drvdata, csa);
>  	etm4_enable_arch_specific(drvdata);
>  
>  	etm4_os_unlock(drvdata);
> @@ -366,7 +382,7 @@ static int etm4_enable_hw(struct etmv4_drvdata *drvdata)
>  	isb();
>  
>  done:
> -	CS_LOCK(drvdata->base);
> +	etm4_cs_lock(drvdata, csa);
>  
>  	dev_dbg(etm_dev, "cpu: %d enable smp call done: %d\n",
>  		drvdata->cpu, rc);
> @@ -623,7 +639,7 @@ static void etm4_disable_hw(void *info)
>  	struct csdev_access *csa = &csdev->access;
>  	int i;
>  
> -	CS_UNLOCK(drvdata->base);
> +	etm4_cs_unlock(drvdata, csa);
>  	etm4_disable_arch_specific(drvdata);
>  
>  	if (!drvdata->skip_power_up) {
> @@ -665,8 +681,7 @@ static void etm4_disable_hw(void *info)
>  	}
>  
>  	coresight_disclaim_device_unlocked(csdev);
> -
> -	CS_LOCK(drvdata->base);
> +	etm4_cs_lock(drvdata, csa);
>  
>  	dev_dbg(&drvdata->csdev->dev,
>  		"cpu: %d disable smp call done\n", drvdata->cpu);
> @@ -776,8 +791,7 @@ static void etm4_init_arch_data(void *info)
>  
>  	/* Make sure all registers are accessible */
>  	etm4_os_unlock_csa(drvdata, csa);
> -
> -	CS_UNLOCK(drvdata->base);
> +	etm4_cs_unlock(drvdata, csa);
>  
>  	/* find all capabilities of the tracing unit */
>  	etmidr0 = etm4x_relaxed_read32(csa, TRCIDR0);
> @@ -942,7 +956,7 @@ static void etm4_init_arch_data(void *info)
>  	drvdata->nrseqstate = BMVAL(etmidr5, 25, 27);
>  	/* NUMCNTR, bits[30:28] number of counters available for tracing */
>  	drvdata->nr_cntr = BMVAL(etmidr5, 28, 30);
> -	CS_LOCK(drvdata->base);
> +	etm4_cs_lock(drvdata, csa);
>  }
>  
>  /* Set ELx trace filter access in the TRCVICTLR register */
> @@ -1323,8 +1337,7 @@ static int etm4_cpu_save(struct etmv4_drvdata *drvdata)
>  	dsb(sy);
>  	isb();
>  
> -	CS_UNLOCK(drvdata->base);
> -
> +	etm4_cs_unlock(drvdata, csa);
>  	/* Lock the OS lock to disable trace and external debugger access */
>  	etm4_os_lock(drvdata);
>  
> @@ -1437,7 +1450,7 @@ static int etm4_cpu_save(struct etmv4_drvdata *drvdata)
>  		etm4x_relaxed_write32(csa, (state->trcpdcr & ~TRCPDCR_PU),
>  				      TRCPDCR);
>  out:
> -	CS_LOCK(drvdata->base);
> +	etm4_cs_lock(drvdata, csa);
>  	return ret;
>  }
>  
> @@ -1448,8 +1461,7 @@ static void etm4_cpu_restore(struct etmv4_drvdata *drvdata)
>  	struct csdev_access tmp_csa = CSDEV_ACCESS_IOMEM(drvdata->base);
>  	struct csdev_access *csa = &tmp_csa;
>  
> -	CS_UNLOCK(drvdata->base);
> -
> +	etm4_cs_unlock(drvdata, csa);
>  	etm4x_relaxed_write32(csa, state->trcclaimset, TRCCLAIMSET);
>  
>  	etm4x_relaxed_write32(csa, state->trcprgctlr, TRCPRGCTLR);
> @@ -1534,7 +1546,7 @@ static void etm4_cpu_restore(struct etmv4_drvdata *drvdata)
>  
>  	/* Unlock the OS lock to re-enable trace and external debug access */
>  	etm4_os_unlock(drvdata);
> -	CS_LOCK(drvdata->base);
> +	etm4_cs_lock(drvdata, csa);
>  }
>  
>  static int etm4_cpu_pm_notify(struct notifier_block *nb, unsigned long cmd,
> -- 
> 2.24.1
> 
