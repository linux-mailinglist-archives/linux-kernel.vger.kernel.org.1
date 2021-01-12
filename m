Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 763FE2F2BCA
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 10:53:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392771AbhALJwa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 04:52:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391252AbhALJw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 04:52:28 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 553B6C061575
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 01:51:48 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id y8so1115906plp.8
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 01:51:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OMgiF78gUWEYLUGFiDuarkkkzIV0Lfaxz8wzZTO/7qs=;
        b=0A5uBL+U2u1qaGb5hU9qvxusYG4KmguNoH2B+jeIjKvKpeIE5QW3Q2YHulrFIAt1te
         OEL8cFaYV0Eh2EtYySH0iUH+9FtNhstuiriAuqHk92jpwsDGz2DfRwQfZP+km68dxFbD
         xIIwRfsyGtqG5FP1aZ7cAaVOAplmEcA0TdhmlK4Xw0FXB6T4sO6NhKVCkLbFbjM+83sp
         R3WRK3GrPNvwhM27EbFIU/huUgkyZR0AOFaGcXTijOZjiJ9LQK2bW+HbZ4pNewJHWqLm
         CQQDhSUpIOyFMZMdL/T9zqc7ZHC9DrmWU4o9wxty4PAu1I5HOJJqW/XwDtoeue/Whh08
         OS6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OMgiF78gUWEYLUGFiDuarkkkzIV0Lfaxz8wzZTO/7qs=;
        b=kJSJM0p2TL5mKBAvmnvOrzlgpDRXxwRRennFdNgnlJ4+ZLyybIKvvYdcSV1oW62hN3
         tBaL4kqD6C7Cdzc9WhjfMIdwPDesfrdcAC9nss0nDREaC7/PoLBxKaXVM+QuA9PGWWBU
         H7ixfKgFEELCYS/hpBBtFwhQN3cuystLpbscBEluW63DglyHuCp0jmZ5OHHPT/Kd/Oh6
         N5ypsqwHU3FvsbGM2RKrbcl3eKF9FwQtYeAnm0R5sRPJA5H5MMEpfAATmObZ3iibcfuC
         8zwZ2LcMw66SDbLwHsayPoia+TQNUTXwTvUCBTDoZuDkmDzb2tWqbPPA3Rqlg8U2a2yO
         9v9Q==
X-Gm-Message-State: AOAM532qyHEDnvlc94k/TEwif/Oh1720eO2EmhuUvFVA8KIEIqszO+Wx
        l5psDPyFvnB4pVAPG0sxlK89TqFKe/DgiSK/UfAJz1c1RCRl247DUkQ=
X-Google-Smtp-Source: ABdhPJwoo3k/ywhTHur5E1sTqh0bqQW9nS+u+CN1Fh6a9ZkB9J1RhnGWGAvITbKo/fTVWlmfv3Ghr3O0eeA6kzDgwUw=
X-Received: by 2002:a17:90a:5405:: with SMTP id z5mr3853388pjh.13.1610445107870;
 Tue, 12 Jan 2021 01:51:47 -0800 (PST)
MIME-Version: 1.0
References: <20210110124017.86750-1-songmuchun@bytedance.com>
 <20210110124017.86750-5-songmuchun@bytedance.com> <c61cdf1d-2feb-ecb3-393d-ca25175c73f4@oracle.com>
 <20210112083335.GH22493@dhcp22.suse.cz>
In-Reply-To: <20210112083335.GH22493@dhcp22.suse.cz>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Tue, 12 Jan 2021 17:51:05 +0800
Message-ID: <CAMZfGtVCntwNM=2RHHp=qDLN3L71ouQy=9V_e=VTNHtCDHsmWA@mail.gmail.com>
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

On Tue, Jan 12, 2021 at 4:33 PM Michal Hocko <mhocko@suse.com> wrote:
>
> On Mon 11-01-21 17:20:51, Mike Kravetz wrote:
> > On 1/10/21 4:40 AM, Muchun Song wrote:
> > > There is a race between dissolve_free_huge_page() and put_page(),
> > > and the race window is quite small. Theoretically, we should return
> > > -EBUSY when we encounter this race. In fact, we have a chance to
> > > successfully dissolve the page if we do a retry. Because the race
> > > window is quite small. If we seize this opportunity, it is an
> > > optimization for increasing the success rate of dissolving page.
> > >
> > > If we free a HugeTLB page from a non-task context, it is deferred
> > > through a workqueue. In this case, we need to flush the work.
> > >
> > > The dissolve_free_huge_page() can be called from memory hotplug,
> > > the caller aims to free the HugeTLB page to the buddy allocator
> > > so that the caller can unplug the page successfully.
> > >
> > > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > > ---
> > >  mm/hugetlb.c | 26 +++++++++++++++++++++-----
> > >  1 file changed, 21 insertions(+), 5 deletions(-)
> >
> > I am unsure about the need for this patch.  The code is OK, there are no
> > issues with the code.
> >
> > As mentioned in the commit message, this is an optimization and could
> > potentially cause a memory offline operation to succeed instead of fail.
> > However, we are very unlikely to ever exercise this code.  Adding an
> > optimization that is unlikely to be exercised is certainly questionable.
> >
> > Memory offline is the only code that could benefit from this optimization.
> > As someone with more memory offline user experience, what is your opinion
> > Michal?
>
> I am not a great fun of optimizations without any data to back them up.
> I do not see any sign this code has been actually tested and the
> condition triggered.

This race is quite small. I only trigger this only once on my server.
And then the kernel panic. So I sent this patch series to fix some
bugs.

>
> Besides that I have requested to have an explanation of why blocking on
> the WQ is safe and that hasn't happened.

I have seen all the caller of dissolve_free_huge_page, some caller is under
page lock (via lock_page). Others are also under a sleep context.

So I think that blocking on the WQ is safe. Right?

> --
> Michal Hocko
> SUSE Labs
