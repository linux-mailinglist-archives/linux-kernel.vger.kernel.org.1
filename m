Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B7102EF741
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 19:22:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728782AbhAHSU7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 13:20:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728505AbhAHSU4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 13:20:56 -0500
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76DCFC061380
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jan 2021 10:19:48 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id z3so7143631qtw.9
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jan 2021 10:19:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=eRLIK07R5/k0ZbmMrIsckpNA62/b6A5anKQsmHzEdBY=;
        b=R+475cboSKr58vv5Hxs0z9t7POpKNf/xhofVv4JdASVwAwEsgcjZcJmwpLBGtHnbMI
         /y4gV0jyoiWjSN+CQcuhmyl+l+hLgRJ3n8luhxBPOfykD4a0qw0AlPCE+FB4nejDX9TQ
         QUPNKenHeiKIbLHyyFjs0Y9mS8tSfEEDX5GAJd+nbuvh94vxkaM9mxkv8owrl/qYzi7a
         Nyx3g4KNCyekZ5JMFw6Kwpc8DJzsP6J/gwh7eXiQJSpg/QozsRrR7jGcpij+crgr5dgc
         FE0j4XH2c76AMTWuGgMUuekYV/I9iVmGyjf7w7wbSoo8Jk46wn2VMC7AMes4ngH5Q9oE
         cSTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eRLIK07R5/k0ZbmMrIsckpNA62/b6A5anKQsmHzEdBY=;
        b=suaPxs9PkeDndcvUJqEDohJy6aSBlylLB6nQwiuZiZke8ZkXPuhlnKNBxljEKdZ8NU
         SlbRMW8XmbF5p+LkEwxfjzZqWffbk42hmXE5J1iv4lQ517GC4m9ZBIlDlJmlCug8HGyr
         UmPG6xrB7Ql/GKDbj8v8YgbDomRbf0Z35hFQdGE7iEqwRquLoKr8+cljmIDeOQ9gY+af
         Nps/yZ44cZiZcSO2sSNWbVusctKavdDCGZ61dB5m62BeI/uXU6voOumEodRRnnOApQr5
         jjPyg/CT91E177sclwyfw1AOnRhJCKlLsQrAGP7r9ugahrB1Tsr9IQg1V3cKNlfJw9Ti
         oizg==
X-Gm-Message-State: AOAM530ccZ3A0aftBna0npotbjXMwpErapPR1DbYcrAEjusxEGORWNeB
        usxunUb4To6QGFxffykPH/CFnQ==
X-Google-Smtp-Source: ABdhPJyuOfC07l6KISbB7sKwd+cR+1B6S/d4qwAz+y56h3RO8A4CD+ubqr00QYTycwUsBN9/P8hF7w==
X-Received: by 2002:ac8:7a81:: with SMTP id x1mr4591721qtr.373.1610129987552;
        Fri, 08 Jan 2021 10:19:47 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-115-133.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.115.133])
        by smtp.gmail.com with ESMTPSA id d46sm4848135qtc.76.2021.01.08.10.19.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jan 2021 10:19:46 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kxwMT-004IpK-Ik; Fri, 08 Jan 2021 14:19:45 -0400
Date:   Fri, 8 Jan 2021 14:19:45 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Andrea Arcangeli <aarcange@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Yu Zhao <yuzhao@google.com>, Andy Lutomirski <luto@kernel.org>,
        Peter Xu <peterx@redhat.com>,
        Pavel Emelyanov <xemul@openvz.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Minchan Kim <minchan@kernel.org>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Leon Romanovsky <leonro@nvidia.com>, Jan Kara <jack@suse.cz>,
        Kirill Tkhai <ktkhai@virtuozzo.com>
Subject: Re: [PATCH 0/2] page_count can't be used to decide when wp_page_copy
Message-ID: <20210108181945.GF504133@ziepe.ca>
References: <B1B85771-B211-4FCC-AEEF-BDFD37332C25@vmware.com>
 <20210107200402.31095-1-aarcange@redhat.com>
 <20210107202525.GD504133@ziepe.ca>
 <X/eA/f1r5GXvcRWH@redhat.com>
 <20210108133649.GE504133@ziepe.ca>
 <X/iPtCktcQHwuK5T@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <X/iPtCktcQHwuK5T@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 08, 2021 at 12:00:36PM -0500, Andrea Arcangeli wrote:
> > The majority cannot be converted to notifiers because they are DMA
> > based. Every one of those is an ABI for something, and does not expect
> > extra privilege to function. It would be a major breaking change to
> > have pin_user_pages require some cap.
> 
> ... what makes them safe is to be transient GUP pin and not long
> term.
> 
> Please note the "long term" in the underlined line.

Many of them are long term, though only 50 or so have been marked
specifically with FOLL_LONGTERM. I don't see how we can make such a
major ABI break.

Looking at it, vmsplice() is simply wrong. A long term page pin must
use pin_user_pages(), and either FOLL_LONGTERM|FOLL_WRITE (write mode)
FOLL_LONGTERM|FOLL_FORCE|FOLL_WRITE (read mode)

ie it must COW and it must reject cases that are not longterm safe,
like DAX and CMA and so on.

These are the well established rules, vmsplice does not get a pass
simply because it is using the CPU to memory copy as its "DMA".

> speaking in practice. io_uring has similar concern but it can use mmu
> notifier, so it can totally fix it and be 100% safe from this.

IIRC io_uring does use FOLL_LONGTERM and FOLL_WRITE..

> The scheduler disclosure date was 2020-08-25 so I can freely explain
> the case that motivated all these changes.
> 
> case A)
> 
> if !fork() {
>    // in child
>    mmap one page
>    vmsplice takes gup pin long term on such page
>    munmap one page
>    // mapcount == 1 (parent mm)
>    // page_count == 2 (gup in child, and parent mm)
> } else {
>    parent writes to the page
>    // mapcount == 1, wp_page_reuse
> }
> 
> parent did a COW with mapcount == 1 so the parent will take over a
> page that is still GUP pinned in the child. 

Sorry, I missed something, how does mmaping a fresh new page in the
child impact the parent?

I guess the issue is not to mmap but to GUP a shared page in a way
that doesn't trigger COW during GUP and then munmap that page so a
future parent COW does re-use, leaking access.

It seems enforcing FOLL_WRITE to always COW on GUP closes this, right?

This is what all correct FOLL_LONGTERM users do today, it is required
for many other reasons beyond this interesting security issue.

> However, you know full well in the second case it is a feature and not
> a bug, that wp_page_reuse is called instead, and in fact it has to be
> called or it's a bug (and that's the bug page_count in do_wp_page
> introduces).

What I was trying to explain below, is I think we agreed that a page
under active FOLL_LONGTERM pin *can not* be write protected.

Establishing the FOLL_LONGTERM pin (for read or write) must *always*
break the write protection and the VM *cannot* later establish a new
write protection on that page while the pin is active.

Indeed, it is complete nonsense to try and write protect a page that
has active DMA write activity! Changing the CPU page protection bits
will not stop any DMA! Doing so will inevitably become a security
problem with an attack similar to what you described.

So this is what was done during fork() - fork will no longer write
protect pages under FOLL_LONGTERM to make them COWable, instead it
will copy them at fork time.

Any other place doing write protect must also follow these same
rules.

I wasn't aware this could be used to create a security problem, but it
does make sense. write protect really must mean writes to the memory
must stop and that is fundementally incompatible with active DMA.

Thus write protect of pages under DMA must be forbidden, as a matter
of security.

Jason
