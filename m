Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F40372EC355
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 19:44:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726687AbhAFSnQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 13:43:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726362AbhAFSnN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 13:43:13 -0500
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5220C06134C
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jan 2021 10:42:33 -0800 (PST)
Received: by mail-io1-xd36.google.com with SMTP id z5so3628473iob.11
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jan 2021 10:42:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LXbQyuhu8MJhuWLpzCR+mt3CN6/MAbyKTSN+t0WIyKg=;
        b=pybeZ3LJXJM520ZUF/lF5e+DMV6pDbodJA58CCMaXrvOWT5plLY3BDk1bQ9mWsRHkA
         dog0zUHHVZCTLKeYETnRnjTcjxsh5rjMh8MhP4MeuxUu7CeQRNT2+qO6nupBj+E4gDxd
         hHi58oRS9SQ+cTjV6NVNnuWf86EW8PljAr8VdQx3ZB2EKpSKRXTpb/OgR4EjFDQDyqzF
         eVt5uwZFLdvcruoeERL3XwixAfem1OQu7bPo0MXcHQ30/mzs3jVLk2mtDWmdrnGqejic
         DuOxaeRtcVYVPUqN8w1QGzTZoYgFFaoJxPs1ibjxiNqqM2BKCKwabhlCrGaorooqMeJB
         VS/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LXbQyuhu8MJhuWLpzCR+mt3CN6/MAbyKTSN+t0WIyKg=;
        b=d2ouA+V/eQU95Q4sHtdFh2VZKhRna/e8GGoVsXJoj/DN6mvbdl/2eVEuqJrd0rRTUz
         wWmph64mmGbkUwPozG4s5uL/YCwoijapjP0iV3Jc+HFD83/SQAtYtpocBMWV+xSbsWRD
         zoY4VcUtwdocKjXCyN6eHSQ+S+On+ipxedppLTEpg2e/udWT50ESVuO+piH9u81S7pdN
         bkXyLKC4D4mkUV3tRnWfoZD8+kRfI3nFlQ+b66J+v5y5Q3E73XdsW+MuuZWqNYJDP9X0
         wuQ4L7ezdcRkMsnpoUWmhmuzdr2zRzdboQdcloE/ecYB5AKSI2Yt4I4h3CXBr9tzlyqT
         hz/Q==
X-Gm-Message-State: AOAM533BZ5CpVk/V8KioGtk4GKtEXBHysUAxEqeuivWK5Zi/gUnp5t9X
        jBaUx7BvFPHYdyjjQXe8zYvbljOwftH8agRepag=
X-Google-Smtp-Source: ABdhPJyN/Evfh7mW0ZqQGsTY+XA0zAm54YpbvgTzjeZ7QhrWyhnrpWN32WMF1Veb8fQE7eCDA0PMoXG2OfLo6jzPXM0=
X-Received: by 2002:a5d:9a82:: with SMTP id c2mr3913038iom.38.1609958552867;
 Wed, 06 Jan 2021 10:42:32 -0800 (PST)
