Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9180D2B7CEA
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 12:41:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727919AbgKRLjj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 06:39:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:52075 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726867AbgKRLji (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 06:39:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605699576;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6R/6pwwpmuxG0MDZ4yvt0MqGRHPil6xB7qtVxel0gLg=;
        b=LxZgRlQnMDGpF23ns1issgUcYppgpnHkbkbYSg1fWrsUrWBtT03oeLqpCFrqgPkP3zNlw9
        DJsnD03MgLAI3z05BZd7Qfgr7tXrAkObuVFWWzekoGCJAOiBDKyBQ9ifwHBDyh9/lF5nuv
        1u+sVZ86v+gDF01cKKBAlYU6wqQa1sw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-580-j--3qPDFPE-juJ_vE929Ug-1; Wed, 18 Nov 2020 06:39:35 -0500
X-MC-Unique: j--3qPDFPE-juJ_vE929Ug-1
Received: by mail-wr1-f69.google.com with SMTP id d8so808858wrr.10
        for <linux-kernel@vger.kernel.org>; Wed, 18 Nov 2020 03:39:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6R/6pwwpmuxG0MDZ4yvt0MqGRHPil6xB7qtVxel0gLg=;
        b=W3sRHYiJs3FMlor8O7pvxTqRUzbb0C2LHSfl3gJb0Dc33d4EXsnLOGyZq+j9bYcgnG
         oSxFDkKiMWXt1uNgx/rl3QY4cs711dO19U8+FDFkWt3TuPfqayBdYKZF/GsoahtdpY4N
         VfAiTj6xE5TRhu0L3PBrcOAumc7C0Ob+btkAHQIkxqKkHO4nXYr6VMeEoNgXm7p3PCHw
         /70NPpSJBlX1t+92EahucbOswc48hvSTUisqWXy1NqUgWZ6obI91XGFrIHDRSafqQAOc
         qes9hx6OwnCzysjERRlwg0D69XncWhP4dGprw+ViAgFI/pW3wOUN/4wKtQWm8l9Pu3Ni
         zmag==
X-Gm-Message-State: AOAM532y6qpqU/HzcQ3mxjQZyDRNGVaMj0yadpC7O3djmYu/Fa3s2N/0
        XKiSv2fucWl+4Y9cIxDAx8KWQTlV9Yoeu+4ygjPzv3GB7C4lBoivtlK22IESpN1YEtb4+0SP8pC
        1Dib4QOIVp5rhXzhg8kVonVHz
X-Received: by 2002:a7b:c1ce:: with SMTP id a14mr4098635wmj.126.1605699574083;
        Wed, 18 Nov 2020 03:39:34 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzrPLqC5uRTn2T9zd6p9hbLUkX2tNzGSzrjqO2hEeUwzwzrRTmKFuYoh+KPvYKlSgz9RTE61A==
X-Received: by 2002:a7b:c1ce:: with SMTP id a14mr4098620wmj.126.1605699573741;
        Wed, 18 Nov 2020 03:39:33 -0800 (PST)
Received: from steredhat (host-79-17-248-175.retail.telecomitalia.it. [79.17.248.175])
        by smtp.gmail.com with ESMTPSA id y16sm31384125wrt.25.2020.11.18.03.39.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2020 03:39:33 -0800 (PST)
Date:   Wed, 18 Nov 2020 12:39:30 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Stefan Hajnoczi <stefanha@redhat.com>
Cc:     virtualization@lists.linux-foundation.org,
        Laurent Vivier <lvivier@redhat.com>,
        linux-kernel@vger.kernel.org, Eli Cohen <elic@nvidia.com>,
        Jason Wang <jasowang@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: Re: [PATCH RFC 04/12] vdpa: add vdpa simulator for block device
Message-ID: <20201118113930.p7uigootcb42wqix@steredhat>
References: <20201113134712.69744-1-sgarzare@redhat.com>
 <20201113134712.69744-5-sgarzare@redhat.com>
 <20201117111121.GD131917@stefanha-x1.localdomain>
 <20201117141620.ytium7r6xpxi4and@steredhat>
 <20201117164342.GT131917@stefanha-x1.localdomain>
 <20201117173811.lw4nwicoykhnn3tt@steredhat>
 <20201118112355.GE182763@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20201118112355.GE182763@stefanha-x1.localdomain>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 18, 2020 at 11:23:55AM +0000, Stefan Hajnoczi wrote:
>On Tue, Nov 17, 2020 at 06:38:11PM +0100, Stefano Garzarella wrote:
>> On Tue, Nov 17, 2020 at 04:43:42PM +0000, Stefan Hajnoczi wrote:
>> > On Tue, Nov 17, 2020 at 03:16:20PM +0100, Stefano Garzarella wrote:
>> > > On Tue, Nov 17, 2020 at 11:11:21AM +0000, Stefan Hajnoczi wrote:
>> > > > On Fri, Nov 13, 2020 at 02:47:04PM +0100, Stefano Garzarella wrote:
>> > > > > +static void vdpasim_blk_work(struct work_struct *work)
>> > > > > +{
>> > > > > +	struct vdpasim *vdpasim = container_of(work, struct vdpasim, work);
>> > > > > +	u8 status = VIRTIO_BLK_S_OK;
>> > > > > +	int i;
>> > > > > +
>> > > > > +	spin_lock(&vdpasim->lock);
>> > > > > +
>> > > > > +	if (!(vdpasim->status & VIRTIO_CONFIG_S_DRIVER_OK))
>> > > > > +		goto out;
>> > > > > +
>> > > > > +	for (i = 0; i < VDPASIM_BLK_VQ_NUM; i++) {
>> > > > > +		struct vdpasim_virtqueue *vq = &vdpasim->vqs[i];
>> > > > > +
>> > > > > +		if (!vq->ready)
>> > > > > +			continue;
>> > > > > +
>> > > > > +		while (vringh_getdesc_iotlb(&vq->vring, &vq->iov, &vq->iov,
>> > > > > +					    &vq->head, GFP_ATOMIC) > 0) {
>> > > > > +
>> > > > > +			int write;
>> > > > > +
>> > > > > +			vq->iov.i = vq->iov.used - 1;
>> > > > > +			write = vringh_iov_push_iotlb(&vq->vring, &vq->iov, &status, 1);
>> > > > > +			if (write <= 0)
>> > > > > +				break;
>> > > >
>> > > > We're lucky the guest driver doesn't crash after VIRTIO_BLK_T_GET_ID? :)
>> > >
>> > > The crash could happen if the simulator doesn't put the string terminator,
>> > > but in virtio_blk.c, the serial_show() initialize the buffer putting the
>> > > string terminator in the VIRTIO_BLK_ID_BYTES element:
>> > >
>> > >     buf[VIRTIO_BLK_ID_BYTES] = '\0';
>> > >     err = virtblk_get_id(disk, buf);
>> > >
>> > > This should prevent the issue, right?
>> > >
>> > > However in the last patch of this series I implemented VIRTIO_BLK_T_GET_ID
>> > > support :-)
>> >
>> > Windows, BSD, macOS, etc guest drivers aren't necessarily going to
>> > terminate or initialize the serial string buffer.
>>
>> Unfortunately I discovered that VIRTIO_BLK_T_GET_ID is not in the VIRTIO
>> specs, so, just for curiosity, I checked the QEMU code and I found this:
>>
>>     case VIRTIO_BLK_T_GET_ID:
>>     {
>>         /*
>>          * NB: per existing s/n string convention the string is
>>          * terminated by '\0' only when shorter than buffer.
>>          */
>>         const char *serial = s->conf.serial ? s->conf.serial : "";
>>         size_t size = MIN(strlen(serial) + 1,
>>                           MIN(iov_size(in_iov, in_num),
>>                               VIRTIO_BLK_ID_BYTES));
>>         iov_from_buf(in_iov, in_num, 0, serial, size);
>>         virtio_blk_req_complete(req, VIRTIO_BLK_S_OK);
>>         virtio_blk_free_request(req);
>>         break;
>>     }
>>
>> It seems that the device emulation in QEMU expects that the driver
>> terminates the serial string buffer.
>>
>> Do you know why VIRTIO_BLK_T_GET_ID is not in the specs?
>> Should we add it?
>
>It's about to be merged into the VIRTIO spec:
>https://github.com/oasis-tcs/virtio-spec/issues/63
>

Great! Thanks for the link!

Stefano

