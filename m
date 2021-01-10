Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 581E92F0958
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jan 2021 20:32:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbhAJTcA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jan 2021 14:32:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726263AbhAJTb7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jan 2021 14:31:59 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 787A9C061786
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jan 2021 11:31:18 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id o17so34809027lfg.4
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jan 2021 11:31:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=U77Z/e7pPvpSKaZjlLCX+01Zq5Bo7+MX62kJ615oHaE=;
        b=G+mRxXy9WB+qwItlNZSVxB/DRWseWVu117U84YUv3t/BfX6ZJJuN6Ym6QluxJ6CZU7
         U4w3a/V2xMaHLe3JZ08/zOZqKMMLmhDFynHH/g9/bslyPz3xd1OC0/uB7FsSgAB8j6hO
         qk7xFViwthsby2Y810OHu+t4uUwexcNAg7BM4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U77Z/e7pPvpSKaZjlLCX+01Zq5Bo7+MX62kJ615oHaE=;
        b=uTRnd+VRFe585K8haceRujhn+44B5MStha7N0Cjr6nektczvDG9FWMgoJhUFQjtBUw
         Fu/HWjFs+EClhHTqCejExy5BQ0xdfvLo68b8ApYeEaQXiz+C7vFPEy7iA5zUPHClPcVQ
         vXXXSLBqZ9p2pf0TA9ITt9hB2soePvrnP5l4Ya3vEhtDuqUD9zoRmEVwpzqPhw0oDcQu
         50JOF0sg8AlIqyoB+9O1hjabpzsoX7MJF4i7LjDZ99N6T//H6ALNqOJmMvjEpriEEK3F
         0q3/p25PGeKL28+uSamV/gp5q0fFaiUJiOAxv3mJE+Uv96s4ekAb+P/M69vNdHECcgsx
         cVVQ==
X-Gm-Message-State: AOAM530tXlgkf/aC3P78cOIHB/VpeQfLU9vFZrWZkNIm2fDwoehPQugK
        WY8N676akZmgxHPH+dxQ4bIhocpoIEey5Q==
X-Google-Smtp-Source: ABdhPJz1fVysAhf+TMcHy1mZ6rDvcCNkPPmBQuXLWWvpy1UJHHbjnhJzZKs3Z/cYq+k3+K5dWTY1nA==
X-Received: by 2002:a19:56:: with SMTP id 83mr6015896lfa.561.1610307076304;
        Sun, 10 Jan 2021 11:31:16 -0800 (PST)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id z14sm3148118ljc.41.2021.01.10.11.31.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Jan 2021 11:31:14 -0800 (PST)
Received: by mail-lf1-f45.google.com with SMTP id a12so34794121lfl.6
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jan 2021 11:31:14 -0800 (PST)
X-Received: by 2002:a05:6512:338f:: with SMTP id h15mr5416099lfg.40.1610307073936;
 Sun, 10 Jan 2021 11:31:13 -0800 (PST)
MIME-Version: 1.0
References: <20210110004435.26382-1-aarcange@redhat.com> <CAHk-=wghqNywtf=sRv_5FmG=+hPGqj=KWakw34tNeoZ1wPuaHg@mail.gmail.com>
 <CAHk-=wj5=1DKbQut1-21EwQbMSghNL3KOSd82rNrBhuG9+eekA@mail.gmail.com>
 <X/prosulFrEoNnoF@redhat.com> <CAHk-=wjZTMsv0_GOyQpLRk_5U1r5W8e21f8sV0jykK=z47hjGQ@mail.gmail.com>
In-Reply-To: <CAHk-=wjZTMsv0_GOyQpLRk_5U1r5W8e21f8sV0jykK=z47hjGQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 10 Jan 2021 11:30:57 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgi31FKc9AL6m87+pb2B79V2g_QjdhmtJNW8Pnq2ERQ-Q@mail.gmail.com>
Message-ID: <CAHk-=wgi31FKc9AL6m87+pb2B79V2g_QjdhmtJNW8Pnq2ERQ-Q@mail.gmail.com>
Subject: Re: [PATCH 0/1] mm: restore full accuracy in COW page reuse
To:     Andrea Arcangeli <aarcange@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
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
        Leon Romanovsky <leonro@nvidia.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Jan Kara <jack@suse.cz>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Nadav Amit <nadav.amit@gmail.com>, Jens Axboe <axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 9, 2021 at 7:51 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> COW is about "I'm about to write to this page, and that means I need
