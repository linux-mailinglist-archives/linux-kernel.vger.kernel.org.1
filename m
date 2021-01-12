Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD3DC2F2E3B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 12:45:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730433AbhALLoq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 06:44:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728431AbhALLoq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 06:44:46 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1331C061786
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 03:44:05 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id m5so1490316pjv.5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 03:44:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YXgK4lRZ9KFIZd6/lO39RKwyKYxTIqhJvO9L+itxVOY=;
        b=E1kst2tXTMFQJDZxPRDVfYPneeubPmbOWsFnTQkvuSZg5zvYvD5+0yEDnDF8qkN9BP
         657+XVe9yrBS8clnMKfyqIIXgqpjvTu0N/NyQaNuLNJWORC4xiZaWRM9xjtlySkNwsM0
         1sDaGLVgx0CnUDPNjy5TqE+G96ULAOU5uOPodXuDdidheJZcvoiodrTwOG2K7N0AaJnH
         umaVi13EGBZKbAH1CAhghwHP3x+vry3WyI20ngDXJh+C2FhyftdlH/HWK9MzjKp0pWMC
         DRZY1fbhTn3YmOVtsOhcJwHFwsJJ/S9l2vvD4t3E6RlAwaVvxDUgBHNNVU9uv28yAzAr
         4JfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YXgK4lRZ9KFIZd6/lO39RKwyKYxTIqhJvO9L+itxVOY=;
        b=aERArHy7pJcJ9yafZFFalL4ApI7q607d0hGO1PHT8sKzN0G9+AOSLbsX0tLE5fNFxG
         cbR1FRkU2Y0SnllUu72OJc1JpaGSAhlmy01OhXa1cAeJd1ITptPPngDJl4bQzjdvtNmW
         rXOGMVK6/NIdwOO3YIJayv3DuZcWqqGxxVL/qbrhmbdxUgYNTk/8+v+qA4Q9ynhJX/YM
         MS9voIAQkhkIlJ4hJmZ7RvYxZWz2uv/hP1/c9QxuPA80NnQDYR2PzBrLVaGzp580fiYd
         KMVqvxmeKk8BJwB6o8Wc+HtWKRhFDT/+EvGJ575kkDwCV6COgnGc/W2sDnvp2vJfOma2
         5Sfw==
X-Gm-Message-State: AOAM531NoPCNuG/LAfuI2dn88KmPYj5glXfleXjLfBf8oV5OhBUntsaJ
        e44m/QavyPlCBUF081mr9PtJUkBRRW3v51CwyIb0Uw==
X-Google-Smtp-Source: ABdhPJwhJTuvwURefw5F76iCXx8fAufBEOUt+yDBCmtfhDnc12TggdrqEgSGxOoLHs+vnRoKR3Pm9R4V3jihjOTSA1s=
X-Received: by 2002:a17:90a:ba88:: with SMTP id t8mr4162139pjr.229.1610451844939;
 Tue, 12 Jan 2021 03:44:04 -0800 (PST)
MIME-Version: 1.0
References: <20210110124017.86750-1-songmuchun@bytedance.com>
 <20210110124017.86750-4-songmuchun@bytedance.com> <20210112100213.GK22493@dhcp22.suse.cz>
 <CAMZfGtVJVsuL39owkT+Sp8A7ywXJLhbiQ6zYgL9FKhqSeAvy=w@mail.gmail.com> <20210112111712.GN22493@dhcp22.suse.cz>
In-Reply-To: <20210112111712.GN22493@dhcp22.suse.cz>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Tue, 12 Jan 2021 19:43:21 +0800
Message-ID: <CAMZfGtWt5+03Pne9QjLn53kqUbZWSmi0f-iEOisHO6LjohdXFA@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v3 3/6] mm: hugetlb: fix a race between
 freeing and dissolving the page
To:     Michal Hocko <mhocko@suse.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Andi Kleen <ak@linux.intel.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux- stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 12, 2021 at 7:17 PM Michal Hocko <mhocko@suse.com> wrote:
>
> On Tue 12-01-21 18:13:02, Muchun Song wrote:
> > On Tue, Jan 12, 2021 at 6:02 PM Michal Hocko <mhocko@suse.com> wrote:
> > >
> > > On Sun 10-01-21 20:40:14, Muchun Song wrote:
> > > [...]
> > > > @@ -1770,6 +1788,14 @@ int dissolve_free_huge_page(struct page *page)
> > > >               int nid = page_to_nid(head);
> > > >               if (h->free_huge_pages - h->resv_huge_pages == 0)
> > > >                       goto out;
> > > > +
> > > > +             /*
> > > > +              * We should make sure that the page is already on the free list
> > > > +              * when it is dissolved.
> > > > +              */
> > > > +             if (unlikely(!PageHugeFreed(head)))
> > > > +                     goto out;
> > > > +
> > >
> > > Do you really want to report EBUSY in this case? This doesn't make much
> > > sense to me TBH. I believe you want to return 0 same as when you race
> > > and the page is no longer PageHuge.
> >
> > Return 0 is wrong. Because the page is not freed to the buddy allocator.
> > IIUC, dissolve_free_huge_page returns 0 when the page is already freed
> > to the buddy allocator. Right?
>
> 0 is return when the page is either dissolved or it doesn't need
> dissolving. If there is a race with somebody else freeing the page then
> there is nothing to dissolve. Under which condition it makes sense to
> report the failure and/or retry dissolving?

If there is a race with somebody else freeing the page, the page
can be freed to the hugepage pool not the buddy allocator. Do
you think that this page is dissolved?

> --
> Michal Hocko
> SUSE Labs
