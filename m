Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F9702AB7A3
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 12:59:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729267AbgKIL74 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 06:59:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727077AbgKIL74 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 06:59:56 -0500
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 002D6C0613D3
        for <linux-kernel@vger.kernel.org>; Mon,  9 Nov 2020 03:59:55 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id w4so6944622pgg.13
        for <linux-kernel@vger.kernel.org>; Mon, 09 Nov 2020 03:59:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lr4Cz9thkO5BeHlwWTqxwoeU7qvgDXar1hvGAFKb8x0=;
        b=Azjcqpp4OiWVMYTCnFEPXlDTuJoPuD+JB7fGW2oTcslLq8s3d/IGt5sXjU98vnzNRq
         m1EiQPZ+OW/fQvONuPIUPvoyiTYsXQJ8sKPXE8671rdkFcSEFlGvmsh6VzNLg6KLz5qB
         rOJ9QKn+YTFiBPYOn6WP/Il5ltT/HK8kAV0JMBfP8SU78SxoPbr1Gt9urGAmjgztXZ23
         zit7NYSyz9oTZlXM8GuEL3dY8zsLkiu38kVqHueYUt/P5UlZX7Bt8XvjHvxPsp7RNrTt
         CfrH9C3aLPgSVtBduWZWzbp/GdKeh8ml+xbfnC+FsPM38ef+QX0Liasq5jjSE3W50NCt
         5ahA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lr4Cz9thkO5BeHlwWTqxwoeU7qvgDXar1hvGAFKb8x0=;
        b=fLfH0dpCHlWL3E38TiuqzJvA7lHJnR9vi1RumZ9IBTZcrCA2T2+apevOArowQlReXm
         YKud7yeJdJcGhlnlsMvmeSetAla5ulp9vqqLjE0hzicwLmJBWKJVSQaaAUZqVMV2YM/o
         lI6B8JU4AQ1KCkXKU7BcVqWkL16t43yJjqW/LFKcc0mgeAYFycflLHu923Fc5tHo7hsV
         BBrS8kurs1gFEDZ7XfpdYBMMTey5uuO6Y+uK0er/2G6uxR8EQc7dyu987uvlui3PNtsV
         aZFVVu24X72wh7aWPDlAr8oVSOwfRBsdn88PqsBoc3T33MapkHm7CwelZvajJyj3o2pc
         WZ+g==
X-Gm-Message-State: AOAM530z6sO1WQ91h/OBJ+36b6xtX0nkfejI96o2iPBcM+T80spbAki5
        xuiNDDENX6o6aP2biARHuDQYQEOXatSa
X-Google-Smtp-Source: ABdhPJzcrnwWYIb5L4wAFweAqmKGmbtjNFN3kwGCHOSAwypQDL8S2TPj/LKr+WG5y/YdWH5kSngw1g==
X-Received: by 2002:a17:90a:d796:: with SMTP id z22mr13418546pju.2.1604923195399;
        Mon, 09 Nov 2020 03:59:55 -0800 (PST)
Received: from work ([103.59.133.81])
        by smtp.gmail.com with ESMTPSA id z3sm10024582pgl.73.2020.11.09.03.59.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 09 Nov 2020 03:59:54 -0800 (PST)
Date:   Mon, 9 Nov 2020 17:29:49 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Bhaumik Bhatt <bbhatt@codeaurora.org>
Cc:     linux-arm-msm@vger.kernel.org, hemantk@codeaurora.org,
        jhugo@codeaurora.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org
Subject: Re: [PATCH] bus: mhi: core: Remove double locking from
 mhi_driver_remove()
Message-ID: <20201109115949.GD24289@work>
References: <1602787671-9497-1-git-send-email-bbhatt@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1602787671-9497-1-git-send-email-bbhatt@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 15, 2020 at 11:47:51AM -0700, Bhaumik Bhatt wrote:
> There is double acquisition of the pm_lock from mhi_driver_remove()
> function. Remove the read_lock_bh/read_unlock_bh calls for pm_lock
> taken during a call to mhi_device_put() as the lock is acquired
> within the function already. This will help avoid a potential
> kernel panic.
> 
> Fixes: 189ff97cca53 ("bus: mhi: core: Add support for data transfer")
> Reported-by: Shuah Khan <skhan@linuxfoundation.org>
> Signed-off-by: Bhaumik Bhatt <bbhatt@codeaurora.org>

Applied to mhi-next!

Thanks,
Mani

> ---
>  drivers/bus/mhi/core/init.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/bus/mhi/core/init.c b/drivers/bus/mhi/core/init.c
> index 0ffdebd..0a09f82 100644
> --- a/drivers/bus/mhi/core/init.c
> +++ b/drivers/bus/mhi/core/init.c
> @@ -1276,10 +1276,8 @@ static int mhi_driver_remove(struct device *dev)
>  		mutex_unlock(&mhi_chan->mutex);
>  	}
>  
> -	read_lock_bh(&mhi_cntrl->pm_lock);
>  	while (mhi_dev->dev_wake)
>  		mhi_device_put(mhi_dev);
> -	read_unlock_bh(&mhi_cntrl->pm_lock);
>  
>  	return 0;
>  }
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
