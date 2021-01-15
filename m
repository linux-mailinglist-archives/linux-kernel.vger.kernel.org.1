Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A579B2F71BC
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 05:52:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731477AbhAOEwR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 23:52:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726019AbhAOEwQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 23:52:16 -0500
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16727C061575
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 20:51:36 -0800 (PST)
Received: by mail-io1-xd2f.google.com with SMTP id z5so15844770iob.11
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 20:51:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=QBJgA4HNYXN/XW/YtH3zS5vGCt3KtxYhfozKpWDh0/Y=;
        b=mIBaiyCa3l9zHhwvjFtxfvSPcdm/NcqRL+gd/jcttVD9dz/JXV//nh1BrwqTyfPP0S
         suLzCStfuqNUEoOG+xmti8BSpyp3i/7YWNT5EUFlHV0uL6Cli3QU7pf9mKXQsHk/FEEL
         fQbY6a/mEZTXu2KgZKvEbBOqF97xJ6l1TBDjflyprqY2S9RB5/EGA8O4i9k2E94aSTPq
         ZxvPiihBYGiH0cSXYOphQ3FQBjI+UELaTgGpvQ8u/LX1gv2Go42H3/7AtyHKQYb6lWy2
         FaXKcIANQH40Wfqy588nhaHGr2b38xF87CLGGYecRkqPeoL1f+oRtU6iiS7akMm0paiz
         XhJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=QBJgA4HNYXN/XW/YtH3zS5vGCt3KtxYhfozKpWDh0/Y=;
        b=nQkZCNbmWu8m/z3ZW/9sMPrOnmU4a0puyc8qdMUYGWKNuKT75WAgFT8bfnN8ZLRRc2
         XqDub4D/u8iBDai90oxlL4JjuP/vQ0nznZYB/t112//UV5GXE3TToe2WiCs9qrknI6uY
         QSioMxVzOarDqXkPUkBKiZnhcuAxB0XXef+qqpUtSNXxanQr/H2VhaYqfxpM/X9uu4qz
         qoIIAu7D19nc1bn8lZHZRGZphkcDtKzQCNvtd2tTwR8NCuVLFhTVeptVrdNQ9axwAoSq
         LYHmMn3SQYSifoMnvtNw3kE+d929nzeUuoaxf7Tl8NYGkUw+W2/w6j77RtdovVvNCqRB
         dWAA==
X-Gm-Message-State: AOAM533+Cf55NAw7pobcZE/Fwck9cWKubeJWfTFc/w+AQkncmAmDFojZ
        CknOgXUflz6dqlSqfK90uDFeqEANhZQd7WOUr70=
X-Google-Smtp-Source: ABdhPJycvSRZq56+vQBfSbxRGXmlQmhyk5z093LgJuTqenfCC03PbeLRdDQGMbtzCGdnzxJ+IH0Fi0Ge4ieKSfpyMu4=
X-Received: by 2002:a05:6e02:eb0:: with SMTP id u16mr9293810ilj.209.1610686295416;
 Thu, 14 Jan 2021 20:51:35 -0800 (PST)
MIME-Version: 1.0
References: <cover.1610652862.git.jpoimboe@redhat.com>
In-Reply-To: <cover.1610652862.git.jpoimboe@redhat.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Fri, 15 Jan 2021 05:51:24 +0100
Message-ID: <CA+icZUV1a-DEf-dTm8MyyBbp_VYmW5WwJPF9DQb=yJHPykJASQ@mail.gmail.com>
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

