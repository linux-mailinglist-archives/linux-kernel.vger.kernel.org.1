Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90C8A2A4DC8
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 19:03:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728720AbgKCSDd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 13:03:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727688AbgKCSDc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 13:03:32 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB818C0613D1
        for <linux-kernel@vger.kernel.org>; Tue,  3 Nov 2020 10:03:32 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id w65so14937738pfd.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Nov 2020 10:03:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=s4mHwrcFlxVItgOP/jfAoS0hIwx51qGZO3nEOKs0gwU=;
        b=gaKefxnafRlRUzFT98aiOwqJcRATaoTKjV2UjNWQp+2EmK6zZSMO1yko0qJd25XqPk
         pM1iRWraCrR+nZCzlvjZsK1PUHhfZnqK3dY/3lMmORg/f7P1se4gB51NIHhc+Mpnm0RP
         q1ChI3bNuP7BsnOW2HYs0MR8sukRml4DZw1byuB0LuGRQ8xmcO/T0TbtAmr273fme/PQ
         OnpH9OL2Ij8NvBMUM+HCdiNXeF5AwtcJGUXUxO6Gf3BjSDibzsQvEX9xCI+sFpH/kdco
         AyQ51GhROxNdnQl2NL1rlirAvb64SZYLF+YJv+QbmPRYI6SZYDhIBWsnbwPCvzMr8RSL
         RI4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=s4mHwrcFlxVItgOP/jfAoS0hIwx51qGZO3nEOKs0gwU=;
        b=nOWQ2NFavQPnr5TAKesOOCmZiINT2Q/WP9hFfem0aMbH+hfbEvVLtfBlYGosdX+pPb
         18xps/5HuFCieURvGXvPwOI/kP1V2Q5T+hqnEOiJCeryRFR+UHjZWYVPsTpsLhPybTDH
         IkvJTwsrWAvGS1mibkG/PKDUjkPw10MNupkXQ1Zi3APzcTwGTxjE8UKsvHQ7YqCHuXvB
         qUB/yyTE34tCha/8Z+PkxQHX63doD/W1GcwKZH3vX81oWz8xq0Q3xK71FitqRuqXkR8G
         pSIJBLIUskbSJ/zxu8t+v1Bhz601N4xgB/Me8hNDwq3ks3gXuVxBgFysYUK3ujWdCwSs
         zzQw==
X-Gm-Message-State: AOAM530VCxJUbJx/ZrU4ExDWF4XNNs+i/sjZ3fIyQ7Q6VxgJpZeDiv9n
        Gmq/F/dhYxgwpTQej1255fDrVQ==
X-Google-Smtp-Source: ABdhPJy+sPpbwVTD0Hhc1Tymn19Xgxze5A4Q3FzoNsMetXlIbdzUmKadno3oYZGjHlLUe5JXVKEujQ==
X-Received: by 2002:a62:5f83:0:b029:18a:e039:4908 with SMTP id t125-20020a625f830000b029018ae0394908mr11619623pfb.23.1604426611987;
        Tue, 03 Nov 2020 10:03:31 -0800 (PST)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id jy19sm4352443pjb.9.2020.11.03.10.03.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2020 10:03:31 -0800 (PST)
Date:   Tue, 3 Nov 2020 11:03:29 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, mike.leach@linaro.org,
        coresight@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 09/26] coresight: Convert coresight_timeout to use
 access abstraction
Message-ID: <20201103180329.GB2855763@xps15>
References: <20201028220945.3826358-1-suzuki.poulose@arm.com>
 <20201028220945.3826358-11-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201028220945.3826358-11-suzuki.poulose@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 28, 2020 at 10:09:28PM +0000, Suzuki K Poulose wrote:
