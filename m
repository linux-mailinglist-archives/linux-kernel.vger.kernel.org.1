Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C03DF2FCFC9
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 13:14:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730486AbhATLy2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 06:54:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:40178 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729193AbhATLee (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 06:34:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611142388;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pFGGWQjriPthIYfyi3X3sOv+nCS3Pi6CkQN1y+wI4Fk=;
        b=S9MqfV9QV6Y17xnLIX90J2kuZPgdfx68s84R7gqeVSJF9r1aGkR36QQu7VlxvGyLRlGndz
        nCntDMIKbmn8adDYT3HzE3T6M2vURmBpKwtABDZHyg5xRbHBaw2zx3qmlRvwl1hFTPHWcJ
        iTiYyIp/zgwafCkLF2Ktx24X/1Xen/g=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-314-i5ePAcRUOSmEMnp_Cmt4gA-1; Wed, 20 Jan 2021 06:33:05 -0500
X-MC-Unique: i5ePAcRUOSmEMnp_Cmt4gA-1
Received: by mail-wr1-f72.google.com with SMTP id g17so11257568wrr.11
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 03:33:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pFGGWQjriPthIYfyi3X3sOv+nCS3Pi6CkQN1y+wI4Fk=;
        b=nTFCfEpb35TbHi1o4u8t78xs274CNqTW/AwoA35s/BliGzcP8rI3676sxVEYfBRZMf
         NalCkb9Ps6RJwOcz2beV3nFu8ZOS1EThwUoBusTJ8h2vGJaOwIc/rpnOzk3Y3ZnFbw6H
         R2N5tx91TG8CTwE/oa/oq2kmRZKXxEe9x3BD4D+kaoTLjtq2jNT07qpqABQeEQC6DW8J
         VrHV+dQWx2ZWdl7I/u1PZeuJM5B4goLrqRUxTwzg4fkGYYnBdmKw+DWn0GZLXMAp3A01
         eNjy+jKhh2jek2PQH/dAilVjK33blKcEPAvEgkRsrPyMHRtrkJ6/1xkoY7dmVvTJhio3
         yuBw==
X-Gm-Message-State: AOAM533GV/ndKhUAH1n2VbXhm3ir2hryHEe3ZKECgBtM/o+UjO38IOnt
        9FLCINUG+1PpwfyFWieN58Kk3DtWtxFn5Ix3AwHVwlNuDAsZKfbLYVTJNS+qyEZKbDL2inSAeQD
        71JJDJqe+ceiJJvOOrWUkNGOd
X-Received: by 2002:adf:f78e:: with SMTP id q14mr8804239wrp.320.1611142384134;
        Wed, 20 Jan 2021 03:33:04 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxpAzKVhVIbT4hcSrf3FM2z1FMS/LGB4HGq2jsjXgqDx5dXW8G7egeuMP2ItkYMGP6U/CzXlw==
X-Received: by 2002:adf:f78e:: with SMTP id q14mr8804219wrp.320.1611142383943;
        Wed, 20 Jan 2021 03:33:03 -0800 (PST)
Received: from redhat.com (bzq-79-177-39-148.red.bezeqint.net. [79.177.39.148])
        by smtp.gmail.com with ESMTPSA id a16sm2548221wrr.89.2021.01.20.03.33.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 03:33:03 -0800 (PST)
Date:   Wed, 20 Jan 2021 06:33:00 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Jiapeng Zhong <abaci-bugfix@linux.alibaba.com>,
        jasowang@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Tian Tao <tiantao6@hisilicon.com>
Subject: Re: [PATCH] virtio-mem: Assign boolean values to a bool variable
Message-ID: <20210120063209-mutt-send-email-mst@kernel.org>
References: <1611129031-82818-1-git-send-email-abaci-bugfix@linux.alibaba.com>
 <81a1817d-a1f5-dfca-550c-3e3f62cf3a9d@redhat.com>
 <20210120045736-mutt-send-email-mst@kernel.org>
 <da2cb3fb-0ea5-5afd-afb5-a9e7f474e148@redhat.com>
 <20210120060301-mutt-send-email-mst@kernel.org>
 <a61b016e-7896-134c-a1be-8ff8e8e6fbe2@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a61b016e-7896-134c-a1be-8ff8e8e6fbe2@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 20, 2021 at 12:14:14PM +0100, David Hildenbrand wrote:
> On 20.01.21 12:03, Michael S. Tsirkin wrote:
> > On Wed, Jan 20, 2021 at 11:04:18AM +0100, David Hildenbrand wrote:
> >> On 20.01.21 10:57, Michael S. Tsirkin wrote:
> >>> On Wed, Jan 20, 2021 at 10:40:37AM +0100, David Hildenbrand wrote:
> >>>> On 20.01.21 08:50, Jiapeng Zhong wrote:
> >>>>> Fix the following coccicheck warnings:
> >>>>>
> >>>>> ./drivers/virtio/virtio_mem.c:2580:2-25: WARNING: Assignment
> >>>>> of 0/1 to bool variable.
> >>>>>
> >>>>> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> >>>>> Signed-off-by: Jiapeng Zhong <abaci-bugfix@linux.alibaba.com>
> >>>>> ---
> >>>>>  drivers/virtio/virtio_mem.c | 2 +-
> >>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>>>>
> >>>>> diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
> >>>>> index 9fc9ec4..85a272c 100644
> >>>>> --- a/drivers/virtio/virtio_mem.c
> >>>>> +++ b/drivers/virtio/virtio_mem.c
> >>>>> @@ -2577,7 +2577,7 @@ static int virtio_mem_probe(struct virtio_device *vdev)
> >>>>>  	 * actually in use (e.g., trying to reload the driver).
> >>>>>  	 */
> >>>>>  	if (vm->plugged_size) {
> >>>>> -		vm->unplug_all_required = 1;
> >>>>> +		vm->unplug_all_required = true;
> >>>>>  		dev_info(&vm->vdev->dev, "unplugging all memory is required\n");
> >>>>>  	}
> >>>>>  
> >>>>>
> >>>>
> >>>> Hi,
> >>>>
> >>>> we already had a fix on the list for quite a while:
> >>>>
> >>>> https://lkml.kernel.org/r/1609233239-60313-1-git-send-email-tiantao6@hisilicon.com
> >>>
> >>> Can't find that one.
> >>
> >> Looks like it was only on virtualization@ and a couple of people on cc.
> >>
> >> https://lists.linuxfoundation.org/pipermail/virtualization/2020-December/051662.html
> >>
> >> Interestingly, I cannot find the follow-up ("[PATCH] virtio-mem: use
> >> boolean value when setting vm->unplug_all_required") in the mailing list
> >> archives, even though it has virtualization@ on cc.
> > 
> > 
> > Unsurprising that I didn't merge it then ;)
> 
> Well, you were on cc ;)

Hmm true. Found it now.

> > Want to send your ack on this one?
> 
> Sure
> 
> Acked-by: David Hildenbrand <david@redhat.com>


Added yours and the original Signed-off-by.

Thanks!

> 
> -- 
> Thanks,
> 
> David / dhildenb

