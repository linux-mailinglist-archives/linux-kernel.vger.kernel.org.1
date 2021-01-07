Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C290F2EC91B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 04:31:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726771AbhAGDaS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 22:30:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726326AbhAGDaR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 22:30:17 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 591AEC0612F0
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jan 2021 19:29:37 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id s26so11395041lfc.8
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jan 2021 19:29:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=67gzgMad2skc1/SGymVxxTd69u2O0I4adnxIqqBXpBk=;
        b=Iab1xh5YDex6NeMo0jSanWjTZkGUrSHm5FNKTIqGn87sEdm5HChnPAsV86glkoBGh7
         yp2f3aKrhqlJeFEajcKLM6nuMtdirwokft4gWA+EjiYf/NtGaoLKknAD6OyR6o+uMyEI
         ZwszVCqL+m1i1ys1WEt8NgE1LnsGLSdWqN4k8Cf/f/KhzsuHfmqX18oBA4VlVyVR8eKs
         P5BQ7BblI1lFcs9WwiKU5yM18uz2EGcRkdnuURNGLaFoq9BVtPNSpagbzV2ZkoBl5NX0
         slCI+JG4EKkYc3Pepu8NIbmGQDD40lzdFvbr9hJVL7xUTsldRyjOi0mjpXWDHSQA4/gS
         54Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=67gzgMad2skc1/SGymVxxTd69u2O0I4adnxIqqBXpBk=;
        b=hYHMypxktb1fGUkgf5Dp+e6qlS5Hj8Dj35AWWYdFGEWEpt3fP5ltyC3VF3km6ctlv/
         obN7xcBDJQveb/U/WnpgNxlUGddshOqNAJChTga4Xh+xrSXE8joJp3knLd6BI1jWCBfC
         dBSqsLTz8yuplHsOQ3Yk2WsxgH36uCdcxpv7zkU6NBS/G6IJhPWS7N7GMFY04Ze8tzwi
         JIxZmfd9fF5sYYhqmlFfN7gPaZlgYnYjps4XEV6jtQCMz4rfC1PxBkj1pfnxzfxUPvHJ
         ZjtZjmS3cAvaRQRNlF+4fuyAlrEcYfpPLR/npL5oOpSmpb9lTyaKu2mKoF6wPwc3LRPO
         yWZQ==
X-Gm-Message-State: AOAM530fWA5WmWfV5HQ54L50bMls8t2Md1Fwf9XE3Qfd2UxZzLqhavpm
        /Xzhemn167Za4bbQ54rTGNixzu9Lpk/+OJqWm7A=
X-Google-Smtp-Source: ABdhPJyHS3QC+4obdLCpe4zevaRNhFS19Ou7PmVG1j9dhtYp6TUL8HCz7XBtLdeHtIp3qfkNrj23Wbw3aLJnC7nLZGg=
X-Received: by 2002:a19:814c:: with SMTP id c73mr2886142lfd.638.1609990175893;
 Wed, 06 Jan 2021 19:29:35 -0800 (PST)
MIME-Version: 1.0
References: <20210106034806.GA1146@open-light-1.localdomain> <CAKgT0UffrUeLm0VFxW5S3rOqQit4vEPhmnEW17nGtA7yy5M3ow@mail.gmail.com>
In-Reply-To: <CAKgT0UffrUeLm0VFxW5S3rOqQit4vEPhmnEW17nGtA7yy5M3ow@mail.gmail.com>
From:   Liang Li <liliang324@gmail.com>
Date:   Thu, 7 Jan 2021 11:29:22 +0800
Message-ID: <CA+2MQi-yLWdoP0goa8ZzGGJmEJrQoO_jHN8gYS=gvKAt3JAswg@mail.gmail.com>
Subject: Re: [PATCH 2/6] mm: let user decide page reporting option
To:     Alexander Duyck <alexander.duyck@gmail.com>
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
        Mike Kravetz <mike.kravetz@oracle.com>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        virtualization@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> >  enum {
> >         PAGE_REPORTING_IDLE = 0,
> > @@ -44,7 +45,7 @@ __page_reporting_request(struct page_reporting_dev_info *prdev)
> >          * now we are limiting this to running no more than once every
> >          * couple of seconds.
> >          */
> > -       schedule_delayed_work(&prdev->work, PAGE_REPORTING_DELAY);
> > +       schedule_delayed_work(&prdev->work, prdev->delay_jiffies);
> >  }
> >
>
> So this ends up being the reason why you needed to add the batch size
> value. However I don't really see it working as expected since you
> could essentially have 1 page freed 4M times that could trigger your
> page zeroing logic. So for example if a NIC is processing frames and
> ends up freeing and then reallocating some small batch of pages this
> could would be running often even though there isn't really all that
> many pages that needed zeroing.

