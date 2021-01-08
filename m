Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE0AC2EF7D0
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 20:01:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728833AbhAHTAh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 14:00:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728061AbhAHTAg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 14:00:36 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF3B1C061381
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jan 2021 10:59:55 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id o13so25417223lfr.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jan 2021 10:59:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mzgwJG9AN+Kw8A5nsRsgdQNOmS3gSYvBdFF/kGI96fg=;
        b=AYmpBNSAHkcQMH7EvVO5b8/9x0BtDIqWdmmprlcc7kj5j2PtWiHA6PvS2qau3UgzJg
         sn/tN73gL1GWNCXBwpQ/q4vCl/iVTCtJDXh5uGUecmv0ZHC+MkIv8IAJxDWIg99V523W
         p8WhMm1ZsIsQr1D6wEFxim/maKpuCkXeyVsHA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mzgwJG9AN+Kw8A5nsRsgdQNOmS3gSYvBdFF/kGI96fg=;
        b=LqKzarhUqrTuKhls1zNZoocqHJzfLXoA2/ApljTnuhIs6J+Vz1EJnTJokEISIPa1Tx
         4K+sOFVXXz4A4rF6L+Rh6ITnZhKwRghBrdWMdf08aUyXYH4ME7IfprpkG7SWYfCIAYcQ
         iq1tDh8kDtVjQZkiLu95ZdZpbADdZGAAOFNmnCbZVXQmcF8eFTEGjdijkHLRAKcKCKDp
         Rifq9v76iWdHS/isVOXmk4NCOW47zZXfb/6Di/avB07mWTJmM4s0tBjfgG7jY2HEz16X
         cQfmiBsDrpS8slqLaNMXxPEri9jWwitcm0+Xca/zXdE4cjGqDqQ7PdNhYKqTUvI+1Chh
         9hAQ==
X-Gm-Message-State: AOAM530ywFy/3NFbl52BRo3JXbWAb+kIRY45EQvIrQYTflEnykLmibCm
        TvG/rYu5GtKBPa+DDSBQl1Ht/ZrvySUaaQ==
X-Google-Smtp-Source: ABdhPJxDMPPZyQRJO0NgTGcB7XlTcvSSa7Rr2wYV2O2h6K/FG1SkKuHK+6UIckxnvksPRR7TMnr0NQ==
X-Received: by 2002:a05:6512:3319:: with SMTP id k25mr2390775lfe.128.1610132393852;
        Fri, 08 Jan 2021 10:59:53 -0800 (PST)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id b22sm2118681lfp.233.2021.01.08.10.59.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Jan 2021 10:59:52 -0800 (PST)
Received: by mail-lf1-f46.google.com with SMTP id o13so25416930lfr.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jan 2021 10:59:52 -0800 (PST)
X-Received: by 2002:a2e:9ad7:: with SMTP id p23mr1972594ljj.465.1610132391703;
 Fri, 08 Jan 2021 10:59:51 -0800 (PST)
MIME-Version: 1.0
References: <B1B85771-B211-4FCC-AEEF-BDFD37332C25@vmware.com>
 <20210107200402.31095-1-aarcange@redhat.com> <20210107202525.GD504133@ziepe.ca>
 <X/eA/f1r5GXvcRWH@redhat.com> <20210108133649.GE504133@ziepe.ca>
 <X/iPtCktcQHwuK5T@redhat.com> <20210108181945.GF504133@ziepe.ca>
In-Reply-To: <20210108181945.GF504133@ziepe.ca>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 8 Jan 2021 10:59:35 -0800
X-Gmail-Original-Message-ID: <CAHk-=wirQT8Sc8ZJwLqUfet1GTokyc0L0Vt+Y_b0mS++KbX36g@mail.gmail.com>
Message-ID: <CAHk-=wirQT8Sc8ZJwLqUfet1GTokyc0L0Vt+Y_b0mS++KbX36g@mail.gmail.com>
Subject: Re: [PATCH 0/2] page_count can't be used to decide when wp_page_copy
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
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
        Matthew Wilcox <willy@infradead.org>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Leon Romanovsky <leonro@nvidia.com>, Jan Kara <jack@suse.cz>,
        Kirill Tkhai <ktkhai@virtuozzo.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 8, 2021 at 10:19 AM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> Sorry, I missed something, how does mmaping a fresh new page in the
> child impact the parent?
>
> I guess the issue is not to mmap but to GUP a shared page

No.

It has nothing to do with a shared page.

The problem with the COW in the child is that the parent now BELIEVES
that it has a private copy (because page_mapcount() was 1), but it
doesn't really.

But because the parent *thought* it had a private copy of the page,
when the _parent_ did a write, it would cause the page COW logic to go
"you have exclusive access to the page, so I'll just make it
writable".

The parent then writes whatever private data to that page.

That page is still in the system as a vmsplice'd page, and the child
can now read that private data that was _supposed_ to be exclusive to
the parent, but wasn't.

And the thing is, blaming vmsplice() is entirely wrong. The exact same
thing used to be able to happen with any GUP case, vmsplice() was just
the simplest way to cause that non-mapped page access. But any GUP
could do it, with the child basically fooling the parent into
revealing data.

Note that Zygote itself is in no way special from a technical
standpoint, and this can happen after any random fork().

The only real difference is that in all *traditional* UNIX cases, this
"child can see the parent's data with trickery before execve()"
situation simply doesn't *matter*.  In traditional fork() situations,
the parent and the child are really the same program, and if you don't
trust the child, then you don't trust the parent either.

The Android Zygote case isn't _technically_ any different. But the
difference is that because the whole idea with Zygote is to pre-map
the JIT stuff for the child, you are in this special situation where
the parent doesn't actually trust the child.

See? No _technical_ difference. Exact same scenario as for any random
fork() with GUP and COW going the wrong way.

It just normally doesn't _matter_.

And see above: because this is not really specific to vmsplice()
(apart from that just being the easiest model), the _original_ fix for
this was just "GUP will break COW early" commit:

   17839856fd58 ("gup: document and work around "COW can break either
way" issue")

which is very straightforward: if you do a GUP lookup, you force that
GUP to do the COW for you, so that nobody can then fool another
process to think that it has a private page that can be re-used, but
it really has a second reference to it. Because whoever took the
"sneaky" GUP reference had to get their _own_ private copy first.

But while that approach was very simple and very targeted (and I don't
think it's wrong per se), it then caused other problems.

In fact, it caused other problems for pretty much all the same cases
that the current model causes problems for: all the odd special cases
that do weird things to the VM.

And because these problems were so odd, the alternate solution - and
the thing I'm really pushing for - is to make the _core_ VM rules very
simple and straightforward, and then the odd special cases have to
live with those simple and straightforward rules.

And the most core of those rules is that "page_mapcount()"
fundamenally doesn't matter, because there are other references to
pages that are all equally valid. Thinking that a page being "mapped"
makes is special is wrong, as exemplified by any GUP case (but also as
exemplified by the page cache or the swap cache, which were always a
source of _other_ special cases for the COW code).

So if you accept that notion of "page_mapcount()" is meaninfless being
a truism (which Andrea obviously doesn't), then the logical extension
of that is the set of rules I outlined in my reply to Andy:

 (a) COW can never happen "too much", and "page_count()" is the
fundamental "somebody has a reference to this page"

 (b) page pinning and any other "this needs to be coherent" ends up
being a special per-page "shared memory" case

That special "shared memory page" thing in (b) is then that rule that
when we pin a page, we make sure it's writable, and stays writable, so
that COW never breaks the association.

That's then the thing that causes problems for anybody who wants to
write-protect stuff.

         Linus
