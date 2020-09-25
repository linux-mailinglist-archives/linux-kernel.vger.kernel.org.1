Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 959DC279213
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 22:33:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729075AbgIYUdh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 16:33:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727078AbgIYUXf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 16:23:35 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29E20C0613BC
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 12:56:31 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id u4so3405863ljd.10
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 12:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qUiy2ig2a15MrzQwKLflyxH1xyfxaBmeAG61rIjvflk=;
        b=K2e+w8y0EFDqfA6rNqzjoQsIAS1IBF+m+AAbrXyUmRaFi0guqcGQf95oAMkA5qmqSG
         mX05KX/tiJGJFcjwBr2/LwKRNzqV/6s1eUoxd4qJUIgVvGCKzIklVLTVB2RdIqxx8zO8
         h4nz26JplzDj2c4dht03UI5Iwc+kEchIVoPy8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qUiy2ig2a15MrzQwKLflyxH1xyfxaBmeAG61rIjvflk=;
        b=pO0yKPjxbpijvHsERgGiqTkVSLd5JMJdK8wefHS+yG1aer8jgD3xOZveCFUxlOUS5q
         WKrCs0NauxC8yjlxMiQlUEmOWTEo6ixn0deM8j5r2S8dpOhHKesqApO2SMKy51Afl5zx
         A28TFjD4Lf64tDHykqh0MDW7t6fO8MH1ssgocY3fJ3A4hhBT4DTzz5+8CzgELan1VRBj
         ZhYO5vOhu6Jvc6/Dn+b3u01lWpaqKxXEZ4M2+sAl7GQho+nW5sQGR6/HSKDoSEdMhw8L
         FBEO2H5ZszMCO6w2rOFmu8bdm8r8SQY4CAgtOnaEvlZIICAbXAuOqyQr1s8+VvZQP8Yi
         0EUg==
X-Gm-Message-State: AOAM530hZVEEMa2BYMFbe98xXN6y1GaU+tAS2dMi2MLPleyCjJJ4brGC
        kFR2ij5S72ZcaZHOpZQX//8UZqUNIVCejw==
X-Google-Smtp-Source: ABdhPJxhzGrboqRM9eMkTrmJu0o8pPWqjpN+EQKU3ZVlVymggYVqgPm4WxubA7Lwtls8N5EdJPLWkQ==
X-Received: by 2002:a2e:8593:: with SMTP id b19mr1760549lji.290.1601063788698;
        Fri, 25 Sep 2020 12:56:28 -0700 (PDT)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id k3sm79941lfg.300.2020.09.25.12.56.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Sep 2020 12:56:22 -0700 (PDT)
Received: by mail-lf1-f41.google.com with SMTP id u8so4141876lff.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 12:56:22 -0700 (PDT)
X-Received: by 2002:a19:e00a:: with SMTP id x10mr150939lfg.603.1601063781887;
 Fri, 25 Sep 2020 12:56:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200922175415.GI19098@xz-x1> <20200922191116.GK8409@ziepe.ca>
 <20200923002735.GN19098@xz-x1> <20200923170759.GA9916@ziepe.ca>
 <20200924143517.GD79898@xz-x1> <20200924165152.GE9916@ziepe.ca>
 <20200924175531.GH79898@xz-x1> <20200924181501.GF9916@ziepe.ca>
 <20200924183418.GJ79898@xz-x1> <20200924183953.GG9916@ziepe.ca> <20200924213010.GL79898@xz-x1>
In-Reply-To: <20200924213010.GL79898@xz-x1>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 25 Sep 2020 12:56:05 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgz5SXKA6-uZ_BimOP1C7pHJag0ndz=tnJDAZS_Z+FrGQ@mail.gmail.com>
Message-ID: <CAHk-=wgz5SXKA6-uZ_BimOP1C7pHJag0ndz=tnJDAZS_Z+FrGQ@mail.gmail.com>
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

On Thu, Sep 24, 2020 at 2:30 PM Peter Xu <peterx@redhat.com> wrote:
>
> > >
> > > With the extra mprotect(!WRITE), I think we'll see a !pte_write() entry.  Then
> > > it'll not go into maybe_dma_pinned() at all since cow==false.
> >
> > Hum that seems like a problem in this patch, we still need to do the
> > DMA pinned logic even if the pte is already write protected.
>
> Yes I agree.  I'll take care of that in the next version too.

You people seem to be worrying too much about crazy use cases.

The fact is, if people do pinning, they had better be careful
afterwards. I agree that marking things MADV_DONTFORK may not be
great, and there may be apps that do it. But honestly, if people then
do mprotect() to make a VM non-writable after pinning a page for
writing (and before the IO has completed), such an app only has itself
to blame.

So I don't think this issue is even worth worrying about.  At some
point, when apps do broken things, the kernel says "you broke it, you
get to keep both pieces". Not "Oh, you're doing unreasonable things,
let me help you".

This has dragged out a lot longer than I hoped it would, and I think
it's been over-complicated.

In fact, looking at this all, I'm starting to think that we don't
actually even need the mm_struct.has_pinned logic, because we can work
with something much simpler: the page mapping count.

A pinned page will have the page count increased by
GUP_PIN_COUNTING_BIAS, and my worry was that this would be ambiguous
with the traditional "fork a lot" UNIX style behavior. And that
traditional case is obviously one of the cases we very much don't want
to slow down.

But a pinned page has _another_ thing that is special about it: the
pinning action broke COW.

So I think we can simply add a

        if (page_mapcount(page) != 1)
                return false;

to page_maybe_dma_pinned(), and that very naturally protects against
the "is the page count perhaps elevated due to a lot of forking?"

Because pinning forces the mapcount to 1, and while it is pinned,
nothing else should possibly increase it - since the only thing that
would increase it is fork, and the whole point is that we won't be
doing that "page_dup_rmap()" for this page (which is what increases
the mapcount).

So we actually already have a very nice flag for "this page isn't
duplicated by forking".

And if we keep the existing early "ptep_set_wrprotect()", we also know
that we cannot be racing with another thread that is pinning at the
same time, because the fast-gup code won't be touching a read-only
pte.

So we'll just have to mark it writable again before we release the
page table lock, and we avoid that race too.

And honestly, since this is all getting fairly late in the rc, and it
took longer than I thought, I think we should do the GFP_ATOMIC
approach for now - not great, but since it only triggers for this case
that really should never happen anyway, I think it's probably the best
thing for 5.9, and we can improve on things later.

                 Linus
