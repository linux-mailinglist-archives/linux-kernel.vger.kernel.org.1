Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E781C2C8F9C
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 22:06:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729296AbgK3VFb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 16:05:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728013AbgK3VFb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 16:05:31 -0500
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69729C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 13:04:50 -0800 (PST)
Received: by mail-pl1-x643.google.com with SMTP id t18so7200422plo.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 13:04:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=82yKvbW6UAPr1E6eoidRMUQDPhj1TCTGRsTGhmU+Y7s=;
        b=Hhw4i5mBWoKWMntkN9BBmMhGtmG4wLZpSLqZr4NmHDCGjpDb8wiWG8oUx0s5ykI05A
         I12SZiXIMpAXwHlHMKJNietLBzAaEIW63Dt0kMnYf6qqYdZHqQNCNA387FcCSqbs27/a
         aQovMpuDqbcAy6NiYBd38r9I6B6rZ97m0dyK9OZGnehMNJp6Dnrs8l5ohbQ06z+i8635
         xI/xO2RozfEsSID8c8ouUKHSC2fO8Tp2IxKUimv+Fbe6ecUQXvClQ6yD2lth3ljK77s7
         wjrIWtAMSAub+GcOJbaWsoBFDBC/MWTBSSAoZE9og7wk8tXKBRy05SrVNLqvN0n57Nz3
         W2xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=82yKvbW6UAPr1E6eoidRMUQDPhj1TCTGRsTGhmU+Y7s=;
        b=DijxS2gRX6hme0WtgyiWWaRrmyv5am8abBMujygJ+/A7ly5xfIUxb57wejpAAOrLD6
         Fs+vpfvJx92jPrNBGSKX5Kk/0UX4bozUeYCOshYQbYBP4Zb9xXVZJmOB1Ff0y59NJUPv
         btD9FyHFHGXOHUXh+4VPnBCFCy95DSN8CiseHhJ7IAWdHzdC/yqUQ72WLCUFG7LqOpuw
         7ZxmOgudUW8G9OiUODrTp7TzbGi5pfXIuPRo0lM4+LaBidj+gD9FFXZ8Wzg4L/z4clKy
         6mtezrViHDXQS87UvTIrkL2S1QyGB7MkzbAsrtTwauYr+5Vx2aIXm9FHKbS5ZaPFYFal
         H9eA==
X-Gm-Message-State: AOAM531nLKJtQM4wVw3b/4l1gpTf0MqHdr3pCvGCini6gaJEB+Cg/c0+
        7mXE05Ps9Cj//4PwigA3z+8xlQ==
X-Google-Smtp-Source: ABdhPJwVHH9+mqx5mPpD2ihKTIzx3Ys+/oyA+VPnIgv37VNUEg1N3NUJhL/oArDfFwAU0VL7S12KOQ==
X-Received: by 2002:a17:902:bf0b:b029:da:274:c754 with SMTP id bi11-20020a170902bf0bb02900da0274c754mr20650013plb.43.1606770289734;
        Mon, 30 Nov 2020 13:04:49 -0800 (PST)
