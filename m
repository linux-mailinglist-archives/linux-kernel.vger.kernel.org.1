Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CBAF2F32D4
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 15:21:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728787AbhALOTH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 09:19:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbhALOTG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 09:19:06 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DA1AC061786
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 06:18:26 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id z21so1543190pgj.4
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 06:18:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZP/OKsBTHa1Ku/1C8+jY1uZ9XXWnbjWQbbJ1iqiQI90=;
        b=KXJDcyT04KY1E1/QvWwWjUF36RQI+5Bu+t3pUk2IHBywPVmHdqc+vzoj6oysXqV9RT
         U357Xxhes9/2bjHM8hT2AKu97rn+qbyiAC/hTrSSHupPcpPEzGvuaHx9KHUY1bXWOSWI
         FdXitRT2Wj6V+xJFgjqWpqzgGrumEPB12ESZ0NYtdDoaV9weEiBbEmuHNkblO/dquesr
         3fA21BrKCYy262yV7usZurMZwsjpyKY1apcI9hJU2/DyA/k+Kl4kWvrUPNoViA6SC0nL
         dfgI2d1OHb15tB2ry8KHen2cQEqXwIF5i6RViXC68QYIq0e7WE8m23+vXPKXUyJ4v0lE
         Vjwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZP/OKsBTHa1Ku/1C8+jY1uZ9XXWnbjWQbbJ1iqiQI90=;
        b=TQjE5m0dYDxNK2IhgvEz1Pisbfas4kNJ/XfxSe3BxKGblBcaVlXY/wjAftb4pzUBUA
         mDBwLcEbXRO4xPTSb/Bx6ghJiJzoiS/J8d/7Kc4bIRE188M5ctdIlvjH8JRvYo5j3O1H
         H531e1birOwtrPc+jV8aR5FXShhskZJ4seEyzVMTgYIZomBqJSltwJcE7NENtwJ8hrU1
         6Z7MlSbaJquySWgBc6CTdqND02NvW9pf2uqonc59vEnb4xVi2wWrc5LrepyCrjcFIJnz
         KJmM6i4BtpMxeFjDKmjfSXtivjtD0XUMlkhojZzsXMNfd9ndzBjTLGdT6DslnTi1i7UO
         DQlg==
X-Gm-Message-State: AOAM5313r7Gj/Tf2bWOjvGYv9Vy0E4sJz6SHhaFgcEBRWhl+nrAxIcpm
        av/LFcdubz4OTLs/dx34yIK2tCzPIKImbnSndz/cZw==
X-Google-Smtp-Source: ABdhPJymg7ZZpekPq1atCLekTkcjQv4GQ0IAuUDaK2XbFHH8P04lOSQ9bOJNTYSLi5qlu4NStP7+Xv+mzMDUmx1MI+I=
X-Received: by 2002:a63:50a:: with SMTP id 10mr4974342pgf.273.1610461106114;
 Tue, 12 Jan 2021 06:18:26 -0800 (PST)
MIME-Version: 1.0
References: <20210110124017.86750-1-songmuchun@bytedance.com>
 <20210110124017.86750-2-songmuchun@bytedance.com> <1b39d654-0b8c-de3a-55d1-6ab8c2b2e0ba@redhat.com>
 <c6eddfc6-8e15-4a28-36ff-64bfa65cca8e@redhat.com> <CAMZfGtWnATsqgdqVONgAFWAAJU=KGxVJQEt38b8JTV+UtRzkYw@mail.gmail.com>
 <423ee403-bba7-acf6-8934-9db36d3a719a@redhat.com>
In-Reply-To: <423ee403-bba7-acf6-8934-9db36d3a719a@redhat.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Tue, 12 Jan 2021 22:17:42 +0800
Message-ID: <CAMZfGtXfA6JA3eYLhT8YGLJJocopix_mp7uSDPfcmooFEE7xNA@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v3 1/6] mm: migrate: do not migrate HugeTLB
 page whose refcount is one
To:     David Hildenbrand <david@redhat.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Andi Kleen <ak@linux.intel.com>, mhocko@suse.cz,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Yang Shi <shy828301@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 12, 2021 at 9:51 PM David Hildenbrand <david@redhat.com> wrote:
>
> On 12.01.21 14:40, Muchun Song wrote:
> > On Tue, Jan 12, 2021 at 7:11 PM David Hildenbrand <david@redhat.com> wrote:
> >>
> >> On 12.01.21 12:00, David Hildenbrand wrote:
> >>> On 10.01.21 13:40, Muchun Song wrote:
> >>>> If the refcount is one when it is migrated, it means that the page
> >>>> was freed from under us. So we are done and do not need to migrate.
> >>>>
> >>>> This optimization is consistent with the regular pages, just like
> >>>> unmap_and_move() does.
> >>>>
> >>>> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> >>>> Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
> >>>> Acked-by: Yang Shi <shy828301@gmail.com>
> >>>> ---
> >>>>  mm/migrate.c | 6 ++++++
> >>>>  1 file changed, 6 insertions(+)
> >>>>
> >>>> diff --git a/mm/migrate.c b/mm/migrate.c
> >>>> index 4385f2fb5d18..a6631c4eb6a6 100644
> >>>> --- a/mm/migrate.c
> >>>> +++ b/mm/migrate.c
> >>>> @@ -1279,6 +1279,12 @@ static int unmap_and_move_huge_page(new_page_t get_new_page,
> >>>>              return -ENOSYS;
> >>>>      }
> >>>>
> >>>> +    if (page_count(hpage) == 1) {
> >>>> +            /* page was freed from under us. So we are done. */
> >>>> +            putback_active_hugepage(hpage);
> >>>> +            return MIGRATEPAGE_SUCCESS;
> >>>> +    }
> >>>> +
> >>>>      new_hpage = get_new_page(hpage, private);
> >>>>      if (!new_hpage)
> >>>>              return -ENOMEM;
> >>>>
> >>>
> >>> Question: What if called via alloc_contig_range() where we even want to
> >>> "migrate" free pages, meaning, relocate it?
> >>>
> >>
> >> To be more precise:
> >>
> >> a) We don't have dissolve_free_huge_pages() calls on the
> >> alloc_contig_range() path. So we *need* migration IIUC.
> >
> > Without this patch, if you want to migrate a HUgeTLB page,
> > the page is freed to the hugepage pool. With this patch,
> > the page is also freed to the hugepage pool.
> > I didn't see any different. I am missing something?
>
> I am definitely not an expert on hugetlb pools, that's why I am asking.
>
> Isn't it, that with your code, no new page is allocated - so
> dissolve_free_huge_pages() might just refuse to dissolve due to
> reservations, bailing out, no?

Without this patch, the new page can be allocated from the
hugepage pool. The dissolve_free_huge_pages() also
can refuse to dissolve due to reservations. Right?

>
> (as discussed, looks like alloc_contig_range() needs to be fixed to
> handle this correctly)
>
> --
> Thanks,
>
> David / dhildenb
>
