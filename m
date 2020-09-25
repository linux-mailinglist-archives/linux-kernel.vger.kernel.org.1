Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F0A9279403
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Sep 2020 00:16:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728963AbgIYWQc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 18:16:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727183AbgIYWQc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 18:16:32 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1181C0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 15:16:31 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id w3so3683169ljo.5
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 15:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2qHTqnIfH0BrTrH8c6GV0zk0WcCBrtPGOUQiFR1y9ws=;
        b=Kv1GBbShRS5ryf448gWDVZmIPK8cMF1KcxmoYwXV4eM8lJFqzkq4jrowlSJCcHHxTx
         8h9/NPStUqXDhl4nu5Dix0msNC0mCw3A8pys74DFElega7J8M3CmL71s3vZGX3mQljaJ
         RS+srjEY/wgkIpXGQN9iWrez+qZZyiHKX9Tiw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2qHTqnIfH0BrTrH8c6GV0zk0WcCBrtPGOUQiFR1y9ws=;
        b=Tfbh7KjJFo4BLaVcYvVjKz3E8VvFS5ASYTHhf12uK7LbJTovrNa2OTdKiKsN6IPeRw
         DK4XJUu8xVq7w5A3sIbgxGFbbYr1tD3tQdIjbAp3VTjPWedTlMi/FtMJzmwOl2tQK//m
         ymfLXfYmIRbPpyuz8JXMfJbOLVRNWQIWC1ymUE6sKnyZDVp9tLM0ORN+RjLYPzj1emsG
         Bwdno8RqqHprgnsor3wCaMcHtnACcpa09isZFpwJYKs/KU+9cLmd+/cMw3saJwMGHW7p
         ypkS33LXwd70ypicWhwYmNuI0u14qCvuwu5maaFQsscbp8NhMGuSYGVRq91afU5Cjyha
         sX+g==
X-Gm-Message-State: AOAM533OVvq565wr7G7oaiKa+b01ZoVKymR0zsHmbNvYM5slI21sarTZ
        s2d4CQ6zPmD0Y9r1v4fQHLhgoD1nJnVUrQ==
X-Google-Smtp-Source: ABdhPJwOgptF/mINIoNqiOQsyTKqKjbW9vB6Ih6qQiJU/s0EQT3RvpdXgNcJ/Fb2A4zJ6KlHNVcAvg==
X-Received: by 2002:a05:651c:23c:: with SMTP id z28mr1913019ljn.36.1601072189963;
        Fri, 25 Sep 2020 15:16:29 -0700 (PDT)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id q9sm288974lfn.170.2020.09.25.15.16.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Sep 2020 15:16:29 -0700 (PDT)
Received: by mail-lf1-f42.google.com with SMTP id b22so4420220lfs.13
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 15:16:29 -0700 (PDT)
X-Received: by 2002:a19:521a:: with SMTP id m26mr309828lfb.133.1601071742457;
 Fri, 25 Sep 2020 15:09:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200923002735.GN19098@xz-x1> <20200923170759.GA9916@ziepe.ca>
 <20200924143517.GD79898@xz-x1> <20200924165152.GE9916@ziepe.ca>
 <20200924175531.GH79898@xz-x1> <20200924181501.GF9916@ziepe.ca>
 <20200924183418.GJ79898@xz-x1> <20200924183953.GG9916@ziepe.ca>
 <20200924213010.GL79898@xz-x1> <CAHk-=wgz5SXKA6-uZ_BimOP1C7pHJag0ndz=tnJDAZS_Z+FrGQ@mail.gmail.com>
 <20200925211321.GC188812@xz-x1>
In-Reply-To: <20200925211321.GC188812@xz-x1>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 25 Sep 2020 15:08:46 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiBAkpgoTB1n5L6OdfWhOvmbmKgbKUH+QNBnw=cfoR-oA@mail.gmail.com>
Message-ID: <CAHk-=wiBAkpgoTB1n5L6OdfWhOvmbmKgbKUH+QNBnw=cfoR-oA@mail.gmail.com>
Subject: Re: [PATCH 1/5] mm: Introduce mm_struct.has_pinned
To:     Peter Xu <peterx@redhat.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jan Kara <jack@suse.cz>, Michal Hocko <mhocko@suse.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Kirill Shutemov <kirill@shutemov.name>,
        Hugh Dickins <hughd@google.com>,
        Christoph Hellwig <hch@lst.de>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Jann Horn <jannh@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 25, 2020 at 2:13 PM Peter Xu <peterx@redhat.com> wrote:
>
> On Fri, Sep 25, 2020 at 12:56:05PM -0700, Linus Torvalds wrote:
> > So I think we can simply add a
> >
> >         if (page_mapcount(page) != 1)
> >                 return false;
> >
> > to page_maybe_dma_pinned(), and that very naturally protects against
> > the "is the page count perhaps elevated due to a lot of forking?"
>
> How about the MAP_SHARED case where the page is pinned by some process but also
> shared (so mapcount can be >1)?

MAP_SHARED doesn't matter, since it's not getting COW'ed anyway, and
we keep the page around regardless.

So MAP_SHARED is the easy case. We'll never get to any of this code,
because is_cow_mapping() won't be true.

You can still screw up MAP_SHARED if you do a truncate() on the
underlying file or something like that, but that most *definitely*
falls under the "you only have yourself to blame" heading.

> Would the ATOMIC version always work?  I mean, I thought it could fail anytime,
> so any fork() can start to fail for the tests too.

Sure. I'm not really happy about GFP_ATOMIC, but I suspect it works in practice.

Honestly, if somebody first pins megabytes of memory, and then does a
fork(), they are doing some seriously odd and wrong things. So I think
this should be a "we will try to handle it gracefully, but your load
is broken" case.

I am still inclined to add some kind of warning to this case, but I'm
also a bit on the fence wrt the whole "convenience" issue - for some
very occasional use it's probably convenient to not have to worry
about this in user space.

Actually, what I'm even less happy about than the GFP_ATOMIC is how
much annoying boilerplate this just "map anonymous page" required with
the whole cgroup_charge, throttle, anon_rmap, lru_cache_add thing.
Looking at that patch, it all looks _fairly_ simple, but there's a lot
of details that got duplicated from the pte_none() new-page-fault case
(and that the do_cow_page() case also shares)

I understand why it happens, and there's not *that* many cases, it
made me go "ouch, this is a lot of small details, maybe I missed
some", and I got the feeling that I should try to re-organize a few
helper functions to avoid duplicating the same basic code over and
over again.

But I decided that I wanted to keep the patch minimal and as focused
as possible, so I didn't actually do that. But we clearly have decades
of adding rules that just makes even something as "simple" as "add a
new page to a VM" fairly complex.

Also, to avoid making the patch bigger, I skipped your "pass
destination vma around" patch. I think it's the right thing
conceptually, but everything I looked at also screamed "we don't
actually care about the differences" to me.

I dunno. I'm conflicted. This really _feels_ to me like "we're so
close to just fixing this once and for all", but then I also go "maybe
we should just revert everything and do this for 5.10".

Except "reverting everything" is sadly really really problematic too.
It will fix the rdma issue, but in this case "everything" goes all the
way back to "uhhuh, we have a security issue with COW going the wrong
way". Otherwise I'd have gone that way two weeks ago already.

               Linus
