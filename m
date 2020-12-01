Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A2472CAC97
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 20:42:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404327AbgLATlR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 14:41:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404304AbgLATlQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 14:41:16 -0500
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED04EC0613CF
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 11:40:30 -0800 (PST)
Received: by mail-pj1-x1044.google.com with SMTP id hk16so1929359pjb.4
        for <linux-kernel@vger.kernel.org>; Tue, 01 Dec 2020 11:40:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2BDD6CsjIvFrZbWANWLZeGCBU13Uq75odWBuX37T8kI=;
        b=mRkRJ6Q6HwpjyKxMoRiMtZ3pS1uUIT/G5xuUFez4in34vsXCSysO+PdErJrlP8z1+j
         rc5b8IAhbMC47zb1/v1a3L58migC78Yyjgc6TcuRnNA87TYGqSrDL37o8HDEGbROp0Jv
         RfABQEm1ynHSXwGgA7egTZEn4UR3Uwsi1ty28=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2BDD6CsjIvFrZbWANWLZeGCBU13Uq75odWBuX37T8kI=;
        b=N84Weqtm95GnET4gBaO2yHViK6ygpcrX048dfSM8p3surOItu614rqG2QgMwBwOTmg
         KpI6X41vjQGBqVq6ppLRJZlc3b9mbzRgVEJrB07Mv0dodEXYrf+NV9GFMzj3Tw6+4IV2
         UAFmlqLtT3xgb1CZQUVoN6YuIK1iStYtajSn8DIIZMorBpGq+LiqjEDAAh7telIkTiLf
         G+Rmd9p2ZulvJTyZ4clLcmNqERTWyVTIDCfGC+vCyaxsGjjak5/KfC3L1UKswoY+q/wk
         5CjdJmUZSY6lUbXXy4I2EctZgCii8dzQSH7WqjKR1PTV2nnoYyqZ9YqfKGEtHJs9PXGg
         c9gQ==
X-Gm-Message-State: AOAM533rAmc/uCYKd5BNcK7t0TIVK0q5XrS3n3ke1EBDyWg/Q39IgBJX
        t86W4LZyq3xRSDVQONQOj9N7Zw==
X-Google-Smtp-Source: ABdhPJxFQ+7SgypoxZ0m2CK5lpx5CBEA02jrkBDab7sOkAx2BY39vgwXHvfYN+IY2m6uUQIbUcXppQ==
X-Received: by 2002:a17:902:eb54:b029:da:29d7:cffd with SMTP id i20-20020a170902eb54b02900da29d7cffdmr4400902pli.28.1606851630463;
        Tue, 01 Dec 2020 11:40:30 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id m4sm517209pfd.203.2020.12.01.11.40.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Dec 2020 11:40:29 -0800 (PST)
Date:   Tue, 1 Dec 2020 11:40:28 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        WeiXiong Liao <liaoweixiong@allwinnertech.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/9] pstore/blk: simplify the block device open / close
 path
Message-ID: <202012011138.5766F520D9@keescook>
References: <20201016132047.3068029-1-hch@lst.de>
 <20201016132047.3068029-6-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201016132047.3068029-6-hch@lst.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 16, 2020 at 03:20:43PM +0200, Christoph Hellwig wrote:
> Remove the pointless psblk_get_bdev and psblk_put_bdev helper,
> and don't bother holding pstore_blk_lock over the block device
> open / close interactions given that they only happen first thing
> during module init and last thing during module exit.  Also don't
> bother with unregistering a zone info that did not come from the
> actually block backed code, as users like mtd have to unregister
> it themselves already.

I don't like this because it's changing too many things at once. Of the
stuff I don't want is:

- removal of checking for already-active zoneinfo (there can be only one)
- collapsing register_blk into _init (it seems clearer to me to keep
  them separate)

-Kees

> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/pstore/blk.c | 156 ++++++++++++------------------------------------
>  1 file changed, 38 insertions(+), 118 deletions(-)
> 
> diff --git a/fs/pstore/blk.c b/fs/pstore/blk.c
> index 3a2214ecf942ae..a8aa56cba96d59 100644
> --- a/fs/pstore/blk.c
> +++ b/fs/pstore/blk.c
> @@ -91,12 +91,6 @@ static DEFINE_MUTEX(pstore_blk_lock);
>  static struct block_device *psblk_bdev;
>  static struct pstore_zone_info *pstore_zone_info;
>  
> -struct bdev_info {
> -	dev_t devt;
> -	sector_t nr_sects;
> -	sector_t start_sect;
> -};
> -
>  #define check_size(name, alignsize) ({				\
>  	long _##name_ = (name);					\
>  	_##name_ = _##name_ <= 0 ? 0 : (_##name_ * 1024);	\
> @@ -205,75 +199,6 @@ void unregister_pstore_device(struct pstore_device_info *dev)
>  }
>  EXPORT_SYMBOL_GPL(unregister_pstore_device);
>  
> -/**
> - * psblk_get_bdev() - open block device
> - *
> - * @holder:	Exclusive holder identifier
> - * @info:	Information about bdev to fill in
> - *
> - * Return: pointer to block device on success and others on error.
> - *
> - * On success, the returned block_device has reference count of one.
> - */
> -static struct block_device *psblk_get_bdev(void *holder,
> -					   struct bdev_info *info)
> -{
> -	struct block_device *bdev = ERR_PTR(-ENODEV);
> -	fmode_t mode = FMODE_READ | FMODE_WRITE;
> -	sector_t nr_sects;
> -
> -	lockdep_assert_held(&pstore_blk_lock);
> -
> -	if (pstore_zone_info)
> -		return ERR_PTR(-EBUSY);
> -
> -	if (!blkdev[0])
> -		return ERR_PTR(-ENODEV);
> -
> -	if (holder)
> -		mode |= FMODE_EXCL;
> -	bdev = blkdev_get_by_path(blkdev, mode, holder);
> -	if (IS_ERR(bdev)) {
> -		dev_t devt;
> -
> -		devt = name_to_dev_t(blkdev);
> -		if (devt == 0)
> -			return ERR_PTR(-ENODEV);
> -		bdev = blkdev_get_by_dev(devt, mode, holder);
> -		if (IS_ERR(bdev))
> -			return bdev;
> -	}
> -
> -	nr_sects = part_nr_sects_read(bdev->bd_part);
> -	if (!nr_sects) {
> -		pr_err("not enough space for '%s'\n", blkdev);
> -		blkdev_put(bdev, mode);
> -		return ERR_PTR(-ENOSPC);
> -	}
> -
> -	if (info) {
> -		info->devt = bdev->bd_dev;
> -		info->nr_sects = nr_sects;
> -		info->start_sect = get_start_sect(bdev);
> -	}
> -
> -	return bdev;
> -}
> -
> -static void psblk_put_bdev(struct block_device *bdev, void *holder)
> -{
> -	fmode_t mode = FMODE_READ | FMODE_WRITE;
> -
> -	lockdep_assert_held(&pstore_blk_lock);
> -
> -	if (!bdev)
> -		return;
> -
> -	if (holder)
> -		mode |= FMODE_EXCL;
> -	blkdev_put(bdev, mode);
> -}
> -
>  static ssize_t psblk_generic_blk_read(char *buf, size_t bytes, loff_t pos)
>  {
>  	struct block_device *bdev = psblk_bdev;
> @@ -340,29 +265,39 @@ static ssize_t psblk_generic_blk_write(const char *buf, size_t bytes,
>  	return ret;
>  }
>  
> -static int __register_pstore_blk(void)
> +static int __init pstore_blk_init(void)
>  {
>  	char bdev_name[BDEVNAME_SIZE];
>  	struct block_device *bdev;
>  	struct pstore_device_info dev;
> -	struct bdev_info binfo;
> -	void *holder = blkdev;
>  	int ret = -ENODEV;
> -
> -	lockdep_assert_held(&pstore_blk_lock);
> +	fmode_t mode = FMODE_READ | FMODE_WRITE | FMODE_EXCL;
> +	sector_t nr_sects;
> +	
> +	if (!best_effort || !blkdev[0])
> +		return 0;
>  
>  	/* hold bdev exclusively */
> -	memset(&binfo, 0, sizeof(binfo));
> -	bdev = psblk_get_bdev(holder, &binfo);
> +	bdev = blkdev_get_by_path(blkdev, mode, blkdev);
>  	if (IS_ERR(bdev)) {
> -		pr_err("failed to open '%s'!\n", blkdev);
> -		return PTR_ERR(bdev);
> +		dev_t devt;
> +
> +		devt = name_to_dev_t(blkdev);
> +		if (devt == 0) {
> +			pr_err("failed to open '%s'!\n", blkdev);
> +			return -ENODEV;
> +		}
> +		bdev = blkdev_get_by_dev(devt, mode, blkdev);
> +		if (IS_ERR(bdev)) {
> +			pr_err("failed to open '%s'!\n", blkdev);
> +			return PTR_ERR(bdev);
> +		}
>  	}
>  
> -	/* only allow driver matching the @blkdev */
> -	if (!binfo.devt) {
> -		pr_debug("no major\n");
> -		ret = -ENODEV;
> +	nr_sects = part_nr_sects_read(bdev->bd_part);
> +	if (!nr_sects) {
> +		pr_err("not enough space for '%s'\n", blkdev);
> +		ret = -ENOSPC;
>  		goto err_put_bdev;
>  	}
>  
> @@ -370,11 +305,11 @@ static int __register_pstore_blk(void)
>  	psblk_bdev = bdev;
>  
>  	memset(&dev, 0, sizeof(dev));
> -	dev.total_size = binfo.nr_sects << SECTOR_SHIFT;
> +	dev.total_size = nr_sects << SECTOR_SHIFT;
>  	dev.read = psblk_generic_blk_read;
>  	dev.write = psblk_generic_blk_write;
>  
> -	ret = __register_pstore_device(&dev);
> +	ret = register_pstore_device(&dev);
>  	if (ret)
>  		goto err_put_bdev;
>  
> @@ -383,10 +318,22 @@ static int __register_pstore_blk(void)
>  	return 0;
>  
>  err_put_bdev:
> +	blkdev_put(bdev, FMODE_READ | FMODE_WRITE | FMODE_EXCL);
>  	psblk_bdev = NULL;
> -	psblk_put_bdev(bdev, holder);
>  	return ret;
>  }
> +late_initcall(pstore_blk_init);
> +
> +static void __exit pstore_blk_exit(void)
> +{
> +	struct pstore_device_info dev = { .read = psblk_generic_blk_read };
> +
> +	if (!psblk_bdev)
> +		return;
> +	unregister_pstore_device(&dev);
> +	blkdev_put(psblk_bdev, FMODE_READ | FMODE_WRITE | FMODE_EXCL);
> +}
> +module_exit(pstore_blk_exit);
>  
>  /* get information of pstore/blk */
>  int pstore_blk_get_config(struct pstore_blk_config *info)
> @@ -402,33 +349,6 @@ int pstore_blk_get_config(struct pstore_blk_config *info)
>  }
>  EXPORT_SYMBOL_GPL(pstore_blk_get_config);
>  
> -static int __init pstore_blk_init(void)
> -{
> -	int ret = 0;
> -
> -	mutex_lock(&pstore_blk_lock);
> -	if (!pstore_zone_info && best_effort && blkdev[0])
> -		ret = __register_pstore_blk();
> -	mutex_unlock(&pstore_blk_lock);
> -
> -	return ret;
> -}
> -late_initcall(pstore_blk_init);
> -
> -static void __exit pstore_blk_exit(void)
> -{
> -	struct pstore_device_info dev = { };
> -
> -	mutex_lock(&pstore_blk_lock);
> -	if (pstore_zone_info)
> -		dev.read = pstore_zone_info->read;
> -	__unregister_pstore_device(&dev);
> -	if (psblk_bdev)
> -		psblk_put_bdev(psblk_bdev, blkdev);
> -	mutex_unlock(&pstore_blk_lock);
> -}
> -module_exit(pstore_blk_exit);
> -
>  MODULE_LICENSE("GPL");
>  MODULE_AUTHOR("WeiXiong Liao <liaoweixiong@allwinnertech.com>");
>  MODULE_AUTHOR("Kees Cook <keescook@chromium.org>");
> -- 
> 2.28.0
> 

-- 
Kees Cook
