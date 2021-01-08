Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AA152EEAAB
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 02:06:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729783AbhAHBDW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 20:03:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729768AbhAHBDV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 20:03:21 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA01AC0612F5
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jan 2021 17:02:40 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id j1so4805776pld.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jan 2021 17:02:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Dd2tV1nAbb6DFWrXlfS2dcWhKRewQrKs8AwXO16cMcQ=;
        b=GQ8fK2NkFWRFTISaOVkknrwWAUmz05q7mjAQ5vasikad+4wPS+MAPHZuVckm2kAxrR
         GxE3TAAAaKgAV56Ty+l31U6U8AtiOKXHvyIG0JvW8dFyhbx5QOD5JIdJeXKHDSB2TacX
         jRL6vNXUjbKQnyBiB5rAlfJ5KHdT1I593W7KAlZUZNOk1mHsZ2nmwfHOHuD90msHuevV
         PgxT9YmhWZTqY6sEclfmgKS4QipTsKoYfk6oL4cHjbIKBJ+14fg3TccaeAfEI8C3ats7
         QAPyAtuDOZ2YweTWMchQw9IPxOkLeTKF+zVkcqbz1elVkUC08Gl+J3EYTICql5zSiXnp
         7c1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Dd2tV1nAbb6DFWrXlfS2dcWhKRewQrKs8AwXO16cMcQ=;
        b=jLpSqTUSCLDk9qfQMAfI0PUzOTE+v6YLcaRH7K5sgioyMJI4KKQIKJ3xbbe+OpLK2F
         +PelbGsSaHRkwg7rFdLTeBSMyWFc6AB47yHd1tenGXccvtwsC7mlPwoEa6o48HyVxkx+
         /QJ74Oe4pjlZ94BFG8VV/h9iWIdZ75C+MoxwricPRuK3MatCQtOCU/rkAosNyCdOLfPt
         g1GN7kZWBaslR7XTgzIFf2IMRezehzhWoWJWKXjLf4S+bYu+3eVcO03seJ8/bHDIarDt
         x2gH+HMgfiLoBt+ejjOh60lNzWlSQfRnvAyIkAIjqfOhViJTfDpzvWZnH6Y8SUsFLQh7
         4qkw==
X-Gm-Message-State: AOAM530fZDhLlvyUOhK7gj6GQS1fLH9O3yyvNFPsgKMrF24Qa/qNRD0W
        q/U3YVHQU44qBfCf9aDJoubqkw==
X-Google-Smtp-Source: ABdhPJygQsUfEobyUpzUkEtx1NDcLX6rmTb4lQ8ji23E90asx6dR+3uKyqiClJk87UPdfBrejl9jyg==
X-Received: by 2002:a17:90b:298:: with SMTP id az24mr1130598pjb.128.1610067760478;
        Thu, 07 Jan 2021 17:02:40 -0800 (PST)
Received: from xps15 (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id b26sm7307722pgm.25.2021.01.07.17.02.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jan 2021 17:02:39 -0800 (PST)
Date:   Thu, 7 Jan 2021 18:02:38 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        coresight@lists.linaro.org, leo.yan@linaro.org,
        mike.leach@linaro.org, anshuman.khandual@arm.com,
        Jonathan Zhou <jonathan.zhouwen@huawei.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH v6 26/26] coresight: Add support for v8.4 SelfHosted
 tracing
Message-ID: <20210108010238.GI43045@xps15>
References: <20210107123859.674252-1-suzuki.poulose@arm.com>
 <20210107123859.674252-27-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210107123859.674252-27-suzuki.poulose@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 07, 2021 at 12:38:59PM +0000, Suzuki K Poulose wrote:
> From: Jonathan Zhou <jonathan.zhouwen@huawei.com>
> 
> v8.4 tracing extensions added support for trace filtering controlled
> by TRFCR_ELx. This must be programmed to allow tracing at EL1/EL2 and
> EL0. The timestamp used is the virtual time. Also enable CONTEXIDR_EL2
> tracing if we are running the kernel at EL2.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: Mike Leach <mike.leach@linaro.org>
> Cc: Will Deacon <will@kernel.org>
> Signed-off-by: Jonathan Zhou <jonathan.zhouwen@huawei.com>
> [ Move the trace filtering setup etm_init_arch_data() and
>  clean ups]
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

> ---
>  .../coresight/coresight-etm4x-core.c          | 25 +++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> index 34a6cdff75e7..6d96f4226bca 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> @@ -859,6 +859,30 @@ static bool etm4_init_csdev_access(struct etmv4_drvdata *drvdata,
>  	return false;
>  }
>  
> +static void cpu_enable_tracing(void)
> +{
> +	u64 dfr0 = read_sysreg(id_aa64dfr0_el1);
> +	u64 trfcr;
> +
> +	if (!cpuid_feature_extract_unsigned_field(dfr0, ID_AA64DFR0_TRACE_FILT_SHIFT))
> +		return;
> +
> +	/*
> +	 * If the CPU supports v8.4 SelfHosted Tracing, enable
> +	 * tracing at the kernel EL and EL0, forcing to use the
> +	 * virtual time as the timestamp.
> +	 */
> +	trfcr = (TRFCR_ELx_TS_VIRTUAL |
> +		 TRFCR_ELx_ExTRE |
> +		 TRFCR_ELx_E0TRE);
> +
> +	/* If we are running at EL2, allow tracing the CONTEXTIDR_EL2. */
> +	if (is_kernel_in_hyp_mode())
> +		trfcr |= TRFCR_EL2_CX;
> +
> +	write_sysreg_s(trfcr, SYS_TRFCR_EL1);
> +}
> +
>  static void etm4_init_arch_data(void *info)
>  {
>  	u32 etmidr0;
> @@ -1044,6 +1068,7 @@ static void etm4_init_arch_data(void *info)
>  	/* NUMCNTR, bits[30:28] number of counters available for tracing */
>  	drvdata->nr_cntr = BMVAL(etmidr5, 28, 30);
>  	etm4_cs_lock(drvdata, csa);
> +	cpu_enable_tracing();
>  }
>  
>  static inline u32 etm4_get_victlr_access_type(struct etmv4_config *config)
> -- 
> 2.24.1
> 
