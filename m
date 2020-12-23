Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F1BF2E17EE
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 04:59:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727384AbgLWD6Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 22:58:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726068AbgLWD6Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 22:58:24 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C8FDC0613D3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Dec 2020 19:57:44 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id l11so37059873lfg.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Dec 2020 19:57:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=enuHhNBx3erTv6NGu3mnW7SPnLxGpEoV7bQL4nKhqzc=;
        b=VA1JPRz3K+EPcAExLpHvImEKhTkZKKlFdfj/D85QkXAxWQfXv3NhMFQjOjsPDmbib4
         TTMVjd/41mO7CUjSZveAq8PN7jv+07omfCXAEn/XS0PEmibkdGHTIV6xMkpM4Z0vdLWr
         uMY5ZscGmuwOHcf+O7m9nVa2ImfQWUDxqypaqEdzsfBGgXdGn07TRdEwSEaMLOLgRmfK
         YkfYygjWIfGtiS2jSsvLR9myX1+K3N7TdcbfzSh2q0saW6mvepJQIRqgE/DXzXMhFwJ/
         hc/03ydcIRVUdRyKQAtqG+E+MTaVllURwLkiu8kuuM9KyNdWgBjzOKV04LHTUQDHFk+0
         jOoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=enuHhNBx3erTv6NGu3mnW7SPnLxGpEoV7bQL4nKhqzc=;
        b=iwrYihyYOIsxpkyR1Z31k/Q4g+qf28SQg++BatbAuYwcA4LhI6XeBivnuEFDewZS4X
         ga0eAz7vbc97QiPkxXeVwp0Y8JC3EHKNYaMsANiDEcLcHK2I+pBXXtTqzqBqdNVGKiVx
         3bihSD3ZOF/N36n6Gdre+ZgH71AOIDjmSIDGDQ58iDRLxmHvUgG28gQQmpDgCowiYcTD
         E+AdJeyD3WQE/stJFJDRGSNBTQ+Yb+/gNzZBGXchj8NRBD+Qajhnh5LMaJeM4T13ap/Z
         sRLhwfx9XX+K0JkjuvUpG7Ent+5uXnlCj6lbtHA3r8LM4sr2RxcRMhCVUdS93VbkSxEb
         edXQ==
X-Gm-Message-State: AOAM532vwWQbyqCSsSAdZkCIwmhiEi+QvsKjtMfav7g8Ooh8yjEurLry
        DisbG9nSGw0+d08Qe3IdewbZmTbDTJl1gBRh01w=
X-Google-Smtp-Source: ABdhPJxeb9uR35SLDkEHQkSFzjI6GJGZz5VYrcM5t1drBy2nU9D3Lmn1TDuOZuq9KEJJ3obKbiwEa4Kg14NvoKT3LmY=
X-Received: by 2002:a05:6512:1112:: with SMTP id l18mr9559659lfg.538.1608695862702;
 Tue, 22 Dec 2020 19:57:42 -0800 (PST)
MIME-Version: 1.0
References: <20201222074656.GA30035@open-light-1.localdomain> <63318bf1-21ea-7202-e060-b4b2517c684e@oracle.com>
In-Reply-To: <63318bf1-21ea-7202-e060-b4b2517c684e@oracle.com>
From:   Liang Li <liliang324@gmail.com>
Date:   Wed, 23 Dec 2020 11:57:31 +0800
Message-ID: <CA+2MQi_QDnnsbMdOH5B4Hhak-CWA-Xs6PLhxoGq2f+Vv13sgyg@mail.gmail.com>
Subject: Re: [RFC PATCH 1/3] mm: support hugetlb free page reporting
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Liang Li <liliangleo@didiglobal.com>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        virtualization@lists.linux-foundation.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On 12/21/20 11:46 PM, Liang Li wrote:
> > Free page reporting only supports buddy pages, it can't report the
> > free pages reserved for hugetlbfs case. On the other hand, hugetlbfs
> > is a good choice for a system with a huge amount of RAM, because it
> > can help to reduce the memory management overhead and improve system
> > performance.
> > This patch add the support for reporting hugepages in the free list
> > of hugetlb, it canbe used by virtio_balloon driver for memory
> > overcommit and pre zero out free pages for speeding up memory population.
>
> My apologies as I do not follow virtio_balloon driver.  Comments from
> the hugetlb perspective.

Any comments are welcome.


> >  static struct page *dequeue_huge_page_node_exact(struct hstate *h, int nid)
> > @@ -5531,6 +5537,29 @@ follow_huge_pgd(struct mm_struct *mm, unsigned long address, pgd_t *pgd, int fla
> >       return pte_page(*(pte_t *)pgd) + ((address & ~PGDIR_MASK) >> PAGE_SHIFT);
> >  }
> >
> > +bool isolate_free_huge_page(struct page *page, struct hstate *h, int nid)
>
> Looks like this always returns true.  Should it be type void?

