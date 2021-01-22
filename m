Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2FB72FFEB6
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 09:54:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726247AbhAVIwx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 03:52:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727085AbhAVIuh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 03:50:37 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41C5AC0613D6
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 00:49:55 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id a20so293810pjs.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 00:49:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vuYYxfHO/zPcYQBLEclWRDog1Ypxlh8KeuaA6+NsDvY=;
        b=Q98YbcV2IQJMhFLKAD7cFqWyiSmPq/Mcn7y55WxRgs/oAzFCKHNMx94vWoVKBagy3+
         r09BMmdHegxPafn40rvPE2dV1xIxT8cekmOrTgf+eokSLTawIbUSIcVkFPd3v6R8YYOy
         ARvoXJ1NhFJfdSJ+oqenhAx5ALNP4GLlYKqpn0hLNcEOaHLJIh0HLl1W5xrtivm/cvSP
         6wkMltPYWzbhe1CkSgA2n0QhtsXwfVsGoJ5fLMoMRaM99GMD+3+pOcxzNjxhRUw/Q2bM
         wgIEmVGti/lekUNSqMqZm75+NlgMXiRokM+TB/KWDayu+H/b4Q3BNkHdP/LezspKGFIc
         ouEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vuYYxfHO/zPcYQBLEclWRDog1Ypxlh8KeuaA6+NsDvY=;
        b=dknup9+LD51mgBuRa71o2LkIrGSVIMlKKWaayyqO3QMm3SKFSbkiqQ1OsMwbm84VlF
         QJ9nMRjw5LzCNtZIGxAH1bhJE/ecxUhjsouz6MYu7lp6Ano9+a3xY3Q5QbQcYhlXg3xa
         rie6NHpArAl+zAHh00ITW6K2vRkEH6978ePcCQb4EogUhNwIOa/Xo4si+LngzBX7jWUc
         adXY0V0fmQNw10E03gLVee1dQQzmOrfX4xCNFvos14secsPFTHu2IdQmGxBAPO30vA2M
         sGgI8ECd9irzAYV+48DSsLJcIasfv4u0AiNdU+a3j06MoJY1Fgvr0BjADnwIOlNFpUFj
         9IOw==
X-Gm-Message-State: AOAM533TAWEbNiv212Tys/dkxJ6ooo4/g8BYF6krKCNJIATQM795DJWm
        2zFEWtBHANBVnXiZgJu2uFk0+GugJtePQ+GpSmkFDiTPxUZUIQ==
X-Google-Smtp-Source: ABdhPJyEc7vl11PHRndOMMg79n0of7jPoYY0VtG5oyFc1yfcmAUBNtkHhChKzgnRywWFrwfNh7o6LC+/uyKl8kuqDVk=
X-Received: by 2002:a17:90a:da02:: with SMTP id e2mr4092438pjv.173.1611305394649;
 Fri, 22 Jan 2021 00:49:54 -0800 (PST)
MIME-Version: 1.0
References: <20210107185555.2781221-1-maskray@google.com> <20210114224819.1608929-1-maskray@google.com>
In-Reply-To: <20210114224819.1608929-1-maskray@google.com>
From:   =?UTF-8?B?RsSBbmctcnXDrCBTw7JuZw==?= <maskray@google.com>
Date:   Fri, 22 Jan 2021 00:49:43 -0800
Message-ID: <CAFP8O3JBkxYfQ+shsmu=8e1QE4Wza6vt69PaZGNegLKQS9b1DA@mail.gmail.com>
Subject: Re: [PATCH v3] x86: Treat R_386_PLT32 as R_386_PC32
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        X86 ML <x86@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 14, 2021 at 2:48 PM Fangrui Song <maskray@google.com> wrote:
>
> This is similar to commit b21ebf2fb4cd ("x86: Treat R_X86_64_PLT32 as
> R_X86_64_PC32"), but for i386.  As far as Linux kernel is concerned,
> R_386_PLT32 can be treated the same as R_386_PC32.
>
> R_386_PC32/R_X86_64_PC32 are PC-relative relocation types with the
> requirement that the symbol address is significant.
> R_386_PLT32/R_X86_64_PLT32 are PC-relative relocation types without the
> address significance requirement.
>
> On x86-64, there is no PIC vs non-PIC PLT distinction and an
> R_X86_64_PLT32 relocation is produced for both `call/jmp foo` and
> `call/jmp foo@PLT` with newer (2018) GNU as/LLVM integrated assembler.
>
> On i386, there are 2 types of PLTs, PIC and non-PIC. Currently the
> convention is to use R_386_PC32 for non-PIC PLT and R_386_PLT32 for PIC
> PLT.
>
> clang-12 -fno-pic (since
> https://github.com/llvm/llvm-project/commit/a084c0388e2a59b9556f2de0083333232da3f1d6)
> can emit R_386_PLT32 for compiler generated function declarations as
> well to avoid a canonical PLT entry (st_shndx=0, st_value!=0) if the
> symbol turns out to be defined externally. GCC/GNU as will likely keep
> using R_386_PC32 because (1) the ABI is legacy (2) the change will drop
> a GNU ld non-default visibility ifunc for shared objects.
> https://sourceware.org/bugzilla/show_bug.cgi?id=27169
>
> Link: https://github.com/ClangBuiltLinux/linux/issues/1210
> Reported-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Fangrui Song <maskray@google.com>
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>
> Tested-by: Nick Desaulniers <ndesaulniers@google.com>
> Tested-by: Nathan Chancellor <natechancellor@gmail.com>
>
> ---
> Change in v2:
> * Improve commit message
> ---
> Change in v3:
> * Change the GCC link to the more relevant GNU as link.
> * Fix the relevant llvm-project commit id.
> ---
>  arch/x86/kernel/module.c | 1 +
>  arch/x86/tools/relocs.c  | 2 ++
>  2 files changed, 3 insertions(+)
>
> diff --git a/arch/x86/kernel/module.c b/arch/x86/kernel/module.c
> index 34b153cbd4ac..5e9a34b5bd74 100644
> --- a/arch/x86/kernel/module.c
> +++ b/arch/x86/kernel/module.c
> @@ -114,6 +114,7 @@ int apply_relocate(Elf32_Shdr *sechdrs,
>                         *location += sym->st_value;
>                         break;
>                 case R_386_PC32:
> +               case R_386_PLT32:
>                         /* Add the value, subtract its position */
>                         *location += sym->st_value - (uint32_t)location;
>                         break;
> diff --git a/arch/x86/tools/relocs.c b/arch/x86/tools/relocs.c
> index ce7188cbdae5..717e48ca28b6 100644
> --- a/arch/x86/tools/relocs.c
> +++ b/arch/x86/tools/relocs.c
> @@ -867,6 +867,7 @@ static int do_reloc32(struct section *sec, Elf_Rel *rel, Elf_Sym *sym,
>         case R_386_PC32:
>         case R_386_PC16:
>         case R_386_PC8:
> +       case R_386_PLT32:
>                 /*
>                  * NONE can be ignored and PC relative relocations don't
>                  * need to be adjusted.
> @@ -910,6 +911,7 @@ static int do_reloc_real(struct section *sec, Elf_Rel *rel, Elf_Sym *sym,
>         case R_386_PC32:
>         case R_386_PC16:
>         case R_386_PC8:
> +       case R_386_PLT32:
>                 /*
>                  * NONE can be ignored and PC relative relocations don't
>                  * need to be adjusted.
> --
> 2.30.0.296.g2bfb1c46d8-goog
>

Ping:)
