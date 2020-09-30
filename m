Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B25F27F4FE
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 00:21:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730823AbgI3WVI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 18:21:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730128AbgI3WVI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 18:21:08 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30337C0613D0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 15:21:08 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id q123so2389955pfb.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 15:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ePM6QfsM36THSeKgqnpoCi7o8XR/cpqwQC0wJXmRkfY=;
        b=O7yCy3sg2m1IQak/jqM5ElfuEFBSebnZ0Bcxx3YfqFLFbXpjx8fjPVJtb32iBU1DMk
         efTCBen+IiSf5+xH87v9hYdL/9eFlKgt5hLUknMcrmQ3WmWVDGd/eMwWGs3tRjz96Cwm
         1PVDfSwe4Z+93lUhZuzDUj8USpTO0cl48jPEotAzJsMOmb6DjnsUV8CJf9DF8IOco64S
         mdqKoG3iwTjkq4U4BLp32R4IFqArDFHS7PJwaF3gDY9GOVvzoRYQpQp1KQvm3x4b9ILP
         qFRADnVVWfmUIdbuKBalKuI/M46FvDRdH1TlnYhNSDYXXeHT3TUJmRBfSDHdEi2SY3Nk
         ZTYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ePM6QfsM36THSeKgqnpoCi7o8XR/cpqwQC0wJXmRkfY=;
        b=tU7Z92T5LHi8xhFZgxFk4ho3HNAxjKYpkN/8oydp2Q66pPYkZ6weOOzRsRElikjRFj
         6tZB138bUaySpXub4qpgtnK7TBaq3zGjIl3SVNOfzB6YBMX0g5H4tXdZkY324WPmRScW
         2SLUyx1zw/hUxXGFIbC9koDavAHpR6Dg+mUcqh1/AonPpwxcBL4KVLU3qpM2IH7ger8d
         WR9HQUeXt8b9nCf19vegLT4osDrgxboi6eKo63zkDaHLl3txRq0EKWmRnwWkRe12Fqqm
         o2ROlDmHOzjPydYj0ozKRX71GB1iG/XmFNIGv/b4DVztzEkWViV4F9uEV+lBWiQ8pZwV
         6LWQ==
X-Gm-Message-State: AOAM5333NFXjbglizNqnoWy2TmuI5Ihu9N73a2QXXVZ6NCGB2+S53/jZ
        el1tyfV7jFO/pgUkazGM68sjXuDzTaY8DGeDuWIfkA==
X-Google-Smtp-Source: ABdhPJzA4bkQAHDdH3W4GUXc99blOZtPvkxFiG6hiPFdxAK1bSv1wcCC+kM/ALC53ayuhYyO+ekBT1KSXiMRjwXUsps=
X-Received: by 2002:a62:5586:0:b029:13e:d13d:a108 with SMTP id
 j128-20020a6255860000b029013ed13da108mr4232171pfb.36.1601504467381; Wed, 30
 Sep 2020 15:21:07 -0700 (PDT)
MIME-Version: 1.0
References: <CAKwvOd=s+N4+X94sTams_hKn8uV5Hc6QyCc7OHyOGC-JFesS8A@mail.gmail.com>
 <20200929192549.501516-1-ndesaulniers@google.com> <CA+icZUVgfnVQ1=zjUGhGKnJAs9g3Q06sWN3ffNdrfZMZLCEkbA@mail.gmail.com>
 <133589afbe999347454dfcc46ae782897bf9e3a2.camel@perches.com>
 <46f69161e60b802488ba8c8f3f8bbf922aa3b49b.camel@perches.com>
 <CAKwvOdkhyvTpY6pHT+CLSsBFuKRWsXucjbwN_tyJAsryZXvG1A@mail.gmail.com> <417ffa3fd3fba5d4a481db6a0b0c9b48cbbb17c4.camel@perches.com>
