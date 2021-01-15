Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C454E2F7F98
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 16:31:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732985AbhAOPa7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 10:30:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726849AbhAOPa5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 10:30:57 -0500
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EF96C061757
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 07:30:17 -0800 (PST)
Received: by mail-io1-xd36.google.com with SMTP id d9so18822097iob.6
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 07:30:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=9tGP6LLQ137anIQKqmX6+3qkciwULnuVTeg/pgmzRE8=;
        b=NXSO1eFyssgXRc+ToB3CfRlRxii1wSMr/x0P8ED3FVJHQJFCL5MbAC0nZpKvmWLDV9
         2jM5ykbS77iM4DzgDOnjlEdXbqJIHY7EyqN5Yr9zqmLnWTFByaCnMddUkUwAwjd+v1Wd
         NSAO9uqX54CRWFvzcuuOquZPuKC0hJCZ+gJTKfH4lE2uTFIskbYOEtx/T+VWQfx+hcU8
         kCClAjU5NzUwFzT3SPhzyLMTR80bPr3y7ZHYr5K+ZJbE0jRuygz6Kti/TN4Hm2Bgk8gj
         wCdKz5hAiEIx8bSBb/1Z5VgbdZplYRN8nj9Z1/KkxaXW/iE8V5Uneg1cPGZ110d2GdSZ
         cs8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=9tGP6LLQ137anIQKqmX6+3qkciwULnuVTeg/pgmzRE8=;
        b=jHXZypoOzDfapAc2M2zZDaLuCwTqIXAMZDSwIOJiFcwJICzbQo+bwXnqpZXntvqjv4
         PHiu+6z2lLEbMhjbNC5it8KeVrg4S50tIxW7XTVlaOcopuUAuzAAuZ6+FnHubRwjksB0
         SoOyOrOFWzsYaopWMOKGeWMww37pk2cb07pcAoqjwU3NXZ3prVwlrXAfSSNz+UpNwfjf
         NUP5t1x1QvTqVfAxWjdguudOcr1ro1i3iqhN09FfzjDxfmyV91AcOipIs3CsS6PKUET1
         8u2S8eZX8sDPW8WR1Ts0Rn41/tLTjEeeLeR9rT1cnep6R+l0FkTs3cnjL7ohqj4JmYvU
         H8bA==
X-Gm-Message-State: AOAM5319XGKMxQaPJ0OgJn71EAtq7+jyNG3goBJNzrqGkcU5Mr3CFEAq
        da41AmQCLl2FaXQbxFFnamYnSNoQXY9BDSf5Jaw=
X-Google-Smtp-Source: ABdhPJzPnLLA1q8mUr68X2IwXOuHF8vlXs2B/lOxFRE8Cg1bKrB6EPeCPsrEQ5YBFXLUcDbzU4fAA04HSr2y/H8+uK0=
X-Received: by 2002:a5e:9b06:: with SMTP id j6mr8945465iok.171.1610724616587;
 Fri, 15 Jan 2021 07:30:16 -0800 (PST)
MIME-Version: 1.0
References: <cover.1610652862.git.jpoimboe@redhat.com> <CA+icZUV1a-DEf-dTm8MyyBbp_VYmW5WwJPF9DQb=yJHPykJASQ@mail.gmail.com>
In-Reply-To: <CA+icZUV1a-DEf-dTm8MyyBbp_VYmW5WwJPF9DQb=yJHPykJASQ@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Fri, 15 Jan 2021 16:30:05 +0100
Message-ID: <CA+icZUVc0M3Ydf=SKSV2MhDmdb49nGSrN-9TjYvjL25vmDHaeQ@mail.gmail.com>
Subject: Re: [PATCH 00/21] objtool: vmlinux.o and CLANG LTO support
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Clang-Built-Linux ML <clang-built-linux@googlegroups.com>,
        Miroslav Benes <mbenes@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 15, 2021 at 5:51 AM Sedat Dilek <sedat.dilek@gmail.com> wrote:
