Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA1D12FF81C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 23:41:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727137AbhAUWkS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 17:40:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727075AbhAUWjs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 17:39:48 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5712C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 14:39:06 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id q129so7439753iod.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 14:39:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=hm2msTaf5VzRjPCAA+w+1MuBzYiewjiIsmSAGwC1ATw=;
        b=VpDkjP0RBffgqKeiDwDH49oRl+fGXlnjw8knPur/vHA375hwrkQrzXx8KBxwilM4BF
         bX2q+PuusDI60fmv3V78yvJSDXLg4htFHioaeCv1B2pTqyhZ63gGJGMgfo7u2plH72lx
         CV7yCPIDKA8BxQf4WARiU2WWYwloGPz+gIOySd8iQGODZ6jnEd9vAZYqn1pMJ3BxuU+N
         BygLNDIFgWexWUO530BoXY2asUoyJsTfIG2NJ/S4fpSTFMOqMbDh4cmexUfFY1AvsFhA
         i/h3FTwSUe8W7b1EnWtdT4C9y02RQYm7W2QVK6jRyPJMWupssPwEYSVv7vonUdHDYq3N
         NGow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=hm2msTaf5VzRjPCAA+w+1MuBzYiewjiIsmSAGwC1ATw=;
        b=lwxl7rWE6ySbVlIwA0ibT3hdgNcRsICoDH8JqG5nk6A5XU33npSLA7tnfKfZc3tBd7
         ivDHBcvHc2in6Hm6vwxD+LuCiQvZlCcpdzLUN7oHbxwuP3oqi5Pn4GNlIBc+nSnhbNDa
         YTiJDprr+LXrzm2RumtO+EJLA+m8hvl9khslb0KSCKNBCH2Ztd7qeFY04WJzWV7oQ7a7
         d9wX35Ic+rcavr43KZU2HRw/lxfYDUkNdROrJUGcaQ32y3/CJaWZD6ceobGxxpyy5XUk
         kUA2O8yz2USx59WLsMZnTM/7Gx1X/HUx8hCu/KCiTxnBXTpqsxY2ESXvfkEJMrwk9HAB
         hnPA==
X-Gm-Message-State: AOAM533COlQCBN//XQvTCRyc1YfbfrEn1+GNqYX9EBpJ3ys57wpMbJ6+
        lzNQXmHKSp7cFe9WkyuLMj5PDSGEyjRig41fAzA=
X-Google-Smtp-Source: ABdhPJxaEXqiA08rlt5zbnY8+4sz7vcv99g3mcjfYYkWSpyBfZr0RYdcDsTFLhSbTBH5tE5iItPzFfgdsReQTzm3LWY=
X-Received: by 2002:a05:6602:2f93:: with SMTP id u19mr1341198iow.110.1611268745483;
 Thu, 21 Jan 2021 14:39:05 -0800 (PST)
MIME-Version: 1.0
References: <cover.1611263461.git.jpoimboe@redhat.com>
In-Reply-To: <cover.1611263461.git.jpoimboe@redhat.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Thu, 21 Jan 2021 23:38:54 +0100
Message-ID: <CA+icZUU6QBeahDWpgYPjkf_OmRC+4T4SAnCg=iObNq9+CGT6jA@mail.gmail.com>
Subject: Re: [PATCH v2 00/20] objtool: vmlinux.o and CLANG LTO support
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

On Thu, Jan 21, 2021 at 10:29 PM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
>
> v2:
> - fix commit description for why xen hypervisor page contents don't
>   matter [Juergen]
> - annotate indirect jumps as safe instead of converting them to
>   retpolines [Andrew, Juergen]
> - drop patch 1 - fake jumps no longer exist
> - add acks
>
> Based on tip/objtool/core.
>
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

Should this be s/objtool-vmlinux/objtool-vmlinux-v2 ?

- Sedat -

> And for more testing it can be combined with Sami's x86 LTO patches:
>
>   https://github.com/samitolvanen/linux clang-lto
>
>
> Josh Poimboeuf (20):
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
>   x86/xen/pvh: Annotate indirect branch as safe
>   x86/ftrace: Support objtool vmlinux.o validation in ftrace_64.S
>   x86/acpi: Annotate indirect branch as safe
>   x86/acpi: Support objtool validation in wakeup_64.S
>   x86/power: Annotate indirect branches as safe
>   x86/power: Move restore_registers() to top of the file
>   x86/power: Support objtool validation in hibernate_asm_64.S
>
>  arch/x86/include/asm/unwind_hints.h   |  13 +---
>  arch/x86/kernel/acpi/Makefile         |   1 -
>  arch/x86/kernel/acpi/wakeup_64.S      |   4 +
>  arch/x86/kernel/ftrace_64.S           |   8 +-
>  arch/x86/lib/retpoline.S              |   2 +-
>  arch/x86/platform/pvh/head.S          |   2 +
>  arch/x86/power/Makefile               |   1 -
>  arch/x86/power/hibernate_asm_64.S     | 103 +++++++++++++-------------
>  arch/x86/xen/Makefile                 |   1 -
>  arch/x86/xen/xen-asm.S                |  29 +++++---
>  arch/x86/xen/xen-head.S               |   5 +-
>  include/linux/objtool.h               |  13 +++-
>  tools/include/linux/objtool.h         |  13 +++-
>  tools/objtool/arch/x86/decode.c       |   4 +-
>  tools/objtool/arch/x86/special.c      |   2 +-
>  tools/objtool/check.c                 |  89 ++++++++++++----------
>  tools/objtool/elf.c                   |  88 ++++++++++++++++------
>  tools/objtool/include/objtool/check.h |  12 ++-
>  tools/objtool/include/objtool/elf.h   |   2 +-
>  19 files changed, 240 insertions(+), 152 deletions(-)
>
> --
> 2.29.2
>
