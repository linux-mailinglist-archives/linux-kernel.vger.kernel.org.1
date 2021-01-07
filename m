Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F031E2EE758
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 22:01:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727290AbhAGVBa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 16:01:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726526AbhAGVB3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 16:01:29 -0500
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48E72C0612F5
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jan 2021 13:00:49 -0800 (PST)
Received: by mail-qv1-xf2f.google.com with SMTP id l7so3434089qvt.4
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jan 2021 13:00:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=unMrV0zhpUV0GILjeHwsieeOs0TVSvZbf5iDIce41oA=;
        b=i9CtxiGDp+wHb2ljojX8tVLU7TiZzkGUoVuKBFFqh76jhoGQB7ZziS4raB857oOLlu
         ls1hlhm4z0r2Yu3sAioXg6jkPzMxcXQX79j63Yo5kOh/gN9yX3GZtFRU7FbPEI1tsVrl
         YoAavsWjTCXbCxJDaGLOefWs8Kv/qs2ue5Uoh15UO6VR+kUJ/h9YH4mUNEtre/9eYOVR
         6VCnoaBThTNvECxaHCmB+trOL4LbdUNaO1zDTG5CaalOk9i5ww16KJIlFWpOOPBbHNSb
         O0Qv0cAVEYYKarc4YdywcAAR/O5sc/EC8fUSyq64fUIHdK274iTp7wZIfGLWS+DsBnNM
         yJeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=unMrV0zhpUV0GILjeHwsieeOs0TVSvZbf5iDIce41oA=;
        b=SbtBxqMRJeMhj0Np87S0OyirPYeuNYJ8CiNnWPOkDRplHGfbGRduttCG3A3ICPFwCy
         au0KwG6Tvwf9941a9PC8YlfXOUzFA0KZg0BNWttU6ibu0bYR8OFmlGOocS/T0y0VI8Do
         wD1fiACM4e8k7jZWqqI1pmuDO4k0Z9RC3VUXWLtq6BUg9U/JdFSAwdOeu64ADOuiM+9M
         SEhwiVhnMTCgRAExshmyzbnJx/wbS5TP5n0orpwtE0UjGmIGlT2wwX+MPowmzspvHtNo
         s5DU6fbkU0P5RRLlhYI6XL77RTOSrqWjHVXwmBITUQeqvF8p4/mmyGA4jDKrAmSc2zAU
         AHng==
X-Gm-Message-State: AOAM531yKKh0N3ZjiANffa+HViXMF4N8NDXYmbcMIpyP79ZDBq72om0I
        XeMqoZbNozmXBiUFse1TM5A=
X-Google-Smtp-Source: ABdhPJwmSKq2k01h2aQbm0/qCF1bOAHZ//H9xdf6+hI7eCl4LGGvWkZI/IAVMKJriVoxqfiL+cqaHg==
X-Received: by 2002:a0c:d403:: with SMTP id t3mr3799962qvh.4.1610053248333;
        Thu, 07 Jan 2021 13:00:48 -0800 (PST)
Received: from ubuntu-m3-large-x86 ([2604:1380:45f1:1d00::1])
        by smtp.gmail.com with ESMTPSA id a203sm3885880qkb.31.2021.01.07.13.00.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jan 2021 13:00:47 -0800 (PST)
Date:   Thu, 7 Jan 2021 14:00:45 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Walter Wu <walter-zh.wu@mediatek.com>
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        wsd_upstream <wsd_upstream@mediatek.com>,
        linux-mediatek@lists.infradead.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH] kasan: remove redundant config option
