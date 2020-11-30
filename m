Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85AB72C8E22
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 20:35:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729791AbgK3Te3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 14:34:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729608AbgK3Te2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 14:34:28 -0500
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6847EC0613D6
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 11:33:48 -0800 (PST)
Received: by mail-pj1-x1044.google.com with SMTP id t21so219004pjw.2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 11:33:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CGCfzwd93ASiBjoTcqNrGvupvrJe2uwFFi+sFJL4Neg=;
        b=FwlZLBwiN8Sg8B7444O9gOcY1fHCOJED3NpGs1VcPdPhljPrz6RY2/s0Jb01A7jvO7
         5AqL4U9eVSBuLONDA2ThiEAWDZd3PseV2mM3DCm48Q+jnUHy3Nu4QuCYx01HjZ/QERTq
         a4PqfJiDvCHLbfWuuWt0WFXxpFXO8i4SWAXj4MYcPM9JQwgtRS1Uyc228CD2nH9NESi1
         0BfxHn3WnvBkF5Qt109xUH5xJsd9g0WXc7MpV05D1+zVc0aaJl/w7G5d6iWZBtSVk7JA
         3Qmu1ShBDMLjQgIb0PoBF88Jv6KZqcxmKBnHrXwEJu9BvZUr7EK0Ohwt1TLbxZLlqyfw
         Hzgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CGCfzwd93ASiBjoTcqNrGvupvrJe2uwFFi+sFJL4Neg=;
        b=r4pG1QuWN7MSEBNfdpYkroxLIsec9K8z8Q6L7mhS9d1AFRAfR32fwnzAsXM74+vyAk
         N3nfb+oVtpT2kUWcrHRkkN5vqJux7Nxpdoh+76tlPk6Pd3O8rMQX0UoeD6UjAz5hBbfR
         /DDatW2tlCRQQ7Vk/v0cj1PJTiAnGbA5mMlBe5T5jsO5fw6RK0rlDTXYBV+nlbBIOChs
         jXCHi88hyrx664PKUbukjzLQHJ/A856wntiDI1ACwMM7pol5SXbAGljiVWBgH/+3kJLt
         4Tk+UzlY9P7DXsgEgdIXUNkV3Jv81PxJeTn9J+acUy6kO5JTVFMQxtoKzkm7p69ZryH4
         q66Q==
X-Gm-Message-State: AOAM532CGnVuGD0QI8t5/zuYKjAteu4WQh0TiEyJD08tEkdgBUc0OAc7
        ZruW2EkkcAt99SDtjaTNA3Xpo+q9ZkXJuOUx+S07eg==
X-Google-Smtp-Source: ABdhPJz5ZJRIByZgoQucavhN1VJHt7aslzVAW3llEM1XaEqac5pWlh2+8ODWmDRBrN6WX6ZncFKvxSlQH3/oUiu0hTM=
X-Received: by 2002:a17:902:b18c:b029:d9:f:15fc with SMTP id
 s12-20020a170902b18cb02900d9000f15fcmr19983326plr.29.1606764827740; Mon, 30
 Nov 2020 11:33:47 -0800 (PST)
MIME-Version: 1.0
References: <pr6q9q72-6n62-236q-s59n-7osq71o285r9@syhkavp.arg>
In-Reply-To: <pr6q9q72-6n62-236q-s59n-7osq71o285r9@syhkavp.arg>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 30 Nov 2020 11:33:36 -0800
Message-ID: <CAKwvOdn1nCx354hkb15wBDH12aJgbObqPxa_neX5m71axaKRUw@mail.gmail.com>
Subject: Re: [PATCH] __div64_32(): straighten up inline asm constraints
To:     Nicolas Pitre <nico@fluxnic.net>
Cc:     Ard Biesheuvel <ardb@kernel.org>, Antony Yu <swpenim@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 30, 2020 at 11:05 AM Nicolas Pitre <nico@fluxnic.net> wrote:
>
> The ARM version of __div64_32() encapsulates a call to __do_div64 with
> non-standard argument passing. In particular, __n is a 64-bit input
> argument assigned to r0-r1 and __rem is an output argument sharing half
> of that 40-r1 register pair.

Should `40` be `r0`?

>
> With __n being an input argument, the compiler is in its right to
> presume that r0-r1 would still hold the value of __n past the inline
> assembly statement. Normally, the compiler would have assigned non
> overlapping registers to __n and __rem if the value for __n is needed
> again.
>
> However, here we enforce our own register assignment and gcc fails to
> notice the conflict. In practice this doesn't cause any problem as __n
> is considered dead after the asm statement and *n is overwritten.
> However this is not always guaranteed and clang rightfully complains.
>
> Let's fix it properly by making __n into an input-output variable. This
> makes it clear that those registers representing __n have been modified.
> Then we can extract __rem as the high part of __n with plain C code.
>
> This asm constraint "abuse" was likely relied upon back when gcc didn't
> handle 64-bit values optimally Turns out that gcc is now able to

^ Missing punctuation (period after `optimally`).

> optimize things and produces the same code with this patch applied.
>
> Signed-off-by: Nicolas Pitre <nico@fluxnic.net>
> Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
> Tested-by: Ard Biesheuvel <ardb@kernel.org>

Reported-by: Antony Yu <swpenim@gmail.com>


> ---
>
> This is related to the thread titled "[RESEND,PATCH] ARM: fix
> __div64_32() error when compiling with clang". My limited compile test
> with clang appears to make it happy. If no more comments I'll push this
> to RMK's patch system.
>
> diff --git a/arch/arm/include/asm/div64.h b/arch/arm/include/asm/div64.h
> index 898e9c78a7..595e538f5b 100644
> --- a/arch/arm/include/asm/div64.h
> +++ b/arch/arm/include/asm/div64.h
> @@ -21,29 +21,20 @@
>   * assembly implementation with completely non standard calling convention
>   * for arguments and results (beware).
>   */
> -
> -#ifdef __ARMEB__
> -#define __xh "r0"
> -#define __xl "r1"
> -#else
> -#define __xl "r0"
> -#define __xh "r1"
> -#endif
> -
>  static inline uint32_t __div64_32(uint64_t *n, uint32_t base)
>  {
>         register unsigned int __base      asm("r4") = base;
>         register unsigned long long __n   asm("r0") = *n;
>         register unsigned long long __res asm("r2");
> -       register unsigned int __rem       asm(__xh);
> -       asm(    __asmeq("%0", __xh)
> +       unsigned int __rem;
> +       asm(    __asmeq("%0", "r0")
>                 __asmeq("%1", "r2")
> -               __asmeq("%2", "r0")
> -               __asmeq("%3", "r4")
> +               __asmeq("%2", "r4")
>                 "bl     __do_div64"
> -               : "=r" (__rem), "=r" (__res)
> -               : "r" (__n), "r" (__base)
> +               : "+r" (__n), "=r" (__res)
> +               : "r" (__base)
>                 : "ip", "lr", "cc");
> +       __rem = __n >> 32;
>         *n = __res;
>         return __rem;

The above 3 statement could be:

```
*n = __res;
return __n >> 32;
```

>  }



-- 
Thanks,
~Nick Desaulniers
