Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8A592EC3A2
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 20:03:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726723AbhAFTDB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 14:03:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726407AbhAFTDA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 14:03:00 -0500
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD4E0C061575
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jan 2021 11:02:20 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id u26so3739458iof.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jan 2021 11:02:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M0UU3Fnq+AFDY3LyEvzo+8UIeemvleyG8FxASGXtzZk=;
        b=IJqte2brsbiUjTAqQUQIwhUXLXNmzSbuAyYTBcwfoRLDJuH5UjOHFTqsMqjS7wzZB+
         Ji0sLhgN9+cJbBPWkhgX2dxAzCxKTRZKN9sPXkbhxrPeOyI4UWoDMvp2DzSVxDiEo/Sc
         rKnK6d/p/ySoeU1FNBiF0FfpC34+1xcvYleNpVTm5MxlM9tQTYeUeSeI08YrFvA7uAQb
         jmpvoThYXuyDb+d19wJpAOYHobwgZpp6xdVW8hhbXPabz0N1Um3R7MiAKA5tAKDqCluC
         ejrtfIZg+EKBGPyTnE4N06p5NshM5kq2PflPknc2sOUZNDiNX3gvbanBNxqzl/Tx8JLB
         tkSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M0UU3Fnq+AFDY3LyEvzo+8UIeemvleyG8FxASGXtzZk=;
        b=Pbu46XMAtClTV3Fde4ccw1HjbCnOj6PipmPfU1lPQBPuaJkF1nWhpuy9qIv5NsiD7U
         ygWCaQLgpHcOZJzPWfAoO7hoTdmRqv+MyUJbCOsc8T7bLLnudR5LBCkhZG0PgpH6Jatx
         P6hNs5p/241aMb5k7ad8LkHJFYfySZLuJm7IHRJlrZyZg3JMLbAqcJ3tWhXe3jArdXlS
         7qEFGXopikvwxxYWLy1YQWjl88Wqk0pPihXopP6reDJByYijlM8R/lf/HccKpo98t6fa
         Iw42ir7rSPVunkc0zo8QBPPc8oDwu/8ZokPE1DWQ0uod7bHS6SCbZqgyGau1L5L7WSQT
         jqzg==
X-Gm-Message-State: AOAM531REujKsxKZDzCSMNu/08TPSI4xDvw10qdHl6PN5DRzUhttz/xM
        Eh0qqil7z0F9ssFZtVwOSGkX2bhpL0PxMisPTxk=
X-Google-Smtp-Source: ABdhPJwG+edIgaoxPvZl0LuFM4yyoTnhPu3VBY7ANESudQRB2S8rG/6gT8xCNFuG5VHx3Oslf/WUOA+1pU6/vpHEOjA=
X-Received: by 2002:a6b:8e41:: with SMTP id q62mr3935276iod.5.1609959739977;
 Wed, 06 Jan 2021 11:02:19 -0800 (PST)
MIME-Version: 1.0
References: <20210106035027.GA1160@open-light-1.localdomain>
In-Reply-To: <20210106035027.GA1160@open-light-1.localdomain>
From:   Alexander Duyck <alexander.duyck@gmail.com>
Date:   Wed, 6 Jan 2021 11:02:09 -0800
Message-ID: <CAKgT0Ue=hXEarqjW-h2G1fODA5UiSjHsKz3FpcyTcaTtQR4iMw@mail.gmail.com>
Subject: Re: [PATCH 4/6] hugetlb: avoid allocation failed when page reporting
 is on going
To:     Mel Gorman <mgorman@techsingularity.net>,
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
Cc:     Liang Li <liliang324@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 5, 2021 at 7:50 PM Liang Li <liliang324@gmail.com> wrote:
>
> Page reporting isolates free pages temporarily when reporting
> free pages information. It will reduce the actual free pages
> and may cause application failed for no enough available memory.
> This patch try to solve this issue, when there is no free page
> and page repoting is on going, wait until it is done.
>
> Cc: Alexander Duyck <alexander.h.duyck@linux.intel.com>

Please don't use this email address for me anymore. Either use
alexander.duyck@gmail.com or alexanderduyck@fb.com. I am getting
bounces when I reply to this thread because of the old address.

