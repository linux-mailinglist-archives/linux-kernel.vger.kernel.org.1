Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84DCE2A8952
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 22:55:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732569AbgKEVz3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 16:55:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732536AbgKEVz3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 16:55:29 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51D63C0613CF
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 13:55:29 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id e21so2279820pgr.11
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 13:55:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=W3oSD2X4Ee+VNtkgaLJ1P2CmikRQeSChjJ6u8CjZ9uA=;
        b=e1Vtmd+IdcYOZoob+Lum7vdjW199hyhsLyOaz6rkggtIk75kxUA448vj7DmktbxJ4M
         7AKkK5Nc+5V6Lrbka73k7Pr8fz1o5kZ1oTyNYNVCWwXnq19937DEGNy/VTGnjS32kYeJ
         7z4RAjQ+qctPttuZdium23gVJ75Ip5mQdmKTLoCmBFexhuL/tg37JcKvabymMwzFeBQD
         yUyR3oAu3FB3O3FpxtBWPG70UQIlK7FU2JNU/dM1HzwECjTNVN/JdIcaymARia01syjS
         OlgCqaj4NwzgXhT7iWHW+qF/GOHeQm40zJCyvsibzovuKITsxOAf7uvbTQmFDdq5mUfh
         jynQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=W3oSD2X4Ee+VNtkgaLJ1P2CmikRQeSChjJ6u8CjZ9uA=;
        b=WKQWIUgSUGpDAosPaYfSDpj8tUtrLJSuQ8VK/hQhjKaOODFgr4QczHcWTrQoRP8i1D
         3tGtQ+kUoDRzlQwA4XDRmimYJhw8qB/ImqA/GeEvPKd9dSUv4hHS1YpT0glARNxQoOYh
         F/3/Wl+a5HUhAuYFhwkAQrNPsv+F4ibn8aukOtqCWypqHKelepLmFAVJpMGMY0f1ASW0
         CR/Oyd8gVnXWp4nT7Fn2EumKJhMeLjTOQZbFhTf87ZByhyEe9JmpfSuLQO2h3vEXI/bg
         A9Si74Or9SJNgt+00FFpCaN01Uda3eUOiLXzG9HcdOmOiC/9tV0fATMNM8m380DTD+ZO
         9StA==
X-Gm-Message-State: AOAM531kmE2Q+1ywGaWDz54eCutW0axLqlzF+44RkLeKeCmlKNmU3MTP
        088IwMpsv4XdRjPKZqs5o98UnRJlao3YXQ==
X-Google-Smtp-Source: ABdhPJw60dMNr+NG1rb/zJu1UFQ0fVWzWSbNTExpAzJbTwNwKDj4nEn8+4oYWnFJzGIxzQPTluCgQQ==
X-Received: by 2002:a17:90a:e643:: with SMTP id ep3mr4565875pjb.211.1604613328910;
        Thu, 05 Nov 2020 13:55:28 -0800 (PST)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id 3sm3721006pfv.92.2020.11.05.13.55.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 13:55:28 -0800 (PST)
Date:   Thu, 5 Nov 2020 14:55:26 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, mike.leach@linaro.org,
        coresight@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 17/26] coresight: etm4x: Cleanup secure exception
 level masks
Message-ID: <20201105215526.GC3047244@xps15>
References: <20201028220945.3826358-1-suzuki.poulose@arm.com>
 <20201028220945.3826358-19-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201028220945.3826358-19-suzuki.poulose@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 28, 2020 at 10:09:36PM +0000, Suzuki K Poulose wrote:
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
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> index a12d58a04c5d..6e3f9cb7de3f 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> @@ -733,7 +733,6 @@ static void etm4_init_arch_data(void *info)
>  	 * TRCARCHMAJ, bits[11:8] architecture major versin number
>  	 */
>  	drvdata->arch = BMVAL(etmidr1, 4, 11);
> -	drvdata->config.arch = drvdata->arch;
>  
>  	/* maximum size of resources */
>  	etmidr2 = etm4x_relaxed_read32(csa, TRCIDR2);
> @@ -749,6 +748,7 @@ static void etm4_init_arch_data(void *info)
>  	drvdata->ccitmin = BMVAL(etmidr3, 0, 11);
>  	/* EXLEVEL_S, bits[19:16] Secure state instruction tracing */
>  	drvdata->s_ex_level = BMVAL(etmidr3, 16, 19);
> +	drvdata->config.s_ex_level = drvdata->s_ex_level;
>  	/* EXLEVEL_NS, bits[23:20] Non-secure state instruction tracing */
>  	drvdata->ns_ex_level = BMVAL(etmidr3, 20, 23);
>  
> @@ -920,16 +920,9 @@ static u64 etm4_get_ns_access_type(struct etmv4_config *config)
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
> index e7f6b7b16fb7..2ac4ecb0af61 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x.h
> +++ b/drivers/hwtracing/coresight/coresight-etm4x.h
> @@ -546,6 +546,8 @@
>  /* PowerDown Control Register bits */
>  #define TRCPDCR_PU			BIT(3)
>  
> +#define TRCACATR_EXLEVEL_SHIFT		8
> +
>  /* secure state access levels - TRCACATRn */
>  #define ETM_EXLEVEL_S_APP		BIT(8)
>  #define ETM_EXLEVEL_S_OS		BIT(9)
> @@ -615,7 +617,7 @@
>   * @vmid_mask0:	VM ID comparator mask for comparator 0-3.
>   * @vmid_mask1:	VM ID comparator mask for comparator 4-7.
>   * @ext_inp:	External input selection.
> - * @arch:	ETM architecture version (for arch dependent config).
> + * @s_ex_level: Secure ELs where tracing is supported.
>   */
>  struct etmv4_config {
>  	u32				mode;
> @@ -659,7 +661,7 @@ struct etmv4_config {
>  	u32				vmid_mask0;
>  	u32				vmid_mask1;
>  	u32				ext_inp;
> -	u8				arch;
> +	u8				s_ex_level;

Instead of making s_ex_level redundant I suggest to pass a struct etmv4_drvdata
to etm4_get_access_type().

More comments to come tomorrow.

Thanks,
Mathieu

>  };
>  
>  /**
> -- 
> 2.24.1
> 
