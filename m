Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49FAE2F21DA
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 22:34:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730167AbhAKVdh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 16:33:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727073AbhAKVdg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 16:33:36 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEF6AC061795
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 13:32:55 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id ce23so457301ejb.8
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 13:32:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=50L+1hnJJiPA478RLj/gLuEG+isMc9fiaMNBoBubFG8=;
        b=rYOp9BCUVy7bgeYU35xdwLribm7Ww37Bcp1eJcWjuc90z/LhUUyMPc19HCdqTD9l67
         cd7GR+imksIxIU/WsQLWGGaJwGxPmCMbUdUzfXyohigz6XcMRByOcdeY/ZhAenAMpTwA
         TfMVLU1yeUw8nGcMTu9UfQXyqb56ftQSQJVpOy227M/Qr3ML+GTo+2e+WO2M2d86uFFh
         H9nxrtZSY5Q//LSDZvsOJSsTnRMj+gn2d5mMpa0JN0ET6dmpD5wJRfs58n3zp176Hy+0
         TdzKJLJSR1qTLZlQxX1nnsFosQCCpbL4aMhAwViuDQUIsOJNg091t58ZiFilVJTroXIM
         1VCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=50L+1hnJJiPA478RLj/gLuEG+isMc9fiaMNBoBubFG8=;
        b=Kln3xKPRIJzQ44PAQSX2OCaJpFbQRdQger8ELoPLghoSOgnG61O4dmGbH3FqythhsJ
         c8i7e/RrEOQjH40BVrRcUnvcYd0g7McnKVy+641wn5WMFnmpj9ZLQejdIrVD83qpJlJ+
         1KsmemL1FulDrwRep1+ChKPRzU5Iz6hWzE06HQgxF/e5jq6GLq+iZrBWlzS0mXvnY9wF
         5IrYmviBARanBLNC4c+AwO348SZ0f/f9rbiZ2xNuwE1nr+9Zs3KwSF2E+gsx/ASG/Bsd
         SjLwpFHbTPNhfyvhs0vcltEkVIjgJGh+VZIHe3fEkFuIKvuOymVqs7LXC/D9JjBwjGDd
         EoGA==
X-Gm-Message-State: AOAM530WTB2qnw4nNVns9w4VaMKBsDT/so6hrv1HIhMM5XEuIQIIFto/
        /pHe3ufqnuhmF96ry2Yu9fGs9iOBV7ZTpSJDTRrM
X-Google-Smtp-Source: ABdhPJx+2LyouZzRygCuLlWFWx4k+p6i/4U8LokURJQNA4v0tODWOZ8ObMJC5e5El+Q6xCskMviaUUvpTxEojhVhqlQ=
X-Received: by 2002:a17:906:cc8c:: with SMTP id oq12mr958706ejb.419.1610400774280;
 Mon, 11 Jan 2021 13:32:54 -0800 (PST)
MIME-Version: 1.0
References: <20210111081821.3041587-1-morbo@google.com> <20210111210418.GA3660906@ubuntu-m3-large-x86>
 <CAKwvOdnssY=CV4daRQvGa659AzGvMT+Kb10g5-DDuZjqbp-J5A@mail.gmail.com>
