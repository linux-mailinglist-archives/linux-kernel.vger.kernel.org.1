Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5909A26FC8E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 14:33:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726611AbgIRMc5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 08:32:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726591AbgIRMc5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 08:32:57 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 389F4C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 05:32:57 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id x23so5157372wmi.3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 05:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RW3V/7rc9G+S8I7/pZacY9c5WPGbtuzmcvpRc7I+JUM=;
        b=qL4mSxuDrjxuRYOar00dO1llfZRNDUcbTJ+/hSLVke3o6xiH7pVYcSfkiPPz/iDCQj
         l12QmAeXWvomNGmyC3CHANnT6m9SElltT62xCfL4suFvVzeV3cUcQj1M+T2/NaQWS7ZR
         /JaufTMWmgCfVgZoGx95s2ud/f4/+U9kn3GjJqPWKaH9wkmZEeTiGEB0RI6xjrn/EsE+
         Yj2qNtIBoCjtMhG6ttNdV9JvO0xRSG51NU3/BfNsydJZD5WiEGfFB1KSiynHytnIJ1aB
         ZohPnzKOsUnnel3D+zfJAaSHxfxFNLe3B6DuOyRrbRy8UD1BPC684QynexNY8tSqwzjP
         TOtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RW3V/7rc9G+S8I7/pZacY9c5WPGbtuzmcvpRc7I+JUM=;
        b=Ab0XRAMiEmXjtHvYvDZVsPZiu9M0CbUZkNJvw0U30BlrxRov8lsA3W4cA2tp1kbxk/
         2+wXymbClYrbA7O+gN9B1tPeVY+3QR36qeXqXJmxD8DLwD/Sx+Ocib/KS5rd88AvpX/z
         BoOD+E34gdbAxkWirXVs0VxdHaM4FN+5fblw6QueISLzB5EMyg7/ffP9cn6KhcBloVoB
         18B8qSADQpftKqWpBU6T1SpNYLz/gfLgcWc74hJXuL2IaJ+HQZdL5zOQmnyGEHSnYZJy
         2VeMXEXWsHr+U6N4Q9grk8SJWRE7St38ONLKlqnBmFK/ABArJR7b5LBaDG176i8ztujg
         hxeQ==
X-Gm-Message-State: AOAM533ipz/EgOaeaWf5+HQgWKNxfV6PGcJQqhIlq1S4HzqEuAg5d9V/
        CQlj/15jXCtCKTszvYuwPj9gaQ==
X-Google-Smtp-Source: ABdhPJwA5eQZZD6nEWS4rNGk9gnrwEW+ecPPQhkI9OE6L5VW71FW34+0vWngW8ufMpLjmVkcOjollw==
X-Received: by 2002:a1c:7e15:: with SMTP id z21mr15195514wmc.21.1600432375666;
        Fri, 18 Sep 2020 05:32:55 -0700 (PDT)
Received: from elver.google.com ([100.105.32.75])
        by smtp.gmail.com with ESMTPSA id y6sm4995614wrt.80.2020.09.18.05.32.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2020 05:32:54 -0700 (PDT)
Date:   Fri, 18 Sep 2020 14:32:49 +0200
From:   Marco Elver <elver@google.com>
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        kasan-dev@googlegroups.com,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Elena Petrova <lenaptr@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 21/37] kasan: introduce CONFIG_KASAN_HW_TAGS
Message-ID: <20200918123249.GC2384246@elver.google.com>
References: <cover.1600204505.git.andreyknvl@google.com>
 <329ece34759c5208ae32a126dc5c978695ab1776.1600204505.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <329ece34759c5208ae32a126dc5c978695ab1776.1600204505.git.andreyknvl@google.com>
