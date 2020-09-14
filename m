Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9ADB9269545
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 21:07:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726023AbgINTHT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 15:07:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725961AbgINTHJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 15:07:09 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 261A5C061788
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 12:07:09 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id w1so682078edr.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 12:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KdP1iGPi3JdsFjU/S7SwDMj+BRlIyfPVFFF4PCGcGxg=;
        b=PleFn2R8olR+BbuK+cnJjdy9MoubtDazFmebifdBRBEAd18M1ePhqdj8jILrUO1M8i
         MbL47uOUSm9RQn4ukdfTzYuNWqzZXadnWUvQs4N5KQCAPPr/jb5Pj7KVk0yCbh846ovL
         c0eS+A65Ed5gwPwuahLZu3OCGkqbFluRqYU6FCYJ5OLGDUbL8ff8VFVg1loKbQaktNje
         cehDfwb9Un8N3ojwEcRhpfkijT4xJr3gVsJNjh7MKvZfDGoe/P8MtHlGwYiDl8JmwZej
         K7ayMygK1bZMgB72JysrzVE3vssPdF99t5EfYzot89cT4QQygfE1KxdfLSsU//ixqP5A
         btbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KdP1iGPi3JdsFjU/S7SwDMj+BRlIyfPVFFF4PCGcGxg=;
        b=oeQunQBU/qB/HqyqlrLYG3Ypg9Yd4KhXebc+cX9z9mMTFkb6c5HtlThL93ekU1FfS5
         /Fuh2NQglbWNQ98RaO+H805XE1iN0BL7NlohZdpC8KCIQwAYDYOlPlNoh3QtbcLf7glU
         ddGIUQjFWo2klGjJZFOe0HhO9vFBkxfa/iTOtIySigY9Milu1BtoZWHGP3D0wxjF2LBj
         Pk4zAtfptld1fkbBHGStA+frQulN0ZFKjWu5xXa0JKO045W0QgmW2dHnX/L0FmCMLoL+
         yF2k1k2BU+7SY4yF6U4hVVPpi8llu60WRgH/qnY5R/JMpvF0lp+5iZjyn3iUXqBGA85U
         YBmQ==
X-Gm-Message-State: AOAM5315CFCDYia5pl0EvFPwlkXry5gvmdiQxkAGSHDa6TCvbf1HK7c/
        uVY0sjXjqEufDn2fV9J3D7rvMSF57Jahfdrfot8pag==
X-Google-Smtp-Source: ABdhPJwWAlcUtGz46Ol00oJ4aIuI1jjku+s2DPCtgQ5oHWxJvf5VIThc82Dny/nlJ2cM33CWEuYH/AmNpGzJzBA9vTw=
X-Received: by 2002:a05:6402:180a:: with SMTP id g10mr18503592edy.18.1600110427709;
 Mon, 14 Sep 2020 12:07:07 -0700 (PDT)
MIME-Version: 1.0
References: <1d06ed6485b66b9f674900368b63d7ef79f666ca.1599756789.git.jpoimboe@redhat.com>
In-Reply-To: <1d06ed6485b66b9f674900368b63d7ef79f666ca.1599756789.git.jpoimboe@redhat.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 14 Sep 2020 12:06:56 -0700
Message-ID: <CAPcyv4jk_SZGaCtDm39FAdMCo9fQo87gjuAj1xzUCT9isycz9g@mail.gmail.com>
Subject: Re: [PATCH v3] x86/uaccess: Use pointer masking to limit uaccess speculation
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     X86 ML <x86@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Waiman Long <longman@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Andy Lutomirski <luto@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        David Laight <David.Laight@aculab.com>,
        Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 10, 2020 at 10:24 AM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