MIME-Version: 1.0
References: <20210106034806.GA1146@open-light-1.localdomain>
In-Reply-To: <20210106034806.GA1146@open-light-1.localdomain>
From:   Alexander Duyck <alexander.duyck@gmail.com>
Date:   Wed, 6 Jan 2021 10:42:21 -0800
Message-ID: <CAKgT0UffrUeLm0VFxW5S3rOqQit4vEPhmnEW17nGtA7yy5M3ow@mail.gmail.com>
Subject: Re: [PATCH 2/6] mm: let user decide page reporting option
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
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        virtualization@lists.linux-foundation.org
Cc:     Liang Li <liliang324@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 5, 2021 at 7:48 PM Liang Li <liliang324@gmail.com> wrote:
>
> Some key parameters for page reporting are now hard coded, different
> users of the framework may have their special requirements, make
> these parameter configrable and let the user decide them.
>
> Cc: Alexander Duyck <alexander.h.duyck@linux.intel.com>
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
>  drivers/virtio/virtio_balloon.c |  3 +++
>  include/linux/page_reporting.h  |  3 +++
>  mm/page_reporting.c             | 13 +++++++++----
>  mm/page_reporting.h             |  6 +++---
>  4 files changed, 18 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
> index 8985fc2cea86..684bcc39ef5a 100644
> --- a/drivers/virtio/virtio_balloon.c
> +++ b/drivers/virtio/virtio_balloon.c
> @@ -993,6 +993,9 @@ static int virtballoon_probe(struct virtio_device *vdev)
>                         goto out_unregister_oom;
>                 }
>
> +               vb->pr_dev_info.mini_order = pageblock_order;
> +               vb->pr_dev_info.batch_size = 16 * 1024 * 1024; /* 16M */
> +               vb->pr_dev_info.delay_jiffies = 2 * HZ; /* 2 seconds */
>                 err = page_reporting_register(&vb->pr_dev_info);
>                 if (err)
>                         goto out_unregister_oom;
> diff --git a/include/linux/page_reporting.h b/include/linux/page_reporting.h
> index 3b99e0ec24f2..63e1e9fbcaa2 100644
> --- a/include/linux/page_reporting.h
> +++ b/include/linux/page_reporting.h
> @@ -13,6 +13,9 @@ struct page_reporting_dev_info {
>         int (*report)(struct page_reporting_dev_info *prdev,
>                       struct scatterlist *sg, unsigned int nents);
>
> +       unsigned long batch_size;
> +       unsigned long delay_jiffies;
> +       int mini_order;
>         /* work struct for processing reports */
>         struct delayed_work work;
>
> diff --git a/mm/page_reporting.c b/mm/page_reporting.c
> index 694df981ddd2..39bc6a9d7b73 100644
> --- a/mm/page_reporting.c
> +++ b/mm/page_reporting.c
> @@ -13,6 +13,7 @@
>  #define PAGE_REPORTING_DELAY   (2 * HZ)
>  static struct page_reporting_dev_info __rcu *pr_dev_info __read_mostly;
>  unsigned long page_report_batch_size  __read_mostly = 16 * 1024 * 1024UL;
> +int page_report_mini_order = pageblock_order;
>
>  enum {
>         PAGE_REPORTING_IDLE = 0,
> @@ -44,7 +45,7 @@ __page_reporting_request(struct page_reporting_dev_info *prdev)
>          * now we are limiting this to running no more than once every
>          * couple of seconds.
>          */
> -       schedule_delayed_work(&prdev->work, PAGE_REPORTING_DELAY);
> +       schedule_delayed_work(&prdev->work, prdev->delay_jiffies);
>  }
>

So this ends up being the reason why you needed to add the batch size
value. However I don't really see it working as expected since you
could essentially have 1 page freed 4M times that could trigger your
page zeroing logic. So for example if a NIC is processing frames and
ends up freeing and then reallocating some small batch of pages this
could would be running often even though there isn't really all that
many pages that needed zeroing.

>  /* notify prdev of free page reporting request */
> @@ -230,7 +231,7 @@ page_reporting_process_zone(struct page_reporting_dev_info *prdev,
>
>         /* Generate minimum watermark to be able to guarantee progress */
>         watermark = low_wmark_pages(zone) +
> -                   (PAGE_REPORTING_CAPACITY << PAGE_REPORTING_MIN_ORDER);
> +                   (PAGE_REPORTING_CAPACITY << prdev->mini_order);
>
>         /*
>          * Cancel request if insufficient free memory or if we failed

With the page order being able to be greatly reduced this could have a
significant impact on if this code really has any value. Previously we
were able to guarantee a pretty significant number of higher order
pages free. With this we might only be guaranteeing something like 32
4K pages which is pretty small compared to what can end up being
pulled out at the higher end.

> @@ -240,7 +241,7 @@ page_reporting_process_zone(struct page_reporting_dev_info *prdev,
>                 return err;
>
>         /* Process each free list starting from lowest order/mt */
> -       for (order = PAGE_REPORTING_MIN_ORDER; order < MAX_ORDER; order++) {
> +       for (order = prdev->mini_order; order < MAX_ORDER; order++) {
>                 for (mt = 0; mt < MIGRATE_TYPES; mt++) {
>                         /* We do not pull pages from the isolate free list */
>                         if (is_migrate_isolate(mt))
> @@ -307,7 +308,7 @@ static void page_reporting_process(struct work_struct *work)
>          */
>         state = atomic_cmpxchg(&prdev->state, state, PAGE_REPORTING_IDLE);
>         if (state == PAGE_REPORTING_REQUESTED)
> -               schedule_delayed_work(&prdev->work, PAGE_REPORTING_DELAY);
> +               schedule_delayed_work(&prdev->work, prdev->delay_jiffies);
>  }
>
>  static DEFINE_MUTEX(page_reporting_mutex);
> @@ -335,6 +336,8 @@ int page_reporting_register(struct page_reporting_dev_info *prdev)
>         /* Assign device to allow notifications */
>         rcu_assign_pointer(pr_dev_info, prdev);
>
> +       page_report_mini_order = prdev->mini_order;
> +       page_report_batch_size = prdev->batch_size;
>         /* enable page reporting notification */
>         if (!static_key_enabled(&page_reporting_enabled)) {
>                 static_branch_enable(&page_reporting_enabled);
> @@ -352,6 +355,8 @@ void page_reporting_unregister(struct page_reporting_dev_info *prdev)
>         mutex_lock(&page_reporting_mutex);
>
>         if (rcu_access_pointer(pr_dev_info) == prdev) {
> +               if (static_key_enabled(&page_reporting_enabled))
> +                       static_branch_disable(&page_reporting_enabled);
>                 /* Disable page reporting notification */
>                 RCU_INIT_POINTER(pr_dev_info, NULL);
>                 synchronize_rcu();

If we are going to use this we are using it. Once we NULL out the
prdev that should stop page reporting from running. We shouldn't be
relying on the static key.

> diff --git a/mm/page_reporting.h b/mm/page_reporting.h
> index b8fb3bbb345f..86ac6ffad970 100644
> --- a/mm/page_reporting.h
> +++ b/mm/page_reporting.h
> @@ -9,9 +9,9 @@
>  #include <linux/slab.h>
>  #include <linux/pgtable.h>
>  #include <linux/scatterlist.h>
> +#include <linux/page_reporting.h>
>
> -#define PAGE_REPORTING_MIN_ORDER       pageblock_order
> -
> +extern int page_report_mini_order;
>  extern unsigned long page_report_batch_size;
>
>  #ifdef CONFIG_PAGE_REPORTING
> @@ -42,7 +42,7 @@ static inline void page_reporting_notify_free(unsigned int order)
>                 return;
>
>         /* Determine if we have crossed reporting threshold */
> -       if (order < PAGE_REPORTING_MIN_ORDER)
> +       if (order < page_report_mini_order)
>                 return;

This is another case where it might make sense to look at placing the
code in __page_reporting_notify if we are going to allow this to be a
dynamically configurable value.

>         batch_size += (1 << order) << PAGE_SHIFT;
> --
> 2.18.2
>
>
