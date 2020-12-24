Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EF1F2E236A
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Dec 2020 02:32:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728245AbgLXBcQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Dec 2020 20:32:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726004AbgLXBcP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 20:32:15 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29080C061794
        for <linux-kernel@vger.kernel.org>; Wed, 23 Dec 2020 17:31:35 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id s26so1565956lfc.8
        for <linux-kernel@vger.kernel.org>; Wed, 23 Dec 2020 17:31:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0ylr8xtf0vRN/65EDusgs3mZeJJKO/MAb2WdRIppjm8=;
        b=ZV8b8FbD8TZ+50o8AlHdgL2kIgkNMvx3LcjGzyZAsPuEMA5CNGfZyMP42jf59G8GcA
         tfP+6Egyecm0W5A3t3olaLiu22+SWaHeAz3DJi3oYyjuWwVOpOIOcoSxYbJHEgLDcuSS
         z5V2vCaoE0IcDE0LkHffO+li2Qr4KVhUEU09Ixf8a5qy4UQBWUVv0sr1V5GYSzQx38iV
         rp05h/UT506EY6YXwo2ppzxhkjMvFkeW/yEVhAgWa3PhzQaiX0lOt6YelYkyTj06NB2/
         gbS8IFmMhBHLxOYXDgBo9VSfQoezSICh4YRiWEz5Qx0geh5rFAr/dfK/j8NUy6xf1l7g
         mjow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0ylr8xtf0vRN/65EDusgs3mZeJJKO/MAb2WdRIppjm8=;
        b=A78pUEPPXYfnCrjFHYoVImdC5o5ERfvWJQ/T/KUob7wP76HBHUbgR1LlE0qnUwm2Qj
         qSctlW4lpd+PZ3plDowsIBMHFxqU8FIF89i5ZdPrcRs32OxtIVaMl0jyvhxOFSO70Vd4
         4vWtdiPzdLFefzrIIOkhk0Z7clJQ6JzA9BJYxsLhGJPzKUN34O30vCdMw820+kbvRFL3
         EZzPS0WgBiLd6QlFZXjpADC5Q3v2jB6RH5o37g7nTCp0vZt24eTSlw8bUSxOg7yJ8vEX
         lQZ5gI2g3AcQnJxOEr7EB3ayytjSncMC8WWk9TTZg+B5SQ7G+QHPoQQlawDKrZ244uvy
         M5cw==
X-Gm-Message-State: AOAM533qilTjHDy0q1maMPT/oOZEFnAt6qEH+0zteFocNzwTKgH/WQaM
        C+x9S2e6qO6yIfcqTzGKUehu0mRUZaqtacxUqbo=
X-Google-Smtp-Source: ABdhPJyEG+SjICWUo3m2UZWlLl0MO437nGTfmoHzp8M/Z0PaDq7bPPDKbJxvN7AIsNn5Z4VtDFOo7tJri5HZhvYInsM=
X-Received: by 2002:a19:814c:: with SMTP id c73mr11053100lfd.638.1608773493512;
 Wed, 23 Dec 2020 17:31:33 -0800 (PST)
MIME-Version: 1.0
References: <20201222074656.GA30035@open-light-1.localdomain>
 <63318bf1-21ea-7202-e060-b4b2517c684e@oracle.com> <CA+2MQi_QDnnsbMdOH5B4Hhak-CWA-Xs6PLhxoGq2f+Vv13sgyg@mail.gmail.com>
 <e9d835e1-5d7f-d0ca-bf42-1cfa64416db6@oracle.com>
In-Reply-To: <e9d835e1-5d7f-d0ca-bf42-1cfa64416db6@oracle.com>
From:   Liang Li <liliang324@gmail.com>
Date:   Thu, 24 Dec 2020 09:31:21 +0800
Message-ID: <CA+2MQi_bxnzgS+S=GqL7UCYUKqAHZ7VC_ZTHCHcfrBHPsY+9Pg@mail.gmail.com>
Subject: Re: [RFC PATCH 1/3] mm: support hugetlb free page reporting
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Alexander Duyck <alexander.duyck@gmail.com>,
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

> >>> +static int
> >>> +hugepage_reporting_cycle(struct page_reporting_dev_info *prdev,
> >>> +                      struct hstate *h, unsigned int nid,
> >>> +                      struct scatterlist *sgl, unsigned int *offset)
> >>> +{
> >>> +     struct list_head *list = &h->hugepage_freelists[nid];
> >>> +     unsigned int page_len = PAGE_SIZE << h->order;
> >>> +     struct page *page, *next;
> >>> +     long budget;
> >>> +     int ret = 0, scan_cnt = 0;
> >>> +
> >>> +     /*
> >>> +      * Perform early check, if free area is empty there is
> >>> +      * nothing to process so we can skip this free_list.
> >>> +      */
> >>> +     if (list_empty(list))
> >>> +             return ret;
> >>
> >> Do note that not all entries on the hugetlb free lists are free.  Reserved
> >> entries are also on the free list.  The actual number of free entries is
> >> 'h->free_huge_pages - h->resv_huge_pages'.
> >> Is the intention to process reserved pages as well as free pages?
> >
> > Yes, Reserved pages was treated as 'free pages'
>
> If that is true, then this code breaks hugetlb.  hugetlb code assumes that
> h->free_huge_pages is ALWAYS >= h->resv_huge_pages.  This code would break
> that assumption.  If you really want to add support for hugetlb pages, then
> you will need to take reserved pages into account.

I didn't know that. thanks!

> P.S. There might be some confusion about 'reservations' based on the
> commit message.  My comments are directed at hugetlb reservations described
> in Documentation/vm/hugetlbfs_reserv.rst.
>
> >>> +             /* Attempt to pull page from list and place in scatterlist */
> >>> +             if (*offset) {
> >>> +                     isolate_free_huge_page(page, h, nid);
> >>
> >> Once a hugetlb page is isolated, it can not be used and applications that
> >> depend on hugetlb pages can start to fail.
> >> I assume that is acceptable/expected behavior.  Correct?
> >> On some systems, hugetlb pages are a precious resource and the sysadmin
> >> carefully configures the number needed by applications.  Removing a hugetlb
> >> page (even for a very short period of time) could cause serious application
> >> failure.
> >
> > That' true, especially for 1G pages. Any suggestions?
> > Let the hugepage allocator be aware of this situation and retry ?
>
> I would hate to add that complexity to the allocator.
>
> This question is likely based on my lack of understanding of virtio-balloon
> usage and this reporting mechanism.  But, why do the hugetlb pages have to
> be 'temporarily' allocated for reporting purposes?

The link here will give your more detail about how page reporting
works, https://www.kernel.org/doc/html/latest//vm/free_page_reporting.html
the virtio-balloon driver is based on this framework and will report the
free pages information to QEMU&KVM, host can unmap the memory
region corresponding to reported free pages and reclaim the memory
for other use, it's useful for memory overcommit.
Allocated the pages 'temporarily' before reporting is necessary, it make
sure guests will not use the page when the host side unmap the region.
or it will break the guest.

Now I realized we should solve this issue first, it seems adding a lock
will help.

Thanks
