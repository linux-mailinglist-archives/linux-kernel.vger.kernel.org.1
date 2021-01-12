Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1509F2F3394
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 16:08:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727930AbhALPHN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 10:07:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725984AbhALPHN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 10:07:13 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D270C061786
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 07:06:32 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id j13so1853251pjz.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 07:06:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lO4Anqp0yO5boP1OoXosqJ6kbnGa8KHmQ/06aGjVmlM=;
        b=qMvcGQxOGkrAwkonqvVmwpr3suy6jYXi3szVuW3o/UYvBAJv/yL1w2HzCmyZz5JxF5
         FqnQOyiFVr//0VKwQ+0A7jOv9Ts8G/Y6yPCivxr3byMV8kZmt0ORit0Okq76LfViINp3
         aYDpvaO09YxGIk7uymD9R+M+IpgyYykXYlCPqxq6MVqODvZrBtBTS3ai7Ot/zKjTOzuO
         RGT12fsxanbun9E+Qt8fwo9ksObLc3s1Ptq7LfmEoO9Ku+oIv3M2C9PSVhQXG39x5XA+
         sOrXsRtvmBy3Q6Iz//gSBSgtV9k7kYjPZTcda1HGngDFG4bJtxX9/wqI8SOyiz4ZIaIH
         2WSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lO4Anqp0yO5boP1OoXosqJ6kbnGa8KHmQ/06aGjVmlM=;
        b=IU+TP30Kag82cerTRQMi7AfSFAxS2LwdOBvhVOjPjktSVTlliD53N3v87SwtY1wkmm
         cykjb51318tdADF8GlacowPlW6/E0cF5vDSrtzMampT/3v/bZxgVq3OeSQJDdNUIW/ga
         tKhidaip0TeGTSaqlI54WZWvgWQBKHFwQ+7ooqOuz6F3FkscwXzOHMWQjXtUveUda7P8
         2+dYmAi2T96b2fJAT2Oc2WSnnLiJ4Cz9AdDfTYglAaxzZJe4JcePDCtqpfK/B8laL///
         IAIiwBHUerHD50lbaZFRkqF2UeR7AQSRYS17+vzOWhevPeJRIK4YuRZX0ay0eRRn+/5o
         Bedg==
X-Gm-Message-State: AOAM532LoANeh/Qx5t95NyUxR+V8lrQ7K+hZBLG1T6bUNWEHofw4vRgb
        EF6PJHklrj0TMBqZQsj2jRLnkWHT7GKqNnbN2Un2Iw==
X-Google-Smtp-Source: ABdhPJzOWoiSLHOSdhVWD1LgGI5laVjW58Nny6nHyBuLLSjOnoMW3JkaIUSXdHu5HjHDqQTBWv+gUItBeOl7iL7t3/E=
X-Received: by 2002:a17:90a:c588:: with SMTP id l8mr5083968pjt.147.1610463991728;
 Tue, 12 Jan 2021 07:06:31 -0800 (PST)
MIME-Version: 1.0
References: <20210110124017.86750-1-songmuchun@bytedance.com>
 <20210110124017.86750-4-songmuchun@bytedance.com> <20210112100213.GK22493@dhcp22.suse.cz>
 <CAMZfGtVJVsuL39owkT+Sp8A7ywXJLhbiQ6zYgL9FKhqSeAvy=w@mail.gmail.com>
 <20210112111712.GN22493@dhcp22.suse.cz> <CAMZfGtWt5+03Pne9QjLn53kqUbZWSmi0f-iEOisHO6LjohdXFA@mail.gmail.com>
 <20210112123738.GQ22493@dhcp22.suse.cz>
In-Reply-To: <20210112123738.GQ22493@dhcp22.suse.cz>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Tue, 12 Jan 2021 23:05:50 +0800
Message-ID: <CAMZfGtU1Eh91mcMMz=Z7S_3boreu9r=Xzw0=reRZ=FEdyJ_MXQ@mail.gmail.com>
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

On Tue, Jan 12, 2021 at 8:37 PM Michal Hocko <mhocko@suse.com> wrote:
>
> On Tue 12-01-21 19:43:21, Muchun Song wrote:
> > On Tue, Jan 12, 2021 at 7:17 PM Michal Hocko <mhocko@suse.com> wrote:
> > >
> > > On Tue 12-01-21 18:13:02, Muchun Song wrote:
> > > > On Tue, Jan 12, 2021 at 6:02 PM Michal Hocko <mhocko@suse.com> wrote:
> > > > >
> > > > > On Sun 10-01-21 20:40:14, Muchun Song wrote:
> > > > > [...]
> > > > > > @@ -1770,6 +1788,14 @@ int dissolve_free_huge_page(struct page *page)
> > > > > >               int nid = page_to_nid(head);
> > > > > >               if (h->free_huge_pages - h->resv_huge_pages == 0)
> > > > > >                       goto out;
> > > > > > +
> > > > > > +             /*
> > > > > > +              * We should make sure that the page is already on the free list
> > > > > > +              * when it is dissolved.
> > > > > > +              */
> > > > > > +             if (unlikely(!PageHugeFreed(head)))
> > > > > > +                     goto out;
> > > > > > +
> > > > >
> > > > > Do you really want to report EBUSY in this case? This doesn't make much
> > > > > sense to me TBH. I believe you want to return 0 same as when you race
> > > > > and the page is no longer PageHuge.
> > > >
> > > > Return 0 is wrong. Because the page is not freed to the buddy allocator.
> > > > IIUC, dissolve_free_huge_page returns 0 when the page is already freed
> > > > to the buddy allocator. Right?
> > >
> > > 0 is return when the page is either dissolved or it doesn't need
> > > dissolving. If there is a race with somebody else freeing the page then
> > > there is nothing to dissolve. Under which condition it makes sense to
> > > report the failure and/or retry dissolving?
> >
> > If there is a race with somebody else freeing the page, the page
> > can be freed to the hugepage pool not the buddy allocator. Do
> > you think that this page is dissolved?
>
> OK, I see what you mean. Effectively the page would be in a limbo, not
> yet in the pool nor in the allocator but it can find its way to the
> either of the two. But I still dislike returning a failure because that
> would mean e.g. memory hotplug to fail. Can you simply retry inside this
> code path (drop the lock, cond_resched and retry)?

Yeah. This is what I want to do (making the memory hotplug as
successful as possible). So I send the patch:

  [PATCH v3 4/6] mm: hugetlb: add return -EAGAIN for dissolve_free_huge_page

Adding a simple retry inside this function when hitting this race is
also fine to me. I can do that.




> --
> Michal Hocko
> SUSE Labs
