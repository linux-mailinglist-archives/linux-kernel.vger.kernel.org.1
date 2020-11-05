Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10D2C2A893B
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 22:50:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732438AbgKEVuD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 16:50:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731508AbgKEVuD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 16:50:03 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75383C0613CF
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 13:50:03 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id 13so2408375pfy.4
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 13:50:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GEyB3kmbteLsYKAbt8oIKy4Y+BOTmmt14jwAFNUC/x0=;
        b=WBVUglPlSvhsXqGSqJoe5JAZTSNOHhrsRpBfrSXGb+ABmsyan6BQwELumY4WmiCXdG
         Iv4Ghl083PTkEKQqjcakXaglMGFLafCwNnPEwqAqCXNlGmZhUgAjK9sQPuNsaK/1ifkL
         bYnt4ZY66zDCHrrIV66c6eFmWv3Nl5Q2i7NNJho2ArClbP4gxCidTlSz8AzBuu7KPdv/
         863F5iFGOwSeLHEvhSCo2oE/P+KOc2X+Qjo+aAVjkXmHs0MDYLuvymXRG8nOY0/75nUV
         y/B4ODWmToTmwoIJHGJwCR1iJowVXWbGqAaGZsyosIRllDDELFYOCv4yqn/1AMjKV5aF
         auvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GEyB3kmbteLsYKAbt8oIKy4Y+BOTmmt14jwAFNUC/x0=;
        b=VdVvBfseXoFRqSt2QGXxrzJXOaT2mTb0sLfIHweDiKNaMJsaSz7JyKRZRbvj5x6Zb7
         X2OOcrBFF7vNj2eygQ/HoXrbiZc4sAZs33A8eN8HEPT8WU/2AF9EHURMqrGRQyxojuzf
         SdPs0ZBsu4Wc7eO/f+DiiWEgK/n5wutMuzQf3yRTF+PoDCZTmXe3ogfMUBhinSWAH8Pv
         Nl6ZqqwxIGD6N+JC40x2FuhJgRUlhtdZ6ZU8spC2CJF/qEqe18jEL3KvqgafqW0BmSV0
         idAcYnJ1ldr05Cys98NrIFANJJhmmoGlmQthqtmZbMMwCUQQnfWPinjC08w5OMs4ncV3
         J32Q==
X-Gm-Message-State: AOAM533JE3Toa3PlnccqjIW6kHY4LWaWjKgewDaW5Oj/xMKj60606NMz
        QGcO8kKTvLcK9O/n/o8YEPJZXZ4bagqa0g==
X-Google-Smtp-Source: ABdhPJxLPlOhrT1KfqVcU7ImtVVjqgRrezb4k0T7w04fr9l6xv/RD/npvrjJu6OhLhu+3QNrH5Emwg==
X-Received: by 2002:a05:6a00:2126:b029:18b:6372:d444 with SMTP id n6-20020a056a002126b029018b6372d444mr4522632pfj.26.1604613002856;
        Thu, 05 Nov 2020 13:50:02 -0800 (PST)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id j11sm3530590pfe.80.2020.11.05.13.50.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 13:50:02 -0800 (PST)
Date:   Thu, 5 Nov 2020 14:50:00 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, mike.leach@linaro.org,
        coresight@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 16/26] coresight: etm4x: Check for Software Lock
Message-ID: <20201105215000.GB3047244@xps15>
References: <20201028220945.3826358-1-suzuki.poulose@arm.com>
 <20201028220945.3826358-18-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201028220945.3826358-18-suzuki.poulose@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 28, 2020 at 10:09:35PM +0000, Suzuki K Poulose wrote:
> The Software lock is not implemented for system instructions
> based accesses. So, skip the lock register access in such
> cases.
> 
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  .../coresight/coresight-etm4x-core.c          | 40 ++++++++++++-------
>  1 file changed, 25 insertions(+), 15 deletions(-)
>

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
 
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> index a5c914b16e59..a12d58a04c5d 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> @@ -121,6 +121,21 @@ static void etm4_os_lock(struct etmv4_drvdata *drvdata)
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
> +{
> +	if (csa->io_mem)
> +		CS_UNLOCK(csa->base);
> +}
> +
>  static bool etm4_arch_supported(u8 arch)
>  {
>  	/* Mask out the minor version number */
> @@ -160,8 +175,7 @@ static int etm4_enable_hw(struct etmv4_drvdata *drvdata)
>  	struct device *etm_dev = &csdev->dev;
>  	struct csdev_access *csa = &csdev->access;
>  
> -	CS_UNLOCK(drvdata->base);
> -
> +	etm4_cs_unlock(drvdata, csa);
>  	etm4_os_unlock(drvdata);
>  
>  	rc = coresight_claim_device_unlocked(csdev);
> @@ -262,7 +276,7 @@ static int etm4_enable_hw(struct etmv4_drvdata *drvdata)
>  	isb();
>  
>  done:
> -	CS_LOCK(drvdata->base);
> +	etm4_cs_lock(drvdata, csa);
>  
>  	dev_dbg(etm_dev, "cpu: %d enable smp call done: %d\n",
>  		drvdata->cpu, rc);
> @@ -519,7 +533,7 @@ static void etm4_disable_hw(void *info)
>  	struct csdev_access *csa = &csdev->access;
>  	int i;
>  
> -	CS_UNLOCK(drvdata->base);
> +	etm4_cs_unlock(drvdata, csa);
>  
>  	if (!drvdata->skip_power_up) {
>  		/* power can be removed from the trace unit now */
> @@ -560,8 +574,7 @@ static void etm4_disable_hw(void *info)
>  	}
>  
>  	coresight_disclaim_device_unlocked(csdev);
> -
> -	CS_LOCK(drvdata->base);
> +	etm4_cs_lock(drvdata, csa);
>  
>  	dev_dbg(&drvdata->csdev->dev,
>  		"cpu: %d disable smp call done\n", drvdata->cpu);
> @@ -671,8 +684,7 @@ static void etm4_init_arch_data(void *info)
>  
>  	/* Make sure all registers are accessible */
>  	etm4_os_unlock_csa(drvdata, csa);
> -
> -	CS_UNLOCK(drvdata->base);
> +	etm4_cs_unlock(drvdata, csa);
>  
>  	/* find all capabilities of the tracing unit */
>  	etmidr0 = etm4x_relaxed_read32(csa, TRCIDR0);
> @@ -837,7 +849,7 @@ static void etm4_init_arch_data(void *info)
>  	drvdata->nrseqstate = BMVAL(etmidr5, 25, 27);
>  	/* NUMCNTR, bits[30:28] number of counters available for tracing */
>  	drvdata->nr_cntr = BMVAL(etmidr5, 28, 30);
> -	CS_LOCK(drvdata->base);
> +	etm4_cs_lock(drvdata, csa);
>  }
>  
>  /* Set ELx trace filter access in the TRCVICTLR register */
> @@ -1218,8 +1230,7 @@ static int etm4_cpu_save(struct etmv4_drvdata *drvdata)
>  	dsb(sy);
>  	isb();
>  
> -	CS_UNLOCK(drvdata->base);
> -
> +	etm4_cs_unlock(drvdata, csa);
>  	/* Lock the OS lock to disable trace and external debugger access */
>  	etm4_os_lock(drvdata);
>  
> @@ -1330,7 +1341,7 @@ static int etm4_cpu_save(struct etmv4_drvdata *drvdata)
>  	etm4x_relaxed_write32(csa, (state->trcpdcr & ~TRCPDCR_PU), TRCPDCR);
>  
>  out:
> -	CS_LOCK(drvdata->base);
> +	etm4_cs_lock(drvdata, csa);
>  	return ret;
>  }
>  
> @@ -1341,8 +1352,7 @@ static void etm4_cpu_restore(struct etmv4_drvdata *drvdata)
>  	struct csdev_access tmp_csa = CSDEV_ACCESS_IOMEM(drvdata->base);
>  	struct csdev_access *csa = &tmp_csa;
>  
> -	CS_UNLOCK(drvdata->base);
> -
> +	etm4_cs_unlock(drvdata, csa);
>  	etm4x_relaxed_write32(csa, state->trcclaimset, TRCCLAIMSET);
>  
>  	etm4x_relaxed_write32(csa, state->trcprgctlr, TRCPRGCTLR);
> @@ -1426,7 +1436,7 @@ static void etm4_cpu_restore(struct etmv4_drvdata *drvdata)
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
