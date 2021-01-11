Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 697A82F0AB8
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 02:20:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727082AbhAKBTU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jan 2021 20:19:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726362AbhAKBTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jan 2021 20:19:20 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC41EC061786
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jan 2021 17:18:39 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id z5so16174175iob.11
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jan 2021 17:18:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+NrnyZaq7NMDmL0oQZNOQS7o3D1qvxpQlNe+NJXrQZA=;
        b=pEOVX2qcwhXtTq/f3IeKVXWqsuiDDa/iLlSDYm5CzthH6/M6LsrHdCA/eTub0UcETe
         oCapk6sAy1cVrx6knya2bMx5iH7mjwwJn3a0ojAbe8qW3fpo3yFm3KttYuecuADNKjAP
         +/lME2OLTUixfGgwPzYpoJ3Im0OPDsK/mQeda/Uikh7Q8dAMOnfVndhkpiwbteeqHyiB
         QQKEGaL/i3npr9YDd12WrB9Kat5cJjkiW0uG5CmZj+Q3MkGqDG7dQd06LFbwwijrslGn
         2D4x+f+6bqYRFOzqdlZhhMMRcbM2exRm4NxW42hU4sCSbLTRHAILPJYhiIKoYRlfYXK6
         rwFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+NrnyZaq7NMDmL0oQZNOQS7o3D1qvxpQlNe+NJXrQZA=;
        b=h6hV89wMvU3wmC6OJXHHHLt22qwZkaqm+0wAIifXYAx2fYG5r3tpXqoS6FgtFX5TAy
         NahSi3cAHkjT6VsAvagLo/aoBgfkINrLsxCUZzFC9U7KyZGB12Lt8ZwiKCM4tkO3K7Lr
         tt707/E57UqEwBo/IEy6N6d/5TFw4O96DzyVUfw9zw6JBehDsDrE935kGSjUkXzE8c8e
         gxEH3nZ51Q41E27wMxUFojQCQAPDjYW3yrJYZypCWAx4rzvBaUb3O/A5YQnJMJ35MEwi
         yK+7Zd+R5WIrGgwQQXzWhLDJOwa0sLpUD6LBHNXsERAQrtqp6uYxhvAEO4LMwAgzs7MS
         vKog==
X-Gm-Message-State: AOAM531sm28muyIkurGG0Sbn9CgYtPqPO7CjukALZrN/EKh0yRBEMOmh
        vNs3DD6INCplehTNnw70t90IXA==
X-Google-Smtp-Source: ABdhPJwfjHPhqnVLvq1fzQka3jPqKfPQRjWODvzOBEtzJhyuog8aE+wcZVY71r9NiIP4PoCZ29/xnA==
X-Received: by 2002:a6b:6106:: with SMTP id v6mr13275198iob.39.1610327919037;
        Sun, 10 Jan 2021 17:18:39 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-115-133.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.115.133])
        by smtp.gmail.com with ESMTPSA id h70sm10410939iof.31.2021.01.10.17.18.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Jan 2021 17:18:38 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kylqv-005JaH-78; Sun, 10 Jan 2021 21:18:37 -0400
Date:   Sun, 10 Jan 2021 21:18:37 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
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
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Leon Romanovsky <leonro@nvidia.com>, Jan Kara <jack@suse.cz>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Nadav Amit <nadav.amit@gmail.com>, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 0/1] mm: restore full accuracy in COW page reuse
Message-ID: <20210111011837.GH504133@ziepe.ca>
References: <20210110004435.26382-1-aarcange@redhat.com>
 <CAHk-=wghqNywtf=sRv_5FmG=+hPGqj=KWakw34tNeoZ1wPuaHg@mail.gmail.com>
 <CAHk-=wj5=1DKbQut1-21EwQbMSghNL3KOSd82rNrBhuG9+eekA@mail.gmail.com>
 <X/prosulFrEoNnoF@redhat.com>
 <CAHk-=wjZTMsv0_GOyQpLRk_5U1r5W8e21f8sV0jykK=z47hjGQ@mail.gmail.com>
 <CAHk-=wgi31FKc9AL6m87+pb2B79V2g_QjdhmtJNW8Pnq2ERQ-Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgi31FKc9AL6m87+pb2B79V2g_QjdhmtJNW8Pnq2ERQ-Q@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 10, 2021 at 11:30:57AM -0800, Linus Torvalds wrote:

> Notice how this is all both conceptually fairly simple (ie I can
> explain the rules in plain English without really making any complex
> argument) and it is arguably internally fairly self-consistent (ie the
> whole notion of "oh, there's another thing that has write access that
> page but doesn't go through the page table, so trying to make it
> read-only in the page tables is a nonsensical operation").

Yes exactly!
 
> Are the end results wrt something like soft-dirty a bit odd? Not
> really. If you do soft-dirty, such a GUP-shared page would simply
> always show up as dirty. That's still consistent with the rules. If
> somebody else may be writing to it because of GUP, that page really
> *isn't* clean, and us marking it read-only would be just lying about
> things.
> 
> I'm admittedly not very happy about mprotect() itself, though. It's
> actually ok to do the mprotect(PROT_READ) and turn the page read-only:
> that will also disable COW itself (because a page fault will now be a
> SIGSEGV, not a COW).

I would say even mprotect should not set write protect on page under
DMA, it seems like the sort of thing that will trip up other parts of
the mm that might sensibly assume read-only actually means read only,
not 'probably read-only but there might be DMA writes anyhow'

So copy the page before write protecting it? Then the explicit
mprotect is one of the system calls that can cause de-coherence of the
DMA - like munmap.

If we had reliable pinned detection I'd say to fail the mprotect..

And I think you are right about clear refs too. Clear refs must be
aware of FOLL_LONGTERM and handle it properly - which includes not
write protecting such a page.

Jason
