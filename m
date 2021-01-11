Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B04B02F20AB
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 21:24:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404211AbhAKUYE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 15:24:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390366AbhAKUYB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 15:24:01 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E0D1C061794
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 12:23:21 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id qw4so162293ejb.12
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 12:23:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bztGlj0aKk1h/1eIfyJjVJW7vahRd8KxmYcTiDCcm3U=;
        b=SQFbpF1X4gjqkNoz6KSst5u0RFk2UjYwj0lYYHBRSDBA+uUDlzbZ4jfbJLM1w4zPXr
         llmGtJAmxqx8cRU1RsXlyuqDnNTdzX8TkMiRG6Mz3ENqTNdvotNB5Ue44LALDuoi+qBm
         mSYvaLvBh+249E4073uXJTxkKVYxGdZ5mQWKSYV/p8NfaOM9o5iK7Us8fGPZ3Ulh4jmB
         Ke0PnahKwsVGmEhfzFWFFl8XHa/rTibjbKicJOk8+StKitixnjgJvPFC8DRRDJ0p5Pko
         orT2xNwwqJlp0xNTFwgdM7A8fg9h9w/NVHLywbtbcOuTdjD1nJ3czTeFp5OlBarfLKKG
         CdCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bztGlj0aKk1h/1eIfyJjVJW7vahRd8KxmYcTiDCcm3U=;
        b=edsEQLepQtL9CO0B80l0qL6LoBqkWZWz0hjnnQMg1IVM9JjK9jl1bWkWGlmqpvU1wh
         YDKpIchEJ07xd9f8Tuxtg1h9pBjdjMmEWq2QpKF7gxq74BY/JyL6R9GXj2GjRRxH5ozh
         1kp5ScdzfGdg9Lg/kfeRZtznI4exNHEeFNAMY1rLrkMCkDwb69mmhgQH04KXQXdhksV9
         2JxTSPUpckDEhR6PPfYibdqvWtZUkXdiiaKB/U8R/rybeXRhvKWRawP6+j/aYXazyqU9
         XLMLdWnhftNEw7PYk9KkrmGaRvvlderA7x7ZV+zPTZ73FqgRC2TU1JTWYdJ1dHDqKKTd
         iDNw==
X-Gm-Message-State: AOAM5306HTO/GkLTQiBs+WCHVRo0HjLgfXqWrBJwdVJdVI7tGxw2fkMY
        0vm4bfiqIg9Qe4imcpovPwvr3GulXknhTcoFH5Mg
X-Google-Smtp-Source: ABdhPJyss7irrpvrcZKKEGeiutRfKqSI+AnHG3Lnd3FnhacwysvNmvK1KutY85D6zkc62M+ly/fB0OrNHC7Etz3+Fhc=
X-Received: by 2002:a17:906:b002:: with SMTP id v2mr784732ejy.531.1610396599813;
 Mon, 11 Jan 2021 12:23:19 -0800 (PST)
MIME-Version: 1.0
References: <20210111081821.3041587-1-morbo@google.com> <20210111201224.l5r2zxuyd7ayszke@google.com>
In-Reply-To: <20210111201224.l5r2zxuyd7ayszke@google.com>
From:   Bill Wendling <morbo@google.com>
Date:   Mon, 11 Jan 2021 12:23:08 -0800
Message-ID: <CAGG=3QWo5_wwTMHtif4BzFssByaW1ScvpaEH1p1nZ6ymVggLjA@mail.gmail.com>
Subject: Re: [PATCH] pgo: add clang's Profile Guided Optimization infrastructure
To:     Fangrui Song <maskray@google.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 11, 2021 at 12:12 PM Fangrui Song <maskray@google.com> wrote:
>
> On 2021-01-11, 'Bill Wendling' via Clang Built Linux wrote:
> >From: Sami Tolvanen <samitolvanen@google.com>
> >
> >Enable the use of clang's Profile-Guided Optimization[1]. To generate a
> >profile, the kernel is instrumented with PGO counters, a representative
> >workload is run, and the raw profile data is collected from
> >/sys/kernel/debug/pgo/profraw.
> >
> >The raw profile data must be processed by clang's "llvm-profdata" tool before
> >it can be used during recompilation:
> >
> >  $ cp /sys/kernel/debug/pgo/profraw vmlinux.profraw
> >  $ llvm-profdata merge --output=vmlinux.profdata vmlinux.profraw
> >
> >Multiple raw profiles may be merged during this step.
> >
> >The data can be used either by the compiler if LTO isn't enabled:
> >
> >    ... -fprofile-use=vmlinux.profdata ...
> >
> >or by LLD if LTO is enabled:
> >
> >    ... -lto-cs-profile-file=vmlinux.profdata ...
>
> This LLD option does not exist.
> LLD does have some `--lto-*` options but the `-lto-*` form is not supported
> (it clashes with -l) https://reviews.llvm.org/D79371
>
That's strange. I've been using that option for years now. :-) Is this
a recent change?

> (There is an earlier -fprofile-instr-generate which does
> instrumentation in Clang, but the option does not have broad usage.
> It is used more for code coverage, not for optimization.
> Noticeably, it does not even implement the Kirchhoff's current law
> optimization)
>
Right. I've been told outside of this email that -fprofile-generate is
the prefered flag to use.

> -fprofile-use= is used by both regular PGO and context-sensitive PGO (CSPGO).
>
> clang -flto=thin -fprofile-use= passes -plugin-opt=cs-profile-path= to the linker.
> For regular PGO, this option is effectively a no-op (confirmed with CSPGO main developer).
>
> So I think the "or by LLD if LTO is enabled:" part should be removed.

But what if you specify the linking step explicitly? Linux doesn't
call "clang" when linking, but "ld.lld".

-bw
