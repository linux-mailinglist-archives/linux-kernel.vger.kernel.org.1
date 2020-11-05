Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AC062A806B
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 15:10:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730786AbgKEOKz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 09:10:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726067AbgKEOKz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 09:10:55 -0500
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1279C0613CF
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 06:10:53 -0800 (PST)
Received: by mail-pj1-x1041.google.com with SMTP id ie6so136082pjb.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 06:10:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=baAXtX5vqppA7qCUlQzYOK8z1Lg9bB1n7PCPJI2CjKg=;
        b=lyXX8ctS++5eZuxGljanX3e9s9d/koA/7pgJzBKy52Qb7A3S8W/gJhM4R6STGCY8dx
         dRUQOCMOMKLp4/3J9ae2YnrF5O0bVM1aOqWoayI+0vcXVTPVJ9LbbF0eXoCF4sjHFoIo
         ADGWXBUtpZYrb0lA6oGU4LiWNn2mzG003ja9WDMD7I+b9btpCDXyYbp1EcBCVH2R6y8t
         gAzekhBCrtWuh1TikNd5gsAzA+4jIVEDCYqUf1xF27gu4OxdrHTXEj+qwkIR7wq0TyAr
         A5nL/mpC9TNWZob2p7rLRrWuR7YkOAa63WS8kNjCq6+7ZNhBFb0BaWQehy7Qtf5s/GQ9
         uBeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=baAXtX5vqppA7qCUlQzYOK8z1Lg9bB1n7PCPJI2CjKg=;
        b=VlZ4l1/2RSX5K+/BBhXcSvw6bWKKLjEuYgZwlGvMun8nY4TcKFJmVKUjJGI+Gutihk
         s6lYfrHBYHHYotLUHryGQxknzztqGpo6/no/BATDeWMvcEK2YAMiD+3hSlLTIDiB7occ
         AdbKvxH3dtDKpK2p8/cgUnYpLKw+wFhsN/7eaB7xFjMi3Xg1fGSZA7CDYzg4DAErFWEN
         nigVb9cdOsr4yJUJ3oKlwDHupCGi9ElgnNnOC1ykkwzV9N3Pkg2mGVeYVkgo0GWIDbk5
         7kXy88xen5uV4QYwPwOS0c/JY3sDgd+FzWMgQ3kHcJzvySenO4rqKjmPvV8QMHs3feK5
         yhpw==
X-Gm-Message-State: AOAM532OmfSsJPYu4vJ03+M3lESw52VWNn3jdJIY0qs5+3xUDSBc3ZS6
        ukxt9byn5UQFVdyUFZZy0viBhXNiscyb
X-Google-Smtp-Source: ABdhPJxY90qX/PDJ4vyDUVtIy+pe3/OhOGE/qfVtkL+YerRwUQNK0AU84qpsEQB5hYPTgqVC9zTk5g==
X-Received: by 2002:a17:902:8b89:b029:d6:df6e:54df with SMTP id ay9-20020a1709028b89b02900d6df6e54dfmr2642265plb.0.1604585453155;
        Thu, 05 Nov 2020 06:10:53 -0800 (PST)
Received: from work ([103.59.133.81])
        by smtp.gmail.com with ESMTPSA id g14sm3037619pfk.90.2020.11.05.06.10.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 05 Nov 2020 06:10:52 -0800 (PST)
Date:   Thu, 5 Nov 2020 19:40:46 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Bhaumik Bhatt <bbhatt@codeaurora.org>
Cc:     linux-arm-msm@vger.kernel.org, hemantk@codeaurora.org,
        jhugo@codeaurora.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org
Subject: Re: [PATCH] bus: mhi: core: Remove double locking from
 mhi_driver_remove()
Message-ID: <20201105141046.GC7308@work>
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

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

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
