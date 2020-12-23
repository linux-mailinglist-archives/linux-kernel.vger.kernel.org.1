Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EC842E17D1
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 04:40:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727656AbgLWDjt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 22:39:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725938AbgLWDjs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 22:39:48 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8D9EC0613D3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Dec 2020 19:39:07 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id m12so36927919lfo.7
        for <linux-kernel@vger.kernel.org>; Tue, 22 Dec 2020 19:39:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O+L5nyOzWWMqEdUIpe5JXr21QALODnzsWLxiUcKPjas=;
        b=dDs6JYxVtvejeDtqdCy8ki6p1iBg9mDU8NZZHInY3C+LMOelK3F2qW3IH1YRqmrRjW
         voieSGd4gDv9lEMtFNur1Vq9EXfuvdnu+/AAO77kG4oV9kgogGzl9kkynw+VXBTDkWT8
         fr/X6AEk1ujIjFVjwgI4d8NJ/OpP7Wzdw2xQvSdfKxVHuuBEJAMUHeKDXqJWWlDqm7mc
         apz0UZcFLtdyfZMpuYg14Kyd9qIZRsTHBzZGoquSZYmX9YPZlhopnmYPpAF7WshCx5jX
         0orYS69921A/GYVFHzhWp1OLpKc+tDkiwkbU2hnjHoAwrye1fQ/rp85UfPPXKerQ4Uqc
         Ut+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O+L5nyOzWWMqEdUIpe5JXr21QALODnzsWLxiUcKPjas=;
        b=aBB9b1F1l8+HdMD4D0nmCQjg5giCqwx9R7fK3HW0QAU9PeJQjfeAcjrVfNbRQV/vfH
         MgA/X1VoDSLmTcLeMgzI/lVBQdD25gUKZ5Y2sIQX/l/SpfFwG4V3hArvvzd97cPZnxQ5
         lzssgaeoLGAqJpikLTrizkaaZv/pmN7CcMtJUzQH+m06mGbV6w0uxk4Tfi0R1P7c6fZL
         sQ3efYB377A1JQlUCKD+OGxCA/hBc046XKS+BVQN5ZuXWbXX3Hj9mNVKR4i/M3Oz/uEf
         qdzo2+iCaSi+xIHyK4DWOvuEIPYaB0Jf1pYl8NnfdWdGJII0cPPcwdusiETCsvGP5pes
         RnYA==
X-Gm-Message-State: AOAM532CS6aP4VmNVAIl0GPUZm86Nv5AFBi0gKTgM4Etk3jSTYdc+Rk2
        JWYX2CCEG3o+bGYrTNOELerVzi5bxluveuj3CBk=
X-Google-Smtp-Source: ABdhPJymzrqQQDUgKITWsNcm3WJsGpsxFXvhUrlb5SiuxiXJIHgzuljNms0LEFw873DDo+wDJ63ogvZ4tGhx++pgMSc=
X-Received: by 2002:a05:651c:1068:: with SMTP id y8mr10587775ljm.76.1608694746482;
 Tue, 22 Dec 2020 19:39:06 -0800 (PST)
