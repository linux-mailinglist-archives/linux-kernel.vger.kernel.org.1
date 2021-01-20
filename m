Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BB4B2FCE2F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 11:52:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732471AbhATKSx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 05:18:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59510 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730430AbhATJ7W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 04:59:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611136673;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rI/aNUF4iX6rJBo6zJ7zLcisnPIn2Cuehxm+ovurTIg=;
        b=EP0BwrKbVjhEkaKI3E+NFXg3YV3ouJ9Ofs2m0UYaNCwBxHe0KesLg/ujvkSotIvqq6dFCY
        bQQrS/bCnz5Q9zBIJmn25xIWm+HdSCgAIvEiUDWiVd6r6i6mQ76BrOzsYryZYcfRzaxoIk
        IEs7b5DL5mzRDzPXXuQEeepmCRlWCUw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-551-nkNpEo95MwunsUlXB_5DgQ-1; Wed, 20 Jan 2021 04:57:51 -0500
X-MC-Unique: nkNpEo95MwunsUlXB_5DgQ-1
Received: by mail-wr1-f69.google.com with SMTP id j5so11180170wro.12
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 01:57:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rI/aNUF4iX6rJBo6zJ7zLcisnPIn2Cuehxm+ovurTIg=;
        b=lGoyjdlo2goMoSjkh9ZLxrtSYZWaJyZhoqPFLwt5Z3pzkad5CoiVISnM0wAyb763/r
         ddrYMnG1mk6hCo6uoQRo8HPbzOvkJAHg0/jUcggxWjg+M85fE42bj5rjcsReVoj76dA2
         1lXgMssTlkLCQZxy/s192oVf4/J86Bp/uY7OyuZq0Yp7MghejkS3ZXxncJsvkKnlgNu9
         Q9YnIErlcJVuPaMEhu+80eH7yq/mk0+SDw854V6BOSYNsR3u+JuKits2SKnPBplU9MOb
         98QDInCgg1mmDIqcoOt8jChcCbyLDLslGG+WOwgRRSwWuJJl9F77BXlI/jIvm/7ITKBO
         Ryqg==
X-Gm-Message-State: AOAM532olLZgDzXvCWrpR2ow3Anj3MV9aR7gQ/pDkFX0FKbSGvzTScKE
        biIr+jSvTBQrZDsVtoaCg5veGAifuREpFFKBNtoqlyZI1kSc3sqTkdfYJ9moPeiaVA3uTgypMN9
        C43VXpJRlyDQJZcvFeDYbdNdy
X-Received: by 2002:a1c:7c06:: with SMTP id x6mr3522127wmc.67.1611136670202;
        Wed, 20 Jan 2021 01:57:50 -0800 (PST)
X-Google-Smtp-Source: ABdhPJysojSYIU7BmwnZJ8v236DSByDjL3pHaRMW50WuxQGh9a57i9zHGHQkBa+2n+gsCeWAmYp1Fg==
X-Received: by 2002:a1c:7c06:: with SMTP id x6mr3522104wmc.67.1611136670014;
        Wed, 20 Jan 2021 01:57:50 -0800 (PST)
Received: from redhat.com (bzq-79-177-39-148.red.bezeqint.net. [79.177.39.148])
        by smtp.gmail.com with ESMTPSA id q15sm2875475wrw.75.2021.01.20.01.57.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 01:57:49 -0800 (PST)
Date:   Wed, 20 Jan 2021 04:57:46 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Jiapeng Zhong <abaci-bugfix@linux.alibaba.com>,
        jasowang@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Tian Tao <tiantao6@hisilicon.com>
Subject: Re: [PATCH] virtio-mem: Assign boolean values to a bool variable
Message-ID: <20210120045736-mutt-send-email-mst@kernel.org>
References: <1611129031-82818-1-git-send-email-abaci-bugfix@linux.alibaba.com>
 <81a1817d-a1f5-dfca-550c-3e3f62cf3a9d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <81a1817d-a1f5-dfca-550c-3e3f62cf3a9d@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 20, 2021 at 10:40:37AM +0100, David Hildenbrand wrote:
> On 20.01.21 08:50, Jiapeng Zhong wrote:
> > Fix the following coccicheck warnings:
> > 
> > ./drivers/virtio/virtio_mem.c:2580:2-25: WARNING: Assignment
> > of 0/1 to bool variable.
> > 
> > Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> > Signed-off-by: Jiapeng Zhong <abaci-bugfix@linux.alibaba.com>
> > ---
> >  drivers/virtio/virtio_mem.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
> > index 9fc9ec4..85a272c 100644
> > --- a/drivers/virtio/virtio_mem.c
> > +++ b/drivers/virtio/virtio_mem.c
> > @@ -2577,7 +2577,7 @@ static int virtio_mem_probe(struct virtio_device *vdev)
> >  	 * actually in use (e.g., trying to reload the driver).
> >  	 */
> >  	if (vm->plugged_size) {
> > -		vm->unplug_all_required = 1;
> > +		vm->unplug_all_required = true;
> >  		dev_info(&vm->vdev->dev, "unplugging all memory is required\n");
> >  	}
> >  
> > 
> 
> Hi,
> 
> we already had a fix on the list for quite a while:
> 
> https://lkml.kernel.org/r/1609233239-60313-1-git-send-email-tiantao6@hisilicon.com

Can't find that one.

> However, looks like Michael queued your patch on the vhost tree instead.
> 
> -- 
> Thanks,
> 
> David / dhildenb

