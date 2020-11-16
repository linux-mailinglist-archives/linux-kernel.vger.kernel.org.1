Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B0002B4C08
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 18:04:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732500AbgKPRCP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 12:02:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:38260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730829AbgKPRCP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 12:02:15 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1948820E65;
        Mon, 16 Nov 2020 17:02:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605546134;
        bh=sQej5KOQVuVF1FvtsQOqqJoHLX7QyI9vTnt1zwijLEs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=C4V1QzVDVvuoBzZjWIkQbSrmIJz5uvHEq9jhSFUQQbP3y82wn9APnOOAX3dq01G85
         e1BFyJ8mb0UPiFWgHjEsCLZxlZO8r3zsFotOqL5KNAIk66OZZ/1hsfvg8yKqpRBgpg
         LoNobQfwHlZXTiCkEU1Bu0q/bi7UnTB2uufji+yE=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id D9EF8411D1; Mon, 16 Nov 2020 14:02:11 -0300 (-03)
Date:   Mon, 16 Nov 2020 14:02:11 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Fangrui Song <maskray@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        Ian Rogers <irogers@google.com>
Subject: Re: [PATCH] perf bench: Update arch/x86/lib/mem{cpy,set}_64.S
Message-ID: <20201116170211.GF509215@kernel.org>
References: <20201104005609.1316230-1-maskray@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201104005609.1316230-1-maskray@google.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Nov 03, 2020 at 04:56:09PM -0800, Fangrui Song escreveu:
> In memset_64.S, the macros expand to `.weak MEMSET ... .globl MEMSET`
> which will produce a STB_WEAK MEMSET with GNU as but STB_GLOBAL MEMSET
> with LLVM's integrated assembler before LLVM 12. LLVM 12 (since
> https://reviews.llvm.org/D90108) will error on such an overridden symbol
> binding. memcpy_64.S is similar.
> 
> Port http://lore.kernel.org/r/20201103012358.168682-1-maskray@google.com
> ("x86_64: Change .weak to SYM_FUNC_START_WEAK for arch/x86/lib/mem*_64.S")
> to fix the issue. Additionally, port SYM_L_WEAK and SYM_FUNC_START_WEAK
> from include/linux/linkage.h to tools/perf/util/include/linux/linkage.h

Sorry, I noticed this just now and I have done this update already, will
send to Linus soon.

- Arnaldo
 
> Fixes: 7d7d1bf1d1da ("perf bench: Copy kernel files needed to build mem{cpy,set} x86_64 benchmarks")
> Link: https://lore.kernel.org/r/20201103012358.168682-1-maskray@google.com
> Signed-off-by: Fangrui Song <maskray@google.com>
> ---
>  tools/arch/x86/lib/memcpy_64.S          | 4 +---
>  tools/arch/x86/lib/memset_64.S          | 4 +---
>  tools/perf/util/include/linux/linkage.h | 7 +++++++
>  3 files changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/arch/x86/lib/memcpy_64.S b/tools/arch/x86/lib/memcpy_64.S
> index 0b5b8ae56bd9..9428f251df0f 100644
> --- a/tools/arch/x86/lib/memcpy_64.S
> +++ b/tools/arch/x86/lib/memcpy_64.S
> @@ -16,8 +16,6 @@
>   * to a jmp to memcpy_erms which does the REP; MOVSB mem copy.
>   */
>  
> -.weak memcpy
> -
>  /*
>   * memcpy - Copy a memory block.
>   *
> @@ -30,7 +28,7 @@
>   * rax original destination
>   */
>  SYM_FUNC_START_ALIAS(__memcpy)
> -SYM_FUNC_START_LOCAL(memcpy)
> +SYM_FUNC_START_WEAK(memcpy)
>  	ALTERNATIVE_2 "jmp memcpy_orig", "", X86_FEATURE_REP_GOOD, \
>  		      "jmp memcpy_erms", X86_FEATURE_ERMS
>  
> diff --git a/tools/arch/x86/lib/memset_64.S b/tools/arch/x86/lib/memset_64.S
> index fd5d25a474b7..1f9b11f9244d 100644
> --- a/tools/arch/x86/lib/memset_64.S
> +++ b/tools/arch/x86/lib/memset_64.S
> @@ -5,8 +5,6 @@
>  #include <asm/cpufeatures.h>
>  #include <asm/alternative-asm.h>
>  
> -.weak memset
> -
>  /*
>   * ISO C memset - set a memory block to a byte value. This function uses fast
>   * string to get better performance than the original function. The code is
> @@ -18,7 +16,7 @@
>   *
>   * rax   original destination
>   */
> -SYM_FUNC_START_ALIAS(memset)
> +SYM_FUNC_START_WEAK(memset)
>  SYM_FUNC_START(__memset)
>  	/*
>  	 * Some CPUs support enhanced REP MOVSB/STOSB feature. It is recommended
> diff --git a/tools/perf/util/include/linux/linkage.h b/tools/perf/util/include/linux/linkage.h
> index b8a5159361b4..0e493bf3151b 100644
> --- a/tools/perf/util/include/linux/linkage.h
> +++ b/tools/perf/util/include/linux/linkage.h
> @@ -25,6 +25,7 @@
>  
>  /* SYM_L_* -- linkage of symbols */
>  #define SYM_L_GLOBAL(name)			.globl name
> +#define SYM_L_WEAK(name)			.weak name
>  #define SYM_L_LOCAL(name)			/* nothing */
>  
>  #define ALIGN __ALIGN
> @@ -78,6 +79,12 @@
>  	SYM_START(name, SYM_L_LOCAL, SYM_A_ALIGN)
>  #endif
>  
> +/* SYM_FUNC_START_WEAK -- use for weak functions */
> +#ifndef SYM_FUNC_START_WEAK
> +#define SYM_FUNC_START_WEAK(name)			\
> +	SYM_START(name, SYM_L_WEAK, SYM_A_ALIGN)
> +#endif
> +
>  /* SYM_FUNC_END_ALIAS -- the end of LOCAL_ALIASed or ALIASed function */
>  #ifndef SYM_FUNC_END_ALIAS
>  #define SYM_FUNC_END_ALIAS(name)			\
> -- 
> 2.29.1.341.ge80a0c044ae-goog
> 

-- 

- Arnaldo
