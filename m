Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30E4D2AC8C4
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 23:43:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730743AbgKIWnH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 17:43:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24494 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729493AbgKIWnH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 17:43:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604961784;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Fg7zSSuXfHaOdrJzE6K3KV6fZlH5LajqxqmYKp+iv8o=;
        b=Rtey7dYYYt1UaBqbmISTOKLz1jU12t5bmWUHhTP5wYgVqouL8J3W72j9qO2GwdKX8E/5w6
        OmEn13YLsNP23IS86Q2GkKlvKcOzoF9AVtRq4anZJtALGQu3N43rxAYpGyJMINyMi95GUJ
        LMx8Fv3jjqGoa0BtI5mUpuKNBPa8xIo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-305-T7G8FNnJOGKYVKbhCtHOMg-1; Mon, 09 Nov 2020 17:43:02 -0500
X-MC-Unique: T7G8FNnJOGKYVKbhCtHOMg-1
Received: by mail-wm1-f72.google.com with SMTP id u207so366722wmu.4
        for <linux-kernel@vger.kernel.org>; Mon, 09 Nov 2020 14:43:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Fg7zSSuXfHaOdrJzE6K3KV6fZlH5LajqxqmYKp+iv8o=;
        b=oxf68fYXiCBUbDDyLA7zj9pjpCdcE3YytEoTzyxqoVr2X7COcGC56J8AE0nt7kOf2l
         zd40Dxt0z7gkL+Fm/W0jLUk2svHzoG4akxRG1G75SJyFREDteSMCuxWsho8tPKNRAOIr
         0Orzm9YvLccygkGWnDJOr+3YdwYpgNkirEhXr4iXML4lvN32GKzI0n9ZSMbHtKt8gcLx
         L5QCZ0vD2+Kpx3vVJWk91K3NR7ocL/3sY6/HbTpoYFrjDLUUPHrO4fzJciq3uE/Sjfov
         Z1e/z7KyJ5GUv6nMIUuXOEdGRbv6EEE9n/Sof/jZbUb04DkQ+YYNR6N+iKWq//LuoFfF
         sBdw==
X-Gm-Message-State: AOAM530Wi5vflaWYj/8L3rRPPsyzKZi+jT3LTot+CP22Boqj0U4UEdrl
        IMfXAU/NRvxwK9ZrErrGNA1h6WypuJVZNU0BUUR2yaok/Ob8ZZBG9/WvG9/BseYtB8U9lMqCLyv
        n/bbBrhsS/7o5KrQ5jcNwZfjZ
X-Received: by 2002:a1c:2586:: with SMTP id l128mr1301880wml.149.1604961781719;
        Mon, 09 Nov 2020 14:43:01 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwq4ZSd62uP/XNENstVYdZIcFqG2pf7QHksn08DgXsoon1ffeXEyoptiT/kazbdFNifZSAvow==
X-Received: by 2002:a1c:2586:: with SMTP id l128mr1301856wml.149.1604961781448;
        Mon, 09 Nov 2020 14:43:01 -0800 (PST)
Received: from redhat.com (bzq-79-176-118-93.red.bezeqint.net. [79.176.118.93])
        by smtp.gmail.com with ESMTPSA id f17sm858256wmh.10.2020.11.09.14.42.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2020 14:43:00 -0800 (PST)
Date:   Mon, 9 Nov 2020 17:42:57 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     si-wei liu <si-wei.liu@oracle.com>
Cc:     Jason Wang <jasowang@redhat.com>, lingshan.zhu@intel.com,
        joao.m.martins@oracle.com, boris.ostrovsky@oracle.com,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v2] vhost-vdpa: fix page pinning leakage in error path
 (rework)
Message-ID: <20201109173236-mutt-send-email-mst@kernel.org>
References: <1604532796-12757-1-git-send-email-si-wei.liu@oracle.com>
 <dcbe4f3e-42f3-d245-9ee4-b17977ad27a5@redhat.com>
 <5FA48342.4060404@oracle.com>
 <64fb6179-c5ff-9552-381f-85b63e704057@redhat.com>
 <5FA9B823.9060609@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5FA9B823.9060609@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 09, 2020 at 01:44:03PM -0800, si-wei liu wrote:
