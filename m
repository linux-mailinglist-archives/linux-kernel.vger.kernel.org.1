Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 110EE2929E0
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 16:58:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729777AbgJSO6u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 10:58:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729544AbgJSO6u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 10:58:50 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1254BC0613CE
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 07:58:50 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id e10so115246pfj.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 07:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RSuhIHqburwzUy3eygGlAcGNTesq4YXWHtEuEStZ0lU=;
        b=UakS1ZZvMIJ5L4ZJLiHGL2hqZvozvcnwCmDHuSsFeUNKRzjHHnXcoPysI71zp4AEMx
         Vf1kz12Ygmd2mhmoK0yBqLlKVoWHy/yztly6ULcBA77dhXln4AsCYa2BrrVHK5gGVGGG
         J/Wdittv0bKVULHoMlubcGhSnUaopBICbcPEwiW4cBnsLVKmamBmWGrIZQnbOh/tp6zW
         Mek6hkj4svQd8HWu5lBk4WTUWpa0q18az2mROSd9DlUxULF9WsKzwJ6tm6IducPXqXiO
         Woy9INnC5GUIE5P0K5vdSqeXSbrSoexFA3L503QzcpnX5XMjJrlMWtuphEYYA2T6RhNk
         RXGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RSuhIHqburwzUy3eygGlAcGNTesq4YXWHtEuEStZ0lU=;
        b=OFEAldbArolFR53GgZsPrtkQxZyYs7ewCz/cFYPJypp4v63WGphQVRgIlMM6pc9uA7
         UZ2/97Q8jmtRThyW9NeOpgkupTrgBOTa+zEvjGGWEQC6mV+6zksQXAcuVIXc6kKEDby0
         Mzn05kxNS43RdST5Pd2/21rveE4iviKUl4mEIoa4dFo0xBvtZi517YspOCgLHchSmN2o
         ymm629LB6jywoD5E9y3QoFf/lyl7wbebMEBixLypp93+bjWfUaqwk3FSHoPSJcPjQfdS
         7dQX2KzVyLxonSwLhvoJSt+hhx+hK7e+6akveA0+ip9T8b1Q4ZctYPUjTscGrM+ekTRt
         Nylg==
X-Gm-Message-State: AOAM531S8TEGKuLvXKqcrllORG6jj6TN14aWr696tXQ6aFWx4V0ny0IT
        5ranqtXK0XCu2mP3gJEaUOiyt/KN1dbwI4n/pNqMfw==
X-Google-Smtp-Source: ABdhPJwKOCTEkiVhBWHqsbj2FEZeIrJjfIR9bboOEWbeannt3Abv4X8HFhP8oGWaFfiInR+M5kg5nqMvH6AWIRfe0m8=
X-Received: by 2002:a63:df51:: with SMTP id h17mr24820pgj.273.1603119529627;
 Mon, 19 Oct 2020 07:58:49 -0700 (PDT)
MIME-Version: 1.0
References: <20201019101520.12283-1-songmuchun@bytedance.com> <20201019123137.GG27114@dhcp22.suse.cz>
In-Reply-To: <20201019123137.GG27114@dhcp22.suse.cz>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Mon, 19 Oct 2020 22:58:12 +0800
Message-ID: <CAMZfGtVa7n_W2QYA1a8xM3HFtPne8XcWDObytEujO47CBkwYWw@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] mm/memory.c: Introduce non-atomic __{Set,Clear}PageSwapCache
To:     Michal Hocko <mhocko@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>, osalvador@suse.de,
        alexander.h.duyck@linux.intel.com, yang.shi@linux.alibaba.com,
        David Hildenbrand <david@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Hugh Dickins <hughd@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 19, 2020 at 8:31 PM Michal Hocko <mhocko@suse.com> wrote:
>
> On Mon 19-10-20 18:15:20, Muchun Song wrote:
> > For the exclusive reference page, the non-atomic operations is enough,
> > so replace them to non-atomic operations.
>
> I do expect you do not see any difference in runtime and this is mostly
> driven by the code reading, right? Being explicit about this in the code
> would be preferred.

Yeah, just code reading.And the set_bit and __set_bit is actually different
on some architectures. Thanks.

>
> No objection to the change.
>
> > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>
> With an improved changelog
> Acked-by: Michal Hocko <mhocko@suse.com>
>
> > ---
> >  include/linux/page-flags.h | 2 ++
> >  mm/memory.c                | 4 ++--
> >  2 files changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
> > index fbbb841a9346..ec039dde5e4b 100644
> > --- a/include/linux/page-flags.h
> > +++ b/include/linux/page-flags.h
> > @@ -401,6 +401,8 @@ static __always_inline int PageSwapCache(struct page *page)
> >  }
> >  SETPAGEFLAG(SwapCache, swapcache, PF_NO_TAIL)
> >  CLEARPAGEFLAG(SwapCache, swapcache, PF_NO_TAIL)
> > +__SETPAGEFLAG(SwapCache, swapcache, PF_NO_TAIL)
> > +__CLEARPAGEFLAG(SwapCache, swapcache, PF_NO_TAIL)
> >  #else
> >  PAGEFLAG_FALSE(SwapCache)
> >  #endif
> > diff --git a/mm/memory.c b/mm/memory.c
> > index 2d267ef6621a..02dd62da26e0 100644
> > --- a/mm/memory.c
> > +++ b/mm/memory.c
> > @@ -3128,10 +3128,10 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
> >                               set_page_private(page, entry.val);
> >
> >                               /* Tell memcg to use swap ownership records */
> > -                             SetPageSwapCache(page);
> > +                             __SetPageSwapCache(page);
> >                               err = mem_cgroup_charge(page, vma->vm_mm,
> >                                                       GFP_KERNEL);
> > -                             ClearPageSwapCache(page);
> > +                             __ClearPageSwapCache(page);
> >                               if (err) {
> >                                       ret = VM_FAULT_OOM;
> >                                       goto out_page;
> > --
> > 2.20.1
> >
>
> --
> Michal Hocko
> SUSE Labs



-- 
Yours,
Muchun
