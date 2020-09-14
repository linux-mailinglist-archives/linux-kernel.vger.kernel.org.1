Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F333269883
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 00:02:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726086AbgINWCy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 18:02:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:47470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725986AbgINWCu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 18:02:50 -0400
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 988FE208DB
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 22:02:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600120969;
        bh=XAslvacbUzC0jcklVTRhtBa27JtLd3Yu9RjUUQFAxeY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=F3PGCqglopVCcoPAybBIzOObvzSuUo3fXsVZJZuVqyXBqFhWfWhrQ5eySmqOe7Dla
         IaLVHXb5xfoOsV+aHHCHI4frpWVNd+aOUoL6eAjkiqt3jV7nl9p/EEocNYEg/64aTJ
         gDZ++0b4UuhHLSEWeIvx3VpmPFBa5MWsxwnNuJaU=
Received: by mail-wm1-f53.google.com with SMTP id e11so9756026wme.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 15:02:49 -0700 (PDT)
X-Gm-Message-State: AOAM531+VLM5xbaw9AFiGf76vNht+8WYq0OglFcUaGgG4CLbjmJhX5uc
        m8MSszFeEp62WdFHCDvWS05ZGywCitzFcO6+y0x3mQ==
X-Google-Smtp-Source: ABdhPJw9ZC8Je3Hl6su4UpojUc1cqIUj4V18PSSHgyji/jgmcyT7OdlDU3S7jDGL0FCmMVTp5rn1YCK4G94RPgBAceA=
X-Received: by 2002:a05:600c:4104:: with SMTP id j4mr1361681wmi.36.1600120968132;
 Mon, 14 Sep 2020 15:02:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200903011054.2282115-1-morbo@google.com> <20200903073435.GU1362448@hirez.programming.kicks-ass.net>
 <CAGG=3QX4wKcoPWw+5=tOqz3Y7g8ELGZuav3kdWjXRQae=ue9Mg@mail.gmail.com>
 <CALCETrW7B3HkF5iY=qgt0KeN1fXZLVaPZcELYGRm9bOgbirbww@mail.gmail.com> <CAKwvOdkKqkP1qT0002xQnDrByXr_ygvqCmnzZ50vJLDsg6XWXg@mail.gmail.com>
In-Reply-To: <CAKwvOdkKqkP1qT0002xQnDrByXr_ygvqCmnzZ50vJLDsg6XWXg@mail.gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 14 Sep 2020 15:02:36 -0700
X-Gmail-Original-Message-ID: <CALCETrXUaeNUbkQSeMPpPKWDBCEpqX1gLgkv2G9zLeeYMjK8VQ@mail.gmail.com>
Message-ID: <CALCETrXUaeNUbkQSeMPpPKWDBCEpqX1gLgkv2G9zLeeYMjK8VQ@mail.gmail.com>
Subject: Re: [PATCH] x86: use clang builtins to read and write eflags
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Bill Wendling <morbo@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Greg Thelen <gthelen@google.com>,
        John Sperbeck <jsperbeck@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 14, 2020 at 2:05 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> (Bill, please use `./scripts/get_maintainer.pl <patchfile>` to get the
> appropriate list of folks and mailing lists to CC)
>
> On Thu, Sep 3, 2020 at 8:06 AM Andy Lutomirski <luto@kernel.org> wrote:
> >
> > So with my selftests hat on, the inline asm utterly sucks.  Trying to
> > use pushfq / popfq violates the redzone and requires a gross hack to
> > work around.  It also messes up the DWARF annotations.  The kernel
> > gets a free pass on both of these because we don't use a redzone and
> > we don't use DWARF.
>
> Sorry, I don't fully understand:
> 1. What's the redzone?

Userspace ABI.  x86_64 userspace is allowed to use 128 bytes below RSP.

> 2. How does pushfq/popfq violate it?

It clobbers a stack slot owned by the compiler.

> 3. What is the "gross hack"/"workaround?" (So that we might consider
> removing it if these builtins help).

Look in tools/testing/selftests/x86/helpers.h.  I have a patch to
switch to the builtins.

> 4. The kernel does use DWARF, based on configs, right?

Indeed, but user code in the kernel tree (e.g. selftests) does.

> #ifdef CONFIG_X86_64
> #define __read_eflags __builtin_ia32_readeflags_u64
> #define __write_eflags __builtin_i32_writeeflags_u64
> #else
> #define __read_eflags __builtin_ia32_readeflags_u32
> #define __write_eflags __builtin_i32_writeeflags_u32
> #endif

Looks reasonable to me.

>
> Which would be concise.  For smap_save() we can use clac() and stac()
> which might be nicer than `asm goto` (kudos for using `asm goto`, but
> plz no more).  :^P Also, we can probably cleanup the note about GCC <
> 4.9 now. :)

I find it a bit implausible that popfq is faster than a branch, so the
smap_restore() code seems suboptimal.  For smap_save(), I'm not sure
what's ideal, but the current code seems fine other than the bogus
constraint.

> > > Clang chooses the most general constraint when multiple constraints
> > > are specified. So it will use the stack when retrieving the flags.
> >
> > I haven't looked at clang's generated code to see if it's sensible
> > from an optimization perspective, but surely the kernel code right now
> > is genuinely wrong.  GCC is free to omit the frame pointer and
> > generate a stack-relative access for the pop, in which case it will
> > malfunction.
>
> Sorry, this is another case I don't precisely follow, would you mind
> explaining it further to me please?

The compiler is permitted (and expected!) to instantiate an m
constraint as something like offset(%rsp).  For example, this:

unsigned long bogus_read_flags(void)
{
        unsigned long ret;
        asm volatile ("pushfq\n\tpopq %0" : "=m" (ret));
        return ret;
}

compiles to:

        pushfq
        popq -8(%rsp)
        movq    -8(%rsp), %rax
        ret

which is straight-up wrong.  Changing it to "=rm" gives:

        pushfq
        popq %rax
        ret

which is correct, but this only works because gcc politely chose the r
option instead of the m option.  clang chooses poorly and gives:

read_flags:
        pushfq
        popq    -8(%rsp)
        movq    -8(%rsp), %rax
        retq

which is wrong.  I filed a clang bug:

https://bugs.llvm.org/show_bug.cgi?id=47530

but the kernel is buggy here -- clang is within its rights to generate
the bogus sequence above.  Bill's email was IMO rather obfuscated, and
I assume this is what he meant.

Of course, clang unhelpfully generates poor code for the builtin, too:

nice_read_eflags:
        pushq   %rbp
        movq    %rsp, %rbp
        pushfq
        popq    %rax
        popq    %rbp
        retq

I filed a bug for that, too:

https://bugs.llvm.org/show_bug.cgi?id=47531

So we at least need to fix the bogus "=rm", and we should seriously
consider using the builtin.
