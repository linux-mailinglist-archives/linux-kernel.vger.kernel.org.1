Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD7692B16B8
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 08:49:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726207AbgKMHt1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 02:49:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:48184 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726133AbgKMHt0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 02:49:26 -0500
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 004EE20936
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 07:49:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605253766;
        bh=8kvl6kbcf3I7sjDJ7WflrDos9Tai0vUrQQSTGsyMk4U=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=CjvOtuprdR/aiRjhZYzmc9gonc/53vpRt4Kvk+nv/KF7Yt7cG/sFysr67RBom2aNk
         VHTbSEwcGeeVt2I2pn8fgneQHT82532go/wdIohJqawMZHRsuHrFnnRLrxxDRuMOOV
         PATRqBS6jd1K+Vl5GvFPDMIVzTRKqa9677NOuRyc=
Received: by mail-ot1-f50.google.com with SMTP id z16so8185384otq.6
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 23:49:25 -0800 (PST)
X-Gm-Message-State: AOAM532Npv4y+K4wrZAmzx96bl+ngcaoeQVdy1k/shKRHVJMPhZadK2+
        jtbuIG+GEETaS1Aucja84cvNGpmmgb1x1eQRtXA=
X-Google-Smtp-Source: ABdhPJwXAQ3X3z9DgTnNWgOwgPi0i0p6wCcMybY+A2TesXmeeDs8hhF5CFZA8QdcGHm8tRtgj5vukAj1ArXspI+lu70=
X-Received: by 2002:a05:6830:115a:: with SMTP id x26mr701341otq.77.1605253765263;
 Thu, 12 Nov 2020 23:49:25 -0800 (PST)
MIME-Version: 1.0
References: <20201112212457.2042105-1-adrian.ratiu@collabora.com> <20201112212457.2042105-2-adrian.ratiu@collabora.com>
In-Reply-To: <20201112212457.2042105-2-adrian.ratiu@collabora.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 13 Nov 2020 08:49:12 +0100
X-Gmail-Original-Message-ID: <CAMj1kXFbLRTvGuRt5J3-oEuJrrHFV9+SBGFFDNsAftGUbwoTPw@mail.gmail.com>
Message-ID: <CAMj1kXFbLRTvGuRt5J3-oEuJrrHFV9+SBGFFDNsAftGUbwoTPw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] arm: lib: xor-neon: remove unnecessary GCC < 4.6 warning
To:     Adrian Ratiu <adrian.ratiu@collabora.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Arvind Sankar <nivedita@alum.mit.edu>, kernel@collabora.com,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Nov 2020 at 22:23, Adrian Ratiu <adrian.ratiu@collabora.com> wrote:
>
> From: Nathan Chancellor <natechancellor@gmail.com>
>
> Drop warning because kernel now requires GCC >= v4.9 after
> commit 6ec4476ac825 ("Raise gcc version requirement to 4.9").
>
> Reported-by: Nick Desaulniers <ndesaulniers@google.com>
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>

Again, this does not do what it says on the tin.

If you want to disable the pragma for Clang, call that out in the
commit log, and don't hide it under a GCC version change.

Without the pragma, the generated code is the same as the generic
code, so it makes no sense to build xor-neon.ko at all, right?

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
