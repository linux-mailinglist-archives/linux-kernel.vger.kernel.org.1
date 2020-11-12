Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD1122B1084
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 22:39:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727207AbgKLVjT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 16:39:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726960AbgKLVjS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 16:39:18 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F010AC0613D1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 13:39:08 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id e21so5311038pgr.11
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 13:39:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZURdxG09u8DA6MxogITPvJlVlTkJWovFIyDXhgQLLgE=;
        b=fAlqOSFMkPz1OgSYmsN270omY0vG02+dqtL4wgSr7jCGBxX5Wazo2yQwfyCNjtrCJ1
         fyzLKGNLYygsdZF50JBGe3hcKipsytN7MQxBk8fve3M09GOo1aQ/CQq4uleEQ9HHkUgh
         FFJha6wezD22erDfnvGoDclkmV3QBUJyHjqzLeAsvf6p1NqwUqh5E37e78XzYVqmELiP
         K1+P8s90q2Q8xnkitSV5YC5usHpn5wPR036FFGqVvW26zxF+WAuYvuvkcAmnHtmwzpKB
         Y0n6Nrd48Yo/H5/JIiUqiq9Gez4Vkb9eMYLFYMM8jrMiWTf8MNd8olbrUSuxKjElj2ZP
         NS2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZURdxG09u8DA6MxogITPvJlVlTkJWovFIyDXhgQLLgE=;
        b=V1Y+pDljWdzT/JnAAjtlttG950/OGKVG0DFLA/3BlIRsTilvuTq9TGDa2y6XDn4vve
         GqMyuuuwk/rWRaJ3wZj1s6e/hov2x50MCUzZsDbeyc/2js9BNQimzQzJIKwET5iH7I4x
         W8fVTI74HoNDDzCRelPNtYeCPGg6rA67oxNeEr/gZPalfcFsHcE+c7uyrMkTsE11isxu
         oh3tsWOMl0DnTT3F5Tj3qEYzxfqU8RxJskwffHBksrxmcdU7pgA4PrGtjR0gwCwW/+12
         XQekjfmjZsgm4SE/VIIeR+vc5XfmuWPHI2lFAh5+uk3771FN3x1AYXLK53Ryzl6JNiED
         oBPw==
X-Gm-Message-State: AOAM530NgnGx8y5jdkc8ZVOQsA66NiRcz8ULRw8vc4ccj6pikVdUWO4p
        Sjd9gGHWLJYuI6wapZlIHjSTq53jxrCp5AKzRc5sKg==
X-Google-Smtp-Source: ABdhPJxFlnYKOcs3d34DU7bIZxDFaXSslHACG0SCkWlFTT8RSgj9jqv15kWcxAqcDCubxCp1py/6f4+SYJPKMsuzYqA=
X-Received: by 2002:a17:90b:110b:: with SMTP id gi11mr1197979pjb.25.1605217148224;
 Thu, 12 Nov 2020 13:39:08 -0800 (PST)
MIME-Version: 1.0
References: <20201112212457.2042105-1-adrian.ratiu@collabora.com> <20201112212457.2042105-2-adrian.ratiu@collabora.com>
In-Reply-To: <20201112212457.2042105-2-adrian.ratiu@collabora.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 12 Nov 2020 13:38:56 -0800
Message-ID: <CAKwvOdm=3zaiuK4CgujPgqZWnENNnOqFnR_orMuHfXS8DbHKoQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] arm: lib: xor-neon: remove unnecessary GCC < 4.6 warning
To:     Adrian Ratiu <adrian.ratiu@collabora.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Ard Biesheuvel <ardb@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Collabora Kernel ML <kernel@collabora.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 12, 2020 at 1:23 PM Adrian Ratiu <adrian.ratiu@collabora.com> wrote:
>
> From: Nathan Chancellor <natechancellor@gmail.com>
>
> Drop warning because kernel now requires GCC >= v4.9 after
> commit 6ec4476ac825 ("Raise gcc version requirement to 4.9").
>
> Reported-by: Nick Desaulniers <ndesaulniers@google.com>
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>

Link: https://github.com/ClangBuiltLinux/linux/issues/496
Link: https://github.com/ClangBuiltLinux/linux/issues/503
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>  arch/arm/lib/xor-neon.c | 9 +--------
>  1 file changed, 1 insertion(+), 8 deletions(-)
>
> diff --git a/arch/arm/lib/xor-neon.c b/arch/arm/lib/xor-neon.c
> index b99dd8e1c93f..e1e76186ec23 100644
> --- a/arch/arm/lib/xor-neon.c
> +++ b/arch/arm/lib/xor-neon.c
> @@ -19,15 +19,8 @@ MODULE_LICENSE("GPL");
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
> 2.29.2
>


-- 
Thanks,
~Nick Desaulniers