Message-ID: <20210107210045.GA1456581@ubuntu-m3-large-x86>
References: <20210107062152.2015-1-walter-zh.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210107062152.2015-1-walter-zh.wu@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 07, 2021 at 02:21:52PM +0800, Walter Wu wrote:
> CONFIG_KASAN_STACK and CONFIG_KASAN_STACK_ENABLE both enable KASAN
> stack instrumentation, but we should only need one config option,
> so that we remove CONFIG_KASAN_STACK_ENABLE. see [1].
> 
> For gcc we could do no prompt and default value y, and for clang
> prompt and default value n.
> 
> [1]: https://bugzilla.kernel.org/show_bug.cgi?id=210221
> 
> Signed-off-by: Walter Wu <walter-zh.wu@mediatek.com>
> Suggested-by: Dmitry Vyukov <dvyukov@google.com>
> Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
> Cc: Dmitry Vyukov <dvyukov@google.com>
> Cc: Andrey Konovalov <andreyknvl@google.com>
> Cc: Alexander Potapenko <glider@google.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> ---
>  arch/arm64/kernel/sleep.S        |  2 +-
>  arch/x86/kernel/acpi/wakeup_64.S |  2 +-
>  include/linux/kasan.h            |  2 +-
>  lib/Kconfig.kasan                | 11 ++++-------
>  mm/kasan/common.c                |  2 +-
>  mm/kasan/kasan.h                 |  2 +-
>  mm/kasan/report_generic.c        |  2 +-
>  scripts/Makefile.kasan           | 10 ++++++++--
>  8 files changed, 18 insertions(+), 15 deletions(-)
> 
> diff --git a/arch/arm64/kernel/sleep.S b/arch/arm64/kernel/sleep.S
> index 6bdef7362c0e..7c44ede122a9 100644
> --- a/arch/arm64/kernel/sleep.S
> +++ b/arch/arm64/kernel/sleep.S
> @@ -133,7 +133,7 @@ SYM_FUNC_START(_cpu_resume)
>  	 */
>  	bl	cpu_do_resume
>  
> -#if defined(CONFIG_KASAN) && CONFIG_KASAN_STACK
> +#if defined(CONFIG_KASAN) && defined(CONFIG_KASAN_STACK)
>  	mov	x0, sp
>  	bl	kasan_unpoison_task_stack_below
>  #endif
> diff --git a/arch/x86/kernel/acpi/wakeup_64.S b/arch/x86/kernel/acpi/wakeup_64.S
> index 5d3a0b8fd379..c7f412f4e07d 100644
> --- a/arch/x86/kernel/acpi/wakeup_64.S
> +++ b/arch/x86/kernel/acpi/wakeup_64.S
> @@ -112,7 +112,7 @@ SYM_FUNC_START(do_suspend_lowlevel)
>  	movq	pt_regs_r14(%rax), %r14
>  	movq	pt_regs_r15(%rax), %r15
>  
> -#if defined(CONFIG_KASAN) && CONFIG_KASAN_STACK
> +#if defined(CONFIG_KASAN) && defined(CONFIG_KASAN_STACK)
>  	/*
>  	 * The suspend path may have poisoned some areas deeper in the stack,
>  	 * which we now need to unpoison.
> diff --git a/include/linux/kasan.h b/include/linux/kasan.h
> index 5e0655fb2a6f..35d1e9b2cbfa 100644
> --- a/include/linux/kasan.h
> +++ b/include/linux/kasan.h
> @@ -302,7 +302,7 @@ static inline void kasan_kfree_large(void *ptr, unsigned long ip) {}
>  
>  #endif /* CONFIG_KASAN */
>  
> -#if defined(CONFIG_KASAN) && CONFIG_KASAN_STACK
> +#if defined(CONFIG_KASAN) && defined(CONFIG_KASAN_STACK)
>  void kasan_unpoison_task_stack(struct task_struct *task);
>  #else
>  static inline void kasan_unpoison_task_stack(struct task_struct *task) {}
> diff --git a/lib/Kconfig.kasan b/lib/Kconfig.kasan
> index f5fa4ba126bf..59de74293454 100644
> --- a/lib/Kconfig.kasan
> +++ b/lib/Kconfig.kasan
> @@ -138,9 +138,11 @@ config KASAN_INLINE
>  
>  endchoice
>  
> -config KASAN_STACK_ENABLE
> -	bool "Enable stack instrumentation (unsafe)" if CC_IS_CLANG && !COMPILE_TEST

