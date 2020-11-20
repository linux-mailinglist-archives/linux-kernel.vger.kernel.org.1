Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFA112BB803
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 22:00:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730466AbgKTU6z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 15:58:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728740AbgKTU6z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 15:58:55 -0500
Received: from mail-ua1-x942.google.com (mail-ua1-x942.google.com [IPv6:2607:f8b0:4864:20::942])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E29C7C061A04
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 12:58:53 -0800 (PST)
Received: by mail-ua1-x942.google.com with SMTP id q4so3568055ual.8
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 12:58:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JWd8Wn96hX4ViEXOk8cnBriUSzyNGlVdd9D7G7X9krM=;
        b=n7Q8WZSHAzqNmYrv9dNqZivuKsDeywwvO4kl1fLm8yAB9nz+k+3lzkHIC6URMndd9N
         ncfzYU53qrW6L7ktmuiCSCQkVZ/eP5JDWD7TMwJg8e5yVePPZIH2mL+P1inZGOs772ll
         a8QRES6vjPZ1qfhyKHcxA2SDzvnvBpk4g78r8aAZWi1llK+zb+YIfMZx34KzfOChRgPa
         6pg4ojnEfHCIbmevi1eG30tobfXlx2k6qexNCevPM6lVr7/QqpezqSu6yAgpxx7oPbC8
         wgUzxLS+Q8yRx5MTE+8rAH2p4+zi25RWg2L/DNevmi7STfpPOI63AYByOiSP7iPAbmY3
         vTAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JWd8Wn96hX4ViEXOk8cnBriUSzyNGlVdd9D7G7X9krM=;
        b=GDa4aw3W/Xo3zLjgxNSx8LatMTyAHmXuKGg1v4kPJfwfP8qNinIAtDc+CDIK+w2q3C
         hS1qE8d5nkQK9kkwN3wSoi8/isl5x6/R8NrPNXQmlOjjNEi9wZn7AgVg20/7rpp/A4AC
         nVS6RAwaeV0RScojggXNl/5q0YvFCmQKD7dao1w1Gqs3U73w15AgeI1e2NKfvZWyRRze
         QmA4MI24Notldb+PbZmhfKpYy59aoeg26Yw+68m5KE1a9hEKcgDHjT1mWVgYVClOjHW8
         cKPyqDB45ba/XOkTl8xuvVfik+0jYsV+fzimz8AxWgccE8PTkmsDaAwz3RngdbzMDtnh
         DtLw==
X-Gm-Message-State: AOAM5318A9rMpozir1psSVSKzF34+Nt0/7nCTqhurfpPW7m4yQfP2fgN
        Noo5iKzxGGFoVx1OGq7He1Ay72rCu6IorhbopmbXJg==
X-Google-Smtp-Source: ABdhPJwahvlnvpf0HHckrWnv4UpriDhIz+vSW2ABkfUPKok1Yyd5+VP5JP/VFRj6CCBwEc5NUFJu59Sg2jFzgZb6jlE=
X-Received: by 2002:ab0:23cc:: with SMTP id c12mr12322573uan.89.1605905932783;
 Fri, 20 Nov 2020 12:58:52 -0800 (PST)
MIME-Version: 1.0
References: <20201118220731.925424-1-samitolvanen@google.com>
 <20201118220731.925424-3-samitolvanen@google.com> <CAKwvOdnYTMzaahnBqdNYPz3KMdnkp=jZ4hxiqkTYzM5+BBdezA@mail.gmail.com>
 <CABCJKucj_jUwoiLc35R7qFe+cNKTWgT+gsCa5pPiY66+1--3Lg@mail.gmail.com>
 <202011201144.3F2BB70C@keescook> <20201120202935.GA1220359@ubuntu-m3-large-x86>
 <202011201241.B159562D7@keescook>
In-Reply-To: <202011201241.B159562D7@keescook>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Fri, 20 Nov 2020 12:58:41 -0800
Message-ID: <CABCJKucJ87wa73YJkN_dYUyE7foQT+12gdWJZw1PgZ_decFr4w@mail.gmail.com>
Subject: Re: [PATCH v7 02/17] kbuild: add support for Clang LTO
To:     Kees Cook <keescook@chromium.org>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Will Deacon <will@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 20, 2020 at 12:43 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Fri, Nov 20, 2020 at 01:29:35PM -0700, Nathan Chancellor wrote:
> > On Fri, Nov 20, 2020 at 11:47:21AM -0800, Kees Cook wrote:
> > > On Fri, Nov 20, 2020 at 08:23:11AM -0800, Sami Tolvanen wrote:
> > > > Changing the ThinLTO config to a choice and moving it after the main
> > > > LTO config sounds like a good idea to me. I'll see if I can change
> > > > this in v8. Thanks!
> > >
> > > Originally, I thought this might be a bit ugly once GCC LTO is added,
> > > but this could be just a choice like we're done for the stack
> > > initialization. Something like an "LTO" choice of NONE, CLANG_FULL,
> > > CLANG_THIN, and in the future GCC, etc.
> >
> > Having two separate choices might be a little bit cleaner though? One
> > for the compiler (LTO_CLANG versus LTO_GCC) and one for the type
> > (THINLTO versus FULLLTO). The type one could just have a "depends on
> > CC_IS_CLANG" to ensure it only showed up when needed.
>
> Right, that's how the stack init choice works. Kconfigs that aren't
> supported by the compiler won't be shown. I.e. after Sami's future
> patch, the only choice for GCC will be CONFIG_LTO_NONE. But building
> under Clang, it would offer CONFIG_LTO_NONE, CONFIG_LTO_CLANG_FULL,
> CONFIG_LTO_CLANG_THIN, or something.
>
> (and I assume  CONFIG_LTO would be def_bool y, depends on !LTO_NONE)

I'm fine with adding ThinLTO as another option to the LTO choice, but
it would duplicate the dependencies and a lot of the help text. I
suppose we could add another config for the dependencies and have both
LTO options depend on that instead.

Sami
