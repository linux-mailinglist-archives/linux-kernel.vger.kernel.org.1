Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB4682209C0
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jul 2020 12:20:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731074AbgGOKUN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jul 2020 06:20:13 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:25790 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728683AbgGOKUM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 06:20:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594808411;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=q1Ne/qGLtMr4oxn5ulkDcVE34rT0c3am/pJvoECaK3c=;
        b=IUmphwmkVJy6AbfpvHmDetr5be4/wywL3jXMh3IrawOwSMuUczgwUKv0F9PWDhlU9cVSkY
        Lx7AIpkpCFRFyzdPtBw/InqoMleTI3IHIG8f1N6H5304FF2tKf4cfUIxuRWBVvTLrHFRbk
        DOEkfWs6CqDxScv1WJ/cvQjf+qBrUvU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-458-19ar1el3O_Gd9ThFuiUGag-1; Wed, 15 Jul 2020 06:20:09 -0400
X-MC-Unique: 19ar1el3O_Gd9ThFuiUGag-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2F1C6106B245;
        Wed, 15 Jul 2020 10:20:08 +0000 (UTC)
Received: from starship (unknown [10.35.206.178])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A7FEE7BEA0;
        Wed, 15 Jul 2020 10:19:56 +0000 (UTC)
Message-ID: <5dd5af8032160eb49a4f0e38749e2d9cd968a0d6.camel@redhat.com>
Subject: Re: [PATCH] virtio-blk: check host supplied logical block size
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Stefan Hajnoczi <stefanha@redhat.com>,
        "open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
        "open list:VIRTIO CORE AND NET DRIVERS" 
        <virtualization@lists.linux-foundation.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jason Wang <jasowang@redhat.com>, Jens Axboe <axboe@kernel.dk>
Date:   Wed, 15 Jul 2020 13:19:55 +0300
In-Reply-To: <20200715060233-mutt-send-email-mst@kernel.org>
References: <20200715095518.3724-1-mlevitsk@redhat.com>
         <20200715060233-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.2 (3.36.2-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-07-15 at 06:06 -0400, Michael S. Tsirkin wrote:
> On Wed, Jul 15, 2020 at 12:55:18PM +0300, Maxim Levitsky wrote:
> > Linux kernel only supports logical block sizes which are power of
> > two,
> > at least 512 bytes and no more that PAGE_SIZE.
> > 
> > Check this instead of crashing later on.
> > 
> > Note that there is no need to check physical block size since it is
> > only a hint, and virtio-blk already only supports power of two
> > values.
> > 
> > Bugzilla link: https://bugzilla.redhat.com/show_bug.cgi?id=1664619
> > 
> > Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> > ---
> >  drivers/block/virtio_blk.c | 20 ++++++++++++++++++--
> >  1 file changed, 18 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> > index 980df853ee497..36dda31cc4e96 100644
> > --- a/drivers/block/virtio_blk.c
> > +++ b/drivers/block/virtio_blk.c
> > @@ -681,6 +681,12 @@ static const struct blk_mq_ops virtio_mq_ops =
> > {
> >  static unsigned int virtblk_queue_depth;
> >  module_param_named(queue_depth, virtblk_queue_depth, uint, 0444);
> >  
> > +
> > +static bool virtblk_valid_block_size(unsigned int blksize)
> > +{
> > +	return blksize >= 512 && blksize <= PAGE_SIZE &&
> > is_power_of_2(blksize);
> > +}
> > +
> 
> Is this a blk core assumption? in that case, does not this belong
> in blk core?

It is a blk core assumption. 
I had checked other drivers and these that have variable block size all
check this manually like that.

I don't mind fixing all of them but I am a bit afraid to create
too much mess.

> 
> >  static int virtblk_probe(struct virtio_device *vdev)
> >  {
> >  	struct virtio_blk *vblk;
> > @@ -809,9 +815,16 @@ static int virtblk_probe(struct virtio_device
> > *vdev)
> >  	err = virtio_cread_feature(vdev, VIRTIO_BLK_F_BLK_SIZE,
> >  				   struct virtio_blk_config, blk_size,
> >  				   &blk_size);
> > -	if (!err)
> > +	if (!err) {
> > +		if (!virtblk_valid_block_size(blk_size)) {
> > +			dev_err(&vdev->dev,
> > +				"%s failure: unsupported logical block
> > size %d\n",
> > +				__func__, blk_size);
> > +			err = -EINVAL;
> > +			goto out_cleanup_queue;
> > +		}
> >  		blk_queue_logical_block_size(q, blk_size);
> > -	else
> > +	} else
> >  		blk_size = queue_logical_block_size(q);
> >  
> >  	/* Use topology information if available */
> 
> OK so if we are doing this pls add {} around  blk_size =
> queue_logical_block_size(q);
> too.
Will do.

> 
> > @@ -872,6 +885,9 @@ static int virtblk_probe(struct virtio_device
> > *vdev)
> >  	device_add_disk(&vdev->dev, vblk->disk, virtblk_attr_groups);
> >  	return 0;
> >  
> > +out_cleanup_queue:
> > +	blk_cleanup_queue(vblk->disk->queue);
> > +	vblk->disk->queue = NULL;
> >  out_free_tags:
> >  	blk_mq_free_tag_set(&vblk->tag_set);
> >  out_put_disk:
> > -- 
> > 2.26.2


Best regards,
	Maxim Levitsky

