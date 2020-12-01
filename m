Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFA5E2CAC63
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 20:31:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404393AbgLATaH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 14:30:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404351AbgLATaG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 14:30:06 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E13B9C0613D6
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 11:29:22 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id s21so1756329pfu.13
        for <linux-kernel@vger.kernel.org>; Tue, 01 Dec 2020 11:29:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=uHc3+DnHK9PLE5XljsP938ZieTXyfac5v2OAwUm2/s4=;
        b=GOKIK33tiPHZO4211DGLpG7EwNj3KWK2pSnCu8JCq2zGxwOKPqup9Bbqf0L9TlH5/0
         5xuHv1A/RewFOkJvUQVCT4ev/69Bupx58syQ1yQ3xC3bCqmh0vs+x/1CBio8AYkiqACs
         3RBy+RUKhdaf/siED4BpuJA8o0bGWbEcQlsFk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uHc3+DnHK9PLE5XljsP938ZieTXyfac5v2OAwUm2/s4=;
        b=uaYiZUKNfT5zeo04hjjQzoNy7ZNmyodZGKsgNlomC34UuuvWrEd3tsZqKuTaH9WQIQ
         uoCakkkOR/5Wajr5Lu+CybuqPVD0/oLWJFtpJfog6/JqumqtTGzS/JdYqCEGL6P6wvoG
         6wKrbSmtKnL5H3QKoTxTcdJyiD6HlruD8RQBZZXwkMW7NfVUaNcBNWWnM7Gmbno/OL4w
         0wBh+vLti6q9poh5LpGz63QtUNa9rj+Wwwti7b6AlCtBkVzcu9ptovNcnhs4aGdZRbFp
         1SENAbbBySOxXL+ewOjIkia2wHpWeb7roEX8CR/F4mdqaGQVUcPX8CFRCfNoVJXVTEVe
         udjQ==
X-Gm-Message-State: AOAM531STQ7hVakUm68K2UVCkx4zfh+7X86ZW5ygqWBOtkdo0ncXv4HU
        BDkIS1Le9CMP4WEd0zrmP/nKww==
X-Google-Smtp-Source: ABdhPJyr3YDxom7QSOfa+4VJ7zHhrXDxDhzEDzSN8T2kindZuUisgerVVrYnD4ja1rkt1ALtBGIo2A==
X-Received: by 2002:a63:2155:: with SMTP id s21mr3557222pgm.3.1606850962370;
        Tue, 01 Dec 2020 11:29:22 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id v23sm537501pfn.141.2020.12.01.11.29.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Dec 2020 11:29:21 -0800 (PST)
Date:   Tue, 1 Dec 2020 11:29:20 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        WeiXiong Liao <liaoweixiong@allwinnertech.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/9] pstore/blk: remove {un,}register_pstore_blk
Message-ID: <202012011128.CF6461B88@keescook>
References: <20201016132047.3068029-1-hch@lst.de>
 <20201016132047.3068029-4-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201016132047.3068029-4-hch@lst.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 16, 2020 at 03:20:41PM +0200, Christoph Hellwig wrote:
> This interface is entirely unused, so remove them and various bits of
> unreachable code.

Yeah, this is fair to remove -- there are no users. I'm not a fan of
dropping it, but it can come back if anyone wants to provide a full
generic block device implementation.

Reviewed-by: Kees Cook <keescook@chromium.org>


> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  Documentation/admin-guide/pstore-blk.rst |  8 +--
>  fs/pstore/blk.c                          | 79 ++----------------------
>  include/linux/pstore_blk.h               | 42 -------------
>  3 files changed, 7 insertions(+), 122 deletions(-)
> 
> diff --git a/Documentation/admin-guide/pstore-blk.rst b/Documentation/admin-guide/pstore-blk.rst
> index d9ec8b0572d3b2..84477621384d85 100644
> --- a/Documentation/admin-guide/pstore-blk.rst
> +++ b/Documentation/admin-guide/pstore-blk.rst
> @@ -151,13 +151,7 @@ otherwise KMSG_DUMP_MAX.
>  Configurations for driver
>  -------------------------
>  
> -Only a block device driver cares about these configurations. A block device
> -driver uses ``register_pstore_blk`` to register to pstore/blk.
> -
> -.. kernel-doc:: fs/pstore/blk.c
> -   :identifiers: register_pstore_blk
> -
> -A non-block device driver uses ``register_pstore_device`` with
> +A device driver uses ``register_pstore_device`` with
>  ``struct pstore_device_info`` to register to pstore/blk.
>  
>  .. kernel-doc:: fs/pstore/blk.c
> diff --git a/fs/pstore/blk.c b/fs/pstore/blk.c
> index fcd5563dde063c..7f8368e94b3604 100644
> --- a/fs/pstore/blk.c
> +++ b/fs/pstore/blk.c
> @@ -90,7 +90,6 @@ MODULE_PARM_DESC(blkdev, "block device for pstore storage");
>  static DEFINE_MUTEX(pstore_blk_lock);
>  static struct block_device *psblk_bdev;
>  static struct pstore_zone_info *pstore_zone_info;
> -static pstore_blk_panic_write_op blkdev_panic_write;
>  
>  struct bdev_info {
>  	dev_t devt;
> @@ -341,24 +340,7 @@ static ssize_t psblk_generic_blk_write(const char *buf, size_t bytes,
>  	return ret;
>  }
>  
> -static ssize_t psblk_blk_panic_write(const char *buf, size_t size,
> -		loff_t off)
> -{
> -	int ret;
> -
> -	if (!blkdev_panic_write)
> -		return -EOPNOTSUPP;
> -
> -	/* size and off must align to SECTOR_SIZE for block device */
> -	ret = blkdev_panic_write(buf, off >> SECTOR_SHIFT,
> -			size >> SECTOR_SHIFT);
> -	/* try next zone */
> -	if (ret == -ENOMSG)
> -		return ret;
> -	return ret ? -EIO : size;
> -}
> -
> -static int __register_pstore_blk(struct pstore_blk_info *info)
> +static int __register_pstore_blk(void)
>  {
>  	char bdev_name[BDEVNAME_SIZE];
>  	struct block_device *bdev;
> @@ -378,68 +360,34 @@ static int __register_pstore_blk(struct pstore_blk_info *info)
>  	}
>  
>  	/* only allow driver matching the @blkdev */
> -	if (!binfo.devt || (!best_effort &&
> -			    MAJOR(binfo.devt) != info->major)) {
> -		pr_debug("invalid major %u (expect %u)\n",
> -				info->major, MAJOR(binfo.devt));
> +	if (!binfo.devt) {
> +		pr_debug("no major\n");
>  		ret = -ENODEV;
>  		goto err_put_bdev;
>  	}
>  
>  	/* psblk_bdev must be assigned before register to pstore/blk */
>  	psblk_bdev = bdev;
> -	blkdev_panic_write = info->panic_write;
> -
> -	/* Copy back block device details. */
> -	info->devt = binfo.devt;
> -	info->nr_sects = binfo.nr_sects;
> -	info->start_sect = binfo.start_sect;
>  
>  	memset(&dev, 0, sizeof(dev));
> -	dev.total_size = info->nr_sects << SECTOR_SHIFT;
> -	dev.flags = info->flags;
> +	dev.total_size = binfo.nr_sects << SECTOR_SHIFT;
>  	dev.read = psblk_generic_blk_read;
>  	dev.write = psblk_generic_blk_write;
> -	dev.erase = NULL;
> -	dev.panic_write = info->panic_write ? psblk_blk_panic_write : NULL;
>  
>  	ret = __register_pstore_device(&dev);
>  	if (ret)
>  		goto err_put_bdev;
>  
>  	bdevname(bdev, bdev_name);
> -	pr_info("attached %s%s\n", bdev_name,
> -		info->panic_write ? "" : " (no dedicated panic_write!)");
> +	pr_info("attached %s (no dedicated panic_write!)\n", bdev_name);
>  	return 0;
>  
>  err_put_bdev:
>  	psblk_bdev = NULL;
> -	blkdev_panic_write = NULL;
>  	psblk_put_bdev(bdev, holder);
>  	return ret;
>  }
>  
> -/**
> - * register_pstore_blk() - register block device to pstore/blk
> - *
> - * @info: details on the desired block device interface
> - *
> - * Return:
> - * * 0		- OK
> - * * Others	- something error.
> - */
> -int register_pstore_blk(struct pstore_blk_info *info)
> -{
> -	int ret;
> -
> -	mutex_lock(&pstore_blk_lock);
> -	ret = __register_pstore_blk(info);
> -	mutex_unlock(&pstore_blk_lock);
> -
> -	return ret;
> -}
> -EXPORT_SYMBOL_GPL(register_pstore_blk);
> -
>  static void __unregister_pstore_blk(unsigned int major)
>  {
>  	struct pstore_device_info dev = { .read = psblk_generic_blk_read };
> @@ -449,24 +397,10 @@ static void __unregister_pstore_blk(unsigned int major)
>  	if (psblk_bdev && MAJOR(psblk_bdev->bd_dev) == major) {
>  		__unregister_pstore_device(&dev);
>  		psblk_put_bdev(psblk_bdev, holder);
> -		blkdev_panic_write = NULL;
>  		psblk_bdev = NULL;
>  	}
>  }
>  
> -/**
> - * unregister_pstore_blk() - unregister block device from pstore/blk
> - *
> - * @major: the major device number of device
> - */
> -void unregister_pstore_blk(unsigned int major)
> -{
> -	mutex_lock(&pstore_blk_lock);
> -	__unregister_pstore_blk(major);
> -	mutex_unlock(&pstore_blk_lock);
> -}
> -EXPORT_SYMBOL_GPL(unregister_pstore_blk);
> -
>  /* get information of pstore/blk */
>  int pstore_blk_get_config(struct pstore_blk_config *info)
>  {
> @@ -483,12 +417,11 @@ EXPORT_SYMBOL_GPL(pstore_blk_get_config);
>  
>  static int __init pstore_blk_init(void)
>  {
> -	struct pstore_blk_info info = { };
>  	int ret = 0;
>  
>  	mutex_lock(&pstore_blk_lock);
>  	if (!pstore_zone_info && best_effort && blkdev[0])
> -		ret = __register_pstore_blk(&info);
> +		ret = __register_pstore_blk();
>  	mutex_unlock(&pstore_blk_lock);
>  
>  	return ret;
> diff --git a/include/linux/pstore_blk.h b/include/linux/pstore_blk.h
> index 61e914522b0193..99564f93d77488 100644
> --- a/include/linux/pstore_blk.h
> +++ b/include/linux/pstore_blk.h
> @@ -7,48 +7,6 @@
>  #include <linux/pstore.h>
>  #include <linux/pstore_zone.h>
>  
> -/**
> - * typedef pstore_blk_panic_write_op - panic write operation to block device
> - *
> - * @buf: the data to write
> - * @start_sect: start sector to block device
> - * @sects: sectors count on buf
> - *
> - * Return: On success, zero should be returned. Others excluding -ENOMSG
> - * mean error. -ENOMSG means to try next zone.
> - *
> - * Panic write to block device must be aligned to SECTOR_SIZE.
> - */
> -typedef int (*pstore_blk_panic_write_op)(const char *buf, sector_t start_sect,
> -		sector_t sects);
> -
> -/**
> - * struct pstore_blk_info - pstore/blk registration details
> - *
> - * @major:	Which major device number to support with pstore/blk
> - * @flags:	The supported PSTORE_FLAGS_* from linux/pstore.h.
> - * @panic_write:The write operation only used for the panic case.
> - *		This can be NULL, but is recommended to avoid losing
> - *		crash data if the kernel's IO path or work queues are
> - *		broken during a panic.
> - * @devt:	The dev_t that pstore/blk has attached to.
> - * @nr_sects:	Number of sectors on @devt.
> - * @start_sect:	Starting sector on @devt.
> - */
> -struct pstore_blk_info {
> -	unsigned int major;
> -	unsigned int flags;
> -	pstore_blk_panic_write_op panic_write;
> -
> -	/* Filled in by pstore/blk after registration. */
> -	dev_t devt;
> -	sector_t nr_sects;
> -	sector_t start_sect;
> -};
> -
> -int  register_pstore_blk(struct pstore_blk_info *info);
> -void unregister_pstore_blk(unsigned int major);
> -
>  /**
>   * struct pstore_device_info - back-end pstore/blk driver structure.
>   *
> -- 
> 2.28.0
> 

-- 
Kees Cook
