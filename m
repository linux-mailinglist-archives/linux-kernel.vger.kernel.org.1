Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87AD7251335
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Aug 2020 09:31:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729439AbgHYHbd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Aug 2020 03:31:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729194AbgHYHbc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 03:31:32 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0874EC061574
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 00:31:30 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id l191so4111386pgd.5
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 00:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m7ch7awO6dQw6oGepnCr0LIwMq/ocai7485X8Nfpk3A=;
        b=sjOzCSRVvG1BQ9lfblTNWFud2sOL4Z8FoPVLLR2PV/do9wx1dr4Z4Y689ZhRA/v0rY
         q7pmrtRQPDdQoYCsmHvS4g5iPRU+uFKFKsau302IkCsImMeSerTUn6CxGksc6llIvewO
         oKXxq3B5dvx40WPTaY7rdYOrfM6QQUFjKMDdcfMbBmseNYJbYc3D8RL00BGtau8VFU7J
         Vx8KeOuhxOkA7KmNU+W4EpZOZvzXprk9Pku2b0eAOFKHBSi7dN+reeBtCqdu8VKo09iN
         Cyu6nNg7qs5GoBPqsXrpDun8rD+8Q7rSGKEq6jLFtLAtumZ4VyxrpKjmSzkkG345bhCk
         TDsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m7ch7awO6dQw6oGepnCr0LIwMq/ocai7485X8Nfpk3A=;
        b=tK4eQxhrt/lm+hQgRbXkJkGa0qw1OXQpiF9tJ0LUVhwlpd7qsNsfcolztRQyvIt/yb
         8+0Zlgy7ozcAR5xPv14bqiV9JR/sPI8VvwA7jfHn6UYWe7EEXhucg3i84qWR+EwdY+Xj
         NQ/drq+qIN9uZJX0RNVPHM/4SKEgS7zZHwbaSBuoSubNr1PCJAI2XNAgwWEOGP2aA/LJ
         iTRxu7dMoVCtNG9d2gYlvVoCp3w4brzwr/YGunzWn4d4M6eHxy/jxNGUByZ1ALRBFgS8
         VFDudWMn4P+mLRLGUmXP5UAJjmYUXS6Y7gFHOPmQGIv3uzxLvYbe/gGrK+JZQyNJVlTj
         MZ+Q==
X-Gm-Message-State: AOAM532oHJfXknjdTNGmj5a5RRvAwDprNfn+9CK5OgAgsr9+Wo+ypp83
        10rg2L/WbOa2+CcUELsmXH0qV97LD0ChuEupuyJGgA==
X-Google-Smtp-Source: ABdhPJwe6jM7HG16VFQngcUGbRQn3BsibeeAW1tnRrBzba3m+D9Bx6IoJfIhWy3w05MZeYYI3/zkzvt4t6UXOd3rZI4=
X-Received: by 2002:a62:7845:: with SMTP id t66mr6315514pfc.238.1598340690018;
 Tue, 25 Aug 2020 00:31:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200817220212.338670-1-ndesaulniers@google.com>
 <fae91af3-4e08-a929-e5c3-25271ad7324b@zytor.com> <CAKwvOdk6A4AqTtOsD34WNwxRjyTvXP8KCNj2xfNWYdPT+sLHwQ@mail.gmail.com>
 <76071c24-ec6f-7f7a-4172-082bd574d581@zytor.com> <CAHk-=wiPeRQU_5JXCN0TLoW-xHZHp7dmrhx0wyXUSKxiCxE02Q@mail.gmail.com>
 <20200818202407.GA3143683@rani.riverdale.lan> <CAKwvOdnfh9nWwu1xV=WDbETGiabwDxXxQDRCAfpa-+kSZijb9w@mail.gmail.com>
 <CAKwvOdkA4SC==vGZ4e7xqFG3Zo=fnhU=FgnSazmWkkVWhkaSYw@mail.gmail.com>
 <20200818214146.GA3196105@rani.riverdale.lan> <CAK7LNAQmWBPV4nZ0xPdSHEt=DipHmR40co827voGOFN=2j47BQ@mail.gmail.com>
 <20200824173450.GA4157679@rani.riverdale.lan> <CAKwvOd=BEwuHFeuskJ4gPOGLoXm98oXA18U=tTw981g+HdVz-w@mail.gmail.com>
