Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B54B2EC874
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 04:01:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727164AbhAGDAP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 22:00:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726780AbhAGC74 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 21:59:56 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D767C0612F4
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jan 2021 18:58:46 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id a188so2948248pfa.11
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jan 2021 18:58:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Lbh0iTv5BrEfqhngJcXksbTE1AiUdN7XVO3JJGizBjs=;
        b=N7gk1rOXnoWGrYbQDh34Ue+Q1rmAmCB8IRWvvbstzfvKHrshEkONZ/NuIq9gt6Lx6q
         r7IgIQn8ybHd6lQU/x16WkdHhPAh05CxlAXArnwKb+A8qNpXrQvukPcwfP25DahfBJjn
         rx5eP0cFx+MLAhWAMNiOub7Et0XrjeMQKG4qoTVHl/s83i0PH1STbtdoEBoCbOb1pdnC
         yWshY/RCHTf3ZXmKWG60mEp2HflTHJaFjrHBNq8GA7CMhh2pnzORYAndYo1myHlwvTFu
         k27/+4fKgUyPiE901+YvrJ9S3kUWrLqEcd5Wan4ZQdEUZ/z3PHJTkkbZDX1NjUY8He1X
         ivjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Lbh0iTv5BrEfqhngJcXksbTE1AiUdN7XVO3JJGizBjs=;
        b=XsfbT81TuyGsdYWXjq/jor8fgoGyhKpaEKYT82vZOi3SqYDnlCy+5SbUxfIs0fmMvw
         /Ntre8F0ol0vgaCrO8LjWNJFBppH1Lh3wYlpQ6YmvCTPTaG+qTfkmInJPFdJbWZKKHEj
         NwLhjx8YlhG1Zqb5FSccD/1nuUDZxgWLCnPjg0XLMTocr1JbzNJQ0cCRlhFbUjQaEtVp
         O352KMQLHpxOZxOEdLPmqwgQ8LcMInO+U86SxkjmQ7NJBOUYhqpv4BbuXyfm4OM8PDdv
         c8weEET/r7P4Q8D4vAy1u1weIQAF724k4KQTfO6EQpcohDWEC9ImWbQx0JDoA8oWS9LW
         JRKQ==
X-Gm-Message-State: AOAM5322JjM6hc82oGy9B22lU9MbEfk/cC1UkCBGGsWgkZKz/Hal0HUG
        TJk181h9eO+d7jHsQJIVR8h1tCgvic6SqrxAhuQjsw==
X-Google-Smtp-Source: ABdhPJyceDNR4Rcd3pyidd/fRRM3g/ukdzVRMqPO0DO3YGvh87zFtxB6UytQrMdvpk6EEF0Rbpn8KEUE3A03ggKWqPI=
X-Received: by 2002:a63:480f:: with SMTP id v15mr7543749pga.341.1609988325955;
 Wed, 06 Jan 2021 18:58:45 -0800 (PST)
MIME-Version: 1.0
References: <20210106084739.63318-1-songmuchun@bytedance.com>
 <20210106084739.63318-3-songmuchun@bytedance.com> <20210106163513.GS13207@dhcp22.suse.cz>
In-Reply-To: <20210106163513.GS13207@dhcp22.suse.cz>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Thu, 7 Jan 2021 10:58:08 +0800
Message-ID: <CAMZfGtX-znT_V0hn1V=+K+EpgDv_AyRUxX3+qN97H++=uZG67w@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v2 2/6] mm: hugetlbfs: fix cannot migrate
 the fallocated HugeTLB page
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

On Thu, Jan 7, 2021 at 12:35 AM Michal Hocko <mhocko@suse.com> wrote:
>
> On Wed 06-01-21 16:47:35, Muchun Song wrote:
> > Because we only can isolate a active page via isolate_huge_page()
> > and hugetlbfs_fallocate() forget to mark it as active, we cannot
> > isolate and migrate those pages.
>
> I've little bit hard time to understand this initially and had to dive
> into the code to make sense of it. I would consider the following
> wording easier to grasp. Feel free to reuse if you like.
> "
> If a new hugetlb page is allocated during fallocate it will not be
> marked as active (set_page_huge_active) which will result in a later
> isolate_huge_page failure when the page migration code would like to
> move that page. Such a failure would be unexpected and wrong.
> "

Thanks for your suggestion. I will reuse it.

>
> Now to the fix. I believe that this patch shows that the
> set_page_huge_active is just too subtle. Is there any reason why we
> cannot make all freshly allocated huge pages active by default?
>
> > Only export set_page_huge_active, just leave clear_page_huge_active
> > as static. Because there are no external users.
> >
> > Fixes: 70c3547e36f5 (hugetlbfs: add hugetlbfs_fallocate())
> > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > ---
> >  fs/hugetlbfs/inode.c    | 3 ++-
> >  include/linux/hugetlb.h | 2 ++
> >  mm/hugetlb.c            | 2 +-
> >  3 files changed, 5 insertions(+), 2 deletions(-)
> >
> > diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
> > index b5c109703daa..21c20fd5f9ee 100644
> > --- a/fs/hugetlbfs/inode.c
> > +++ b/fs/hugetlbfs/inode.c
> > @@ -735,9 +735,10 @@ static long hugetlbfs_fallocate(struct file *file, int mode, loff_t offset,
> >
> >               mutex_unlock(&hugetlb_fault_mutex_table[hash]);
> >
> > +             set_page_huge_active(page);
> >               /*
> >                * unlock_page because locked by add_to_page_cache()
> > -              * page_put due to reference from alloc_huge_page()
> > +              * put_page() due to reference from alloc_huge_page()
> >                */
> >               unlock_page(page);
> >               put_page(page);
> > diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> > index ebca2ef02212..b5807f23caf8 100644
> > --- a/include/linux/hugetlb.h
> > +++ b/include/linux/hugetlb.h
> > @@ -770,6 +770,8 @@ static inline void huge_ptep_modify_prot_commit(struct vm_area_struct *vma,
> >  }
> >  #endif
> >
> > +void set_page_huge_active(struct page *page);
> > +
> >  #else        /* CONFIG_HUGETLB_PAGE */
> >  struct hstate {};
> >
> > diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> > index 1f3bf1710b66..4741d60f8955 100644
> > --- a/mm/hugetlb.c
> > +++ b/mm/hugetlb.c
> > @@ -1348,7 +1348,7 @@ bool page_huge_active(struct page *page)
> >  }
> >
> >  /* never called for tail page */
> > -static void set_page_huge_active(struct page *page)
> > +void set_page_huge_active(struct page *page)
> >  {
> >       VM_BUG_ON_PAGE(!PageHeadHuge(page), page);
> >       SetPagePrivate(&page[1]);
> > --
> > 2.11.0
>
> --
> Michal Hocko
> SUSE Labs
