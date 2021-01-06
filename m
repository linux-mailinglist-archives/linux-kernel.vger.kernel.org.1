Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C19C2EB843
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 03:59:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726074AbhAFC6X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 21:58:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725824AbhAFC6W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 21:58:22 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AC66C06134C
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jan 2021 18:57:42 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id z21so1240780pgj.4
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jan 2021 18:57:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lYsPdCOzqXfixaKkRPnCKU785zBOXZmL0NyzU0FFiug=;
        b=J1swhEHXszBFVldveCRzUAKJNVdFedOCbywLvekfqMgsECjZdRmrsFyX1vfKnc3lZg
         rIK1xLhRVIcSJ5kH7li+0MyJwShViyAXuIoSJn2H5l/6nvh1sPY7tUE8MLaCnWcq0HXm
         NDr0MjFoJVjn+jnZuT6jO0rGoUZJfNGyVXP41Vhkw0EXKVTJuKiBfmeRE/adA1l/AJRf
         lXBTsEkH0UFcbqwjSR7Teq9GLdHlXr80lQjCq7khfQTaP+NcSy4snVuYlswNSZQapccg
         xcGopoi6OTUnVwLwa4wm2WP24X0uk2tYy3UpEtdyUjBAHBtGG1XtAz/wC7qXKhX/ZhTZ
         l+uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lYsPdCOzqXfixaKkRPnCKU785zBOXZmL0NyzU0FFiug=;
        b=J8loLlBK3p+3Ipz+60DacTA1FVUkte0t2E5AYptNQHK9xoJUYjDq8FAhX0KWT/lHGk
         8qfkrRRpWSDpPIqIiN8KLTInlT8oP7TnpbxKsKCJKViIJmaah/W5GrU0uqobOxT9Xcyn
         KIRRlSv67rPhEFa68lfTrIZ9j6DcOe8+4h7eh4GR5cfyzSOvRRBQdwl84g8qgu5wCGcS
         HXhqeB2nBT5n8huNCBKaCRqzyMOCbYkhpRqxjBkMBW+AWHvEjjnSlUSZnxCG9Cpkh4JX
         zH64YX2pSWnwCTexRPgdMO8Im3c32TjRKV0mdfRL9bBixh3z397iJz3MAQRylJBaK59y
         ayGQ==
X-Gm-Message-State: AOAM53356D5NBpdTpl20zEHKjr+t/olhoZXEBg2TpC+YyrZSWF9ryu68
        /UM26FsMy2IEkxwGJ0saTVyNSy5tvW+yzpWUxzDc5A==
X-Google-Smtp-Source: ABdhPJxmVeH2zMLxyYLVS6nxqNvd3jKCWsvP/nlla8VfJsdAUn5exKmZi9EzfE5wgDEMbM5strc+q/fgjqk209aDIu0=
X-Received: by 2002:aa7:8701:0:b029:19e:561:d476 with SMTP id
 b1-20020aa787010000b029019e0561d476mr2144416pfo.2.1609901862076; Tue, 05 Jan
 2021 18:57:42 -0800 (PST)
MIME-Version: 1.0
References: <20210104065843.5658-1-songmuchun@bytedance.com>
 <20210104065843.5658-2-songmuchun@bytedance.com> <09be227a-4e16-1960-c8e9-609c35a80ef5@oracle.com>
 <CAMZfGtXApP2k5AWK5ff5TWh+nkY1bHKbMimj4faFC8u6bUzMCQ@mail.gmail.com> <24d35764-46b9-4234-3266-91232ac9103b@oracle.com>
In-Reply-To: <24d35764-46b9-4234-3266-91232ac9103b@oracle.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Wed, 6 Jan 2021 10:57:03 +0800
Message-ID: <CAMZfGtWw+=qnuq-4LP3O4qxdLY-OT_csZd5+dKRtNdCMQXc_Fw@mail.gmail.com>
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

On Wed, Jan 6, 2021 at 6:29 AM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>
> On 1/4/21 6:44 PM, Muchun Song wrote:
> > On Tue, Jan 5, 2021 at 6:40 AM Mike Kravetz <mike.kravetz@oracle.com> wrote:
> >>
> >> On 1/3/21 10:58 PM, Muchun Song wrote:
> >>> Because we only can isolate a active page via isolate_huge_page()
> >>> and hugetlbfs_fallocate() forget to mark it as active, we cannot
> >>> isolate and migrate those pages.
> >>>
> >>> Fixes: 70c3547e36f5 (hugetlbfs: add hugetlbfs_fallocate())
> >>> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> >>> ---
> >>>  fs/hugetlbfs/inode.c | 5 +++--
> >>>  1 file changed, 3 insertions(+), 2 deletions(-)
> >>
> >> Good catch.  This is indeed an issue.
> >>
> >>>
> >>> diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
> >>> index b5c109703daa..2aceb085d202 100644
> >>> --- a/fs/hugetlbfs/inode.c
> >>> +++ b/fs/hugetlbfs/inode.c
> >>> @@ -737,10 +737,11 @@ static long hugetlbfs_fallocate(struct file *file, int mode, loff_t offset,
> >>>
> >>>               /*
> >>>                * unlock_page because locked by add_to_page_cache()
> >>> -              * page_put due to reference from alloc_huge_page()
> >>> +              * put_page() (which is in the putback_active_hugepage())
> >>> +              * due to reference from alloc_huge_page()
> >>
> >> Thanks for fixing the comment.
> >>
> >>>                */
> >>>               unlock_page(page);
> >>> -             put_page(page);
> >>> +             putback_active_hugepage(page);
> >>
> >> I'm curious why you used putback_active_hugepage() here instead of simply
> >> calling set_page_huge_active() before the put_page()?
> >>
> >> When the page was allocated, it was placed on the active list (alloc_huge_page).
> >> Therefore, the hugetlb_lock locking and list movement should not be necessary.
> >
> > I agree with you. Because set_page_huge_active is not exported (static
> > function). Only exporting set_page_huge_active seems strange (leaving
> > clear_page_huge_active not export). This is just my opinion. What's
> > yours, Mike?
>
> I'm thinking that we should export (make external) set_page_huge_active.
> We can leave clear_page_huge_active as static and just add something to
> the commit log noting that there are no external users.
>
> My primary reason for doing this is to eliminate the extra and unnecessary
> per-page lock/unlock cycle.  I believe there are some applications that
> use fallocate to pre-allocate very large hugetlbfs files.  They may notice
> the extra overhead.

Agree. Will do in the next version. Thanks.

> --
> Mike Kravetz