In-Reply-To: <CAKwvOd=BEwuHFeuskJ4gPOGLoXm98oXA18U=tTw981g+HdVz-w@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 25 Aug 2020 00:31:18 -0700
Message-ID: <CAKwvOdmRz6d9touuZnotpF3vs0m5M9MbbKX8M_XmTCZ+8Fe6-A@mail.gmail.com>
Subject: Re: [PATCH 0/4] -ffreestanding/-fno-builtin-* patches
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     =?UTF-8?B?RMOhdmlkIEJvbHZhbnNrw70=?= <david.bolvansky@gmail.com>,
        Eli Friedman <efriedma@quicinc.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Tony Luck <tony.luck@intel.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Joe Perches <joe@perches.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Daniel Axtens <dja@axtens.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Yury Norov <yury.norov@gmail.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Daniel Kiper <daniel.kiper@oracle.com>,
        Bruce Ashfield <bruce.ashfield@gmail.com>,
        Marco Elver <elver@google.com>,
        Vamshi K Sthambamkadi <vamshi.k.sthambamkadi@gmail.com>,
        Arvind Sankar <nivedita@alum.mit.edu>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 25, 2020 at 12:10 AM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Mon, Aug 24, 2020 at 10:34 AM Arvind Sankar <nivedita@alum.mit.edu> wrote:
> >
> > On Tue, Aug 25, 2020 at 12:57:22AM +0900, Masahiro Yamada wrote:
> > >
> > >
> > > To prevent transformation from foo() into bar(),
> > > there are two ways in Clang to do that;
> > > -fno-builtin-foo, and -fno-builtin-bar.
> > > There is only one in GCC; -fno-buitin-foo.
> > >
> > > Is this correct?
> > >
> >
> > It looked that way from previous experimentation, but...
> >
> > >
> > >
> > > I just played the optimization
> > > from printf("helloworld\n") to puts("helloworld").
> > >
> > > https://godbolt.org/z/5s4ded
> > >
> > >
> > > -fno-builtin-puts cannot prevent clang
> > > from emitting puts.
> > > Is it because clang does not support
> > > -fno-builtin-puts?
> >
> > Ugh. clang doesn't have __builtin_puts() but it optimizes printf() into
> > puts(). It doesn't have __builtin_putchar() but will optimize
> > printf("c") into putchar('c').
>
> Bah, merely a <strikethrough>flesh
> wound</strikethrough><strikethrough>compiler bug</strikethrough>rather
> long TODO in the compiler.
> https://github.com/llvm/llvm-project/blob/be2bc7d4cef2edd66c7fb74b70adf62fc68754db/clang/include/clang/Basic/Builtins.def#L943
>
> Anyways, give me a week and I'll hack through the rest of them
> https://reviews.llvm.org/D86508.  Certainly made HPA's point hit home,
> that's a lot of functionality to implement or disable in an
> environment.
>
> Masahiro, are you implying that we shouldn't take the
> -fno-builtin-stpcpy patch, because Clang is inconsistent? (That can be
> fixed.) Even though -fno-builtin-stpcpy works here as intended?
> https://lore.kernel.org/lkml/20200817220212.338670-2-ndesaulniers@google.com/

Sorry, the above link ^ should be this hunk (beyond tired, getting up
in 4.5hrs for plumbers):

diff --git a/Makefile b/Makefile
index c4470a4e131f..6a08cdfa58ae 100644
--- a/Makefile
+++ b/Makefile
@@ -577,6 +577,7 @@ ifneq ($(LLVM_IAS),1)
 CLANG_FLAGS    += -no-integrated-as
 endif
 CLANG_FLAGS    += -Werror=unknown-warning-option
+CLANG_FLAGS    += -fno-builtin-stpcpy
 KBUILD_CFLAGS  += $(CLANG_FLAGS)
 KBUILD_AFLAGS  += $(CLANG_FLAGS)
 export CLANG_FLAGS

>
> Otherwise we need to provide an implementation of this symbol in the kernel.
> https://lore.kernel.org/lkml/20200815020946.1538085-1-ndesaulniers@google.com/
>
> Please, pick your poison.
> --
> Thanks,
> ~Nick Desaulniers



-- 
Thanks,
~Nick Desaulniers
