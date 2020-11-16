Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E3022B43F9
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 13:50:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727805AbgKPMrQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 07:47:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726287AbgKPMrQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 07:47:16 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9982AC0613D1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 04:47:14 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id p68so2650409pga.6
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 04:47:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Hjz/pG1FXMNclKUbGQCgRGQRnKutMZdz2lW6yKssubA=;
        b=KooEXHpP9BPJzYOzg3A0MdhsS2deEHUEnnFU3BBIn+0iw+BBuocqupBgv382HXDzjQ
         Gg87WkmhmkusvAh1YDUCUAk4UKju5y3dFS+RrWOhAzfItdLmyTyQ2bOyKz9Zhy9iSsjA
         Tutdr1BfzWdNXAWkP6e3Z4xqdC+VmrUiaq0SS8aSk1VbRYpzIC+iId9moBFFc5z32NL8
         QGTJlU+LHD+hcWPOW5IYU1hVAViqVK2CGXOCXdMzPwQzMMtRidfgLL0YTzWQqlyqXrUR
         S8xFhXQufNm4Ck6TGCOoGwHylxrggHoXjkD2dr6vxHVuU/mxeh96WLMwAjoIz732k2Mh
         ICkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Hjz/pG1FXMNclKUbGQCgRGQRnKutMZdz2lW6yKssubA=;
        b=OPg2omLMwIWWXqXIVU0vNm1KRhERxCB2oyHs7bABaHpNrR3mlJ9w9x/Ew8VjIJ4uFB
         aDdC1JxTNFdrhgFPQQe7x7YyP1McV+CoLF4HHTGbW2Qr0doF/pJKfFZWX4YtLEs63Hjw
         XJYfM8OAeBfHxLU7KS/AwDtNIWGTwhwyd9mMq5gJTlvPotinK5IrFYF0vnXE5jYkP/O+
         QqkwEjNP1QWXHoyYU32QFWJP5uMRLywL4wNPPMzKMoWyExEjb3bZEU3x0sW3ERdyD9K9
         HFIhLT8BebT5JPCSZ7nUvUcEq/QTbhZNvB+uG5hAds2ZFSBnjvaj3h/SBS0CmAPj2p5S
         iNFg==
X-Gm-Message-State: AOAM533/ETLtnw22iuzSUIQl94vsD2xvUCu2KwAnr0GOnqYKjY+yV44w
        ud8YbsHLgRPxXLN3e5wWkOlt
X-Google-Smtp-Source: ABdhPJxNw7SIpur2I8+FwPob3ZbSh0X23uAMFBndfW4XT94TUoy9uKQOmg+GNcS1lrfV8yUbuD/fvA==
X-Received: by 2002:a63:2cc3:: with SMTP id s186mr4008863pgs.230.1605530834088;
        Mon, 16 Nov 2020 04:47:14 -0800 (PST)
Received: from Mani-XPS-13-9360 ([2409:4072:618e:9b0a:75fd:1290:bf5c:a350])
        by smtp.gmail.com with ESMTPSA id gx24sm18002561pjb.38.2020.11.16.04.47.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 16 Nov 2020 04:47:13 -0800 (PST)
Date:   Mon, 16 Nov 2020 18:17:06 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Bhaumik Bhatt <bbhatt@codeaurora.org>
Cc:     linux-arm-msm@vger.kernel.org, hemantk@codeaurora.org,
        jhugo@codeaurora.org, loic.poulain@linaro.org,
        kvalo@codeaurora.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/6] bus: mhi: core: Remove __ prefix for MHI channel
 unprepare function
Message-ID: <20201116124706.GL3926@Mani-XPS-13-9360>
References: <1605122473-12179-1-git-send-email-bbhatt@codeaurora.org>
 <1605122473-12179-6-git-send-email-bbhatt@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1605122473-12179-6-git-send-email-bbhatt@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 11, 2020 at 11:21:12AM -0800, Bhaumik Bhatt wrote:
> The __mhi_unprepare_channel() API does not require the __ prefix.
> Get rid of it and make the internal function consistent with the
> other function names.
> 
> Signed-off-by: Bhaumik Bhatt <bbhatt@codeaurora.org>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

> ---
>  drivers/bus/mhi/core/main.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/bus/mhi/core/main.c b/drivers/bus/mhi/core/main.c
> index e8af85a..19156d4 100644
> --- a/drivers/bus/mhi/core/main.c
> +++ b/drivers/bus/mhi/core/main.c
> @@ -1312,8 +1312,8 @@ static int mhi_update_channel_state(struct mhi_controller *mhi_cntrl,
>  	return -EINVAL;
>  }
>  
> -static void __mhi_unprepare_channel(struct mhi_controller *mhi_cntrl,
> -				    struct mhi_chan *mhi_chan)
> +static void mhi_unprepare_channel(struct mhi_controller *mhi_cntrl,
> +				  struct mhi_chan *mhi_chan)
>  {
>  	int ret;
>  	struct device *dev = &mhi_cntrl->mhi_dev->dev;
> @@ -1433,7 +1433,7 @@ int mhi_prepare_channel(struct mhi_controller *mhi_cntrl,
>  
>  error_pre_alloc:
>  	mutex_unlock(&mhi_chan->mutex);
> -	__mhi_unprepare_channel(mhi_cntrl, mhi_chan);
> +	mhi_unprepare_channel(mhi_cntrl, mhi_chan);
>  
>  	return ret;
>  }
> @@ -1550,7 +1550,7 @@ int mhi_prepare_for_transfer(struct mhi_device *mhi_dev)
>  		if (!mhi_chan)
>  			continue;
>  
> -		__mhi_unprepare_channel(mhi_cntrl, mhi_chan);
> +		mhi_unprepare_channel(mhi_cntrl, mhi_chan);
>  	}
>  
>  	return ret;
> @@ -1568,7 +1568,7 @@ void mhi_unprepare_from_transfer(struct mhi_device *mhi_dev)
>  		if (!mhi_chan)
>  			continue;
>  
> -		__mhi_unprepare_channel(mhi_cntrl, mhi_chan);
> +		mhi_unprepare_channel(mhi_cntrl, mhi_chan);
>  	}
>  }
>  EXPORT_SYMBOL_GPL(mhi_unprepare_from_transfer);
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
