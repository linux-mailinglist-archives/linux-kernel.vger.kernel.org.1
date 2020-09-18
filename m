Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1142F26F88B
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 10:41:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbgIRIlF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 04:41:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726511AbgIRIlE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 04:41:04 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49EBFC06174A
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 01:41:04 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id n25so4415123ljj.4
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 01:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=02PV3oHiwrDr+3qeV9iVgUcXInPW363IN1EVnL1zAwE=;
        b=hoeQRPyhmK9FHzNzhrxuSWjlaSbbSEY3KdFZTBj5IGlYToCPzbPPDpiXKRklfU//jL
         SPq0HfaC1arMvb9YXZv6VbjPu+AftzcDRc3mkRd6732lkGXyYp0WeCdQc4ROGLdUIGhE
         dbvWmrHNn+XWprwmZ7I6UdxiFkvoeEe72XStLWDGLBeVenmmJwVYtbUKwUHI+4yVKDZf
         Dy+7cLExhHFWpyHbFCfFiYJtKc3/Yq9ElGM/8/4MjgTF5Xo0BTQz6Lfb1HN8C1TgCIUj
         29nHFM8Zpkd/SivL56eKF86P1iDTNlkgzfGmtvl395VhB0vUIdM0GeQqIIij4XaDMwqz
         JLiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=02PV3oHiwrDr+3qeV9iVgUcXInPW363IN1EVnL1zAwE=;
        b=K8vMi7m9I5XPckY5jsvgQRS/idFB4/KToal9e5k9HxDiQ+aF0HE3nQru8PElBess9u
         s8S4Rtrcdx4Hoq+u3gw3ng/eS6akecJLXvB9uOmYiWqvR6lCYOq5TizEYABtsvsVH/+J
         1Yook/mGY+H7o5p/g4BSb+M7wbgqL9/KULK3AhUKg/r86mE3Vrm0BiDwJeGTsGceDPCD
         1sJ0abCnJep7lssvDJw0Rhh0KBag47716g7IS6yO/CWIBQ5x50hMH54jHGGifV5gc1Vj
         hzuCArb30PyXN7MeQx2BLTqbdNErg60b5jQhrDm8RTLMvDklT3xPjc8s+WBBpnDrZLTA
         5kCA==
X-Gm-Message-State: AOAM532kmgswJ4gMVDeKvmKma66dkeaXWe0lxrx0ZeuDwXYd6k2Mqbf+
        1QM2pZyfG2SUvYsLCtMZC1uEsUbZ+W3l6Q==
X-Google-Smtp-Source: ABdhPJyMKL0v2VCgjZwfKbqACGWyl/aATGhPTcPD0hYYfZ6MTj1aw5qE0eF0BSUdHN9ipp2unAMgjA==
X-Received: by 2002:a2e:b52c:: with SMTP id z12mr10238941ljm.437.1600418462619;
        Fri, 18 Sep 2020 01:41:02 -0700 (PDT)
Received: from jade (h-249-223.A175.priv.bahnhof.se. [98.128.249.223])
        by smtp.gmail.com with ESMTPSA id f22sm455228lfc.240.2020.09.18.01.41.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2020 01:41:02 -0700 (PDT)
Date:   Fri, 18 Sep 2020 10:41:00 +0200
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH 1/2] tee: replace cdev_add + device_add with
 cdev_device_add
Message-ID: <20200918084100.GA1219771@jade>
References: <20200901103335.685-1-sudeep.holla@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200901103335.685-1-sudeep.holla@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 01, 2020 at 11:33:34AM +0100, Sudeep Holla wrote:
> Commit 233ed09d7fda ("chardev: add helper function to register char devs
> with a struct device") added a helper function 'cdev_device_add'.
> 
> Make use of cdev_device_add in tee_device_register to replace cdev_add
> and device_add. Since cdev_device_add takes care of setting the
> kobj->parent, drop explicit initialisation in tee_device_alloc.
> 
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  drivers/tee/tee_core.c | 21 ++++-----------------
>  1 file changed, 4 insertions(+), 17 deletions(-)

Thanks for the nice cleanups. I'm picking up this patch and
"[PATCH 2/2] tee: avoid explicit sysfs_create/delete_group by
initialising dev->groups".

Cheers,
Jens

> 
> diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
> index 64637e09a095..b4a8b362d78f 100644
> --- a/drivers/tee/tee_core.c
> +++ b/drivers/tee/tee_core.c
> @@ -917,7 +917,6 @@ struct tee_device *tee_device_alloc(const struct tee_desc *teedesc,
>  
>  	cdev_init(&teedev->cdev, &tee_fops);
>  	teedev->cdev.owner = teedesc->owner;
> -	teedev->cdev.kobj.parent = &teedev->dev.kobj;
>  
>  	dev_set_drvdata(&teedev->dev, driver_data);
>  	device_initialize(&teedev->dev);
> @@ -985,24 +984,15 @@ int tee_device_register(struct tee_device *teedev)
>  		return -EINVAL;
>  	}
>  
> -	rc = cdev_add(&teedev->cdev, teedev->dev.devt, 1);
> +	rc = cdev_device_add(&teedev->cdev, &teedev->dev);
>  	if (rc) {
>  		dev_err(&teedev->dev,
> -			"unable to cdev_add() %s, major %d, minor %d, err=%d\n",
> +			"unable to cdev_device_add() %s, major %d, minor %d, err=%d\n",
>  			teedev->name, MAJOR(teedev->dev.devt),
>  			MINOR(teedev->dev.devt), rc);
>  		return rc;
>  	}
>  
> -	rc = device_add(&teedev->dev);
> -	if (rc) {
> -		dev_err(&teedev->dev,
> -			"unable to device_add() %s, major %d, minor %d, err=%d\n",
> -			teedev->name, MAJOR(teedev->dev.devt),
> -			MINOR(teedev->dev.devt), rc);
> -		goto err_device_add;
> -	}
> -
>  	rc = sysfs_create_group(&teedev->dev.kobj, &tee_dev_group);
>  	if (rc) {
>  		dev_err(&teedev->dev,
> @@ -1014,9 +1004,7 @@ int tee_device_register(struct tee_device *teedev)
>  	return 0;
>  
>  err_sysfs_create_group:
> -	device_del(&teedev->dev);
> -err_device_add:
> -	cdev_del(&teedev->cdev);
> +	cdev_device_del(&teedev->cdev, &teedev->dev);
>  	return rc;
>  }
>  EXPORT_SYMBOL_GPL(tee_device_register);
> @@ -1062,8 +1050,7 @@ void tee_device_unregister(struct tee_device *teedev)
>  
>  	if (teedev->flags & TEE_DEVICE_FLAG_REGISTERED) {
>  		sysfs_remove_group(&teedev->dev.kobj, &tee_dev_group);
> -		cdev_del(&teedev->cdev);
> -		device_del(&teedev->dev);
> +		cdev_device_del(&teedev->cdev, &teedev->dev);
>  	}
>  
>  	tee_device_put(teedev);
> -- 
> 2.17.1
> 
