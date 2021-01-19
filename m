Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE76E2FC2DB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 22:57:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727729AbhASV5F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 16:57:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728041AbhASVzT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 16:55:19 -0500
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF848C061757
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 13:54:38 -0800 (PST)
Received: by mail-qk1-x729.google.com with SMTP id n142so23539747qkn.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 13:54:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SbyUbNXiGA6Y5PlccSbIv65ItGeI9NDKaJPt5uKU/b0=;
        b=vZ8APkKlADNNu0l1A8tgRexvdkcpISReIrRKS03w380rYukUeHONcGAwLx78mnjIdf
         E+dyg2CG8biMvZ7cK6jr9jXL9lqAzWm9KSitkAqdGiabA3kGPTg25eGg5q/C9VwUqotg
         PZq6l8qbmOYYpvbKZQvgfzOZ6/ENGTXU2ZbonelrqDwlr0kcLCSn50bEYbe5RtV3GGIm
         NQEJtk8C8XF+sGNOnJ3BhnnC/A4iBR2oLExA5fdp8YfD/GbdleSlzq0P5bKiaa6Qour4
         gJSzOtJf1VC41FXtcnWgGuUyGKwHiv/vZ6D1aS2gyKpXP9GpqlSt3gTpWerb/jxUmTjf
         q/pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SbyUbNXiGA6Y5PlccSbIv65ItGeI9NDKaJPt5uKU/b0=;
        b=XDsPOfG0dLGyhmX7k6V5/yMaTXDPVCYJTcm//d4CLwEZ0mN4MTam18PoKI4SOoXdEA
         Ntvm3fvi1vfbD0TAbgYAB4vfobSThvR8jAYaP1gR3+vNM6nUb2vOiz/5WsS59QG8tMU2
         1+BM6ElPfgFieDMjKYz7qGd/eiRBJHTiikitmghdaepF9hU8furh+3SO/LeiYUxpq2DV
         8TPOjKd8RzOYtghJjLvn8NAYq44S9ojolMCR1p05FYrnsKaifAQY2T3RZ8C3krNph766
         iTiF2eb/mRjHmWPQpo/akYLhPSBZCismIYXMJTlRfOP3jys7bDMTVYkjhrtjkpJlsJdj
         N8yQ==
X-Gm-Message-State: AOAM53179A+hoYA9rNk1fPQeZYxX2lgWos+TGNNXKYQFtxoKA9YtU2uS
        Ms8IFdAigFvLiz/34wz1DVA=
X-Google-Smtp-Source: ABdhPJx4YZQZbSq2lmR9phFNAuZOjlfXdyBQHkEwoDheM5/Ez12olq9ToLsM57kiPRNl1cUCwR/klw==
X-Received: by 2002:a37:a658:: with SMTP id p85mr2515080qke.422.1611093277837;
        Tue, 19 Jan 2021 13:54:37 -0800 (PST)
Received: from ubuntu-m3-large-x86 ([2604:1380:45f1:1d00::1])
        by smtp.gmail.com with ESMTPSA id i13sm21996qkk.83.2021.01.19.13.54.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jan 2021 13:54:36 -0800 (PST)
Date:   Tue, 19 Jan 2021 14:54:35 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Adrian Ratiu <adrian.ratiu@collabora.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Ard Biesheuvel <ardb@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        kernel@collabora.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 1/2] arm: lib: xor-neon: remove unnecessary GCC < 4.6
 warning
Message-ID: <20210119215435.GA1727211@ubuntu-m3-large-x86>
References: <20210119131724.308884-1-adrian.ratiu@collabora.com>
 <20210119131724.308884-2-adrian.ratiu@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210119131724.308884-2-adrian.ratiu@collabora.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 19, 2021 at 03:17:23PM +0200, Adrian Ratiu wrote:
> From: Nathan Chancellor <natechancellor@gmail.com>
> 
> Drop warning because kernel now requires GCC >= v4.9 after
> commit 6ec4476ac825 ("Raise gcc version requirement to 4.9")
> and clarify that -ftree-vectorize now always needs enabling
> for GCC by directly testing the presence of CONFIG_CC_IS_GCC.
> 
> Another reason to remove the warning is that Clang exposes
> itself as GCC < 4.6 so it triggers the warning about GCC
> which doesn't make much sense and misleads Clang users by
> telling them to update GCC.
> 
> Because Clang is now supported by the kernel print a clear
> Clang-specific warning.
> 
> Link: https://github.com/ClangBuiltLinux/linux/issues/496
> Link: https://github.com/ClangBuiltLinux/linux/issues/503
> Reported-by: Nick Desaulniers <ndesaulniers@google.com>
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>

The commit message looks like it is written by me but I never added a
Clang specific warning. I appreciate wanting to give me credit but when
you change things about my original commit message, please make it
clear that you did the edits, something like:

Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
[adrian: Add clang specific warning]
Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>

> ---
>  arch/arm/lib/xor-neon.c | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm/lib/xor-neon.c b/arch/arm/lib/xor-neon.c
> index b99dd8e1c93f..f9f3601cc2d1 100644
> --- a/arch/arm/lib/xor-neon.c
> +++ b/arch/arm/lib/xor-neon.c
> @@ -14,20 +14,22 @@ MODULE_LICENSE("GPL");
>  #error You should compile this file with '-march=armv7-a -mfloat-abi=softfp -mfpu=neon'
>  #endif
>  
> +/*
> + * TODO: Even though -ftree-vectorize is enabled by default in Clang, the
> + * compiler does not produce vectorized code due to its cost model.
> + * See: https://github.com/ClangBuiltLinux/linux/issues/503
> + */
> +#ifdef CONFIG_CC_IS_CLANG
> +#warning Clang does not vectorize code in this file.
> +#endif

I really do not like this. With the GCC specific warning, the user could
just upgrade their GCC. With this warning, it is basically telling them
don't use clang, in which case, it would just be better to disable this
code altogether. I would rather see:

1. Just don't build this file with clang altogether, which I believe was
   v1's 2/2 patch.

OR

2. Use the pragma:

#pragma clang loop vectorize(enable)

as Nick suggests in v1's 2/2 patch.

Alternatively, __restrict__ sounds like it might be beneficial for both
GCC and clang:

https://lore.kernel.org/lkml/20201112215033.GA438824@rani.riverdale.lan/

>  /*
>   * Pull in the reference implementations while instructing GCC (through
>   * -ftree-vectorize) to attempt to exploit implicit parallelism and emit
>   * NEON instructions.
>   */
> -#if __GNUC__ > 4 || (__GNUC__ == 4 && __GNUC_MINOR__ >= 6)
> +#ifdef CONFIG_CC_IS_GCC
>  #pragma GCC optimize "tree-vectorize"
> -#else
> -/*
> - * While older versions of GCC do not generate incorrect code, they fail to
> - * recognize the parallel nature of these functions, and emit plain ARM code,
> - * which is known to be slower than the optimized ARM code in asm-arm/xor.h.
> - */
> -#warning This code requires at least version 4.6 of GCC
>  #endif
>  
>  #pragma GCC diagnostic ignored "-Wunused-variable"
> -- 
> 2.30.0
> 
