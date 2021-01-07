Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC13F2EC819
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 03:33:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbhAGCca (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 21:32:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726260AbhAGCc2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 21:32:28 -0500
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 710E7C0612EF
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jan 2021 18:31:48 -0800 (PST)
Received: by mail-io1-xd2b.google.com with SMTP id n4so4743373iow.12
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jan 2021 18:31:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Ocfz6BYodnE1ca0pECVz4l5nljcLR4HxYXqfYA1DSZo=;
        b=GN2YYSrGDrvxbBNcYMWc2A0K3z5hb3/K+k/QeQLwh122Hu6z//v2deYFF+nWY4AXaG
         VdeBRYjyupMxCkzTnORP013NeMGdsrvPbSUZRHWNHkhoknttabH/jnuA3d7HXGlln+FK
         bZJj3KU0fiwyzhw62mHwhWDZg2bIS5XIlS8Dg8b1YELvbGW+8sKMZ8boh2uno5uVcYun
         u5bQEvySYlpwLNs/m71CypFAFihScdSuahZqfLieLdF9THM2Ke9UoCIE6efGmSbfFIYE
         qS2d9eO3ifp4J4Sc8vmzj7kI6OaDBttb1+L0MHzi+8iMwVYGij8+89fH9Rr2bedHpaLu
         5cGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ocfz6BYodnE1ca0pECVz4l5nljcLR4HxYXqfYA1DSZo=;
        b=tJ+SWl0yIkfMdYaMuPi5IuYCfzbiJpRl7Y1rjfFKOiKb3opWTtD93lFb8iHk/3QBsX
         SR2P+24BLbS1ixQoXmnpSNWl95BzGsjuEEiXuCuZ6F6MUO2K6PXU58m7blRGdPLiugfY
         Nx3GnmYMaWMvWlpptXjUrTiHzxtLput7tnOv3Npzo1MztGrCkyXPRDsfvpuJBo23GT7u
         VuQAFLLg0URw8zn0BywotczNc921/51Cv3aAakx33hBt6enuFKpEDHn1/um/9aDGJuWS
         YRrxBp7DUKvNpByDPq9929F/61YmtK+NTpFT7Vq3qCI/I8mEfvUaLOeMEhhLb7CFMkdy
         142g==
X-Gm-Message-State: AOAM530BWb0DX4kofRy1vsY9SNdNDvo7v+6G3WoWuXbINxNVOY7XHCNj
        039vbgtk0lnDj76ljvSA1+Q=
X-Google-Smtp-Source: ABdhPJwovTyxLLgasO0GT2elbhCuqt1r5ZCzCmLt4PozhvZu47d72UMBnBtC57GggfWnhqlzPD5GQw==
X-Received: by 2002:a02:1007:: with SMTP id 7mr6199161jay.73.1609986707707;
        Wed, 06 Jan 2021 18:31:47 -0800 (PST)
Received: from ubuntu-m3-large-x86 ([2604:1380:45f1:1d00::1])
        by smtp.gmail.com with ESMTPSA id h18sm2421732ioh.30.2021.01.06.18.31.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jan 2021 18:31:46 -0800 (PST)
Date:   Wed, 6 Jan 2021 19:31:45 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Fangrui Song <maskray@google.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] x86: Treat R_386_PLT32 as R_386_PC32
Message-ID: <20210107023145.GA3778412@ubuntu-m3-large-x86>
References: <20210107001739.1321725-1-maskray@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210107001739.1321725-1-maskray@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 06, 2021 at 04:17:39PM -0800, Fangrui Song wrote:
> This is similar to commit b21ebf2fb4cde1618915a97cc773e287ff49173e "x86:
> Treat R_X86_64_PLT32 as R_X86_64_PC32", but for i386.  As far as Linux
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
> compiler produced symbols (if we drop -ffreestanding for CONFIG_X86_32,
> library call optimization can produce newer declarations) and future GCC
> may use R_386_PLT32 as well if the maintainers agree to adopt an option
> like -fdirect-access-external-data to avoid "canonical PLT entry"/copy
> relocations https://gcc.gnu.org/bugzilla/show_bug.cgi?id=98112
> 
> Link: https://github.com/ClangBuiltLinux/linux/issues/1210
> Reported-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Fangrui Song <maskray@google.com>

I agree with Nick's comments about the commit message. With those
addressed:

Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>
Tested-by: Nathan Chancellor <natechancellor@gmail.com>

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
> @@ -910,6 +911,7 @@ static int do_reloc_real(struct section *sec, Elf_Rel *rel, Elf_Sym *sym,
>  	case R_386_PC32:
>  	case R_386_PC16:
>  	case R_386_PC8:
> +	case R_386_PLT32:
>  		/*
>  		 * NONE can be ignored and PC relative relocations don't
>  		 * need to be adjusted.
> -- 
> 2.29.2.729.g45daf8777d-goog
> 
