Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6C811B5BC3
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Apr 2020 14:51:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728419AbgDWMv1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Apr 2020 08:51:27 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:21571 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728381AbgDWMv0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 08:51:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587646285;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oFynhrdn2AeeDCMTi/GbcSIhzhXYtqVnBO1H8k4rM8s=;
        b=N7xHWzPI7I65AnkCsALYzYm7m2rHJGqKMejYETyONLZrfv2yrfgnWh6TB7Vbztw3i2bozt
        358KIL9LaX5Vht3CT9tpLyMVHG+6qiS6mFC4jOF6ZPP04A0XoRTFQjv8Xto0REUgaducwX
        13uvOkhLE9Znnbu/leFOCGL0lWaTfLY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-264-eH-LRYH_NzaSoWY6usQDIQ-1; Thu, 23 Apr 2020 08:51:23 -0400
X-MC-Unique: eH-LRYH_NzaSoWY6usQDIQ-1
Received: by mail-wr1-f71.google.com with SMTP id d17so2777876wrr.17
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 05:51:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oFynhrdn2AeeDCMTi/GbcSIhzhXYtqVnBO1H8k4rM8s=;
        b=Z6sQKPVhWNS3PV5pkif09KqDhj14XnTFc2/Xr4n6bT40CvWvd0X90OGdOn5el29qk/
         NOjyF3tx/mqqTJyo1vvCCbjcXJsHPia8cwK96Wgr33aLOqN4NJS8cwNxV3hnFk8dkHdR
         9rM8se7twujTyCHScWSsuKr7++e8z3juvSzHOUDy5oKlQURzujHpfit0Ngtj/sLQ+cBv
         o7HTDgc1OEy+jIFI55ItCIOP857ul/5vdUr/Nungt2o1hoarTf6wVCZohNbJfRmLXzz0
         GkBBdUko7GpiTOEGcVU++8FZH4PTbbd05t/m/ecFiiuOnrg/M/TvAvGduYlKoyy0t9Fx
         +o2g==
X-Gm-Message-State: AGi0PubMostmOsQN0jxWMA+GcqIphfsm9gcIm/LZXCbI4H2ZYVNHZgSt
        L//Amfvqal7uUXJd4Up6QqgngyQcgicALr/IuiT7LDcA+7Es5s3/u8upp82/IpzShifOPeY8Ks4
        rRb2NURAFclcsxLYYJreAuQa1
X-Received: by 2002:adf:f34f:: with SMTP id e15mr4890725wrp.275.1587646282060;
        Thu, 23 Apr 2020 05:51:22 -0700 (PDT)
X-Google-Smtp-Source: APiQypI/kzDW73KAZYZbxhnpJuArcvjawCoIOFrcjvuGR9Ia4oEPXtyQVUt1e61nouVHczLBSQLGAg==
X-Received: by 2002:adf:f34f:: with SMTP id e15mr4890704wrp.275.1587646281858;
        Thu, 23 Apr 2020 05:51:21 -0700 (PDT)
Received: from redhat.com (bzq-109-65-97-189.red.bezeqint.net. [109.65.97.189])
        by smtp.gmail.com with ESMTPSA id l4sm3745135wrv.60.2020.04.23.05.51.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2020 05:51:21 -0700 (PDT)
Date:   Thu, 23 Apr 2020 08:51:19 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Stefan Hajnoczi <stefanha@redhat.com>
Cc:     virtualization@lists.linux-foundation.org,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Lance Digby <ldigby@redhat.com>
Subject: Re: [PATCH] virtio-blk: handle block_device_operations callbacks
 after hot unplug
Message-ID: <20200423084914-mutt-send-email-mst@kernel.org>
References: <20200423123717.139141-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200423123717.139141-1-stefanha@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 23, 2020 at 01:37:17PM +0100, Stefan Hajnoczi wrote:
> A virtio_blk block device can still be referenced after hot unplug by
> userspace processes that hold the file descriptor.  In this case
> virtblk_getgeo() can be invoked after virtblk_remove() was called.  For
> example, a program that has /dev/vdb open can call ioctl(HDIO_GETGEO)
> after hot unplug.
> 
> Fix this by clearing vblk->disk->private_data and checking that the
> virtio_blk driver instance is still around in virtblk_getgeo().
> 
> Note that the virtblk_getgeo() function itself is guaranteed to remain
> in memory after hot unplug because the virtio_blk module refcount is
> still held while a block device reference exists.
> 
> Originally-by: Lance Digby <ldigby@redhat.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  drivers/block/virtio_blk.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index 93468b7c6701..b50cdf37a6f7 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -300,6 +300,10 @@ static int virtblk_getgeo(struct block_device *bd, struct hd_geometry *geo)
>  {
>  	struct virtio_blk *vblk = bd->bd_disk->private_data;
>  
> +	/* Driver instance has been removed */
> +	if (!vblk)
> +		return -ENOTTY;
> +
>  	/* see if the host passed in geometry config */
>  	if (virtio_has_feature(vblk->vdev, VIRTIO_BLK_F_GEOMETRY)) {
>  		virtio_cread(vblk->vdev, struct virtio_blk_config,

Just so I understand, what serializes this access?
See below for what looks like a race condition ...

> @@ -835,6 +839,7 @@ static void virtblk_remove(struct virtio_device *vdev)
>  	vdev->config->reset(vdev);
>  
>  	refc = kref_read(&disk_to_dev(vblk->disk)->kobj.kref);

So what if private_data is tested at this time ...

> +	vblk->disk->private_data = NULL;
>  	put_disk(vblk->disk);
>  	vdev->config->del_vqs(vdev);
>  	kfree(vblk->vqs);

... and then used at this time?

What prevents this?


> -- 
> 2.25.1
> 

