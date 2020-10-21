Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49F48295316
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 21:47:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408259AbgJUTrB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 15:47:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406677AbgJUTrA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 15:47:00 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D5A8C0613CE
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 12:47:00 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id bh6so1195712plb.5
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 12:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=d/NkYNlV7YyPAwyamSxhvGsJXxfXBxApaHqL2+qSD24=;
        b=NvPfieXtCX+MTiWeHiL5kh11lW41JEKRpcnDab5OhcbjPq0lSLQL6Z+FLdn+vV1bsP
         COYIXTQjVPCIIgkeVUlsLSSQiu7XIlMQDnGPetkJkYYFUsqGgLlOZQ7dCKPbWGg1a/Ir
         GBzWv1Fg3L0yTDcYoiatleoCMKlNGHNDf9GN4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=d/NkYNlV7YyPAwyamSxhvGsJXxfXBxApaHqL2+qSD24=;
        b=ggkXP+JI0sjS+sx+dhozFrTSiEkWz1h/ypVbe+A96jiXX7nvOUV7c+l6WUtC9jVx5U
         DJT+GiWa5B5GfkdBfzacxP0Y98X0ILG1279HnIU56QyvpBSSp4ilOzpEug/tBXx0ANCw
         cWcHHyx1Yzbq5AETo3lR3Nnw9TZo9aj7DFeFUQgzu3rpJRya5eN3JYhUhdX/dcu4Qe1E
         /segSu6KT8NjOPXFMD6h6bmv5+NRwg1EjBoFRxuNdVMm6tTFWGcQnveV7MQyN6Nli4iX
         v2xQiZPIpD5shkvAS56D6me2H2+rsQqv0jJlRnWrKqt6qQqRp6RDE9JKv4e3GzfqviFO
         vjMQ==
X-Gm-Message-State: AOAM532l1oiS2TTsN3jHPaEHRwYiLConYyDAX65afnMyB2t1YaTmXQ9a
        JnVg8MltQliyaZLXg4wSMG//8A==
X-Google-Smtp-Source: ABdhPJy9yYZ/tBP5IqmNWbG7c2JjScUrkgBV+GF0kADA7BPfWMnb33H5I2GuWk6UordSlv2qK5vb7w==
X-Received: by 2002:a17:902:b18f:b029:d5:e3d3:9b87 with SMTP id s15-20020a170902b18fb02900d5e3d39b87mr5472545plr.78.1603309619481;
        Wed, 21 Oct 2020 12:46:59 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id s77sm3029324pfc.164.2020.10.21.12.46.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2020 12:46:58 -0700 (PDT)
Date:   Wed, 21 Oct 2020 12:46:57 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] compiler.h: Fix barrier_data() on clang
Message-ID: <202010211239.2A67F44BB@keescook>
References: <20201014212631.207844-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201014212631.207844-1-nivedita@alum.mit.edu>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 14, 2020 at 05:26:31PM -0400, Arvind Sankar wrote:
> Commit
>   815f0ddb346c ("include/linux/compiler*.h: make compiler-*.h mutually exclusive")
> 
> neglected to copy barrier_data() from compiler-gcc.h into
> compiler-clang.h. The definition in compiler-gcc.h was really to work
> around clang's more aggressive optimization, so this broke
> barrier_data() on clang, and consequently memzero_explicit() as well.
> 
> For example, this results in at least the memzero_explicit() call in
> lib/crypto/sha256.c:sha256_transform() being optimized away by clang.
> 
> Fix this by moving the definition of barrier_data() into compiler.h.
> 
> Also move the gcc/clang definition of barrier() into compiler.h,
> __memory_barrier() is icc-specific (and barrier() is already defined
> using it in compiler-intel.h) and doesn't belong in compiler.h.
> 
> Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
> Fixes: 815f0ddb346c ("include/linux/compiler*.h: make compiler-*.h mutually exclusive")

Yeowch.

Cc: stable@vger.kernel.org
Reviewed-by: Kees Cook <keescook@chromium.org>

Nick just mentioned this to me; I hadn't had a chance to read it yet. This
needs to go to Linus ASAP; memzero_explicit() under Clang in v4.19 and
later isn't so explicit. :(

Andrew, Linus, can one of you pick this up please?

As Nick mentioned, sorting out the specifics of the comments[1] can
come later.

