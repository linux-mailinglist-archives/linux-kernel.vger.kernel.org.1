Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFC3E26946D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 20:08:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726059AbgINSIZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 14:08:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726052AbgINSHg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 14:07:36 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C228C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 11:07:36 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id l191so438538pgd.5
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 11:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kHCI7393v5p3kexWunTjdq/iYFgJKMZ0uvZccmvK5y8=;
        b=Wq1KqHf7XbQNK9J/wBkbvAfCmPENj64N2mQRwZxLftk5ZvLJHMrD5KIRurHlZakzam
         g5Dhpjg6yuiPSn783tfxST3oemxDNWGHY8QjYw5lqQ8UVYyppUj6vCC3VFQo8k3mc2aL
         JNP9W6DX666rVAfjikQ75Qg0yTTl25zoTMezx6mW1Ty1LYP5p/CtnlsoodcEeO7Z0aLP
         Xzpe+wlxBe4BXfPPocf0g8pvNdad57vqt9HrwddSWHzEhKg827LCHxAS76YL/3euUKdO
         +aj8pgobrGQbGokyuLRFQL12u0pD0XY+4QX4qt3TL1j+hA51Q4m9cCW56TGEB9+iJ4Km
         cL3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kHCI7393v5p3kexWunTjdq/iYFgJKMZ0uvZccmvK5y8=;
        b=UPRkvsnWNLPelk9+tTeIqKY3pV50zCBoZireFlyZiOn+XmW1LDnsQMTyAa2oNs+r4Z
         3/3NYPei6PYJ6a8ULTjg+d8d6YTDivqLtr+nRI+brMWXL4F0C2QiqmEfKEH+jwW/1uvg
         FfQZtAo0+Ld331bzfSOMFsNvNpCXv6Ar84Yuyr4Z5h5cKaej+lfdBdCs2tm6xvWbyLPr
         2v9je1C9MvJOVNpH2wGRLOQqzAamIyagDdO55wRqjRDGFdO6E+sC8zm83JudGlmkk1nm
         0N6otiUPhRRaCzLiArjKBPfUF6GPhh20twcvcEM6nWdmTxC9Azyizg3vuqZjHoiLx327
         k8AQ==
X-Gm-Message-State: AOAM532d5CT9y9zArdbviVua0oNvDHRa6Q6EjXLCbohJFjGvQuMj/GXf
        vY0tMIlCotXid75x1Myl61RrsQ==
X-Google-Smtp-Source: ABdhPJxrFrjvVqOIlIBr14qaBpuCIcZBJRtrTbHN8EzlL6RAfkfE2K09U0mY0LwWELCoLih8z4PzsA==
X-Received: by 2002:a63:a55e:: with SMTP id r30mr12232178pgu.61.1600106855715;
        Mon, 14 Sep 2020 11:07:35 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id y23sm10906205pfp.65.2020.09.14.11.07.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 11:07:35 -0700 (PDT)
Date:   Mon, 14 Sep 2020 12:07:32 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Tingwei Zhang <tingwei@codeaurora.org>
Cc:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mike Leach <mike.leach@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Leo Yan <leo.yan@linaro.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Russell King <linux@armlinux.org.uk>,
        Kim Phillips <kim.phillips@arm.com>,
        Mian Yousaf Kaukab <ykaukab@suse.de>, tsoni@codeaurora.org,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Mao Jinlong <jinlmao@codeaurora.org>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 19/24] coresight: cti: don't disable ect device if
 it's not enabled
Message-ID: <20200914180732.GB3238264@xps15>
References: <20200821034445.967-1-tingwei@codeaurora.org>
 <20200821034445.967-20-tingwei@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200821034445.967-20-tingwei@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 21, 2020 at 11:44:40AM +0800, Tingwei Zhang wrote:
> If associated ect device is not enabled at first place, disable
> routine should not be called. Add ect_enabled flag to check whether
> ect device is enabled. Fix the issue in below case.  Ect device is
> not available when associated coresight device enabled and the
> association is established after coresight device is enabled.
> 
> Signed-off-by: Mike Leach <mike.leach@linaro.org>
> Signed-off-by: Tingwei Zhang <tingwei@codeaurora.org>
> ---

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

>  drivers/hwtracing/coresight/coresight.c | 11 ++++++++---
>  include/linux/coresight.h               |  1 +
>  2 files changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight.c b/drivers/hwtracing/coresight/coresight.c
> index 6c09be15d60c..d354fd57474e 100644
> --- a/drivers/hwtracing/coresight/coresight.c
> +++ b/drivers/hwtracing/coresight/coresight.c
> @@ -244,13 +244,18 @@ coresight_control_assoc_ectdev(struct coresight_device *csdev, bool enable)
>  
>  	if (!ect_csdev)
>  		return 0;
> +	if ((!ect_ops(ect_csdev)->enable) || (!ect_ops(ect_csdev)->disable))
> +		return 0;
>  
>  	if (enable) {
> -		if (ect_ops(ect_csdev)->enable)
> -			ect_ret = ect_ops(ect_csdev)->enable(ect_csdev);
> +		ect_ret = ect_ops(ect_csdev)->enable(ect_csdev);
> +		if (!ect_ret)
> +			csdev->ect_enabled = true;
>  	} else {
> -		if (ect_ops(ect_csdev)->disable)
> +		if (csdev->ect_enabled) {
>  			ect_ret = ect_ops(ect_csdev)->disable(ect_csdev);
> +			csdev->ect_enabled = false;
> +		}
>  	}
>  
>  	/* output warning if ECT enable is preventing trace operation */
> diff --git a/include/linux/coresight.h b/include/linux/coresight.h
> index 3bb738f9a326..7d3c87e5b97c 100644
> --- a/include/linux/coresight.h
> +++ b/include/linux/coresight.h
> @@ -208,6 +208,7 @@ struct coresight_device {
>  	/* sysfs links between components */
>  	int nr_links;
>  	bool has_conns_grp;
> +	bool ect_enabled; /* true only if associated ect device is enabled */
>  };
>  
>  /*
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
