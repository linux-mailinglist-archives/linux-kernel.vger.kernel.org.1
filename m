Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE16729118D
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Oct 2020 13:02:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437557AbgJQLCl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Oct 2020 07:02:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437536AbgJQLCk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Oct 2020 07:02:40 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F181AC0613D5
        for <linux-kernel@vger.kernel.org>; Sat, 17 Oct 2020 04:02:38 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id y16so5510215ljk.1
        for <linux-kernel@vger.kernel.org>; Sat, 17 Oct 2020 04:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ryHcnFL3X2ubTpBi4U39WXt6C9kRreCQ/0huSf2L3do=;
        b=aOWznuCaQIlixDU6SOesCp6hl51I1s6KBDUb+jgvBaeife3h9N30l976G6IrkovzTQ
         FSIWj+wmSSx2kzywl0OajEnHOszeeqwksy0drW25QW6E0tqsJD4Qs53VdDkR0LoqUYxm
         rDoVg7ZYME194C3fODz2iU4P96FsjnkELXjqQy16AXZ4mBpFXdYcZWyo+fF33sL86Z3K
         9evbXoKZ+yEGX7TbxJmgjtyQvHdTJDj2ZNhfAU9l+E35NoqMjMSwmoS2YpVt7B3G8rM8
         IggfzkJlJ69uFBZD7IGI8u41HdWzXkHpW5AXjZynudtn7ekuNqQ3FOlqer1KlukwYjgC
         F3Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ryHcnFL3X2ubTpBi4U39WXt6C9kRreCQ/0huSf2L3do=;
        b=WcwWcJ+bdKYciLV6dWJSw6Ws9DypEwPAeE2eoBgpPR4Mfyv2iiETKvfZZeiuNaN+ia
         9ODVtrTm/Pr+c1lvLx4st23/QpE/iFBxFYA2utt0ipQ9zEzaZ8+sc4TDk4banO+Fu3Kq
         UynFksqjxeQ0vNFwNVhottU7TPG6fapnWLcYBhZoa4H/rVv5VcenQtCnFCJvLxfskEnn
         ctEqEp5SQ2XuQYHGT/rd13O+ylyBryvMmFdP1y48hBiJ7zbzMfRK2t+ng9MKTS9jqETa
         JrpJCCjCYJykV0QmXL+IaKK1V9adKE00iCi/GDbbzbtOAu4ZiLFbEF3wWWlfe3IQWLaZ
         Ublg==
X-Gm-Message-State: AOAM5331vibojcmOk81Ab0yr4ipKoD+tQ83l8ZF+Zd6pYk/sfz1MW7ID
        CXkrF79D318xMS972t4mKrze4n+zSlfDzIIgFn+Fxg==
X-Google-Smtp-Source: ABdhPJzEAJpkMmeWOAsIyaY5DQSRSQojEHMoHGdEt3bZzz+5k9SDt+ciMo/9jdZGqVTpXGdmFn57NiiVo2tLReq0cdY=
X-Received: by 2002:a2e:8816:: with SMTP id x22mr2949059ljh.377.1602932556614;
 Sat, 17 Oct 2020 04:02:36 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000014370305b1c55370@google.com> <202010162042.7C51549A16@keescook>
 <CACT4Y+bG=89ii+kzgGvNiZnB9ZEcAsy-3YofJeW5K_rynp_S7g@mail.gmail.com>
In-Reply-To: <CACT4Y+bG=89ii+kzgGvNiZnB9ZEcAsy-3YofJeW5K_rynp_S7g@mail.gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Sat, 17 Oct 2020 13:02:10 +0200
Message-ID: <CAG48ez0LKk7iEersZe-S25SGJm-AFVW2jzG32X=NkKon+1Fuxw@mail.gmail.com>
Subject: Re: UBSAN: array-index-out-of-bounds in alg_bind
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        syzbot <syzbot+92ead4eb8e26a26d465e@syzkaller.appspotmail.com>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        linux-hardening@vger.kernel.org,
        Elena Petrova <lenaptr@google.com>,
        Vegard Nossum <vegard.nossum@oracle.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 17, 2020 at 12:50 PM Dmitry Vyukov <dvyukov@google.com> wrote:
> On Sat, Oct 17, 2020 at 5:49 AM Kees Cook <keescook@chromium.org> wrote:
> > On Fri, Oct 16, 2020 at 01:12:24AM -0700, syzbot wrote:
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=92ead4eb8e26a26d465e
> > > [...]
> > > Reported-by: syzbot+92ead4eb8e26a26d465e@syzkaller.appspotmail.com
> > > [...]
> > > UBSAN: array-index-out-of-bounds in crypto/af_alg.c:166:2
> > > index 91 is out of range for type '__u8 [64]'
> >
> > This seems to be an "as intended", if very odd. false positive (the actual
> > memory area is backed by the on-stack _K_SS_MAXSIZE-sized sockaddr_storage
> > "address" variable in __sys_bind. But yes, af_alg's salg_name member
> > size here doesn't make sense.
>
> As Vegard noted elsewhere, compilers can start making assumptions
> based on absence of UB and compile code in surprising ways as the
> result leading to very serious and very real bugs.
>
> One example would be a compiler generating jump table for common sizes
> during PGO and leaving size > 64 as wild jump.
>
> Another example would be a compiler assuming that copy size <= 64.
> Then if there is another copy into a 64-byte buffer with a proper size
> check, the compiler can now drop that size check (since it now knows
> size <= 64) and we get real stack smash (for a copy that does have a
> proper size check before!).

FWIW, the kernel currently still has a bunch of places that use
C89-style length-1 arrays (which were in the past used to work around
C89's lack of proper flexible arrays). Gustavo A. R. Silva has a bunch
of patches pending to change those places now, but those are not
marked for stable backporting; so in all currently released kernels,
we'll probably keep having length-1 arrays at the ends of C structs
that are used as if they were flexible arrays. (Unless someone makes
the case that these patches are not just cleanups but actually fix
some sort of real bug, and therefore need to be backported.)

The code in this example looks just like one of those C89-style
length-1 arrays to me (except that the length isn't 1).

Of course I do agree that this should be cleaned up, and that having
bogus array lengths in the source code is a bad idea.

> And we do want compilers to be that smart today. Because of all levels
> of abstractions/macros/inlining we actually have lots of
> redundant/nonsensical code in the end after all inlining and
> expansions, and we do want compilers to infer things, remove redundant
> checks, etc so that we can have both nice abstract source code and
> efficient machine code at the same time.

I guess that kinda leads to the question: Do we just need to fix the
kernel code here (which is comparatively easy), or do you think that
this is a sufficiently big problem that we need to go and somehow
change the actual UAPI headers here (e.g. by deprecating the existing
UAPI struct and making a new one with a different name)?
