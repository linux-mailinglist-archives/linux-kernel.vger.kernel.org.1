Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C52D2F0EEE
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 10:21:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728211AbhAKJS2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 04:18:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727839AbhAKJS1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 04:18:27 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3C6FC061794
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 01:17:46 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id cm17so18026438edb.4
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 01:17:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LaTp5Y5Nk9Ij1O9UX9G8J8yj5l061X+cBmCeyjMzuRA=;
        b=PU6XsOP4CHf5LtAxQ7g3G3LuSBk+T0UA4WDm78IqIFTfQfKIEfqgNWPD2e/A+1suzV
         eiPMsgXjID9Au+GtD6H1EJuTCzVEDd1j4LTCMXtv1ffvplMvFL2Xk/eb1CnYJ5dGJmNL
         UtZTilH1FjNk5Kq9pvgV0J+PlHannYyo5BLdGLu2cLgx95oH4YM9Xg9HjRYWLk2ldEaH
         5+YRqNWniOx9ZwxDv4UU97JcWjZzA+pNIBqcbWLzxrLtUc69BEiO6PwxRbBJvJrsFqbK
         1WHEEbzky03S86d6v+RFmEqDZaRAspY+D9vrVYHC9WOeis/7LRU21haoSX7+n4u263MW
         X33g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LaTp5Y5Nk9Ij1O9UX9G8J8yj5l061X+cBmCeyjMzuRA=;
        b=OPDr7JK7YgVbAYORCNK+7D4A2Qah1w5VBLQtfyN1jhnJi/lC7ZA+bZdHIKK9roIp/a
         YZ02uRCHHurWFqqwZ9mDLIKu00VAbBnoeDy2ntBHDiK71wfC3k5pcHOEtmfZqz//TVD7
         o3QILQNX0UNFwAciTBlhWmSQyVsnHoyO2nF1eGR59Ejt4j7hp9BNMaWlbE0UdHMksach
         lKZ2HZ2rzxkqeJliNeZUmySt2hOtqPbq6+zIhNmz5aQvGw9sQbQYK2KNObLNBN7cXmx/
         YXsYZZVefaoMq7s44GffexDR10Ko8wS+MXrdKXoUBWwU52kfAGpjaZzjCCqOj9z3DxUf
         8Wiw==
X-Gm-Message-State: AOAM533UIdcr+V45ixpJejfcMerNpC/E5jkoRkX6gSO8ptTElZ+3rv4r
        3o1QWyeOWKThedpVMw7zNmRLZ4cd8BEpNteuZxlS
X-Google-Smtp-Source: ABdhPJwu4WWPzJvauBgwvH9pXvz7ot5kdqV6CGu1DbAAUcqkkL1pIHhUPUc4xiN2VB4I5oZGx96PyarzTMzq4J5tEvY=
X-Received: by 2002:a50:a694:: with SMTP id e20mr13412711edc.261.1610356665096;
 Mon, 11 Jan 2021 01:17:45 -0800 (PST)
MIME-Version: 1.0
References: <20210111081821.3041587-1-morbo@google.com> <CA+icZUUUTEdRNbmORy4X=UqMHLMEfD186o2mh23v_mXGBM8Anw@mail.gmail.com>
In-Reply-To: <CA+icZUUUTEdRNbmORy4X=UqMHLMEfD186o2mh23v_mXGBM8Anw@mail.gmail.com>
From:   Bill Wendling <morbo@google.com>
Date:   Mon, 11 Jan 2021 01:17:33 -0800
Message-ID: <CAGG=3QUHWkuF0Q-=tNO5PztqtxuKYgyQy_EbBLyL0xNQ7TjgoQ@mail.gmail.com>
Subject: Re: [PATCH] pgo: add clang's Profile Guided Optimization infrastructure
To:     Sedat Dilek <sedat.dilek@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Clang-Built-Linux ML <clang-built-linux@googlegroups.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 11, 2021 at 12:39 AM Sedat Dilek <sedat.dilek@gmail.com> wrote:
>
> On Mon, Jan 11, 2021 at 9:18 AM 'Bill Wendling' via Clang Built Linux
> <clang-built-linux@googlegroups.com> wrote:
> >
> > From: Sami Tolvanen <samitolvanen@google.com>
> >
> > Enable the use of clang's Profile-Guided Optimization[1]. To generate a
> > profile, the kernel is instrumented with PGO counters, a representative
> > workload is run, and the raw profile data is collected from
> > /sys/kernel/debug/pgo/profraw.
> >
> > The raw profile data must be processed by clang's "llvm-profdata" tool before
> > it can be used during recompilation:
> >
> >   $ cp /sys/kernel/debug/pgo/profraw vmlinux.profraw
> >   $ llvm-profdata merge --output=vmlinux.profdata vmlinux.profraw
> >
> > Multiple raw profiles may be merged during this step.
> >
> > The data can be used either by the compiler if LTO isn't enabled:
> >
> >     ... -fprofile-use=vmlinux.profdata ...
> >
> > or by LLD if LTO is enabled:
> >
> >     ... -lto-cs-profile-file=vmlinux.profdata ...
> >
> > This initial submission is restricted to x86, as that's the platform we know
> > works. This restriction can be lifted once other platforms have been verified
> > to work with PGO.
> >
> > Note that this method of profiling the kernel is clang-native and isn't
> > compatible with clang's gcov support in kernel/gcov.
> >
> > [1] https://clang.llvm.org/docs/UsersManual.html#profile-guided-optimization
> >
>
> Hi Bill and Sami,
>
> I have seen the pull-request in the CBL issue tracker and had some
> questions in mind.
>
> Good you send this.
>
> First of all, I like to fetch any development stuff easily from a Git
> repository.

The version in the pull-request in the CBL issue tracker is roughly
the same as this patch. (There are some changes, but they aren't
functionality changes.)

> Can you offer this, please?
> What is the base for your work?
> I hope this is (fresh released) Linux v5.11-rc3.
>
This patch (and the PR on the CBL issue tracker) are from top-of-tree Linux.

> I myself had some experiences with a PGO + ThinLTO optimized LLVM
> toolchain built with the help of tc-build.
> Here it takes very long to build it.
>
> This means I have some profile-data archived.
> Can I use it?
>
LLVM is more tolerant of "stale" profile data than gcov, so it's
possible that your archived profile data would still work, but I can't
guarantee that it will be better than using new profile data.

> Is an own PGO + ThinLTO optimized LLVM toolchain pre-requirement for
> this or not?
> That is one of my important questions.
>
Do you mean that the LLVM tools (clang, llc, etc.) are compiled with
PGO + ThinLTO?

-bw
