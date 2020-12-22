Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C526A2E0F26
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 21:00:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726497AbgLVUAI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 15:00:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbgLVUAH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 15:00:07 -0500
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EF19C0613D3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Dec 2020 11:59:27 -0800 (PST)
Received: by mail-il1-x133.google.com with SMTP id 75so12998496ilv.13
        for <linux-kernel@vger.kernel.org>; Tue, 22 Dec 2020 11:59:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=9Yk5leUX6PAFGO+LhAPPSBWBIhVvNWxazIiU7rcx2S0=;
        b=cvf3eceegxoOKIlNyNGq3609ubf15e6EGHlwVESKv5VMXDfKRGN5AjfJardxcGjuKn
         uV5DtdZQytkk/FVPv0IDckPrZ8nnTgxPqUopdFYY0lxRZIIyIXtGs/4tT8oS0ed3JKHZ
         ONmcmrpn41bzRsBMQNGLKMxz3L6DXfTPyznB34gDNUTMoCzXQ652GHC4ebmSWlVb0gbT
         b8KeGtWAtbDorPRJwi04QD1PookVb/YKPKKLc3txo6sjBjBvE8LExWqTB9ouG8gHk48y
         ISW3b+8CCPkQrI0HucLNmQBdvPaAuE2mCif5QbkDlet0utTAW9uqxj3d/oPNBgDs+1AO
         fYvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=9Yk5leUX6PAFGO+LhAPPSBWBIhVvNWxazIiU7rcx2S0=;
        b=BnNE5Sp9etlISt/+9R+HHouxsbNkKlgLT6ZUI1unkdjHxcPDa4wcn8aJM9xQn8f3aQ
         1aE3Qn4ObecvcxfE5Mj2me8D10J60Zaha5a18faZs0wwsmvbAl6qVaMUpAIV2sntRMEF
         0TnSqXa1JPNkAXFgsAxmWqxoocsHriYk9uQfx5Er5Y1gImjhqTJiV9zHY72531vM5uhE
         1DdOeAax77wegfsEZrZrsWJEsJGXPUFQAJEc+HVmOuEqAXWjhSVdQPAoFsM34ilLrwGK
         3D7/ScS9ugROPazsSWUBij4SkUtl/yO4hXxTgPAkREltveIrGed1/cu8BAMacZP4WbHF
         KmjA==
X-Gm-Message-State: AOAM531SRuFheSGI6e0lH5I2Gvww7REh0VVG/O7PFktnDFOQbVOmQG4R
        ff5aFCt9GxEg4ekWqqfi/auF0iJqAKj3jkK0NG4=
X-Google-Smtp-Source: ABdhPJxbKuhIzGW/BHOviA32FS8UJVrEmTBWeeFkSK0jO7zc2iHRkkH0v3kFdmJmRmRAMioHKm1/HM9X4EtKCRBUEY4=
X-Received: by 2002:a92:c682:: with SMTP id o2mr22285132ilg.97.1608667166677;
 Tue, 22 Dec 2020 11:59:26 -0800 (PST)
MIME-Version: 1.0
References: <20201222074656.GA30035@open-light-1.localdomain>
In-Reply-To: <20201222074656.GA30035@open-light-1.localdomain>
From:   Alexander Duyck <alexander.duyck@gmail.com>
Date:   Tue, 22 Dec 2020 11:59:15 -0800
Message-ID: <CAKgT0Ucs4pv0+rcPi41uNDrav0sgOmLnVaD4NNWkg7=gncidnQ@mail.gmail.com>
Subject: Re: [RFC PATCH 1/3] mm: support hugetlb free page reporting
To:     Alexander Duyck <alexander.h.duyck@linux.intel.com>,
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
        Mike Kravetz <mike.kravetz@oracle.com>,
        Liang Li <liliang324@gmail.com>, linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        virtualization@lists.linux-foundation.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 21, 2020 at 11:47 PM Liang Li <liliang.opensource@gmail.com> wrote:
