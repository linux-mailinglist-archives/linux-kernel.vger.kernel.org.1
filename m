Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8BCA269470
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 20:09:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726095AbgINSIm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 14:08:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbgINSIJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 14:08:09 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EA49C061788
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 11:08:08 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id j34so428032pgi.7
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 11:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HiLz1RcLzusQXgfz36ooDNe/17JxLFBNTfE6VhS7a/0=;
        b=vJxbTWUocKX1FfLqSSVE7HKpizU2MWTMXsREQ2ChXEtrFCqDRhITBkAWu4HmDSFMxl
         O88TRzaUjISbqIb0paYVueJyG2N1gLmfwTWvi76PBn28KSd+Un42/vnZ6KrckS9SgBR5
         rcvKGCxaXEmFpcSYlMyK9vss1dBeiHjeWrd3X0uh+DcutEDaL4owZJ9hlEZYreETLcR7
         kAAKc693Ig1qejFLE2FFyyLxXbwrDg5UMfnfbDedEzNZayKTrzrTLIyPfm+mqLc+ulWL
         M4bHGwOpYFtnzkymQ8EMeNRsIdafzU75yc35/szbUXEVnJR6wvSvwly5kB6kZB5+fa+e
         b7Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HiLz1RcLzusQXgfz36ooDNe/17JxLFBNTfE6VhS7a/0=;
        b=qA4uJdB7IYmzguVt+zxWA5rVb3sULTwFwyPn0uExLiVeskbHekLU8cBrlnMjQJvDFa
         hMBgqNWQEoRjNlCK0rV+0tPQ5SdTlOAX7C9uhORjVaS60PcEACuxxkt6mVd+Rs6DbQer
         Ovy2rsKflD8GPs26XkATaJ6hx42YuFpU6fhLbqKVnLATfWpYPvPROjfyy7BnadutQ0Ax
         oEruk0ZVY6jiqYx6stnzQa1Yc5cJxCKVmbqbsPt5Kdrd8uXL3a5XvAw0iB7yPtrDBGRp
         vOR89j0e8v+KJ4qMzifGZtW2VFAdpn2YqGvyINgyH1Xk6T13INAxrbvzKUF2KSESXQqL
         vd7A==
X-Gm-Message-State: AOAM533da1OoxyomCntvaymt3IlWFzpcWz+jGwK6f1BqIfFLHsadz3Yd
        XwIJ7hoQ84V5ZFE5ALlxci21UA==
X-Google-Smtp-Source: ABdhPJwUskmYuzX/7PmB2Mv7QAdxGmL0bmHu5FbDXd984uW2TNPzmWobyxIfbcqU1vQzbjC0zKh12g==
X-Received: by 2002:aa7:9f04:0:b029:13e:d13d:a13b with SMTP id g4-20020aa79f040000b029013ed13da13bmr13543279pfr.35.1600106888120;
        Mon, 14 Sep 2020 11:08:08 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id j20sm10938084pfh.146.2020.09.14.11.08.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 11:08:07 -0700 (PDT)
Date:   Mon, 14 Sep 2020 12:08:05 -0600
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
Subject: Re: [PATCH v10 20/24] coresight: cti: increase reference count when
 enabling cti
Message-ID: <20200914180805.GC3238264@xps15>
References: <20200821034445.967-1-tingwei@codeaurora.org>
 <20200821034445.967-21-tingwei@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200821034445.967-21-tingwei@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 21, 2020 at 11:44:41AM +0800, Tingwei Zhang wrote:
> CTI device is enabled when associated coresight device is enabled.
> Increase the module and device reference count for CTI device
> when it's enabled. This can prevent CTI device be removed or
> module be unloaded when CTI device is enabled by an active trace
> session.
> 
> Signed-off-by: Mike Leach <mike.leach@linaro.org>
> Signed-off-by: Tingwei Zhang <tingwei@codeaurora.org>
> ---

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

>  drivers/hwtracing/coresight/coresight.c | 17 ++++++++++++++---
>  1 file changed, 14 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight.c b/drivers/hwtracing/coresight/coresight.c
> index d354fd57474e..6c9f6930b8b8 100644
> --- a/drivers/hwtracing/coresight/coresight.c
> +++ b/drivers/hwtracing/coresight/coresight.c
> @@ -241,19 +241,30 @@ coresight_control_assoc_ectdev(struct coresight_device *csdev, bool enable)
>  {
>  	int ect_ret = 0;
>  	struct coresight_device *ect_csdev = csdev->ect_dev;
> +	struct module *mod;
>  
>  	if (!ect_csdev)
>  		return 0;
>  	if ((!ect_ops(ect_csdev)->enable) || (!ect_ops(ect_csdev)->disable))
>  		return 0;
>  
> +	mod = ect_csdev->dev.parent->driver->owner;
>  	if (enable) {
> -		ect_ret = ect_ops(ect_csdev)->enable(ect_csdev);
> -		if (!ect_ret)
> -			csdev->ect_enabled = true;
> +		if (try_module_get(mod)) {
> +			ect_ret = ect_ops(ect_csdev)->enable(ect_csdev);
> +			if (ect_ret) {
> +				module_put(mod);
> +			} else {
> +				get_device(ect_csdev->dev.parent);
> +				csdev->ect_enabled = true;
> +			}
> +		} else
> +			ect_ret = -ENODEV;
>  	} else {
>  		if (csdev->ect_enabled) {
>  			ect_ret = ect_ops(ect_csdev)->disable(ect_csdev);
> +			put_device(ect_csdev->dev.parent);
> +			module_put(mod);
>  			csdev->ect_enabled = false;
>  		}
>  	}
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
