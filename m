Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF04E2F8B4A
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jan 2021 05:38:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726435AbhAPEiQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 23:38:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbhAPEiP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 23:38:15 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A221AC061757
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 20:37:35 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id b3so6808284pft.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 20:37:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/GEsUv4XPzp2MAebK25e+QPQSWvvym5bBrV9gTaI2uU=;
        b=PTL44zbSHBr+2NKLTgq1CeR+ITIvn+69xRddTN/3yMQBqqTd2J7ngNdloqZ5X5W4Vf
         dogd6iuy3sQm5uR7tmmrnHy6yipi2qhuAUFiSjBlVqklxz3CbOMROHJkpEQs0EmITT9f
         0zIbIDqDPrzGz46adV8ehn+C++1vk0dKpdtA8fBEuqiobmMsxqPuXv5b/7EHxga5D42C
         5itiiaPEs8T4Ed7lgAYHCM9gM0SSp/Qnb5IN+Fak3hEAEKnRoDsDMSrdZzDagVPfP0AD
         KenkTFc/wkSfwL0KiplKVpH1i0BIDFKVL2gBAhrYARLmxCrbV12syj/38oJTnKbFek+U
         DTkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/GEsUv4XPzp2MAebK25e+QPQSWvvym5bBrV9gTaI2uU=;
        b=NGHqQ3Of8NEJpL2c7zGelUUVmK/nZSg2lIkJDyE7nQyp4CUdUh1oY7RQ4g94wsZFNn
         nPBzWEqS9iuc/bcPK6l94nveUgwfkRS5g1utjHRMpLdIWGTnVlnsingtBXS80SGxUZUZ
         AtcNziWDiEMtT6Ieiaew7wH3zQklZz6Pz5uoUg2z3BNdK/MYfwxKVmt/Og7j9rgT95AR
         G0vxIl0wGSp7fKyPDw/bJfqjyF0j9Yo/Oi5lTMZQOSP1Mg5QpqLp9W123GQnEdPnhZ4O
         HUNy633mn4Y9f2z5CjOotsNao2Z7gHDWet3uDA6bpP/2Cnzw3Kv+s8tVvr8clHenpydZ
         CqvA==
X-Gm-Message-State: AOAM533iHh4moPqVaU4hoZfdjcE7Aleh4A9Dd3FPaXff0S/EPClf+EI4
        q2G9cCF9FKC6J8UkeF5zVT9dcLonW6ObY4YyADXaTg==
X-Google-Smtp-Source: ABdhPJw6auAbwUc0+HRs4bF+JukQbPjxez5J6xRY1baJNaOgs4+OwLuDT63KPd5jpF5UHKrsdydTkQPbtaqmosUt+0E=
X-Received: by 2002:a63:480f:: with SMTP id v15mr15925182pga.341.1610771855128;
 Fri, 15 Jan 2021 20:37:35 -0800 (PST)
MIME-Version: 1.0
References: <20210116003105.182918-1-mike.kravetz@oracle.com>
 <20210116003105.182918-3-mike.kravetz@oracle.com> <20210116042416.GA2260413@casper.infradead.org>
In-Reply-To: <20210116042416.GA2260413@casper.infradead.org>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Sat, 16 Jan 2021 12:36:55 +0800
Message-ID: <CAMZfGtWt9g9a3cQUj-E8JS5yVe_V7Gj7eY9+61djeXJ2zdgFKg@mail.gmail.com>
Subject: Re: [External] Re: [PATCH 2/5] hugetlb: convert page_huge_active() to
 HP_Migratable flag
To:     Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Michal Hocko <mhocko@kernel.org>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 16, 2021 at 12:26 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Fri, Jan 15, 2021 at 04:31:02PM -0800, Mike Kravetz wrote:
> > +++ b/fs/hugetlbfs/inode.c
> > @@ -735,7 +735,7 @@ static long hugetlbfs_fallocate(struct file *file, int mode, loff_t offset,
> >
> >               mutex_unlock(&hugetlb_fault_mutex_table[hash]);
> >
> > -             set_page_huge_active(page);
> > +             hugetlb_set_page_flag(page, HP_Migratable);
>
> I had understood the request to be more like ...
>
>                 SetHPageMigratable(page);
>
> > +++ b/include/linux/hugetlb.h
> > @@ -480,9 +480,13 @@ unsigned long hugetlb_get_unmapped_area(struct file *file, unsigned long addr,
> >   * HP_Restore_Reserve - Set when a hugetlb page consumes a reservation at
> >   *   allocation time.  Cleared when page is fully instantiated.  Free
> >   *   routine checks flag to restore a reservation on error paths.
> > + * HP_Migratable - Set after a newly allocated page is added to the page
> > + *   cache and/or page tables.  Indicates the page is a candidate for
> > + *   migration.
> >   */
> >  enum hugetlb_page_flags {
> >       HP_Restore_Reserve = 0,
> > +     HP_Migratable,
> >  };
>
> and name these HPG_restore_reserve and HPG_migratable
>
> and generate the calls to hugetlb_set_page_flag etc from macros, eg:
>
> #define TESTHPAGEFLAG(uname, lname)                                     \
> static __always_inline bool HPage##uname(struct page *page)             \
> { return test_bit(HPG_##lname, &page->private); }
> ...
> #define HPAGEFLAG(uname, lname)                                         \
>         TESTHPAGEFLAG(uname, lname)                                     \
>         SETHPAGEFLAG(uname, lname)                                      \
>         CLEARHPAGEFLAG(uname, lname)
>
> HPAGEFLAG(RestoreReserve, restore_reserve)
> HPAGEFLAG(Migratable, migratable)
>
> just to mirror page-flags.h more closely.

I prefer this suggestion. I also made the same suggestion in the
previous RFC version.
