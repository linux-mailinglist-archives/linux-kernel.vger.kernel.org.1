Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C15171C38E5
	for <lists+linux-kernel@lfdr.de>; Mon,  4 May 2020 14:08:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728700AbgEDMIC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 May 2020 08:08:02 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:45818 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726445AbgEDMIB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 08:08:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588594079;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zuWx6hYJPqBsfZstC+jiYoXlJxIPt/6nxHsL/0OEzrQ=;
        b=ZQlIlB3V91GqRKHN5zyI8JBx+JPwmwyYz4RY7Zj7QFiE7Lef+fh59exMULOmk2PPHQk0wX
        SakplujAMuf2yFdwY6j/FJ8gaaROFDixocJ8kck+SFBDJf7oNo7x0QPzMbVsKYi48y2nFL
        1cWp+bGJYXEFNIyBtpY2A76I14Y5s8Q=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-230-A5-GwE_qM5O5y-LJEzdqKg-1; Mon, 04 May 2020 08:07:58 -0400
X-MC-Unique: A5-GwE_qM5O5y-LJEzdqKg-1
Received: by mail-wr1-f71.google.com with SMTP id m5so10612360wru.15
        for <linux-kernel@vger.kernel.org>; Mon, 04 May 2020 05:07:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zuWx6hYJPqBsfZstC+jiYoXlJxIPt/6nxHsL/0OEzrQ=;
        b=O76n4QyFYHj3E2wSWNtcDcAsXDmwOrlN+q8lmhF4EXrdmmjP/0ASVl/4jq8F5JDNOR
         ut/vn4kOuRTbZ/vOaU3p6rbHx7q31CxexkgRVhG0HqgUCh3I5fCBvsQLnPuhtafiIdIq
         Bwq0LNiv98eErceGaiADZ8oIcnyaU5AmGNVUiiw8/3HtTOxniADC3T0TqjZITOJTFDAW
         ack6BUszZ7Yqv0qRYgiz4CREhmIyoa8Ci/NVg78icvytDY9Fnjug/wQcJn8dwGLAYjsz
         nLD8nm5L+LOCFHO2cFj0upH8oUgV5XzGzTiMdu7Gt7oy7ZkjJnziZZFIXBqqlX18v8Iv
         Y2Vw==
X-Gm-Message-State: AGi0PuZ0blDT+SAzrF1aZ3Rf5q2v7uYM+LiZrtOsH2rn5Xi3t+0ypGgU
        8oLfVKFqTknrD8fkVwHeykozTxKj+Ed3wz/eJm77AZ9BsFClL88m3p3AfVLRmlBRBLy+EQ/dUJs
        XKxmncXjEDwJL2tA8Ul27kvL/
X-Received: by 2002:a1c:2d14:: with SMTP id t20mr14947261wmt.28.1588594076271;
        Mon, 04 May 2020 05:07:56 -0700 (PDT)
X-Google-Smtp-Source: APiQypLUNAOyHQ+Ax63ipDZ/jnigbHjmtPK4Ang2nqUkewZhGUrLHWVJon9T6jXVtqmF9BPomAwMPg==
X-Received: by 2002:a1c:2d14:: with SMTP id t20mr14947236wmt.28.1588594075981;
        Mon, 04 May 2020 05:07:55 -0700 (PDT)
Received: from redhat.com (bzq-109-66-7-121.red.bezeqint.net. [109.66.7.121])
        by smtp.gmail.com with ESMTPSA id u188sm13562493wmg.37.2020.05.04.05.07.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 05:07:55 -0700 (PDT)
Date:   Mon, 4 May 2020 08:07:52 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Cornelia Huck <cohuck@redhat.com>
Cc:     Stefan Hajnoczi <stefanha@redhat.com>,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        linux-kernel@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
        Stefano Garzarella <sgarzare@redhat.com>,
        Lance Digby <ldigby@redhat.com>
Subject: Re: [PATCH v4] virtio-blk: handle block_device_operations callbacks
 after hot unplug
Message-ID: <20200504080731-mutt-send-email-mst@kernel.org>
References: <20200430140442.171016-1-stefanha@redhat.com>
 <20200504134834.423eb89e.cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200504134834.423eb89e.cohuck@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 04, 2020 at 01:48:34PM +0200, Cornelia Huck wrote:
> On Thu, 30 Apr 2020 15:04:42 +0100
> Stefan Hajnoczi <stefanha@redhat.com> wrote:
> 
> > A userspace process holding a file descriptor to a virtio_blk device can
> > still invoke block_device_operations after hot unplug.  This leads to a
> > use-after-free accessing vblk->vdev in virtblk_getgeo() when
> > ioctl(HDIO_GETGEO) is invoked:
> > 
> >   BUG: unable to handle kernel NULL pointer dereference at 0000000000000090
> >   IP: [<ffffffffc00e5450>] virtio_check_driver_offered_feature+0x10/0x90 [virtio]
> >   PGD 800000003a92f067 PUD 3a930067 PMD 0
> >   Oops: 0000 [#1] SMP
> >   CPU: 0 PID: 1310 Comm: hdio-getgeo Tainted: G           OE  ------------   3.10.0-1062.el7.x86_64 #1
> >   Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
> >   task: ffff9be5fbfb8000 ti: ffff9be5fa890000 task.ti: ffff9be5fa890000
> >   RIP: 0010:[<ffffffffc00e5450>]  [<ffffffffc00e5450>] virtio_check_driver_offered_feature+0x10/0x90 [virtio]
> >   RSP: 0018:ffff9be5fa893dc8  EFLAGS: 00010246
> >   RAX: ffff9be5fc3f3400 RBX: ffff9be5fa893e30 RCX: 0000000000000000
> >   RDX: 0000000000000000 RSI: 0000000000000004 RDI: ffff9be5fbc10b40
> >   RBP: ffff9be5fa893dc8 R08: 0000000000000301 R09: 0000000000000301
> >   R10: 0000000000000000 R11: 0000000000000000 R12: ffff9be5fdc24680
> >   R13: ffff9be5fbc10b40 R14: ffff9be5fbc10480 R15: 0000000000000000
> >   FS:  00007f1bfb968740(0000) GS:ffff9be5ffc00000(0000) knlGS:0000000000000000
> >   CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >   CR2: 0000000000000090 CR3: 000000003a894000 CR4: 0000000000360ff0
> >   DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> >   DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> >   Call Trace:
> >    [<ffffffffc016ac37>] virtblk_getgeo+0x47/0x110 [virtio_blk]
> >    [<ffffffff8d3f200d>] ? handle_mm_fault+0x39d/0x9b0
> >    [<ffffffff8d561265>] blkdev_ioctl+0x1f5/0xa20
> >    [<ffffffff8d488771>] block_ioctl+0x41/0x50
> >    [<ffffffff8d45d9e0>] do_vfs_ioctl+0x3a0/0x5a0
> >    [<ffffffff8d45dc81>] SyS_ioctl+0xa1/0xc0
> > 
> > A related problem is that virtblk_remove() leaks the vd_index_ida index
> > when something still holds a reference to vblk->disk during hot unplug.
> > This causes virtio-blk device names to be lost (vda, vdb, etc).
> > 
> > Fix these issues by protecting vblk->vdev with a mutex and reference
> > counting vblk so the vd_index_ida index can be removed in all cases.
> > 
> > Fixes: 48e4043d4529523cbc7fa8dd745bd8e2c45ce1d3
> >        ("virtio: add virtio disk geometry feature")
> 
> Should be
> 
> Fixes: 48e4043d4529 ("virtio: add virtio disk geometry feature")


Yes - it was reported on linux-next so I fixed it up when applying.

> > Reported-by: Lance Digby <ldigby@redhat.com>
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > ---
> > v4:
> >  * Clarify vdev_mutex usage [Stefano and Michael]
> > 
> >  drivers/block/virtio_blk.c | 86 ++++++++++++++++++++++++++++++++++----
> >  1 file changed, 78 insertions(+), 8 deletions(-)
> > 
> > diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> > index 93468b7c6701..9d21bf0f155e 100644
> > --- a/drivers/block/virtio_blk.c
> > +++ b/drivers/block/virtio_blk.c
> > @@ -33,6 +33,15 @@ struct virtio_blk_vq {
> >  } ____cacheline_aligned_in_smp;
> >  
> >  struct virtio_blk {
> > +	/*
> > +	 * This mutex must be held by anything that may run after
> > +	 * virtblk_remove() sets vblk->vdev to NULL.
> > +	 *
> > +	 * blk-mq, virtqueue processing, and sysfs attribute code paths are
> > +	 * shut down before vblk->vdev is set to NULL and therefore do not need
> > +	 * to hold this mutex.
> > +	 */
> > +	struct mutex vdev_mutex;
> >  	struct virtio_device *vdev;
> >  
> >  	/* The disk structure for the kernel. */
> > @@ -44,6 +53,13 @@ struct virtio_blk {
> >  	/* Process context for config space updates */
> >  	struct work_struct config_work;
> >  
> > +	/*
> > +	 * Tracks references from block_device_operations open/release and
> > +	 * virtio_driver probe/remove so this object can be freed once no
> > +	 * longer in use.
> > +	 */
> > +	refcount_t refs;
> 
> Using a struct kref might be more idiomatic.
> 
> > +
> >  	/* What host tells us, plus 2 for header & tailer. */
> >  	unsigned int sg_elems;
> >  
> > @@ -295,10 +311,55 @@ static int virtblk_get_id(struct gendisk *disk, char *id_str)
> >  	return err;
> >  }
> >  
> > +static void virtblk_get(struct virtio_blk *vblk)
> > +{
> > +	refcount_inc(&vblk->refs);
> 
> Should the code even be able to grab a ref if !vblk->vdev?
> 
> > +}
> > +
> > +static void virtblk_put(struct virtio_blk *vblk)
> > +{
> > +	if (refcount_dec_and_test(&vblk->refs)) {
> > +		ida_simple_remove(&vd_index_ida, vblk->index);
> > +		mutex_destroy(&vblk->vdev_mutex);
> > +		kfree(vblk);
> 
> I think that's where putting these cleanups into a release() funtion
> would be more idiomatic.
> 
> > +	}
> > +}
> 
> (...)
> 
> Looks sane to me.