> Convert the generic routines to use the new access abstraction layer
> gradually, starting with coresigth_timeout.
> 
> Cc: Mike Leach <mike.leach@linaro.org>
> Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  drivers/hwtracing/coresight/coresight-catu.c  |  5 ++--
>  drivers/hwtracing/coresight/coresight-core.c  | 15 ++++++----
>  drivers/hwtracing/coresight/coresight-etb10.c |  5 ++--
>  .../coresight/coresight-etm4x-core.c          | 30 ++++++++++++-------
>  drivers/hwtracing/coresight/coresight-stm.c   |  3 +-
>  .../hwtracing/coresight/coresight-tmc-core.c  | 15 ++++++----
>  drivers/hwtracing/coresight/coresight-tpiu.c  |  4 +--
>  include/linux/coresight.h                     | 17 ++++++++---
>  8 files changed, 61 insertions(+), 33 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-catu.c b/drivers/hwtracing/coresight/coresight-catu.c
> index 5baf29510f1b..34c74b05c542 100644
> --- a/drivers/hwtracing/coresight/coresight-catu.c
> +++ b/drivers/hwtracing/coresight/coresight-catu.c
> @@ -401,8 +401,9 @@ static const struct attribute_group *catu_groups[] = {
>  
>  static inline int catu_wait_for_ready(struct catu_drvdata *drvdata)
>  {
> -	return coresight_timeout(drvdata->base,
> -				 CATU_STATUS, CATU_STATUS_READY, 1);
> +	struct csdev_access *csa = &drvdata->csdev->access;
> +
> +	return coresight_timeout(csa, CATU_STATUS, CATU_STATUS_READY, 1);
>  }
>  
>  static int catu_enable_hw(struct catu_drvdata *drvdata, void *data)
> diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
> index e96deaca8cab..42ba989a6b5e 100644
> --- a/drivers/hwtracing/coresight/coresight-core.c
> +++ b/drivers/hwtracing/coresight/coresight-core.c
> @@ -1412,23 +1412,26 @@ static void coresight_remove_conns(struct coresight_device *csdev)
>  }
>  
>  /**
> - * coresight_timeout - loop until a bit has changed to a specific state.
> - * @addr: base address of the area of interest.
> - * @offset: address of a register, starting from @addr.
> + * coresight_timeout - loop until a bit has changed to a specific register
> + *			state.
> + * @csa: coresight device access for the device
> + * @offset: Offset of the register from the base of the device.
>   * @position: the position of the bit of interest.
>   * @value: the value the bit should have.
>   *
>   * Return: 0 as soon as the bit has taken the desired state or -EAGAIN if
>   * TIMEOUT_US has elapsed, which ever happens first.
>   */
> -
> -int coresight_timeout(void __iomem *addr, u32 offset, int position, int value)
> +int coresight_timeout(struct csdev_access *csa,
> +		      u32 offset,
> +		      int position,
> +		      int value)

There is no need for stacking, please maximise the 80 characters.  The function
stubs in coresight.h should also be revised.

