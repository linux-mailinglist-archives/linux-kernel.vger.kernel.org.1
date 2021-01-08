Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E643C2EF281
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 13:25:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbhAHMZ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 07:25:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725817AbhAHMZZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 07:25:25 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F3F1C0612F4
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jan 2021 04:24:45 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id w1so5528456pjc.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jan 2021 04:24:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UtS85N+Smc03ohK3CJF7shWpZzDxBCUbzsBkICq+rlA=;
        b=D3jJi18lhxmZE71W9Og4n4blgUtU6tZudM/f5YNsxD84LFG9w24pL8mm7a2s0dXvCo
         mBoAEpg5cU8X0+I4rXEVlii5Kql0mhpJoA/Ubx271o+KG1Ym78CwKBRwbSXaSARaf0Bf
         ipYKu5RtublV7w1KK6Quk5cfxBWF0mhnQUAprMaF4jTw7wTpYEsWODOnCZUfpdx6kfih
         hVHC6MDyDSsE/0MUBd1EW4zjHpdbXDDuOHK8tvRcQFvLPRheiupV71YDvg7YobjUaXhA
         nayP5YiqClQCJfeMUopPbc/Saie4ENGscwi2DcW/rxCP0rSKq8+HEDBdz/UqIQa8K7xk
         aaYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UtS85N+Smc03ohK3CJF7shWpZzDxBCUbzsBkICq+rlA=;
        b=JteMpXcvLCYbfm9/FgaVl/HD9ZyMa3wYRER6P3V4iy1YajaM3gIGMavROtp+yQh3d4
         QS8HVXojKJvQK+2ykgKUoidlILtiwr38t3QVGw8Ywu5VKlWjTWxZL2/kTY/bCYIxFi6A
         Um0tCZWaXfG9S8eS70ox09/8dnv6G+FEqrUpVCoL0Uu5X9Ey5kf9wKPk0cnhObYgNy9V
         xzUFxJxCdQh/FLHmHh6JzaVXarHiWg/doyNIDyjv3uKMtkpGuw2dJ8Q56yTaI6deg4MF
         XJVhWqHuXBj4XTf6q8kXARVlD53usP9922qsFfw0A45oY2MGkkpDVVuaHHk2ul4v3wN8
         tGsg==
X-Gm-Message-State: AOAM533G846JqsMwH0+Kb36z/Aoxd4KVxaIWJj3ch2rAc03ZPMbP2yPe
        Y4iay5kqaiFsBUzdwOhXVrpUFTm4cjZjPgWzbptdbQ==
X-Google-Smtp-Source: ABdhPJz1MKl1jOxXLKdWPgRd2QRQG8qOfU0CNU5J6d21DZtiqKnlOfCKPHKh4nOiX5TisjBNNeR6c4rAx2+ADXRC5as=
X-Received: by 2002:a17:90a:5405:: with SMTP id z5mr3581866pjh.13.1610108684862;
 Fri, 08 Jan 2021 04:24:44 -0800 (PST)
MIME-Version: 1.0
References: <20210107123854.GJ13207@dhcp22.suse.cz> <CAMZfGtWUP1H47ZGcczsmqsQvxYP=FK9vYVr8WbOY_9UG2SCv0A@mail.gmail.com>
 <20210107141130.GL13207@dhcp22.suse.cz> <CAMZfGtW8hDxV_5isGTNLQMFttoymRwxc2N7nEgqxLLj6t5oN3g@mail.gmail.com>
 <20210108084330.GW13207@dhcp22.suse.cz> <CAMZfGtUy740SbsCW_h1NaP5O=ahSZniezkC+62pxZ5bW+vZpBg@mail.gmail.com>
 <20210108093136.GY13207@dhcp22.suse.cz> <CAMZfGtXhMDjw=C8XBUwsQLD7ZLv5osoLWy+RJzqY11WFm07GwQ@mail.gmail.com>
 <20210108114411.GZ13207@dhcp22.suse.cz> <CAMZfGtVc5dAYY_sPywi=BzfA92erqNn6O0X=0_k7sX2Xh1NC=w@mail.gmail.com>
 <20210108120421.GC13207@dhcp22.suse.cz>
