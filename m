Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93D2E2A9EDF
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 22:11:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727773AbgKFVLZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 16:11:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726415AbgKFVLZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 16:11:25 -0500
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A78CC0613CF
        for <linux-kernel@vger.kernel.org>; Fri,  6 Nov 2020 13:11:25 -0800 (PST)
Received: by mail-pl1-x642.google.com with SMTP id k7so1241393plk.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 Nov 2020 13:11:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=F0kEsyePvZb/ixvKbdfJYbJv6DMQdOFKWsB0jb+3vOc=;
        b=F6mV+Dzh+0Nr3Pnthw46g2OvOHmAbDhqlYP2bW7y4GdkiuaWCZ4HoCmg1jvMXMSO+K
         FFccXcqS1UJiQ6QELBYiS7gF7si9H2p1atRawQt5JVsm0pF/MXax7mVhbSwcysFo6YXd
         8UdLsBoxNKUyv+3WexooaARKM5vJtXBND/yQsA5CnZhpsRV132IrRW8YXLVvFtBokhag
         XK8AOtg//YaJPxXnIjXfBjiiCpzCGNNyoTnWbHHFtdOt/0YR2fv7NqVTCKgTozNo3dOK
         4JviX99BuS5Zze06RsajgVqaGLEuJUjnDGBF7hZmKOcDPFzmMr1/ymJx53/Zb8jt0fNH
         Amjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=F0kEsyePvZb/ixvKbdfJYbJv6DMQdOFKWsB0jb+3vOc=;
        b=Vn0aWcUtgg72i2EV4oi6D8JW/fBNNq7IJrERtuVK/gFwawaYVu/ufZzrJlZzCnXes2
         b6xq68xpfkzeEzj4OqXQfJvgkPo3xvZVLnqlGBFJnvYWmMRyO83dXhWKuvkE+KzEACUm
         0WETDul+AlgwPPH+g198jdwrqYaw4zjZTGwTlHEjoPmK1ZOiqe1cqVuriBbS7Vn5GGYC
         Wk0v994qmeMaQ1gjl80UUrAZpH28Vk/Sl+GpeVUJbeZije7iO05XsVWudHUX2kxeQdzo
         cQ/BWmxm5AzHj7Er4Ok2ExOHdzP75wF1f0n6jzLs/sB+Zckmoa+La9F93SUSSn6p3DIw
         FMkA==
X-Gm-Message-State: AOAM533LrPclb/HSeSP+9Z0DhzquB7dNE30plKo66U6ErujrKXzMjfY3
        pG8uxDgWKPofNHZzTY1VdkZ7Os0AF16b+w==
X-Google-Smtp-Source: ABdhPJwU08ajc6kH+SsN41YCTFuNnYMVDQZ2rZStdgM3BRWrZSmhk5qaZTgGfvOSQsmSvpLmgQyYig==
X-Received: by 2002:a17:902:7c8c:b029:d4:e5b2:fba4 with SMTP id y12-20020a1709027c8cb02900d4e5b2fba4mr3147111pll.82.1604697084413;
        Fri, 06 Nov 2020 13:11:24 -0800 (PST)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id ha21sm2208679pjb.2.2020.11.06.13.11.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2020 13:11:23 -0800 (PST)
Date:   Fri, 6 Nov 2020 14:11:21 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, mike.leach@linaro.org,
        coresight@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 20/26] coresight: etm4x: Handle ETM architecture
 version
Message-ID: <20201106211121.GD3299843@xps15>
References: <20201028220945.3826358-1-suzuki.poulose@arm.com>
 <20201028220945.3826358-22-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201028220945.3826358-22-suzuki.poulose@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 28, 2020 at 10:09:39PM +0000, Suzuki K Poulose wrote:
> We are about to rely on TRCDEVARCH for detecting the ETM
> and its architecture version, falling back to TRCIDR1 if
> the former is not implemented (in older broken implementations).
> 
> Also, we use the architecture version information to do
> make some decisions. Streamline the architecture version
> handling by adding helpers.
> 
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  .../coresight/coresight-etm4x-core.c          |  2 +-
>  drivers/hwtracing/coresight/coresight-etm4x.h | 60 ++++++++++++++++++-
>  2 files changed, 58 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> index 308674ab746c..4ef47a2946a4 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> @@ -842,7 +842,7 @@ static void etm4_init_arch_data(void *info)
>  	 * Otherwise for values 0x1 and above the number is N + 1 as per v4.2.
>  	 */
>  	drvdata->nr_resource = BMVAL(etmidr4, 16, 19);
> -	if ((drvdata->arch < ETM4X_ARCH_4V3) || (drvdata->nr_resource > 0))
> +	if ((drvdata->arch < ETM_ARCH_V4_3) || (drvdata->nr_resource > 0))
>  		drvdata->nr_resource += 1;
>  	/*
>  	 * NUMSSCC, bits[23:20] the number of single-shot
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x.h b/drivers/hwtracing/coresight/coresight-etm4x.h
> index f1251ddf1984..fe7107282e54 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x.h
> +++ b/drivers/hwtracing/coresight/coresight-etm4x.h
> @@ -459,7 +459,6 @@
>  #define ETM_MAX_RES_SEL			32
>  #define ETM_MAX_SS_CMP			8
>  
> -#define ETM_ARCH_V4			0x40
>  #define ETMv4_SYNC_MASK			0x1F
>  #define ETM_CYC_THRESHOLD_MASK		0xFFF
>  #define ETM_CYC_THRESHOLD_DEFAULT       0x100
> @@ -581,8 +580,63 @@
>  #define TRCVICTLR_EXLEVEL_S_MASK	(ETM_EXLEVEL_S_MASK << TRCVICTLR_EXLEVEL_S_SHIFT)
>  #define TRCVICTLR_EXLEVEL_NS_MASK	(ETM_EXLEVEL_NS_MASK << TRCVICTLR_EXLEVEL_NS_SHIFT)
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
> + *                - Bits[12:8] - Major version

This should be [11:8], bit 12 is part of RES1.

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

There are a few unused defines brought in by this patch.  I trust they will be
used in subsequent patches.

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
> @@ -744,7 +798,7 @@ struct etmv4_save_state {
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
