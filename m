Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 757D12EEF09
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 10:03:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727888AbhAHJCY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 04:02:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726120AbhAHJCX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 04:02:23 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8FE2C0612F5
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jan 2021 01:01:42 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id m6so5836553pfm.6
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jan 2021 01:01:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Cjm0D2L5k7Q/zrsATyEfG+PCms7IhU88+VBy/f8Uo4U=;
        b=wUwhN9pFbFMmDo+jM3gbYsgRf1IJ/zy78nN5H5P1d7Qputze3XWpWyPvd/QXfyVtJg
         zQqQpB/zZfQitcntFMKr0id5pjMjvSRj+O7rCBPsseUFvxAr8O1Y7i2W0igVtKY4ifel
         2ANEPAW9gVCpceIaNkTxJHS0dQ3vLVLX9t2pgFzNzOqQFPreqNp44pdapvtx4M3Nba09
         Y7Oa/Ll/GZcwZ6nLBLbMu9Q4/obiA/Q4WUd/JKs8uGhRjth8KIwD4eeKICJXMgQYqbNy
         sS8xXwRON5HUDF99AY6CsZbC/oCVDDabWDYQo4HxtgKKBISBN6GSp7r71069HUlg/k5W
         eOOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Cjm0D2L5k7Q/zrsATyEfG+PCms7IhU88+VBy/f8Uo4U=;
        b=oqW8jlVnm36v+lbmTxlV4u1Tc+bKRLd/G00yYci8/NJc7TxtBVSVA3lBmK0/qm4PWz
         5CN117WpleF44zUS3R1z3fQOzECPjunel2QTVZruZFbhvFhFy8KO2PubAUtsq92oHyCp
         +2oQUNpW8oNgURbfk+JvpoauM1Nero7CVeooqasaF8ctfy/1ZQdbNTSwsefdQt8RfV6/
         vHfx+eB8vLaLM1FopMq+Jk6mVuTwGsyCMUzGfe/lYI7OR2NscqgYrvBDUsQK2rKDunCm
         AQW1hLhF2EELJyWE3lkbx1+r5aN42E6eYO7amHtTmc2BrqxYXUpTPtJYGqdioJJHzWfv
         JtWQ==
X-Gm-Message-State: AOAM530IdQYzPNu8O/hGQRsCa49K1pRZ0B+NBMTEQ2Yv1N2RgOuctbqO
        /HBfh9xoqt/rrAiId71pKUoDrr1II/1YDGiXXr2+eA==
X-Google-Smtp-Source: ABdhPJxBPjAShOFhpA+88AbAENNZUsT4F+04eVgAj62CpRX2QePwkFPh07OB+igp/2Y22w45urKsKgVRTpcqE8/WoNk=
X-Received: by 2002:a63:480f:: with SMTP id v15mr6017196pga.341.1610096502333;
 Fri, 08 Jan 2021 01:01:42 -0800 (PST)
MIME-Version: 1.0
References: <20210106165632.GT13207@dhcp22.suse.cz> <CAMZfGtWML+PUnK=jJJ1XFmv=VdKOZYmKjyYU=nhpq-1sSGKMqg@mail.gmail.com>
 <20210107084146.GD13207@dhcp22.suse.cz> <CAMZfGtVr83yb30EHp5i+f90nn5gnNfGH31Q2ebdV-5nnQXCsAQ@mail.gmail.com>
 <20210107111827.GG13207@dhcp22.suse.cz> <CAMZfGtV_k=FxcWfazpuT=3ByXSqK-CH-E3yRQUE_dG6JMnAZeg@mail.gmail.com>
 <20210107123854.GJ13207@dhcp22.suse.cz> <CAMZfGtWUP1H47ZGcczsmqsQvxYP=FK9vYVr8WbOY_9UG2SCv0A@mail.gmail.com>
 <20210107141130.GL13207@dhcp22.suse.cz> <CAMZfGtW8hDxV_5isGTNLQMFttoymRwxc2N7nEgqxLLj6t5oN3g@mail.gmail.com>
 <20210108084330.GW13207@dhcp22.suse.cz>