Good catch, it works not like batch size means.

> >  /* notify prdev of free page reporting request */
> > @@ -230,7 +231,7 @@ page_reporting_process_zone(struct page_reporting_dev_info *prdev,
> >
> >         /* Generate minimum watermark to be able to guarantee progress */
> >         watermark = low_wmark_pages(zone) +
> > -                   (PAGE_REPORTING_CAPACITY << PAGE_REPORTING_MIN_ORDER);
> > +                   (PAGE_REPORTING_CAPACITY << prdev->mini_order);
> >
> >         /*
> >          * Cancel request if insufficient free memory or if we failed
>
> With the page order being able to be greatly reduced this could have a
> significant impact on if this code really has any value. Previously we
> were able to guarantee a pretty significant number of higher order
> pages free. With this we might only be guaranteeing something like 32
> 4K pages which is pretty small compared to what can end up being
> pulled out at the higher end.

I have dropped the 'buddy free page pre zero'  patch, so the mini order will
not change to a small value.

> > @@ -240,7 +241,7 @@ page_reporting_process_zone(struct page_reporting_dev_info *prdev,
> >                 return err;
> >
> >         /* Process each free list starting from lowest order/mt */
> > -       for (order = PAGE_REPORTING_MIN_ORDER; order < MAX_ORDER; order++) {
> > +       for (order = prdev->mini_order; order < MAX_ORDER; order++) {
> >                 for (mt = 0; mt < MIGRATE_TYPES; mt++) {
> >                         /* We do not pull pages from the isolate free list */
> >                         if (is_migrate_isolate(mt))
> > @@ -307,7 +308,7 @@ static void page_reporting_process(struct work_struct *work)
> >          */
> >         state = atomic_cmpxchg(&prdev->state, state, PAGE_REPORTING_IDLE);
> >         if (state == PAGE_REPORTING_REQUESTED)
> > -               schedule_delayed_work(&prdev->work, PAGE_REPORTING_DELAY);
> > +               schedule_delayed_work(&prdev->work, prdev->delay_jiffies);
> >  }
> >
> >  static DEFINE_MUTEX(page_reporting_mutex);
> > @@ -335,6 +336,8 @@ int page_reporting_register(struct page_reporting_dev_info *prdev)
> >         /* Assign device to allow notifications */
> >         rcu_assign_pointer(pr_dev_info, prdev);
> >
> > +       page_report_mini_order = prdev->mini_order;
> > +       page_report_batch_size = prdev->batch_size;
> >         /* enable page reporting notification */
> >         if (!static_key_enabled(&page_reporting_enabled)) {
> >                 static_branch_enable(&page_reporting_enabled);
> > @@ -352,6 +355,8 @@ void page_reporting_unregister(struct page_reporting_dev_info *prdev)
> >         mutex_lock(&page_reporting_mutex);
> >
> >         if (rcu_access_pointer(pr_dev_info) == prdev) {
> > +               if (static_key_enabled(&page_reporting_enabled))
> > +                       static_branch_disable(&page_reporting_enabled);
> >                 /* Disable page reporting notification */
> >                 RCU_INIT_POINTER(pr_dev_info, NULL);
> >                 synchronize_rcu();
>
> If we are going to use this we are using it. Once we NULL out the
> prdev that should stop page reporting from running. We shouldn't be
> relying on the static key.

The benefits for this is that the function call of '__page_reporting_notify' in
'page_reporting_notify_free' can be skipped, it helps to save some
cycles.

> > diff --git a/mm/page_reporting.h b/mm/page_reporting.h
> > index b8fb3bbb345f..86ac6ffad970 100644
> > --- a/mm/page_reporting.h
> > +++ b/mm/page_reporting.h
> > @@ -9,9 +9,9 @@
> >  #include <linux/slab.h>
> >  #include <linux/pgtable.h>
> >  #include <linux/scatterlist.h>
> > +#include <linux/page_reporting.h>
> >
> > -#define PAGE_REPORTING_MIN_ORDER       pageblock_order
> > -
> > +extern int page_report_mini_order;
> >  extern unsigned long page_report_batch_size;
> >
> >  #ifdef CONFIG_PAGE_REPORTING
> > @@ -42,7 +42,7 @@ static inline void page_reporting_notify_free(unsigned int order)
> >                 return;
> >
> >         /* Determine if we have crossed reporting threshold */
> > -       if (order < PAGE_REPORTING_MIN_ORDER)
> > +       if (order < page_report_mini_order)
> >                 return;
>
> This is another case where it might make sense to look at placing the
> code in __page_reporting_notify if we are going to allow this to be a
> dynamically configurable value.

I will change it in the next revision. Thanks!

Liang
