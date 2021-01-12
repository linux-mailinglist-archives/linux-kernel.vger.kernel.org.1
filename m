Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C4282F2D36
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 11:51:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728493AbhALKun (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 05:50:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727740AbhALKum (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 05:50:42 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D65BC061575
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 02:50:01 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id g3so1206872plp.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 02:50:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j6hOZRhr6lM1qFIJTkdoya6lHwDoxk8ZO60XJ7q+5ys=;
        b=vi+crJBdaq2Sz6WZnM5jf9qWYETFaFFQMhnrk5Zi18ejf3zZGhiBBZXRbMhYgnIKfp
         ABV31ETb3qIp9zyDU9K02NSUcS+I0WFHCqxM2zrxmySLIN7Z11DaWiN1F4bUrhsiqDC+
         2fn7qbNzs41a03EJXq5vvBQMjpKGjjt37sddYaYrXfRTNDhTbhyAvFHk5X3PsOzgIKai
         TwEf4sDpKQrwPKnkgItUwshQD5/NYC9wGuTFcp4lgpmH+lfMFhmrDowLfv3A8DhPaCMW
         GtZnf/aLpufpLNP0UbWukc6ClsAAOAg3aGEGhoN9RNpZnUgRr1SNPyVYe0vUogWdBk4h
         W1AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j6hOZRhr6lM1qFIJTkdoya6lHwDoxk8ZO60XJ7q+5ys=;
        b=CFho9TexFt0OCC/9wVZH1dfDXaGcjXfy1FYzW4uw0bw9rxmgq/hT9HJLsnYbxdh5k7
         gs0P0QC4JEuXyYaWqoE2zwS/9UaUumsyQvNgJwHxDiiTgwC6k0XrU24SbTFMKDrmD2zF
         teuOL6i0sgM98mY8Ovk2MJwjTyFW6KtgU1GL3vPBT8s0OYOvrO0/7joL+4MAdZKRfU9h
         0DLN+zqMAWf6Xoqd1h4B1a5D05jx2c1nIFk5dw7vahCWLlR1FuQPcnrtAU2wVKGRiVWK
         QPriHA2Jaw3rPHAE7RgEoeV9Fe4p+mNJBtEvJ+yhsCkk0YtZU2CKoZ2hHEso/ewRl+0+
         1ZwQ==
X-Gm-Message-State: AOAM5332B8qCJCARAkY3DHvTYRj0/hGrWSHrijoXJ4vZBFozL8mvCLzd
        1Ig5KZtry9tEsUFuioGis1sE3srUncoilKEzvt9qBw==
X-Google-Smtp-Source: ABdhPJwYg/d8Ey5S+NTEOtv5UjN8J2XLJeVXg45ipl3li1Kcb9t0pPL0IRxxqWfrG1PuGGR9+o0w94TB7OGPxCTUoAo=
X-Received: by 2002:a17:902:8503:b029:dc:44f:62d8 with SMTP id
 bj3-20020a1709028503b02900dc044f62d8mr4197756plb.34.1610448600939; Tue, 12
 Jan 2021 02:50:00 -0800 (PST)
MIME-Version: 1.0
References: <20210110124017.86750-1-songmuchun@bytedance.com>
 <20210110124017.86750-5-songmuchun@bytedance.com> <c61cdf1d-2feb-ecb3-393d-ca25175c73f4@oracle.com>
 <20210112083335.GH22493@dhcp22.suse.cz> <CAMZfGtVCntwNM=2RHHp=qDLN3L71ouQy=9V_e=VTNHtCDHsmWA@mail.gmail.com>
 <20210112100602.GL22493@dhcp22.suse.cz>
In-Reply-To: <20210112100602.GL22493@dhcp22.suse.cz>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Tue, 12 Jan 2021 18:49:17 +0800
Message-ID: <CAMZfGtVvrMegtXhZbPxgX_6ryJGoU6B64coLkBBUe4yf0jG-9A@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v3 4/6] mm: hugetlb: add return -EAGAIN for dissolve_free_huge_page
To:     Michal Hocko <mhocko@suse.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Andi Kleen <ak@linux.intel.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 12, 2021 at 6:06 PM Michal Hocko <mhocko@suse.com> wrote:
>
> On Tue 12-01-21 17:51:05, Muchun Song wrote:
> > On Tue, Jan 12, 2021 at 4:33 PM Michal Hocko <mhocko@suse.com> wrote:
> > >
> > > On Mon 11-01-21 17:20:51, Mike Kravetz wrote:
> > > > On 1/10/21 4:40 AM, Muchun Song wrote:
> > > > > There is a race between dissolve_free_huge_page() and put_page(),
> > > > > and the race window is quite small. Theoretically, we should return
> > > > > -EBUSY when we encounter this race. In fact, we have a chance to
> > > > > successfully dissolve the page if we do a retry. Because the race
> > > > > window is quite small. If we seize this opportunity, it is an
> > > > > optimization for increasing the success rate of dissolving page.
> > > > >
> > > > > If we free a HugeTLB page from a non-task context, it is deferred
> > > > > through a workqueue. In this case, we need to flush the work.
> > > > >
> > > > > The dissolve_free_huge_page() can be called from memory hotplug,
> > > > > the caller aims to free the HugeTLB page to the buddy allocator
> > > > > so that the caller can unplug the page successfully.
> > > > >
> > > > > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > > > > ---
> > > > >  mm/hugetlb.c | 26 +++++++++++++++++++++-----
> > > > >  1 file changed, 21 insertions(+), 5 deletions(-)
> > > >
> > > > I am unsure about the need for this patch.  The code is OK, there are no
> > > > issues with the code.
> > > >
> > > > As mentioned in the commit message, this is an optimization and could
> > > > potentially cause a memory offline operation to succeed instead of fail.
> > > > However, we are very unlikely to ever exercise this code.  Adding an
> > > > optimization that is unlikely to be exercised is certainly questionable.
> > > >
> > > > Memory offline is the only code that could benefit from this optimization.
> > > > As someone with more memory offline user experience, what is your opinion
> > > > Michal?
> > >
> > > I am not a great fun of optimizations without any data to back them up.
> > > I do not see any sign this code has been actually tested and the
> > > condition triggered.
> >
> > This race is quite small. I only trigger this only once on my server.
> > And then the kernel panic. So I sent this patch series to fix some
> > bugs.
>
> Memory hotplug shouldn't panic when this race happens. Are you sure you
> have seen a race that is directly related to this patch?

I mean the panic is fixed by:

  [PATCH v3 3/6] mm: hugetlb: fix a race between freeing and dissolving the page

>
> > > Besides that I have requested to have an explanation of why blocking on
> > > the WQ is safe and that hasn't happened.
> >
> > I have seen all the caller of dissolve_free_huge_page, some caller is under
> > page lock (via lock_page). Others are also under a sleep context.
> >
> > So I think that blocking on the WQ is safe. Right?
>
> I have requested to explicitly write your thinking why this is safe so
> that we can double check it. Dependency on a work queue progress is much
> more complex than any other locks because there is no guarantee that WQ
> will make forward progress (all workers might be stuck, new workers not
> able to be created etc.).

OK. I know about your concern. How about setting the page as temporary
when hitting this race?

 int dissolve_free_huge_page(struct page *page)
 {
@@ -1793,8 +1794,10 @@ int dissolve_free_huge_page(struct page *page)
                 * We should make sure that the page is already on the free list
                 * when it is dissolved.
                 */
-               if (unlikely(!PageHugeFreed(head)))
+               if (unlikely(!PageHugeFreed(head))) {
+                       SetPageHugeTemporary(page)
                        goto out;
+               }

Setting the page as temporary and just return -EBUSY (do not flush
the work). __free_huge_page() will free it to the buddy allocator later.

> --
> Michal Hocko
> SUSE Labs