will change in the next revision.

> > +{
> > +     bool ret = true;
> > +
> > +     VM_BUG_ON_PAGE(!PageHead(page), page);
> > +
> > +     list_move(&page->lru, &h->hugepage_activelist);
> > +     set_page_refcounted(page);
> > +     h->free_huge_pages--;
> > +     h->free_huge_pages_node[nid]--;
> > +
> > +     return ret;
> > +}
> > +
>
> ...

> > +static void
> > +hugepage_reporting_drain(struct page_reporting_dev_info *prdev,
> > +                      struct hstate *h, struct scatterlist *sgl,
> > +                      unsigned int nents, bool reported)
> > +{
> > +     struct scatterlist *sg = sgl;
> > +
> > +     /*
> > +      * Drain the now reported pages back into their respective
> > +      * free lists/areas. We assume at least one page is populated.
> > +      */
> > +     do {
> > +             struct page *page = sg_page(sg);
> > +
> > +             putback_isolate_huge_page(h, page);
> > +
> > +             /* If the pages were not reported due to error skip flagging */
> > +             if (!reported)
> > +                     continue;
> > +
> > +             __SetPageReported(page);
> > +     } while ((sg = sg_next(sg)));
> > +
> > +     /* reinitialize scatterlist now that it is empty */
> > +     sg_init_table(sgl, nents);
> > +}
> > +
> > +/*
> > + * The page reporting cycle consists of 4 stages, fill, report, drain, and
> > + * idle. We will cycle through the first 3 stages until we cannot obtain a
> > + * full scatterlist of pages, in that case we will switch to idle.
> > + */
>
> As mentioned, I am not familiar with virtio_balloon and the overall design.
> So, some of this does not make sense to me.
>
> > +static int
> > +hugepage_reporting_cycle(struct page_reporting_dev_info *prdev,
> > +                      struct hstate *h, unsigned int nid,
> > +                      struct scatterlist *sgl, unsigned int *offset)
> > +{
> > +     struct list_head *list = &h->hugepage_freelists[nid];
> > +     unsigned int page_len = PAGE_SIZE << h->order;
> > +     struct page *page, *next;
> > +     long budget;
> > +     int ret = 0, scan_cnt = 0;
> > +
> > +     /*
> > +      * Perform early check, if free area is empty there is
> > +      * nothing to process so we can skip this free_list.
> > +      */
> > +     if (list_empty(list))
> > +             return ret;
>
> Do note that not all entries on the hugetlb free lists are free.  Reserved
> entries are also on the free list.  The actual number of free entries is
> 'h->free_huge_pages - h->resv_huge_pages'.
> Is the intention to process reserved pages as well as free pages?

Yes, Reserved pages was treated as 'free pages'

> > +
> > +     spin_lock_irq(&hugetlb_lock);
> > +
> > +     if (huge_page_order(h) > MAX_ORDER)
> > +             budget = HUGEPAGE_REPORTING_CAPACITY;
> > +     else
> > +             budget = HUGEPAGE_REPORTING_CAPACITY * 32;
> > +
> > +     /* loop through free list adding unreported pages to sg list */
> > +     list_for_each_entry_safe(page, next, list, lru) {
> > +             /* We are going to skip over the reported pages. */
> > +             if (PageReported(page)) {
> > +                     if (++scan_cnt >= MAX_SCAN_NUM) {
> > +                             ret = scan_cnt;
> > +                             break;
> > +                     }
> > +                     continue;
> > +             }
> > +
> > +             /*
> > +              * If we fully consumed our budget then update our
> > +              * state to indicate that we are requesting additional
> > +              * processing and exit this list.
> > +              */
> > +             if (budget < 0) {
> > +                     atomic_set(&prdev->state, PAGE_REPORTING_REQUESTED);
> > +                     next = page;
> > +                     break;
> > +             }
> > +
> > +             /* Attempt to pull page from list and place in scatterlist */
> > +             if (*offset) {
> > +                     isolate_free_huge_page(page, h, nid);
>
> Once a hugetlb page is isolated, it can not be used and applications that
> depend on hugetlb pages can start to fail.
> I assume that is acceptable/expected behavior.  Correct?
> On some systems, hugetlb pages are a precious resource and the sysadmin
> carefully configures the number needed by applications.  Removing a hugetlb
> page (even for a very short period of time) could cause serious application
> failure.

That' true, especially for 1G pages. Any suggestions?
Let the hugepage allocator be aware of this situation and retry ?

> My apologies if that is a stupid question.  I really have no knowledge of
> this area.
>
> Mike Kravetz

Thanks for your comments, Mike

Liang

-- 
>
