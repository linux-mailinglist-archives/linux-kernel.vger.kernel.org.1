Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D16FA2747D0
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 19:54:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726731AbgIVRyY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 13:54:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20815 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726654AbgIVRyW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 13:54:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600797260;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4mR3DIjZHT2KVrbWJytSPADbDcUprwbLg37SsN4WIGQ=;
        b=BT6rSdrr8vUv29t05S2Oqo2QImwLFZi39/2xRWdc/a7biNX5S5koJb3jWhTrCrhdP5/Go8
        iqRPM65Q6jUmeOF3KJFUb+nnrJNB+O7tJKy5Lo9IIBA2zA/EBgAFN/VvJaNJKsezRqKolP
        VBUzZJHhhsgZnoYh/2nCv9+xl0db2fI=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-335-xdODbkxJNGaOf8XOlGO22Q-1; Tue, 22 Sep 2020 13:54:18 -0400
X-MC-Unique: xdODbkxJNGaOf8XOlGO22Q-1
Received: by mail-qt1-f199.google.com with SMTP id b39so16800888qta.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 10:54:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4mR3DIjZHT2KVrbWJytSPADbDcUprwbLg37SsN4WIGQ=;
        b=ChP+kjMA9+Hgo5Nmcqq4JS32l6zKLcne+ge1zsv4WCXOPMtvBiEKYaeFZ40oGS79gA
         k2zW3Sa4r038Iea7i2EGxNIf/zIK8r/znXs1bGCKErCft6SzDjBMR8E6AzroJQdQCAWE
         NgKmsko8rn8XT3eLPNvXIrtuOe5od4XKBqST7t2S0oM47bHkNT+Lnjk7ELstxz24CN4P
         2tiflqs15ZqvFQaapeROnDBN9xm5VDfvqnDX4on6cEnck6P3SmwTO5bkNA1s7Bv0FOvJ
         9sp2nI47Iab0rF6rDrJN99eAeM/yGrxWsmY68hWNWVszDZEcsI2WYUg8wQFnYmrsgkNA
         wdqw==
X-Gm-Message-State: AOAM530P98PzQrNTU2zoMR6zyRCVBJ+yXPIiNg5489QIZedXe3IkyHoO
        U1kUxPaaLEa+k2WlQgXWnQBBDW4g+1wG8A4AdJZNWVu1z7nmsrxcTbtEhDCRYwbswHMbmbUkyRi
        Khb5yCV3zmfX88E3EMYqBMmFX
X-Received: by 2002:a05:620a:554:: with SMTP id o20mr1199013qko.205.1600797258004;
        Tue, 22 Sep 2020 10:54:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzEy/lYAbSGUpeZcIc5wUbh8f+DzzpFellpAvEfoWwJu5KYD0EEKMbzE+Dkq1UJuf2e0QxVXw==
X-Received: by 2002:a05:620a:554:: with SMTP id o20mr1198974qko.205.1600797257688;
        Tue, 22 Sep 2020 10:54:17 -0700 (PDT)
Received: from xz-x1 (bras-vprn-toroon474qw-lp130-11-70-53-122-15.dsl.bell.ca. [70.53.122.15])
        by smtp.gmail.com with ESMTPSA id y22sm9832354qki.33.2020.09.22.10.54.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2020 10:54:16 -0700 (PDT)
Date:   Tue, 22 Sep 2020 13:54:15 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     John Hubbard <jhubbard@nvidia.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Jan Kara <jack@suse.cz>, Michal Hocko <mhocko@suse.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Kirill Shutemov <kirill@shutemov.name>,
        Hugh Dickins <hughd@google.com>,
        Christoph Hellwig <hch@lst.de>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jann Horn <jannh@google.com>
Subject: Re: [PATCH 1/5] mm: Introduce mm_struct.has_pinned
Message-ID: <20200922175415.GI19098@xz-x1>
References: <20200921211744.24758-1-peterx@redhat.com>
 <20200921211744.24758-2-peterx@redhat.com>
 <224908c1-5d0f-8e01-baa9-94ec2374971f@nvidia.com>
 <20200922151736.GD19098@xz-x1>
 <20200922161046.GB731578@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200922161046.GB731578@ziepe.ca>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 22, 2020 at 01:10:46PM -0300, Jason Gunthorpe wrote:
> On Tue, Sep 22, 2020 at 11:17:36AM -0400, Peter Xu wrote:
> 
> > > But it's admittedly a cosmetic point, combined with my perennial fear that
> > > I'm missing something when I look at a READ_ONCE()/WRITE_ONCE() pair. :)
> > 
> > Yeah but I hope I'm using it right.. :) I used READ_ONCE/WRITE_ONCE explicitly
> > because I think they're cheaper than atomic operations, (which will, iiuc, lock
> > the bus).
> 
> It is worth thinking a bit about racing fork with
> pin_user_pages(). The desired outcome is:
> 
>   If fork wins the page is write protected, and pin_user_pages_fast()
>   will COW it.
> 
>   If pin_user_pages_fast() wins then fork must see the READ_ONCE and
>   the pin.
> 
> As get_user_pages_fast() is lockless it looks like the ordering has to
> be like this:
> 
>   pin_user_pages_fast()                   fork()
>    atomic_set(has_pinned, 1);
>    [..]
>    atomic_add(page->_refcount)
>    ordered check write protect()
>                                           ordered set write protect()
>                                           atomic_read(page->_refcount)
>                                           atomic_read(has_pinned)
> 
> Such that in all the degenerate racy cases the outcome is that both
> sides COW, never neither.
> 
> Thus I think it does have to be atomics purely from an ordering
> perspective, observing an increased _refcount requires that has_pinned
> != 0 if we are pinning.
> 
> So, to make this 100% this ordering will need to be touched up too.

Thanks for spotting this.  So something like below should work, right?

diff --git a/mm/memory.c b/mm/memory.c
index 8f3521be80ca..6591f3f33299 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -888,8 +888,8 @@ copy_one_pte(struct mm_struct *dst_mm, struct mm_struct *src_mm,
                 * Because we'll need to release the locks before doing cow,
                 * pass this work to upper layer.
                 */
-               if (READ_ONCE(src_mm->has_pinned) && wp &&
-                   page_maybe_dma_pinned(page)) {
+               if (wp && page_maybe_dma_pinned(page) &&
+                   READ_ONCE(src_mm->has_pinned)) {
                        /* We've got the page already; we're safe */
                        data->cow_old_page = page;
                        data->cow_oldpte = *src_pte;

I can also add some more comment to emphasize this.

I think the WRITE_ONCE/READ_ONCE can actually be kept, because atomic ops
should contain proper memory barriers already so the memory access orders
should be guaranteed (e.g., atomic_add() will have an implicit wmb(); rmb() for
the other side).  However maybe it's even simpler to change has_pinned into
atomic as John suggested.  Thanks,

-- 
Peter Xu

