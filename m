Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADABC2EFDA8
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jan 2021 05:11:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726660AbhAIEIl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 23:08:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725861AbhAIEIl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 23:08:41 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE49CC061573
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jan 2021 20:08:00 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id c132so8926431pga.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jan 2021 20:08:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SZPu9nK08b09RVlqMCyYU/QJHO8hBuENpyc+FPiZxx4=;
        b=bvChS53t6XLwHp/0ONK5leV7w8i1/FYS2NKsdhhV725OlZXkuAbvr5JMSvPL/nHUn3
         W4/XHTuTwAd5zebe6ptOL4+l/gEssd4lSDlLxdEkSsABYc2oeLgDsl1KjSFTI2JbDZVk
         TeV9EHDemdaj9K/FdaA8Awf0UD5GJBQEWIM+uFMZq9qxwgiXZG0XeslSCDBkyThPNIf+
         wq3k338YeSEKI2qB0KthP2QPqZ/6YrYqWzZsQajI2mENl6wYMjT9/yWl9h/UOi9WKevz
         08ZsVlF8qJ0ydDmk3D9Wy/PzmMN61CFuCGQNLwCX9PH6UzPI9GdvokM1sRRaHEmKd6vA
         auNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SZPu9nK08b09RVlqMCyYU/QJHO8hBuENpyc+FPiZxx4=;
        b=Q7pY59Mk5OO+Xu70pBTFxabmpvyI+InxBEkfSRW6XIKMbgqWfDe3z0dENh9MC/cdJO
         twg0mNXtImvy908n2yfRXInRtN1JqKITr6zCfi6dcDaZ1Jg5VyxMdjTmdFn8/UTwGFDz
         /VWLFRcpg0c1/lIcD1hunGrbsUG4CngNULHxOI4N6Y44QOTXHkXdQpuLVrIQYletwTwW
         g6ANZAWohDt65nYOsWiDEfgSLNT5Aq8EgQlFh9E/vcF7nnOK7XGs65Z++fTM0cSbefGo
         VeH3kEcmAyle8rZ2Kp/Ida5xInbWPpj0YJ29UMxYdMSwDPiXdNkaRtbevUaxsEzhtnBV
         Y+4A==
X-Gm-Message-State: AOAM531UELx9fRePZdTGljAoVSkXkyZyi+zAe4CcN5L62JWuK+PTZOjD
        DNJ0aT6LL9mqkKqYfgqoLIQ2CcM3qeoizhle1/BbLue6tI9IGwMwqv0=
X-Google-Smtp-Source: ABdhPJwChhhLJQdjQOhNCEjwFG4xdIa4EhmH/fZbdCjfBgqbW90733XcI6EKfORtvwxzDCaOka3sUviA3DIpfFNfd+U=
X-Received: by 2002:aa7:8701:0:b029:19e:561:d476 with SMTP id
 b1-20020aa787010000b029019e0561d476mr6764399pfo.2.1610165279628; Fri, 08 Jan
 2021 20:07:59 -0800 (PST)
MIME-Version: 1.0
References: <20210106084739.63318-1-songmuchun@bytedance.com>
 <20210106084739.63318-7-songmuchun@bytedance.com> <b4777be4-fa76-4e71-8659-7d0820005028@oracle.com>
In-Reply-To: <b4777be4-fa76-4e71-8659-7d0820005028@oracle.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Sat, 9 Jan 2021 12:07:21 +0800
Message-ID: <CAMZfGtUkUq_8pnL9SY+aA=TBx5aJx0x+32qKQ5r+yB-q2STN6g@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v2 6/6] mm: hugetlb: remove VM_BUG_ON_PAGE
 from page_huge_active
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

On Sat, Jan 9, 2021 at 6:24 AM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>
> On 1/6/21 12:47 AM, Muchun Song wrote:
> > The page_huge_active() can be called from scan_movable_pages() which
> > do not hold a reference count to the HugeTLB page. So when we call
> > page_huge_active() from scan_movable_pages(), the HugeTLB page can
> > be freed parallel. Then we will trigger a BUG_ON which is in the
> > page_huge_active() when CONFIG_DEBUG_VM is enabled. Just remove the
> > VM_BUG_ON_PAGE.
> >
> > Fixes: 7e1f049efb86 ("mm: hugetlb: cleanup using paeg_huge_active()")
> > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
> > ---
> >  mm/hugetlb.c | 1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> > index 67200dd25b1d..7a24ed28ec4f 100644
> > --- a/mm/hugetlb.c
> > +++ b/mm/hugetlb.c
> > @@ -1372,7 +1372,6 @@ struct hstate *size_to_hstate(unsigned long size)
> >   */
> >  bool page_huge_active(struct page *page)
> >  {
> > -     VM_BUG_ON_PAGE(!PageHuge(page), page);
> >       return PageHead(page) && PagePrivate(&page[1]);
> >  }
>
> After more thought, should that return statement be changed to?
>         return PageHeadHuge(page) && PagePrivate(&page[1]);

Agree.

>
> We only want to test that PagePrivate flag for hugetlb head pages.
> Although, the possibility that the hugetlb page was freed and turned
> into another compound page in this race window is REALLY small.

Yeah. Thanks. I will update to PageHeadHuge().

> --
> Mike Kravetz
