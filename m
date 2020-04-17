Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 053921ADF98
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Apr 2020 16:15:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730926AbgDQONm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Apr 2020 10:13:42 -0400
Received: from conssluserg-04.nifty.com ([210.131.2.83]:19476 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730662AbgDQONl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 10:13:41 -0400
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id 03HEDDdj011312
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 23:13:13 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com 03HEDDdj011312
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1587132794;
        bh=soczHQygZ5e4Z4/uBgr0PVGiMli0DNK+wn9N64tR5qU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=vXuRLTovDrQmMb0Jz37P9s2LBa6Jb1e/OUiRedx63I0IFnBEDdaseDJmrt8I6+yNf
         YwxQQopMU2clgNfcN5XYa5Pdao15glEfClHbc9nH43HSs1Julc8SjX09ZfxxNGgNZ1
         L2y3yIwwSDwMFX+ug9VhWRfr7yo4w7BJoeadMqw4WrhuM6BzVqXadkqpeahMtW4mME
         iRKHSf/7aXQtWqNWcjEqbNd1y2k7an7fr66xZ6JGbirh4am9JHd6+siWU3PaImO0sO
         Eg2kf5oJczJgxOoSYG0X5oXG3RdLGssN/7QKmvFhvYf2WvL7C7tM5MDUBnGKcAH8mv
         pI488dLZ0hQJw==
X-Nifty-SrcIP: [209.85.222.49]
Received: by mail-ua1-f49.google.com with SMTP id d23so697685uak.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 07:13:13 -0700 (PDT)
X-Gm-Message-State: AGi0PuYWEon7qV7RHgPQep7lJf1IHCZMi5+pQjDaUpvRU5kOgimatoYR
        ljljC9d1saITiqRRqwIi2N7cy8KtMlRGY3vmq+E=
X-Google-Smtp-Source: APiQypKhiuo80RsLEisith0XyQOFUV3PzTzMi+mrapjPQLCKwWkCyn51WYWMMdjYPdS/P6p4Vjn2U9i/In6A9eNfdOo=
X-Received: by 2002:ab0:20d6:: with SMTP id z22mr2640996ual.121.1587132792213;
 Fri, 17 Apr 2020 07:13:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200409232728.231527-1-caij2003@gmail.com> <CAK8P3a3uj7AHbAo4sNzr6KQx5Fk6v99k4ZixCgKo1tUuGoat9Q@mail.gmail.com>
 <CAMj1kXGXNxXGiC4dmNXHkZ6n=J0Fhim3oSwNx4Bz5m9fEphJvQ@mail.gmail.com>
 <20200410123301.GX25745@shell.armlinux.org.uk> <CAMj1kXFpknCfwb6JMdk_SHopnGqMswgSqaQUeAUEh5yaV10vJg@mail.gmail.com>
 <CAKwvOdk-xwuppJzxd1+5sfsC8jYiP3t8D=aTNaYxnFCRDiEUmQ@mail.gmail.com>
 <CAMj1kXFHb8th0rv1yjrsr=c1o-g9_ERPUy4itnrVN13fcQcXag@mail.gmail.com>
 <CAKwvOdm5aawsa2-=atB8z6W8zo8YVgdDEVbU3i4evDcpo1_AxQ@mail.gmail.com>
 <202004141258.6D9CB92507@keescook> <CAMj1kXG6_CO6pzeJCSeWiCDyLfWw+ZMuvkv_DLxe-si00fLd1Q@mail.gmail.com>
 <202004150833.E2E9A89E0@keescook>
In-Reply-To: <202004150833.E2E9A89E0@keescook>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Fri, 17 Apr 2020 23:12:35 +0900
X-Gmail-Original-Message-ID: <CAK7LNAS-juF8dpeSVCuYQPwJ5HSQypFqOvesGFQR4bzTf23nUg@mail.gmail.com>
Message-ID: <CAK7LNAS-juF8dpeSVCuYQPwJ5HSQypFqOvesGFQR4bzTf23nUg@mail.gmail.com>
Subject: Re: [PATCH] ARM: do not assemble iwmmxt.S with LLVM toolchain
To:     Kees Cook <keescook@chromium.org>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kristof Beyls <Kristof.Beyls@arm.com>,
        Stephen Hines <srhines@google.com>,
        Luis Lozano <llozano@google.com>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>, Jian Cai <caij2003@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Peter Smith <Peter.Smith@arm.com>,
        Stefan Agner <stefan@agner.ch>,
        David Howells <dhowells@redhat.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Manoj Gupta <manojgupta@google.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Ilie Halip <ilie.halip@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Jian Cai <jiancai@google.com>,
        Doug Anderson <armlinux@m.disordat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tejun Heo <tj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On Thu, Apr 16, 2020 at 12:44 AM Kees Cook <keescook@chromium.org> wrote:
>
> On Wed, Apr 15, 2020 at 12:32:17PM +0200, Ard Biesheuvel wrote:
> > To reiterate my point: I strongly prefer minor asm surgery over
> > elaborate Kconfig plumbing if it means we can retain the functionality
> > even when using LLVM tools. In particular, the use of macros to
> > implement missing ISA support should be considered before any other
> > solution, as these are already being used widely across architectures
> > to fill in such gaps.
>
> Yeah, this seems like the right place to start from. It sounded like
> there were cases where the people with knowledge needed to accomplish
> the macro creation were not always immediately available. But, yes,
> let's get iwmmxt fixed up.
>
> > This code has been around since 2004. It has never been possible to
> > assemble it with Clang's assembler. So the only thing this patch gives
> > you is the ability to switch from a .config where IWMMXT was disabled
> > by hand to one where it gets disabled automatically by Kconfig.
>
> Right -- I meant "let's fix iwmmxt with macro magic" not "let's disable
> it". I did want to point out the Kconfig disabling may be needed in
> other cases.
>
> > So what hard-won ground are we losing here? Did IWMMXT recently get
> > enabled in a defconfig that you care about?
>
> It's a CI's ability to do randconfig builds to catch new stuff. (i.e.
> where "disabled by hand" isn't part of the process.) Since there are
> multiple CIs doing multi-architecture builds we need to get these things
> fixed upstream, not a CI's local patch stacks or Kconfig whitelists,
> etc. And when the expertise isn't available to fix arch-specific stuff,
> Kconfig negative depends seems like a reasonable middle ground. I, too,
> prefer fixes that allow Clang to do its work without wrecking things
> for GNU as.
>
> > I am not disagreeing with you here, and I have worked with Nick,
> > Nathan and Stefan on numerous occasions to get Clang related build
> > issues solved.
>
> Yup! Totally; this thread just looked very familiar to me from doing
> treewide stuff and I didn't want what I thought looked like the core
> points to get lost in the details. :)
>
> --
> Kees Cook



When I started to read this thread,
I just slightly preferred
    depends on $(as-instr, <some iwmmxt instructions>)
over
    depends on AS_IS_CLANG

because it is what we recently did for x86.
commit 5e8ebd841a44b895e2bab5e874ff7d333ca31135


But, Ard's macro approach seems even better.


I do not know how difficult to replace
the arch/x86/Kconfig.assembler with .macro

Anyway, arch/x86/Kconfig.assembler will be gone
when we raise the binutils version next time.


-- 
Best Regards
Masahiro Yamada