You are effectively undoing commits 6baec880d7a5 ("kasan: turn off
asan-stack for clang-8 and earlier") and ebb6d35a74ce ("kasan: remove
clang version check for KASAN_STACK") with this change. This change
should still remain around so that all{mod,yes}config remain mostly
clean for clang builds. This should not change anything from the user's
perspective because this option was never user selectable for GCC and
the default y keeps it on.

> +config KASAN_STACK
> +	bool "Enable stack instrumentation (unsafe)"
>  	depends on KASAN_GENERIC || KASAN_SW_TAGS
> +	default y if CC_IS_GCC
> +	default n if CC_IS_CLANG

This is implied and can be removed.

>  	help
>  	  The LLVM stack address sanitizer has a know problem that
>  	  causes excessive stack usage in a lot of functions, see
> @@ -154,11 +156,6 @@ config KASAN_STACK_ENABLE
>  	  CONFIG_COMPILE_TEST.	On gcc it is assumed to always be safe
>  	  to use and enabled by default.
>  
> -config KASAN_STACK
> -	int
> -	default 1 if KASAN_STACK_ENABLE || CC_IS_GCC
> -	default 0
> -
>  config KASAN_SW_TAGS_IDENTIFY
>  	bool "Enable memory corruption identification"
>  	depends on KASAN_SW_TAGS
> diff --git a/mm/kasan/common.c b/mm/kasan/common.c
> index 38ba2aecd8f4..02ec7f81dc16 100644
> --- a/mm/kasan/common.c
> +++ b/mm/kasan/common.c
> @@ -63,7 +63,7 @@ void __kasan_unpoison_range(const void *address, size_t size)
>  	unpoison_range(address, size);
>  }
>  
> -#if CONFIG_KASAN_STACK
> +#if defined(CONFIG_KASAN_STACK)

Isn't '#ifdef CONFIG_...' preferred for CONFIG symbols?

>  /* Unpoison the entire stack for a task. */
>  void kasan_unpoison_task_stack(struct task_struct *task)
>  {
> diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
> index cc4d9e1d49b1..bdfdb1cff653 100644
> --- a/mm/kasan/kasan.h
> +++ b/mm/kasan/kasan.h
> @@ -224,7 +224,7 @@ void *find_first_bad_addr(void *addr, size_t size);
>  const char *get_bug_type(struct kasan_access_info *info);
>  void metadata_fetch_row(char *buffer, void *row);
>  
> -#if defined(CONFIG_KASAN_GENERIC) && CONFIG_KASAN_STACK
> +#if defined(CONFIG_KASAN_GENERIC) && defined(CONFIG_KASAN_STACK)
>  void print_address_stack_frame(const void *addr);
>  #else
>  static inline void print_address_stack_frame(const void *addr) { }
> diff --git a/mm/kasan/report_generic.c b/mm/kasan/report_generic.c
> index 8a9c889872da..137a1dba1978 100644
> --- a/mm/kasan/report_generic.c
> +++ b/mm/kasan/report_generic.c
> @@ -128,7 +128,7 @@ void metadata_fetch_row(char *buffer, void *row)
>  	memcpy(buffer, kasan_mem_to_shadow(row), META_BYTES_PER_ROW);
>  }
>  
> -#if CONFIG_KASAN_STACK
> +#if defined(CONFIG_KASAN_STACK)
>  static bool __must_check tokenize_frame_descr(const char **frame_descr,
>  					      char *token, size_t max_tok_len,
>  					      unsigned long *value)
> diff --git a/scripts/Makefile.kasan b/scripts/Makefile.kasan
> index 1e000cc2e7b4..abf231d209b1 100644
> --- a/scripts/Makefile.kasan
> +++ b/scripts/Makefile.kasan
> @@ -2,6 +2,12 @@
>  CFLAGS_KASAN_NOSANITIZE := -fno-builtin
>  KASAN_SHADOW_OFFSET ?= $(CONFIG_KASAN_SHADOW_OFFSET)
>  
> +ifdef CONFIG_KASAN_STACK
> +	stack_enable := 1
> +else
> +	stack_enable := 0
> +endif
> +
>  ifdef CONFIG_KASAN_GENERIC
>  
>  ifdef CONFIG_KASAN_INLINE
> @@ -27,7 +33,7 @@ else
>  	CFLAGS_KASAN := $(CFLAGS_KASAN_SHADOW) \
>  	 $(call cc-param,asan-globals=1) \
>  	 $(call cc-param,asan-instrumentation-with-call-threshold=$(call_threshold)) \
> -	 $(call cc-param,asan-stack=$(CONFIG_KASAN_STACK)) \
> +	 $(call cc-param,asan-stack=$(stack_enable)) \
>  	 $(call cc-param,asan-instrument-allocas=1)
>  endif
>  
> @@ -42,7 +48,7 @@ else
>  endif
>  
>  CFLAGS_KASAN := -fsanitize=kernel-hwaddress \
> -		-mllvm -hwasan-instrument-stack=$(CONFIG_KASAN_STACK) \
> +		-mllvm -hwasan-instrument-stack=$(stack_enable) \
>  		-mllvm -hwasan-use-short-granules=0 \
>  		$(instrumentation_flags)
>  
> -- 
> 2.18.0
> 