Received: from xps15 (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id x10sm16813724pga.70.2020.11.30.13.04.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Nov 2020 13:04:49 -0800 (PST)
Date:   Mon, 30 Nov 2020 14:04:46 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, mike.leach@linaro.org,
        linux-kernel@vger.kernel.org, anshuman.khandual@arm.com,
        jonathan.zhouwen@huawei.com, coresight@lists.linaro.org
Subject: Re: [PATCH v4 06/25] coresight: Convert claim/disclaim operations to
 use access wrappers
Message-ID: <20201130210446.GF1092947@xps15>
References: <20201119164547.2982871-1-suzuki.poulose@arm.com>
 <20201119164547.2982871-7-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201119164547.2982871-7-suzuki.poulose@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 19, 2020 at 04:45:28PM +0000, Suzuki K Poulose wrote:
> Convert the generic CLAIM tag management APIs to use the
> device access layer abstraction.
> 
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: Mike Leach <mike.leach@linaro.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
> Changes since V3:
>  - Removed WARN_ON(!csdev) check. (Mathieu)
>  - Fixed indentation (Mathieu)
> ---
>  drivers/hwtracing/coresight/coresight-catu.c  |  6 +-
>  drivers/hwtracing/coresight/coresight-core.c  | 66 +++++++++++--------
>  .../hwtracing/coresight/coresight-cti-core.c  | 17 +++--
>  drivers/hwtracing/coresight/coresight-etb10.c |  4 +-
>  .../coresight/coresight-etm3x-core.c          |  8 ++-
>  .../coresight/coresight-etm4x-core.c          |  4 +-
>  .../hwtracing/coresight/coresight-funnel.c    |  6 +-
>  .../coresight/coresight-replicator.c          | 12 ++--
>  .../hwtracing/coresight/coresight-tmc-etf.c   | 10 +--
>  .../hwtracing/coresight/coresight-tmc-etr.c   |  4 +-
>  include/linux/coresight.h                     | 16 ++---
>  11 files changed, 91 insertions(+), 62 deletions(-)
> 

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

> diff --git a/drivers/hwtracing/coresight/coresight-catu.c b/drivers/hwtracing/coresight/coresight-catu.c
> index 34c74b05c542..438063523463 100644
> --- a/drivers/hwtracing/coresight/coresight-catu.c
> +++ b/drivers/hwtracing/coresight/coresight-catu.c
> @@ -412,6 +412,7 @@ static int catu_enable_hw(struct catu_drvdata *drvdata, void *data)
>  	u32 control, mode;
>  	struct etr_buf *etr_buf = data;
>  	struct device *dev = &drvdata->csdev->dev;
> +	struct coresight_device *csdev = drvdata->csdev;
>  
>  	if (catu_wait_for_ready(drvdata))
>  		dev_warn(dev, "Timeout while waiting for READY\n");
> @@ -422,7 +423,7 @@ static int catu_enable_hw(struct catu_drvdata *drvdata, void *data)
>  		return -EBUSY;
>  	}
>  
> -	rc = coresight_claim_device_unlocked(drvdata->base);
> +	rc = coresight_claim_device_unlocked(csdev);
>  	if (rc)
>  		return rc;
>  
> @@ -466,9 +467,10 @@ static int catu_disable_hw(struct catu_drvdata *drvdata)
>  {
>  	int rc = 0;
>  	struct device *dev = &drvdata->csdev->dev;
> +	struct coresight_device *csdev = drvdata->csdev;
>  
>  	catu_write_control(drvdata, 0);
> -	coresight_disclaim_device_unlocked(drvdata->base);
> +	coresight_disclaim_device_unlocked(csdev);
>  	if (catu_wait_for_ready(drvdata)) {
>  		dev_info(dev, "Timeout while waiting for READY\n");
>  		rc = -EAGAIN;
> diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
> index f8fa53490753..3d344a21ef7f 100644
> --- a/drivers/hwtracing/coresight/coresight-core.c
> +++ b/drivers/hwtracing/coresight/coresight-core.c
> @@ -145,30 +145,32 @@ static int coresight_find_link_outport(struct coresight_device *csdev,
>  	return -ENODEV;
>  }
>  
> -static inline u32 coresight_read_claim_tags(void __iomem *base)
> +static inline u32 coresight_read_claim_tags(struct coresight_device *csdev)
>  {
> -	return readl_relaxed(base + CORESIGHT_CLAIMCLR);
> +	return csdev_access_relaxed_read32(&csdev->access, CORESIGHT_CLAIMCLR);
>  }
>  
> -static inline bool coresight_is_claimed_self_hosted(void __iomem *base)
> +static inline bool coresight_is_claimed_self_hosted(struct coresight_device *csdev)
>  {
> -	return coresight_read_claim_tags(base) == CORESIGHT_CLAIM_SELF_HOSTED;
> +	return coresight_read_claim_tags(csdev) == CORESIGHT_CLAIM_SELF_HOSTED;
>  }
>  
> -static inline bool coresight_is_claimed_any(void __iomem *base)
> +static inline bool coresight_is_claimed_any(struct coresight_device *csdev)
>  {
> -	return coresight_read_claim_tags(base) != 0;
> +	return coresight_read_claim_tags(csdev) != 0;
>  }
>  
> -static inline void coresight_set_claim_tags(void __iomem *base)
> +static inline void coresight_set_claim_tags(struct coresight_device *csdev)
>  {
> -	writel_relaxed(CORESIGHT_CLAIM_SELF_HOSTED, base + CORESIGHT_CLAIMSET);
> +	csdev_access_relaxed_write32(&csdev->access, CORESIGHT_CLAIM_SELF_HOSTED,
> +				     CORESIGHT_CLAIMSET);
>  	isb();
>  }
>  
> -static inline void coresight_clear_claim_tags(void __iomem *base)
> +static inline void coresight_clear_claim_tags(struct coresight_device *csdev)
>  {
> -	writel_relaxed(CORESIGHT_CLAIM_SELF_HOSTED, base + CORESIGHT_CLAIMCLR);
> +	csdev_access_relaxed_write32(&csdev->access, CORESIGHT_CLAIM_SELF_HOSTED,
> +				     CORESIGHT_CLAIMCLR);
>  	isb();
>  }
>  
> @@ -182,27 +184,33 @@ static inline void coresight_clear_claim_tags(void __iomem *base)
>   * Called with CS_UNLOCKed for the component.
>   * Returns : 0 on success
>   */
> -int coresight_claim_device_unlocked(void __iomem *base)
> +int coresight_claim_device_unlocked(struct coresight_device *csdev)
>  {
> -	if (coresight_is_claimed_any(base))
> +	if (WARN_ON(!csdev))
> +		return -EINVAL;
> +
> +	if (coresight_is_claimed_any(csdev))
>  		return -EBUSY;
>  
> -	coresight_set_claim_tags(base);
> -	if (coresight_is_claimed_self_hosted(base))
> +	coresight_set_claim_tags(csdev);
> +	if (coresight_is_claimed_self_hosted(csdev))
>  		return 0;
>  	/* There was a race setting the tags, clean up and fail */
> -	coresight_clear_claim_tags(base);
> +	coresight_clear_claim_tags(csdev);
>  	return -EBUSY;
>  }
>  EXPORT_SYMBOL_GPL(coresight_claim_device_unlocked);
>  
> -int coresight_claim_device(void __iomem *base)
> +int coresight_claim_device(struct coresight_device *csdev)
>  {
>  	int rc;
>  
> -	CS_UNLOCK(base);
> -	rc = coresight_claim_device_unlocked(base);
> -	CS_LOCK(base);
> +	if (WARN_ON(!csdev))
> +		return -EINVAL;
> +
> +	CS_UNLOCK(csdev->access.base);
> +	rc = coresight_claim_device_unlocked(csdev);
> +	CS_LOCK(csdev->access.base);
>  
>  	return rc;
>  }
> @@ -212,11 +220,14 @@ EXPORT_SYMBOL_GPL(coresight_claim_device);
>   * coresight_disclaim_device_unlocked : Clear the claim tags for the device.
>   * Called with CS_UNLOCKed for the component.
>   */
> -void coresight_disclaim_device_unlocked(void __iomem *base)
> +void coresight_disclaim_device_unlocked(struct coresight_device *csdev)
>  {
>  
> -	if (coresight_is_claimed_self_hosted(base))
> -		coresight_clear_claim_tags(base);
> +	if (WARN_ON(!csdev))
> +		return;
> +
> +	if (coresight_is_claimed_self_hosted(csdev))
> +		coresight_clear_claim_tags(csdev);
>  	else
>  		/*
>  		 * The external agent may have not honoured our claim
> @@ -227,11 +238,14 @@ void coresight_disclaim_device_unlocked(void __iomem *base)
>  }
>  EXPORT_SYMBOL_GPL(coresight_disclaim_device_unlocked);
>  
> -void coresight_disclaim_device(void __iomem *base)
> +void coresight_disclaim_device(struct coresight_device *csdev)
>  {
> -	CS_UNLOCK(base);
> -	coresight_disclaim_device_unlocked(base);
> -	CS_LOCK(base);
> +	if (WARN_ON(!csdev))
> +		return;
> +
> +	CS_UNLOCK(csdev->access.base);
> +	coresight_disclaim_device_unlocked(csdev);
> +	CS_LOCK(csdev->access.base);
>  }
>  EXPORT_SYMBOL_GPL(coresight_disclaim_device);
>  
> diff --git a/drivers/hwtracing/coresight/coresight-cti-core.c b/drivers/hwtracing/coresight/coresight-cti-core.c
> index 3bb0de97d66e..5651d7f61a70 100644
> --- a/drivers/hwtracing/coresight/coresight-cti-core.c
> +++ b/drivers/hwtracing/coresight/coresight-cti-core.c
> @@ -102,7 +102,7 @@ static int cti_enable_hw(struct cti_drvdata *drvdata)
>  		goto cti_state_unchanged;
>  
>  	/* claim the device */
> -	rc = coresight_claim_device(drvdata->base);
> +	rc = coresight_claim_device(drvdata->csdev);
>  	if (rc)
>  		goto cti_err_not_enabled;
>  
> @@ -136,7 +136,7 @@ static void cti_cpuhp_enable_hw(struct cti_drvdata *drvdata)
>  		goto cti_hp_not_enabled;
>  
>  	/* try to claim the device */
> -	if (coresight_claim_device(drvdata->base))
> +	if (coresight_claim_device(drvdata->csdev))
>  		goto cti_hp_not_enabled;
>  
>  	cti_write_all_hw_regs(drvdata);
> @@ -154,6 +154,7 @@ static int cti_disable_hw(struct cti_drvdata *drvdata)
>  {
>  	struct cti_config *config = &drvdata->config;
>  	struct device *dev = &drvdata->csdev->dev;
> +	struct coresight_device *csdev = drvdata->csdev;
>  
>  	spin_lock(&drvdata->spinlock);
>  
> @@ -171,7 +172,7 @@ static int cti_disable_hw(struct cti_drvdata *drvdata)
>  	writel_relaxed(0, drvdata->base + CTICONTROL);
>  	config->hw_enabled = false;
>  
> -	coresight_disclaim_device_unlocked(drvdata->base);
> +	coresight_disclaim_device_unlocked(csdev);
>  	CS_LOCK(drvdata->base);
>  	spin_unlock(&drvdata->spinlock);
>  	pm_runtime_put(dev);
> @@ -655,6 +656,7 @@ static int cti_cpu_pm_notify(struct notifier_block *nb, unsigned long cmd,
>  			     void *v)
>  {
>  	struct cti_drvdata *drvdata;
> +	struct coresight_device *csdev;
>  	unsigned int cpu = smp_processor_id();
>  	int notify_res = NOTIFY_OK;
>  
> @@ -662,6 +664,7 @@ static int cti_cpu_pm_notify(struct notifier_block *nb, unsigned long cmd,
>  		return NOTIFY_OK;
>  
>  	drvdata = cti_cpu_drvdata[cpu];
> +	csdev = drvdata->csdev;
>  
>  	if (WARN_ON_ONCE(drvdata->ctidev.cpu != cpu))
>  		return NOTIFY_BAD;
> @@ -673,13 +676,13 @@ static int cti_cpu_pm_notify(struct notifier_block *nb, unsigned long cmd,
>  		/* CTI regs all static - we have a copy & nothing to save */
>  		drvdata->config.hw_powered = false;
>  		if (drvdata->config.hw_enabled)
> -			coresight_disclaim_device(drvdata->base);
> +			coresight_disclaim_device(csdev);
>  		break;
>  
>  	case CPU_PM_ENTER_FAILED:
>  		drvdata->config.hw_powered = true;
>  		if (drvdata->config.hw_enabled) {
> -			if (coresight_claim_device(drvdata->base))
> +			if (coresight_claim_device(csdev))
>  				drvdata->config.hw_enabled = false;
>  		}
>  		break;
> @@ -692,7 +695,7 @@ static int cti_cpu_pm_notify(struct notifier_block *nb, unsigned long cmd,
>  		/* check enable reference count to enable HW */
>  		if (atomic_read(&drvdata->config.enable_req_count)) {
>  			/* check we can claim the device as we re-power */
> -			if (coresight_claim_device(drvdata->base))
> +			if (coresight_claim_device(csdev))
>  				goto cti_notify_exit;
>  
>  			drvdata->config.hw_enabled = true;
> @@ -736,7 +739,7 @@ static int cti_dying_cpu(unsigned int cpu)
>  	spin_lock(&drvdata->spinlock);
>  	drvdata->config.hw_powered = false;
>  	if (drvdata->config.hw_enabled)
> -		coresight_disclaim_device(drvdata->base);
> +		coresight_disclaim_device(drvdata->csdev);
>  	spin_unlock(&drvdata->spinlock);
>  	return 0;
>  }
> diff --git a/drivers/hwtracing/coresight/coresight-etb10.c b/drivers/hwtracing/coresight/coresight-etb10.c
> index f643e5bc3aa5..bcec58e7e22f 100644
> --- a/drivers/hwtracing/coresight/coresight-etb10.c
> +++ b/drivers/hwtracing/coresight/coresight-etb10.c
> @@ -132,7 +132,7 @@ static void __etb_enable_hw(struct etb_drvdata *drvdata)
>  
>  static int etb_enable_hw(struct etb_drvdata *drvdata)
>  {
> -	int rc = coresight_claim_device(drvdata->base);
> +	int rc = coresight_claim_device(drvdata->csdev);
>  
>  	if (rc)
>  		return rc;
> @@ -345,7 +345,7 @@ static void etb_disable_hw(struct etb_drvdata *drvdata)
>  {
>  	__etb_disable_hw(drvdata);
>  	etb_dump_hw(drvdata);
> -	coresight_disclaim_device(drvdata->base);
> +	coresight_disclaim_device(drvdata->csdev);
>  }
>  
>  static int etb_disable(struct coresight_device *csdev)
> diff --git a/drivers/hwtracing/coresight/coresight-etm3x-core.c b/drivers/hwtracing/coresight/coresight-etm3x-core.c
> index 36c5b0ae1b43..70d6d809cb47 100644
> --- a/drivers/hwtracing/coresight/coresight-etm3x-core.c
> +++ b/drivers/hwtracing/coresight/coresight-etm3x-core.c
> @@ -358,10 +358,11 @@ static int etm_enable_hw(struct etm_drvdata *drvdata)
>  	int i, rc;
>  	u32 etmcr;
>  	struct etm_config *config = &drvdata->config;
> +	struct coresight_device *csdev = drvdata->csdev;
>  
>  	CS_UNLOCK(drvdata->base);
>  
> -	rc = coresight_claim_device_unlocked(drvdata->base);
> +	rc = coresight_claim_device_unlocked(csdev);
>  	if (rc)
>  		goto done;
>  
> @@ -566,6 +567,7 @@ static void etm_disable_hw(void *info)
>  	int i;
>  	struct etm_drvdata *drvdata = info;
>  	struct etm_config *config = &drvdata->config;
> +	struct coresight_device *csdev = drvdata->csdev;
>  
>  	CS_UNLOCK(drvdata->base);
>  	etm_set_prog(drvdata);
> @@ -577,7 +579,7 @@ static void etm_disable_hw(void *info)
>  		config->cntr_val[i] = etm_readl(drvdata, ETMCNTVRn(i));
>  
>  	etm_set_pwrdwn(drvdata);
> -	coresight_disclaim_device_unlocked(drvdata->base);
> +	coresight_disclaim_device_unlocked(csdev);
>  
>  	CS_LOCK(drvdata->base);
>  
> @@ -602,7 +604,7 @@ static void etm_disable_perf(struct coresight_device *csdev)
>  	 * power down the tracer.
>  	 */
>  	etm_set_pwrdwn(drvdata);
> -	coresight_disclaim_device_unlocked(drvdata->base);
> +	coresight_disclaim_device_unlocked(csdev);
>  
>  	CS_LOCK(drvdata->base);
>  }
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> index 4335ed97f9c7..144727a1142b 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> @@ -131,7 +131,7 @@ static int etm4_enable_hw(struct etmv4_drvdata *drvdata)
>  
>  	etm4_os_unlock(drvdata);
>  
> -	rc = coresight_claim_device_unlocked(drvdata->base);
> +	rc = coresight_claim_device_unlocked(csdev);
>  	if (rc)
>  		goto done;
>  
> @@ -539,7 +539,7 @@ static void etm4_disable_hw(void *info)
>  			readl_relaxed(drvdata->base + TRCCNTVRn(i));
>  	}
>  
> -	coresight_disclaim_device_unlocked(drvdata->base);
> +	coresight_disclaim_device_unlocked(csdev);
>  
>  	CS_LOCK(drvdata->base);
>  
> diff --git a/drivers/hwtracing/coresight/coresight-funnel.c b/drivers/hwtracing/coresight/coresight-funnel.c
> index 18c3e112a813..bae6eeabb0b0 100644
> --- a/drivers/hwtracing/coresight/coresight-funnel.c
> +++ b/drivers/hwtracing/coresight/coresight-funnel.c
> @@ -52,13 +52,14 @@ static int dynamic_funnel_enable_hw(struct funnel_drvdata *drvdata, int port)
>  {
>  	u32 functl;
>  	int rc = 0;
> +	struct coresight_device *csdev = drvdata->csdev;
>  
>  	CS_UNLOCK(drvdata->base);
>  
>  	functl = readl_relaxed(drvdata->base + FUNNEL_FUNCTL);
>  	/* Claim the device only when we enable the first slave */
>  	if (!(functl & FUNNEL_ENSx_MASK)) {
> -		rc = coresight_claim_device_unlocked(drvdata->base);
> +		rc = coresight_claim_device_unlocked(csdev);
>  		if (rc)
>  			goto done;
>  	}
> @@ -101,6 +102,7 @@ static void dynamic_funnel_disable_hw(struct funnel_drvdata *drvdata,
>  				      int inport)
>  {
>  	u32 functl;
> +	struct coresight_device *csdev = drvdata->csdev;
>  
>  	CS_UNLOCK(drvdata->base);
>  
> @@ -110,7 +112,7 @@ static void dynamic_funnel_disable_hw(struct funnel_drvdata *drvdata,
>  
>  	/* Disclaim the device if none of the slaves are now active */
>  	if (!(functl & FUNNEL_ENSx_MASK))
> -		coresight_disclaim_device_unlocked(drvdata->base);
> +		coresight_disclaim_device_unlocked(csdev);
>  
>  	CS_LOCK(drvdata->base);
>  }
> diff --git a/drivers/hwtracing/coresight/coresight-replicator.c b/drivers/hwtracing/coresight/coresight-replicator.c
> index 14781da6579e..aa551dc4abd8 100644
> --- a/drivers/hwtracing/coresight/coresight-replicator.c
> +++ b/drivers/hwtracing/coresight/coresight-replicator.c
> @@ -45,12 +45,14 @@ struct replicator_drvdata {
>  
>  static void dynamic_replicator_reset(struct replicator_drvdata *drvdata)
>  {
> +	struct coresight_device *csdev = drvdata->csdev;
> +
>  	CS_UNLOCK(drvdata->base);
>  
> -	if (!coresight_claim_device_unlocked(drvdata->base)) {
> +	if (!coresight_claim_device_unlocked(csdev)) {
>  		writel_relaxed(0xff, drvdata->base + REPLICATOR_IDFILTER0);
>  		writel_relaxed(0xff, drvdata->base + REPLICATOR_IDFILTER1);
> -		coresight_disclaim_device_unlocked(drvdata->base);
> +		coresight_disclaim_device_unlocked(csdev);
>  	}
>  
>  	CS_LOCK(drvdata->base);
> @@ -70,6 +72,7 @@ static int dynamic_replicator_enable(struct replicator_drvdata *drvdata,
>  {
>  	int rc = 0;
>  	u32 id0val, id1val;
> +	struct coresight_device *csdev = drvdata->csdev;
>  
>  	CS_UNLOCK(drvdata->base);
>  
> @@ -84,7 +87,7 @@ static int dynamic_replicator_enable(struct replicator_drvdata *drvdata,
>  		id0val = id1val = 0xff;
>  
>  	if (id0val == 0xff && id1val == 0xff)
> -		rc = coresight_claim_device_unlocked(drvdata->base);
> +		rc = coresight_claim_device_unlocked(csdev);
>  
>  	if (!rc) {
>  		switch (outport) {
> @@ -140,6 +143,7 @@ static void dynamic_replicator_disable(struct replicator_drvdata *drvdata,
>  				       int inport, int outport)
>  {
>  	u32 reg;
> +	struct coresight_device *csdev = drvdata->csdev;
>  
>  	switch (outport) {
>  	case 0:
> @@ -160,7 +164,7 @@ static void dynamic_replicator_disable(struct replicator_drvdata *drvdata,
>  
>  	if ((readl_relaxed(drvdata->base + REPLICATOR_IDFILTER0) == 0xff) &&
>  	    (readl_relaxed(drvdata->base + REPLICATOR_IDFILTER1) == 0xff))
> -		coresight_disclaim_device_unlocked(drvdata->base);
> +		coresight_disclaim_device_unlocked(csdev);
>  	CS_LOCK(drvdata->base);
>  }
>  
> diff --git a/drivers/hwtracing/coresight/coresight-tmc-etf.c b/drivers/hwtracing/coresight/coresight-tmc-etf.c
> index 989d965f3d90..45b85edfc690 100644
> --- a/drivers/hwtracing/coresight/coresight-tmc-etf.c
> +++ b/drivers/hwtracing/coresight/coresight-tmc-etf.c
> @@ -37,7 +37,7 @@ static void __tmc_etb_enable_hw(struct tmc_drvdata *drvdata)
>  
>  static int tmc_etb_enable_hw(struct tmc_drvdata *drvdata)
>  {
> -	int rc = coresight_claim_device(drvdata->base);
> +	int rc = coresight_claim_device(drvdata->csdev);
>  
>  	if (rc)
>  		return rc;
> @@ -88,7 +88,7 @@ static void __tmc_etb_disable_hw(struct tmc_drvdata *drvdata)
>  static void tmc_etb_disable_hw(struct tmc_drvdata *drvdata)
>  {
>  	__tmc_etb_disable_hw(drvdata);
> -	coresight_disclaim_device(drvdata->base);
> +	coresight_disclaim_device(drvdata->csdev);
>  }
>  
>  static void __tmc_etf_enable_hw(struct tmc_drvdata *drvdata)
> @@ -109,7 +109,7 @@ static void __tmc_etf_enable_hw(struct tmc_drvdata *drvdata)
>  
>  static int tmc_etf_enable_hw(struct tmc_drvdata *drvdata)
>  {
> -	int rc = coresight_claim_device(drvdata->base);
> +	int rc = coresight_claim_device(drvdata->csdev);
>  
>  	if (rc)
>  		return rc;
> @@ -120,11 +120,13 @@ static int tmc_etf_enable_hw(struct tmc_drvdata *drvdata)
>  
>  static void tmc_etf_disable_hw(struct tmc_drvdata *drvdata)
>  {
> +	struct coresight_device *csdev = drvdata->csdev;
> +
>  	CS_UNLOCK(drvdata->base);
>  
>  	tmc_flush_and_stop(drvdata);
>  	tmc_disable_hw(drvdata);
> -	coresight_disclaim_device_unlocked(drvdata->base);
> +	coresight_disclaim_device_unlocked(csdev);
>  	CS_LOCK(drvdata->base);
>  }
>  
> diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
> index 525f0ecc129c..abe094d2227e 100644
> --- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
> +++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
> @@ -1038,7 +1038,7 @@ static int tmc_etr_enable_hw(struct tmc_drvdata *drvdata,
>  	rc = tmc_etr_enable_catu(drvdata, etr_buf);
>  	if (rc)
>  		return rc;
> -	rc = coresight_claim_device(drvdata->base);
> +	rc = coresight_claim_device(drvdata->csdev);
>  	if (!rc) {
>  		drvdata->etr_buf = etr_buf;
>  		__tmc_etr_enable_hw(drvdata);
> @@ -1132,7 +1132,7 @@ void tmc_etr_disable_hw(struct tmc_drvdata *drvdata)
>  	__tmc_etr_disable_hw(drvdata);
>  	/* Disable CATU device if this ETR is connected to one */
>  	tmc_etr_disable_catu(drvdata);
> -	coresight_disclaim_device(drvdata->base);
> +	coresight_disclaim_device(drvdata->csdev);
>  	/* Reset the ETR buf used by hardware */
>  	drvdata->etr_buf = NULL;
>  }
> diff --git a/include/linux/coresight.h b/include/linux/coresight.h
> index 595ceb5f8d53..cabc0977a96e 100644
> --- a/include/linux/coresight.h
> +++ b/include/linux/coresight.h
> @@ -467,11 +467,11 @@ extern void coresight_disable(struct coresight_device *csdev);
>  extern int coresight_timeout(struct csdev_access *csa, u32 offset,
>  			     int position, int value);
>  
> -extern int coresight_claim_device(void __iomem *base);
> -extern int coresight_claim_device_unlocked(void __iomem *base);
> +extern int coresight_claim_device(struct coresight_device *csdev);
> +extern int coresight_claim_device_unlocked(struct coresight_device *csdev);
>  
> -extern void coresight_disclaim_device(void __iomem *base);
> -extern void coresight_disclaim_device_unlocked(void __iomem *base);
> +extern void coresight_disclaim_device(struct coresight_device *csdev);
> +extern void coresight_disclaim_device_unlocked(struct coresight_device *csdev);
>  extern char *coresight_alloc_device_name(struct coresight_dev_list *devs,
>  					 struct device *dev);
>  
> @@ -506,18 +506,18 @@ static inline int coresight_timeout(struct csdev_access *csa,
>  	return 1;
>  }
>  
> -static inline int coresight_claim_device_unlocked(void __iomem *base)
> +static inline int coresight_claim_device_unlocked(struct coresight_device *csdev)
>  {
>  	return -EINVAL;
>  }
>  
> -static inline int coresight_claim_device(void __iomem *base)
> +static inline int coresight_claim_device(struct coresight_device *csdev)
>  {
>  	return -EINVAL;
>  }
>  
> -static inline void coresight_disclaim_device(void __iomem *base) {}
> -static inline void coresight_disclaim_device_unlocked(void __iomem *base) {}
> +static inline void coresight_disclaim_device(struct coresight_device *csdev) {}
> +static inline void coresight_disclaim_device_unlocked(struct coresight_device *csdev) {}
>  
>  static inline bool coresight_loses_context_with_cpu(struct device *dev)
>  {
> -- 
> 2.24.1
> 
