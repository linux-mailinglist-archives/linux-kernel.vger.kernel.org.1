Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 624C11B6FEF
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Apr 2020 10:42:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726791AbgDXImJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Apr 2020 04:42:09 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:43769 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726298AbgDXImI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 04:42:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587717727;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eRBkH5/Xmo1XGOKZTIj29qxMagsUMmu9LlrB6+bvzhA=;
        b=F7tvAWZK3Pou5mUmzdqXeT5ByPCy2VEc7KDNRso3p7jwrMtEYaeptwjuKuAavM0xh5HmzJ
        J8D4LU3qll80h2oD58YP+EPg/ax89yUxVcMi+CjiDrW0S4ENJSxza7lHfgkVRi0x9I9TBQ
        kbpxa0QoWXE49i852sAUtM6CQYegjQ0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-153-qCKx6qIoOxSxXBfk5XlA2g-1; Fri, 24 Apr 2020 04:42:02 -0400
X-MC-Unique: qCKx6qIoOxSxXBfk5XlA2g-1
Received: by mail-wr1-f69.google.com with SMTP id x15so4456907wrn.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 01:42:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eRBkH5/Xmo1XGOKZTIj29qxMagsUMmu9LlrB6+bvzhA=;
        b=TK9Pb+BQLJF0RYP5iE5LIqFznezbPImvuE6KYJAxl29ih4SD9BCZ7H0nFRrfo5fJc9
         mnHArMMmF39en+YujgORDHwq9GJeZDFdu8QoA5r7uu0Hri9fjrjj180DU6EeBzlYnKFg
         ElcG37cOFCm20A48Bjbq0pTsaMe0Zo2AUxcqYmGwIBwhO/F4kI2Px2yi1UkUwAw9yqSW
         9S+MqwG19d2EzkBrOo+bEJTuFghRdxH8SIA/Qg2188zcHwLEVlxw9GBbJZnSaEyvy+5l
         PLR0tbWqgDmbvaYgD8S3pBD3PZ1fCvHNwDYzXp9+7EIsLrL6j66hXW5NPVEUR9kvvbjX
         QJxg==
X-Gm-Message-State: AGi0PuaRzfpO9W1gzvJrGa1DVA2shlg6bLoWifI/VTykFnqX9sC89lF2
        urDERQcRryVgP9KJ9dVWTfQbf25qVJhtRr8sVqNGGaia+RBvttPmT2wm8Es3wtn8VoBO0Ad+tkG
        yMYfSOhY946PaIkfUjEs+Bzo9
X-Received: by 2002:a7b:cd04:: with SMTP id f4mr8507239wmj.3.1587717721287;
        Fri, 24 Apr 2020 01:42:01 -0700 (PDT)
X-Google-Smtp-Source: APiQypKxuCqGvW3NHNyEw4+X3HPjqbYB2EyJcTmS/3W+wWEll8LclKWavyc7mGG0iFRlqlH/YaX6NQ==
X-Received: by 2002:a7b:cd04:: with SMTP id f4mr8507206wmj.3.1587717721017;
        Fri, 24 Apr 2020 01:42:01 -0700 (PDT)
Received: from steredhat (host108-207-dynamic.49-79-r.retail.telecomitalia.it. [79.49.207.108])
        by smtp.gmail.com with ESMTPSA id s12sm1831955wmc.7.2020.04.24.01.41.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2020 01:42:00 -0700 (PDT)
Date:   Fri, 24 Apr 2020 10:41:58 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Stefan Hajnoczi <stefanha@redhat.com>
Cc:     virtualization@lists.linux-foundation.org,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Lance Digby <ldigby@redhat.com>
Subject: Re: [PATCH] virtio-blk: handle block_device_operations callbacks
 after hot unplug
Message-ID: <20200424084158.uayekt5c3lus4532@steredhat>
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
> @@ -835,6 +839,7 @@ static void virtblk_remove(struct virtio_device *vdev)
>  	vdev->config->reset(vdev);
>  
>  	refc = kref_read(&disk_to_dev(vblk->disk)->kobj.kref);
> +	vblk->disk->private_data = NULL;
>  	put_disk(vblk->disk);
>  	vdev->config->del_vqs(vdev);
>  	kfree(vblk->vqs);

As pointed out, can be a race. We had a very similar issue in
virtio-vsock, and we solved using RCU to assign and get the pointer [1],
maybe the same solution can work here.

Cheers,
Stefano

[1] 0deab087b16a vsock/virtio: use RCU to avoid use-after-free on the_virtio_vsock

