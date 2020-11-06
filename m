Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E05CB2A8EDD
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 06:26:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726090AbgKFF0B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 00:26:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725979AbgKFF0A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 00:26:00 -0500
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B473FC0613D2
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 21:26:00 -0800 (PST)
Received: by mail-pl1-x641.google.com with SMTP id p4so148504plr.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 21:26:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dWFmJSmMkzR+Uad+HotN/bLAH+aGeTDhTIhR7y4Osz4=;
        b=lQ7sUrQwFwA65z8XIV/1OrFNCwF1wpgZvP0iRY/UhGXlwEY2z45LUKV3qipYGFDw5C
         oyXN4l/NuSYMb1kldHmcCnC0Rfuu0KALdUsXV00nGr6uZD6Qact/FD6B6f82A4vObmlh
         CGY3yotUFEDj0kzC9xttQ5v92GSlhsvwTHrDedrTivqp9rbysFkFqMWdlgmsKDM1X9/N
         ispxVQYPWmDoFkc9k/4LU1yfBRTETyn4ryHDuirafZehJuNNrXAKBau9oh0WosSWnheU
         nzqOM8s7yzfBKax4iOLLwbDBsaZxoiXM8TMiU3McQMxZEGzw2GFrFYWU2aKZ8TYjFwuR
         GUmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dWFmJSmMkzR+Uad+HotN/bLAH+aGeTDhTIhR7y4Osz4=;
        b=Z1sgCYMquUMzV5+8cJMi9kfixnMtJCCeyVGT9SUOHZ5rb2vbj/Kj6OuXWK5lRD6wRZ
         eojw2nEFYbQCvOPzS+fD0sZw3S/L6vP3CXuu+0bw37ely4wJH94MyRySmCMeUu8ZrYqm
         6q4zFIftPPzv6x2m9KHjRbZnBIKO2hPgVQUrutRshnbCP3ppRhacjl+BMSz3uRLnDhgp
         Tq9l5i/Aq/ZJRMkHpVNnQ7z2w48R+fE0Jc7ovrX72DyQPb6CBVPhs7PLPDopkee9Z1NT
         vB1X5C/xCptVmgFgDn382WjqVoawUgto+Tg+pc9EmlRrK0xQa3uSjU46RyV5+xzTEdwO
         SdKQ==
X-Gm-Message-State: AOAM533alCK9mry9wzLy8BpSncXdkqSdKCm2Kls2uhA3prrJvLp5TYHQ
        8DhqAqjtvdiw6vlBFWRMGHyJOq5GK5P6
X-Google-Smtp-Source: ABdhPJzp0NoM3yI7AVtmcQwDbCiiD1+GM+ZQR8tweE7CdIhc9T6fVZz2vt+IdJ1UXf5BVfFuHbI6SQ==
X-Received: by 2002:a17:902:760c:b029:d6:efa5:4cdd with SMTP id k12-20020a170902760cb02900d6efa54cddmr500153pll.56.1604640360100;
        Thu, 05 Nov 2020 21:26:00 -0800 (PST)
Received: from work ([103.59.133.81])
        by smtp.gmail.com with ESMTPSA id l190sm151232pfl.205.2020.11.05.21.25.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 05 Nov 2020 21:25:59 -0800 (PST)
Date:   Fri, 6 Nov 2020 10:55:54 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Bhaumik Bhatt <bbhatt@codeaurora.org>
Cc:     linux-arm-msm@vger.kernel.org, hemantk@codeaurora.org,
        jhugo@codeaurora.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/6] bus: mhi: core: Remove unnecessary counter from
 mhi_firmware_copy()
Message-ID: <20201106052554.GB3473@work>
References: <1604622869-40212-1-git-send-email-bbhatt@codeaurora.org>
 <1604622869-40212-2-git-send-email-bbhatt@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1604622869-40212-2-git-send-email-bbhatt@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 05, 2020 at 04:34:24PM -0800, Bhaumik Bhatt wrote:
> There is an extra 'i' counter in the mhi_firmware_copy() function
> which is unused. Remove it to clean-up code and reduce stack
> space as well as improve efficiency of the function.
> 
> Fixes: cd457afb1667 ("bus: mhi: core: Add support for downloading firmware over BHIe")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Bhaumik Bhatt <bbhatt@codeaurora.org>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

> ---
>  drivers/bus/mhi/core/boot.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/bus/mhi/core/boot.c b/drivers/bus/mhi/core/boot.c
> index 24422f5..6b6fd96 100644
> --- a/drivers/bus/mhi/core/boot.c
> +++ b/drivers/bus/mhi/core/boot.c
> @@ -365,7 +365,6 @@ static void mhi_firmware_copy(struct mhi_controller *mhi_cntrl,
>  	size_t remainder = firmware->size;
>  	size_t to_cpy;
>  	const u8 *buf = firmware->data;
> -	int i = 0;
>  	struct mhi_buf *mhi_buf = img_info->mhi_buf;
>  	struct bhi_vec_entry *bhi_vec = img_info->bhi_vec;
>  
> @@ -377,7 +376,6 @@ static void mhi_firmware_copy(struct mhi_controller *mhi_cntrl,
>  
>  		buf += to_cpy;
>  		remainder -= to_cpy;
> -		i++;
>  		bhi_vec++;
>  		mhi_buf++;
>  	}
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
