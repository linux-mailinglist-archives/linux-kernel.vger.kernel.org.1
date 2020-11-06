Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB1042A9CB7
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 19:52:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727983AbgKFSwq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 13:52:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726447AbgKFSwp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 13:52:45 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 714CEC0613CF
        for <linux-kernel@vger.kernel.org>; Fri,  6 Nov 2020 10:52:45 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id u4so1621644pgr.9
        for <linux-kernel@vger.kernel.org>; Fri, 06 Nov 2020 10:52:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vvsTsXFERb+lVOW9+teUGEwQPDYWf6fhAoxDY3KZRU4=;
        b=XtL4kifdsRSQg33mYbFB+uiK98KSODeLCPfpvhhRRK8ElGD6Rb2ODb+RzUWU2zcSgp
         XzZ76ad+avLcNYmISinyEgezRiiU4HectGnhAt3nMzgITdeGCWO2Hlq1wQsHtCmT6gOt
         qnImFK6nE9zkrIQtEWfRk55KRrjo+ewkTErWkEqwU2dLeYliI8Z40h4rgr7xhfsa3ZqY
         wNoKI0J132/X0qYQ5+nzWO+geduLvVlZIw2z4wOTL7MqcUtBqHVG4kwgN6OkOBOg4ufy
         N97+5aLoi6u907UG3ijQDnv9JyiK5qng1LrMU46bI4SSwFOTTf3LgxkjIWu05ogFYG/c
         4VwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vvsTsXFERb+lVOW9+teUGEwQPDYWf6fhAoxDY3KZRU4=;
        b=CJMuh0alQ2McUfVcBgrlMgABlseF880mWxx02EzPrIGSuO/2VTU6CHYHI37ef4DlmP
         mcRAWPIhgeD1me2U+qtFL97xwX0CGf5dQ5VUO5r6JRUixZGgLn0Csmi7LbnaC/LDCbv+
         zHRNffyNdpffaog/ocK156tfE3Q1rhuYjg/jN/lO2yFQMJaZSrOJPk8aOEtNUl72kAFg
         0KtQ+XPX5juwaYghTLS32AvWpPOlXPx4z6e5DpAjsYj7Z94YPhpTV00GK4ebRSXddHzv
         GaJGv9oD9vRUaJUD3PjC7TfrZraQNZxg+En5I71cIme47HjVEmrgNBVN/3/fYJZ0EmQM
         6akA==
X-Gm-Message-State: AOAM532ysMJf+qI5eEuOTNCJph6GvM9Fg1GUwZ2+Fz1YeUt6dQQGTTCf
        JFbqXtbZjxppCcneq3XzC1M2oOMZJtqZ2A==
X-Google-Smtp-Source: ABdhPJwe2I956rsddmU6iXOnweZYHT8ni9l/V4hmueotIA6Rq4azUDt6zgW6C2jLd37xKUerHs1+0w==
X-Received: by 2002:a63:ef4f:: with SMTP id c15mr2819789pgk.345.1604688764740;
        Fri, 06 Nov 2020 10:52:44 -0800 (PST)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id f21sm2527429pga.32.2020.11.06.10.52.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2020 10:52:43 -0800 (PST)
Date:   Fri, 6 Nov 2020 11:52:41 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, mike.leach@linaro.org,
        coresight@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 18/26] coresight: etm4x: Clean up exception level masks
Message-ID: <20201106185241.GA3299843@xps15>
References: <20201028220945.3826358-1-suzuki.poulose@arm.com>
 <20201028220945.3826358-20-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201028220945.3826358-20-suzuki.poulose@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good morning,

