Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 374642EC7C2
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 02:34:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbhAGBc3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 20:32:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725792AbhAGBc3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 20:32:29 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98603C0612EF
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jan 2021 17:31:48 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id s15so2539769plr.9
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jan 2021 17:31:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SbVYGy9XqOcWAwUS/VlqYQ0BKy9D6r7yL0ju+vzRuck=;
        b=dE1vMDn9F8fOVCGV78RF1xmRRInz0wzqhTYSQsSrjKWvClxB5psNhdiXXGf8XChQRv
         Goi5YrG/97k1JdBcblGk37CWfqxnRQcpnALj+Y9EnqeJ1GSBLjuH/AkESoUrwbx/rdEe
         1rlsmj0GbKgYnZTvQpgDUNO3KN0u0b9IiCaRxQ8ZqZ30xDnGVXiQf9SO+33KTwr5fLln
         Xh5m3po/uxohcc1Qy3vwryhOexX4g/5sZdTMuOP7CqJEpuuxn51y9NlRqqOPFKEHozwe
         DLi3IN94K9U+jDt1o8kPzEAAMgCnmzt3vZHnrFbxQlXFwnCRuTAUlnmufMTDUZyZzebV
         h9cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SbVYGy9XqOcWAwUS/VlqYQ0BKy9D6r7yL0ju+vzRuck=;
        b=tR2bQrI4ifVgqoa64elhJqKJLzJ2PuAGeVKI7NX3hTxBTmvSB85tcvXAF//o9v6IPU
         R44HeHK5zx2xvJ2Z7nVjxjtxbpA/ETLgQpicFbipDV9k0ZpTMlheafCkZCmrI/1eWarR
         HFPSFcUJBdaGjMOXLbL0yDTOeqFjXwovSSmBR1KaIHxQsSVQHE9Ou8vL3vf1AuHiRrP5
         CnLQ3GN+vht+eWcdkSHDUTjaU0icDVmsnkP7sfSj0M2AFvJuEQE4a3fHt3CfPGsrWjQt
         kenLXaNLI+fv5GIfikRApl7GT6TinH5HVFYXrmJGgu7hEXPxoKDBTveSkhO8dn5cpiSE
         4HxQ==
X-Gm-Message-State: AOAM531hgi72pBvOSJvGSuuhLkbR0sibjYS85yIPnedQ51UWaICHVSAZ
        yCM0aLOKcCn40IPGN3wVwCPzlipqMhL5iJ6c4aUQSg==
X-Google-Smtp-Source: ABdhPJyCPrFx19bOxTvH9LajuQFjd7Pxi9hyhfYgix3i9Y6pKvXme5SzSSdNMZvBSaddpL3Q3FTT/XIGZ+DgOzidxxw=
X-Received: by 2002:a17:90a:31c3:: with SMTP id j3mr6731683pjf.25.1609983107918;
 Wed, 06 Jan 2021 17:31:47 -0800 (PST)
MIME-Version: 1.0
References: <20210107001739.1321725-1-maskray@google.com>
In-Reply-To: <20210107001739.1321725-1-maskray@google.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 6 Jan 2021 17:31:36 -0800
Message-ID: <CAKwvOdkR5E81=w-F9YbGdPCfr8qtUe_uPx6dnQiHdapC22XHgg@mail.gmail.com>
Subject: Re: [PATCH] x86: Treat R_386_PLT32 as R_386_PC32
To:     Fangrui Song <maskray@google.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Arvind Sankar <nivedita@alum.mit.edu>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 6, 2021 at 4:17 PM Fangrui Song <maskray@google.com> wrote:
>
> This is similar to commit b21ebf2fb4cde1618915a97cc773e287ff49173e "x86:
> Treat R_X86_64_PLT32 as R_X86_64_PC32", but for i386.  As far as Linux

nit: the format for referring to in tree sha's:

commit b21ebf2fb4cd ("x86: Treat R_X86_64_PLT32 as R_X86_64_PC32")

ie. `commit <first 12 chars of sha> ("<oneline from commit message>")

> kernel is concerned, R_386_PLT32 can be treated the same as R_386_PC32.
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
> PLT, but R_386_PLT32 is arguably preferable for -fno-pic code as well:
> this can avoid a "canonical PLT entry" (st_shndx=0, st_value!=0) if the
> symbol turns out to be defined externally. Latest Clang (since
> 961f31d8ad14c66829991522d73e14b5a96ff6d4) can use R_386_PLT32 for

Is https://reviews.llvm.org/rG37f0c8df47d84ba311fc9a2c1884935ba8961e84
related? If so, that should be linked; it would be good to say
"clang-12" rather than "Latest Clang" since in some time "Latest
Clang" will lose meaning.

> compiler produced symbols (if we drop -ffreestanding for CONFIG_X86_32,
> library call optimization can produce newer declarations) and future GCC
> may use R_386_PLT32 as well if the maintainers agree to adopt an option
> like -fdirect-access-external-data to avoid "canonical PLT entry"/copy
> relocations https://gcc.gnu.org/bugzilla/show_bug.cgi?id=98112

Punctuation for end of sentence.

>
> Link: https://github.com/ClangBuiltLinux/linux/issues/1210
> Reported-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Fangrui Song <maskray@google.com>

This fixes a build failure for me with clang-12 (ie. top of tree),
thanks for the patch.

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Tested-by: Nick Desaulniers <ndesaulniers@google.com>

I also see R_386_PC32 referenced in scripts/mod/modpost.c and wonder
if we'd need to potentially handle R_386_PLT32 relocation types there
as well? No current build failures, so maybe YAGNI.

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
> 2.29.2.729.g45daf8777d-goog
>


-- 
Thanks,
~Nick Desaulniers
