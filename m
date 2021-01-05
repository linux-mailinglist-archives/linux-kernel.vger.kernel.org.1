Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 651B22EB397
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 20:43:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730872AbhAETnM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 14:43:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730570AbhAETnL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 14:43:11 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EBFAC061574
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jan 2021 11:42:30 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id o13so1231392lfr.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jan 2021 11:42:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BYoTEEasTGTbeUe5rO0NOqcMl/OsWURt/XrVYO9iiBE=;
        b=rVAYvv/W3AwJm3e7hsUlb8tsPHpuRmS/tGCKqISerYJWmOpDfpfLStFg/yt9KJ3NzY
         frYYOWAAhLCirAwpOFpfKhI0lQFcrlM09zdnx3qQB7hHP9q4UbS7puMB9aspXQEy0e8d
         zz9wv4iUHWToHSIzzBGMePeHDDgU1rE2Ht6ZPfI11hgEOVmAXNsOGOe1Aqve1moPjF+t
         NkZs2cwjbhTFbvDuPaL3B+nRfnWpxyL3AdhvzqUPYFzRTRuFezyJ+/QwgrMJ9ouaOaKV
         xvMywi3uY/4gUz8dAvH36AgEtNQR+U302+0NYCbx0xmZb61kb9M1pKqdn+AshRwIZMj+
         a2Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BYoTEEasTGTbeUe5rO0NOqcMl/OsWURt/XrVYO9iiBE=;
        b=LHjIUQJgRslmJLdxnvDaAoEKDYGQ/aawfc/QZU3Wdulxu3MBw/H3b0ge2jSqZ/AOWE
         SyTFVEhvsvBnmNNrk9qpum5SC1sKFgOi4BXvV6jywCaCzPthCRu+NaaN3KXJMduRzyAV
         tGWspkzDTKUMx9ARlA8g2clf4I+2SJws+LYnT8Ak+78L8fjmrZYRwbyjCz4sSyuD33jO
         uSwdnda1jEBVwNGbC1jZcxmjRXZeIAKkpc7D5Qsaa3k1ZQEwgjpvKdyGAP8YEAg48mVF
         1I7dnG3H729LzYuRVkfrLaFAs1WBI4XfJ8IV74Su8UjliR5VtVEkb+xYVR0G7TBsTImZ
         0AJQ==
X-Gm-Message-State: AOAM532U42oEDVPdwBadFxkTV9RhWuU+MfjOJvgDr+6RxUPzvibYwW9D
        dsNUVKB0VPGR96kDidUak6T3iDtLYnlf480Iab4DuA==
X-Google-Smtp-Source: ABdhPJx/+k688ShdldqheuNW9q3B3igGtUsLNim+goYWXcvTrFNPoh8S6h0MdE29Sjhy0iwjyhdyppnpI1tlclKVhuA=
X-Received: by 2002:ac2:47e7:: with SMTP id b7mr343986lfp.117.1609875748867;
 Tue, 05 Jan 2021 11:42:28 -0800 (PST)
MIME-Version: 1.0
References: <1604566549-62481-1-git-send-email-alex.shi@linux.alibaba.com> <aebcdd933df3abad378aeafc1a07dfe9bbb25548.camel@redhat.com>
In-Reply-To: <aebcdd933df3abad378aeafc1a07dfe9bbb25548.camel@redhat.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 5 Jan 2021 11:42:18 -0800
Message-ID: <CALvZod448Ebw7YE-HVCNXNSbtvTcTvQx+_EqcyxTVd_SZ4ATBA@mail.gmail.com>
Subject: Re: [PATCH v21 00/19] per memcg lru lock
To:     Qian Cai <qcai@redhat.com>
Cc:     Alex Shi <alex.shi@linux.alibaba.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Tejun Heo <tj@kernel.org>, Hugh Dickins <hughd@google.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        kernel test robot <lkp@intel.com>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Cgroups <cgroups@vger.kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        alexander.duyck@gmail.com,
        kernel test robot <rong.a.chen@intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Yang Shi <shy828301@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 5, 2021 at 11:30 AM Qian Cai <qcai@redhat.com> wrote:
>
> On Thu, 2020-11-05 at 16:55 +0800, Alex Shi wrote:
> > This version rebase on next/master 20201104, with much of Johannes's
> > Acks and some changes according to Johannes comments. And add a new patch
> > v21-0006-mm-rmap-stop-store-reordering-issue-on-page-mapp.patch to support
> > v21-0007.
> >
> > This patchset followed 2 memcg VM_WARN_ON_ONCE_PAGE patches which were
> > added to -mm tree yesterday.
> >
> > Many thanks for line by line review by Hugh Dickins, Alexander Duyck and
> > Johannes Weiner.
>
> Given the troublesome history of this patchset, and had been put into linux-next
> recently, as well as it touched both THP and mlock. Is it a good idea to suspect
> this patchset introducing some races and a spontaneous crash with some mlock
> memory presume?

This has already been merged into the linus tree. Were you able to get
a similar crash on the latest upstream kernel as well?
