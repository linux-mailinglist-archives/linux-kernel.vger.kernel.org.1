Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFE4C2EC877
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 04:01:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727233AbhAGDAw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 22:00:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726326AbhAGDAv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 22:00:51 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BC89C0612EF
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jan 2021 19:00:11 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id m25so11233417lfc.11
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jan 2021 19:00:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y2xQZ5RMbObOSpIE8tPtSLqtuZYmrDOIDrzQfpthNtY=;
        b=FREAbxHZ+FdRctVna5bB4km0wAZI1guozJraW+Ss/19NakfFF5WZZtgcJ9yPXDFugO
         BpmhRoQiQhslNDXDDiq93//SMZ7ohrQb1rtT4tY+75q5KB6lZOdXtILfBWWQCBaoXlPJ
         8LONDz0qABe3Fig5IqXutrZr3xx9wZnt+L5i0+37k/m/2Vs0J7IQ8zQ4uCHleW6ngBIR
         zA/MmbgGo2srFlLyIsSJARCqTFRSnOox0oX3Q2Ujh4pg0/TVN3e45dS7DUDZGNTC5+CV
         NQcW7j2vsR3GGN+X1PJDCIKLoju5XbpXh85F2ukI3YOWq8SJP6NSAKl20ISjJrFLb6eS
         lXaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y2xQZ5RMbObOSpIE8tPtSLqtuZYmrDOIDrzQfpthNtY=;
        b=hDsL7ZyMWUR+RGr0hdWzVjtwqSUxfDMCjaSaJwbbE32JIuKzGV3LmJi6/yynhqnmMx
         aLy23wK3yHd/pBdfZLnu2+PR99YLYQMDTzApKlS2UITH9HEVySn0KymFvOkDRRx0qTaO
         LOIR1gQH4a9G1l6A+osFAiMVmOoRjI2ZgwnJhO54sF9ORn+6Y5x66wEBmt7Tm4iGSLpF
         8DzcXT6585FzglhiI2z/wmr5jyXjRDkoK7GaZv+WmTHtae6LoZlXyLqAX60HQnTqop15
         aRYbtHWmx/aV0p8BsIZhO14b6T+YWRnOoRGfXJohwa4Dkz6E5PE0fLQpBgPlfQblpF/u
         EtPQ==
X-Gm-Message-State: AOAM53253qepRmd1qVsYsTo8wEc06eUQqLPFGP3TfNux6tjEBg07SAE0
        zduZrQkBtEOO9Ci2fU6q1wzqvN1O1MoPPnFqC4o=
X-Google-Smtp-Source: ABdhPJz0u4kaTNiRDi7EHBiRqoyK82SxCRX5Gw1c7Qs4zLA5ZsrkL4MCqQqXfao/3cfYwAfoncEI9LH4LDSRvFr/3nM=
X-Received: by 2002:a05:651c:22b:: with SMTP id z11mr3104479ljn.38.1609988409068;
 Wed, 06 Jan 2021 19:00:09 -0800 (PST)
MIME-Version: 1.0
References: <20210106034715.GA1138@open-light-1.localdomain> <CAKgT0Uf=iQ-vzk7woNBsgAOvVD2RS41x9dRC-Y06TCGwykHzSw@mail.gmail.com>
In-Reply-To: <CAKgT0Uf=iQ-vzk7woNBsgAOvVD2RS41x9dRC-Y06TCGwykHzSw@mail.gmail.com>
From:   Liang Li <liliang324@gmail.com>
Date:   Thu, 7 Jan 2021 10:59:55 +0800
Message-ID: <CA+2MQi8XqHmKznsGum89YuiBn1dTxCqEDsZMuSUNLm10hBwQhw@mail.gmail.com>
Subject: Re: [PATCH 1/6] mm: Add batch size for free page reporting
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

> So you are going to need a lot more explanation for this. Page
> reporting already had the concept of batching as you could only scan
> once every 2 seconds as I recall. Thus the "PAGE_REPORTING_DELAY". The
> change you are making doesn't make any sense without additional
> context.

The reason for adding a batch is mainly for page prezero, I just want to make it
configurable to control the 'cache pollution', for that case, the
reporting thread
should not be woken up too frequently.

> > ---
> >  mm/page_reporting.c |  1 +
> >  mm/page_reporting.h | 12 ++++++++++--
> >  2 files changed, 11 insertions(+), 2 deletions(-)
> >
> > diff --git a/mm/page_reporting.c b/mm/page_reporting.c
> > index cd8e13d41df4..694df981ddd2 100644
> > --- a/mm/page_reporting.c
> > +++ b/mm/page_reporting.c
> > @@ -12,6 +12,7 @@
> >
> >  #define PAGE_REPORTING_DELAY   (2 * HZ)
> >  static struct page_reporting_dev_info __rcu *pr_dev_info __read_mostly;
> > +unsigned long page_report_batch_size  __read_mostly = 16 * 1024 * 1024UL;
> >
> >  enum {
> >         PAGE_REPORTING_IDLE = 0,
> > diff --git a/mm/page_reporting.h b/mm/page_reporting.h
> > index 2c385dd4ddbd..b8fb3bbb345f 100644
> > --- a/mm/page_reporting.h
> > +++ b/mm/page_reporting.h
> > @@ -12,6 +12,8 @@
> >
> >  #define PAGE_REPORTING_MIN_ORDER       pageblock_order
> >
> > +extern unsigned long page_report_batch_size;
> > +
> >  #ifdef CONFIG_PAGE_REPORTING
> >  DECLARE_STATIC_KEY_FALSE(page_reporting_enabled);
> >  void __page_reporting_notify(void);
> > @@ -33,6 +35,8 @@ static inline bool page_reported(struct page *page)
> >   */
> >  static inline void page_reporting_notify_free(unsigned int order)
> >  {
> > +       static long batch_size;
> > +
>
> I'm not sure this makes a tone of sense to place the value in an
> inline function. It might make more sense to put this new code in
> __page_reporting_notify so that all callers would be referring to the
> same batch_size value and you don't have to bother with the export of
> the page_report_batch_size value.

you are right, will change.

> >         /* Called from hot path in __free_one_page() */
> >         if (!static_branch_unlikely(&page_reporting_enabled))
> >                 return;
> > @@ -41,8 +45,12 @@ static inline void page_reporting_notify_free(unsigned int order)
> >         if (order < PAGE_REPORTING_MIN_ORDER)
> >                 return;
> >
> > -       /* This will add a few cycles, but should be called infrequently */
> > -       __page_reporting_notify();
> > +       batch_size += (1 << order) << PAGE_SHIFT;
> > +       if (batch_size >= page_report_batch_size) {
> > +               batch_size = 0;
>
> I would probably run this in the opposite direction. Rather than
> running batch_size to zero I would look at adding a "batch_remaining"
> and then when it is < 0 you could then reset it back to
> page_report_batch_size. Doing that you only have to read one variable
> most of the time instead of doing a comparison against two.

You are right again.

Thanks
Liang
