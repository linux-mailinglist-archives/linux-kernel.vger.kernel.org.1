Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCB7B28F653
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 18:03:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389479AbgJOQDE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 12:03:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388560AbgJOQDE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 12:03:04 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1099CC061755
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 09:03:04 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id j8so2341955pjy.5
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 09:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Iv2OYAnv0SA23u+SDCrJEFVeIFrM8td2tmeExloIU5M=;
        b=WMP4y67p7K2jBWI8kiEW/1mYKERGeEA8o4azow+B1ckeg5kmfX0f0KUshy0CIDEzvZ
         ECOITkGCaMHeGCe1f8GRrsbhbRh7kEUWzQYYS2HfyontUnA8rPrUcVddem9BHoofetTR
         JDACBNsZUzKEhdFB28TxjiHCL4s0UfHm2lJi/2zD3rYVujTQVpmh8txHyXUM3L/J6ATh
         ZttJ68BfA/++TMOSM5r6ruoOqSiIF4DgLbuOQjfg1SF1mO87JGQJP2mjPJV57v0bKpoS
         tjeejwK48/Ix3bnLBLsGi04q6grhk850aFoW1h1bIOvdChjissWnNXgzk7Wdq4CpnzHZ
         hMWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Iv2OYAnv0SA23u+SDCrJEFVeIFrM8td2tmeExloIU5M=;
        b=V/iOuEBLRDx2XqRt0kjIdLzgfKViwt6HDSbn67Kgqf2rFhFCSLYYeMo4vR3h2IhTwY
         u5l1cn4Yuq5Uihp9TrgU3n53lAuD7F83NxhbWHoyxt9dmRxV8UXXK+mWK0CTfaTrf2Tl
         clEgHsQovFjiMq8ZCsziS3OfcaOMOQM9roWEkpG2sS07GMFx4oDyyioLctx8Y6wnS/Um
         S/UMlYGx1TQGbN4wzfZH84g5RfUS5kL2/Sb9og65pFXw0+yO0/xLTJ38vSekWeyVZKnW
         0Lf8WD/URExkv+tVjMuVyQET+Gb+FYTOfeVOIdx4OTtcdjsJBQ7R+1dkori9bQkpkaYp
         dXvg==
X-Gm-Message-State: AOAM533msPkynL7Clf6fCKyNmGCnDovWcMUCUc2dgtMs3uz+0b+MtkVy
        RdWKiCD63FvwKMKH77VSuy8G8Q==
X-Google-Smtp-Source: ABdhPJwfIKbf4iP20eUHbQ17ExMMt9lJlaF7boqyuBwhO2o5YDtjBcdTQ4yl+RKs1Dq25HBcaUH+wQ==
X-Received: by 2002:a17:90a:1702:: with SMTP id z2mr5026194pjd.88.1602777780374;
        Thu, 15 Oct 2020 09:03:00 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id s186sm3920831pfc.171.2020.10.15.09.02.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2020 09:02:59 -0700 (PDT)
Date:   Thu, 15 Oct 2020 10:02:57 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Cc:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>, coresight@lists.linaro.org,
        Stephen Boyd <swboyd@chromium.org>,
        Denis Nikitin <denik@chromium.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] coresight: etm4x: Add config to exclude kernel mode
 tracing
Message-ID: <20201015160257.GA1450102@xps15>
References: <20201015124522.1876-1-saiprakash.ranjan@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201015124522.1876-1-saiprakash.ranjan@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 15, 2020 at 06:15:22PM +0530, Sai Prakash Ranjan wrote:
> On production systems with ETMs enabled, it is preferred to
> exclude kernel mode(NS EL1) tracing for security concerns and
> support only userspace(NS EL0) tracing. So provide an option
> via kconfig to exclude kernel mode tracing if it is required.
> This config is disabled by default and would not affect the
> current configuration which has both kernel and userspace
> tracing enabled by default.
>

One requires root access (or be part of a special trace group) to be able to use
the cs_etm PMU.  With this kind of elevated access restricting tracing at EL1
provides little in terms of security.

Thanks,
Mathieu
 
> Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
> ---
>  drivers/hwtracing/coresight/Kconfig                | 9 +++++++++
>  drivers/hwtracing/coresight/coresight-etm4x-core.c | 6 +++++-
>  2 files changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hwtracing/coresight/Kconfig b/drivers/hwtracing/coresight/Kconfig
> index c1198245461d..52435de8824c 100644
> --- a/drivers/hwtracing/coresight/Kconfig
> +++ b/drivers/hwtracing/coresight/Kconfig
> @@ -110,6 +110,15 @@ config CORESIGHT_SOURCE_ETM4X
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called coresight-etm4x.
>  
> +config CORESIGHT_ETM4X_EXCL_KERN
> +	bool "Coresight ETM 4.x exclude kernel mode tracing"
> +	depends on CORESIGHT_SOURCE_ETM4X
> +	help
> +	  This will exclude kernel mode(NS EL1) tracing if enabled. This option
> +	  will be useful to provide more flexible options on production systems
> +	  where only userspace(NS EL0) tracing might be preferred for security
> +	  reasons.
> +
>  config CORESIGHT_STM
>  	tristate "CoreSight System Trace Macrocell driver"
>  	depends on (ARM && !(CPU_32v3 || CPU_32v4 || CPU_32v4T)) || ARM64
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> index abd706b216ac..7e5669e5cd1f 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> @@ -832,6 +832,9 @@ static u64 etm4_get_ns_access_type(struct etmv4_config *config)
>  {
>  	u64 access_type = 0;
>  
> +	if (IS_ENABLED(CONFIG_CORESIGHT_ETM4X_EXCL_KERN))
> +		config->mode |= ETM_MODE_EXCL_KERN;
> +
>  	/*
>  	 * EXLEVEL_NS, bits[15:12]
>  	 * The Exception levels are:
> @@ -849,7 +852,8 @@ static u64 etm4_get_ns_access_type(struct etmv4_config *config)
>  		access_type = ETM_EXLEVEL_NS_HYP;
>  	}
>  
> -	if (config->mode & ETM_MODE_EXCL_USER)
> +	if (config->mode & ETM_MODE_EXCL_USER &&
> +	    !IS_ENABLED(CONFIG_CORESIGHT_ETM4X_EXCL_KERN))
>  		access_type |= ETM_EXLEVEL_NS_APP;
>  
>  	return access_type;
> 
> base-commit: 3477326277451000bc667dfcc4fd0774c039184c
> -- 
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> of Code Aurora Forum, hosted by The Linux Foundation
> 
