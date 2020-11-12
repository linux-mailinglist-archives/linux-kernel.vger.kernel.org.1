Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 012AA2AFC9A
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 02:41:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729076AbgKLBkV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 20:40:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728174AbgKLBA5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 20:00:57 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D06DAC0613D4
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 17:00:55 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id m13so2697544pgl.7
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 17:00:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iWJMCBasD7Kt3omEYiLg083V4MvggRKPIB9CJhks3NU=;
        b=E2SDleIw33M0R8xWlLbP1dQQIqjSWTBo7g8TkOt+PBqigSw/fT8HHs9kqx7PPjcLGv
         o1PzOsS5nkJ6mpeXUfBONznwaCI9rG1jO4oLZ/EUdwAZXa7SOKAqoYSeNBGZq2MWNu7M
         vUP04AIrnYjexiysNCIln819wS3Xg81VV4ZwoiIGh1fXS92hgkKt4f1a465Evi57mdBx
         gFzv3ajsM/384IONJVUfJdnK8mnTvpxdDDFtez5K7dIBs+WDCdUt+0brrpEkYEVgY5IZ
         PpW4OP8C1nxhQZrsbGsS+dO7PWot0Qfrr3Keht1BiMkiDWAUHjMN1rlLPd40S4x8+UJa
         3jwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iWJMCBasD7Kt3omEYiLg083V4MvggRKPIB9CJhks3NU=;
        b=oe8/lmGzeBPiANyFffLkROBpUShFjEBDrWtW7fH2gUCUP3c8TYsV/Gr2I3joM1WsP4
         czB3Y9/OOBo9dAN99i9hgAH3PFNN7RJton+oCpuVOiQx0VL0V3OJHkb+UmlnFf5qRbAJ
         G77czPquzX3Pac2GcjcklITPzteTosR/5/FRZgKiKgll7rdDR+JbZPMpoh+YX/FNobtM
         lILo0oqj0kRetl5Qe4aZJEIYMK1KxFdsOvmCHfgbd/2AlIRHKG+I9pxtqDXwCa8KigID
         cn+SqB+YbguvxDJGl2HSzkLK7otyMIvl11FlMbhcGyZK8UStS9X/j+e+KnmqFqJWTQiD
         LLKg==
X-Gm-Message-State: AOAM533k1NaNxczMZqUweM+vXXGATvLdEvB3GjxkQkxiqzOCYGhTBXX5
        gd3ELuV1Pj8yQXmmiaWGZCo0KBIhC2g40pxuUTF4/A==
X-Google-Smtp-Source: ABdhPJxkqswZCwL0P/Yg/0r4uGE5OG25zH8IOLZ2KgScZYDTBgDvU23Qg5gcYVNB0Fuqxoq6QxZuVUKrDRLekie6l7g=
X-Received: by 2002:a62:ed0d:0:b029:18b:78d:626 with SMTP id
 u13-20020a62ed0d0000b029018b078d0626mr213230pfh.15.1605142855176; Wed, 11 Nov
 2020 17:00:55 -0800 (PST)
MIME-Version: 1.0
References: <20201112001422.340449-1-willmcvicker@google.com>
In-Reply-To: <20201112001422.340449-1-willmcvicker@google.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 11 Nov 2020 17:00:43 -0800
Message-ID: <CAKwvOdkDG2wt=ZT93GT7r60_qXn=tdW_zWiJ1Gr5JVdRvcU8uw@mail.gmail.com>
Subject: Re: [PATCH] arm64: Fix off-by-one vdso trampoline return value
To:     Will McVicker <willmcvicker@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Andrei Vagin <avagin@gmail.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        kernel-team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 11, 2020 at 4:14 PM Will McVicker <willmcvicker@google.com> wrote:
>
> Depending on your host nm version, the generated header
> `include/generated/vdso32-offsets.h` may have the bottom bit set for the
> thumb vdso offset addresses (as observed when using llvm-nm). This

Sorry, the commit message seems to imply a bug in llvm-nm, but I don't
think that's the case.  If it is, please, send us a bugreport.

$ aarch64-linux-gnu-nm arch/arm64/kernel/vdso32/vdso.so.raw | grep thumb
00000968 T __kernel_rt_sigreturn_thumb
00000960 T __kernel_sigreturn_thumb
00000968 t VDSO_compat_rt_sigreturn_thumb
00000960 t VDSO_compat_sigreturn_thumb
$ llvm-nm arch/arm64/kernel/vdso32/vdso.so.raw | grep thumb
00000968 t VDSO_compat_rt_sigreturn_thumb
00000960 t VDSO_compat_sigreturn_thumb
00000968 T __kernel_rt_sigreturn_thumb
00000960 T __kernel_sigreturn_thumb
$ /usr/bin/nm arch/arm64/kernel/vdso32/vdso.so.raw | grep thumb
00000969 T __kernel_rt_sigreturn_thumb
00000961 T __kernel_sigreturn_thumb
00000969 t VDSO_compat_rt_sigreturn_thumb
00000961 t VDSO_compat_sigreturn_thumb
$ /usr/bin/nm --version
GNU nm (GNU Binutils for Debian) 2.35.1

Would you mind amending the commit message to not imply that llvm-nm is broken?

It might be of interest to find out why the host `nm` was invoked,
rather than $(NM)/$(CROSS_COMPILE)nm.

> results in an additional +1 for thumb vdso trampoline return values
> since compat_setup_return() already includes `vdso_trampoline + thumb`.
> As a result, I see a SIGBUS error when running the LTP test
> syscalls.rt_sigaction01. To fix this, let's clear the bottom bit of the
> vdso_offset in the VDSO_SYMBOL macro.
>
> Test: LTP test syscalls.rt_sigaction01
> Fixes: f01703b3d2e6 ("arm64: compat: Get sigreturn trampolines from vDSO")
> Signed-off-by: Will McVicker <willmcvicker@google.com>
> ---
>  arch/arm64/include/asm/vdso.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm64/include/asm/vdso.h b/arch/arm64/include/asm/vdso.h
> index f99dcb94b438..a7384379e8e1 100644
> --- a/arch/arm64/include/asm/vdso.h
> +++ b/arch/arm64/include/asm/vdso.h
> @@ -23,7 +23,7 @@
>
>  #define VDSO_SYMBOL(base, name)                                                   \
>  ({                                                                        \
> -       (void *)(vdso_offset_##name - VDSO_LBASE + (unsigned long)(base)); \
> +       (void *)((vdso_offset_##name & ~1UL) - VDSO_LBASE + (unsigned long)(base)); \
>  })
>
>  #endif /* !__ASSEMBLY__ */
> --
> 2.29.2.299.gdc1121823c-goog
>


-- 
Thanks,
~Nick Desaulniers
