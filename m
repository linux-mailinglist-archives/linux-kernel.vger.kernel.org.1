Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 068AA2C9043
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 22:51:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730316AbgK3Vth (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 16:49:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727807AbgK3Vth (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 16:49:37 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 415C5C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 13:48:57 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id w6so11321555pfu.1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 13:48:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HLPise+xDw+yK9QnQOiR2ANB+NOTo6DEjG9AcXclvyk=;
        b=x1OItiVHmQKGJLCloT6tA+ReWGLJAjXpLu3p6OnS4384c98gapnRUEO8PGyqYHny2i
         uc8bEIABzSNuGFTirg+JuM2gfnOoxzGPMzDx2DuWMo1qL0ei75pW7S/6ogo5CJ5FGGEQ
         Agq/Do6j7KfJr5jD89WtthZYPMoYROoF7knzxdx+kv9aG9U1pAcqnXqR4hHfoVgtiq22
         KjVRwoCzhi86l6NvKsVdnOluGbOjwtHg+1NAzLEZOMVdl0QiZ/WCYeiWYU0VTTSyIm5K
         oz1HjNR2d6CqJ0Cr6I1/PB9hOLMeJgLwM2Nkt14sE+b0AOXO9NGxpoTn1QGjwDjj6uEr
         ahlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HLPise+xDw+yK9QnQOiR2ANB+NOTo6DEjG9AcXclvyk=;
        b=GQKVNB7+g20y6jcEAFo/dplQq4y9Fi6VHv9340vDypwM9N4TKA8nsxFE/wcQJDoZ1U
         h4ZBB+AXvBdNLoCuSI44T0q1GgcPTw4zbefBKvSz+4tB4/FTP57rYgfS/nYKAvA6R+q5
         DvlUsRrR4JgsXP0cmqgaKQcjKVGDM1Eb2syb7PL1+FWAwUZdlostmbie9y0d+ZeL9D39
         GYssI8ASo4LMhxIpkCICsUY95Zl2ZWwmg6B8lEOriKbt9mxFkaKQUDKqbvZuxPnGQ21q
         OVwImmEIqTdf/TeeRdsskusVYDZEPd2JKNHxMpKoNBihg2q+LCoB12JLYUZ+ogljO6ZX
         7b8g==
X-Gm-Message-State: AOAM533pTAop1BTXAhUS2TzSt0pt4LAuinRdo7tMJU+liczzvPH5M1Lg
        15QsNnpi2RBCwJ1CM6jH7n0LGA==
X-Google-Smtp-Source: ABdhPJyUiT5ii71Ra24pG9+x9ADvwWktNvrZz6TF2Q/wQnUrimKh8f9LjEHprtpQuWCCbKaL/xoUKw==
X-Received: by 2002:a63:cc01:: with SMTP id x1mr19948678pgf.15.1606772936779;
        Mon, 30 Nov 2020 13:48:56 -0800 (PST)
Received: from xps15 (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id q14sm18465758pfl.163.2020.11.30.13.48.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Nov 2020 13:48:55 -0800 (PST)
Date:   Mon, 30 Nov 2020 14:48:54 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, mike.leach@linaro.org,
        linux-kernel@vger.kernel.org, anshuman.khandual@arm.com,
        jonathan.zhouwen@huawei.com, coresight@lists.linaro.org
Subject: Re: [PATCH v4 15/25] coresight: etm4x: Handle ETM architecture
 version
Message-ID: <20201130214854.GJ1092947@xps15>
References: <20201119164547.2982871-1-suzuki.poulose@arm.com>
 <20201119164547.2982871-16-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201119164547.2982871-16-suzuki.poulose@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 19, 2020 at 04:45:37PM +0000, Suzuki K Poulose wrote:
> We are about to rely on TRCDEVARCH for detecting the ETM
> and its architecture version, falling back to TRCIDR1 if
> the former is not implemented (in older broken implementations).
> 
> Also, we use the architecture version information to do
> make some decisions. Streamline the architecture version

s/to do make/to make

> handling by adding helpers.
> 
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  .../coresight/coresight-etm4x-core.c          |  2 +-
>  drivers/hwtracing/coresight/coresight-etm4x.h | 60 ++++++++++++++++++-
>  2 files changed, 58 insertions(+), 4 deletions(-)

With the above:

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

> 
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> index 2342e72c5016..a91e7de77ab9 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> @@ -819,7 +819,7 @@ static void etm4_init_arch_data(void *info)
>  	 * Otherwise for values 0x1 and above the number is N + 1 as per v4.2.
>  	 */
>  	drvdata->nr_resource = BMVAL(etmidr4, 16, 19);
> -	if ((drvdata->arch < ETM4X_ARCH_4V3) || (drvdata->nr_resource > 0))
> +	if ((drvdata->arch < ETM_ARCH_V4_3) || (drvdata->nr_resource > 0))
>  		drvdata->nr_resource += 1;
>  	/*
>  	 * NUMSSCC, bits[23:20] the number of single-shot
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x.h b/drivers/hwtracing/coresight/coresight-etm4x.h
> index 173ea7445c29..7a6e3cd34d58 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x.h
> +++ b/drivers/hwtracing/coresight/coresight-etm4x.h
> @@ -460,7 +460,6 @@
>  #define ETM_MAX_RES_SEL			32
>  #define ETM_MAX_SS_CMP			8
>  
> -#define ETM_ARCH_V4			0x40
>  #define ETMv4_SYNC_MASK			0x1F
>  #define ETM_CYC_THRESHOLD_MASK		0xFFF
>  #define ETM_CYC_THRESHOLD_DEFAULT       0x100
> @@ -585,8 +584,63 @@
>  #define TRCVICTLR_EXLEVEL_S_MASK	(ETM_EXLEVEL_S_MASK << TRCVICTLR_EXLEVEL_SHIFT)
>  #define TRCVICTLR_EXLEVEL_NS_MASK	(ETM_EXLEVEL_NS_MASK << TRCVICTLR_EXLEVEL_SHIFT)
>  
> +#define ETM_TRCIDR1_ARCH_MAJOR_SHIFT	8
> +#define ETM_TRCIDR1_ARCH_MAJOR_MASK	(0xfU << ETM_TRCIDR1_ARCH_MAJOR_SHIFT)
> +#define ETM_TRCIDR1_ARCH_MAJOR(x)	\
> +	(((x) & ETM_TRCIDR1_ARCH_MAJOR_MASK) >> ETM_TRCIDR1_ARCH_MAJOR_SHIFT)
> +#define ETM_TRCIDR1_ARCH_MINOR_SHIFT	4
> +#define ETM_TRCIDR1_ARCH_MINOR_MASK	(0xfU << ETM_TRCIDR1_ARCH_MINOR_SHIFT)
> +#define ETM_TRCIDR1_ARCH_MINOR(x)	\
> +	(((x) & ETM_TRCIDR1_ARCH_MINOR_MASK) >> ETM_TRCIDR1_ARCH_MINOR_SHIFT)
> +#define ETM_TRCIDR1_ARCH_SHIFT		ETM_TRCIDR1_ARCH_MINOR_SHIFT
> +#define ETM_TRCIDR1_ARCH_MASK		\
> +	(ETM_TRCIDR1_ARCH_MAJOR_MASK | ETM_TRCIDR1_ARCH_MINOR_MASK)
> +
> +#define ETM_TRCIDR1_ARCH_ETMv4		0x4
> +
> +/*
> + * Driver representation of the ETM architecture.
> + * The version of an ETM component can be detected from
> + *
> + * TRCDEVARCH	- CoreSight architected register
> + *                - Bits[15:12] - Major version
> + *                - Bits[19:16] - Minor version
> + * TRCIDR1	- ETM architected register
> + *                - Bits[11:8] - Major version
> + *                - Bits[7:4]  - Minor version
> + * We must rely on TRCDEVARCH for the version information,
> + * however we don't want to break the support for potential
> + * old implementations which might not implement it. Thus
> + * we fall back to TRCIDR1 if TRCDEVARCH is not implemented
> + * for memory mapped components.
> + * Now to make certain decisions easier based on the version
> + * we use an internal representation of the version in the
> + * driver, as follows :
> + *
> + * ETM_ARCH_VERSION[7:0], where :
> + *      Bits[7:4] - Major version
> + *      Bits[3:0] - Minro version
> + */
> +#define ETM_ARCH_VERSION(major, minor)		\
> +	((((major) & 0xfU) << 4) | (((minor) & 0xfU)))
> +#define ETM_ARCH_MAJOR_VERSION(arch)	(((arch) >> 4) & 0xfU)
> +#define ETM_ARCH_MINOR_VERSION(arch)	((arch) & 0xfU)
> +
> +#define ETM_ARCH_V4	ETM_ARCH_VERSION(4, 0)
>  /* Interpretation of resource numbers change at ETM v4.3 architecture */
> -#define ETM4X_ARCH_4V3	0x43
> +#define ETM_ARCH_V4_3	ETM_ARCH_VERSION(4, 3)
> +
> +static inline u8 etm_devarch_to_arch(u32 devarch)
> +{
> +	return ETM_ARCH_VERSION(ETM_DEVARCH_ARCHID_ARCH_VER(devarch),
> +				ETM_DEVARCH_REVISION(devarch));
> +}
> +
> +static inline u8 etm_trcidr_to_arch(u32 trcidr1)
> +{
> +	return ETM_ARCH_VERSION(ETM_TRCIDR1_ARCH_MAJOR(trcidr1),
> +				ETM_TRCIDR1_ARCH_MINOR(trcidr1));
> +}
>  
>  /**
>   * struct etmv4_config - configuration information related to an ETMv4
> @@ -748,7 +802,7 @@ struct etmv4_save_state {
>   * @spinlock:   Only one at a time pls.
>   * @mode:	This tracer's mode, i.e sysFS, Perf or disabled.
>   * @cpu:        The cpu this component is affined to.
> - * @arch:       ETM version number.
> + * @arch:       ETM architecture version.
>   * @nr_pe:	The number of processing entity available for tracing.
>   * @nr_pe_cmp:	The number of processing entity comparator inputs that are
>   *		available for tracing.
> -- 
> 2.24.1
> 
