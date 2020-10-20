Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAE3C293CF9
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 15:09:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407327AbgJTNJE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 09:09:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406360AbgJTNJD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 09:09:03 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B548EC061755
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 06:09:01 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id h7so1170153pfn.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 06:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ITF5JclwspjIVhEI/makUWBTrmHam62Yza4T+6BNq5w=;
        b=mdxaoKWh+3gz8T9lGzDzOEXWt/zO3loiddpJYHXv040n51bqawqJpJ0gp5x5P9zBvg
         EUoRIkG1UvLYFTEQx5RDAtfQC00sUg19zGitphqtn71Y4l6a9KoekDNRasPt+VrN1mRC
         HXKripL5MgSXWDSQiijRI6qFpbyJGjFcakPaf8wpXU/3W3DEkHVejgmCBU3u7QvViVsA
         0gFj+1QVp+7f9aCTMG7GMfVgTEPGTErZL/jVNtG3bBvIGHR3dGih2DmMzC9JmF/xWeTH
         lwu7jPYgDbRZuqQQB7GOV0mGjPtpMKXHHo0NL4niXTYiryMLRY1E4plZuivxDvZ9hc3G
         gCjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ITF5JclwspjIVhEI/makUWBTrmHam62Yza4T+6BNq5w=;
        b=bFZt2+2pO6moofMMb6AB27DwhISq/9hSoINEDXt2sPEwnKfqybL8K6bhuKWTEhFqVj
         QDkMrht1Gt4TOsZNt4QcfH7/uNDpsL9ZxUzVkLheZb6w43maVOxzAyQnWfMOSZSXL/43
         BqlLAMz7Z+4t0KBLkDnmluJG51ITteQtbsMui0ajWGMOp4ISa/pu7hhytiRGZudRwD3L
         OgiPmL/olJVpGRHFLrJYJl7m/2+N2es7VY+W8V2vbyGZFfZIWp9hFXFp2JCqJ2Yzdy9z
         BDwYpoSKK3k0aH223GmhSHzFnOubOibVSrDcCJQrO5ZQW6vfKWVSWgZOOGDSQ4bgiaQT
         laPQ==
X-Gm-Message-State: AOAM533MbO99Zy4yuS5GyR2wW+IOObdk+orpaa8r3YTu+yKxXQ8O9s5d
        xbsahp5h1zn6dOjVtJxcYPUf4aCdZQ0qBjR7O6R8mg==
X-Google-Smtp-Source: ABdhPJxabMb2qd9lo31jJKqCx7rg2FeGmCHQDAGFjsaMcfo4CLQwDJY4kd0+ooqXExTvQ+VeQbb0b6k0LnrYe2EwGBs=
X-Received: by 2002:a63:313:: with SMTP id 19mr2529541pgd.341.1603199341306;
 Tue, 20 Oct 2020 06:09:01 -0700 (PDT)
MIME-Version: 1.0
References: <20201019101520.12283-1-songmuchun@bytedance.com>
 <20201019123137.GG27114@dhcp22.suse.cz> <CAMZfGtVa7n_W2QYA1a8xM3HFtPne8XcWDObytEujO47CBkwYWw@mail.gmail.com>
 <1b5198a5-247c-23aa-3be7-f5821a672cc2@windriver.com>
In-Reply-To: <1b5198a5-247c-23aa-3be7-f5821a672cc2@windriver.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Tue, 20 Oct 2020 21:08:25 +0800
Message-ID: <CAMZfGtVJb1HJLGEYH2aFgDvjES80UYm11cYadLo0jrmUTsy0eg@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] mm/memory.c: Introduce non-atomic __{Set,Clear}PageSwapCache
To:     "Xu, Yanfei" <yanfei.xu@windriver.com>
Cc:     Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>, osalvador@suse.de,
        alexander.h.duyck@linux.intel.com, yang.shi@linux.alibaba.com,
        David Hildenbrand <david@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Hugh Dickins <hughd@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 20, 2020 at 7:51 PM Xu, Yanfei <yanfei.xu@windriver.com> wrote:
>
>
>
> On 10/19/20 10:58 PM, Muchun Song wrote:
> > On Mon, Oct 19, 2020 at 8:31 PM Michal Hocko <mhocko@suse.com> wrote:
> >>
> >> On Mon 19-10-20 18:15:20, Muchun Song wrote:
> >>> For the exclusive reference page, the non-atomic operations is enough=
,
> >>> so replace them to non-atomic operations.
> >>
> >> I do expect you do not see any difference in runtime and this is mostl=
y
> >> driven by the code reading, right? Being explicit about this in the co=
de
> >> would be preferred.
> >
> > Yeah, just code reading.And the set_bit and __set_bit is actually diffe=
rent
> > on some architectures. Thanks.
> >
> >>
> >> No objection to the change.
> >>
> >>> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> >>
> >> With an improved changelog
> >> Acked-by: Michal Hocko <mhocko@suse.com>
> >>
> >>> ---
> >>>   include/linux/page-flags.h | 2 ++
> >>>   mm/memory.c                | 4 ++--
> >>>   2 files changed, 4 insertions(+), 2 deletions(-)
> >>>
> >>> diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
> >>> index fbbb841a9346..ec039dde5e4b 100644
> >>> --- a/include/linux/page-flags.h
> >>> +++ b/include/linux/page-flags.h
> >>> @@ -401,6 +401,8 @@ static __always_inline int PageSwapCache(struct p=
age *page)
> >>>   }
> >>>   SETPAGEFLAG(SwapCache, swapcache, PF_NO_TAIL)
> >>>   CLEARPAGEFLAG(SwapCache, swapcache, PF_NO_TAIL)
> >>> +__SETPAGEFLAG(SwapCache, swapcache, PF_NO_TAIL)
> >>> +__CLEARPAGEFLAG(SwapCache, swapcache, PF_NO_TAIL)
> >>>   #else
> >>>   PAGEFLAG_FALSE(SwapCache)
> >>>   #endif
> >>> diff --git a/mm/memory.c b/mm/memory.c
> >>> index 2d267ef6621a..02dd62da26e0 100644
> >>> --- a/mm/memory.c
> >>> +++ b/mm/memory.c
> >>> @@ -3128,10 +3128,10 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
> >>>                                set_page_private(page, entry.val);
> >>>
> >>>                                /* Tell memcg to use swap ownership re=
cords */
> >>> -                             SetPageSwapCache(page);
> >>> +                             __SetPageSwapCache(page);
>
> Good evening, Muchun. I found there are still some places could be
> replaced with __SetPageSwapCache=EF=BC=88=EF=BC=89. Such as shmem_replace=
_page=EF=BC=88=EF=BC=89, why

Yeah, thanks for your suggestion.

> PG_locked has been set before SetPageSwapCache=EF=BC=88=EF=BC=89 is invol=
ved.

In this case, It doesn't matter whether PG_locked is set before
SetPageSwapCache.

>
> Would you please to check the rest places? :)

Ok, I'll take a look. Thanks.

>
> Thanks
>
> Acked-by: Yanfei Xu <yanfei.xu@windriver.com>
>
> >>>                                err =3D mem_cgroup_charge(page, vma->v=
m_mm,
> >>>                                                        GFP_KERNEL);
> >>> -                             ClearPageSwapCache(page);
> >>> +                             __ClearPageSwapCache(page);
> >>>                                if (err) {
> >>>                                        ret =3D VM_FAULT_OOM;
> >>>                                        goto out_page;
> >>> --
> >>> 2.20.1
> >>>
> >>
> >> --
> >> Michal Hocko
> >> SUSE Labs
> >
> >
> >



--
Yours,
Muchun
