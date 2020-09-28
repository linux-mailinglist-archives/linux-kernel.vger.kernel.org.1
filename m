Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C76CA27B3B9
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 19:54:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbgI1Ryt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 13:54:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbgI1Rys (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 13:54:48 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E0E5C061755
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 10:54:48 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id b12so2312114lfp.9
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 10:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nVQLqfhAMue9WFpIvdR+SPVZ27tvqqW+KhexMPe51Eg=;
        b=JESamvpCr7P6D1koJK+bYfaWc/gIRk+gxvqsb639smqknsgpUtq8ybZgdz3KmpdwSm
         BOGvMs13i1hIOhbXZ0kGX29MC4GwdbFoVGM2scepvfxdiRoWcX0JUlgsoAwS9IECgBin
         SZ2Psk9nWs4dIJn0dtt/AdBJw4kExf40QIIsI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nVQLqfhAMue9WFpIvdR+SPVZ27tvqqW+KhexMPe51Eg=;
        b=dit+RsPI4e+zFwGnmmSqiIa0o10me6reBUpxoyImBjYJ3U4L8NJheDFGwx+63d66G+
         +fSg1Ts9f1ic0bwiznWVsuezusboKvp/2hrIRiYufRMdYFifqj8Gct6eTWmjZtwYyvMf
         FAcW7G7tX4/RK2wjUAV9aIlpnll7zVhpd0TD8Om3AW03Q3G9WP90sGYt/cDaZ//q/Ewv
         uNmKuE8KITI0RdOypvqs1F1OX1yTPFVFTVBUUhK3IOiVvPIxaOxXtIukWPWDNAfCy/ic
         RYJJil7eFKzV4/I8jAG6mLO7cNy7tw0mHzp/VxqMstb6HKki8yrZ9KycyARIDEKUbKdb
         fzkA==
X-Gm-Message-State: AOAM531SqPB8gsyL8sqjvyAnP3kJztJMg3xy3LhWhXi7W0r8zo28U8Ko
        EbaUz16NUMrMOqkzDeOsV+c19bJoG3xDSQ==
X-Google-Smtp-Source: ABdhPJxSPjXihbu+dGQqyY/DaaC2l4JDn6iMDloXhPCVIQJ4l7BbwRTviW1AqKeqy3AoSlMXm3Xbyg==
X-Received: by 2002:a19:cb12:: with SMTP id b18mr958901lfg.417.1601315686219;
        Mon, 28 Sep 2020 10:54:46 -0700 (PDT)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id y196sm2977904lfa.0.2020.09.28.10.54.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Sep 2020 10:54:46 -0700 (PDT)
Received: by mail-lf1-f46.google.com with SMTP id b22so2285149lfs.13
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 10:54:45 -0700 (PDT)
X-Received: by 2002:ac2:4a6a:: with SMTP id q10mr786502lfp.534.1601315685097;
 Mon, 28 Sep 2020 10:54:45 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wgz5SXKA6-uZ_BimOP1C7pHJag0ndz=tnJDAZS_Z+FrGQ@mail.gmail.com>
 <CAHk-=whDSH_MRMt80JaSwoquzt=1nQ-0n3w0aVngoWPAc10BCw@mail.gmail.com>
 <20200926004136.GJ9916@ziepe.ca> <CAHk-=wiutA_J-OfvrD8Kp3SoYcfMHUwsU7ViOH48q7QN0AQ6eg@mail.gmail.com>
 <CAHk-=wi_gd+JWj-8t8tc8cy3WZ7NMj-_1hATfH3Rt0ytUxtMpQ@mail.gmail.com>
 <20200927062337.GE2280698@unreal> <CAHk-=winqSOFsdn1ntYL13s2UuhpQQ9+GRvjWth3sA5APY4Wwg@mail.gmail.com>
 <CAHk-=wj61s30pt8POVtKYVamYTh6h=7-_ser2Hx9sEjqeACkDA@mail.gmail.com>
 <20200928124937.GN9916@ziepe.ca> <CAHk-=wj6aTsqq6BAUci-NYJ3b-EkDwVgz_NvW_kW8KBqGocouQ@mail.gmail.com>
 <20200928172256.GB59869@xz-x1>
In-Reply-To: <20200928172256.GB59869@xz-x1>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 28 Sep 2020 10:54:28 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi=iCnYCARbPGjkVJu9eyYeZ13N64tZYLdOB8CP5Q_PLw@mail.gmail.com>
Message-ID: <CAHk-=wi=iCnYCARbPGjkVJu9eyYeZ13N64tZYLdOB8CP5Q_PLw@mail.gmail.com>
Subject: Re: [PATCH 1/5] mm: Introduce mm_struct.has_pinned
To:     Peter Xu <peterx@redhat.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leonro@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jan Kara <jack@suse.cz>, Michal Hocko <mhocko@suse.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Kirill Shutemov <kirill@shutemov.name>,
        Hugh Dickins <hughd@google.com>,
        Christoph Hellwig <hch@lst.de>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 28, 2020 at 10:23 AM Peter Xu <peterx@redhat.com> wrote:
>
> Yes...  Actually I am also thinking about the complete solution to cover
> read-only fast-gups too, but now I start to doubt this, at least for the fork()
> path.  E.g. if we'd finally like to use pte_protnone() to replace the current
> pte_wrprotect(), we'll be able to also block the read gups, but we'll suffer
> the same degradation on normal fork()s, or even more.  Seems unacceptable.

So I think the real question about pinned read gups is what semantics
they should have.

Because honestly, I think we have two options:

 - the current "it gets a shared copy from the page tables"

 - the "this is an exclusive pin, and it _will_ follow the source VM
changes, and never break"

because honestly, if we get a shared copy at the time of the pinning
(like we do now), then "fork()" is entirely immaterial. The fork() can
have happened ages ago, that page is shared with other processes, and
anybody process writing to it - including very much the pinning one -
will cause a copy-on-write and get a copy of the page.

IOW, the current - and past - semantics for read pinning is that you
get a copy of the page, but any changes made by the pinning process
may OR MAY NOT show up in your pinned copy.

Again: doing a concurrent fork() is entirely immaterial, because the
page can have been made a read-only COW page by _previous_ fork()
calls (or KSM logic or whatever).

In other words: read pinning gets a page efficiently, but there is
zero guarantee of any future coherence with the process doing
subsequent writes.

That has always been the semantics, and FOLL_PIN didn't change that at
all. You may have had things that worked almost by accident (ie you
had made the page private by writing to it after the fork, so the read
pinning _effectively_ gave you a page that was coherent), but even
that was always accidental rather than anything else. Afaik it could
easily be broken by KSM, for example.

In other words, a read pin isn't really any different from a read GUP.
You get a reference to a page that is valid at the time of the page
lookup, and absolutely nothing more.

Now, the alternative is to make a read pin have the same guarantees as
a write pin, and say "this will stay attached to this MM until unmap
or unpin".

But honestly, that is largely going to _be_ the same as a write pin,
because it absolutely needs to do a page COW at the time of the
pinning to get that initial exclusive guarantee in the first place.
Without that initial exclusivity, you cannot avoid future COW events
breaking the wrong way.

So I think the "you get a reference to the page at the time of the
pin, and the page _may_ or may not change under you if the original
process writes to it" are really the only relevant semantics. Because
if you need those exclusive semantics, you might as well just use a
write pin.

The downside of a write pin is that it not only makes that page
exclusive, it also (a) marks it dirty and (b) requires write access.
That can matter particularly for shared mappings. So if you know
you're doing the pin on a shared mmap, then a read pin is the right
thing, because the page will stay around - not because of the VM it
happens in, but because of the underlying file mapping!

See the difference?

> The other question is, whether we should emphasize and document somewhere that
> MADV_DONTFORK is still (and should always be) the preferred way, because
> changes like this series can potentially encourage the other way.

I really suspect that the concurrent fork() case is fundamentally hard
to handle.

Is it impossible? No. Even without any real locking, we could change
the code to do a seqcount_t, for example. The fastgup code wouldn't
take a lock, but it would just fail and fall back to the slow code if
the sequence count fails.

So the copy_page_range() code would do a write count around the copy:

    write_seqcount_begin(&mm->seq);
    .. do the copy ..
    write_seqcount_end(&mm->seq);

and the fast-gup code would do a

    seq = raw_read_seqcount(&mm->seq);
    if (seq & 1)
        return -EAGAIN;

at the top, and do a

    if (__read_seqcount_t_retry(&mm->seq, seq) {
       .. Uhhuh, that failed, drop the ref to the page again ..
        return -EAGAIN;
    }

after getting the pin reference.

We could make this conditional on FOLL_PIN, or maybe even a new flag
("FOLL_FORK_CONSISTENT").

So I think we can serialize with fork() without serializing each and every PTE.

If we want to and really need to.

Hmm?

               Linus
