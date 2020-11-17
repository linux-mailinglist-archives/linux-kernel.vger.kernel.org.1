Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 930952B6BE6
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 18:38:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728128AbgKQRiV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 12:38:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:42526 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726509AbgKQRiV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 12:38:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605634699;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=z3zMU/irHlYxEEE6FnqPEHkVQnZNhU8YfF5u9aF7C6Y=;
        b=HQYWCPEs4gdRlIOaD4HewFQ1NXRbjT253Va4kmA/UyjY2taG/03jlZxYxeybkljiENCsa5
        xsXW8ejLqU0OSa6Wg+8w9BTF5sLpYiys/jX1cxIJlodXEL/UwAHtm/XZQvLrq+7QIaO+6k
        Pkns+eG4eRzIVJ7boFK87vQB8MYBTH4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-408-87BUsz3eOkaKon1VJI1mHQ-1; Tue, 17 Nov 2020 12:38:17 -0500
X-MC-Unique: 87BUsz3eOkaKon1VJI1mHQ-1
Received: by mail-wm1-f70.google.com with SMTP id y21so13154wma.6
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 09:38:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=z3zMU/irHlYxEEE6FnqPEHkVQnZNhU8YfF5u9aF7C6Y=;
        b=LczB8ip138Lk2Fm/qDoA/1Go9gyX/xLYg8DY4fnRYFW3MRC/VI1g2aisaRmmIZPjeX
         /FcJekAM6tJ3ArI28KLZr3PAVi+f3z0kBnxG1RaPY7UnAQUFhdOKJliG+5VkfDUH98Zo
         zTT3o6U0U8gAwDdPKLyy064LJ0EFi8G5fG5T7HzNPVumNJS1wV8Wk5upyUYw7Q3d/OZ7
         qLLb+Id2cZD1+uwsyzeTqM0GRdLI0lzaBbtvu4PPjamaoUHOWl6vw6xnJRsSog66KEFl
         skFiK/OHIb6JDbOOjHfdgCbMKAZAJDwC1isMm7F4HblV11wDGkJHYTgau8OQ58ksDjnb
         Wy6Q==
X-Gm-Message-State: AOAM530LxDoVe08csE4cfOnvwsEL3ygKQdqhPoZ4mPD3h288qyE0mpeC
        4ZB6VGhKteBD58QAG5MqXOmURlDmN01+oz3P7Ma2sPbu1UrQBOUTgsZhhvwCDQllFUPupnMKP0K
        PHaaT9YbKEb0S03jnrbno9aeI
X-Received: by 2002:adf:8304:: with SMTP id 4mr615939wrd.215.1605634694934;
        Tue, 17 Nov 2020 09:38:14 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwwdJ6+EaN9QGoIcD75zlLRHiDRmAV9Png2NohLzSTCxLdpVgipQWF3mLG37OL/b0dc/u/QeA==
X-Received: by 2002:adf:8304:: with SMTP id 4mr615917wrd.215.1605634694710;
        Tue, 17 Nov 2020 09:38:14 -0800 (PST)
Received: from steredhat (host-79-17-248-175.retail.telecomitalia.it. [79.17.248.175])
        by smtp.gmail.com with ESMTPSA id p21sm4228345wma.41.2020.11.17.09.38.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2020 09:38:13 -0800 (PST)
Date:   Tue, 17 Nov 2020 18:38:11 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Stefan Hajnoczi <stefanha@redhat.com>
Cc:     virtualization@lists.linux-foundation.org,
        Laurent Vivier <lvivier@redhat.com>,
        linux-kernel@vger.kernel.org, Eli Cohen <elic@nvidia.com>,
        Jason Wang <jasowang@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: Re: [PATCH RFC 04/12] vdpa: add vdpa simulator for block device
