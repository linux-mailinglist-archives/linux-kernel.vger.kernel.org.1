Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 893511B3ADA
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Apr 2020 11:10:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726692AbgDVJJf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Apr 2020 05:09:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:60828 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726082AbgDVJJe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 05:09:34 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id AED0BAD5C;
        Wed, 22 Apr 2020 09:09:31 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id EEECD1E125C; Wed, 22 Apr 2020 11:09:31 +0200 (CEST)
Date:   Wed, 22 Apr 2020 11:09:31 +0200
From:   Jan Kara <jack@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     axboe@kernel.dk, yuyufen@huawei.com, tj@kernel.org, jack@suse.cz,
        bvanassche@acm.org, tytso@mit.edu, hdegoede@redhat.com,
        gregkh@linuxfoundation.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/9] driver core: remove device_create_vargs
Message-ID: <20200422090931.GF8775@quack2.suse.cz>
References: <20200422073851.303714-1-hch@lst.de>
 <20200422073851.303714-6-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200422073851.303714-6-hch@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 22-04-20 09:38:47, Christoph Hellwig wrote:
> All external users of device_create_vargs are gone, so remove it and
> open code it in the only caller.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Looks good to me. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  drivers/base/core.c    | 37 ++-----------------------------------
>  include/linux/device.h |  4 ----
>  2 files changed, 2 insertions(+), 39 deletions(-)
> 
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index 139cdf7e7327..fb8ae248e5aa 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -3188,40 +3188,6 @@ device_create_groups_vargs(struct class *class, struct device *parent,
>  	return ERR_PTR(retval);
>  }
>  
> -/**
> - * device_create_vargs - creates a device and registers it with sysfs
> - * @class: pointer to the struct class that this device should be registered to
> - * @parent: pointer to the parent struct device of this new device, if any
> - * @devt: the dev_t for the char device to be added
> - * @drvdata: the data to be added to the device for callbacks
> - * @fmt: string for the device's name
> - * @args: va_list for the device's name
> - *
> - * This function can be used by char device classes.  A struct device
> - * will be created in sysfs, registered to the specified class.
> - *
> - * A "dev" file will be created, showing the dev_t for the device, if
> - * the dev_t is not 0,0.
> - * If a pointer to a parent struct device is passed in, the newly created
> - * struct device will be a child of that device in sysfs.
> - * The pointer to the struct device will be returned from the call.
> - * Any further sysfs files that might be required can be created using this
> - * pointer.
> - *
> - * Returns &struct device pointer on success, or ERR_PTR() on error.
> - *
> - * Note: the struct class passed to this function must have previously
> - * been created with a call to class_create().
> - */
> -struct device *device_create_vargs(struct class *class, struct device *parent,
> -				   dev_t devt, void *drvdata, const char *fmt,
> -				   va_list args)
> -{
> -	return device_create_groups_vargs(class, parent, devt, drvdata, NULL,
> -					  fmt, args);
> -}
> -EXPORT_SYMBOL_GPL(device_create_vargs);
> -
>  /**
>   * device_create - creates a device and registers it with sysfs
>   * @class: pointer to the struct class that this device should be registered to
> @@ -3253,7 +3219,8 @@ struct device *device_create(struct class *class, struct device *parent,
>  	struct device *dev;
>  
>  	va_start(vargs, fmt);
> -	dev = device_create_vargs(class, parent, devt, drvdata, fmt, vargs);
> +	dev = device_create_groups_vargs(class, parent, devt, drvdata, NULL,
> +					  fmt, vargs);
>  	va_end(vargs);
>  	return dev;
>  }
> diff --git a/include/linux/device.h b/include/linux/device.h
> index ac8e37cd716a..15460a5ac024 100644
> --- a/include/linux/device.h
> +++ b/include/linux/device.h
> @@ -884,10 +884,6 @@ extern bool device_is_bound(struct device *dev);
>  /*
>   * Easy functions for dynamically creating devices on the fly
>   */
> -extern __printf(5, 0)
> -struct device *device_create_vargs(struct class *cls, struct device *parent,
> -				   dev_t devt, void *drvdata,
> -				   const char *fmt, va_list vargs);
>  extern __printf(5, 6)
>  struct device *device_create(struct class *cls, struct device *parent,
>  			     dev_t devt, void *drvdata,
> -- 
> 2.26.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