>
> The x86 uaccess code uses barrier_nospec() in various places to prevent
> speculative dereferencing of user-controlled pointers (which might be
> combined with further gadgets or CPU bugs to leak data).
>
> There are some issues with the current implementation:
>
> - The barrier_nospec() in copy_from_user() was inadvertently removed
>   with: 4b842e4e25b1 ("x86: get rid of small constant size cases in
>   raw_copy_{to,from}_user()")
>
> - copy_to_user() and friends should also have a speculation barrier,
>   because a speculative write to a user-controlled address can still
>   populate the cache line with the original data.
>
> - The LFENCE in barrier_nospec() is overkill, when more lightweight user
>   pointer masking can be used instead.
>
> Remove all existing barrier_nospec() usage, and instead do user pointer
> masking, throughout the x86 uaccess code.  This is similar to what arm64
> is already doing with uaccess_mask_ptr().
>
> barrier_nospec() is now unused, and can be removed.
>
> Fixes: 4b842e4e25b1 ("x86: get rid of small constant size cases in raw_copy_{to,from}_user()")
> Suggested-by: Will Deacon <will@kernel.org>
> Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
> ---
> v3:
>
> - Rebased on vfs#for-next, using TASK_SIZE_MAX now that set_fs() is
>   gone.  I considered just clearing the most significant bit, but that
>   only works for 64-bit, so in the interest of common code I went with
>   the more straightforward enforcement of the TASK_SIZE_MAX limit.
>
> - Rename the macro to force_user_ptr(), which is more descriptive, and
>   also more distinguishable from a planned future macro for sanitizing
>   __user pointers on syscall entry.
>
>  Documentation/admin-guide/hw-vuln/spectre.rst |  6 ++--
>  arch/x86/include/asm/barrier.h                |  3 --
>  arch/x86/include/asm/checksum_32.h            |  6 ++--
>  arch/x86/include/asm/futex.h                  |  5 +++
>  arch/x86/include/asm/uaccess.h                | 35 ++++++++++++-------
>  arch/x86/include/asm/uaccess_64.h             | 16 ++++-----
>  arch/x86/lib/csum-wrappers_64.c               |  5 +--
>  arch/x86/lib/getuser.S                        | 10 +++---
>  arch/x86/lib/putuser.S                        |  8 +++++
>  arch/x86/lib/usercopy_32.c                    |  6 ++--
>  arch/x86/lib/usercopy_64.c                    |  7 ++--
>  lib/iov_iter.c                                |  2 +-
>  12 files changed, 65 insertions(+), 44 deletions(-)
>
> diff --git a/Documentation/admin-guide/hw-vuln/spectre.rst b/Documentation/admin-guide/hw-vuln/spectre.rst
> index e05e581af5cf..27a8adedd2b8 100644
> --- a/Documentation/admin-guide/hw-vuln/spectre.rst
> +++ b/Documentation/admin-guide/hw-vuln/spectre.rst
> @@ -426,9 +426,9 @@ Spectre variant 1
>     <spec_ref2>` to avoid any usable disclosure gadgets. However, it may
>     not cover all attack vectors for Spectre variant 1.
>
> -   Copy-from-user code has an LFENCE barrier to prevent the access_ok()
> -   check from being mis-speculated.  The barrier is done by the
> -   barrier_nospec() macro.
> +   Usercopy code uses user pointer masking to prevent the access_ok()
> +   check from being mis-speculated in the success path with a kernel
> +   address.  The masking is done by the force_user_ptr() macro.
>
>     For the swapgs variant of Spectre variant 1, LFENCE barriers are
>     added to interrupt, exception and NMI entry where needed.  These
> diff --git a/arch/x86/include/asm/barrier.h b/arch/x86/include/asm/barrier.h
> index 7f828fe49797..d158ea1fa250 100644
> --- a/arch/x86/include/asm/barrier.h
> +++ b/arch/x86/include/asm/barrier.h
> @@ -48,9 +48,6 @@ static inline unsigned long array_index_mask_nospec(unsigned long index,
>  /* Override the default implementation from linux/nospec.h. */
>  #define array_index_mask_nospec array_index_mask_nospec
>
> -/* Prevent speculative execution past this barrier. */
> -#define barrier_nospec() alternative("", "lfence", X86_FEATURE_LFENCE_RDTSC)
> -
>  #define dma_rmb()      barrier()
>  #define dma_wmb()      barrier()
>
> diff --git a/arch/x86/include/asm/checksum_32.h b/arch/x86/include/asm/checksum_32.h
> index 17da95387997..c7ebc40c6fb9 100644
> --- a/arch/x86/include/asm/checksum_32.h
> +++ b/arch/x86/include/asm/checksum_32.h
> @@ -49,7 +49,8 @@ static inline __wsum csum_and_copy_from_user(const void __user *src,
>         might_sleep();
>         if (!user_access_begin(src, len))
>                 return 0;
> -       ret = csum_partial_copy_generic((__force void *)src, dst, len);
> +       ret = csum_partial_copy_generic((__force void *)force_user_ptr(src),
> +                                       dst, len);

I look at this and wonder if the open-coded "(__force void *)" should
be subsumed in the new macro. It also feels like the name should be
"enforce" to distinguish it from the type cast case?

>         user_access_end();
>
>         return ret;
> @@ -177,8 +178,7 @@ static inline __wsum csum_and_copy_to_user(const void *src,
>         might_sleep();
>         if (!user_access_begin(dst, len))
>                 return 0;
> -
> -       ret = csum_partial_copy_generic(src, (__force void *)dst, len);
> +       ret = csum_partial_copy_generic(src, (__force void *)force_user_ptr(dst), len);
>         user_access_end();
>         return ret;
>  }
> diff --git a/arch/x86/include/asm/futex.h b/arch/x86/include/asm/futex.h
> index f9c00110a69a..0cecdaa362b1 100644
> --- a/arch/x86/include/asm/futex.h
> +++ b/arch/x86/include/asm/futex.h
> @@ -59,6 +59,8 @@ static __always_inline int arch_futex_atomic_op_inuser(int op, int oparg, int *o
>         if (!user_access_begin(uaddr, sizeof(u32)))
>                 return -EFAULT;
>
> +       uaddr = force_user_ptr(uaddr);
> +
>         switch (op) {
>         case FUTEX_OP_SET:
>                 unsafe_atomic_op1("xchgl %0, %2", oval, uaddr, oparg, Efault);
> @@ -94,6 +96,9 @@ static inline int futex_atomic_cmpxchg_inatomic(u32 *uval, u32 __user *uaddr,
>
>         if (!user_access_begin(uaddr, sizeof(u32)))
>                 return -EFAULT;
> +
> +       uaddr = force_user_ptr(uaddr);
> +
>         asm volatile("\n"
>                 "1:\t" LOCK_PREFIX "cmpxchgl %4, %2\n"
>                 "2:\n"
> diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uaccess.h
> index a4ceda0510ea..d35f6dc22341 100644
> --- a/arch/x86/include/asm/uaccess.h
> +++ b/arch/x86/include/asm/uaccess.h
> @@ -6,6 +6,7 @@
>   */
>  #include <linux/compiler.h>
>  #include <linux/kasan-checks.h>
> +#include <linux/nospec.h>
>  #include <linux/string.h>
>  #include <asm/asm.h>
>  #include <asm/page.h>
> @@ -66,12 +67,23 @@ static inline bool pagefault_disabled(void);
>   * Return: true (nonzero) if the memory block may be valid, false (zero)
>   * if it is definitely invalid.
>   */
> -#define access_ok(addr, size)                                  \

unnecessary whitespace change?

Other than that and the optional s/force/enforce/ rename + cast
collapse you can add:

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
