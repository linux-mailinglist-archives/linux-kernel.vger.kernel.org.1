Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65F802ECDA4
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 11:18:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbhAGKRg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 05:17:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725974AbhAGKRg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 05:17:36 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7C6DC0612F4
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jan 2021 02:16:54 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id n25so4544786pgb.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jan 2021 02:16:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fMg+Efsr+R+6AgYEdihpBKpjToT/4HtI9c2KzJ9otZ8=;
        b=le0WsLpP4bBFfsvpr8snBYSl8L9P6PHp9BhUUJbbVp1HQi4TnNUNXk4eQlZdVtMPim
         I6Qta6BUS8FRAjiVX9cSWi0QG7vEDthBZN1bh9zEpkgpZH4O6SubCMnEwZVu6H6y2MqW
         r75pJEf8v/zqpQxUsQqSKYlWI6VUtM67NC1y8L66spAFTqyAs4Q84EqkkW64yQ63IM7Y
         VCPcOzKCe+ykQXpoxqBugIV8OmH4CD/B1cmY8xilxzzvXhEAdiLnbLkx1YqODqoZPnEe
         LVkNENmNJ2xBkWWP7ZdzQEeznD57MjZEZLM561xNZrOV9q+ADk+KZArSce9kn9NzGnoh
         6DVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fMg+Efsr+R+6AgYEdihpBKpjToT/4HtI9c2KzJ9otZ8=;
        b=U3SlXHebkIMDWWVVMSIMWE9oYg0dfbx+vi3Fd/s9GESIDGghbX+hXcLe2XpK1KEdvz
         SWypa2IqhWdJ5p8bdEY7n7ZisANPJMWpXIBewBnLFquCZ2MaBGUIDTxBmWxjsN0pJPNr
         42xGS53VVC9gvioOr+kk5DjxxTONmuh8JbOLOLuHlHE+5S07Ci7cW+pCSOiEiDMk+Nw5
         BNbnDIydBeTOx/xSHOJm0Z8452rSqRIr4sryViykBuaC7swkJXREwLZngTlJnlc2sMk9
         Oxc73u8kEsCFCCdyZgQZwyjLbzZsCgAtRK50knx/JsJrqCwKCEQHxbMM8J/YFUNWI3AA
         J8Wg==
X-Gm-Message-State: AOAM530XXveUKCGf4f2s54534xi0yPQ5KIkhlJz7mERsrBSvR+aqD1gI
        trfPXOoeBHOhD5mP7EOW8YZU/AoyqqxaPzmzbGEi2w==
X-Google-Smtp-Source: ABdhPJwTPnAi13cnwMFKWWpRhZjrz70it7/2/lJzwgmkROoSS+yYxtKi9u9XSoYPLbVM8BWQpZvb3ZsAB7p4l72x1OY=
X-Received: by 2002:aa7:979d:0:b029:1a4:3b76:a559 with SMTP id
 o29-20020aa7979d0000b02901a43b76a559mr7945860pfp.49.1610014614360; Thu, 07
 Jan 2021 02:16:54 -0800 (PST)
MIME-Version: 1.0
References: <20210106084739.63318-1-songmuchun@bytedance.com>
 <7b44eddc-cbae-92b6-5ac7-765cad2a6326@redhat.com> <CAMZfGtUcGLZjesq4ztqHXG2PekmJ2q60s3ymjBRmiJ141syK3A@mail.gmail.com>
 <7971c96c-6b96-2dca-b9d9-d3828b117e66@redhat.com>
In-Reply-To: <7971c96c-6b96-2dca-b9d9-d3828b117e66@redhat.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Thu, 7 Jan 2021 18:16:14 +0800
Message-ID: <CAMZfGtXS8V8FgPmHWGtDbd=opkCMzMPsmd5n=1gLH6LpcSaA7w@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v2 0/6] Fix some bugs about HugeTLB code
To:     David Hildenbrand <david@redhat.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Andi Kleen <ak@linux.intel.com>, mhocko@suse.cz,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 7, 2021 at 6:10 PM David Hildenbrand <david@redhat.com> wrote:
>
> On 07.01.21 10:40, Muchun Song wrote:
> > On Thu, Jan 7, 2021 at 5:30 PM David Hildenbrand <david@redhat.com> wrote:
> >>
> >> On 06.01.21 09:47, Muchun Song wrote:
> >>> This patch series aims to fix some bugs and add some improvements.
> >>>
> >>> Changelog since v1 -> v2:
> >>>   - Export set_page_huge_active() in patch #2 to fix.
> >>>   - Using head[3].mapping to indicate the page is freed in patch #3.
> >>>   - Flush @free_hpage_work in patch #4.
> >>>
> >>> Muchun Song (6):
> >>>   mm: migrate: do not migrate HugeTLB page whose refcount is one
> >>>   mm: hugetlbfs: fix cannot migrate the fallocated HugeTLB page
> >>>   mm: hugetlb: fix a race between freeing and dissolving the page
> >>>   mm: hugetlb: add return -EAGAIN for dissolve_free_huge_page
> >>>   mm: hugetlb: fix a race between isolating and freeing page
> >>>   mm: hugetlb: remove VM_BUG_ON_PAGE from page_huge_active
> >>>
> >>>  fs/hugetlbfs/inode.c    |  3 ++-
> >>>  include/linux/hugetlb.h |  2 ++
> >>>  mm/hugetlb.c            | 69 +++++++++++++++++++++++++++++++++++++++++++------
> >>>  mm/migrate.c            |  6 +++++
> >>>  4 files changed, 71 insertions(+), 9 deletions(-)
> >>>
> >>
> >> Repeating my question regarding ccing stable on selected fixes.
> >>
> >
> > Just add a CC tag in the commit log of the fix patches? Right?
> > Sorry, I'm a novice about this. Thanks.
>
> Sure, here is some information:
>
> https://www.kernel.org/doc/html/v4.10/process/stable-kernel-rules.html
>
> Applicable patches should be moved to the beginning of the series.
>
> Add "Cc: stable@vger.kernel.org" similar to "Fixes:" to the respective
> patches. In the ideal case, indicate the applicable earliest stable
> release where it applies.
>
> E.g., take a look at (random commit)
>
> commit 20b329129009caf1c646152abe09b697227e1c37
> Author: Bob Peterson <rpeterso@redhat.com>
> Date:   Wed Nov 18 08:54:31 2020 -0500
>
>     gfs2: Fix regression in freeze_go_sync
> ...
>     Fixes: 541656d3a513 ("gfs2: freeze should work on read-only mounts")
>     Cc: stable@vger.kernel.org # v5.8+
> ...
>
>
> Consequently, actually cc when sending out these patches (e.g., let "git
> send-email" do it automatically).

Great! Very thanks.

>
> --
> Thanks,
>
> David / dhildenb
>
