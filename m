Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 266292C8FFF
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 22:26:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388616AbgK3V0B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 16:26:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388607AbgK3V0B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 16:26:01 -0500
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD045C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 13:25:20 -0800 (PST)
Received: by mail-pj1-x1043.google.com with SMTP id h7so441427pjk.1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 13:25:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=y7RO377EB18tjslC6Vh73hVU4r2GlVkMnINYXjKoMGI=;
        b=EEG7Q59nhTN7LTyzQsWDFTJ2mQKLxlunkXqY4n/f7NEO3o8/FLGmmIdYYnfumi0Yka
         bH5IFD4tqH1P9qgDAH4zvtO9Ihdl678rbZz7wbfICDo0Yt5FMtY4gYEhamngqcpObpCx
         dA3BiaGnCj8w4VEcSiyodpUqMr67upLWoAA+/PMXMFWqCeV0b5pfj+kUHg7CDKu/qZCg
         ZG6GuuOvR2CscxImFOXd90sSm4+zIVn8kkUZ29Tl/pNKl97iqgjvTY/zpLl1pEo99Rn0
         l1x2TkduANMiFD2QqvIYr2TcGpTc5qqIZzo3c2EZVtjzFdpGkYdREhHzQjsWEFza40F2
         Ez6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=y7RO377EB18tjslC6Vh73hVU4r2GlVkMnINYXjKoMGI=;
        b=mD5WbnADb+9wx/do7pUtwMxcumnwGelgl/qyJAtQV2eF4q0QCceh9PnGaqZ86ejVUc
         nKREnyoxsHyMB3Sf+OtEs8WxEG4RvlSwxCeKBxL6+kMNwjNSSPpSE0dx8NZLMosKaVlt
         azF/BOBOo09HfX1w1HBLP2TP6IuhNeWkKXQCpE5N4kZMpLPlO/c11sF7MOvEmpiPFaYB
         PhSCpCP3hUgqvBoD7E2vQ5Y6u6RX2RgRPEFwMWqVXyfgHTi7M69rtXdHOq++UmFzstCF
         y6+0b6UfrecTo7NmpII4MT/Hh1ZmRJyIrObppOlOmz0VBLNXwn/HxtUbRoVD9vNGmojm
         THzg==
X-Gm-Message-State: AOAM533+ymdlH5PViS3SAC/sxk9WUiQpgspKSI+H1BcQdHJrZUtrvO8F
        fnLnEiA9z8rpIPp0e56S1lOWRA==
X-Google-Smtp-Source: ABdhPJxEp792ADqyvD9lgPUNn4UqYYwWJliH9jI8V3GLi8nH4zrWI5CUDhpW7nfGnF2kgejvnPPryQ==
X-Received: by 2002:a17:902:8490:b029:d6:d165:fde with SMTP id c16-20020a1709028490b02900d6d1650fdemr20389296plo.73.1606771520423;
        Mon, 30 Nov 2020 13:25:20 -0800 (PST)
Received: from xps15 (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id g31sm16358284pgl.34.2020.11.30.13.25.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Nov 2020 13:25:19 -0800 (PST)
Date:   Mon, 30 Nov 2020 14:25:17 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, mike.leach@linaro.org,
        linux-kernel@vger.kernel.org, anshuman.khandual@arm.com,
        jonathan.zhouwen@huawei.com, coresight@lists.linaro.org
Subject: Re: [PATCH v4 13/25] coresight: etm4x: Cleanup secure exception
 level masks
Message-ID: <20201130212517.GH1092947@xps15>
References: <20201119164547.2982871-1-suzuki.poulose@arm.com>
 <20201119164547.2982871-14-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201119164547.2982871-14-suzuki.poulose@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 19, 2020 at 04:45:35PM +0000, Suzuki K Poulose wrote:
> We rely on the ETM architecture version to decide whether
> Secure EL2 is available on the CPU for excluding the level
> for address comparators and viewinst main control register.
> We must instead use the TRCDIDR3.EXLEVEL_S field to detect
> the supported levels.
> 
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  drivers/hwtracing/coresight/coresight-etm4x-core.c | 13 +++----------
>  drivers/hwtracing/coresight/coresight-etm4x.h      |  6 ++++--
>  2 files changed, 7 insertions(+), 12 deletions(-)
>

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
 
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> index 85a165d1245e..a1f294703c43 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> @@ -742,7 +742,6 @@ static void etm4_init_arch_data(void *info)
>  	 * TRCARCHMAJ, bits[11:8] architecture major versin number
>  	 */
>  	drvdata->arch = BMVAL(etmidr1, 4, 11);
> -	drvdata->config.arch = drvdata->arch;
>  
>  	/* maximum size of resources */
>  	etmidr2 = etm4x_relaxed_read32(csa, TRCIDR2);
> @@ -758,6 +757,7 @@ static void etm4_init_arch_data(void *info)
>  	drvdata->ccitmin = BMVAL(etmidr3, 0, 11);
>  	/* EXLEVEL_S, bits[19:16] Secure state instruction tracing */
>  	drvdata->s_ex_level = BMVAL(etmidr3, 16, 19);
> +	drvdata->config.s_ex_level = drvdata->s_ex_level;
>  	/* EXLEVEL_NS, bits[23:20] Non-secure state instruction tracing */
>  	drvdata->ns_ex_level = BMVAL(etmidr3, 20, 23);
>  
> @@ -929,16 +929,9 @@ static u64 etm4_get_ns_access_type(struct etmv4_config *config)
>  static u64 etm4_get_access_type(struct etmv4_config *config)
>  {
>  	u64 access_type = etm4_get_ns_access_type(config);
> -	u64 s_hyp = (config->arch & 0x0f) >= 0x4 ? ETM_EXLEVEL_S_HYP : 0;
>  
> -	/*
> -	 * EXLEVEL_S, bits[11:8], don't trace anything happening
> -	 * in secure state.
> -	 */
> -	access_type |= (ETM_EXLEVEL_S_APP	|
> -			ETM_EXLEVEL_S_OS	|
> -			s_hyp			|
> -			ETM_EXLEVEL_S_MON);
> +	/* All supported secure ELs are excluded */
> +	access_type |= (u64)config->s_ex_level << TRCACATR_EXLEVEL_SHIFT;
>  
>  	return access_type;
>  }
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x.h b/drivers/hwtracing/coresight/coresight-etm4x.h
> index d8f047547a36..94ead0cd98df 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x.h
> +++ b/drivers/hwtracing/coresight/coresight-etm4x.h
> @@ -549,6 +549,8 @@
>  /* PowerDown Control Register bits */
>  #define TRCPDCR_PU			BIT(3)
>  
> +#define TRCACATR_EXLEVEL_SHIFT		8
> +
>  /* secure state access levels - TRCACATRn */
>  #define ETM_EXLEVEL_S_APP		BIT(8)
>  #define ETM_EXLEVEL_S_OS		BIT(9)
> @@ -618,7 +620,7 @@
>   * @vmid_mask0:	VM ID comparator mask for comparator 0-3.
>   * @vmid_mask1:	VM ID comparator mask for comparator 4-7.
>   * @ext_inp:	External input selection.
> - * @arch:	ETM architecture version (for arch dependent config).
> + * @s_ex_level: Secure ELs where tracing is supported.
>   */
>  struct etmv4_config {
>  	u32				mode;
> @@ -662,7 +664,7 @@ struct etmv4_config {
>  	u32				vmid_mask0;
>  	u32				vmid_mask1;
>  	u32				ext_inp;
> -	u8				arch;
> +	u8				s_ex_level;
>  };
>  
>  /**
> -- 
> 2.24.1
> 