> 
> On 11/8/2020 7:21 PM, Jason Wang wrote:
> > 
> > On 2020/11/6 上午6:57, si-wei liu wrote:
> > > 
> > > On 11/4/2020 7:26 PM, Jason Wang wrote:
> > > > 
> > > > On 2020/11/5 上午7:33, Si-Wei Liu wrote:
> > > > > Pinned pages are not properly accounted particularly when
> > > > > mapping error occurs on IOTLB update. Clean up dangling
> > > > > pinned pages for the error path.
> > > > > 
> > > > > The memory usage for bookkeeping pinned pages is reverted
> > > > > to what it was before: only one single free page is needed.
> > > > > This helps reduce the host memory demand for VM with a large
> > > > > amount of memory, or in the situation where host is running
> > > > > short of free memory.
> > > > > 
> > > > > Fixes: 4c8cf31885f6 ("vhost: introduce vDPA-based backend")
> > > > > Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
> > > > > ---
> > > > > Changes in v2:
> > > > > - Drop the reversion patch
> > > > > - Fix unhandled page leak towards the end of page_list
> > > > > 
> > > > >   drivers/vhost/vdpa.c | 79
> > > > > ++++++++++++++++++++++++++++++++++++++++------------
> > > > >   1 file changed, 61 insertions(+), 18 deletions(-)
> > > > > 
> > > > > diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> > > > > index b6d9016..e112854 100644
> > > > > --- a/drivers/vhost/vdpa.c
> > > > > +++ b/drivers/vhost/vdpa.c
> > > > > @@ -560,6 +560,8 @@ static int vhost_vdpa_map(struct vhost_vdpa *v,
> > > > >         if (r)
> > > > >           vhost_iotlb_del_range(dev->iotlb, iova, iova + size - 1);
> > > > > +    else
> > > > > +        atomic64_add(size >> PAGE_SHIFT, &dev->mm->pinned_vm);
> > > > >         return r;
> > > > >   }
> > > > > @@ -591,14 +593,16 @@ static int
> > > > > vhost_vdpa_process_iotlb_update(struct vhost_vdpa *v,
> > > > >       unsigned long list_size = PAGE_SIZE / sizeof(struct page *);
> > > > >       unsigned int gup_flags = FOLL_LONGTERM;
> > > > >       unsigned long npages, cur_base, map_pfn, last_pfn = 0;
> > > > > -    unsigned long locked, lock_limit, pinned, i;
> > > > > +    unsigned long lock_limit, sz2pin, nchunks, i;
> > > > >       u64 iova = msg->iova;
> > > > > +    long pinned;
> > > > >       int ret = 0;
> > > > >         if (vhost_iotlb_itree_first(iotlb, msg->iova,
> > > > >                       msg->iova + msg->size - 1))
> > > > >           return -EEXIST;
> > > > >   +    /* Limit the use of memory for bookkeeping */
> > > > >       page_list = (struct page **) __get_free_page(GFP_KERNEL);
> > > > >       if (!page_list)
> > > > >           return -ENOMEM;
> > > > > @@ -607,52 +611,75 @@ static int
> > > > > vhost_vdpa_process_iotlb_update(struct vhost_vdpa *v,
> > > > >           gup_flags |= FOLL_WRITE;
> > > > >         npages = PAGE_ALIGN(msg->size + (iova & ~PAGE_MASK))
> > > > > >> PAGE_SHIFT;
> > > > > -    if (!npages)
> > > > > -        return -EINVAL;
> > > > > +    if (!npages) {
> > > > > +        ret = -EINVAL;
> > > > > +        goto free;
> > > > > +    }
> > > > >         mmap_read_lock(dev->mm);
> > > > >   -    locked = atomic64_add_return(npages, &dev->mm->pinned_vm);
> > > > >       lock_limit = rlimit(RLIMIT_MEMLOCK) >> PAGE_SHIFT;
> > > > > -
> > > > > -    if (locked > lock_limit) {
> > > > > +    if (npages + atomic64_read(&dev->mm->pinned_vm) > lock_limit) {
> > > > >           ret = -ENOMEM;
> > > > > -        goto out;
> > > > > +        goto unlock;
> > > > >       }
> > > > >         cur_base = msg->uaddr & PAGE_MASK;
> > > > >       iova &= PAGE_MASK;
> > > > > +    nchunks = 0;
> > > > >         while (npages) {
> > > > > -        pinned = min_t(unsigned long, npages, list_size);
> > > > > -        ret = pin_user_pages(cur_base, pinned,
> > > > > -                     gup_flags, page_list, NULL);
> > > > > -        if (ret != pinned)
> > > > > +        sz2pin = min_t(unsigned long, npages, list_size);
> > > > > +        pinned = pin_user_pages(cur_base, sz2pin,
> > > > > +                    gup_flags, page_list, NULL);
> > > > > +        if (sz2pin != pinned) {
> > > > > +            if (pinned < 0) {
> > > > > +                ret = pinned;
> > > > > +            } else {
> > > > > +                unpin_user_pages(page_list, pinned);
> > > > > +                ret = -ENOMEM;
> > > > > +            }
> > > > >               goto out;
> > > > > +        }
> > > > > +        nchunks++;
> > > > >             if (!last_pfn)
> > > > >               map_pfn = page_to_pfn(page_list[0]);
> > > > >   -        for (i = 0; i < ret; i++) {
> > > > > +        for (i = 0; i < pinned; i++) {
> > > > >               unsigned long this_pfn = page_to_pfn(page_list[i]);
> > > > >               u64 csize;
> > > > >                 if (last_pfn && (this_pfn != last_pfn + 1)) {
> > > > >                   /* Pin a contiguous chunk of memory */
> > > > >                   csize = (last_pfn - map_pfn + 1) << PAGE_SHIFT;
> > > > > -                if (vhost_vdpa_map(v, iova, csize,
> > > > > -                           map_pfn << PAGE_SHIFT,
> > > > > -                           msg->perm))
> > > > > +                ret = vhost_vdpa_map(v, iova, csize,
> > > > > +                             map_pfn << PAGE_SHIFT,
> > > > > +                             msg->perm);
> > > > > +                if (ret) {
> > > > > +                    /*
> > > > > +                     * Unpin the pages that are left unmapped
> > > > > +                     * from this point on in the current
> > > > > +                     * page_list. The remaining outstanding
> > > > > +                     * ones which may stride across several
> > > > > +                     * chunks will be covered in the common
> > > > > +                     * error path subsequently.
> > > > > +                     */
> > > > > +                    unpin_user_pages(&page_list[i],
> > > > > +                             pinned - i);
> > > > 
> > > > 
> > > > Can we simply do last_pfn = this_pfn here?
> > > Nope. They are not contiguous segments of memory. Noted the
> > > conditional (this_pfn != last_pfn + 1) being held here.
> > 
> > 
> > Right.
> > 
> > 
> > > 
> > > > 
> > > > 
> > > > >                       goto out;
> > > > > +                }
> > > > > +
> > > > >                   map_pfn = this_pfn;
> > > > >                   iova += csize;
> > > > > +                nchunks = 0;
> > > > >               }
> > > > >                 last_pfn = this_pfn;
> > > > >           }
> > > > >   -        cur_base += ret << PAGE_SHIFT;
> > > > > -        npages -= ret;
> > > > > +        cur_base += pinned << PAGE_SHIFT;
> > > > > +        npages -= pinned;
> > > > >       }
> > > > >         /* Pin the rest chunk */
> > > > > @@ -660,10 +687,26 @@ static int
> > > > > vhost_vdpa_process_iotlb_update(struct vhost_vdpa *v,
> > > > >                    map_pfn << PAGE_SHIFT, msg->perm);
> > > > >   out:
> > > > >       if (ret) {
> > > > > +        if (nchunks && last_pfn) {
> > > > 
> > > > 
> > > > Any reason for checking last_pfn here?
> > > > 
> > > > Note that we did:
> > > > 
> > > > +        nchunks++;
> > > > 
> > > >          if (!last_pfn)
> > > >              map_pfn = page_to_pfn(page_list[0]);
> > > It's for explicit coding to make sure this common error path can be
> > > reused no matter if last_pfn has a sane value assigned or not. I can
> > > change it to an implicit WARN_ON() if need be.
> > 
> > 
> > Just to make sure I understand. A question, when will we get nchunks !=
> > 0 but last_pfn == 0?
> The current code has implicit assumption that nchunks != 0 infers last_pfn
> != 0. However, this assumption could break subject to code structure changes
> for eg. failure may occur after the increment of nchunks and before the for
> loop. I feel it'd be the best to capture this assumption with something
> explicit.
> 
> -Siwei

if here isn't really an explicit way to document assumptions,
it's a way to avoid assumptions :)
A way to document assumptions is probably BUG_ON.

> > 
> > Thanks
> > 
> > 
> > > Thanks,
> > > -Siwei
> > > 
> > > > 
> > > > 
> > > > Thanks
> > > > 
> > > > 
> > > > > +            unsigned long pfn;
> > > > > +
> > > > > +            /*
> > > > > +             * Unpin the outstanding pages which are yet to be
> > > > > +             * mapped but haven't due to vdpa_map() or
> > > > > +             * pin_user_pages() failure.
> > > > > +             *
> > > > > +             * Mapped pages are accounted in vdpa_map(), hence
> > > > > +             * the corresponding unpinning will be handled by
> > > > > +             * vdpa_unmap().
> > > > > +             */
> > > > > +            for (pfn = map_pfn; pfn <= last_pfn; pfn++)
> > > > > +                unpin_user_page(pfn_to_page(pfn));
> > > > > +        }
> > > > >           vhost_vdpa_unmap(v, msg->iova, msg->size);
> > > > > -        atomic64_sub(npages, &dev->mm->pinned_vm);
> > > > >       }
> > > > > +unlock:
> > > > >       mmap_read_unlock(dev->mm);
> > > > > +free:
> > > > >       free_page((unsigned long)page_list);
> > > > >       return ret;
> > > > >   }
> > > > 
> > > 
> > 

