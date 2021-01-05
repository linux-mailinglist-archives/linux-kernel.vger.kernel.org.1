Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18F952EA3D2
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 04:17:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728188AbhAEDQF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 22:16:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726329AbhAEDQF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 22:16:05 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E838C061574
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jan 2021 19:15:25 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id z21so20377775pgj.4
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jan 2021 19:15:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=374PX+r27VhlfV2TpHUAfDd6BqcAZV0CQiqGA0zU7J8=;
        b=W1n1q4WvrdywqUmyhut35HCgrPrMzw9uMhIJzTnWBETHHLmQxxfwS9Z/FZv/LyAVxP
         vVo7GoIQi98+ENtGDrWvlyKK+YYL5kewH0pwWftyYRpBm5FstiDaJHG2Ls6T3/83e/k2
         0xr3CqN3olOLls3UB/ETU3qEr4dPUS9AkdBujbcK7citWllqNQFFxWkFsWdtVCL3M1ak
         Wy2m+H1znBiYKt6jZfa/fS6I04ElxTZFW13k+f6yvjvE7SxN7E8CujKLFxf8z89CWXgX
         9zSNE6BnX08Hm7mmmQ4H/AWJT2tPjwneGdgnkr7CLjGp/hgVS5Z5o/NPwgoooUgG8OeM
         mIEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=374PX+r27VhlfV2TpHUAfDd6BqcAZV0CQiqGA0zU7J8=;
        b=rTZ42UCxLO3829I6upZZXwyUTuoVYOtdlMXZ6uhPlIJZzor+FbbSwDHYjXWjnipuzE
         WAqkYufS1yE/SENFpBdmsVk3rwmZR16W4y6dSPCqCSqv4ivPMwtLuHNRreY6zKqFDQYc
         kdevVnVe/CK4EMjSGU6oay+D+v55JpFJBs3WMpMawi9LLI3KMjP7QJ0Jff5yQ3aF7rJg
         03WbJyoAIc8ASQjcaqfIQeG4l/6RyRTc8/nZTOzwfe/TUctIK3XQ1FGgQP1hJqHio4q8
         44KkDXUEG6S38eJWpydN9gCqylO0HPx+Dc9U3B0/a6cvrtMr/1W3hiNtQRM11O0O3liG
         /Cwg==
X-Gm-Message-State: AOAM5339zfqMWrfGhgXWtjeetKUZB9Jsiuh52TBWvbymux4iWeSomvTm
        JVYRr7XvTWU02rFUvR+5L5+WClg35SyojADqehsvmQ==
X-Google-Smtp-Source: ABdhPJyAjGaM3S3iiFfXERflIW7dbWrqo8z9pM4Bw0aLc6rm7OAkttFCEl5XP6PyYMXCS+D0vULRFLhDtejWq6lTb6A=
X-Received: by 2002:a63:50a:: with SMTP id 10mr73473074pgf.273.1609816524718;
 Mon, 04 Jan 2021 19:15:24 -0800 (PST)
MIME-Version: 1.0
References: <20210104065843.5658-1-songmuchun@bytedance.com>
 <20210104065843.5658-4-songmuchun@bytedance.com> <e043e137-5ca7-d478-248c-9defcecc6ac7@oracle.com>
In-Reply-To: <e043e137-5ca7-d478-248c-9defcecc6ac7@oracle.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Tue, 5 Jan 2021 11:14:46 +0800
Message-ID: <CAMZfGtXZqbNwb2k5sq29gXSBMO3sVNaATiJnPWSggoAG5mZMqA@mail.gmail.com>
Subject: Re: [External] Re: [PATCH 4/6] mm: hugetlb: add return -EAGAIN for dissolve_free_huge_page
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Andi Kleen <ak@linux.intel.com>, mhocko@suse.cz,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 5, 2021 at 9:33 AM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>
> On 1/3/21 10:58 PM, Muchun Song wrote:
> > When dissolve_free_huge_page() races with __free_huge_page(), we can
> > do a retry. Because the race window is small.
>
> In general, I agree that the race window is small.  However, worst case
> would be if the freeing of the page is put on a work queue.  Is it acceptable
> to keep retrying in that case?  In addition, the 'Free some vmemmap' series
> may slow the free_huge_page path even more.

I also consider the 'Free some vmemmap' series case. In my next
version series, I will flush the work before dissolve_free_huge_page
returns when encountering this race. So the retry is acceptable.
Right?

Thanks.

>
> In these worst case scenarios, I am not sure we want to just spin retrying.
>
> --
> Mike Kravetz
>
> >
> > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > ---
> >  mm/hugetlb.c | 16 +++++++++++-----
> >  1 file changed, 11 insertions(+), 5 deletions(-)
> >
> > diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> > index 72608008f8b4..db00ae375d2a 100644
> > --- a/mm/hugetlb.c
> > +++ b/mm/hugetlb.c
> > @@ -1763,10 +1763,11 @@ static int free_pool_huge_page(struct hstate *h, nodemask_t *nodes_allowed,
> >   * nothing for in-use hugepages and non-hugepages.
> >   * This function returns values like below:
> >   *
> > - *  -EBUSY: failed to dissolved free hugepages or the hugepage is in-use
> > - *          (allocated or reserved.)
> > - *       0: successfully dissolved free hugepages or the page is not a
> > - *          hugepage (considered as already dissolved)
> > + *  -EAGAIN: race with __free_huge_page() and can do a retry
> > + *  -EBUSY:  failed to dissolved free hugepages or the hugepage is in-use
> > + *           (allocated or reserved.)
> > + *       0:  successfully dissolved free hugepages or the page is not a
> > + *           hugepage (considered as already dissolved)
> >   */
> >  int dissolve_free_huge_page(struct page *page)
> >  {
> > @@ -1815,8 +1816,10 @@ int dissolve_free_huge_page(struct page *page)
> >                * We should make sure that the page is already on the free list
> >                * when it is dissolved.
> >                */
> > -             if (unlikely(!PageHugeFreed(head)))
> > +             if (unlikely(!PageHugeFreed(head))) {
> > +                     rc = -EAGAIN;
> >                       goto out;
> > +             }
> >
> >               /*
> >                * Move PageHWPoison flag from head page to the raw error page,
> > @@ -1857,7 +1860,10 @@ int dissolve_free_huge_pages(unsigned long start_pfn, unsigned long end_pfn)
> >
> >       for (pfn = start_pfn; pfn < end_pfn; pfn += 1 << minimum_order) {
> >               page = pfn_to_page(pfn);
> > +retry:
> >               rc = dissolve_free_huge_page(page);
> > +             if (rc == -EAGAIN)
> > +                     goto retry;
> >               if (rc)
> >                       break;
> >       }
> >