>  {
>  	int i;
>  	u32 val;
>  
>  	for (i = TIMEOUT_US; i > 0; i--) {
> -		val = __raw_readl(addr + offset);
> +		val = csdev_access_read32(csa, offset);

I vaguely remember commenting on this, or perhaps it was on some othe patch you
wrote...  Anyways, I think it is a good thing to go from an unordered access to
an ordered access for the timeout function.

With the above:

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

>  		/* waiting on the bit to go from 0 to 1 */
>  		if (value) {
>  			if (val & BIT(position))
> diff --git a/drivers/hwtracing/coresight/coresight-etb10.c b/drivers/hwtracing/coresight/coresight-etb10.c
> index b91633c6c9b4..f994a22876d9 100644
> --- a/drivers/hwtracing/coresight/coresight-etb10.c
> +++ b/drivers/hwtracing/coresight/coresight-etb10.c
> @@ -251,6 +251,7 @@ static void __etb_disable_hw(struct etb_drvdata *drvdata)
>  {
>  	u32 ffcr;
>  	struct device *dev = &drvdata->csdev->dev;
> +	struct csdev_access *csa = &drvdata->csdev->access;
>  
>  	CS_UNLOCK(drvdata->base);
>  
> @@ -262,7 +263,7 @@ static void __etb_disable_hw(struct etb_drvdata *drvdata)
>  	ffcr |= ETB_FFCR_FON_MAN;
>  	writel_relaxed(ffcr, drvdata->base + ETB_FFCR);
>  
> -	if (coresight_timeout(drvdata->base, ETB_FFCR, ETB_FFCR_BIT, 0)) {
> +	if (coresight_timeout(csa, ETB_FFCR, ETB_FFCR_BIT, 0)) {
>  		dev_err(dev,
>  		"timeout while waiting for completion of Manual Flush\n");
>  	}
> @@ -270,7 +271,7 @@ static void __etb_disable_hw(struct etb_drvdata *drvdata)
>  	/* disable trace capture */
>  	writel_relaxed(0x0, drvdata->base + ETB_CTL_REG);
>  
> -	if (coresight_timeout(drvdata->base, ETB_FFSR, ETB_FFSR_BIT, 1)) {
> +	if (coresight_timeout(csa, ETB_FFSR, ETB_FFSR_BIT, 1)) {
>  		dev_err(dev,
>  			"timeout while waiting for Formatter to Stop\n");
>  	}
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> index c5cb93f1b80c..2744aadaa5ec 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> @@ -107,7 +107,9 @@ static int etm4_enable_hw(struct etmv4_drvdata *drvdata)
>  {
>  	int i, rc;
>  	struct etmv4_config *config = &drvdata->config;
> -	struct device *etm_dev = &drvdata->csdev->dev;
> +	struct coresight_device *csdev = drvdata->csdev;
> +	struct device *etm_dev = &csdev->dev;
> +	struct csdev_access *csa = &csdev->access;
>  
>  	CS_UNLOCK(drvdata->base);
>  
> @@ -121,7 +123,7 @@ static int etm4_enable_hw(struct etmv4_drvdata *drvdata)
>  	writel_relaxed(0, drvdata->base + TRCPRGCTLR);
>  
>  	/* wait for TRCSTATR.IDLE to go up */
> -	if (coresight_timeout(drvdata->base, TRCSTATR, TRCSTATR_IDLE_BIT, 1))
> +	if (coresight_timeout(csa, TRCSTATR, TRCSTATR_IDLE_BIT, 1))
>  		dev_err(etm_dev,
>  			"timeout while waiting for Idle Trace Status\n");
>  	if (drvdata->nr_pe)
> @@ -212,7 +214,7 @@ static int etm4_enable_hw(struct etmv4_drvdata *drvdata)
>  	writel_relaxed(1, drvdata->base + TRCPRGCTLR);
>  
>  	/* wait for TRCSTATR.IDLE to go back down to '0' */
> -	if (coresight_timeout(drvdata->base, TRCSTATR, TRCSTATR_IDLE_BIT, 0))
> +	if (coresight_timeout(csa, TRCSTATR, TRCSTATR_IDLE_BIT, 0))
>  		dev_err(etm_dev,
>  			"timeout while waiting for Idle Trace Status\n");
>  
> @@ -476,7 +478,9 @@ static void etm4_disable_hw(void *info)
>  	u32 control;
>  	struct etmv4_drvdata *drvdata = info;
>  	struct etmv4_config *config = &drvdata->config;
> -	struct device *etm_dev = &drvdata->csdev->dev;
> +	struct coresight_device *csdev = drvdata->csdev;
> +	struct device *etm_dev = &csdev->dev;
> +	struct csdev_access *csa = &csdev->access;
>  	int i;
>  
>  	CS_UNLOCK(drvdata->base);
> @@ -503,8 +507,7 @@ static void etm4_disable_hw(void *info)
>  	writel_relaxed(control, drvdata->base + TRCPRGCTLR);
>  
>  	/* wait for TRCSTATR.PMSTABLE to go to '1' */
> -	if (coresight_timeout(drvdata->base, TRCSTATR,
> -			      TRCSTATR_PMSTABLE_BIT, 1))
> +	if (coresight_timeout(csa, TRCSTATR, TRCSTATR_PMSTABLE_BIT, 1))
>  		dev_err(etm_dev,
>  			"timeout while waiting for PM stable Trace Status\n");
>  
> @@ -1160,7 +1163,15 @@ static int etm4_cpu_save(struct etmv4_drvdata *drvdata)
>  {
>  	int i, ret = 0;
>  	struct etmv4_save_state *state;
> -	struct device *etm_dev = &drvdata->csdev->dev;
> +	struct coresight_device *csdev = drvdata->csdev;
> +	struct csdev_access *csa;
> +	struct device *etm_dev;
> +
> +	if (WARN_ON(!csdev))
> +		return -ENODEV;
> +
> +	etm_dev = &csdev->dev;
> +	csa = &csdev->access;
>  
>  	/*
>  	 * As recommended by 3.4.1 ("The procedure when powering down the PE")
> @@ -1175,8 +1186,7 @@ static int etm4_cpu_save(struct etmv4_drvdata *drvdata)
>  	etm4_os_lock(drvdata);
>  
>  	/* wait for TRCSTATR.PMSTABLE to go up */
> -	if (coresight_timeout(drvdata->base, TRCSTATR,
> -			      TRCSTATR_PMSTABLE_BIT, 1)) {
> +	if (coresight_timeout(csa, TRCSTATR, TRCSTATR_PMSTABLE_BIT, 1)) {
>  		dev_err(etm_dev,
>  			"timeout while waiting for PM Stable Status\n");
>  		etm4_os_unlock(drvdata);
> @@ -1264,7 +1274,7 @@ static int etm4_cpu_save(struct etmv4_drvdata *drvdata)
>  	state->trcpdcr = readl(drvdata->base + TRCPDCR);
>  
>  	/* wait for TRCSTATR.IDLE to go up */
> -	if (coresight_timeout(drvdata->base, TRCSTATR, TRCSTATR_IDLE_BIT, 1)) {
> +	if (coresight_timeout(csa, TRCSTATR, TRCSTATR_IDLE_BIT, 1)) {
>  		dev_err(etm_dev,
>  			"timeout while waiting for Idle Trace Status\n");
>  		etm4_os_unlock(drvdata);
> diff --git a/drivers/hwtracing/coresight/coresight-stm.c b/drivers/hwtracing/coresight/coresight-stm.c
> index 315500b7763f..9cba67b27586 100644
> --- a/drivers/hwtracing/coresight/coresight-stm.c
> +++ b/drivers/hwtracing/coresight/coresight-stm.c
> @@ -258,6 +258,7 @@ static void stm_disable(struct coresight_device *csdev,
>  			struct perf_event *event)
>  {
>  	struct stm_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
> +	struct csdev_access *csa = &csdev->access;
>  
>  	/*
>  	 * For as long as the tracer isn't disabled another entity can't
> @@ -270,7 +271,7 @@ static void stm_disable(struct coresight_device *csdev,
>  		spin_unlock(&drvdata->spinlock);
>  
>  		/* Wait until the engine has completely stopped */
> -		coresight_timeout(drvdata->base, STMTCSR, STMTCSR_BUSY_BIT, 0);
> +		coresight_timeout(csa, STMTCSR, STMTCSR_BUSY_BIT, 0);
>  
>  		pm_runtime_put(csdev->dev.parent);
>  
> diff --git a/drivers/hwtracing/coresight/coresight-tmc-core.c b/drivers/hwtracing/coresight/coresight-tmc-core.c
> index 8fd640d41e1b..572f4b316798 100644
> --- a/drivers/hwtracing/coresight/coresight-tmc-core.c
> +++ b/drivers/hwtracing/coresight/coresight-tmc-core.c
> @@ -33,16 +33,20 @@ DEFINE_CORESIGHT_DEVLIST(etr_devs, "tmc_etr");
>  
>  void tmc_wait_for_tmcready(struct tmc_drvdata *drvdata)
>  {
> +	struct coresight_device *csdev = drvdata->csdev;
> +	struct csdev_access *csa = &csdev->access;
> +
>  	/* Ensure formatter, unformatter and hardware fifo are empty */
> -	if (coresight_timeout(drvdata->base,
> -			      TMC_STS, TMC_STS_TMCREADY_BIT, 1)) {
> -		dev_err(&drvdata->csdev->dev,
> +	if (coresight_timeout(csa, TMC_STS, TMC_STS_TMCREADY_BIT, 1)) {
> +		dev_err(&csdev->dev,
>  			"timeout while waiting for TMC to be Ready\n");
>  	}
>  }
>  
>  void tmc_flush_and_stop(struct tmc_drvdata *drvdata)
>  {
> +	struct coresight_device *csdev = drvdata->csdev;
> +	struct csdev_access *csa = &csdev->access;
>  	u32 ffcr;
>  
>  	ffcr = readl_relaxed(drvdata->base + TMC_FFCR);
> @@ -51,9 +55,8 @@ void tmc_flush_and_stop(struct tmc_drvdata *drvdata)
>  	ffcr |= BIT(TMC_FFCR_FLUSHMAN_BIT);
>  	writel_relaxed(ffcr, drvdata->base + TMC_FFCR);
>  	/* Ensure flush completes */
> -	if (coresight_timeout(drvdata->base,
> -			      TMC_FFCR, TMC_FFCR_FLUSHMAN_BIT, 0)) {
> -		dev_err(&drvdata->csdev->dev,
> +	if (coresight_timeout(csa, TMC_FFCR, TMC_FFCR_FLUSHMAN_BIT, 0)) {
> +		dev_err(&csdev->dev,
>  		"timeout while waiting for completion of Manual Flush\n");
>  	}
>  
> diff --git a/drivers/hwtracing/coresight/coresight-tpiu.c b/drivers/hwtracing/coresight/coresight-tpiu.c
> index 98c4a029854c..1e92c76d9656 100644
> --- a/drivers/hwtracing/coresight/coresight-tpiu.c
> +++ b/drivers/hwtracing/coresight/coresight-tpiu.c
> @@ -86,9 +86,9 @@ static void tpiu_disable_hw(struct csdev_access *csa)
>  	/* Generate manual flush */
>  	csdev_access_relaxed_write32(csa, FFCR_STOP_FI | FFCR_FON_MAN, TPIU_FFCR);
>  	/* Wait for flush to complete */
> -	coresight_timeout(csa->base, TPIU_FFCR, FFCR_FON_MAN_BIT, 0);
> +	coresight_timeout(csa, TPIU_FFCR, FFCR_FON_MAN_BIT, 0);
>  	/* Wait for formatter to stop */
> -	coresight_timeout(csa->base, TPIU_FFSR, FFSR_FT_STOPPED_BIT, 1);
> +	coresight_timeout(csa, TPIU_FFSR, FFSR_FT_STOPPED_BIT, 1);
>  
>  	CS_LOCK(csa->base);
>  }
> diff --git a/include/linux/coresight.h b/include/linux/coresight.h
> index 5a34c2f2debc..cefc8fe239e6 100644
> --- a/include/linux/coresight.h
> +++ b/include/linux/coresight.h
> @@ -469,8 +469,10 @@ coresight_register(struct coresight_desc *desc);
>  extern void coresight_unregister(struct coresight_device *csdev);
>  extern int coresight_enable(struct coresight_device *csdev);
>  extern void coresight_disable(struct coresight_device *csdev);
> -extern int coresight_timeout(void __iomem *addr, u32 offset,
> -			     int position, int value);
> +extern int coresight_timeout(struct csdev_access *csa,
> +			     u32 offset,
> +			     int position,
> +			     int value);
>  
>  extern int coresight_claim_device(void __iomem *base);
>  extern int coresight_claim_device_unlocked(void __iomem *base);
> @@ -502,8 +504,15 @@ static inline void coresight_unregister(struct coresight_device *csdev) {}
>  static inline int
>  coresight_enable(struct coresight_device *csdev) { return -ENOSYS; }
>  static inline void coresight_disable(struct coresight_device *csdev) {}
> -static inline int coresight_timeout(void __iomem *addr, u32 offset,
> -				     int position, int value) { return 1; }
> +
> +static inline int coresight_timeout(struct csdev_access *csa,
> +				    u32 offset,
> +				    int position,
> +				    int value)
> +{
> +	return 1;
> +}
> +
>  static inline int coresight_claim_device_unlocked(void __iomem *base)
>  {
>  	return -EINVAL;
> -- 
> 2.24.1
> 