In-Reply-To: <417ffa3fd3fba5d4a481db6a0b0c9b48cbbb17c4.camel@perches.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 30 Sep 2020 15:20:55 -0700
Message-ID: <CAKwvOd=P+j0RaQfHsXPfB0EL3oRgAu8Q0+spUOn_v-p2+3=3pw@mail.gmail.com>
Subject: Re: [RFC PATCH next-20200930] treewide: Convert macro and uses of
 __section(foo) to __section("foo")
To:     Joe Perches <joe@perches.com>
Cc:     Sedat Dilek <sedat.dilek@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>, rcu@vger.kernel.org,
        Clang-Built-Linux ML <clang-built-linux@googlegroups.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 30, 2020 at 3:06 PM Joe Perches <joe@perches.com> wrote:
>
> On Wed, 2020-09-30 at 14:40 -0700, Nick Desaulniers wrote:
> > On Wed, Sep 30, 2020 at 12:16 PM Joe Perches <joe@perches.com> wrote:
> > > Use a more generic form for __section that requires quotes to avoid
> > > complications with clang and gcc differences.
> > >
> > > Remove the quote operator # from compiler_attributes.h __section macro.
> > >
> > > Convert all unquoted __section(foo) uses to quoted __section("foo").
> > > Also convert __attribute__((section("foo"))) uses to __section("foo")
> > > even if the __attribute__ has multiple list entry forms.
> > >
> > > Signed-off-by: Joe Perches <joe@perches.com>
> > > ---
> > >
> > > This is the current output from the script against next-20200930
> > > attached in this link:
> > >
> > > https://lore.kernel.org/lkml/0e582a7f5144a33f465978d97701f9b3dcc377f3.camel@perches.com/
> > >
> > > It might be useful to run the script immediately before
> > > the next -rc1.
> >
> > $ ARCH=powerpc CROSS_COMPILE=powerpc64le-linux-gnu- make CC=clang -j71
> > powernv_defconfig
> > $ ARCH=powerpc CROSS_COMPILE=powerpc64le-linux-gnu- make CC=clang -j71
> > ...
> > arch/powerpc/boot/main.c:193:44: error: expected ';' after top level declarator
> > static char cmdline[BOOT_COMMAND_LINE_SIZE]
>
> The script does not convert files in
>
>         scripts/
>         tools/
>         uapi/
>         and include/linux/compiler_attributes.h
>
> It otherwise assumes that any __attribute__((__section__
> use should be converted to __section.
>
> If this ppc file is the only file outside of the
> listed exclusions, I can either exclude it directly
> or add compiler.h to it.
>
> You have a preference?

If compiler_types.h which includes compiler_attributes.h is being
implicitly including by Kbuild add `-include` flags to most
translation units in the kernel, it would be nice to be able to use it
everywhere.  I consider open coded __attribute__'s a portability bug.
So including the header in arch/powerpc/boot/*.c would be my
preference.

>
> Perhaps these are also possible files that need exclusions:
>
> ./arch/x86/boot/video.h:#define __videocard struct card_info __section(".videocards") __attribute__((used))
> ./arch/x86/boot/compressed/pgtable_64.c:unsigned long *trampoline_32bit __section(".data");
> ./arch/x86/boot/tty.c:static void __section(".inittext") serial_putchar(int ch)
> ./arch/x86/boot/tty.c:static void __section(".inittext") bios_putchar(int ch)
> ./arch/x86/boot/tty.c:void __section(".inittext") putchar(int ch)
> ./arch/x86/boot/tty.c:void __section(".inittext") puts(const char *str)
> ./arch/s390/boot/startup.c:static struct diag210 _diag210_tmp_dma __section(".dma.data");
> ./arch/powerpc/boot/main.c:     __section("__builtin_cmdline");
> ./arch/powerpc/boot/ps3.c:      __section("__builtin_cmdline");
>
>


-- 
Thanks,
~Nick Desaulniers