In-Reply-To: <20210108120421.GC13207@dhcp22.suse.cz>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Fri, 8 Jan 2021 20:24:04 +0800
Message-ID: <CAMZfGtX5hj=ODdwXBOYsKkP6Z4eTMP0YXqGesM618Gfi0GhHtQ@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v2 3/6] mm: hugetlb: fix a race between
 freeing and dissolving the page
To:     Michal Hocko <mhocko@suse.com>,
        Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Andi Kleen <ak@linux.intel.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 8, 2021 at 8:04 PM Michal Hocko <mhocko@suse.com> wrote:
>
> On Fri 08-01-21 19:52:54, Muchun Song wrote:
> > On Fri, Jan 8, 2021 at 7:44 PM Michal Hocko <mhocko@suse.com> wrote:
> > >
> > > On Fri 08-01-21 18:08:57, Muchun Song wrote:
> > > > On Fri, Jan 8, 2021 at 5:31 PM Michal Hocko <mhocko@suse.com> wrote:
> > > > >
> > > > > On Fri 08-01-21 17:01:03, Muchun Song wrote:
> > > > > > On Fri, Jan 8, 2021 at 4:43 PM Michal Hocko <mhocko@suse.com> wrote:
> > > > > > >
> > > > > > > On Thu 07-01-21 23:11:22, Muchun Song wrote:
> > > > > [..]
> > > > > > > > But I find a tricky problem to solve. See free_huge_page().
> > > > > > > > If we are in non-task context, we should schedule a work
> > > > > > > > to free the page. We reuse the page->mapping. If the page
> > > > > > > > is already freed by the dissolve path. We should not touch
> > > > > > > > the page->mapping. So we need to check PageHuge().
> > > > > > > > The check and llist_add() should be protected by
> > > > > > > > hugetlb_lock. But we cannot do that. Right? If dissolve
> > > > > > > > happens after it is linked to the list. We also should
> > > > > > > > remove it from the list (hpage_freelist). It seems to make
> > > > > > > > the thing more complex.
> > > > > > >
> > > > > > > I am not sure I follow you here but yes PageHuge under hugetlb_lock
> > > > > > > should be the reliable way to check for the race. I am not sure why we
> > > > > > > really need to care about mapping or other state.
> > > > > >
> > > > > > CPU0:                               CPU1:
> > > > > > free_huge_page(page)
> > > > > >   if (PageHuge(page))
> > > > > >                                     dissolve_free_huge_page(page)
> > > > > >                                       spin_lock(&hugetlb_lock)
> > > > > >                                       update_and_free_page(page)
> > > > > >                                       spin_unlock(&hugetlb_lock)
> > > > > >     llist_add(page->mapping)
> > > > > >     // the mapping is corrupted
> > > > > >
> > > > > > The PageHuge(page) and llist_add() should be protected by
> > > > > > hugetlb_lock. Right? If so, we cannot hold hugetlb_lock
> > > > > > in free_huge_page() path.
> > > > >
> > > > > OK, I see. I completely forgot about this snowflake. I thought that
> > > > > free_huge_page was a typo missing initial __. Anyway you are right that
> > > > > this path needs a check as well. But I don't see why we couldn't use the
> > > > > lock here. The lock can be held only inside the !in_task branch.
> > > >
> > > > Because we hold the hugetlb_lock without disable irq. So if an interrupt
> > > > occurs after we hold the lock. And we also free a HugeTLB page. Then
> > > > it leads to deadlock.
> > >
> > > There is nothing really to prevent making hugetlb_lock irq safe, isn't
> > > it?
> >
> > Yeah. We can make the hugetlb_lock irq safe. But why have we not
> > done this? Maybe the commit changelog can provide more information.
> >
> > See https://github.com/torvalds/linux/commit/c77c0a8ac4c522638a8242fcb9de9496e3cdbb2d
>
> Dang! Maybe it is the time to finally stack one workaround on top of the
> other and put this code into the shape. The amount of hackery and subtle
> details has just grown beyond healthy!

From readability point of view, maybe making the hugetlb_lock irq safe
is an improvement (in the feature).

The details are always messy. :)

> --
> Michal Hocko
> SUSE Labs
