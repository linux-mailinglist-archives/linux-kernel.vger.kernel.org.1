Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 529AF279324
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 23:19:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728691AbgIYVTC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 17:19:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726636AbgIYVTB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 17:19:01 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42953C0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 14:19:01 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id 77so4359254lfj.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 14:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BAZC5WdsihBei8ZEYFA5ibD70o4Yn/tMBPfbhpwMzrw=;
        b=eNZv88uTD+H0687sCNUjErQN0ou7Br7/82NHVBB4WbSsMLa6Xv+b6Py7dIwago8+oV
         LVTgsWVWUV0AfVW3zTJ2+BPeF/2CRbdZ5mh6o59MNoQ8Os2KF2lKb1rUuBeXIczq23h9
         gAwf6yQbAUadJ4ve7LCZdZFcw2mMfQTUgRC19MgdwFfnqyYGhRVeG5L6ZpEdPBplhIsF
         kZZvxrpjdnCLAqObXL+OsCdWoPpV1aD42X9YJXAQN3Y/byVqUSwl7dhz+C1N/NGxqKve
         UFJ+q2IfH/66yw4Iib1An5JHeYd5cCNdqIuigSrwMSdO6gjXfmKxrulbrZdU03sEjUkF
         Q3Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BAZC5WdsihBei8ZEYFA5ibD70o4Yn/tMBPfbhpwMzrw=;
        b=guKRzIqlC8sDizenQdIhQgeSwQWBH3a16/larfWBwR9qGT/h2BLawvo2LUHU4hIKrO
         eY0RGCLeJXWu4ty1HE0taenB69/1Lx6AAcsM4z1osKHTH/Yyu/o9gUN/YghkmmsolpFC
         EJmfvTX9QEPEP9gtq+LayW+Ky4iDlNVoU7D6O6qM5ce2qtc9StXdAKDIyCJo6fHDPrWW
         pg8n3/1I9pMkRvf8RAUUYryymfTW6mAsIb7sKT5LowC9/0N9o0Us7DW7nZIuVsLQtp7L
         9st4sLdhZ2x5VUJ5Bj/d1zKIbHF5jBzua3SC03gcV0MYFHEM0148zY8KIJE80c79IJ77
         OJnA==
X-Gm-Message-State: AOAM530KlcXfIe7bVPT/98mYSixc35Drt8g04h+GgU8a/XSm8bdwGlvG
        oNF1kHMjKkJpMGhsqvcG9wYNUt+izjZo3Q9ou3Cp4w==
X-Google-Smtp-Source: ABdhPJxUEE37WPkdJrc9HedFYru6tI6b/9DtnLDZsC2ZOqMgNlXO3m98KYOozN9brJWAwI+Hjol/pci4CGZ7tcktK4w=
X-Received: by 2002:ac2:4315:: with SMTP id l21mr254323lfh.494.1601068739382;
 Fri, 25 Sep 2020 14:18:59 -0700 (PDT)
MIME-Version: 1.0
References: <CALvZod5pERERkxWAJcBrZHpcWQH75kXkys2gUg__qM9OL+MmtQ@mail.gmail.com>
 <20200925191902.543953-1-shakeelb@google.com> <20200925205604.GA2228989@carbon.dhcp.thefacebook.com>
In-Reply-To: <20200925205604.GA2228989@carbon.dhcp.thefacebook.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Fri, 25 Sep 2020 14:18:48 -0700
Message-ID: <CALvZod5ETbjn7Y0A619Sd+sFO_9QCnUDC-_pBXPgq9AkAK0LRQ@mail.gmail.com>
Subject: Re: REGRESSION: 37f4a24c2469: blk-mq: centralise related handling
 into blk_mq_get_driver_tag
To:     Roman Gushchin <guro@fb.com>
Cc:     Ming Lei <ming.lei@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Theodore Y . Ts'o" <tytso@mit.edu>, Jens Axboe <axboe@kernel.dk>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 25, 2020 at 1:56 PM Roman Gushchin <guro@fb.com> wrote:
>
> On Fri, Sep 25, 2020 at 12:19:02PM -0700, Shakeel Butt wrote:
> > On Fri, Sep 25, 2020 at 10:58 AM Shakeel Butt <shakeelb@google.com>
> > wrote:
> > >
> > [snip]
> > >
> > > I don't think you can ignore the flushing. The __free_once() in
> > > ___cache_free() assumes there is a space available.
> > >
> > > BTW do_drain() also have the same issue.
> > >
> > > Why not move slabs_destroy() after we update ac->avail and memmove()?
> >
> > Ming, can you please try the following patch?
> >
> >
> > From: Shakeel Butt <shakeelb@google.com>
> >
> > [PATCH] mm: slab: fix potential infinite recursion in ___cache_free
> >
> > With the commit 10befea91b61 ("mm: memcg/slab: use a single set of
> > kmem_caches for all allocations"), it becomes possible to call kfree()
> > from the slabs_destroy(). However if slabs_destroy() is being called for
> > the array_cache of the local CPU then this opens the potential scenario
> > of infinite recursion because kfree() called from slabs_destroy() can
> > call slabs_destroy() with the same array_cache of the local CPU. Since
> > the array_cache of the local CPU is not updated before calling
> > slabs_destroy(), it will try to free the same pages.
> >
> > To fix the issue, simply update the cache before calling
> > slabs_destroy().
> >
> > Signed-off-by: Shakeel Butt <shakeelb@google.com>
>
> I like the patch and I think it should fix the problem.
>
> However the description above should be likely asjusted a bit.
> It seems that the problem is not necessary caused by an infinite recursion,
> it can be even simpler.
>
> In cache_flusharray() we rely on the state of ac, which is described
> by ac->avail. In particular we rely on batchcount < ac->avail,
> as we shift the batchcount number of pointers by memmove.
> But if slabs_destroy() is called before and leaded to a change of the
> ac state, it can lead to a memory corruption.
>
> Also, unconditionally resetting ac->avail to 0 in do_drain() after calling
> to slab_destroy() seems to be wrong.
> It explains double free BUGs we've seen in stacktraces.
>

Yes, you are right. Let's first get this patch tested and after
confirmation we can update the commit message.
