Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DFED2CACA6
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 20:47:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730253AbgLATpY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 14:45:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726213AbgLATpY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 14:45:24 -0500
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CB53C0613CF
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 11:44:38 -0800 (PST)
Received: by mail-pj1-x1042.google.com with SMTP id iq13so1893366pjb.3
        for <linux-kernel@vger.kernel.org>; Tue, 01 Dec 2020 11:44:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dqwysqi+9L95tpvuywV7A+6LVGaFVl3uZg4PTg8+oII=;
        b=oHAUvQIvp66wQnurdoykxpwJlhjofxb6D1B+JyNpjYUbE+MluAL9E6e8wiKG7ozKPj
         xaGmhP6RSCFXb/7XG7/tZv9gKEOU22c/xk9mBs0/wrFrJk9pU5bSuxR0gutAdT6WLeGF
         uHaTOcPvsT3Nc7mgD7szTcMhbQJRjQkE0dD0M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dqwysqi+9L95tpvuywV7A+6LVGaFVl3uZg4PTg8+oII=;
        b=GX53eCzinuZwNEKXGrqdaBEylVIQfiXkZT4lwo99Xy2LbV2ht+f41tj5Bx0Q3lPxdt
         cpcJvPlQ/uqLXrUd/8uerEUId1z9GXQjU17CkNGdZGsKkiZg0taqmjku7AbzWUQd+SZJ
         zXQ+iD9hJrAoocpn9TDA+NqqK9J/HIcf7tO/gUt2zJxPSm+YeyUM4NS7DXJ078P0tadk
         MWDlZbfZ1xAeM/64gA4KLxCL7igaqscHio5Mu0WhNriWyOBm+ptHbSodjekR6K+SJC4K
         PFBX5APR8WzzqvuK2HoBwBhuAD4HmrNpKPgjTn/SFDWNZ30T5Eb8PUOs3eGym6aTylhY
         YdFg==
X-Gm-Message-State: AOAM53269r9nopMiBH203CQ1PegEeU8h1MRWJjkmJt2PaCLsYTUHWFs3
        l8Q4BoX22QcMZ6VzS1kVW2oRBA==
X-Google-Smtp-Source: ABdhPJwmvPw0ngX0Er6V5eSIAMUGRQPVjLGQUyVDnXjlc4QzqWCPK9gB1yrpMuqGrJzlgG7vwHGMrA==
X-Received: by 2002:a17:90b:14d3:: with SMTP id jz19mr4427386pjb.196.1606851877744;
        Tue, 01 Dec 2020 11:44:37 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b83sm509273pfb.220.2020.12.01.11.44.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Dec 2020 11:44:36 -0800 (PST)
Date:   Tue, 1 Dec 2020 11:44:35 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        WeiXiong Liao <liaoweixiong@allwinnertech.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/9] pstore/blk: remove struct pstore_device_info
Message-ID: <202012011143.43273D716@keescook>
References: <20201016132047.3068029-1-hch@lst.de>
 <20201016132047.3068029-8-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201016132047.3068029-8-hch@lst.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 16, 2020 at 03:20:45PM +0200, Christoph Hellwig wrote:
> The total_size and flags are only needed at registrations time, so just
> pass them to register_pstore_device directly.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Full NAK on this -- pstore was mess of function argument passing, and I
vowed to pass everything in structures after I finally cleaned all of
that up. I don't want anything that looks like this getting back into
the pstore code.

-Kees

