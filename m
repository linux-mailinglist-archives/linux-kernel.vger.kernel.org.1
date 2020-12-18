Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C00E82DE07E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 10:43:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733028AbgLRJmp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Dec 2020 04:42:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725870AbgLRJmo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Dec 2020 04:42:44 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FDEAC0617A7
        for <linux-kernel@vger.kernel.org>; Fri, 18 Dec 2020 01:42:04 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id t22so1224256pfl.3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Dec 2020 01:42:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Pqqg8DDqW0mYjxSRT2ri8wFtsthaAPGXwdPj8g0F1AM=;
        b=qQsxvCxsK5tYahBEkEGFTy+EGjEclNaaIU2qx50C9G6MvIXlWULspeHYmmaCiqsSvy
         19Fx7fbCVuSmNGp4VYK9bg/sero4jC6yP4BsHz2dMgiOAhSDmR9PnUQ+r+mnIpdMhe1s
         y8WKc4stNLOllpzlUKAPd6N1sxYtjtYR+BgvhnofZ0luUR39sXhjueW4phwDZlfbLT20
         feJkPbLxIQge7SV9dMweCaGG9VajK0LVj0nR7s82uMi4jUliFp3/oRK+dXDNpOn6sVeb
         9XonvaeSdu+/lktpb/NGH5vqd3yHkDyKt/phhL/f8pzoSmb1IgruCMdX0uhnjCWj04eW
         PN1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Pqqg8DDqW0mYjxSRT2ri8wFtsthaAPGXwdPj8g0F1AM=;
        b=Ov47J9hXhJFRyqiG2FYMrmAyVR5HRfeh5IEB5vLAI581sN5oOgftlRCL0xrOED4wAy
         lNvlsKx+cZ2fcOAbelAk0IkWxRqzPazfq4Mn6fbzrXGWNKCWSvtzI4R10f2d9g0l2oQj
         M/Xp0tiAAunACFaMXz7eK4k7baEy8s3dzD4ysikHrQKOqAT5BAdRC5EwTQJYSVO6HD98
         YqIuTqS8269yECzLc1lV8o3RAWZx//BJg+oVDy9vQd3SajoDBk2ly+LlZZhps1sI/ZxV
         KMPSKRmbCKkFwIXQajR2hEXfJMeASbkh08WLRXCFqAjpin15pv3/+Of2tkzuHvi6dYFJ
         XOHw==
X-Gm-Message-State: AOAM531kvlMUsZpAxFI/K5QjWqXdI7WBGq/01//zczqgyE7RIif0Fycf
        z6toqp2F5pZVFynswhCjL41aL0NJI3sGn8zBgmePfA==
X-Google-Smtp-Source: ABdhPJx2YShUHAdmKlbD92/q4ID8magiF7CQMaMINDxCXVqJQV0vu71BObO+Mx6j5v7VeR91fgNZ+3CY/NCm9NVn2fo=
X-Received: by 2002:aa7:8701:0:b029:19e:561:d476 with SMTP id
 b1-20020aa787010000b029019e0561d476mr3558941pfo.2.1608284523546; Fri, 18 Dec
 2020 01:42:03 -0800 (PST)
MIME-Version: 1.0
References: <20201217121303.13386-1-songmuchun@bytedance.com>
 <20201217121303.13386-11-songmuchun@bytedance.com> <20201218090631.GA3623@localhost.localdomain>
In-Reply-To: <20201218090631.GA3623@localhost.localdomain>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Fri, 18 Dec 2020 17:41:24 +0800
Message-ID: <CAMZfGtW1uMwdLC-VeBV-7FT5rVborUphfvZex71CGcDPLU5TRg@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v10 10/11] mm/hugetlb: Gather discrete
 indexes of tail page
To:     Oscar Salvador <osalvador@suse.de>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org,
        Peter Zijlstra <peterz@infradead.org>, viro@zeniv.linux.org.uk,
        Andrew Morton <akpm@linux-foundation.org>, paulmck@kernel.org,
        mchehab+huawei@kernel.org, pawan.kumar.gupta@linux.intel.com,
        Randy Dunlap <rdunlap@infradead.org>, oneukum@suse.com,
        anshuman.khandual@arm.com, jroedel@suse.de,
        Mina Almasry <almasrymina@google.com>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>,
        David Hildenbrand <david@redhat.com>, naoya.horiguchi@nec.com,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 18, 2020 at 5:06 PM Oscar Salvador <osalvador@suse.de> wrote:
>
> On Thu, Dec 17, 2020 at 08:13:02PM +0800, Muchun Song wrote:
> > diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> > index 6c02f49959fd..78dd88dda857 100644
> > --- a/mm/hugetlb.c
> > +++ b/mm/hugetlb.c
> > @@ -1360,7 +1360,7 @@ static inline void hwpoison_subpage_deliver(struct hstate *h, struct page *head)
> >       if (!PageHWPoison(head) || !free_vmemmap_pages_per_hpage(h))
> >               return;
> >
> > -     page = head + page_private(head + 4);
> > +     page = head + page_private(head + SUBPAGE_INDEX_HWPOISON);
> >
> >       /*
> >        * Move PageHWPoison flag from head page to the raw error page,
> > @@ -1379,7 +1379,7 @@ static inline void hwpoison_subpage_set(struct hstate *h, struct page *head,
> >               return;
> >
> >       if (free_vmemmap_pages_per_hpage(h)) {
> > -             set_page_private(head + 4, page - head);
> > +             set_page_private(head + SUBPAGE_INDEX_HWPOISON, page - head);
>
> Ok, I was too eager here.
>
> If CONFIG_HUGETLB_PAGE_FREE_VMEMMAP is not set for whatever reason
> (e.g: CONFIG_MEMORY_HOTREMOVE is disabled), when you convert "+4"
> to its index (SUBPAGE_INDEX_HWPOISON), this will no longer build
> since we only define SUBPAGE_INDEX_HWPOISON when the config
> option CONFIG_HUGETLB_PAGE_FREE_VMEMMAP is set.

Yeah, it is my mistake. Thanks for pointing that out.

>
> Different things can be done to fix this:
>
> e.g:
>
>  - Define a two different hwpoison_subpage_{deliver,set}
>    and have them under
>    #ifdef CONFIG_HUGETLB_PAGE_FREE_VMEMMAP
>    ...
>    #else
>    ...
>    #endif
>
>  - Work it around as is with IS_ENABLED(CONFIG_HUGETLB_...
>  - Have a common entry and decide depending on whether
>    the config is enabled.
>
> I guess option #1 might be cleaner.

Thanks for your suggestion. I also prefer option #1.

>
> --
> Oscar Salvador
> SUSE L3



-- 
Yours,
Muchun