>
> On Thu, Jan 14, 2021 at 8:40 PM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> >
> > Add support for proper vmlinux.o validation, which will be needed for
> > Sami's upcoming x86 LTO set.  (And vmlinux validation is the future for
> > objtool anyway, for other reasons.)
> >
> > This isn't 100% done -- most notably, crypto still needs to be supported
> > -- but I think this gets us most of the way there.
> >
> > This can also be found at
> >
> >   git://git.kernel.org/pub/scm/linux/kernel/git/jpoimboe/linux.git objtool-vmlinux
> >
> > And for more testing it can be combined with Sami's x86 LTO patches:
> >
> >   https://github.com/samitolvanen/linux clang-lto
> >
> >
> >
> > Josh Poimboeuf (21):
> >   objtool: Fix seg fault in BT_FUNC() with fake jump
> >   objtool: Fix error handling for STD/CLD warnings
> >   objtool: Fix retpoline detection in asm code
> >   objtool: Fix ".cold" section suffix check for newer versions of GCC
> >   objtool: Support retpoline jump detection for vmlinux.o
> >   x86/ftrace: Add UNWIND_HINT_FUNC annotation for ftrace_stub
> >   objtool: Assume only ELF functions do sibling calls
> >   objtool: Add asm version of STACK_FRAME_NON_STANDARD
> >   objtool: Combine UNWIND_HINT_RET_OFFSET and UNWIND_HINT_FUNC
> >   objtool: Add xen_start_kernel() to noreturn list
> >   objtool: Move unsuffixed symbol conversion to a helper function
> >   objtool: Add CONFIG_CFI_CLANG support
> >   x86/xen: Support objtool validation in xen-asm.S
> >   x86/xen: Support objtool vmlinux.o validation in xen-head.S
> >   x86/xen/pvh: Convert indirect jump to retpoline
> >   x86/ftrace: Support objtool vmlinux.o validation in ftrace_64.S
> >   x86/acpi: Convert indirect jump to retpoline
> >   x86/acpi: Support objtool validation in wakeup_64.S
> >   x86/power: Convert indirect jumps to retpolines
> >   x86/power: Move restore_registers() to top of the file
> >   x86/power: Support objtool validation in hibernate_asm_64.S
> >
> >  arch/x86/include/asm/unwind_hints.h |  13 +---
> >  arch/x86/kernel/acpi/Makefile       |   1 -
> >  arch/x86/kernel/acpi/wakeup_64.S    |   5 +-
> >  arch/x86/kernel/ftrace_64.S         |   8 +--
> >  arch/x86/lib/retpoline.S            |   2 +-
> >  arch/x86/platform/pvh/head.S        |   3 +-
> >  arch/x86/power/Makefile             |   1 -
> >  arch/x86/power/hibernate_asm_64.S   | 105 ++++++++++++++--------------
> >  arch/x86/xen/Makefile               |   1 -
> >  arch/x86/xen/xen-asm.S              |  29 +++++---
> >  arch/x86/xen/xen-head.S             |   5 +-
> >  include/linux/objtool.h             |  13 +++-
> >  tools/include/linux/objtool.h       |  13 +++-
> >  tools/objtool/arch/x86/decode.c     |   4 +-
> >  tools/objtool/arch/x86/special.c    |   2 +-
> >  tools/objtool/check.c               |  91 +++++++++++++-----------
> >  tools/objtool/check.h               |  12 +++-
> >  tools/objtool/elf.c                 |  87 +++++++++++++++++------
> >  tools/objtool/elf.h                 |   2 +-
> >  19 files changed, 241 insertions(+), 156 deletions(-)
> >
> > --
> > 2.29.2
> >
>
> I tried this series on top of clang-cfi and it segfaults here.
>
> + info OBJTOOL vmlinux.o
> + [  != silent_ ]
> + printf   %-7s %s\n OBJTOOL vmlinux.o
>  OBJTOOL vmlinux.o
> + tools/objtool/objtool orc generate --duplicate --mcount --vmlinux
> --no-fp --no-unreachable --retpoline --uaccess vmlinux.o
> Segmentation fault
> + on_exit
> + [ 139 -ne 0 ]
> + cleanup
> + rm -f .btf.*
> + rm -f .tmp_System.map
> + rm -f .tmp_initcalls.lds
> + rm -f .tmp_symversions.lds
> + rm -f .tmp_vmlinux*
> + rm -f System.map
> + rm -f vmlinux
> + rm -f vmlinux.o
> make[3]: *** [Makefile:1213: vmlinux] Error 139
>

I re-tried with the latest clang-lto Git and switched to Debian's LLVM-11.0.1.
This build was successful.
No objtool-vmlinux warnings observed.

In the next step I try with my selfmade LLVM-11.1.0-rc1 (to see if it's broken).

- Sedat