MIME-Version: 1.0
References: <20201222074656.GA30035@open-light-1.localdomain> <CAKgT0Ucs4pv0+rcPi41uNDrav0sgOmLnVaD4NNWkg7=gncidnQ@mail.gmail.com>
In-Reply-To: <CAKgT0Ucs4pv0+rcPi41uNDrav0sgOmLnVaD4NNWkg7=gncidnQ@mail.gmail.com>
From:   Liang Li <liliang324@gmail.com>
Date:   Wed, 23 Dec 2020 11:38:54 +0800
Message-ID: <CA+2MQi_b98v+vS9J+FnovPe5avNv4WSeD2KoQycdQAG4c3Hxpg@mail.gmail.com>
Subject: Re: [RFC PATCH 1/3] mm: support hugetlb free page reporting
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
        virtualization@lists.linux-foundation.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > +hugepage_reporting_cycle(struct page_reporting_dev_info *prdev,
> > +                        struct hstate *h, unsigned int nid,
> > +                        struct scatterlist *sgl, unsigned int *offset)
> > +{
> > +       struct list_head *list = &h->hugepage_freelists[nid];
> > +       unsigned int page_len = PAGE_SIZE << h->order;
> > +       struct page *page, *next;
> > +       long budget;
> > +       int ret = 0, scan_cnt = 0;
> > +
> > +       /*
> > +        * Perform early check, if free area is empty there is
> > +        * nothing to process so we can skip this free_list.
> > +        */
> > +       if (list_empty(list))
> > +               return ret;
> > +
> > +       spin_lock_irq(&hugetlb_lock);
> > +
> > +       if (huge_page_order(h) > MAX_ORDER)
> > +               budget = HUGEPAGE_REPORTING_CAPACITY;
> > +       else
> > +               budget = HUGEPAGE_REPORTING_CAPACITY * 32;
>
> Wouldn't huge_page_order always be more than MAX_ORDER? Seems like we
> don't even really need budget since this should probably be pulling
> out no more than one hugepage at a time.

I want to disting a 2M page and 1GB page here. The order of 1GB page is greater
than MAX_ORDER while 2M page's order is less than MAX_ORDER.

>
> > +       /* loop through free list adding unreported pages to sg list */
> > +       list_for_each_entry_safe(page, next, list, lru) {
> > +               /* We are going to skip over the reported pages. */
> > +               if (PageReported(page)) {
> > +                       if (++scan_cnt >= MAX_SCAN_NUM) {
> > +                               ret = scan_cnt;
> > +                               break;
> > +                       }
> > +                       continue;
> > +               }
> > +
>
> It would probably have been better to place this set before your new
> set. I don't see your new set necessarily being the best use for page
> reporting.

I haven't really latched on to what you mean, could you explain it again?

>
> > +               /*
> > +                * If we fully consumed our budget then update our
> > +                * state to indicate that we are requesting additional
> > +                * processing and exit this list.
> > +                */
> > +               if (budget < 0) {
> > +                       atomic_set(&prdev->state, PAGE_REPORTING_REQUESTED);
> > +                       next = page;
> > +                       break;
> > +               }
> > +
>
> If budget is only ever going to be 1 then we probably could just look
> at making this the default case for any time we find a non-reported
> page.

and here again.

> > +               /* Attempt to pull page from list and place in scatterlist */
> > +               if (*offset) {
> > +                       isolate_free_huge_page(page, h, nid);
> > +                       /* Add page to scatter list */
> > +                       --(*offset);
> > +                       sg_set_page(&sgl[*offset], page, page_len, 0);
> > +
> > +                       continue;
> > +               }
> > +
>
> There is no point in the continue case if we only have a budget of 1.
> We should probably just tighten up the loop so that all it does is
> search until it finds the 1 page it can pull, pull it, and then return
> it. The scatterlist doesn't serve much purpose and could be reduced to
> just a single entry.

I will think about it more.

> > +static int
> > +hugepage_reporting_process_hstate(struct page_reporting_dev_info *prdev,
> > +                           struct scatterlist *sgl, struct hstate *h)
> > +{
> > +       unsigned int leftover, offset = HUGEPAGE_REPORTING_CAPACITY;
> > +       int ret = 0, nid;
> > +
> > +       for (nid = 0; nid < MAX_NUMNODES; nid++) {
> > +               ret = hugepage_reporting_cycle(prdev, h, nid, sgl, &offset);
> > +
> > +               if (ret < 0)
> > +                       return ret;
> > +       }
> > +
> > +       /* report the leftover pages before going idle */
> > +       leftover = HUGEPAGE_REPORTING_CAPACITY - offset;
> > +       if (leftover) {
> > +               sgl = &sgl[offset];
> > +               ret = prdev->report(prdev, sgl, leftover);
> > +
> > +               /* flush any remaining pages out from the last report */
> > +               spin_lock_irq(&hugetlb_lock);
> > +               hugepage_reporting_drain(prdev, h, sgl, leftover, !ret);
> > +               spin_unlock_irq(&hugetlb_lock);
> > +       }
> > +
> > +       return ret;
> > +}
> > +
>
> If HUGEPAGE_REPORTING_CAPACITY is 1 it would make more sense to
> rewrite this code to just optimize for a find and process a page
> approach rather than trying to batch pages.

Yes, I will make a change. Thanks for your comments!

Liang
