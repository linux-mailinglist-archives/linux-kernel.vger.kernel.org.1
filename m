Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19EDD2FC21B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 22:20:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729168AbhASVUJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 16:20:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728221AbhASVTJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 16:19:09 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C03FFC0613C1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 13:18:27 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id 15so13767793pgx.7
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 13:18:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GUbLbmtARwLrukRtqOIAYNu5h84qqes4aFplAP4XxME=;
        b=pFWSQ7PxnGjqvOIOSz+b9o3QjhNS22c/IpR/WKX1WRJJBSHSEZkpqQH4d3jeXFqwx5
         BS53/1afs51JkhbIeGi0M+480mh3kMCnV37bss+xeHpq9KMPSHd7UgqKFZQQPQTkmXyP
         g9+F/QKE77NR/v2JbDmTc/jQYq/768UxCvPb/kOmAS4bPwSy96usDuqZEFS6gUJ+/Yeh
         TMSJxfmnWqFUu6qP6ko4NZXcjsT0TcQqfGOgw0dSVIquT3bqftGPMbb7HBuMCwmAvKzm
         H1RSIFpx/xuH5ujg9yd0XOSeE2/pwaXax8Odq+hLb0q2eldi2JMrmoKYKeq2/CYgJr+s
         RBrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GUbLbmtARwLrukRtqOIAYNu5h84qqes4aFplAP4XxME=;
        b=p+ELSb5AnpLKzgazP13B/ZNMux4AebcxbzAcruoe0fQ7BDom7vCOfT/8nBginUh9Zn
         7bf8MMl8o3ByfKJ39Cfmrktm+UTgGtveASjpSx1MmP6vaeAT1dis/34Chc042IqQBCS6
         XQYhhmF5LevyYt5f4BlT4ztt2X/rR0wENyv4l1zKfb/f9yoPBEWaMAZJrhSy29N+aLRB
         cTIJ+KnRzqpjn89lB+D/OaLF23jVMr9fqzBnDrtdteeNXk+HSw+rm8gEC/ro9NvdQSWv
         cXZ+xw7xrgU1ak8clIH8WVLUYag1C1a0pxA34pIzR+Rx5unsrLsfuqKyzTdV2tr+HisL
         oVmw==
X-Gm-Message-State: AOAM532V93jTTKNvtNhH9kWAi213y1Ol1oGpOnCQYh7BYO+AWMNCwzff
        /Mniwl4meAOY6Dg7gtI411yU4mOTgT2F2AtEQVcr0w==
X-Google-Smtp-Source: ABdhPJw8pKTzHIo3RJ5xY5RlGpjCInElwVgnKjp2tnXoGZvmUnZPXMzM1QJsasme15Kzt4eqJVuhKaLV93GRhvN1sHA=
X-Received: by 2002:a63:5701:: with SMTP id l1mr6165248pgb.381.1611091107085;
 Tue, 19 Jan 2021 13:18:27 -0800 (PST)
MIME-Version: 1.0
References: <20210119131724.308884-1-adrian.ratiu@collabora.com> <20210119131724.308884-2-adrian.ratiu@collabora.com>
In-Reply-To: <20210119131724.308884-2-adrian.ratiu@collabora.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 19 Jan 2021 13:18:15 -0800
Message-ID: <CAKwvOdkNZ09kkzi+A8diaxViqSufxrHizuBu-7quG6an3Z8iDA@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] arm: lib: xor-neon: remove unnecessary GCC < 4.6 warning
To:     Adrian Ratiu <adrian.ratiu@collabora.com>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Ard Biesheuvel <ardb@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Collabora Kernel ML <kernel@collabora.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 19, 2021 at 5:17 AM Adrian Ratiu <adrian.ratiu@collabora.com> wrote:
>
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

This is not the version of the patch I had reviewed; please drop my
reviewed-by tag when you change a patch significantly, as otherwise it
looks like I approved this patch.

Nacked-by: Nick Desaulniers <ndesaulniers@google.com>

> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
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

Arnd, remind me again why it's a bug that the compiler's cost model
says it's faster to not produce a vectorized version of these loops?
I stand by my previous comment: https://bugs.llvm.org/show_bug.cgi?id=40976#c8

> +
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


-- 
Thanks,
~Nick Desaulniers
