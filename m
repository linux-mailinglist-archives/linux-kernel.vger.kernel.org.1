Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5534C1BC365
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Apr 2020 17:25:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728786AbgD1PZS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Apr 2020 11:25:18 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:50609 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728606AbgD1PZR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 11:25:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588087516;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5MtNMEGePoQeOLLhuNO9qh1Kt/0hKDl+pM06audhEQE=;
        b=WCY45wgp9MZIZV24aw9O+CsRNmRMo8keKh+JMd1j/59gLURvnQGv76CVhborwEt5cN+W1Y
        G45B7+zH4NOTsJxMZZfvbbENQzeHlV3k/+HwK9Cj+i/q80Zb51N/m6nuFVFky5yqOjFsot
        QSAW1AgtwD7m21TU/IiXNlFc4rfivPE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-67-oaZ_Z8BoMbC0ijO3_-1-lw-1; Tue, 28 Apr 2020 11:25:13 -0400
X-MC-Unique: oaZ_Z8BoMbC0ijO3_-1-lw-1
Received: by mail-wm1-f72.google.com with SMTP id 14so997682wmo.9
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 08:25:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5MtNMEGePoQeOLLhuNO9qh1Kt/0hKDl+pM06audhEQE=;
        b=OSshChdr+SmoMY0BxhOkXqWvi++mQEiOa6livSK1isirTdecjvFbU0ghFPtaXYels7
         RewImknqScacdT2xZWgElxHgTKYRKuLeP1znJ+YQU7pNvGkhV8cxote5s5i6TWJTkNwI
         FTznypFz6aAbzrYPRzyMrm6fu7jNHmheU28Fhwgv9I6RpY5Bq+BoNxH38l15XqjWfhaY
         cOiJ95ClMP2/dkxTRBhXzqq63/ppOs9wjzRxMoE9te73yLa2N3HeD69SSFOtcOE403dE
         CRoSMcEYW6qtOIKB+ZtLRCUxKWOzC/6WuXthDlEdqpoL6X6+KC2rDJoemmgF8jpB9MMS
         wi6w==
X-Gm-Message-State: AGi0PubQIc7TbMZ8lURtdDaVESSQLZeKIiX7A2BJ2m18CJ0XGs07LMJ0
        EezP1rSkQSK4a70GkSHxCv9EgDHYJGMTpGE/A2tGc6YVKwQWyh7rri7I8i+h0XqRg2zeJ6e31/M
        gouhtR9PElhqzgAS3YamdwjLq
X-Received: by 2002:a1c:66d5:: with SMTP id a204mr5197820wmc.69.1588087512165;
        Tue, 28 Apr 2020 08:25:12 -0700 (PDT)
X-Google-Smtp-Source: APiQypIJdX3FBeU0e1jJbzapSQEZb33vOn2eVbDhxsWqrn0qFTot27aYfiyyqxJOctswjaoqI4z3Xg==
X-Received: by 2002:a1c:66d5:: with SMTP id a204mr5197790wmc.69.1588087511757;
        Tue, 28 Apr 2020 08:25:11 -0700 (PDT)
Received: from redhat.com (bzq-109-66-7-121.red.bezeqint.net. [109.66.7.121])
        by smtp.gmail.com with ESMTPSA id a205sm3990772wmh.29.2020.04.28.08.25.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2020 08:25:10 -0700 (PDT)
Date:   Tue, 28 Apr 2020 11:25:07 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Stefan Hajnoczi <stefanha@redhat.com>
Cc:     virtualization@lists.linux-foundation.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jason Wang <jasowang@redhat.com>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
        cohuck@redhat.com, Stefano Garzarella <sgarzare@redhat.com>,
        Lance Digby <ldigby@redhat.com>
Subject: Re: [PATCH v2] virtio-blk: handle block_device_operations callbacks
 after hot unplug
Message-ID: <20200428110515-mutt-send-email-mst@kernel.org>
References: <20200428143009.107645-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200428143009.107645-1-stefanha@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 28, 2020 at 03:30:09PM +0100, Stefan Hajnoczi wrote:
> A userspace process holding a file descriptor to a virtio_blk device can
> still invoke block_device_operations after hot unplug.  For example, a
> program that has /dev/vdb open can call ioctl(HDIO_GETGEO) after hot
> unplug to invoke virtblk_getgeo().


which causes what? a use after free?

> 
> Introduce a reference count in struct virtio_blk so that its lifetime
> covers both virtio_driver probe/remove and block_device_operations
> open/release users.  This ensures that block_device_operations functions
> like virtblk_getgeo() can safely access struct virtio_blk.
> 
> Add remove_mutex to prevent block_device_operations functions from
> accessing vblk->vdev during virtblk_remove() and let the safely check

let the -> let them?

> for !vblk->vdev after virtblk_remove() returns.
> 
> Switching to a reference count also solves the vd_index_ida leak where
> vda, vdb, vdc, etc indices were lost when the device was hot unplugged
> while the block device was still open.

Can you move this statement up so we list both issues (use after free
and leak) upfront, then discuss the fix?

