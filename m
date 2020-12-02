Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF84A2CBA2B
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 11:10:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729370AbgLBKH2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 05:07:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60202 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729349AbgLBKH1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 05:07:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606903560;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PbDDvGrK+lSE7MWXuh3UJq+otQmOFQID2RCDUTDFTBk=;
        b=YcFs+XxJzw4RaPVrIawLRY2H4Kon4SSNr/49OfC2Tnvp2SJ6hu7friqXtOL61LVMyO1bzC
        BEalWdmiafMeaXaAv36Z7H4Y/NCujN0ZJQTqz1LnXyZiJqnDdH4N6D+xAUdUicMHrf1wJo
        Z41GkcdasOZo1o1jcIHmbFDH2+Umm3E=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-549-4VKep3ZgOdevJprQeaD_1A-1; Wed, 02 Dec 2020 05:05:59 -0500
X-MC-Unique: 4VKep3ZgOdevJprQeaD_1A-1
Received: by mail-wr1-f70.google.com with SMTP id x16so2943513wrm.20
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 02:05:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PbDDvGrK+lSE7MWXuh3UJq+otQmOFQID2RCDUTDFTBk=;
        b=KqxQICFZJ4OFSuiJPfs7LppuF0Iw5LrpwSJIBH0RSXRv5b/BghLDwHrxZw/+YjzHx/
         wohkRqUdB9ExeO4qrlFSREzujN9OUnRKUPkpSki3MAsPCQX2WCezy6u4746cQf6au3en
         tp0V5SzeIyIVZkZb+I+4KnZpEQzfJJR1CfUPfOv0IZRheR3mzElgdkuYREFarEb2Gmru
         MFgrh3SeFiF8rJ+uj9rNgQdYAf+DyhSUjSZQvTLMqqARB0dpT7G6ucE5XeiQMDRXS9mx
         jT19Q2Rh+k5FkgTpPukb5An3Ifiz54sFFCGYEIkupVyrAh2GO8k93ap5/Cb1fTUZYyoh
         RV8g==
X-Gm-Message-State: AOAM532rc5mQyff1i7baxIqmK3NONwHWHOE16B5/TmSU++3xU1xhwKs2
        L+ep2s/7aTccuo2Gnc2Ie7Xv7nWewpb5d9+ZMzTkVjxR2mqmLBsRMZzr7j+lDj9vRQMWt0mIVy+
        naq+EfyEhS+OwwLJaeayHKVMf
X-Received: by 2002:adf:a1c2:: with SMTP id v2mr2386526wrv.95.1606903554758;
        Wed, 02 Dec 2020 02:05:54 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxzAkTq8bXuJFW7NHdmLsLxKyy6vL7jL4nlti/FLH63SUNoE4PDnFQs/gXTmXx74q3nmxnmlw==
X-Received: by 2002:adf:a1c2:: with SMTP id v2mr2386355wrv.95.1606903553082;
        Wed, 02 Dec 2020 02:05:53 -0800 (PST)
Received: from steredhat (host-79-17-248-175.retail.telecomitalia.it. [79.17.248.175])
        by smtp.gmail.com with ESMTPSA id h2sm1443549wrv.76.2020.12.02.02.05.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 02:05:52 -0800 (PST)
Date:   Wed, 2 Dec 2020 11:05:50 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Norbert Slusarek <nslusarek@gmx.net>,
        Jorgen Hansen <jhansen@vmware.com>,
        Arnd Bergmann <arnd@kernel.org>
Cc:     gregkh <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RESEND] misc/vmw_vmci: bail out earlier on too big queue
 allocation
Message-ID: <CAGxU2F7-suw3PT0GKw68AHTaOzUOgbBRCZmNOZd+MH+Y+q8EyA@mail.gmail.com>
References: <trinity-56749cfc-536b-45e2-8e6f-621754c07824-1606165260518@3c-app-gmx-bs09>
 <CAK8P3a2dq8VtYARPS9r9aeJipA3hD9M01wmEJ8LuZT1_Taav3w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a2dq8VtYARPS9r9aeJipA3hD9M01wmEJ8LuZT1_Taav3w@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 1, 2020 at 9:21 PM Arnd Bergmann <arnd@kernel.org> wrote:
>
> On Mon, Nov 23, 2020 at 10:01 PM Norbert Slusarek <nslusarek@gmx.net> wrote:
> >
> > From: Norbert Slusarek <nslusarek@gmx.net>
> > Date: Mon, 23 Nov 2020 21:53:41 +0100
> > Subject: [PATCH RESEND] misc/vmw_vmci: bail out earlier on too big queue allocation
> >
> > For the allocation of a queue pair in qp_host_alloc_queue() an arbitrary value
> > can be passed for produce_size, which can lead to miscalculation of memory we'd
> > like to allocate in one take. A warning is triggered at __alloc_pages_nodemask()
> > in mm/page_alloc.c:4737 which aborts the false allocation, but it results in a
> > VMware machine freezing for an infinite time.
> >
> > Signed-off-by: Norbert Slusarek <nslusarek@gmx.net>
>
> Thank you for sending a patch with such a detailed analysis and even
> including a test case!

Yeah agree, very good details!

>
> > diff --git a/drivers/misc/vmw_vmci/vmci_queue_pair.c b/drivers/misc/vmw_vmci/vmci_queue_pair.c
> > index c49065887e8f..997ff32475b2 100644
> > --- a/drivers/misc/vmw_vmci/vmci_queue_pair.c
> > +++ b/drivers/misc/vmw_vmci/vmci_queue_pair.c
> > @@ -526,6 +526,7 @@ static struct vmci_queue *qp_host_alloc_queue(u64 size)
> >         struct vmci_queue *queue;
> >         size_t queue_page_size;
> >         u64 num_pages;
> > +       unsigned int order;
> >         const size_t queue_size = sizeof(*queue) + sizeof(*(queue->kernel_if));
> >
> >         if (size > SIZE_MAX - PAGE_SIZE)
> > @@ -537,6 +538,10 @@ static struct vmci_queue *qp_host_alloc_queue(u64 size)
> >
> >         queue_page_size = num_pages * sizeof(*queue->kernel_if->u.h.page);
> >
> > +       order = get_order(queue_size + queue_page_size);
> > +       if (order >= MAX_ORDER)
> > +               return NULL;
> > +
> >         queue = kzalloc(queue_size + queue_page_size, GFP_KERNEL);
>
> Calling kzalloc() with that user-provided size may still not be a great
> idea, and MAX_ORDER is probably more than anyone ever needs here
> (I don't know what the interface is needed for, but usually it is).
>
> If there is a reasonable upper bound smaller than MAX_ORDER, I
> would suggest using that. It might also be helpful to use kvzalloc()/kvfree()
> in this case, which can return an arbitrary number of pages
> and suffers less from fragmentation.

I don't know well vmw_vmci, but I took a brief look, and I saw that 
there is a macro (VMCI_MAX_GUEST_QP_MEMORY) used in vmci_qpair_alloc(), 
I'm not sure if we can use the same macro, but maybe something similar.

Honestly I don't know where that limit comes from, maybe it was chosen 
as an arbitrary and reasonable value but I suggest to check if we can 
reuse the same macro here with some adjustments.
I think in some way that limit is related to the max memory that the 
host should allocate.

@Jorgen any thought?

Thanks,
Stefano

>
> Note that both kzalloc() and kvzalloc() will fail for much smaller
> sizes if the kernel is low on memory, so that might have the same
> problem.
>
>        Arnd
>

