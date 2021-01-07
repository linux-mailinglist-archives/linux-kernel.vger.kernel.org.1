Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08AC72EC93F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 04:58:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726865AbhAGD6F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 22:58:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726532AbhAGD6E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 22:58:04 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6F0CC0612F0
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jan 2021 19:57:23 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id 23so11483684lfg.10
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jan 2021 19:57:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w+mL5mz+44KVkcz4bbzbq47jBM8tSe3hNfNBeoGgiNw=;
        b=Ckx4+8H705gHnCqZ2z7zk9akrGczZLyqw3IlP0ywLHbzHT1DE2Aq6Ck5bL0yoIAInV
         16zM5VM0tyV0+9FVcKQ9EjMWAZEbd55d7xG29arO0BpB3jYEVD78+ppVqdEOlshvXI4b
         ld7QKCQAWtI8bYVBqFLpCDcjrm5vTJ81EI/4f7r5OZTGIjYjF6VCTG9NneDa3iUiLpkG
         pLnGz1w4W+Co4Z9OQxb1tBF6OS+C8ic8/+PFF7edkOlH8aWmEe/ksgez+9eicS3UmxnB
         6vE2Gn1fnXk/7nlG3r7kM1UgTaa9kwqt9p93XpSKEVg93zLfPTBZkDLkj3mp8VD/EKwj
         CjIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w+mL5mz+44KVkcz4bbzbq47jBM8tSe3hNfNBeoGgiNw=;
        b=GKyFQoUn+Yr6B81MPAIGQSivrSNdL//+m0AAhK0iAozATCZXMQvf0QhF6cMVbDLxid
         w7Z3PNtDrJc0U6ZwfZ2/aABbpu/FHE/8a9OpB1vARhXfwFUD/pBlbWynAX0gYbYhosxD
         OniXRHU2H0RgdOVFnkLXAtFzaCOhHtgGyWzCfYu9dy9i/TAyj46nfb8VsomaAPFWe0WB
         bjES4iyXJn9mFtIui3IztlqLTD7BdgXXaqiwM1ghHKrFOwC9aHLgtBBS/cojWiPNPonM
         akrDdKMl41UA3duXRNUfqwyqYj3CInwtGuN+xxelwpXvU7qqcI7ST3rn6X/FedjfNZkC
         apsQ==
X-Gm-Message-State: AOAM533q0Tvp9dHeBro+IrLWwtV1+3qJgrVzk2YcdrOuekkX+W7AC7RA
        iSuXojYOvdtTaLJGj8Q5ySTMaDFbxqVlyef9HhM=
X-Google-Smtp-Source: ABdhPJzch6I1tqMYg1Q5NOqSRoqhWuWDM8Ksmafh7GIivUfy9etpByNfzg88HMg/aQ7LX+/RBRsui/GczP8JtyCeJyA=
X-Received: by 2002:a19:83c9:: with SMTP id f192mr2976342lfd.399.1609991842495;
 Wed, 06 Jan 2021 19:57:22 -0800 (PST)
MIME-Version: 1.0
References: <20210106035027.GA1160@open-light-1.localdomain> <CAKgT0Ue=hXEarqjW-h2G1fODA5UiSjHsKz3FpcyTcaTtQR4iMw@mail.gmail.com>
In-Reply-To: <CAKgT0Ue=hXEarqjW-h2G1fODA5UiSjHsKz3FpcyTcaTtQR4iMw@mail.gmail.com>
From:   Liang Li <liliang324@gmail.com>
Date:   Thu, 7 Jan 2021 11:57:09 +0800
Message-ID: <CA+2MQi9MxE_DWW3BHLJbvYDsOppCmfL6AHkdRwtHX0gBDpDebA@mail.gmail.com>
Subject: Re: [PATCH 4/6] hugetlb: avoid allocation failed when page reporting
 is on going
To:     Alexander Duyck <alexander.duyck@gmail.com>
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Liang Li <liliangleo@didiglobal.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        virtualization@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > Page reporting isolates free pages temporarily when reporting
> > free pages information. It will reduce the actual free pages
> > and may cause application failed for no enough available memory.
> > This patch try to solve this issue, when there is no free page
> > and page repoting is on going, wait until it is done.
> >
> > Cc: Alexander Duyck <alexander.h.duyck@linux.intel.com>
>
> Please don't use this email address for me anymore. Either use
> alexander.duyck@gmail.com or alexanderduyck@fb.com. I am getting
> bounces when I reply to this thread because of the old address.

No problem.

> > diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> > index eb533995cb49..0fccd5f96954 100644
> > --- a/mm/hugetlb.c
> > +++ b/mm/hugetlb.c
> > @@ -2320,6 +2320,12 @@ struct page *alloc_huge_page(struct vm_area_struct *vma,
> >                 goto out_uncharge_cgroup_reservation;
> >
> >         spin_lock(&hugetlb_lock);
> > +       while (h->free_huge_pages <= 1 && h->isolated_huge_pages) {
> > +               spin_unlock(&hugetlb_lock);
> > +               mutex_lock(&h->mtx_prezero);
> > +               mutex_unlock(&h->mtx_prezero);
> > +               spin_lock(&hugetlb_lock);
> > +       }
>
> This seems like a bad idea. It kind of defeats the whole point of
> doing the page zeroing outside of the hugetlb_lock. Also it is
> operating on the assumption that the only way you might get a page is
> from the page zeroing logic.
>
> With the page reporting code we wouldn't drop the count to zero. We
> had checks that were going through and monitoring the watermarks and
> if we started to hit the low watermark we would stop page reporting
> and just assume there aren't enough pages to report. You might need to
> look at doing something similar here so that you can avoid colliding
> with the allocator.

For hugetlb, things are a little different, Just like Mike points out:
     "On some systems, hugetlb pages are a precious resource and
      the sysadmin carefully configures the number needed by
      applications.  Removing a hugetlb page (even for a very short
      period of time) could cause serious application failure."

Just keeping some pages in the freelist is not enough to prevent that from
happening, because these pages may be allocated while zero out is on
going, and application may still run into a situation for not available free
pages.

Thanks
Liang