On Wed, Oct 28, 2020 at 10:09:37PM +0000, Suzuki K Poulose wrote:
> etm4_get_access_type() calculates the exception level bits
> for use in address comparator registers. This is also used
> by the TRCVICTLR register by shifting to the required position.
> 
> This patch cleans up the logic to make etm4_get_access_type()
> calcualte a generic mask which can be used by all users by
> shifting to their field.
> 
> No functional changes, only code cleanups.
> 
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
> Changes since previous version:
>   - Fix the duplicate shift. More commentary
> ---
>  .../coresight/coresight-etm4x-core.c          | 47 +++++++++----------
>  .../coresight/coresight-etm4x-sysfs.c         | 12 ++---
>  drivers/hwtracing/coresight/coresight-etm4x.h | 46 +++++++++++-------
>  3 files changed, 59 insertions(+), 46 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> index 6e3f9cb7de3f..f038bb10bc78 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> @@ -852,20 +852,16 @@ static void etm4_init_arch_data(void *info)
>  	etm4_cs_lock(drvdata, csa);
>  }
>  
> +static inline u32 etm4_get_victlr_access_type(struct etmv4_config *config)
> +{
> +	return etm4_get_access_type(config) << TRCVICTLR_EXLEVEL_SHIFT;
> +}
> +
>  /* Set ELx trace filter access in the TRCVICTLR register */
>  static void etm4_set_victlr_access(struct etmv4_config *config)
>  {
> -	u64 access_type;
> -
> -	config->vinst_ctrl &= ~(ETM_EXLEVEL_S_VICTLR_MASK | ETM_EXLEVEL_NS_VICTLR_MASK);
> -
> -	/*
> -	 * TRCVICTLR::EXLEVEL_NS:EXLEVELS: Set kernel / user filtering
> -	 * bits in vinst_ctrl, same bit pattern as TRCACATRn values returned by
> -	 * etm4_get_access_type() but with a relative shift in this register.
> -	 */
> -	access_type = etm4_get_access_type(config) << ETM_EXLEVEL_LSHIFT_TRCVICTLR;
> -	config->vinst_ctrl |= (u32)access_type;
> +	config->vinst_ctrl &= ~(TRCVICTLR_EXLEVEL_S_MASK | TRCVICTLR_EXLEVEL_NS_MASK);
> +	config->vinst_ctrl |= etm4_get_victlr_access_type(config);
>  }
>  
>  static void etm4_set_default_config(struct etmv4_config *config)
> @@ -895,12 +891,9 @@ static u64 etm4_get_ns_access_type(struct etmv4_config *config)
>  	u64 access_type = 0;
>  
>  	/*
> -	 * EXLEVEL_NS, bits[15:12]
> -	 * The Exception levels are:
> -	 *   Bit[12] Exception level 0 - Application
> -	 *   Bit[13] Exception level 1 - OS
> -	 *   Bit[14] Exception level 2 - Hypervisor
> -	 *   Bit[15] Never implemented
> +	 * EXLEVEL_NS, for NonSecure Exception levels.
> +	 * The mask here is a generic value and must be
> +	 * shifted to the corresponding field for the registers
>  	 */
>  	if (!is_kernel_in_hyp_mode()) {
>  		/* Stay away from hypervisor mode for non-VHE */
> @@ -917,20 +910,26 @@ static u64 etm4_get_ns_access_type(struct etmv4_config *config)
>  	return access_type;
>  }
>  
> +/*
> + * Construct the exception level masks for a given config.
> + * This must be shifted to the corresponding register field
> + * for usage.
> + */
>  static u64 etm4_get_access_type(struct etmv4_config *config)
>  {
> -	u64 access_type = etm4_get_ns_access_type(config);
> -
> -	/* All supported secure ELs are excluded */
> -	access_type |= (u64)config->s_ex_level << TRCACATR_EXLEVEL_SHIFT;
> +	/* All Secure exception levels are excluded from the trace */
> +	return etm4_get_ns_access_type(config) | (u64)config->s_ex_level;
> +}
>  
> -	return access_type;
> +static u64 etm4_get_comparator_access_type(struct etmv4_config *config)
> +{
> +	return etm4_get_access_type(config) << TRCACATR_EXLEVEL_SHIFT;
>  }
>  
>  static void etm4_set_comparator_filter(struct etmv4_config *config,
>  				       u64 start, u64 stop, int comparator)
>  {
> -	u64 access_type = etm4_get_access_type(config);
> +	u64 access_type = etm4_get_comparator_access_type(config);
>  
>  	/* First half of default address comparator */
>  	config->addr_val[comparator] = start;
> @@ -965,7 +964,7 @@ static void etm4_set_start_stop_filter(struct etmv4_config *config,
>  				       enum etm_addr_type type)
>  {
>  	int shift;
> -	u64 access_type = etm4_get_access_type(config);
> +	u64 access_type = etm4_get_comparator_access_type(config);
>  
>  	/* Configure the comparator */
>  	config->addr_val[comparator] = address;
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
> index fce9df16bfb5..009818675928 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
> @@ -743,7 +743,7 @@ static ssize_t s_exlevel_vinst_show(struct device *dev,
>  	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
>  	struct etmv4_config *config = &drvdata->config;
>  
> -	val = (config->vinst_ctrl & ETM_EXLEVEL_S_VICTLR_MASK) >> 16;
> +	val = (config->vinst_ctrl & TRCVICTLR_EXLEVEL_S_MASK) >> TRCVICTLR_EXLEVEL_S_SHIFT;
>  	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
>  }
>  
> @@ -760,10 +760,10 @@ static ssize_t s_exlevel_vinst_store(struct device *dev,
>  
>  	spin_lock(&drvdata->spinlock);
>  	/* clear all EXLEVEL_S bits  */
> -	config->vinst_ctrl &= ~(ETM_EXLEVEL_S_VICTLR_MASK);
> +	config->vinst_ctrl &= ~(TRCVICTLR_EXLEVEL_S_MASK);
>  	/* enable instruction tracing for corresponding exception level */
>  	val &= drvdata->s_ex_level;
> -	config->vinst_ctrl |= (val << 16);
> +	config->vinst_ctrl |= (val << TRCVICTLR_EXLEVEL_S_SHIFT);
>  	spin_unlock(&drvdata->spinlock);
>  	return size;
>  }
> @@ -778,7 +778,7 @@ static ssize_t ns_exlevel_vinst_show(struct device *dev,
>  	struct etmv4_config *config = &drvdata->config;
>  
>  	/* EXLEVEL_NS, bits[23:20] */
> -	val = (config->vinst_ctrl & ETM_EXLEVEL_NS_VICTLR_MASK) >> 20;
> +	val = (config->vinst_ctrl & TRCVICTLR_EXLEVEL_NS_MASK) >> TRCVICTLR_EXLEVEL_NS_SHIFT;
>  	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
>  }
>  
> @@ -795,10 +795,10 @@ static ssize_t ns_exlevel_vinst_store(struct device *dev,
>  
>  	spin_lock(&drvdata->spinlock);
>  	/* clear EXLEVEL_NS bits  */
> -	config->vinst_ctrl &= ~(ETM_EXLEVEL_NS_VICTLR_MASK);
> +	config->vinst_ctrl &= ~(TRCVICTLR_EXLEVEL_NS_MASK);
>  	/* enable instruction tracing for corresponding exception level */
>  	val &= drvdata->ns_ex_level;
> -	config->vinst_ctrl |= (val << 20);
> +	config->vinst_ctrl |= (val << TRCVICTLR_EXLEVEL_NS_SHIFT);
>  	spin_unlock(&drvdata->spinlock);
>  	return size;
>  }
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x.h b/drivers/hwtracing/coresight/coresight-etm4x.h
> index 2ac4ecb0af61..f1251ddf1984 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x.h
> +++ b/drivers/hwtracing/coresight/coresight-etm4x.h
> @@ -548,24 +548,38 @@
>  
>  #define TRCACATR_EXLEVEL_SHIFT		8
>  
> -/* secure state access levels - TRCACATRn */
> -#define ETM_EXLEVEL_S_APP		BIT(8)
> -#define ETM_EXLEVEL_S_OS		BIT(9)
> -#define ETM_EXLEVEL_S_HYP		BIT(10)
> -#define ETM_EXLEVEL_S_MON		BIT(11)
> -/* non-secure state access levels - TRCACATRn */
> -#define ETM_EXLEVEL_NS_APP		BIT(12)
> -#define ETM_EXLEVEL_NS_OS		BIT(13)
> -#define ETM_EXLEVEL_NS_HYP		BIT(14)
> -#define ETM_EXLEVEL_NS_NA		BIT(15)
> -
> -/* access level control in TRCVICTLR - same bits as TRCACATRn but shifted */
> -#define ETM_EXLEVEL_LSHIFT_TRCVICTLR	8
> +/*
> + * Exception level mask for Secure and Non-Secure ELs.
> + * ETM defines the bits for EL control (e.g, TRVICTLR, TRCACTRn).
> + * The Secure and Non-Secure ELs are always to gether.
> + * Non-secure EL3 is never implemented.
> + * We use the following generic mask as they appear in different
> + * registers and this can be shifted for the appropriate
> + * fields.
> + */
> +#define ETM_EXLEVEL_S_APP		BIT(0)	/* Secure EL0		*/
> +#define ETM_EXLEVEL_S_OS		BIT(1)	/* Secure EL1		*/
> +#define ETM_EXLEVEL_S_HYP		BIT(2)	/* Secure EL2		*/
> +#define ETM_EXLEVEL_S_MON		BIT(3)	/* Secure EL3/Montor	*/

s/Montor/Monitor

> +#define ETM_EXLEVEL_NS_APP		BIT(4)	/* NonSecure EL0	*/
> +#define ETM_EXLEVEL_NS_OS		BIT(5)	/* NonSecure EL1	*/
> +#define ETM_EXLEVEL_NS_HYP		BIT(6)	/* NonSecure EL2	*/
> +
> +#define ETM_EXLEVEL_MASK		(GENMASK(6, 0))

Not used.

> +#define ETM_EXLEVEL_S_MASK		(GENMASK(3, 0))
> +#define ETM_EXLEVEL_NS_MASK		(GENMASK(6, 4))

This needs to be GENMASK(2, 0) in order TRCVICTLR_EXLEVEL_NS_SHIFT to be 20.
Otherwise the resulting mask is 4 bit off to the left. 

> +
> +/* access level controls in TRCACATRn */
> +#define TRCACATR_EXLEVEL_SHIFT		8
> +
> +/* access level control in TRCVICTLR */
> +#define TRCVICTLR_EXLEVEL_SHIFT		16
> +#define TRCVICTLR_EXLEVEL_S_SHIFT	16
> +#define TRCVICTLR_EXLEVEL_NS_SHIFT	20
>  
>  /* secure / non secure masks - TRCVICTLR, IDR3 */
> -#define ETM_EXLEVEL_S_VICTLR_MASK	GENMASK(19, 16)
> -/* NS MON (EL3) mode never implemented */
> -#define ETM_EXLEVEL_NS_VICTLR_MASK	GENMASK(22, 20)
> +#define TRCVICTLR_EXLEVEL_S_MASK	(ETM_EXLEVEL_S_MASK << TRCVICTLR_EXLEVEL_S_SHIFT)
> +#define TRCVICTLR_EXLEVEL_NS_MASK	(ETM_EXLEVEL_NS_MASK << TRCVICTLR_EXLEVEL_NS_SHIFT)
>  
>  /* Interpretation of resource numbers change at ETM v4.3 architecture */
>  #define ETM4X_ARCH_4V3	0x43
> -- 
> 2.24.1
> 
