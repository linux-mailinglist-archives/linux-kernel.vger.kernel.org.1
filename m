Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEE332F0BB8
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 05:10:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726626AbhAKEKO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jan 2021 23:10:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725824AbhAKEKO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jan 2021 23:10:14 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5423C061786
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jan 2021 20:09:33 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id o19so35897106lfo.1
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jan 2021 20:09:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JRbCTp+kxr3AXSPRV3xhg0bLNLT4VzvUn0Z63tU3D30=;
        b=QJnwhAu05K947WCTB0Tnk3GmguiIR5k6mGYtULd5JlqNPdE4lbB1qMCA4eReGXmC3m
         d1tqg6QqAG4Y6nIamu2HnPUJx9zOAx9Hd3l8G7aNIHMbL4m3wsifOzaHFetRVhxknQTP
         v6B7OB72QiMT0biubV1/5l4WnrRrfWGBXKgGVqEvZRkklWaNpo0PfAi+5VDmaDsdie07
         ris8UdI26xSbc6UI0s4j2YeDBRMkfzXXxltDjheHjG0y6FnmkN4O9gtPCRM/+gPngyBn
         lRVoePy/tKj376jnu0FyoAUfSLc9dn9676fduFrp2fiex1DnboxrJtSQBEa9pLtjgUjN
         8mNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JRbCTp+kxr3AXSPRV3xhg0bLNLT4VzvUn0Z63tU3D30=;
        b=Wy2qGlJSaCJpjBhFOmYqajjJBr0OYCnpvCUHokG8f30waqXYBxZ3DCi8xkyXh8XIJg
         pdzka9tgvA4js5pzRR/NdmoNR17FlFqpLQgwdhOnYPEo5VEtb0n667BcHzGuUbanLTaP
         7NhT/yZ1W4tS0Pqsllw7YINrVfzzZ15y6kQeLXTcCCD++nyB/XQB4xf7c3yJikku7O05
         sxg+ttFOa4TdmylWLZJ7QhMumuOaqXZLYrs3azyEMO/XgxY6XTMGjY6gR3tpAWFSCRLB
         Y8SS4ZzoTTTVrKWJ/dbGTQR8CmhjVgfL053b889PjMyvOnLSjEYUWtJUaBALoIbqpiLC
         WICA==
X-Gm-Message-State: AOAM532c2S5dW8+cyMEhDOS4nhzamxLJJNXMzSr3ZgsAsGKva3M8svBO
        3Zevb1Qwvw/UbkADHbJPob2RDPX7nbgWMIejmZ8=
X-Google-Smtp-Source: ABdhPJzT85P22DleIQr94p9kVvrqXvqylXEyf5I9JncJoK5DXk0ewk0mPOAewXiEoNljxci5XAXi2raBVt9JFQ1pICk=
X-Received: by 2002:a19:83c9:: with SMTP id f192mr6069276lfd.399.1610338172393;
 Sun, 10 Jan 2021 20:09:32 -0800 (PST)
MIME-Version: 1.0
References: <20210106034918.GA1154@open-light-1.localdomain> <3bfdbe48-5818-7470-4c3b-96e62d387fb4@oracle.com>
In-Reply-To: <3bfdbe48-5818-7470-4c3b-96e62d387fb4@oracle.com>
From:   Liang Li <liliang324@gmail.com>
Date:   Mon, 11 Jan 2021 12:09:18 +0800
Message-ID: <CA+2MQi8Z0se7AGdzyXVqMeUZkHBq8KXEGQcyKHeH256ZvHTX8w@mail.gmail.com>
Subject: Re: [PATCH 3/6] hugetlb: add free page reporting support
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
        virtualization@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 8, 2021 at 6:04 AM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>
> On 1/5/21 7:49 PM, Liang Li wrote:
> > hugetlb manages its page in hstate's free page list, not in buddy
> > system, this patch try to make it works for hugetlbfs. It canbe
> > used for memory overcommit in virtualization and hugetlb pre zero
> > out.
>
> I am not looking closely at the hugetlb changes yet.  There seem to be
> higher level questions about page reporting/etc.  Once those are sorted,
> I will be happy to take a closer look.  One quick question below.
>
> > --- a/mm/hugetlb.c
> > +++ b/mm/hugetlb.c
> > @@ -41,6 +41,7 @@
> >  #include <linux/node.h>
> >  #include <linux/userfaultfd_k.h>
> >  #include <linux/page_owner.h>
> > +#include "page_reporting.h"
> >  #include "internal.h"
> >
> >  int hugetlb_max_hstate __read_mostly;
> > @@ -1028,6 +1029,9 @@ static void enqueue_huge_page(struct hstate *h, struct page *page)
> >       list_move(&page->lru, &h->hugepage_freelists[nid]);
> >       h->free_huge_pages++;
> >       h->free_huge_pages_node[nid]++;
> > +     if (hugepage_reported(page))
> > +             __ClearPageReported(page);
> > +     hugepage_reporting_notify_free(h->order);
> >  }
> >
> >  static struct page *dequeue_huge_page_node_exact(struct hstate *h, int nid)
> > @@ -5531,6 +5535,21 @@ follow_huge_pgd(struct mm_struct *mm, unsigned long address, pgd_t *pgd, int fla
> >       return pte_page(*(pte_t *)pgd) + ((address & ~PGDIR_MASK) >> PAGE_SHIFT);
> >  }
> >
> > +void isolate_free_huge_page(struct page *page, struct hstate *h, int nid)
> > +{
> > +     VM_BUG_ON_PAGE(!PageHead(page), page);
> > +
> > +     list_move(&page->lru, &h->hugepage_activelist);
> > +     set_page_refcounted(page);
> > +}
> > +
> > +void putback_isolate_huge_page(struct hstate *h, struct page *page)
> > +{
> > +     int nid = page_to_nid(page);
> > +
> > +     list_move(&page->lru, &h->hugepage_freelists[nid]);
> > +}
>
> The above routines move pages between the free and active lists without any
> update to free page counts.  How does that work?  Will the number of entries
> on the free list get out of sync with the free_huge_pages counters?
> --
> Mike Kravetz
>
Yes. the  free_huge_pages counters will be out of sync with the free list.
There are two reasons for the above code: 1. Hide the free page reporting
to the user; 2. Simplify the logic to sync 'free_huge_pages' and
'resv_huge_pages'.  I am not sure if it will break something else.

Thanks
Liang