> 
> Reported-by: Lance Digby <ldigby@redhat.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
> If someone has a simpler solution please let me know.  I looked at
> various approaches including reusing device_lock(&vblk->vdev.dev) but
> they were more complex and extending the lifetime of virtio_device after
> remove() has been called seems questionable.
> ---
>  drivers/block/virtio_blk.c | 85 ++++++++++++++++++++++++++++++++++----
>  1 file changed, 77 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index 93468b7c6701..3dd53b445cc1 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -44,6 +44,13 @@ struct virtio_blk {
>  	/* Process context for config space updates */
>  	struct work_struct config_work;
>  
> +	/*
> +	 * Tracks references from block_device_operations open/release and
> +	 * virtio_driver probe/remove so this object can be freed once no
> +	 * longer in use.
> +	 */
> +	refcount_t refs;
> +
>  	/* What host tells us, plus 2 for header & tailer. */
>  	unsigned int sg_elems;
>  
> @@ -53,6 +60,9 @@ struct virtio_blk {
>  	/* num of vqs */
>  	int num_vqs;
>  	struct virtio_blk_vq *vqs;
> +
> +	/* Provides mutual exclusion with virtblk_remove(). */

This is not the best way to document access rules.
Which fields does this protect, exactly?
I think it's just vdev. Right?
Pls add to the comment.

> +	struct mutex remove_mutex;
>  };
>  
>  struct virtblk_req {
> @@ -295,10 +305,54 @@ static int virtblk_get_id(struct gendisk *disk, char *id_str)
>  	return err;
>  }
>  
> +static void virtblk_get(struct virtio_blk *vblk)
> +{
> +	refcount_inc(&vblk->refs);
> +}
> +
> +static void virtblk_put(struct virtio_blk *vblk)
> +{
> +	if (refcount_dec_and_test(&vblk->refs)) {
> +		ida_simple_remove(&vd_index_ida, vblk->index);
> +		mutex_destroy(&vblk->remove_mutex);
> +		kfree(vblk);
> +	}
> +}
> +
> +static int virtblk_open(struct block_device *bd, fmode_t mode)
> +{
> +	struct virtio_blk *vblk = bd->bd_disk->private_data;
> +	int ret = -ENXIO;


It's more common to do

	int ret = 0;

and on error:
	ret = -ENXIO;


let's do this.


> +
> +	mutex_lock(&vblk->remove_mutex);
> +
> +	if (vblk->vdev) {
> +		virtblk_get(vblk);
> +		ret = 0;
> +	}

I prefer
	else
		ret = -ENXIO

here.


> +
> +	mutex_unlock(&vblk->remove_mutex);
> +	return ret;
> +}
> +
> +static void virtblk_release(struct gendisk *disk, fmode_t mode)
> +{
> +	struct virtio_blk *vblk = disk->private_data;
> +
> +	virtblk_put(vblk);
> +}
> +
>  /* We provide getgeo only to please some old bootloader/partitioning tools */
>  static int virtblk_getgeo(struct block_device *bd, struct hd_geometry *geo)
>  {
>  	struct virtio_blk *vblk = bd->bd_disk->private_data;
> +	int ret = -ENXIO;

It's more common to do

	int ret = 0;

and on error:
	ret = -ENXIO;


let's do this.

> +
> +	mutex_lock(&vblk->remove_mutex);
> +
> +	if (!vblk->vdev) {
> +		goto out;
> +	}


single lines are not supposed to use {}.
if you add ret = -ENXIO here then it won't be a single line anymore
though.

>  
>  	/* see if the host passed in geometry config */
>  	if (virtio_has_feature(vblk->vdev, VIRTIO_BLK_F_GEOMETRY)) {
> @@ -314,11 +368,17 @@ static int virtblk_getgeo(struct block_device *bd, struct hd_geometry *geo)
>  		geo->sectors = 1 << 5;
>  		geo->cylinders = get_capacity(bd->bd_disk) >> 11;
>  	}
> -	return 0;
> +
> +	ret = 0;
> +out:
> +	mutex_unlock(&vblk->remove_mutex);
> +	return ret;
>  }
>  
>  static const struct block_device_operations virtblk_fops = {
>  	.owner  = THIS_MODULE,
> +	.open = virtblk_open,
> +	.release = virtblk_release,
>  	.getgeo = virtblk_getgeo,
>  };
>  
> @@ -655,6 +715,10 @@ static int virtblk_probe(struct virtio_device *vdev)
>  		goto out_free_index;
>  	}
>  
> +	/* This reference is dropped in virtblk_remove(). */
> +	refcount_set(&vblk->refs, 1);
> +	mutex_init(&vblk->remove_mutex);
> +
>  	vblk->vdev = vdev;
>  	vblk->sg_elems = sg_elems;
>  
> @@ -820,8 +884,12 @@ static int virtblk_probe(struct virtio_device *vdev)
>  static void virtblk_remove(struct virtio_device *vdev)
>  {
>  	struct virtio_blk *vblk = vdev->priv;
> -	int index = vblk->index;
> -	int refc;
> +
> +	/*
> +	 * Virtqueue processing is stopped safely here but mutual exclusion is
> +	 * needed for block_device_operations.
> +	 */
> +	mutex_lock(&vblk->remove_mutex);
>  
>  	/* Make sure no work handler is accessing the device. */
>  	flush_work(&vblk->config_work);
> @@ -834,15 +902,16 @@ static void virtblk_remove(struct virtio_device *vdev)
>  	/* Stop all the virtqueues. */
>  	vdev->config->reset(vdev);
>  
> -	refc = kref_read(&disk_to_dev(vblk->disk)->kobj.kref);
> +	/* Virtqueue are stopped, nothing can use vblk->vdev anymore. */

Virtqueues?

> +	vblk->vdev = NULL;
> +
>  	put_disk(vblk->disk);
>  	vdev->config->del_vqs(vdev);
>  	kfree(vblk->vqs);
> -	kfree(vblk);
>  
> -	/* Only free device id if we don't have any users */
> -	if (refc == 1)
> -		ida_simple_remove(&vd_index_ida, index);
> +	mutex_unlock(&vblk->remove_mutex);
> +
> +	virtblk_put(vblk);
>  }
>  
>  #ifdef CONFIG_PM_SLEEP
> -- 
> 2.25.3
> 

