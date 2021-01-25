Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52C5A30264E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 15:31:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729351AbhAYO3f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 09:29:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729427AbhAYOXv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 09:23:51 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 867A2C061574
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 06:23:11 -0800 (PST)
Received: from zn.tnic (p200300ec2f09db0060c9c38025ffa6e4.dip0.t-ipconnect.de [IPv6:2003:ec:2f09:db00:60c9:c380:25ff:a6e4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 936861EC04F2;
        Mon, 25 Jan 2021 15:23:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1611584588;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=KvaGodOg8sDLe0fDG3u7guV4sdl96juKUdVwNDOmutg=;
        b=jxm2GLMn3n4VvOoCFEjJlwvqnSYK2o33cAM7EX3vj3izVx8C/JQfZBwItN1IPG50yt+Zzi
        wyR7XWIWAeukFevjKzxuizaRlkrCr91SnQ2ZI1+x8A3OlyP8/xyR2/HESQLNOkJBmEXjSV
        ev0YrfD8tlI7DQjyrncxEqaNgxyIeXA=
Date:   Mon, 25 Jan 2021 15:23:02 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Fangrui Song <maskray@google.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        Arnd Bergmann <arnd@arndb.de>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Michael Matz <matz@suse.de>
Subject: Re: [PATCH v3] x86: Treat R_386_PLT32 as R_386_PC32
Message-ID: <20210125142302.GA23070@zn.tnic>
References: <20210107185555.2781221-1-maskray@google.com>
 <20210114224819.1608929-1-maskray@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210114224819.1608929-1-maskray@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's a good thing I have a toolchain guy who can explain to me what you
guys are doing because you need to start writing those commit messages
for !toolchain developers.

On Thu, Jan 14, 2021 at 02:48:19PM -0800, Fangrui Song wrote:
> This is similar to commit b21ebf2fb4cd ("x86: Treat R_X86_64_PLT32 as
> R_X86_64_PC32"), but for i386.  As far as Linux kernel is concerned,
> R_386_PLT32 can be treated the same as R_386_PC32.
> 
> R_386_PC32/R_X86_64_PC32 are PC-relative relocation types with the
> requirement that the symbol address is significant.
> R_386_PLT32/R_X86_64_PLT32 are PC-relative relocation types without the
> address significance requirement.

I was told what "significant" means in that context and while it is
clear to you, I'm pretty sure it is not clear to kernel developers who
haven't looked at toolchains in depth. So please elaborate.

> On x86-64, there is no PIC vs non-PIC PLT distinction and an
> R_X86_64_PLT32 relocation is produced for both `call/jmp foo` and
> `call/jmp foo@PLT` with newer (2018) GNU as/LLVM integrated assembler.

Also, please explain in short why LLVM is generating R_X86_64_PLT32
relocs now? I.e., is it the same reason as why binutils does that?

I.e., mentioning the big picture of things would help as to why you're
doing this.

> On i386, there are 2 types of PLTs, PIC and non-PIC. Currently the
> convention is to use R_386_PC32 for non-PIC PLT and R_386_PLT32 for PIC
> PLT.

Convention in general or convention for LLVM?

> clang-12 -fno-pic (since
> https://github.com/llvm/llvm-project/commit/a084c0388e2a59b9556f2de0083333232da3f1d6)
> can emit R_386_PLT32 for compiler generated function declarations as
> well to avoid a canonical PLT entry (st_shndx=0, st_value!=0) if the
> symbol turns out to be defined externally. GCC/GNU as will likely keep
> using R_386_PC32 because (1) the ABI is legacy (2) the change will drop
> a GNU ld non-default visibility ifunc for shared objects.
> https://sourceware.org/bugzilla/show_bug.cgi?id=27169

Not sure how useful this paragraph is for kernel developers...

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
>  			*location += sym->st_value;
>  			break;
>  		case R_386_PC32:
> +		case R_386_PLT32:
>  			/* Add the value, subtract its position */
>  			*location += sym->st_value - (uint32_t)location;
>  			break;
> diff --git a/arch/x86/tools/relocs.c b/arch/x86/tools/relocs.c
> index ce7188cbdae5..717e48ca28b6 100644
> --- a/arch/x86/tools/relocs.c
> +++ b/arch/x86/tools/relocs.c
> @@ -867,6 +867,7 @@ static int do_reloc32(struct section *sec, Elf_Rel *rel, Elf_Sym *sym,
>  	case R_386_PC32:
>  	case R_386_PC16:
>  	case R_386_PC8:
> +	case R_386_PLT32:
>  		/*
>  		 * NONE can be ignored and PC relative relocations don't
>  		 * need to be adjusted.

That comment might need adjustment.

> @@ -910,6 +911,7 @@ static int do_reloc_real(struct section *sec, Elf_Rel *rel, Elf_Sym *sym,
>  	case R_386_PC32:
>  	case R_386_PC16:
>  	case R_386_PC8:
> +	case R_386_PLT32:
>  		/*
>  		 * NONE can be ignored and PC relative relocations don't
>  		 * need to be adjusted.

Ditto.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
