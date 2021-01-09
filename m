Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 677EE2F0342
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jan 2021 20:53:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726465AbhAITxG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jan 2021 14:53:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726068AbhAITxG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jan 2021 14:53:06 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 721ACC061786
        for <linux-kernel@vger.kernel.org>; Sat,  9 Jan 2021 11:52:25 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id u25so10536417lfc.2
        for <linux-kernel@vger.kernel.org>; Sat, 09 Jan 2021 11:52:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=veLut2Mq67QlA+4PjesLq+vNFT/elLTUULwTvEbHofA=;
        b=GlclWeZ9nBeSxG/j4lXsymddq6D/nXzTQ1864ONV4MnfIJph4uPm/YIxt3/2aVCGt7
         q9bHnIkyRQNn0BrnVGVX4f8SVLvpAksZdPxJNAN7hsvl+HgfPSuRHWVd3/N/sRGGiGkF
         5h3Ip2bsNYBPb+Fmm7zFXD/qP3cCRJS0kSlQI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=veLut2Mq67QlA+4PjesLq+vNFT/elLTUULwTvEbHofA=;
        b=KoxsKIH+LrjunlbBICVAV79wsqbJH8+wGNW8lRyw+pfN3b2TVXqLo327mQr5At5d2i
         6KxH/m3/cswOv1aEGJXfNGh2bOvCgqe0hs96h8kucwQTi7LjTLRR+CuK8JUwodQHJuR0
         4Mr0t0eMFQ6F0c+xB+j8o/qX3qcsCvPvdKnz9t1+HEW0jj7JNNLPtBQ3YPg0P32SZi2a
         6nF+GnJb0l8jLHy5brMOk0KhGtkztgMyfE4hArUCKNgnr7Bwf1inkiS5x2R7svmDQyNS
         R9Hv0MEJyhxNUgawP6DGVEyFrD5GpNJejahNCthddN74x89Yls9N5utZ0cey3o5UiWqc
         Ojuw==
X-Gm-Message-State: AOAM53143cEARG2j06in4r5d02i6CwCaK97UdQFgyTnsO33/bTfZ+KtS
        +oWTG2B5dUevHSruD1M5zw0bE3XCw5O1uQ==
X-Google-Smtp-Source: ABdhPJzQqTLaJTs9DZLKCyEBtKHOQn2KIgosZOGvdmgIfoKSXgArlSvi7ZyGZZ9p+PTQxOH4yve5WA==
X-Received: by 2002:a19:8a46:: with SMTP id m67mr3907423lfd.515.1610221943688;
        Sat, 09 Jan 2021 11:52:23 -0800 (PST)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id p18sm2697467ljc.40.2021.01.09.11.52.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Jan 2021 11:52:23 -0800 (PST)
Received: by mail-lf1-f42.google.com with SMTP id 23so31236597lfg.10
        for <linux-kernel@vger.kernel.org>; Sat, 09 Jan 2021 11:52:23 -0800 (PST)
X-Received: by 2002:a2e:9d89:: with SMTP id c9mr4479195ljj.220.1610221622595;
 Sat, 09 Jan 2021 11:47:02 -0800 (PST)
MIME-Version: 1.0
References: <B1B85771-B211-4FCC-AEEF-BDFD37332C25@vmware.com>
 <20210107200402.31095-1-aarcange@redhat.com> <20210107202525.GD504133@ziepe.ca>
 <CAHk-=wjTuS9JB=Ms4WAMaOkGuLmvYwaf2W0JhXxNPdcv4NWZUA@mail.gmail.com>
 <CAHk-=wjDkyom4haQu6OU_yykkCFqMi98qO2gUPgZBF-11krRAA@mail.gmail.com> <20210109193224.GB35215@casper.infradead.org>
In-Reply-To: <20210109193224.GB35215@casper.infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 9 Jan 2021 11:46:46 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgv=fz=c34MJOUbdSOVb6pGXkEXx9OnTz7weuYYBhd5pQ@mail.gmail.com>
Message-ID: <CAHk-=wgv=fz=c34MJOUbdSOVb6pGXkEXx9OnTz7weuYYBhd5pQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] page_count can't be used to decide when wp_page_copy
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yu Zhao <yuzhao@google.com>, Andy Lutomirski <luto@kernel.org>,
        Peter Xu <peterx@redhat.com>,
        Pavel Emelyanov <xemul@openvz.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Minchan Kim <minchan@kernel.org>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Hugh Dickins <hughd@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Leon Romanovsky <leonro@nvidia.com>, Jan Kara <jack@suse.cz>,
        Kirill Tkhai <ktkhai@virtuozzo.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 9, 2021 at 11:33 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Thu, Jan 07, 2021 at 01:05:19PM -0800, Linus Torvalds wrote:
> > Side note, and not really related to UFFD, but the mmap_sem in
> > general: I was at one point actually hoping that we could make the
> > mmap_sem a spinlock, or at least make the rule be that we never do any
> > IO under it. At which point a write lock hopefully really shouldn't be
> > such a huge deal.
>
> There's a (small) group of us working towards that.  It has some
> prerequisites, but where we're hoping to go currently:
>
>  - Replace the vma rbtree with a b-tree protected with a spinlock
>  - Page faults walk the b-tree under RCU, like peterz/laurent's SPF patchset
>  - If we need to do I/O, take a refcount on the VMA
>
> After that, we can gradually move things out from mmap_sem protection
> to just the vma tree spinlock, or whatever makes sense for them.  In a
> very real way the mmap_sem is the MM layer's BKL.

Well, we could do the "no IO" part first, and keep the semaphore part.

Some people actually prefer a semaphore to a spinlock, because it
doesn't end up causing preemption issues.

As long as you don't do IO (or memory allocations) under a semaphore
(ok, in this case it's a rwsem, same difference), it might even be
preferable to keep it as a semaphore rather than as a spinlock.

So it doesn't necessarily have to go all the way - we _could_ just try
something like "when taking the mmap_sem, set a thread flag" and then
have a "warn if doing allocations or IO under that flag".

And since this is about performance, not some hard requirement, it
might not even matter if we catch all cases.  If we fix it so that any
regular load on most normal filesystems never see the warning, we'd
already be golden.

Of course, I think we've had issues with rw_sems for _other_ reasons.
Waiman actually removed the reader optimistic spinning because it
caused bad interactions with mixed reader-writer loads.

So rwsemapores may end up not working as well as spinlocks if the
common situation is "just wait a bit, you'll get it".

                   Linus
