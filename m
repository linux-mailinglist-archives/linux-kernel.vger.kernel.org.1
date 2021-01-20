Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C081D2FCFA1
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 13:14:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733223AbhATLkt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 06:40:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28705 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732934AbhATLFB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 06:05:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611140614;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IgKWadVO4IhTvmcLY56retKTp5qCTT4hdx8ojgzPM6c=;
        b=FBCaGJ+9HeMb/6QsrEJB4/VYFXoFfaBVKGfqVsCBDuGzHKmMI3ysMitKkAq3czc+T4uiEO
        aun7ikf2gexJKafbY4ofsSutl1pn0XspQy2ol+jnnWpxCIkKpVV/EvaFeBsNSAiKlxGKBF
        HwJXI+TMNoidb+S/4mFjip6Z9Nkf6Hg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-409-W_e0sA-lOMKjfGGkUTpSOQ-1; Wed, 20 Jan 2021 06:03:31 -0500
X-MC-Unique: W_e0sA-lOMKjfGGkUTpSOQ-1
Received: by mail-wr1-f70.google.com with SMTP id q18so11262861wrc.20
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 03:03:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IgKWadVO4IhTvmcLY56retKTp5qCTT4hdx8ojgzPM6c=;
        b=Naw8yPllXzbOMqOzwHwmf5b6nFfk8x3jFq0xR16MmjDMpaL66OfnxLGshGEXNVsZmT
         qI2M3hDAADesVzA4FrKie8e/dsESNYh3sqBcA2C4hIh8oJPPtEVFDXJEw7HC6r+IzdXt
         7Iho+tgb+3SX7muaJEebtenHY4PAs9KmaqFyvWuFYJgbuVuvwSsr5UEXy88JxELS5Xsh
         /qeZacdVjLYuTsaDgv6fgQOxwW3GP4rolgK/e+Vkrhql2vpvBmeb6m7FyEDdVnC9y7YF
         3kR72Myc/r+w70nFAlpEsSq+bTAhrxCNtabbxepC2wkmBU2I/kUu3iDS7c6yRMAkRsvk
         hZaQ==
X-Gm-Message-State: AOAM533bfxfQYetssqCnBmcsqeT5r7zWTl7Wy31jNq5lEI5cag3xyNEy
        GPr9xtETdiYNP89VjfPzxqPlq6En5PssWl5wfg9iSD++Ixi3GDaH+oBOxLZ+3tRyrRG6tMZ4SEK
        eKcTKvYFv6XfduG1PNMTNJoeB
X-Received: by 2002:a5d:4902:: with SMTP id x2mr8611993wrq.272.1611140610817;
        Wed, 20 Jan 2021 03:03:30 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwywLoNdtS4lCyWc3ZmurPe1dJfsEyxg1TTUlkT27LGHLKaXnUgjJOjYxEkBqAW7+WZS9nbEg==
X-Received: by 2002:a5d:4902:: with SMTP id x2mr8611973wrq.272.1611140610655;
        Wed, 20 Jan 2021 03:03:30 -0800 (PST)
Received: from redhat.com (bzq-79-177-39-148.red.bezeqint.net. [79.177.39.148])
        by smtp.gmail.com with ESMTPSA id g12sm3393102wmh.14.2021.01.20.03.03.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 03:03:29 -0800 (PST)
Date:   Wed, 20 Jan 2021 06:03:26 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Jiapeng Zhong <abaci-bugfix@linux.alibaba.com>,
        jasowang@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Tian Tao <tiantao6@hisilicon.com>
Subject: Re: [PATCH] virtio-mem: Assign boolean values to a bool variable
Message-ID: <20210120060301-mutt-send-email-mst@kernel.org>
References: <1611129031-82818-1-git-send-email-abaci-bugfix@linux.alibaba.com>
 <81a1817d-a1f5-dfca-550c-3e3f62cf3a9d@redhat.com>
 <20210120045736-mutt-send-email-mst@kernel.org>
 <da2cb3fb-0ea5-5afd-afb5-a9e7f474e148@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <da2cb3fb-0ea5-5afd-afb5-a9e7f474e148@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 20, 2021 at 11:04:18AM +0100, David Hildenbrand wrote:
> On 20.01.21 10:57, Michael S. Tsirkin wrote:
> > On Wed, Jan 20, 2021 at 10:40:37AM +0100, David Hildenbrand wrote:
> >> On 20.01.21 08:50, Jiapeng Zhong wrote:
> >>> Fix the following coccicheck warnings:
> >>>
> >>> ./drivers/virtio/virtio_mem.c:2580:2-25: WARNING: Assignment
> >>> of 0/1 to bool variable.
> >>>
> >>> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> >>> Signed-off-by: Jiapeng Zhong <abaci-bugfix@linux.alibaba.com>
> >>> ---
> >>>  drivers/virtio/virtio_mem.c | 2 +-
> >>>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>>
> >>> diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
> >>> index 9fc9ec4..85a272c 100644
> >>> --- a/drivers/virtio/virtio_mem.c
> >>> +++ b/drivers/virtio/virtio_mem.c
> >>> @@ -2577,7 +2577,7 @@ static int virtio_mem_probe(struct virtio_device *vdev)
> >>>  	 * actually in use (e.g., trying to reload the driver).
> >>>  	 */
> >>>  	if (vm->plugged_size) {
> >>> -		vm->unplug_all_required = 1;
> >>> +		vm->unplug_all_required = true;
> >>>  		dev_info(&vm->vdev->dev, "unplugging all memory is required\n");
> >>>  	}
> >>>  
> >>>
> >>
> >> Hi,
> >>
> >> we already had a fix on the list for quite a while:
> >>
> >> https://lkml.kernel.org/r/1609233239-60313-1-git-send-email-tiantao6@hisilicon.com
> > 
> > Can't find that one.
> 
> Looks like it was only on virtualization@ and a couple of people on cc.
> 
> https://lists.linuxfoundation.org/pipermail/virtualization/2020-December/051662.html
> 
> Interestingly, I cannot find the follow-up ("[PATCH] virtio-mem: use
> boolean value when setting vm->unplug_all_required") in the mailing list
> archives, even though it has virtualization@ on cc.


Unsurprising that I didn't merge it then ;)
Want to send your ack on this one?

> -- 
> Thanks,
> 
> David / dhildenb