User-Agent: Mutt/1.14.4 (2020-06-18)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 15, 2020 at 11:16PM +0200, Andrey Konovalov wrote:
> This patch adds a configuration option for a new KASAN mode called
> hardware tag-based KASAN. This mode uses the memory tagging approach
> like the software tag-based mode, but relies on arm64 Memory Tagging
> Extension feature for tag management and access checking.
> 
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> ---
> Change-Id: I246c2def9fffa6563278db1bddfbe742ca7bdefe
> ---
>  lib/Kconfig.kasan | 56 +++++++++++++++++++++++++++++++++--------------
>  1 file changed, 39 insertions(+), 17 deletions(-)
> 
> diff --git a/lib/Kconfig.kasan b/lib/Kconfig.kasan
> index b4cf6c519d71..17c9ecfaecb9 100644
> --- a/lib/Kconfig.kasan
> +++ b/lib/Kconfig.kasan
> @@ -6,7 +6,10 @@ config HAVE_ARCH_KASAN
>  config HAVE_ARCH_KASAN_SW_TAGS
>  	bool
>  
> -config	HAVE_ARCH_KASAN_VMALLOC
> +config HAVE_ARCH_KASAN_HW_TAGS
> +	bool
> +
> +config HAVE_ARCH_KASAN_VMALLOC
>  	bool
>  
>  config CC_HAS_KASAN_GENERIC
> @@ -20,10 +23,11 @@ config CC_HAS_WORKING_NOSANITIZE_ADDRESS
>  
>  menuconfig KASAN
>  	bool "KASAN: runtime memory debugger"
> -	depends on (HAVE_ARCH_KASAN && CC_HAS_KASAN_GENERIC) || \
> -		   (HAVE_ARCH_KASAN_SW_TAGS && CC_HAS_KASAN_SW_TAGS)
> +	depends on (((HAVE_ARCH_KASAN && CC_HAS_KASAN_GENERIC) || \
> +		     (HAVE_ARCH_KASAN_SW_TAGS && CC_HAS_KASAN_SW_TAGS)) && \
> +		    CC_HAS_WORKING_NOSANITIZE_ADDRESS) || \
> +		   HAVE_ARCH_KASAN_HW_TAGS
>  	depends on (SLUB && SYSFS) || (SLAB && !DEBUG_SLAB)
> -	depends on CC_HAS_WORKING_NOSANITIZE_ADDRESS
>  	select SLUB_DEBUG if SLUB

Is SLUB_DEBUG necessary with HW_TAGS?

>  	select CONSTRUCTORS
>  	select STACKDEPOT
> @@ -38,13 +42,18 @@ choice
>  	prompt "KASAN mode"
>  	default KASAN_GENERIC
>  	help
> -	  KASAN has two modes: generic KASAN (similar to userspace ASan,
> -	  x86_64/arm64/xtensa, enabled with CONFIG_KASAN_GENERIC) and
> -	  software tag-based KASAN (a version based on software memory
> -	  tagging, arm64 only, similar to userspace HWASan, enabled with
> -	  CONFIG_KASAN_SW_TAGS).
> +	  KASAN has three modes:
> +	  1. generic KASAN (similar to userspace ASan,
> +	     x86_64/arm64/xtensa, enabled with CONFIG_KASAN_GENERIC),
> +	  2. software tag-based KASAN (arm64 only, based on software
> +	     memory tagging (similar to userspace HWASan), enabled with
> +	     CONFIG_KASAN_SW_TAGS), and
> +	  3. hardware tag-based KASAN (arm64 only, based on hardware
> +	     memory tagging, enabled with CONFIG_KASAN_HW_TAGS).
>  
> -	  Both generic and tag-based KASAN are strictly debugging features.
> +	  All KASAN modes are strictly debugging features.
> +
> +	  For better error detection enable CONFIG_STACKTRACE.

I don't think CONFIG_STACKTRACE improves error detection, right? It only
makes the reports more readable