> Cc: Mel Gorman <mgorman@techsingularity.net>
> Cc: Andrea Arcangeli <aarcange@redhat.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Dave Hansen <dave.hansen@intel.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Alex Williamson <alex.williamson@redhat.com>
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Cc: Liang Li <liliang324@gmail.com>
> Signed-off-by: Liang Li <liliangleo@didiglobal.com>
> ---
>  include/linux/hugetlb.h | 2 ++
>  mm/hugetlb.c            | 9 +++++++++
>  mm/page_reporting.c     | 6 +++++-
>  3 files changed, 16 insertions(+), 1 deletion(-)
>
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index d55e6a00b3dc..73b2934ba91c 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -490,6 +490,7 @@ struct hstate {
>         unsigned long resv_huge_pages;
>         unsigned long surplus_huge_pages;
>         unsigned long nr_overcommit_huge_pages;
> +       unsigned long isolated_huge_pages;
>         struct list_head hugepage_activelist;
>         struct list_head hugepage_freelists[MAX_NUMNODES];
>         unsigned int nr_huge_pages_node[MAX_NUMNODES];
> @@ -500,6 +501,7 @@ struct hstate {
>         struct cftype cgroup_files_dfl[7];
>         struct cftype cgroup_files_legacy[9];
>  #endif
> +       struct mutex mtx_prezero;
>         char name[HSTATE_NAME_LEN];
>  };
>
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index eb533995cb49..0fccd5f96954 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -2320,6 +2320,12 @@ struct page *alloc_huge_page(struct vm_area_struct *vma,
>                 goto out_uncharge_cgroup_reservation;
>
>         spin_lock(&hugetlb_lock);
> +       while (h->free_huge_pages <= 1 && h->isolated_huge_pages) {
> +               spin_unlock(&hugetlb_lock);
> +               mutex_lock(&h->mtx_prezero);
> +               mutex_unlock(&h->mtx_prezero);
> +               spin_lock(&hugetlb_lock);
> +       }

This seems like a bad idea. It kind of defeats the whole point of
doing the page zeroing outside of the hugetlb_lock. Also it is
operating on the assumption that the only way you might get a page is
from the page zeroing logic.

With the page reporting code we wouldn't drop the count to zero. We
had checks that were going through and monitoring the watermarks and
if we started to hit the low watermark we would stop page reporting
and just assume there aren't enough pages to report. You might need to
look at doing something similar here so that you can avoid colliding
with the allocator.


>         /*
>          * glb_chg is passed to indicate whether or not a page must be taken
>          * from the global free pool (global change).  gbl_chg == 0 indicates
> @@ -3208,6 +3214,7 @@ void __init hugetlb_add_hstate(unsigned int order)
>         INIT_LIST_HEAD(&h->hugepage_activelist);
>         h->next_nid_to_alloc = first_memory_node;
>         h->next_nid_to_free = first_memory_node;
> +       mutex_init(&h->mtx_prezero);
>         snprintf(h->name, HSTATE_NAME_LEN, "hugepages-%lukB",
>                                         huge_page_size(h)/1024);
>
> @@ -5541,6 +5548,7 @@ void isolate_free_huge_page(struct page *page, struct hstate *h, int nid)
>
>         list_move(&page->lru, &h->hugepage_activelist);
>         set_page_refcounted(page);
> +       h->isolated_huge_pages++;
>  }
>
>  void putback_isolate_huge_page(struct hstate *h, struct page *page)
> @@ -5548,6 +5556,7 @@ void putback_isolate_huge_page(struct hstate *h, struct page *page)
>         int nid = page_to_nid(page);
>
>         list_move(&page->lru, &h->hugepage_freelists[nid]);
> +       h->isolated_huge_pages--;
>  }
>
>  bool isolate_huge_page(struct page *page, struct list_head *list)
> diff --git a/mm/page_reporting.c b/mm/page_reporting.c
> index cc31696225bb..99e1e688d7c1 100644
> --- a/mm/page_reporting.c
> +++ b/mm/page_reporting.c
> @@ -272,12 +272,15 @@ hugepage_reporting_process_hstate(struct page_reporting_dev_info *prdev,
>         int ret = 0, nid;
>
>         offset = max_items;
> +       mutex_lock(&h->mtx_prezero);
>         for (nid = 0; nid < MAX_NUMNODES; nid++) {
>                 ret = hugepage_reporting_cycle(prdev, h, nid, sgl, &offset,
>                                                max_items);
>
> -               if (ret < 0)
> +               if (ret < 0) {
> +                       mutex_unlock(&h->mtx_prezero);
>                         return ret;
> +               }
>         }
>
>         /* report the leftover pages before going idle */
> @@ -291,6 +294,7 @@ hugepage_reporting_process_hstate(struct page_reporting_dev_info *prdev,
>                 hugepage_reporting_drain(prdev, h, sgl, leftover, !ret);
>                 spin_unlock(&hugetlb_lock);
>         }
> +       mutex_unlock(&h->mtx_prezero);
>
>         return ret;
>  }
> --
> 2.18.2
>
>