In-Reply-To: <CAKwvOdnssY=CV4daRQvGa659AzGvMT+Kb10g5-DDuZjqbp-J5A@mail.gmail.com>
From:   Bill Wendling <morbo@google.com>
Date:   Mon, 11 Jan 2021 13:32:43 -0800
Message-ID: <CAGG=3QVpxUpZJJYiy88YYk80-kvRPipnYdk9_9WzN=bToX9POA@mail.gmail.com>
Subject: Re: [PATCH] pgo: add clang's Profile Guided Optimization infrastructure
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 11, 2021 at 1:18 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Mon, Jan 11, 2021 at 1:04 PM Nathan Chancellor
> <natechancellor@gmail.com> wrote:
> >
> > On Mon, Jan 11, 2021 at 12:18:21AM -0800, Bill Wendling wrote:
> > > From: Sami Tolvanen <samitolvanen@google.com>
> > >
> > > Enable the use of clang's Profile-Guided Optimization[1]. To generate a
> > > profile, the kernel is instrumented with PGO counters, a representative
> > > workload is run, and the raw profile data is collected from
> > > /sys/kernel/debug/pgo/profraw.
> > >
> > > The raw profile data must be processed by clang's "llvm-profdata" tool before
> > > it can be used during recompilation:
> > >
> > >   $ cp /sys/kernel/debug/pgo/profraw vmlinux.profraw
> > >   $ llvm-profdata merge --output=vmlinux.profdata vmlinux.profraw
> > >
> > > Multiple raw profiles may be merged during this step.
> > >
> > > The data can be used either by the compiler if LTO isn't enabled:
> > >
> > >     ... -fprofile-use=vmlinux.profdata ...
> > >
> > > or by LLD if LTO is enabled:
> > >
> > >     ... -lto-cs-profile-file=vmlinux.profdata ...
> > >
> > > This initial submission is restricted to x86, as that's the platform we know
> > > works. This restriction can be lifted once other platforms have been verified
> > > to work with PGO.
> > >
> > > Note that this method of profiling the kernel is clang-native and isn't
> > > compatible with clang's gcov support in kernel/gcov.
> > >
> > > [1] https://clang.llvm.org/docs/UsersManual.html#profile-guided-optimization
> > >
> > > Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> > > Co-developed-by: Bill Wendling <morbo@google.com>
> > > Signed-off-by: Bill Wendling <morbo@google.com>
> >
> > I took this for a spin against x86_64_defconfig and ran into two issues:
> >
> > 1. https://github.com/ClangBuiltLinux/linux/issues/1252
>
> "Cannot split an edge from a CallBrInst"
> Looks like that should be fixed first, then we should gate this
> feature on clang-12.
>
Weird. I'll investigate.

> >
> >    There is also one in drivers/gpu/drm/i915/i915_query.c. For the time
> >    being, I added PGO_PROFILE_... := n for those two files.
> >
> > 2. After doing that, I run into an undefined function error with ld.lld.
> >
> > How I tested:
> >
> > $ make -skj"$(nproc)" LLVM=1 defconfig
> >
> > $ scripts/config -e PGO_CLANG
> >
> > $ make -skj"$(nproc)" LLVM=1 olddefconfig vmlinux all
> > ld.lld: error: undefined symbol: __llvm_profile_instrument_memop
>
> Err...that seems like it should be implemented in
> kernel/pgo/instrument.c in this patch in a v2?
>
Yes. I'll submit a new V2 with this and other feedback integrated.

> > >>> referenced by head64.c
> > >>>               arch/x86/kernel/head64.o:(__early_make_pgtable)
> > >>> referenced by head64.c
> > >>>               arch/x86/kernel/head64.o:(x86_64_start_kernel)
> > >>> referenced by head64.c
> > >>>               arch/x86/kernel/head64.o:(copy_bootdata)
> > >>> referenced 2259 more times
> >
> > Local diff:
> >
> > diff --git a/drivers/char/Makefile b/drivers/char/Makefile
> > index ffce287ef415..4b2f238770b5 100644
> > --- a/drivers/char/Makefile
> > +++ b/drivers/char/Makefile
> > @@ -4,6 +4,7 @@
> >  #
> >
> >  obj-y                          += mem.o random.o
> > +PGO_PROFILE_random.o           := n
> >  obj-$(CONFIG_TTY_PRINTK)       += ttyprintk.o
> >  obj-y                          += misc.o
> >  obj-$(CONFIG_ATARI_DSP56K)     += dsp56k.o
> > diff --git a/drivers/gpu/drm/i915/Makefile b/drivers/gpu/drm/i915/Makefile
> > index e5574e506a5c..d83cacc79b1a 100644
> > --- a/drivers/gpu/drm/i915/Makefile
> > +++ b/drivers/gpu/drm/i915/Makefile
> > @@ -168,6 +168,7 @@ i915-y += \
> >           i915_vma.o \
> >           intel_region_lmem.o \
> >           intel_wopcm.o
> > +PGO_PROFILE_i915_query.o := n
> >
> >  # general-purpose microcontroller (GuC) support
> >  i915-y += gt/uc/intel_uc.o \
>
> I'd rather have these both sorted out before landing with PGO disabled
> on these files.
>
Agreed.

-bw
