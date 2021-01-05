Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78FB72EA36F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 03:47:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727757AbhAECpz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 21:45:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726124AbhAECpz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 21:45:55 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCFB9C061574
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jan 2021 18:45:14 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id v1so826265pjr.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jan 2021 18:45:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4yUElh54ziqvnaYw/lR3NMZ3F3Mtb4o6tzGU6Ylom2Q=;
        b=DujKVO3d2mCQEEZxErsU9lpPFJgvhxlKBJ+QIpDglKDdEb0504AGv46al434FwKvWo
         A1Y/U4gAZ0ByNCedkRGfgxHw1BZyF51U/YBbBqVXKMizT1Qtt+mPGhB2BMZtDLZ2qUz5
         XbYCqYULiAag0MDrcQpee67LsH9LZHnTKohm5f40wL7eKWe8l9ZekWJOOO4HRMTM9bMw
         sd54braeYGnSOBqAsl3g2Vx0ZmV739Y61uOBE48JqpJy7bmLo4svzcKc9M08QsUWJhCk
         tgiIiYKy9STr1M/LDjrVSifX2xnxhnehe/QXJdHadbbq9MvdCJ0pFfnkNqUv6eZnR/gW
         uwiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4yUElh54ziqvnaYw/lR3NMZ3F3Mtb4o6tzGU6Ylom2Q=;
        b=UzwhvK3FSd1JzRVtiuOaiYaO5GBMrPXAVMdznNE4BFRWJhH1xmYNwUzGX73BfNgaN3
         TJC9sOW/g/t2VEoS+o0BI56Ajt4MEJbb+SXd7uPLGdkneMxbVhWiUg4rJdZCwssA6Liw
         HHgMc4NE++wEwtsdZeyvNgcp/oG7q7bDP26fwK+Bq6Kht4cqmVHZRHuijAh5RtUmEup8
         0YFD/tJBUy1gky89iqLkaenEogj/446SJ1qFBbMgpJNvd9cstVyRE3prRGM1fkKEmzSW
         hF8o4wCQw+oSoWATS5u0PbuzmfJX8kxPNUc81+gXXb3w0/dpQ0R/SvyPEbAAmfa6ZsFq
         kZ7g==
X-Gm-Message-State: AOAM53001Fv0EQ/lz+l1v9bthormRtpUvpGFiWtWwep6idpdWYQnD+6W
        OGpJGi8637L5uacKTA80QWCfkSizG8VxdWWD00wtZg==
X-Google-Smtp-Source: ABdhPJz9xOghcVpQzvTTeiTfKR7cGivJL60nU4siI92Q6vDRRcW64XOS/SIVpSgSGNE5LBraooDw69ZDRa02nwo0cYE=
X-Received: by 2002:a17:90a:5405:: with SMTP id z5mr1948803pjh.13.1609814714345;
 Mon, 04 Jan 2021 18:45:14 -0800 (PST)
MIME-Version: 1.0
References: <20210104065843.5658-1-songmuchun@bytedance.com>
 <20210104065843.5658-2-songmuchun@bytedance.com> <09be227a-4e16-1960-c8e9-609c35a80ef5@oracle.com>
In-Reply-To: <09be227a-4e16-1960-c8e9-609c35a80ef5@oracle.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Tue, 5 Jan 2021 10:44:35 +0800
Message-ID: <CAMZfGtXApP2k5AWK5ff5TWh+nkY1bHKbMimj4faFC8u6bUzMCQ@mail.gmail.com>
Subject: Re: [External] Re: [PATCH 2/6] hugetlbfs: fix cannot migrate the
 fallocated HugeTLB page
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

On Tue, Jan 5, 2021 at 6:40 AM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>
> On 1/3/21 10:58 PM, Muchun Song wrote:
> > Because we only can isolate a active page via isolate_huge_page()
> > and hugetlbfs_fallocate() forget to mark it as active, we cannot
> > isolate and migrate those pages.
> >
> > Fixes: 70c3547e36f5 (hugetlbfs: add hugetlbfs_fallocate())
> > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > ---
> >  fs/hugetlbfs/inode.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
>
> Good catch.  This is indeed an issue.
>
> >
> > diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
> > index b5c109703daa..2aceb085d202 100644
> > --- a/fs/hugetlbfs/inode.c
> > +++ b/fs/hugetlbfs/inode.c
> > @@ -737,10 +737,11 @@ static long hugetlbfs_fallocate(struct file *file, int mode, loff_t offset,
> >
> >               /*
> >                * unlock_page because locked by add_to_page_cache()
> > -              * page_put due to reference from alloc_huge_page()
> > +              * put_page() (which is in the putback_active_hugepage())
> > +              * due to reference from alloc_huge_page()
>
> Thanks for fixing the comment.
>
> >                */
> >               unlock_page(page);
> > -             put_page(page);
> > +             putback_active_hugepage(page);
>
> I'm curious why you used putback_active_hugepage() here instead of simply
> calling set_page_huge_active() before the put_page()?
>
> When the page was allocated, it was placed on the active list (alloc_huge_page).
> Therefore, the hugetlb_lock locking and list movement should not be necessary.

I agree with you. Because set_page_huge_active is not exported (static
function). Only exporting set_page_huge_active seems strange (leaving
clear_page_huge_active not export). This is just my opinion. What's
yours, Mike?

Thanks.

>
> --
> Mike Kravetz
>
> >       }
> >
> >       if (!(mode & FALLOC_FL_KEEP_SIZE) && offset + len > inode->i_size)
> >