In-Reply-To: <20210108084330.GW13207@dhcp22.suse.cz>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Fri, 8 Jan 2021 17:01:03 +0800
Message-ID: <CAMZfGtUy740SbsCW_h1NaP5O=ahSZniezkC+62pxZ5bW+vZpBg@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v2 3/6] mm: hugetlb: fix a race between
 freeing and dissolving the page
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

On Fri, Jan 8, 2021 at 4:43 PM Michal Hocko <mhocko@suse.com> wrote:
>
> On Thu 07-01-21 23:11:22, Muchun Song wrote:
> > On Thu, Jan 7, 2021 at 10:11 PM Michal Hocko <mhocko@suse.com> wrote:
> > >
> > > On Thu 07-01-21 20:59:33, Muchun Song wrote:
> > > > On Thu, Jan 7, 2021 at 8:38 PM Michal Hocko <mhocko@suse.com> wrote:
> > > [...]
> > > > > Right. Can we simply back off in the dissolving path when ref count is
> > > > > 0 && PageHuge() if list_empty(page->lru)? Is there any other scenario
> > > > > when the all above is true and the page is not being freed?
> > > >
> > > > The list_empty(&page->lru) may always return false.
> > > > The page before freeing is on the active list
> > > > (hstate->hugepage_activelist).Then it is on the free list
> > > > after freeing. So list_empty(&page->lru) is always false.
> > >
> > > The point I was trying to make is that the page has to be enqueued when
> > > it is dissolved and freed. If the page is not enqueued then something
> > > racing. But then I have realized that this is not a great check to
> > > detect the race because pages are going to be released to buddy
> > > allocator and that will reuse page->lru again. So scratch that and sorry
> > > for the detour.
> > >
> > > But that made me think some more and one way to reliably detect the race
> > > should be PageHuge() check in the freeing path. This is what dissolve
> > > path does already. PageHuge becomes false during update_and_free_page()
> > > while holding the hugetlb_lock. So can we use that?
> >
> > It may make the thing complex. Apart from freeing it to the
> > buddy allocator, free_huge_page also does something else for
> > us. If we detect the race in the freeing path, if it is not a HugeTLB
> > page, the freeing path just returns. We also should move those
> > things to the dissolve path. Right?
>
> Not sure what you mean. Dissolving is a subset of the freeing path. It
> effectivelly only implements the update_and_free_page branch (aka free
> to buddy). It skips some of the existing steps because it believes it
> sees a freed page. But as you have pointed out this is racy and I
> strongly suspect it is simply wrong in those assumptions. E.g. hugetlb
> cgroup accounting can get wrong right?

OK. I know what you mean. The update_and_free_page should
do the freeing which is similar to __free_huge_page().

>
> The more I think about it the more I think that dissolving path should
> simply have a common helper with  __free_huge_page that would release
> the huge page to the allocator. The only thing that should be specific
> to the dissolving path is HWpoison handling. It shouldn't be playing
> with accounting and what not. Btw the HWpoison handling is suspicious as
> well, a lost race would mean this doesn't happen. But maybe there is
> some fixup handled later on...
>
> > But I find a tricky problem to solve. See free_huge_page().
> > If we are in non-task context, we should schedule a work
> > to free the page. We reuse the page->mapping. If the page
> > is already freed by the dissolve path. We should not touch
> > the page->mapping. So we need to check PageHuge().
> > The check and llist_add() should be protected by
> > hugetlb_lock. But we cannot do that. Right? If dissolve
> > happens after it is linked to the list. We also should
> > remove it from the list (hpage_freelist). It seems to make
> > the thing more complex.
>
> I am not sure I follow you here but yes PageHuge under hugetlb_lock
> should be the reliable way to check for the race. I am not sure why we
> really need to care about mapping or other state.

CPU0:                               CPU1:
free_huge_page(page)
  if (PageHuge(page))
                                    dissolve_free_huge_page(page)
                                      spin_lock(&hugetlb_lock)
                                      update_and_free_page(page)
                                      spin_unlock(&hugetlb_lock)
    llist_add(page->mapping)
    // the mapping is corrupted

The PageHuge(page) and llist_add() should be protected by
hugetlb_lock. Right? If so, we cannot hold hugetlb_lock
in free_huge_page() path.

> --
> Michal Hocko
> SUSE Labs
