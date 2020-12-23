Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD2B52E1F8D
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 17:41:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726540AbgLWQka (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Dec 2020 11:40:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725811AbgLWQka (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 11:40:30 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFA93C061794
        for <linux-kernel@vger.kernel.org>; Wed, 23 Dec 2020 08:39:49 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id 81so15556709ioc.13
        for <linux-kernel@vger.kernel.org>; Wed, 23 Dec 2020 08:39:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rVatYmYCMQJMPjerzko57jobHUoXj+DHRjujys0dqAg=;
        b=CMoRHJGuB1XkSbypZBbRm5Lmn/sYHKrrdSCLcYKUgSpGp/iIxUWpK7MqDlEpZGZ/ZD
         SMUgmlHBkjZAhgOYfKLrsAQQ2mMDkqHE13F3DRTjxTcGD7l658kjyqkYC81jcTfgm40h
         ngdZ8ggxsn4jQ9lLSvbc41CsNjCnD70y41Fcq+PlRGEb+3XfAxEra5cNugupWtTuptdk
         ZOJocOMNm0WBUDIT6NlQuhYN35JEon7iB0ECIKD+pwOL3niu5vO44NxBWPUa6+gdBhE6
         d31sf7OTkUeHc1/u00+DUii7nWaEIpW5kk/NmXqi4ND+8t/dRs77wgI+xsDHUWMmfyDt
         odyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rVatYmYCMQJMPjerzko57jobHUoXj+DHRjujys0dqAg=;
        b=Zse4qiTIzFrEsZ9NOc6ZfWk6YcN+6hqzNp/vT2C5kvaOxOG2SUZ2Vr89GGaGOKnjQE
         I7fpDWRnxphOjRnhzZ1HAH3Edq2Q2TgwR4FCIJOPLXjNYpOiEexSiUZfbhMYuJeqKoMs
         U2k1dX8gH00P2dvdoHntRHYoAR67aujF9GQSI1Lo5/gt2pfrnAPWdObywiRC+O9xuduM
         im0RQpHRztMTjutITvWst0vmZ/FBYaTP7m4LeMm23DfMhUDRNflCZvH3t0wHYJhJjN+D
         zDx6aNJVR74e5patE6tGnHcEDyk11D/hBCy7FQDYC1LQAhP1VOgcp2Q9+Uws/u3Ih+om
         Qh0w==
X-Gm-Message-State: AOAM531fnAwK312YVF67gthEBnhaHHWRISjNwVHfQhKyMZjjHMF4lNbW
        /Us/EN7YF+m7juxhKUjZsudtIadeY1tCwosGSz8=
X-Google-Smtp-Source: ABdhPJxyAnwmJZzZB1b22WrZzw7BIjDXYDFpaPAmxIgWuUHQ3FHGoOFNR3974ncYPlecPN6dclod2ICJWmOPjDwyEvk=
X-Received: by 2002:a02:5d85:: with SMTP id w127mr23645424jaa.83.1608741587758;
 Wed, 23 Dec 2020 08:39:47 -0800 (PST)
MIME-Version: 1.0
References: <20201222074656.GA30035@open-light-1.localdomain>
 <CAKgT0Ucs4pv0+rcPi41uNDrav0sgOmLnVaD4NNWkg7=gncidnQ@mail.gmail.com> <CA+2MQi_b98v+vS9J+FnovPe5avNv4WSeD2KoQycdQAG4c3Hxpg@mail.gmail.com>
In-Reply-To: <CA+2MQi_b98v+vS9J+FnovPe5avNv4WSeD2KoQycdQAG4c3Hxpg@mail.gmail.com>
From:   Alexander Duyck <alexander.duyck@gmail.com>
Date:   Wed, 23 Dec 2020 08:39:36 -0800
Message-ID: <CAKgT0Ue2+eV22kAt-DmsTZqRvXGdxQXa8uVEbD0cmmFP22-r5A@mail.gmail.com>
Subject: Re: [RFC PATCH 1/3] mm: support hugetlb free page reporting
To:     Liang Li <liliang324@gmail.com>
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
        virtualization@lists.linux-foundation.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 22, 2020 at 7:39 PM Liang Li <liliang324@gmail.com> wrote:
>
> > > +hugepage_reporting_cycle(struct page_reporting_dev_info *prdev,
> > > +                        struct hstate *h, unsigned int nid,
> > > +                        struct scatterlist *sgl, unsigned int *offset)
> > > +{
> > > +       struct list_head *list = &h->hugepage_freelists[nid];
> > > +       unsigned int page_len = PAGE_SIZE << h->order;
> > > +       struct page *page, *next;
> > > +       long budget;
> > > +       int ret = 0, scan_cnt = 0;
> > > +
> > > +       /*
> > > +        * Perform early check, if free area is empty there is
> > > +        * nothing to process so we can skip this free_list.
> > > +        */
> > > +       if (list_empty(list))
> > > +               return ret;
> > > +
> > > +       spin_lock_irq(&hugetlb_lock);
> > > +
> > > +       if (huge_page_order(h) > MAX_ORDER)
> > > +               budget = HUGEPAGE_REPORTING_CAPACITY;
> > > +       else
> > > +               budget = HUGEPAGE_REPORTING_CAPACITY * 32;
> >
> > Wouldn't huge_page_order always be more than MAX_ORDER? Seems like we
> > don't even really need budget since this should probably be pulling
> > out no more than one hugepage at a time.
>
> I want to disting a 2M page and 1GB page here. The order of 1GB page is greater
> than MAX_ORDER while 2M page's order is less than MAX_ORDER.

The budget here is broken. When I put the budget in page reporting it
was so that we wouldn't try to report all of the memory in a given
region. It is meant to hold us to no more than one pass through 1/16
of the free memory. So essentially we will be slowly processing all of
memory and it will take 16 calls (32 seconds) for us to process a
system that is sitting completely idle. It is meant to pace us so we
don't spend a ton of time doing work that will be undone, not to
prevent us from burying a CPU which is what seems to be implied here.

Using HUGEPAGE_REPORTING_CAPACITY makes no sense here. I was using it
in the original definition because it was how many pages we could
scoop out at a time and then I was aiming for a 16th of that. Here you
are arbitrarily squaring HUGEPAGE_REPORTING_CAPACITY in terms of the
amount of work you will doo since you are using it as a multiple
instead of a divisor.

> >
> > > +       /* loop through free list adding unreported pages to sg list */
> > > +       list_for_each_entry_safe(page, next, list, lru) {
> > > +               /* We are going to skip over the reported pages. */
> > > +               if (PageReported(page)) {
> > > +                       if (++scan_cnt >= MAX_SCAN_NUM) {
> > > +                               ret = scan_cnt;
> > > +                               break;
> > > +                       }
> > > +                       continue;
> > > +               }
> > > +
> >
> > It would probably have been better to place this set before your new
> > set. I don't see your new set necessarily being the best use for page
> > reporting.
>
> I haven't really latched on to what you mean, could you explain it again?

It would be better for you to spend time understanding how this patch
set works before you go about expanding it to do other things.
Mistakes like the budget one above kind of point out the fact that you
don't understand how this code was supposed to work and just kind of
shoehorned you page zeroing code onto it.

It would be better to look at trying to understand this code first
before you extend it to support your zeroing use case. So adding huge
pages first might make more sense than trying to zero and push the
order down. The fact is the page reporting extension should be minimal
for huge pages since they are just passed as a scatterlist so you
should only need to add a small bit to page_reporting.c to extend it
to support this use case.

> >
> > > +               /*
> > > +                * If we fully consumed our budget then update our
> > > +                * state to indicate that we are requesting additional
> > > +                * processing and exit this list.
> > > +                */
> > > +               if (budget < 0) {
> > > +                       atomic_set(&prdev->state, PAGE_REPORTING_REQUESTED);
> > > +                       next = page;
> > > +                       break;
> > > +               }
> > > +
> >
> > If budget is only ever going to be 1 then we probably could just look
> > at making this the default case for any time we find a non-reported
> > page.
>
> and here again.

It comes down to the fact that the changes you made have a significant
impact on how this is supposed to function. Reducing the scatterlist
to a size of one makes the whole point of doing batching kind of
pointless. Basically the code should be rewritten with the assumption
that if you find a page you report it.

The old code would batch things up because there is significant
overhead to be addressed when going to the hypervisor to report said
memory. Your code doesn't seem to really take anything like that into
account and instead is using an arbitrary budget value based on the
page size.

> > > +               /* Attempt to pull page from list and place in scatterlist */
> > > +               if (*offset) {
> > > +                       isolate_free_huge_page(page, h, nid);
> > > +                       /* Add page to scatter list */
> > > +                       --(*offset);
> > > +                       sg_set_page(&sgl[*offset], page, page_len, 0);
> > > +
> > > +                       continue;
> > > +               }
> > > +
> >
> > There is no point in the continue case if we only have a budget of 1.
> > We should probably just tighten up the loop so that all it does is
> > search until it finds the 1 page it can pull, pull it, and then return
> > it. The scatterlist doesn't serve much purpose and could be reduced to
> > just a single entry.
>
> I will think about it more.
>
> > > +static int
> > > +hugepage_reporting_process_hstate(struct page_reporting_dev_info *prdev,
> > > +                           struct scatterlist *sgl, struct hstate *h)
> > > +{
> > > +       unsigned int leftover, offset = HUGEPAGE_REPORTING_CAPACITY;
> > > +       int ret = 0, nid;
> > > +
> > > +       for (nid = 0; nid < MAX_NUMNODES; nid++) {
> > > +               ret = hugepage_reporting_cycle(prdev, h, nid, sgl, &offset);
> > > +
> > > +               if (ret < 0)
> > > +                       return ret;
> > > +       }
> > > +
> > > +       /* report the leftover pages before going idle */
> > > +       leftover = HUGEPAGE_REPORTING_CAPACITY - offset;
> > > +       if (leftover) {
> > > +               sgl = &sgl[offset];
> > > +               ret = prdev->report(prdev, sgl, leftover);
> > > +
> > > +               /* flush any remaining pages out from the last report */
> > > +               spin_lock_irq(&hugetlb_lock);
> > > +               hugepage_reporting_drain(prdev, h, sgl, leftover, !ret);
> > > +               spin_unlock_irq(&hugetlb_lock);
> > > +       }
> > > +
> > > +       return ret;
> > > +}
> > > +
> >
> > If HUGEPAGE_REPORTING_CAPACITY is 1 it would make more sense to
> > rewrite this code to just optimize for a find and process a page
> > approach rather than trying to batch pages.
>
> Yes, I will make a change. Thanks for your comments!

Lastly I would recommend setting up and testing page reporting with
the virtio-balloon driver. I worry that your patch set would have a
significant negative impact on the performance of it. As I mentioned
before it was designed to be more of a leaky bucket solution to
reporting memory and was supposed to take about 30 seconds for it to
flush all of the memory in a guest. Your changes seem to be trying to
do a much more aggressive task and I worry that what you are going to
find is that it will easily push CPUs to 100% on an active system
since it will be aggressively trying to zero memory as soon as it is
freed rather than taking it at a slower pace.
