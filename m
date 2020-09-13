Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4732268128
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Sep 2020 22:30:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725965AbgIMU3Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Sep 2020 16:29:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725940AbgIMU3P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Sep 2020 16:29:15 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 597D0C06174A
        for <linux-kernel@vger.kernel.org>; Sun, 13 Sep 2020 13:29:14 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id c2so16810002ljj.12
        for <linux-kernel@vger.kernel.org>; Sun, 13 Sep 2020 13:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3lHDoU/H9XzG7I14VS2g4WO/mVOjgOVFse/bjqwpgGU=;
        b=GASWo7w8jjpUAVHSAIf21CdzDUKCXRV35W1cajLaalGsAZm1e0IAr9uVt42g+O0v9u
         WbHvgGaZDR7KIeXlnFi2u+n0uzRdSiTfSU/wUdkNAgXQfrLqRJmbFHi6ybdYFkStx6GE
         IfR/gUE7fNOc5/UdiCFrWXypsjIvB/YlPubFAisfu6oRUjK9HywKUIybZJWnQ3wrLOtT
         oABZt1Btme/VOTXjCAHwcMZxKK4j4rCfLo3SItwZYxWZ8EdiNvB13o0r+HrHf8+hQ+8h
         xm2SOSnaF6OnGJIm1jJcVohdBYP1HvpfsVQ3NIwXR3xhIwTqSx3oCFzuLIH/2VD6FHdX
         IK8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3lHDoU/H9XzG7I14VS2g4WO/mVOjgOVFse/bjqwpgGU=;
        b=ReXdO23X5EMR5J5R8/9SACbGfvfdoJquMZUIyz4pL6cgEid+/cvD86o73w+8IpuxGT
         fIMSIfqthzbKyyrNUjuNo0MRT4GxBNQ8TLhtbc3W7GCBK/2bZ19C+DXNwqlkYyCE9pVb
         ndW+rR9dRzak2xgm3y8IVj7Hm+9gXqSwc/kSuA6tgoAfrgyC5wFXTPf6akk+ukwHJDoC
         VpvX2LgNMPBNK59lqeiwK6hshsKuBoARK2q2hNXiNmairiWaKp9k4xmj9rB366GjbWLL
         pU5TWam0ZcQ8tWO41YIZMCSgZgctXMAUDUsAW4loFxZSIA4qoh/zxsNE6Y4epph8hNUw
         hBjw==
X-Gm-Message-State: AOAM5303bjjwrqEXA85sh1noNytyPQOdlWWgPC8NDfTQU9yW2jm/RWf2
        i1O/+YoGeA0jD6IX1D54l0ppSA==
X-Google-Smtp-Source: ABdhPJzMJku7nZ/BR0wpi72U8GQD1Sk0KiUEt2zWwei5XG7UX8s1R1FXtKJRrGeeGndblgi43ED84g==
X-Received: by 2002:a2e:9948:: with SMTP id r8mr3907576ljj.126.1600028951763;
        Sun, 13 Sep 2020 13:29:11 -0700 (PDT)
Received: from jade (h-249-223.A175.priv.bahnhof.se. [98.128.249.223])
        by smtp.gmail.com with ESMTPSA id t15sm3416763ljg.139.2020.09.13.13.29.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2020 13:29:10 -0700 (PDT)
Date:   Sun, 13 Sep 2020 22:29:09 +0200
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     Souptick Joarder <jrdr.linux@gmail.com>
Cc:     op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org,
        John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH] tee/tee_shm.c: Fix error handling path
Message-ID: <20200913202909.GA1018725@jade>
References: <1599972131-31770-1-git-send-email-jrdr.linux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1599972131-31770-1-git-send-email-jrdr.linux@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 13, 2020 at 10:12:11AM +0530, Souptick Joarder wrote:
> When shm->num_pages <= 0, we should avoid calling
> release_registered_pages() in error handling path.
What are we fixing?

> 
> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> Cc: John Hubbard <jhubbard@nvidia.com>
> ---
>  drivers/tee/tee_shm.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
> index 00472f5..e517d9f 100644
> --- a/drivers/tee/tee_shm.c
> +++ b/drivers/tee/tee_shm.c
> @@ -260,8 +260,7 @@ struct tee_shm *tee_shm_register(struct tee_context *ctx, unsigned long addr,
>  		rc = get_kernel_pages(kiov, num_pages, 0, shm->pages);
>  		kfree(kiov);
>  	}
> -	if (rc > 0)
> -		shm->num_pages = rc;
> +	shm->num_pages = rc;
Why not avoiding assigning invalid values to shm->num_pages?
By the way, shm->num_pages is a size_t.

>  	if (rc != num_pages) {
>  		if (rc >= 0)
>  			rc = -ENOMEM;
> @@ -309,7 +308,9 @@ struct tee_shm *tee_shm_register(struct tee_context *ctx, unsigned long addr,
>  			idr_remove(&teedev->idr, shm->id);
>  			mutex_unlock(&teedev->mutex);
>  		}
> -		release_registered_pages(shm);
> +		if (shm->pages && (shm->num_pages > 0))
> +			release_registered_pages(shm);
> +
With this we'll leak if shm->pages has been assigned something.

>  	}
>  	kfree(shm);
>  	teedev_ctx_put(ctx);
> -- 
> 1.9.1
> 

Thanks,
Jens
