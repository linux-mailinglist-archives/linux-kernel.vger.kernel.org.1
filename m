Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52B6C27F392
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 22:50:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730281AbgI3Uu3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 16:50:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbgI3Uu2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 16:50:28 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B0C4C061755
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 13:50:28 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id 197so1878622pge.8
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 13:50:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=N+3NHwXxA8yV485XiztEEBdrTeufxn/Z4VtcZ3blITY=;
        b=e0p3cmjFgpRzOq/7vmMcMQI26wMbq6w778SY7WERxsLsz3Ke4Nfe5XrMkn4Xeq8nep
         UUZTklM4EGIxYQmVrDD8yfVbcQIhe6K3yoh8ngSkZStvcTSmLBlndjgiLFTbLtNoopYY
         6Ywl58KeGfg4fgrJXxZu86a9knAtLrYvKAXu0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=N+3NHwXxA8yV485XiztEEBdrTeufxn/Z4VtcZ3blITY=;
        b=BAJ8GtOvNYtpqdoY0BL6BxHy+wnbNCnq11zPn/dk80x1gfErWfSlWyhFCpqfnwIi6P
         3SGUI6MtiUrytKn75aBhS9cesA3dmB6CqEOTXrqSF9RDU4qoI32xM4NmolU2iGqjbqg0
         lcSOoF6UUbYsLePDIy+oJ8/G90pOvwl+0/t721/y+FdygLPIGhQqBTd/WR2RYpKpg09s
         Oo+GP0Adn+kqwYQWYgUCFHOfUWHCOKdcHejY1UdTGC4zdkpM1odXfe2kLK4w+lRR07Gv
         1S/OfrAozfC3UZE3D+zjyTXnHhwtSP3jgtTuPFc/imPj1Yo7yICMw/o4/wWpKRcOE3W3
         uydA==
X-Gm-Message-State: AOAM533mTriYIgqi0HVJ3Wtoz11o1Tstsl3umVm/+NMrRMTl0IoTkSXb
        YzGNUqnVumRi2ecZxVeyeCMqKA==
X-Google-Smtp-Source: ABdhPJzj4WebQxPbqct2X4MW4Jwygq9/nErqIrDf8aWacPlJ5oE2t1YiEpCoupUx6uLq959zmpNdcw==
X-Received: by 2002:a17:902:fe13:b029:d0:89f4:6226 with SMTP id g19-20020a170902fe13b02900d089f46226mr4090118plj.14.1601499027864;
        Wed, 30 Sep 2020 13:50:27 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id f4sm3347199pfj.147.2020.09.30.13.50.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2020 13:50:26 -0700 (PDT)
Date:   Wed, 30 Sep 2020 13:50:26 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juergen Gross <jgross@suse.com>,
        Andy Lutomirski <luto@kernel.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Will Deacon <will@kernel.org>, nadav.amit@gmail.com,
        Nathan Chancellor <natechancellor@gmail.com>,
        Sami Tolvanen <samitolvanen@google.com>
Subject: Re: [PATCH v3] x86/asm: Replace __force_order with memory clobber
Message-ID: <202009301347.EB0EFDD80@keescook>
References: <20200823212550.3377591-1-nivedita@alum.mit.edu>
 <20200902232152.3709896-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200902232152.3709896-1-nivedita@alum.mit.edu>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

*thread ping*

Can an x86 maintainer please take this for -next? Getting this landed
for v5.10 would be very helpful! :)

-Kees

