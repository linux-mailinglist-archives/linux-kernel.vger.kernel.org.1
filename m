Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB7552FE8F5
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 12:39:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730511AbhAULha (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 06:37:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729259AbhAULhQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 06:37:16 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B64CC061795
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 03:35:49 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id j12so1463890pjy.5
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 03:35:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WSenn1e+npEriFNp9aTeAUcmLEUVQP6Mh8zTu1T/RRY=;
        b=uDFRnuqnWwewkZZNDQPW3NrfHbAdLQ4xxjVLaeZsgZplxcuxI52tf5Dvhl2fmHYh+B
         ZA3lHbLzp77nh2qvW5rHVMS0cjNA9fYnGrAf6Fcg3/JGivCw+2iE8Q2raV2vxz6IT8Yp
         7itOcu0XE6hGotdYRvuDVwKKqnqS9MtthUyh5Xbcb/Nb12bMd06woD4s0QDfERDP1oOk
         M579sEScXL4+muOYPDlZys27RfHi1lr5bhnhjen+S13Xhdwb9WYRGW211cslhEkkHHCY
         rti9REm6dEzTuw6PbhkhzFrZ2OGg35M2X4ShUdEntHvCrGUbp42X/QswHRefMjcBro4/
         3CVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WSenn1e+npEriFNp9aTeAUcmLEUVQP6Mh8zTu1T/RRY=;
        b=K898YuCRgsjBnZCEEb36jncqz1yq3V8ayrdwHDtqSZwnWsCbaplXR0i5B66AiN3c0x
         Prh16RCnVklWIhj7+IwrOM0zLDEVQ61hY2VTo9HxTsyEY2xls71EhcSqz8VqE2wnPM7z
         V+XjjVWaZwxJytY5ZZRt42d4e6Vou6J6l9RZvMucTUdww7+w7xrJo0Ojs+lG2DzWYYaJ
         AvKVmXH5pVFHuuCMOmH4f00/t+eaov4Q8vBQQrYiaoIcr6e8CsXP20Gk5HKmB87rqP5D
         B9lyNjG7uzTs8CKYq4Pj8xo/LbwlnE8ln10gHaQsoGv1q+VoFiBfFtawGsPfUsCXKAme
         Gq6w==
X-Gm-Message-State: AOAM530Gwj7FVVu5FuN11AOL9QQoKELdt1//C51VFdeUuFfhlJparpL3
        ApMGnWd9cHNp67QFTNf0eZam39ikQU70
X-Google-Smtp-Source: ABdhPJyCU+zKfaZshXGzua9V1k0eNekizFPhEEZc8l4jkrTE10W3D7lqXXgG/TqJAH6V1encJGUkeQ==
X-Received: by 2002:a17:90b:1996:: with SMTP id mv22mr11569301pjb.121.1611228948946;
        Thu, 21 Jan 2021 03:35:48 -0800 (PST)
Received: from thinkpad ([2409:4072:6182:23c4:4d5:e6d9:fc7e:c8e2])
        by smtp.gmail.com with ESMTPSA id c23sm5719776pgc.72.2021.01.21.03.35.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jan 2021 03:35:47 -0800 (PST)
Date:   Thu, 21 Jan 2021 17:05:40 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Bhaumik Bhatt <bbhatt@codeaurora.org>
Cc:     linux-arm-msm@vger.kernel.org, hemantk@codeaurora.org,
        jhugo@codeaurora.org, linux-kernel@vger.kernel.org,
        loic.poulain@linaro.org
Subject: Re: [PATCH v5 2/9] bus: mhi: core: Allow channel to be disabled from
 stopped state
Message-ID: <20210121113540.GF30041@thinkpad>
References: <1610139297-36435-1-git-send-email-bbhatt@codeaurora.org>
 <1610139297-36435-3-git-send-email-bbhatt@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1610139297-36435-3-git-send-email-bbhatt@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 08, 2021 at 12:54:50PM -0800, Bhaumik Bhatt wrote:
> If a channel was explicitly stopped but not reset, allow it to
> move to a disabled state so that the channel context can be
> cleaned up after a driver remove is issued. Since the channel
> remained in stopped state, its context on the device is not
> cleared. Allow this move if a client driver module is unloaded
> or a device crash occurs.
> 

The commit message needs to be improved. The stopped channel will by default
move to stopped state during mhi_driver_remove(). So this patch is not at all
doing anything other than clearing the context for stopped channels.

Please fix it!

> Signed-off-by: Bhaumik Bhatt <bbhatt@codeaurora.org>
> Reviewed-by: Hemant Kumar <hemantk@codeaurora.org>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

> ---
>  drivers/bus/mhi/core/init.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/bus/mhi/core/init.c b/drivers/bus/mhi/core/init.c
> index aa575d3..03c5786 100644
> --- a/drivers/bus/mhi/core/init.c
> +++ b/drivers/bus/mhi/core/init.c
> @@ -1293,7 +1293,8 @@ static int mhi_driver_remove(struct device *dev)
>  
>  		mutex_lock(&mhi_chan->mutex);
>  
> -		if (ch_state[dir] == MHI_CH_STATE_ENABLED &&
> +		if ((ch_state[dir] == MHI_CH_STATE_ENABLED ||
> +		     ch_state[dir] == MHI_CH_STATE_STOP) &&
>  		    !mhi_chan->offload_ch)
>  			mhi_deinit_chan_ctxt(mhi_cntrl, mhi_chan);
>  
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
