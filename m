Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D01C28E9E5
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 03:20:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732037AbgJOBUf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 21:20:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387912AbgJOBTh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 21:19:37 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05D56C05BD3D
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 15:51:44 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id l18so594616pgg.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 15:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m1RlPQ41pOi2BLMFnH+YdlsJUL1/xTYXwZ0zleFqEx8=;
        b=qGuXJ+TKiPG3WezuhHvwuuGL361GiKPR1jE1wcYojdVFuJSAZ9l/4JfZHGI7ARLlnX
         zupHy55SxbCEgZp+b2kGG8EU/IkIpF4iP64ipaJE/1eWAhs+gjs3Dy/UpfEle/yyOsdr
         lVCO2+5Bws5XvCX8BrzCPhXZCt9I/LbutrFIxS37eMCSyFX1pOj+jyweeW9U5Ib7Meb8
         ROu1ulJZm09AAgRMiYTGUqpB9jtVEV19+mqYiaeI2iFSDlrcl/zBp5HHXSD3hjMUZ+W+
         u9QLkShoYqOM8F4jENcFiAJ33XokwXy/Dl8WpqrjaRgrCHcSMm8Fy6FAY5bx5i2CHXO3
         exyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m1RlPQ41pOi2BLMFnH+YdlsJUL1/xTYXwZ0zleFqEx8=;
        b=uSkkrlzjT/6vXDn7VzWsfOxzP7XyqkDlaupQlNyETNOXy3si64RYi0ZdxGEOyLYWwe
         mq7qEaNpI6p7m4C7sgIqO+JOYB9eOXGXTC+dEzN7GdE2UyDMbOQgR5LBRtwzYpM34qdq
         TAeKtX6TVuU3eFYN3Vspm8gDqQYQnbtdWhlOmAa0YUQhYZZNejv8P5R6iL4m3IKcomCG
         vwRcZOzWSMczS0Z2t4/x5jtdG7TKTtFnr1K9+34kHEvje1ai+5jGCeS+nlXfJvlZeQ2l
         fexewfs0UP1rfKnB4zBduQ2JGwjsN0pQVZ/ar7H270oKVjMWAXi0SoU2Flqj7AqO6H8B
         OmAw==
X-Gm-Message-State: AOAM532JzLgXdOqbbOE0P1yVi/4d6gxfZX/i7mRVZiFaEn3vNQW45/Kk
        L7IBuB/ii123hKc8NTWo6O/15uK9dpJf9skOZAXNpw==
X-Google-Smtp-Source: ABdhPJyQ66uBmfDJxgBbw7U/9sFVglYq7irSMXXQ6hWGtzAnf2IsnWcqSohKq2nBhatIwxEcIW8O1ucnk8T8zSBN4Y4=
X-Received: by 2002:a63:f74a:: with SMTP id f10mr945665pgk.263.1602715903247;
 Wed, 14 Oct 2020 15:51:43 -0700 (PDT)
MIME-Version: 1.0
References: <20201014212631.207844-1-nivedita@alum.mit.edu>
In-Reply-To: <20201014212631.207844-1-nivedita@alum.mit.edu>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 14 Oct 2020 15:51:32 -0700
Message-ID: <CAKwvOdkinv0dSuuTV7xTwqOVChpZM=Mu0GvEoAQYTtiXXtcERg@mail.gmail.com>
Subject: Re: [PATCH] compiler.h: Fix barrier_data() on clang
To:     Arvind Sankar <nivedita@alum.mit.edu>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 14, 2020 at 2:26 PM Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
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

Thanks for the patch! Curious how you spotted this? My mistake for
missing it.  Definite difference in the disassembly before/after.

Cc: stable@vger.kernel.org
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Tested-by: Nick Desaulniers <ndesaulniers@google.com>

akpm@ would you mind picking this up when you have a chance?

See also:
commit 7829fb09a2b4 ("lib: make memzero_explicit more robust against
dead store elimination")

I'm pretty sure `man 3 explicit_bzero` was created in libc for this
exact problem, though the manual page is an interesting read.

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
>  # define __noscs       __attribute__((__no_sanitize__("shadow-call-stack")))
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
Thanks,
~Nick Desaulniers