>  
>  config KASAN_GENERIC
>  	bool "Generic mode"
> @@ -61,8 +70,6 @@ config KASAN_GENERIC
>  	  and introduces an overhead of ~x1.5 for the rest of the allocations.
>  	  The performance slowdown is ~x3.
>  
> -	  For better error detection enable CONFIG_STACKTRACE.
> -
>  	  Currently CONFIG_KASAN_GENERIC doesn't work with CONFIG_DEBUG_SLAB
>  	  (the resulting kernel does not boot).
>  
> @@ -72,9 +79,11 @@ config KASAN_SW_TAGS
>  	help
>  	  Enables software tag-based KASAN mode.
>  
> -	  This mode requires Top Byte Ignore support by the CPU and therefore
> -	  is only supported for arm64. This mode requires Clang version 7.0.0
> -	  or later.
> +	  This mode require software memory tagging support in the form of
> +	  HWASan-like compiler instrumentation.
> +
> +	  Currently this mode is only implemented for arm64 CPUs and relies on
> +	  Top Byte Ignore. This mode requires Clang version 7.0.0 or later.
>  
>  	  This mode consumes about 1/16th of available memory at kernel start
>  	  and introduces an overhead of ~20% for the rest of the allocations.
> @@ -82,15 +91,27 @@ config KASAN_SW_TAGS
>  	  casting and comparison, as it embeds tags into the top byte of each
>  	  pointer.
>  
> -	  For better error detection enable CONFIG_STACKTRACE.
> -
>  	  Currently CONFIG_KASAN_SW_TAGS doesn't work with CONFIG_DEBUG_SLAB
>  	  (the resulting kernel does not boot).
>  
> +config KASAN_HW_TAGS
> +	bool "Hardware tag-based mode"
> +	depends on HAVE_ARCH_KASAN_HW_TAGS
> +	depends on SLUB
> +	help
> +	  Enables hardware tag-based KASAN mode.
> +
> +	  This mode requires hardware memory tagging support, and can be used
> +	  by any architecture that provides it.
> +
> +	  Currently this mode is only implemented for arm64 CPUs starting from
> +	  ARMv8.5 and relies on Memory Tagging Extension and Top Byte Ignore.
> +
>  endchoice
>  
>  choice
>  	prompt "Instrumentation type"
> +	depends on KASAN_GENERIC || KASAN_SW_TAGS
>  	default KASAN_OUTLINE
>  
>  config KASAN_OUTLINE
> @@ -114,6 +135,7 @@ endchoice
>  
>  config KASAN_STACK_ENABLE
>  	bool "Enable stack instrumentation (unsafe)" if CC_IS_CLANG && !COMPILE_TEST
> +	depends on KASAN_GENERIC || KASAN_SW_TAGS
>  	help
>  	  The LLVM stack address sanitizer has a know problem that
>  	  causes excessive stack usage in a lot of functions, see

How about something like the below change (introduce KASAN_INSTRUMENTED
Kconfig var) to avoid the repeated "KASAN_GENERIC || KASAN_SW_TAGS".
This could then also be used in the various .c/.h files (and make some
of the code more readable hopefully).

+config KASAN_INSTRUMENTED
+	def_bool KASAN_GENERIC || KASAN_SW_TAGS
+
 choice
 	prompt "Instrumentation type"
-	depends on KASAN_GENERIC || KASAN_SW_TAGS
+	depends on KASAN_INSTRUMENTED
 	default KASAN_OUTLINE
 
 config KASAN_OUTLINE
@@ -135,7 +141,7 @@ endchoice
 
 config KASAN_STACK_ENABLE
 	bool "Enable stack instrumentation (unsafe)" if CC_IS_CLANG && !COMPILE_TEST
-	depends on KASAN_GENERIC || KASAN_SW_TAGS
+	depends on KASAN_INSTRUMENTED
 	help
 	  The LLVM stack address sanitizer has a know problem that
 	  causes excessive stack usage in a lot of functions, see

Thanks,
-- Marco