On Wed, Sep 02, 2020 at 07:21:52PM -0400, Arvind Sankar wrote:
> The CRn accessor functions use __force_order as a dummy operand to
> prevent the compiler from reordering CRn reads/writes with respect to
> each other.
> 
> The fact that the asm is volatile should be enough to prevent this:
> volatile asm statements should be executed in program order. However GCC
> 4.9.x and 5.x have a bug that might result in reordering. This was fixed
> in 8.1, 7.3 and 6.5. Versions prior to these, including 5.x and 4.9.x,
> may reorder volatile asm statements with respect to each other.
> 
> There are some issues with __force_order as implemented:
> - It is used only as an input operand for the write functions, and hence
>   doesn't do anything additional to prevent reordering writes.
> - It allows memory accesses to be cached/reordered across write
>   functions, but CRn writes affect the semantics of memory accesses, so
>   this could be dangerous.
> - __force_order is not actually defined in the kernel proper, but the
>   LLVM toolchain can in some cases require a definition: LLVM (as well
>   as GCC 4.9) requires it for PIE code, which is why the compressed
>   kernel has a definition, but also the clang integrated assembler may
>   consider the address of __force_order to be significant, resulting in
>   a reference that requires a definition.
> 
> Fix this by:
> - Using a memory clobber for the write functions to additionally prevent
>   caching/reordering memory accesses across CRn writes.
> - Using a dummy input operand with an arbitrary constant address for the
>   read functions, instead of a global variable. This will prevent reads
>   from being reordered across writes, while allowing memory loads to be
>   cached/reordered across CRn reads, which should be safe.
> 
> Tested-by: Nathan Chancellor <natechancellor@gmail.com>
> Tested-by: Sedat Dilek <sedat.dilek@gmail.com>
> Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
> Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=82602
> Link: https://lore.kernel.org/lkml/20200527135329.1172644-1-arnd@arndb.de/
> ---
> Changes from v2:
> - Clarify commit log and source comment some more
> Changes from v1:
> - Add lore link to email thread and mention state of 5.x/4.9.x in commit log
> 
>  arch/x86/boot/compressed/pgtable_64.c |  9 ---------
>  arch/x86/include/asm/special_insns.h  | 28 ++++++++++++++-------------
>  arch/x86/kernel/cpu/common.c          |  4 ++--
>  3 files changed, 17 insertions(+), 24 deletions(-)
> 
> diff --git a/arch/x86/boot/compressed/pgtable_64.c b/arch/x86/boot/compressed/pgtable_64.c
> index c8862696a47b..7d0394f4ebf9 100644
> --- a/arch/x86/boot/compressed/pgtable_64.c
> +++ b/arch/x86/boot/compressed/pgtable_64.c
> @@ -5,15 +5,6 @@
>  #include "pgtable.h"
>  #include "../string.h"
>  
> -/*
> - * __force_order is used by special_insns.h asm code to force instruction
> - * serialization.
> - *
> - * It is not referenced from the code, but GCC < 5 with -fPIE would fail
> - * due to an undefined symbol. Define it to make these ancient GCCs work.
> - */
> -unsigned long __force_order;
> -
>  #define BIOS_START_MIN		0x20000U	/* 128K, less than this is insane */
>  #define BIOS_START_MAX		0x9f000U	/* 640K, absolute maximum */
>  
> diff --git a/arch/x86/include/asm/special_insns.h b/arch/x86/include/asm/special_insns.h
> index 59a3e13204c3..d6e3bb9363d2 100644
> --- a/arch/x86/include/asm/special_insns.h
> +++ b/arch/x86/include/asm/special_insns.h
> @@ -11,45 +11,47 @@
>  #include <linux/jump_label.h>
>  
>  /*
> - * Volatile isn't enough to prevent the compiler from reordering the
> - * read/write functions for the control registers and messing everything up.
> - * A memory clobber would solve the problem, but would prevent reordering of
> - * all loads stores around it, which can hurt performance. Solution is to
> - * use a variable and mimic reads and writes to it to enforce serialization
> + * The compiler should not reorder volatile asm statements with respect to each
> + * other: they should execute in program order. However GCC 4.9.x and 5.x have
> + * a bug (which was fixed in 8.1, 7.3 and 6.5) where they might reorder
> + * volatile asm. The write functions are not affected since they have memory
> + * clobbers preventing reordering. To prevent reads from being reordered with
> + * respect to writes, use a dummy memory operand.
>   */
> -extern unsigned long __force_order;
> +
> +#define __FORCE_ORDER "m"(*(unsigned int *)0x1000UL)
>  
>  void native_write_cr0(unsigned long val);
>  
>  static inline unsigned long native_read_cr0(void)
>  {
>  	unsigned long val;
> -	asm volatile("mov %%cr0,%0\n\t" : "=r" (val), "=m" (__force_order));
> +	asm volatile("mov %%cr0,%0\n\t" : "=r" (val) : __FORCE_ORDER);
>  	return val;
>  }
>  
>  static __always_inline unsigned long native_read_cr2(void)
>  {
>  	unsigned long val;
> -	asm volatile("mov %%cr2,%0\n\t" : "=r" (val), "=m" (__force_order));
> +	asm volatile("mov %%cr2,%0\n\t" : "=r" (val) : __FORCE_ORDER);
>  	return val;
>  }
>  
>  static __always_inline void native_write_cr2(unsigned long val)
>  {
> -	asm volatile("mov %0,%%cr2": : "r" (val), "m" (__force_order));
> +	asm volatile("mov %0,%%cr2": : "r" (val) : "memory");
>  }
>  
>  static inline unsigned long __native_read_cr3(void)
>  {
>  	unsigned long val;
> -	asm volatile("mov %%cr3,%0\n\t" : "=r" (val), "=m" (__force_order));
> +	asm volatile("mov %%cr3,%0\n\t" : "=r" (val) : __FORCE_ORDER);
>  	return val;
>  }
>  
>  static inline void native_write_cr3(unsigned long val)
>  {
> -	asm volatile("mov %0,%%cr3": : "r" (val), "m" (__force_order));
> +	asm volatile("mov %0,%%cr3": : "r" (val) : "memory");
>  }
>  
>  static inline unsigned long native_read_cr4(void)
> @@ -64,10 +66,10 @@ static inline unsigned long native_read_cr4(void)
>  	asm volatile("1: mov %%cr4, %0\n"
>  		     "2:\n"
>  		     _ASM_EXTABLE(1b, 2b)
> -		     : "=r" (val), "=m" (__force_order) : "0" (0));
> +		     : "=r" (val) : "0" (0), __FORCE_ORDER);
>  #else
>  	/* CR4 always exists on x86_64. */
> -	asm volatile("mov %%cr4,%0\n\t" : "=r" (val), "=m" (__force_order));
> +	asm volatile("mov %%cr4,%0\n\t" : "=r" (val) : __FORCE_ORDER);
>  #endif
>  	return val;
>  }
> diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
> index c5d6f17d9b9d..178499f90366 100644
> --- a/arch/x86/kernel/cpu/common.c
> +++ b/arch/x86/kernel/cpu/common.c
> @@ -359,7 +359,7 @@ void native_write_cr0(unsigned long val)
>  	unsigned long bits_missing = 0;
>  
>  set_register:
> -	asm volatile("mov %0,%%cr0": "+r" (val), "+m" (__force_order));
> +	asm volatile("mov %0,%%cr0": "+r" (val) : : "memory");
>  
>  	if (static_branch_likely(&cr_pinning)) {
>  		if (unlikely((val & X86_CR0_WP) != X86_CR0_WP)) {
> @@ -378,7 +378,7 @@ void native_write_cr4(unsigned long val)
>  	unsigned long bits_changed = 0;
>  
>  set_register:
> -	asm volatile("mov %0,%%cr4": "+r" (val), "+m" (cr4_pinned_bits));
> +	asm volatile("mov %0,%%cr4": "+r" (val) : : "memory");
>  
>  	if (static_branch_likely(&cr_pinning)) {
>  		if (unlikely((val & cr4_pinned_mask) != cr4_pinned_bits)) {
> -- 
> 2.26.2
> 

-- 
Kees Cook
