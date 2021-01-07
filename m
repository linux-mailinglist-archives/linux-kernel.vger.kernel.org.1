Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34B252ECC13
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 09:55:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727218AbhAGIyf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 03:54:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726366AbhAGIye (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 03:54:34 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7390BC0612F4
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jan 2021 00:53:54 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id b5so3328019pjl.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jan 2021 00:53:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uUCvsHvCUDgIJnzQ3S6T2paSQVZlNmh4rqaC1Y4MszQ=;
        b=yNIh/Ok5ue6gPDm5vWv/jp/tjwfZKGL5SV96er+kfs6/JS2hV7CxK4SsZHKNWG1jaL
         a9A4pvLLjJFL7Sz7h0rIoVicHedckkCPXTOBWbJv+IRVvrReXmy+s46Uab3sxrrnj1dq
         UXul4RrtScmbTNoKRpLQ/SdDmUxKCeg1b6pJEHefHgEasULvdIYLqe2GDBuva1fUDbwD
         XcJiPQP7KXg5cIEPlLyV9hdT7NukB3gFocliMczwihPUyUMafZ30xqazgCWOemVk09Af
         Y+fMIFAz3dErvRT7tVMC+R4lOc/ZmAaZbQNqtfXZwRnKkWkPSkI1RnIH1r94aROoWydJ
         He2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uUCvsHvCUDgIJnzQ3S6T2paSQVZlNmh4rqaC1Y4MszQ=;
        b=jmesm1DMm6S0fr0dcZJ+nm41wYIDaGM/+N7Ig+BKKv03HaSzk3oZGVdxv5z5c4tj+F
         AV5+wrNCjUFpNwXQYZIjMMA9kKhTZVubBOMxZHvu4ZiphHAGMwsjIlsRKDZ6M0ZOGCbe
         rydcfzih2hcr9V6St5j8AKDM99IMt83M7lt8+i8kt+69mexYpIlkICg3yukwPCLGHcF/
         2kCHx2mngh2XURvX5+DL3JcysTeHVSgkSQKp58fr5jyblmncUTdGsA3nWTx4cezzBWsn
         Htq/9sc9q2vybLGmNMXr6lPoYGQ5Rbf+c6Md5W3xHSNCFVCnvXB5nBdjNBh29qehUZiZ
         mJVQ==
X-Gm-Message-State: AOAM5339EHlIaVV0olMP329Ctujv+67Q9L4S/4fjay6QAVbFqogq6+oI
        HhQavlKggGQAgmmppLAgu54MDC4jICMiLqOacNG48w==
X-Google-Smtp-Source: ABdhPJy8RktMU98/NVk12c9r+frjlXuodNpdbQALRDB07zw1u882XAAf3iLkeGT5hpdgpaRDdF3a6a4XdODq8+D+tdE=
X-Received: by 2002:a17:902:b416:b029:dc:3657:9265 with SMTP id
 x22-20020a170902b416b02900dc36579265mr8232183plr.24.1610009633963; Thu, 07
 Jan 2021 00:53:53 -0800 (PST)
MIME-Version: 1.0
References: <20210106084739.63318-1-songmuchun@bytedance.com>
 <20210106084739.63318-4-songmuchun@bytedance.com> <20210106165632.GT13207@dhcp22.suse.cz>
 <CAMZfGtWML+PUnK=jJJ1XFmv=VdKOZYmKjyYU=nhpq-1sSGKMqg@mail.gmail.com> <20210107084146.GD13207@dhcp22.suse.cz>
In-Reply-To: <20210107084146.GD13207@dhcp22.suse.cz>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Thu, 7 Jan 2021 16:53:13 +0800
Message-ID: <CAMZfGtVr83yb30EHp5i+f90nn5gnNfGH31Q2ebdV-5nnQXCsAQ@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v2 3/6] mm: hugetlb: fix a race between
 freeing and dissolving the page
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

On Thu, Jan 7, 2021 at 4:41 PM Michal Hocko <mhocko@suse.com> wrote:
>
> On Thu 07-01-21 13:39:38, Muchun Song wrote:
> > On Thu, Jan 7, 2021 at 12:56 AM Michal Hocko <mhocko@suse.com> wrote:
> > >
> > > On Wed 06-01-21 16:47:36, Muchun Song wrote:
> > > > There is a race condition between __free_huge_page()
> > > > and dissolve_free_huge_page().
> > > >
> > > > CPU0:                         CPU1:
> > > >
> > > > // page_count(page) == 1
> > > > put_page(page)
> > > >   __free_huge_page(page)
> > > >                               dissolve_free_huge_page(page)
> > > >                                 spin_lock(&hugetlb_lock)
> > > >                                 // PageHuge(page) && !page_count(page)
> > > >                                 update_and_free_page(page)
> > > >                                 // page is freed to the buddy
> > > >                                 spin_unlock(&hugetlb_lock)
> > > >     spin_lock(&hugetlb_lock)
> > > >     clear_page_huge_active(page)
> > > >     enqueue_huge_page(page)
> > > >     // It is wrong, the page is already freed
> > > >     spin_unlock(&hugetlb_lock)
> > > >
> > > > The race windows is between put_page() and spin_lock() which
> > > > is in the __free_huge_page().
> > >
> > > The race window reall is between put_page and dissolve_free_huge_page.
> > > And the result is that the put_page path would clobber an unrelated page
> > > (either free or already reused page) which is quite serious.
> > > Fortunatelly pages are dissolved very rarely. I believe that user would
> > > require to be privileged to hit this by intention.
> > >
> > > > We should make sure that the page is already on the free list
> > > > when it is dissolved.
> > >
> > > Another option would be to check for PageHuge in __free_huge_page. Have
> > > you considered that rather than add yet another state? The scope of the
> > > spinlock would have to be extended. If that sounds more tricky then can
> > > we check the page->lru in the dissolve path? If the page is still
> > > PageHuge and reference count 0 then there shouldn't be many options
> > > where it can be queued, right?
> >
> > Did you mean that we iterate over the free list to check whether
> > the page is on the free list?
>
> No I meant to check that the page is enqueued which along with ref count
> = 0 should mean it has been released to the pool unless I am missing
> something.

The page can be on the free list or active list or empty when it
is freed to the pool. How to check whether it is on the free list?

> --
> Michal Hocko
> SUSE Labs