On Thu, Jan 14, 2021 at 8:40 PM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
>
> Add support for proper vmlinux.o validation, which will be needed for
> Sami's upcoming x86 LTO set.  (And vmlinux validation is the future for
> objtool anyway, for other reasons.)
>
> This isn't 100% done -- most notably, crypto still needs to be supported
> -- but I think this gets us most of the way there.
>
> This can also be found at
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/jpoimboe/linux.git objtool-vmlinux
>
> And for more testing it can be combined with Sami's x86 LTO patches:
>
>   https://github.com/samitolvanen/linux clang-lto
>
>
>
> Josh Poimboeuf (21):
>   objtool: Fix seg fault in BT_FUNC() with fake jump
>   objtool: Fix error handling for STD/CLD warnings
>   objtool: Fix retpoline detection in asm code
>   objtool: Fix ".cold" section suffix check for newer versions of GCC
>   objtool: Support retpoline jump detection for vmlinux.o
>   x86/ftrace: Add UNWIND_HINT_FUNC annotation for ftrace_stub
>   objtool: Assume only ELF functions do sibling calls
>   objtool: Add asm version of STACK_FRAME_NON_STANDARD
>   objtool: Combine UNWIND_HINT_RET_OFFSET and UNWIND_HINT_FUNC
>   objtool: Add xen_start_kernel() to noreturn list
>   objtool: Move unsuffixed symbol conversion to a helper function
>   objtool: Add CONFIG_CFI_CLANG support
>   x86/xen: Support objtool validation in xen-asm.S
>   x86/xen: Support objtool vmlinux.o validation in xen-head.S
>   x86/xen/pvh: Convert indirect jump to retpoline
>   x86/ftrace: Support objtool vmlinux.o validation in ftrace_64.S
>   x86/acpi: Convert indirect jump to retpoline
>   x86/acpi: Support objtool validation in wakeup_64.S
>   x86/power: Convert indirect jumps to retpolines
>   x86/power: Move restore_registers() to top of the file
>   x86/power: Support objtool validation in hibernate_asm_64.S
>
>  arch/x86/include/asm/unwind_hints.h |  13 +---
>  arch/x86/kernel/acpi/Makefile       |   1 -
>  arch/x86/kernel/acpi/wakeup_64.S    |   5 +-
>  arch/x86/kernel/ftrace_64.S         |   8 +--
>  arch/x86/lib/retpoline.S            |   2 +-
>  arch/x86/platform/pvh/head.S        |   3 +-
>  arch/x86/power/Makefile             |   1 -
>  arch/x86/power/hibernate_asm_64.S   | 105 ++++++++++++++--------------
>  arch/x86/xen/Makefile               |   1 -
>  arch/x86/xen/xen-asm.S              |  29 +++++---
>  arch/x86/xen/xen-head.S             |   5 +-
>  include/linux/objtool.h             |  13 +++-
>  tools/include/linux/objtool.h       |  13 +++-
>  tools/objtool/arch/x86/decode.c     |   4 +-
>  tools/objtool/arch/x86/special.c    |   2 +-
>  tools/objtool/check.c               |  91 +++++++++++++-----------
>  tools/objtool/check.h               |  12 +++-
>  tools/objtool/elf.c                 |  87 +++++++++++++++++------
>  tools/objtool/elf.h                 |   2 +-
>  19 files changed, 241 insertions(+), 156 deletions(-)
>
> --
> 2.29.2
>

I tried this series on top of clang-cfi and it segfaults here.

+ info OBJTOOL vmlinux.o
+ [  != silent_ ]
+ printf   %-7s %s\n OBJTOOL vmlinux.o
 OBJTOOL vmlinux.o
+ tools/objtool/objtool orc generate --duplicate --mcount --vmlinux
--no-fp --no-unreachable --retpoline --uaccess vmlinux.o
Segmentation fault
+ on_exit
+ [ 139 -ne 0 ]
+ cleanup
+ rm -f .btf.*
+ rm -f .tmp_System.map
+ rm -f .tmp_initcalls.lds
+ rm -f .tmp_symversions.lds
+ rm -f .tmp_vmlinux*
+ rm -f System.map
+ rm -f vmlinux
+ rm -f vmlinux.o
make[3]: *** [Makefile:1213: vmlinux] Error 139

- Sedat -