>
> Free page reporting only supports buddy pages, it can't report the
> free pages reserved for hugetlbfs case. On the other hand, hugetlbfs
> is a good choice for a system with a huge amount of RAM, because it
> can help to reduce the memory management overhead and improve system
> performance.
> This patch add the support for reporting hugepages in the free list
> of hugetlb, it canbe used by virtio_balloon driver for memory
> overcommit and pre zero out free pages for speeding up memory population.
>
> Cc: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> Cc: Mel Gorman <mgorman@techsingularity.net>
> Cc: Andrea Arcangeli <aarcange@redhat.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Dave Hansen <dave.hansen@intel.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Alex Williamson <alex.williamson@redhat.com>
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: Mike Kravetz <mike.kravetz@oracle.com>
> Cc: Liang Li <liliang324@gmail.com>
> Signed-off-by: Liang Li <liliangleo@didiglobal.com>
> ---
>  include/linux/hugetlb.h        |   3 +
>  include/linux/page_reporting.h |   5 +
>  mm/hugetlb.c                   |  29 ++++
>  mm/page_reporting.c            | 287 +++++++++++++++++++++++++++++++++
>  mm/page_reporting.h            |  34 ++++
>  5 files changed, 358 insertions(+)
>
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index ebca2ef02212..a72ad25501d3 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -11,6 +11,7 @@
>  #include <linux/kref.h>
>  #include <linux/pgtable.h>
>  #include <linux/gfp.h>
> +#include <linux/page_reporting.h>
>
>  struct ctl_table;
>  struct user_struct;
> @@ -114,6 +115,8 @@ int hugetlb_treat_movable_handler(struct ctl_table *, int, void *, size_t *,
>  int hugetlb_mempolicy_sysctl_handler(struct ctl_table *, int, void *, size_t *,
>                 loff_t *);
>
> +bool isolate_free_huge_page(struct page *page, struct hstate *h, int nid);
> +void putback_isolate_huge_page(struct hstate *h, struct page *page);
>  int copy_hugetlb_page_range(struct mm_struct *, struct mm_struct *, struct vm_area_struct *);
>  long follow_hugetlb_page(struct mm_struct *, struct vm_area_struct *,
>                          struct page **, struct vm_area_struct **,
> diff --git a/include/linux/page_reporting.h b/include/linux/page_reporting.h
> index 63e1e9fbcaa2..0da3d1a6f0cc 100644
> --- a/include/linux/page_reporting.h
> +++ b/include/linux/page_reporting.h
> @@ -7,6 +7,7 @@
>
>  /* This value should always be a power of 2, see page_reporting_cycle() */
>  #define PAGE_REPORTING_CAPACITY                32
> +#define HUGEPAGE_REPORTING_CAPACITY    1
>
>  struct page_reporting_dev_info {
>         /* function that alters pages to make them "reported" */
> @@ -26,4 +27,8 @@ struct page_reporting_dev_info {
>  /* Tear-down and bring-up for page reporting devices */
>  void page_reporting_unregister(struct page_reporting_dev_info *prdev);
>  int page_reporting_register(struct page_reporting_dev_info *prdev);
> +
> +/* Tear-down and bring-up for hugepage reporting devices */
> +void hugepage_reporting_unregister(struct page_reporting_dev_info *prdev);
> +int hugepage_reporting_register(struct page_reporting_dev_info *prdev);
>  #endif /*_LINUX_PAGE_REPORTING_H */
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index cbf32d2824fd..de6ce147dfe2 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -41,6 +41,7 @@
>  #include <linux/node.h>
>  #include <linux/userfaultfd_k.h>
>  #include <linux/page_owner.h>
> +#include "page_reporting.h"
>  #include "internal.h"
>
>  int hugetlb_max_hstate __read_mostly;
> @@ -1028,6 +1029,11 @@ static void enqueue_huge_page(struct hstate *h, struct page *page)
>         list_move(&page->lru, &h->hugepage_freelists[nid]);
>         h->free_huge_pages++;
>         h->free_huge_pages_node[nid]++;
> +       if (hugepage_reported(page)) {
> +               __ClearPageReported(page);
> +               pr_info("%s, free_huge_pages=%ld\n", __func__, h->free_huge_pages);
> +       }
> +       hugepage_reporting_notify_free(h->order);
>  }
>
>  static struct page *dequeue_huge_page_node_exact(struct hstate *h, int nid)
> @@ -5531,6 +5537,29 @@ follow_huge_pgd(struct mm_struct *mm, unsigned long address, pgd_t *pgd, int fla
>         return pte_page(*(pte_t *)pgd) + ((address & ~PGDIR_MASK) >> PAGE_SHIFT);
>  }
>
> +bool isolate_free_huge_page(struct page *page, struct hstate *h, int nid)
> +{
> +       bool ret = true;
> +
> +       VM_BUG_ON_PAGE(!PageHead(page), page);
> +
> +       list_move(&page->lru, &h->hugepage_activelist);
> +       set_page_refcounted(page);
> +       h->free_huge_pages--;
> +       h->free_huge_pages_node[nid]--;
> +
> +       return ret;
> +}
> +
> +void putback_isolate_huge_page(struct hstate *h, struct page *page)
> +{
> +       int nid = page_to_nid(page);
> +       pr_info("%s, free_huge_pages=%ld\n", __func__, h->free_huge_pages);
> +       list_move(&page->lru, &h->hugepage_freelists[nid]);
> +       h->free_huge_pages++;
> +       h->free_huge_pages_node[nid]++;
> +}
> +
>  bool isolate_huge_page(struct page *page, struct list_head *list)
>  {
>         bool ret = true;
> diff --git a/mm/page_reporting.c b/mm/page_reporting.c
> index 20ec3fb1afc4..15d4b5372df8 100644
> --- a/mm/page_reporting.c
> +++ b/mm/page_reporting.c
> @@ -7,6 +7,7 @@
>  #include <linux/delay.h>
>  #include <linux/scatterlist.h>
>  #include <linux/sched.h>
> +#include <linux/hugetlb.h>
>
>  #include "page_reporting.h"
>  #include "internal.h"
> @@ -16,6 +17,10 @@ static struct page_reporting_dev_info __rcu *pr_dev_info __read_mostly;
>  int page_report_mini_order = pageblock_order;
>  unsigned long page_report_batch_size = 32 * 1024 * 1024;
>
> +static struct page_reporting_dev_info __rcu *hgpr_dev_info __read_mostly;
> +int hugepage_report_mini_order = pageblock_order;
> +unsigned long hugepage_report_batch_size = 64 * 1024 * 1024;
> +
>  enum {
>         PAGE_REPORTING_IDLE = 0,
>         PAGE_REPORTING_REQUESTED,
> @@ -67,6 +72,24 @@ void __page_reporting_notify(void)
>         rcu_read_unlock();
>  }
>
> +/* notify prdev of free hugepage reporting request */
> +void __hugepage_reporting_notify(void)
> +{
> +       struct page_reporting_dev_info *prdev;
> +
> +       /*
> +        * We use RCU to protect the pr_dev_info pointer. In almost all
> +        * cases this should be present, however in the unlikely case of
> +        * a shutdown this will be NULL and we should exit.
> +        */
> +       rcu_read_lock();
> +       prdev = rcu_dereference(hgpr_dev_info);
> +       if (likely(prdev))
> +               __page_reporting_request(prdev);
> +
> +       rcu_read_unlock();
> +}
> +
>  static void
>  page_reporting_drain(struct page_reporting_dev_info *prdev,
>                      struct scatterlist *sgl, unsigned int nents, bool reported)
> @@ -103,6 +126,213 @@ page_reporting_drain(struct page_reporting_dev_info *prdev,
>         sg_init_table(sgl, nents);
>  }
>
> +static void
> +hugepage_reporting_drain(struct page_reporting_dev_info *prdev,
> +                        struct hstate *h, struct scatterlist *sgl,
> +                        unsigned int nents, bool reported)
> +{
> +       struct scatterlist *sg = sgl;
> +
> +       /*
> +        * Drain the now reported pages back into their respective
> +        * free lists/areas. We assume at least one page is populated.
> +        */
> +       do {
> +               struct page *page = sg_page(sg);
> +
> +               putback_isolate_huge_page(h, page);
> +
> +               /* If the pages were not reported due to error skip flagging */
> +               if (!reported)
> +                       continue;
> +
> +               __SetPageReported(page);
> +       } while ((sg = sg_next(sg)));
> +
> +       /* reinitialize scatterlist now that it is empty */
> +       sg_init_table(sgl, nents);
> +}
> +
> +/*
> + * The page reporting cycle consists of 4 stages, fill, report, drain, and
> + * idle. We will cycle through the first 3 stages until we cannot obtain a
> + * full scatterlist of pages, in that case we will switch to idle.
> + */
> +static int
> +hugepage_reporting_cycle(struct page_reporting_dev_info *prdev,
> +                        struct hstate *h, unsigned int nid,
> +                        struct scatterlist *sgl, unsigned int *offset)
> +{
> +       struct list_head *list = &h->hugepage_freelists[nid];
> +       unsigned int page_len = PAGE_SIZE << h->order;
> +       struct page *page, *next;
> +       long budget;
> +       int ret = 0, scan_cnt = 0;
> +
> +       /*
> +        * Perform early check, if free area is empty there is
> +        * nothing to process so we can skip this free_list.
> +        */
> +       if (list_empty(list))
> +               return ret;
> +
> +       spin_lock_irq(&hugetlb_lock);
> +
> +       if (huge_page_order(h) > MAX_ORDER)
> +               budget = HUGEPAGE_REPORTING_CAPACITY;
> +       else
> +               budget = HUGEPAGE_REPORTING_CAPACITY * 32;

Wouldn't huge_page_order always be more than MAX_ORDER? Seems like we
don't even really need budget since this should probably be pulling
out no more than one hugepage at a time.


> +       /* loop through free list adding unreported pages to sg list */
> +       list_for_each_entry_safe(page, next, list, lru) {
> +               /* We are going to skip over the reported pages. */
> +               if (PageReported(page)) {
> +                       if (++scan_cnt >= MAX_SCAN_NUM) {
> +                               ret = scan_cnt;
> +                               break;
> +                       }
> +                       continue;
> +               }
> +

It would probably have been better to place this set before your new
set. I don't see your new set necessarily being the best use for page
reporting.

> +               /*
> +                * If we fully consumed our budget then update our
> +                * state to indicate that we are requesting additional
> +                * processing and exit this list.
> +                */
> +               if (budget < 0) {
> +                       atomic_set(&prdev->state, PAGE_REPORTING_REQUESTED);
> +                       next = page;
> +                       break;
> +               }
> +

If budget is only ever going to be 1 then we probably could just look
at making this the default case for any time we find a non-reported
page.

> +               /* Attempt to pull page from list and place in scatterlist */
> +               if (*offset) {
> +                       isolate_free_huge_page(page, h, nid);
> +                       /* Add page to scatter list */
> +                       --(*offset);
> +                       sg_set_page(&sgl[*offset], page, page_len, 0);
> +
> +                       continue;
> +               }
> +

There is no point in the continue case if we only have a budget of 1.
We should probably just tighten up the loop so that all it does is
search until it finds the 1 page it can pull, pull it, and then return
it. The scatterlist doesn't serve much purpose and could be reduced to
just a single entry.

> +               /*
> +                * Make the first non-processed page in the free list
> +                * the new head of the free list before we release the
> +                * zone lock.
> +                */
> +               if (&page->lru != list && !list_is_first(&page->lru, list))
> +                       list_rotate_to_front(&page->lru, list);
> +
> +               /* release lock before waiting on report processing */
> +               spin_unlock_irq(&hugetlb_lock);
> +
> +               /* begin processing pages in local list */
> +               ret = prdev->report(prdev, sgl, HUGEPAGE_REPORTING_CAPACITY);
> +
> +               /* reset offset since the full list was reported */
> +               *offset = HUGEPAGE_REPORTING_CAPACITY;
> +
> +               /* update budget to reflect call to report function */
> +               budget--;
> +
> +               /* reacquire zone lock and resume processing */
> +               spin_lock_irq(&hugetlb_lock);
> +
> +               /* flush reported pages from the sg list */
> +               hugepage_reporting_drain(prdev, h, sgl,
> +                                        HUGEPAGE_REPORTING_CAPACITY, !ret);
> +
> +               /*
> +                * Reset next to first entry, the old next isn't valid
> +                * since we dropped the lock to report the pages
> +                */
> +               next = list_first_entry(list, struct page, lru);
> +
> +               /* exit on error */
> +               if (ret)
> +                       break;
> +       }
> +
> +       /* Rotate any leftover pages to the head of the freelist */
> +       if (&next->lru != list && !list_is_first(&next->lru, list))
> +               list_rotate_to_front(&next->lru, list);
> +
> +       spin_unlock_irq(&hugetlb_lock);
> +
> +       return ret;
> +}
> +
> +static int
> +hugepage_reporting_process_hstate(struct page_reporting_dev_info *prdev,
> +                           struct scatterlist *sgl, struct hstate *h)
> +{
> +       unsigned int leftover, offset = HUGEPAGE_REPORTING_CAPACITY;
> +       int ret = 0, nid;
> +
> +       for (nid = 0; nid < MAX_NUMNODES; nid++) {
> +               ret = hugepage_reporting_cycle(prdev, h, nid, sgl, &offset);
> +
> +               if (ret < 0)
> +                       return ret;
> +       }
> +
> +       /* report the leftover pages before going idle */
> +       leftover = HUGEPAGE_REPORTING_CAPACITY - offset;
> +       if (leftover) {
> +               sgl = &sgl[offset];
> +               ret = prdev->report(prdev, sgl, leftover);
> +
> +               /* flush any remaining pages out from the last report */
> +               spin_lock_irq(&hugetlb_lock);
> +               hugepage_reporting_drain(prdev, h, sgl, leftover, !ret);
> +               spin_unlock_irq(&hugetlb_lock);
> +       }
> +
> +       return ret;
> +}
> +

If HUGEPAGE_REPORTING_CAPACITY is 1 it would make more sense to
rewrite this code to just optimize for a find and process a page
approach rather than trying to batch pages.

> +static void hugepage_reporting_process(struct work_struct *work)
> +{
> +       struct delayed_work *d_work = to_delayed_work(work);
> +       struct page_reporting_dev_info *prdev = container_of(d_work,
> +                                       struct page_reporting_dev_info, work);
> +       int err = 0, state = PAGE_REPORTING_ACTIVE;
> +       struct scatterlist *sgl;
> +       struct hstate *h;
> +
> +       /*
> +        * Change the state to "Active" so that we can track if there is
> +        * anyone requests page reporting after we complete our pass. If
> +        * the state is not altered by the end of the pass we will switch
> +        * to idle and quit scheduling reporting runs.
> +        */
> +       atomic_set(&prdev->state, state);
> +
> +       /* allocate scatterlist to store pages being reported on */
> +       sgl = kmalloc_array(HUGEPAGE_REPORTING_CAPACITY, sizeof(*sgl), GFP_KERNEL);
> +       if (!sgl)
> +               goto err_out;
> +
> +       sg_init_table(sgl, HUGEPAGE_REPORTING_CAPACITY);
> +
> +       for_each_hstate(h) {
> +               err = hugepage_reporting_process_hstate(prdev, sgl, h);
> +               if (err)
> +                       break;
> +       }
> +
> +       kfree(sgl);
> +err_out:
> +       /*
> +        * If the state has reverted back to requested then there may be
> +        * additional pages to be processed. We will defer for 2s to allow
> +        * more pages to accumulate.
> +        */
> +       state = atomic_cmpxchg(&prdev->state, state, PAGE_REPORTING_IDLE);
> +       if (state == PAGE_REPORTING_REQUESTED)
> +               schedule_delayed_work(&prdev->work, prdev->delay_jiffies);
> +}
> +
>  /*
>   * The page reporting cycle consists of 4 stages, fill, report, drain, and
>   * idle. We will cycle through the first 3 stages until we cannot obtain a
> @@ -341,6 +571,9 @@ static void page_reporting_process(struct work_struct *work)
>  static DEFINE_MUTEX(page_reporting_mutex);
>  DEFINE_STATIC_KEY_FALSE(page_reporting_enabled);
>
> +static DEFINE_MUTEX(hugepage_reporting_mutex);
> +DEFINE_STATIC_KEY_FALSE(hugepage_reporting_enabled);
> +
>  int page_reporting_register(struct page_reporting_dev_info *prdev)
>  {
>         int err = 0;
> @@ -395,3 +628,57 @@ void page_reporting_unregister(struct page_reporting_dev_info *prdev)
>         mutex_unlock(&page_reporting_mutex);
>  }
>  EXPORT_SYMBOL_GPL(page_reporting_unregister);
> +
> +int hugepage_reporting_register(struct page_reporting_dev_info *prdev)
> +{
> +       int err = 0;
> +
> +       mutex_lock(&hugepage_reporting_mutex);
> +
> +       /* nothing to do if already in use */
> +       if (rcu_access_pointer(hgpr_dev_info)) {
> +               err = -EBUSY;
> +               goto err_out;
> +       }
> +
> +       /* initialize state and work structures */
> +       atomic_set(&prdev->state, PAGE_REPORTING_IDLE);
> +       INIT_DELAYED_WORK(&prdev->work, &hugepage_reporting_process);
> +
> +       /* Begin initial flush of zones */
> +       __page_reporting_request(prdev);
> +
> +       /* Assign device to allow notifications */
> +       rcu_assign_pointer(hgpr_dev_info, prdev);
> +
> +       hugepage_report_mini_order = prdev->mini_order;
> +       hugepage_report_batch_size = prdev->batch_size;
> +
> +       /* enable hugepage reporting notification */
> +       if (!static_key_enabled(&hugepage_reporting_enabled)) {
> +               static_branch_enable(&hugepage_reporting_enabled);
> +               pr_info("Free hugepage reporting enabled\n");
> +       }
> +err_out:
> +       mutex_unlock(&hugepage_reporting_mutex);
> +
> +       return err;
> +}
> +EXPORT_SYMBOL_GPL(hugepage_reporting_register);
> +
> +void hugepage_reporting_unregister(struct page_reporting_dev_info *prdev)
> +{
> +       mutex_lock(&hugepage_reporting_mutex);
> +
> +       if (rcu_access_pointer(hgpr_dev_info) == prdev) {
> +               /* Disable page reporting notification */
> +               RCU_INIT_POINTER(hgpr_dev_info, NULL);
> +               synchronize_rcu();
> +
> +               /* Flush any existing work, and lock it out */
> +               cancel_delayed_work_sync(&prdev->work);
> +       }
> +
> +       mutex_unlock(&hugepage_reporting_mutex);
> +}
> +EXPORT_SYMBOL_GPL(hugepage_reporting_unregister);
> diff --git a/mm/page_reporting.h b/mm/page_reporting.h
> index 86ac6ffad970..271c64c3c3cb 100644
> --- a/mm/page_reporting.h
> +++ b/mm/page_reporting.h
> @@ -18,12 +18,24 @@ extern unsigned long page_report_batch_size;
>  DECLARE_STATIC_KEY_FALSE(page_reporting_enabled);
>  void __page_reporting_notify(void);
>
> +extern int hugepage_report_mini_order;
> +extern unsigned long hugepage_report_batch_size;
> +
> +DECLARE_STATIC_KEY_FALSE(hugepage_reporting_enabled);
> +void __hugepage_reporting_notify(void);
> +
>  static inline bool page_reported(struct page *page)
>  {
>         return static_branch_unlikely(&page_reporting_enabled) &&
>                PageReported(page);
>  }
>
> +static inline bool hugepage_reported(struct page *page)
> +{
> +       return static_branch_unlikely(&hugepage_reporting_enabled) &&
> +              PageReported(page);
> +}
> +
>  /**
>   * page_reporting_notify_free - Free page notification to start page processing
>   *
> @@ -52,11 +64,33 @@ static inline void page_reporting_notify_free(unsigned int order)
>                 __page_reporting_notify();
>         }
>  }
> +
> +static inline void hugepage_reporting_notify_free(unsigned int order)
> +{
> +       static long batch_size = 0;
> +
> +       if (!static_branch_unlikely(&hugepage_reporting_enabled))
> +               return;
> +
> +       /* Determine if we have crossed reporting threshold */
> +       if (order < hugepage_report_mini_order)
> +               return;
> +
> +       batch_size += (1 << order) << PAGE_SHIFT;
> +       if (batch_size >= hugepage_report_batch_size) {
> +               batch_size = 0;
> +               __hugepage_reporting_notify();
> +       }
> +}
>  #else /* CONFIG_PAGE_REPORTING */
>  #define page_reported(_page)   false
>
>  static inline void page_reporting_notify_free(unsigned int order)
>  {
>  }
> +
> +static inline void hugepage_reporting_notify_free(unsigned int order)
> +{
> +}
>  #endif /* CONFIG_PAGE_REPORTING */
>  #endif /*_MM_PAGE_REPORTING_H */
> --
> 2.18.2
>
>
