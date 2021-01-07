Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 030FA2ED627
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 18:57:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728997AbhAGR5N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 12:57:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727058AbhAGR5M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 12:57:12 -0500
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 342D5C0612F4
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jan 2021 09:56:30 -0800 (PST)
Received: by mail-il1-x134.google.com with SMTP id q1so7570435ilt.6
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jan 2021 09:56:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gIcTJnmCObWJEcPsEVSzZEbUrwSNec8NhE63eBq7ZSM=;
        b=Q2YrzMgiAxkXvm9SqzdMmHt/P1Q3M9VnclkYPlj3KXvMS/VdYP3gLVH9iWfi/tPfJW
         1ohVoytOusKvdsnudhL748xmMxKTx7YBk99jXoeatAdd9FHMFLFk5l7g/TM/KY5snEdF
         l0/qgeWJoRyUQi7Wty/0E0ufwlC4/2sLCis8IhzGwT2j7BZDIcWT6iHKVxizOccE+bDH
         0BdkWOCmUK0CbbhAzv5C6fAenYzSxPe0C3EOIadGWdvl7ABNS/xyzeo8KoUZvz0EaVSK
         5jry93pSQujT1YsqNOeVAY/9W0IB0TYiJtUYwE9AwMoa/JUCLLa7heo9RtcVDBm4m5kE
         mbeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gIcTJnmCObWJEcPsEVSzZEbUrwSNec8NhE63eBq7ZSM=;
        b=C5QIyzfWCFth5J8fH+0B0pATaMMIf9vpmKmv4F1N3JXgqQhwjIuUuI5kgL7wwkzvpg
         cHgBfBcPcd9lpGoIphIoQ5x1+N0feR5uztFSyEjMpGSDDt257pmjjhfsbls1i0jMvW3a
         OfYwUQYD2dmo5Qz7qOk0bERa3HPqVbBJCvoKqSIvGPNobNf/YmGtI0Dksu72nGsxrMkW
         +TvkxabfBCdtdK1qxccjEMgtp6551odPz8yF4SWBbeohHMCpzpc5i6vLxnOyK4Gpygjd
         iZc/boYO0C2NIg4IslgR6DOkShWJt7pZ7K243K0q84oLOrpjES/KR6ykNQdB0JnM+Jo0
         qKYw==
X-Gm-Message-State: AOAM531egBQ3Nl4h5QYEfir8H5yIvUvyAeVgy8bOoTLJw2DS4FBQbZGL
        e9k2aaQv/u6g57oHUQXqqPitbSC2PxsTlbCSYgF6usb6+E8=
X-Google-Smtp-Source: ABdhPJzpGidOJI6I9ogzE3vbvyp2WNvFouko1ksIuIDvXVu11Iivfx97nwvbu3D+KbJDypKndB70eA+Nz4JBOgdYGZM=
X-Received: by 2002:a92:d592:: with SMTP id a18mr57802iln.64.1610042189444;
 Thu, 07 Jan 2021 09:56:29 -0800 (PST)
MIME-Version: 1.0
References: <20210106035027.GA1160@open-light-1.localdomain>
 <CAKgT0Ue=hXEarqjW-h2G1fODA5UiSjHsKz3FpcyTcaTtQR4iMw@mail.gmail.com> <CA+2MQi9MxE_DWW3BHLJbvYDsOppCmfL6AHkdRwtHX0gBDpDebA@mail.gmail.com>
In-Reply-To: <CA+2MQi9MxE_DWW3BHLJbvYDsOppCmfL6AHkdRwtHX0gBDpDebA@mail.gmail.com>
From:   Alexander Duyck <alexander.duyck@gmail.com>
Date:   Thu, 7 Jan 2021 09:56:18 -0800
Message-ID: <CAKgT0UfQUgZvsw6iQOFuFCGSt1SoU5ij4nC7tsUwbvf4C_0fnA@mail.gmail.com>
Subject: Re: [PATCH 4/6] hugetlb: avoid allocation failed when page reporting
 is on going
To:     Liang Li <liliang324@gmail.com>
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

On Wed, Jan 6, 2021 at 7:57 PM Liang Li <liliang324@gmail.com> wrote:
>
> > > Page reporting isolates free pages temporarily when reporting
> > > free pages information. It will reduce the actual free pages
> > > and may cause application failed for no enough available memory.
> > > This patch try to solve this issue, when there is no free page
> > > and page repoting is on going, wait until it is done.
> > >
> > > Cc: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> >
> > Please don't use this email address for me anymore. Either use
> > alexander.duyck@gmail.com or alexanderduyck@fb.com. I am getting
> > bounces when I reply to this thread because of the old address.
>
> No problem.
>
> > > diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> > > index eb533995cb49..0fccd5f96954 100644
> > > --- a/mm/hugetlb.c
> > > +++ b/mm/hugetlb.c
> > > @@ -2320,6 +2320,12 @@ struct page *alloc_huge_page(struct vm_area_struct *vma,
> > >                 goto out_uncharge_cgroup_reservation;
> > >
> > >         spin_lock(&hugetlb_lock);
> > > +       while (h->free_huge_pages <= 1 && h->isolated_huge_pages) {
> > > +               spin_unlock(&hugetlb_lock);
> > > +               mutex_lock(&h->mtx_prezero);
> > > +               mutex_unlock(&h->mtx_prezero);
> > > +               spin_lock(&hugetlb_lock);
> > > +       }
> >
> > This seems like a bad idea. It kind of defeats the whole point of
> > doing the page zeroing outside of the hugetlb_lock. Also it is
> > operating on the assumption that the only way you might get a page is
> > from the page zeroing logic.
> >
> > With the page reporting code we wouldn't drop the count to zero. We
> > had checks that were going through and monitoring the watermarks and
> > if we started to hit the low watermark we would stop page reporting
> > and just assume there aren't enough pages to report. You might need to
> > look at doing something similar here so that you can avoid colliding
> > with the allocator.
>
> For hugetlb, things are a little different, Just like Mike points out:
>      "On some systems, hugetlb pages are a precious resource and
>       the sysadmin carefully configures the number needed by
>       applications.  Removing a hugetlb page (even for a very short
>       period of time) could cause serious application failure."
>
> Just keeping some pages in the freelist is not enough to prevent that from
> happening, because these pages may be allocated while zero out is on
> going, and application may still run into a situation for not available free
> pages.

I get what you are saying. However I don't know if it is acceptable
for the allocating thread to be put to sleep in this situation. There
are two scenarios where I can see this being problematic.

One is a setup where you put the page allocator to sleep and while it
is sleeping another thread is then freeing a page and your thread
cannot respond to that newly freed page and is stuck waiting on the
zeroed page.

The second issue is that users may want a different option of just
breaking up the request into smaller pages rather than waiting on the
page zeroing, or to do something else while waiting on the page. So
instead of sitting on the request and waiting it might make more sense
to return an error pointer like EAGAIN or EBUSY to indicate that there
is a page there, but it is momentarily tied up.
