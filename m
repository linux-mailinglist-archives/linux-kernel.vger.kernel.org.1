Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D3752C9035
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 22:46:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730269AbgK3Vp5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 16:45:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725861AbgK3Vp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 16:45:57 -0500
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0B8BC0613D4
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 13:45:16 -0800 (PST)
Received: by mail-pl1-x642.google.com with SMTP id l11so7263206plt.1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 13:45:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NAVMPedoahzloxAZTi83Cxu7v2k6QSYFs0PxufRbo/0=;
        b=infVFnDkWkudue/dGrT6KXVZILVSAmrWrovq9sm36BlRi2i4woy2DnzbmsZcxWQSUc
         kfmRGz0Db81NOsUKC0M0FBAbtQcvqEQ/KZ24cFdLSaZftC272RQZUKXb8PC94Q+Wggqv
         e+jlxUDoM/b557s6qbBNk6JMxmXWBpSz57ZLUGrEmveGEeMaY+XLC424C8o/dH4bBiPf
         BWT2qlTPwC+O2VPOjN0cDrf5t2jFGy62iiu68CkyXAo+ZjSxvvLk8GjS1rZLnBvpsQWJ
         wJdgTXP/keomun1R1nx2HPpW67SI/Y4pxGt8PSntb/e5QTB2cmi582pu4JbHTjjUJU9s
         2bAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NAVMPedoahzloxAZTi83Cxu7v2k6QSYFs0PxufRbo/0=;
        b=LNIyeYu3sODQRa9ZvfzgJDUfb02K0YvmXSLkqwWkas3K/Q1PMC2rJQXYW3wc3Jmtwh
         ealbsJap3+/oIO+a4z6TcPYmJz8YU5JHAh1dZRTLxgNbC/5iZwenQIvBuVbUB5OJafTO
         z5sUHu2gzBtQtQ8yZOMN41TpWssSVT3zqyZ9YCr1TVp5EhcmXb9WUxv7pn132ooChzq1
         ZJ7vC1k50AN4vJzJAKY+RC5rKyZ0Ya4GlbSUsr3t9J0p2O+fagQs12autRdgRUu7dh1L
         a8kb9Kx3cbNlJHIGeGY+4apMNZmtXh2NsrsF9S4xA9/bzChIDF++Lnymrqxxf36Ux6kL
         daSw==
X-Gm-Message-State: AOAM531Yv/an0jM4R6oohn5mC5kGCIYqdZuLypqyufT5rAtx6VvOW86Z
        Pfrg3gTV99zCFTj/KEY3ovs5Ww==
X-Google-Smtp-Source: ABdhPJx3yhDB6QtzKZvnmhL4TtFE8tQWLe/8PxX2FnjSJ1R2cuAl+X6xnQ+DerIG7dOyCaQY4tW6/Q==
X-Received: by 2002:a17:902:ff0f:b029:da:6dbb:65ff with SMTP id f15-20020a170902ff0fb02900da6dbb65ffmr9641214plj.21.1606772716286;
        Mon, 30 Nov 2020 13:45:16 -0800 (PST)
Received: from xps15 (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id h16sm17327979pgd.62.2020.11.30.13.45.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Nov 2020 13:45:15 -0800 (PST)
Date:   Mon, 30 Nov 2020 14:45:13 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, mike.leach@linaro.org,
        linux-kernel@vger.kernel.org, anshuman.khandual@arm.com,
        jonathan.zhouwen@huawei.com, coresight@lists.linaro.org
Subject: Re: [PATCH v4 14/25] coresight: etm4x: Clean up exception level masks
Message-ID: <20201130214513.GI1092947@xps15>
References: <20201119164547.2982871-1-suzuki.poulose@arm.com>
 <20201119164547.2982871-15-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201119164547.2982871-15-suzuki.poulose@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 19, 2020 at 04:45:36PM +0000, Suzuki K Poulose wrote:
> etm4_get_access_type() calculates the exception level bits
> for use in address comparator registers. This is also used
> by the TRCVICTLR register by shifting to the required position.
> 
> This patch cleans up the logic to make etm4_get_access_type()
> calcualte a generic mask which can be used by all users by
> shifting to their field.
> 
> No functional changes intended.
> 
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
> Changes since v3:
>   - Fix errors in victlr ns_mask setting.
> Changes since v2:
>   - Fix the duplicate shift. More commentary
> ---
>  .../coresight/coresight-etm4x-core.c          | 47 +++++++++----------
>  .../coresight/coresight-etm4x-sysfs.c         | 12 ++---
>  drivers/hwtracing/coresight/coresight-etm4x.h | 47 ++++++++++++-------
>  3 files changed, 60 insertions(+), 46 deletions(-)
> 

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> index a1f294703c43..2342e72c5016 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> @@ -861,20 +861,16 @@ static void etm4_init_arch_data(void *info)
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
> +	config->vinst_ctrl &= ~TRCVICTLR_EXLEVEL_MASK;
> +	config->vinst_ctrl |= etm4_get_victlr_access_type(config);
>  }
>  
>  static void etm4_set_default_config(struct etmv4_config *config)
> @@ -904,12 +900,9 @@ static u64 etm4_get_ns_access_type(struct etmv4_config *config)
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
> @@ -926,20 +919,26 @@ static u64 etm4_get_ns_access_type(struct etmv4_config *config)
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
> @@ -974,7 +973,7 @@ static void etm4_set_start_stop_filter(struct etmv4_config *config,
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
> index 94ead0cd98df..173ea7445c29 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x.h
> +++ b/drivers/hwtracing/coresight/coresight-etm4x.h
> @@ -551,24 +551,39 @@
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
> +#define ETM_EXLEVEL_S_MON		BIT(3)	/* Secure EL3/Monitor	*/
> +#define ETM_EXLEVEL_NS_APP		BIT(4)	/* NonSecure EL0	*/
> +#define ETM_EXLEVEL_NS_OS		BIT(5)	/* NonSecure EL1	*/
> +#define ETM_EXLEVEL_NS_HYP		BIT(6)	/* NonSecure EL2	*/
> +
> +#define ETM_EXLEVEL_MASK		(GENMASK(6, 0))
> +#define ETM_EXLEVEL_S_MASK		(GENMASK(3, 0))
> +#define ETM_EXLEVEL_NS_MASK		(GENMASK(6, 4))
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
> +#define TRCVICTLR_EXLEVEL_MASK		(ETM_EXLEVEL_MASK << TRCVICTLR_EXLEVEL_SHIFT)
> +#define TRCVICTLR_EXLEVEL_S_MASK	(ETM_EXLEVEL_S_MASK << TRCVICTLR_EXLEVEL_SHIFT)
> +#define TRCVICTLR_EXLEVEL_NS_MASK	(ETM_EXLEVEL_NS_MASK << TRCVICTLR_EXLEVEL_SHIFT)
>  
>  /* Interpretation of resource numbers change at ETM v4.3 architecture */
>  #define ETM4X_ARCH_4V3	0x43
> -- 
> 2.24.1
> 