[1] https://lore.kernel.org/lkml/CAKwvOdkLvxeYeBh7Kx0gw7JPktPH8A4DomJTidUqA0jRQTR0FA@mail.gmail.com/

> ---
>  include/linux/compiler-clang.h |  6 ------
>  include/linux/compiler-gcc.h   | 19 -------------------
>  include/linux/compiler.h       | 18 ++++++++++++++++--
>  3 files changed, 16 insertions(+), 27 deletions(-)
> 
> diff --git a/include/linux/compiler-clang.h b/include/linux/compiler-clang.h
> index cee0c728d39a..04c0a5a717f7 100644
> --- a/include/linux/compiler-clang.h
> +++ b/include/linux/compiler-clang.h
> @@ -52,12 +52,6 @@
>  #define COMPILER_HAS_GENERIC_BUILTIN_OVERFLOW 1
>  #endif
>  
> -/* The following are for compatibility with GCC, from compiler-gcc.h,
> - * and may be redefined here because they should not be shared with other
> - * compilers, like ICC.
> - */
> -#define barrier() __asm__ __volatile__("" : : : "memory")
> -
>  #if __has_feature(shadow_call_stack)
>  # define __noscs	__attribute__((__no_sanitize__("shadow-call-stack")))
>  #endif
> diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
> index 7a3769040d7d..fda30ffb037b 100644
> --- a/include/linux/compiler-gcc.h
> +++ b/include/linux/compiler-gcc.h
> @@ -15,25 +15,6 @@
>  # error Sorry, your compiler is too old - please upgrade it.
>  #endif
>  
> -/* Optimization barrier */
> -
> -/* The "volatile" is due to gcc bugs */
> -#define barrier() __asm__ __volatile__("": : :"memory")
> -/*
> - * This version is i.e. to prevent dead stores elimination on @ptr
> - * where gcc and llvm may behave differently when otherwise using
> - * normal barrier(): while gcc behavior gets along with a normal
> - * barrier(), llvm needs an explicit input variable to be assumed
> - * clobbered. The issue is as follows: while the inline asm might
> - * access any memory it wants, the compiler could have fit all of
> - * @ptr into memory registers instead, and since @ptr never escaped
> - * from that, it proved that the inline asm wasn't touching any of
> - * it. This version works well with both compilers, i.e. we're telling
> - * the compiler that the inline asm absolutely may see the contents
> - * of @ptr. See also: https://llvm.org/bugs/show_bug.cgi?id=15495
> - */
> -#define barrier_data(ptr) __asm__ __volatile__("": :"r"(ptr) :"memory")
> -
>  /*
>   * This macro obfuscates arithmetic on a variable address so that gcc
>   * shouldn't recognize the original var, and make assumptions about it.
> diff --git a/include/linux/compiler.h b/include/linux/compiler.h
> index 92ef163a7479..dfba70b2644f 100644
> --- a/include/linux/compiler.h
> +++ b/include/linux/compiler.h
> @@ -80,11 +80,25 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
>  
>  /* Optimization barrier */
>  #ifndef barrier
> -# define barrier() __memory_barrier()
> +/* The "volatile" is due to gcc bugs */
> +# define barrier() __asm__ __volatile__("": : :"memory")
>  #endif
>  
>  #ifndef barrier_data
> -# define barrier_data(ptr) barrier()
> +/*
> + * This version is i.e. to prevent dead stores elimination on @ptr
> + * where gcc and llvm may behave differently when otherwise using
> + * normal barrier(): while gcc behavior gets along with a normal
> + * barrier(), llvm needs an explicit input variable to be assumed
> + * clobbered. The issue is as follows: while the inline asm might
> + * access any memory it wants, the compiler could have fit all of
> + * @ptr into memory registers instead, and since @ptr never escaped
> + * from that, it proved that the inline asm wasn't touching any of
> + * it. This version works well with both compilers, i.e. we're telling
> + * the compiler that the inline asm absolutely may see the contents
> + * of @ptr. See also: https://llvm.org/bugs/show_bug.cgi?id=15495
> + */
> +# define barrier_data(ptr) __asm__ __volatile__("": :"r"(ptr) :"memory")
>  #endif
>  
>  /* workaround for GCC PR82365 if needed */
> -- 
> 2.26.2
> 

-- 
Kees Cook