> an _exclusive_ page so that I don't write to a page that somebody else
> is using".

So this kind of fundamentally explains why I hate the games we used to
play wrt page_mapcount(): they were fundamentally fragile. I _much_
prefer just having the rule that we use page_count(), which the above
simple and straightforward single sentence explains 100%.

This gets back to the fact that especially considering how we've had
subtle bugs here (the "wrong-way COW" issue has existed since
literally the first GUP ever, so it goes back decades), I want the
core VM rules to be things that can be explained basically from simple
"first principles".

And the reason I argue for the current direction that I'm pushing, is
exactly that the above is a very simple "first principle" for why COW
exists.

If the rule for COW is simply "I will always COW if it's not clear
that I'm the exclusive user", then COW itself is very simple to think
about.

The other rule I want to stress is that COW is common, and that argues
against the model we used to have of "let's lock the page to make sure
that everything else is stable". That model was garbage anyway, since
page locking doesn't even guarantee any stability wrt exclusive use in
the first place (ie GUP being another example), but it's why I truly
detested the old model that depended so much on the page lock to
serialize things.

So if you start off with the rule that "I will always COW unless I can
trivially see I'm the only owner", then I think we have really made
for a really clear and unambiguous rule.

And remember: COW is only an issue for private mappings. So pretty
much BY DEFINITION, doing a COW is always safe for all normal
circumstances.

Now, this is where it does get subtle: that "all normal circumstances"
part. The one special case is a cache-coherent GUP. It's arguable
whether "pinned" should matter or not, and it would obviously be
better if "pinned" simply didn't matter at all (and the only issue
with any long-term pinning would simply be about resource counting).

The current approach I'm advocating is "coherency means that it must
have been writable", and then the way to solve the whole "Oh, it's
shared with something else" is to simply never accept making it
read-only, because BY DEFINITION it's not _really_ read-only (because
we know we've created that other alias of the virtual address that is
*not* controlled by the page table protection bits).

Notice how this is all both conceptually fairly simple (ie I can
explain the rules in plain English without really making any complex
argument) and it is arguably internally fairly self-consistent (ie the
whole notion of "oh, there's another thing that has write access that
page but doesn't go through the page table, so trying to make it
read-only in the page tables is a nonsensical operation").

Are the end results wrt something like soft-dirty a bit odd? Not
really. If you do soft-dirty, such a GUP-shared page would simply
always show up as dirty. That's still consistent with the rules. If
somebody else may be writing to it because of GUP, that page really
*isn't* clean, and us marking it read-only would be just lying about
things.

I'm admittedly not very happy about mprotect() itself, though. It's
actually ok to do the mprotect(PROT_READ) and turn the page read-only:
that will also disable COW itself (because a page fault will now be a
SIGSEGV, not a COW).

But if you then make it writable again with mprotect(PROT_WRITE), you
*have* lost the WP bit, and you'll COW on a write, and lose the
coherency.

Now, I'm willing to just say: "if you do page pinning, and then do
mprotect(PROT_READ), and then do mprotect(PROT_WRITE) and then write
to the page, you really do get to keep both broken pieces". IOW, I'm
perfectly happy to just say you get what you deserve.

But I'd also be perfectly happy to make the whole "I'm the exclusive
user" logic a bit more extensive. Right now it's basically _purely_
page_count(), and the other part of "I'm the exclusive owner" is that
the RW bit in the page table is simply not clear. That makes things
really easy for COW: it just won't happen in the first place if you
broke the "obviously exclusive" rule with GUP.

But we _could_ do something slightly smarter. But "page_mapcount()" is
not that "slightly smarter" thing, because we already know it's broken
wrt lots of other uses (GUP, page cache, whatever).

Just having a bit in the page flags for "I already made this
exclusive, and fork() will keep it so" is I feel the best option. In a
way, "page is writable" right now _is_ that bit. By definition, if you
have a writable page in an anonymous mapping, that is an exclusive
user.

But because "writable" has these interactions with other operations,
it would be better if it was a harder bit than that "maybe_pinned()",
though. It would be lovely if a regular non-pinning write-GUP just
always set it, for example.

"maybe_pinned()" is good enough for the fork() case, which is the one
that matters for long-term pinning. But it's admittedly not perfect.

                  Linus
