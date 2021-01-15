Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F67B2F7202
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 06:19:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733034AbhAOFTY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 00:19:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726634AbhAOFTY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 00:19:24 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A428C061575
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 21:18:44 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id z5so15928469iob.11
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 21:18:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=Bchw14XUJHyY/yDFEjYPzsWChE/JAge8nOTF2q3cH9M=;
        b=LntmyLiIuekJH+2GiaBxmFco3QvLIHW/MErMGEZ8m3XP5w/1tc8RHZCcWKW374G0vH
         H7dwzUGw2uANbyU8ZEcp7OW++cfEdEpT1TmvghaaP9SxkdllmKxEqqGXKDCgau+DRGoN
         joLoJ6uu9GXjRdKEgP1AWQkvpH4LgZDiqL9S2+LT2ZyJftxNal8pVR+UNykgyjxJUAqp
         bNancR23XYjTqW9lAtgs0YsTWNK/XYdZib37vZUlAyLVmZcDoB9dYBFa0y3I8O0SKh+y
         Cc+RvQoFu2icubmLWJk5qZDqE0QSObi4Uziq3lw9vBFzdifLWAohkuJihqiuS1JoZv47
         DWog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=Bchw14XUJHyY/yDFEjYPzsWChE/JAge8nOTF2q3cH9M=;
        b=sGKdNKflbnLBYZWhhRBEINZgBS8pql02RJ807E8fWCOGKaPaNjc1DYT18gi5dvTHhc
         VsMtZue/xg637WAtxKn2bJcG185TwsOWxTtU6EnPm76ye+tMxhlFaUxCdlCXPyNd4eWY
         4ieLXNVIBTX3G8lB0myRqOMnQfbjeENzBLNnLfC2kka16LAt1y5uDhzvO8RmSw8mRdkX
         h6hJfbFf/wGbDahhb5UskZksXIBrvVFmmoZT4RFxK340JvNQwG5CTllk4yj/Gkm0x0yh
         2UdSdhqiAdw1oDd6xxuVsCTONswpXTQEwP4HFILwAZJFnbClH71JYVHYz3HZifC7jk4N
         z28A==
X-Gm-Message-State: AOAM530ZgvD+n0NHNYyMcy9Ohz22xbrSlZViWOXIyFw92D/l7CDrYT5s
        XM1tRFmJM1ujRELdAUqFX4q4tKLhX/vEiAjGb7k=
X-Google-Smtp-Source: ABdhPJxzHbIEs+et3buzqXrX11qxFOqKSIR0AT4A/pTAXsdsERX9M3owoBlnx60pdRCNFRIYFzqF6FWDDR9/MysWEUE=
X-Received: by 2002:a05:6e02:eb0:: with SMTP id u16mr9369433ilj.209.1610687923176;
 Thu, 14 Jan 2021 21:18:43 -0800 (PST)
MIME-Version: 1.0
References: <cover.1610652862.git.jpoimboe@redhat.com> <CA+icZUV1a-DEf-dTm8MyyBbp_VYmW5WwJPF9DQb=yJHPykJASQ@mail.gmail.com>
In-Reply-To: <CA+icZUV1a-DEf-dTm8MyyBbp_VYmW5WwJPF9DQb=yJHPykJASQ@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Fri, 15 Jan 2021 06:18:31 +0100
Message-ID: <CA+icZUUrHcGZk=rLvAfRKGDyyqfxD1b3zsbZ+dvz4OWm+yznEg@mail.gmail.com>
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

I did:

$ git diff scripts/link-vmlinux.sh
diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
index 2d0b28758aa5..cd0948bd29ea 100755
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -142,7 +142,8 @@ objtool_link()
                       objtoolopt="${objtoolopt} --uaccess"
               fi
               info OBJTOOL ${1}
-               tools/objtool/objtool ${objtoolcmd} ${objtoolopt} ${1}
+               info OBJTOOL SEGFAULTS
+               ##tools/objtool/objtool ${objtoolcmd} ${objtoolopt} ${1}
       fi
}

To save the vmlinux* files and archived them in case you want me to look at it.
Give me clear instructions, Thanks.

- Sedat -