> ---
>  drivers/mtd/mtdpstore.c    | 10 ++--
>  fs/pstore/blk.c            | 98 ++++++++++++++++----------------------
>  include/linux/pstore_blk.h | 21 ++------
>  3 files changed, 47 insertions(+), 82 deletions(-)
> 
> diff --git a/drivers/mtd/mtdpstore.c b/drivers/mtd/mtdpstore.c
> index 232ba5c39c2a55..88d0305ca27336 100644
> --- a/drivers/mtd/mtdpstore.c
> +++ b/drivers/mtd/mtdpstore.c
> @@ -12,7 +12,6 @@
>  static struct mtdpstore_context {
>  	int index;
>  	struct pstore_blk_config info;
> -	struct pstore_device_info dev;
>  	struct mtd_info *mtd;
>  	unsigned long *rmmap;		/* removed bit map */
>  	unsigned long *usedmap;		/* used bit map */
> @@ -431,12 +430,9 @@ static void mtdpstore_notify_add(struct mtd_info *mtd)
>  	longcnt = BITS_TO_LONGS(div_u64(mtd->size, mtd->erasesize));
>  	cxt->badmap = kcalloc(longcnt, sizeof(long), GFP_KERNEL);
>  
> -	cxt->dev.total_size = mtd->size;
>  	/* just support dmesg right now */
> -	cxt->dev.flags = PSTORE_FLAGS_DMESG;
> -	cxt->dev.ops = &mtdpstore_ops;
> -
> -	ret = register_pstore_device(&cxt->dev);
> +	ret = register_pstore_device(&mtdpstore_ops, mtd->size,
> +				     PSTORE_FLAGS_DMESG);
>  	if (ret) {
>  		dev_err(&mtd->dev, "mtd%d register to psblk failed\n",
>  				mtd->index);
> @@ -531,7 +527,7 @@ static void mtdpstore_notify_remove(struct mtd_info *mtd)
>  
>  	mtdpstore_flush_removed(cxt);
>  
> -	unregister_pstore_device(&cxt->dev);
> +	unregister_pstore_device(&mtdpstore_ops);
>  	kfree(cxt->badmap);
>  	kfree(cxt->usedmap);
>  	kfree(cxt->rmmap);
> diff --git a/fs/pstore/blk.c b/fs/pstore/blk.c
> index f7c7f325e42c71..0430b190a1df2a 100644
> --- a/fs/pstore/blk.c
> +++ b/fs/pstore/blk.c
> @@ -102,27 +102,40 @@ static struct pstore_zone_info *pstore_zone_info;
>  	_##name_;						\
>  })
>  
> -static int __register_pstore_device(struct pstore_device_info *dev)
> +/**
> + * register_pstore_device() - register device to pstore/blk
> + *
> + * @ops:	operations to access the device.
> + * @total_size: The total size in bytes pstore/blk can use. It must be greater
> + *		than 4096 and be multiple of 4096.
> + * @flags:	Refer to macro starting with PSTORE_FLAGS defined in
> + *		linux/pstore.h. It means what front-ends this device support.
> + *		Zero means all backends for compatible.
> + */
> +int register_pstore_device(const struct pstore_zone_ops *ops,
> +		unsigned long total_size, unsigned int flags)
>  {
>  	int ret;
>  
> -	lockdep_assert_held(&pstore_blk_lock);
> -
> -	if (!dev || !dev->total_size || !dev->ops ||
> -	    !dev->ops->read || !dev->ops->write)
> +	if (!ops || !ops->read || !ops->write || !total_size)
>  		return -EINVAL;
>  
>  	/* someone already registered before */
> -	if (pstore_zone_info)
> -		return -EBUSY;
> +	mutex_lock(&pstore_blk_lock);
> +	if (pstore_zone_info) {
> +		ret = -EBUSY;
> +		goto out_unlock;
> +	}
>  
>  	pstore_zone_info = kzalloc(sizeof(struct pstore_zone_info), GFP_KERNEL);
> -	if (!pstore_zone_info)
> -		return -ENOMEM;
> +	if (!pstore_zone_info) {
> +		ret = -ENOMEM;
> +		goto out_unlock;
> +	}
>  
>  	/* zero means not limit on which backends to attempt to store. */
> -	if (!dev->flags)
> -		dev->flags = UINT_MAX;
> +	if (!flags)
> +		flags = UINT_MAX;
>  
>  #define verify_size(name, alignsize, enabled) {				\
>  		long _##name_;						\
> @@ -134,63 +147,40 @@ static int __register_pstore_device(struct pstore_device_info *dev)
>  		pstore_zone_info->name = _##name_;			\
>  	}
>  
> -	verify_size(kmsg_size, 4096, dev->flags & PSTORE_FLAGS_DMESG);
> -	verify_size(pmsg_size, 4096, dev->flags & PSTORE_FLAGS_PMSG);
> -	verify_size(console_size, 4096, dev->flags & PSTORE_FLAGS_CONSOLE);
> -	verify_size(ftrace_size, 4096, dev->flags & PSTORE_FLAGS_FTRACE);
> +	verify_size(kmsg_size, 4096, flags & PSTORE_FLAGS_DMESG);
> +	verify_size(pmsg_size, 4096, flags & PSTORE_FLAGS_PMSG);
> +	verify_size(console_size, 4096, flags & PSTORE_FLAGS_CONSOLE);
> +	verify_size(ftrace_size, 4096, flags & PSTORE_FLAGS_FTRACE);
>  #undef verify_size
>  
> -	pstore_zone_info->total_size = dev->total_size;
> +	pstore_zone_info->total_size = total_size;
>  	pstore_zone_info->max_reason = max_reason;
> -	pstore_zone_info->ops = dev->ops;
> +	pstore_zone_info->ops = ops;
>  
>  	ret = register_pstore_zone(pstore_zone_info);
>  	if (ret) {
>  		kfree(pstore_zone_info);
>  		pstore_zone_info = NULL;
>  	}
> +out_unlock:
> +	mutex_unlock(&pstore_blk_lock);
>  	return ret;
>  }
> +EXPORT_SYMBOL_GPL(register_pstore_device);
> +
>  /**
> - * register_pstore_device() - register non-block device to pstore/blk
> - *
> - * @dev: non-block device information
> + * unregister_pstore_device() - unregister a device from pstore/blk
>   *
> - * Return:
> - * * 0		- OK
> - * * Others	- something error.
> + * @ops: device operations
>   */
> -int register_pstore_device(struct pstore_device_info *dev)
> +void unregister_pstore_device(const struct pstore_zone_ops *ops)
>  {
> -	int ret;
> -
>  	mutex_lock(&pstore_blk_lock);
> -	ret = __register_pstore_device(dev);
> -	mutex_unlock(&pstore_blk_lock);
> -
> -	return ret;
> -}
> -EXPORT_SYMBOL_GPL(register_pstore_device);
> -
> -static void __unregister_pstore_device(struct pstore_device_info *dev)
> -{
> -	lockdep_assert_held(&pstore_blk_lock);
> -	if (pstore_zone_info && pstore_zone_info->ops == dev->ops) {
> +	if (pstore_zone_info && pstore_zone_info->ops == ops) {
>  		unregister_pstore_zone(pstore_zone_info);
>  		kfree(pstore_zone_info);
>  		pstore_zone_info = NULL;
>  	}
> -}
> -
> -/**
> - * unregister_pstore_device() - unregister non-block device from pstore/blk
> - *
> - * @dev: non-block device information
> - */
> -void unregister_pstore_device(struct pstore_device_info *dev)
> -{
> -	mutex_lock(&pstore_blk_lock);
> -	__unregister_pstore_device(dev);
>  	mutex_unlock(&pstore_blk_lock);
>  }
>  EXPORT_SYMBOL_GPL(unregister_pstore_device);
> @@ -271,7 +261,6 @@ static int __init pstore_blk_init(void)
>  {
>  	char bdev_name[BDEVNAME_SIZE];
>  	struct block_device *bdev;
> -	struct pstore_device_info dev;
>  	int ret = -ENODEV;
>  	fmode_t mode = FMODE_READ | FMODE_WRITE | FMODE_EXCL;
>  	sector_t nr_sects;
> @@ -306,11 +295,8 @@ static int __init pstore_blk_init(void)
>  	/* psblk_bdev must be assigned before register to pstore/blk */
>  	psblk_bdev = bdev;
>  
> -	memset(&dev, 0, sizeof(dev));
> -	dev.ops = &pstore_blk_zone_ops;
> -	dev.total_size = nr_sects << SECTOR_SHIFT;
> -
> -	ret = register_pstore_device(&dev);
> +	ret = register_pstore_device(&pstore_blk_zone_ops,
> +			nr_sects << SECTOR_SHIFT, 0);
>  	if (ret)
>  		goto err_put_bdev;
>  
> @@ -327,11 +313,9 @@ late_initcall(pstore_blk_init);
>  
>  static void __exit pstore_blk_exit(void)
>  {
> -	struct pstore_device_info dev = { .ops = &pstore_blk_zone_ops };
> -
>  	if (!psblk_bdev)
>  		return;
> -	unregister_pstore_device(&dev);
> +	unregister_pstore_device(&pstore_blk_zone_ops);
>  	blkdev_put(psblk_bdev, FMODE_READ | FMODE_WRITE | FMODE_EXCL);
>  }
>  module_exit(pstore_blk_exit);
> diff --git a/include/linux/pstore_blk.h b/include/linux/pstore_blk.h
> index 095a44ce5e122c..0abd412a6cb3e3 100644
> --- a/include/linux/pstore_blk.h
> +++ b/include/linux/pstore_blk.h
> @@ -7,24 +7,9 @@
>  #include <linux/pstore.h>
>  #include <linux/pstore_zone.h>
>  
> -/**
> - * struct pstore_device_info - back-end pstore/blk driver structure.
> - *
> - * @total_size: The total size in bytes pstore/blk can use. It must be greater
> - *		than 4096 and be multiple of 4096.
> - * @flags:	Refer to macro starting with PSTORE_FLAGS defined in
> - *		linux/pstore.h. It means what front-ends this device support.
> - *		Zero means all backends for compatible.
> - * @ops:	operations to access the device.
> - */
> -struct pstore_device_info {
> -	unsigned long total_size;
> -	unsigned int flags;
> -	const struct pstore_zone_ops *ops;
> -};
> -
> -int  register_pstore_device(struct pstore_device_info *dev);
> -void unregister_pstore_device(struct pstore_device_info *dev);
> +int register_pstore_device(const struct pstore_zone_ops *ops,
> +		unsigned long total_size, unsigned int flags);
> +void unregister_pstore_device(const struct pstore_zone_ops *ops);
>  
>  /**
>   * struct pstore_blk_config - the pstore_blk backend configuration
> -- 
> 2.28.0
> 

-- 
Kees Cook