Message-ID: <20201117173811.lw4nwicoykhnn3tt@steredhat>
References: <20201113134712.69744-1-sgarzare@redhat.com>
 <20201113134712.69744-5-sgarzare@redhat.com>
 <20201117111121.GD131917@stefanha-x1.localdomain>
 <20201117141620.ytium7r6xpxi4and@steredhat>
 <20201117164342.GT131917@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20201117164342.GT131917@stefanha-x1.localdomain>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 17, 2020 at 04:43:42PM +0000, Stefan Hajnoczi wrote:
>On Tue, Nov 17, 2020 at 03:16:20PM +0100, Stefano Garzarella wrote:
>> On Tue, Nov 17, 2020 at 11:11:21AM +0000, Stefan Hajnoczi wrote:
>> > On Fri, Nov 13, 2020 at 02:47:04PM +0100, Stefano Garzarella wrote:
>> > > +static void vdpasim_blk_work(struct work_struct *work)
>> > > +{
>> > > +	struct vdpasim *vdpasim = container_of(work, struct vdpasim, work);
>> > > +	u8 status = VIRTIO_BLK_S_OK;
>> > > +	int i;
>> > > +
>> > > +	spin_lock(&vdpasim->lock);
>> > > +
>> > > +	if (!(vdpasim->status & VIRTIO_CONFIG_S_DRIVER_OK))
>> > > +		goto out;
>> > > +
>> > > +	for (i = 0; i < VDPASIM_BLK_VQ_NUM; i++) {
>> > > +		struct vdpasim_virtqueue *vq = &vdpasim->vqs[i];
>> > > +
>> > > +		if (!vq->ready)
>> > > +			continue;
>> > > +
>> > > +		while (vringh_getdesc_iotlb(&vq->vring, &vq->iov, &vq->iov,
>> > > +					    &vq->head, GFP_ATOMIC) > 0) {
>> > > +
>> > > +			int write;
>> > > +
>> > > +			vq->iov.i = vq->iov.used - 1;
>> > > +			write = vringh_iov_push_iotlb(&vq->vring, &vq->iov, &status, 1);
>> > > +			if (write <= 0)
>> > > +				break;
>> >
>> > We're lucky the guest driver doesn't crash after VIRTIO_BLK_T_GET_ID? :)
>>
>> The crash could happen if the simulator doesn't put the string terminator,
>> but in virtio_blk.c, the serial_show() initialize the buffer putting the
>> string terminator in the VIRTIO_BLK_ID_BYTES element:
>>
>>     buf[VIRTIO_BLK_ID_BYTES] = '\0';
>>     err = virtblk_get_id(disk, buf);
>>
>> This should prevent the issue, right?
>>
>> However in the last patch of this series I implemented VIRTIO_BLK_T_GET_ID
>> support :-)
>
>Windows, BSD, macOS, etc guest drivers aren't necessarily going to
>terminate or initialize the serial string buffer.

Unfortunately I discovered that VIRTIO_BLK_T_GET_ID is not in the VIRTIO 
specs, so, just for curiosity, I checked the QEMU code and I found this:

     case VIRTIO_BLK_T_GET_ID:
     {
         /*
          * NB: per existing s/n string convention the string is
          * terminated by '\0' only when shorter than buffer.
          */
         const char *serial = s->conf.serial ? s->conf.serial : "";
         size_t size = MIN(strlen(serial) + 1,
                           MIN(iov_size(in_iov, in_num),
                               VIRTIO_BLK_ID_BYTES));
         iov_from_buf(in_iov, in_num, 0, serial, size);
         virtio_blk_req_complete(req, VIRTIO_BLK_S_OK);
         virtio_blk_free_request(req);
         break;
     }

It seems that the device emulation in QEMU expects that the driver 
terminates the serial string buffer.

Do you know why VIRTIO_BLK_T_GET_ID is not in the specs?
Should we add it?

Thanks,
Stefano

>
>Anyway, the later patch that implements VIRTIO_BLK_T_GET_ID solves this
>issue! Thanks.

>
>Stefan


