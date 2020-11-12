Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F79A2B1086
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 22:40:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727254AbgKLVkU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 16:40:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726960AbgKLVkU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 16:40:20 -0500
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 083D6C0613D1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 13:40:20 -0800 (PST)
Received: by mail-pl1-x643.google.com with SMTP id d3so3482786plo.4
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 13:40:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GIyDKMHXNrYMltrg0Ujyp5HW7ajXeXqAEMraB5j3fgw=;
        b=cOF2ey3p32E/WPRacgmh1fqaFaYNQO2Ze5R+m28PA1t4QjIOuo6JuYSRX9nAaPKo3n
         rwK7yxWwaMYB1h1lG0459LkGnP24QJGWjAhaqZeDjTKIHTBD34EAEBNK/tG77r2JzxpD
         /MKW6/x2jgihNtDKEKlIsvcA9aNEqh56IEXOq52dSukXleXMs5lDv+1JicPVdJIB2GbR
         nPJBk6cKGp055Hn/pUjiccTc6E+xup/P/rw1DvkIQ3DA/kVcJUOqyQLQtppeOjI/baYf
         LJuJlhBRXN2J+8XFbTmJi3AN5f6CKQ9PCrqO5/T25J2KV0rk3UDtoADIKJn5XNAk65Lh
         m6PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GIyDKMHXNrYMltrg0Ujyp5HW7ajXeXqAEMraB5j3fgw=;
        b=H0xa4a4ikM0CGT+nWCHB75LYkx+xh8IHQvh8BKcDwUFiJoRC+HLCWlA0CIbHkARumU
         VHSnBmi6Hx7tak9wHKwp7l1S8A74nzNnMCtJ7jUvAMTToDaaS5IuhNOUXg6XSSsTIbxd
         aSnltr9DvO/EffvQa0kFzkAf7G8qb7pt+WxcOvJXAd7t9VVhNSdMpBKSQL1MH3kvg6HQ
         o8E+JDhoPrOsiOe9p0UWYkGjkKf19e336KmhdA6kpT3lPykdL/O8OzfR7wWqzVcSs21u
         JeaZ8oCmFe+xClA+zTIsTGA+XoWLNkKA3mmNP72E4KpTq3Qc4xscFYPUHB0e7FeGSZRf
         QsFw==
X-Gm-Message-State: AOAM531UpnhBTQPoRL4YS+g0dT91duY0KnfRxZAa1x/Pww4tR5icMyPy
        aNQklkSbowl2fuZ1mEx6wii7FjNKH157tblCXyYRHg==
X-Google-Smtp-Source: ABdhPJznItuRRJQmJBKENd+Q0531MmGeJWXEhK6Ijzu6puZ+ZDzXCwLJ5bSRXvVnMHZ1eWlsSBSpEitWFibpJq6qW5A=
X-Received: by 2002:a17:902:760c:b029:d6:efa5:4cdd with SMTP id
 k12-20020a170902760cb02900d6efa54cddmr1142305pll.56.1605217219357; Thu, 12
 Nov 2020 13:40:19 -0800 (PST)
MIME-Version: 1.0
References: <20201112212457.2042105-1-adrian.ratiu@collabora.com> <20201112212457.2042105-3-adrian.ratiu@collabora.com>
In-Reply-To: <20201112212457.2042105-3-adrian.ratiu@collabora.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 12 Nov 2020 13:40:08 -0800
Message-ID: <CAKwvOdkM7q2muArRQxgZ3SdCHYTUja-KtkCveo8bq3RV8GWfKw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] arm: lib: xor-neon: move pragma options to makefile
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
> Using a pragma like GCC optimize is a bad idea because it tags
> all functions with an __attribute__((optimize)) which replaces
> optimization options rather than appending so could result in
> dropping important flags. Not recommended for production use.
>
> Because these options should always be enabled for this file,
> it's better to set them via command line. tree-vectorize is on
> by default in Clang, but it doesn't hurt to make it explicit.
>
> Suggested-by: Arvind Sankar <nivedita@alum.mit.edu>
> Suggested-by: Ard Biesheuvel <ardb@kernel.org>
> Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>  arch/arm/lib/Makefile   |  2 +-
>  arch/arm/lib/xor-neon.c | 10 ----------
>  2 files changed, 1 insertion(+), 11 deletions(-)
>
> diff --git a/arch/arm/lib/Makefile b/arch/arm/lib/Makefile
> index 6d2ba454f25b..12d31d1a7630 100644
> --- a/arch/arm/lib/Makefile
> +++ b/arch/arm/lib/Makefile
> @@ -45,6 +45,6 @@ $(obj)/csumpartialcopyuser.o: $(obj)/csumpartialcopygeneric.S
>
>  ifeq ($(CONFIG_KERNEL_MODE_NEON),y)
>    NEON_FLAGS                   := -march=armv7-a -mfloat-abi=softfp -mfpu=neon
> -  CFLAGS_xor-neon.o            += $(NEON_FLAGS)
> +  CFLAGS_xor-neon.o            += $(NEON_FLAGS) -ftree-vectorize -Wno-unused-variable
>    obj-$(CONFIG_XOR_BLOCKS)     += xor-neon.o
>  endif
> diff --git a/arch/arm/lib/xor-neon.c b/arch/arm/lib/xor-neon.c
> index e1e76186ec23..62b493e386c4 100644
> --- a/arch/arm/lib/xor-neon.c
> +++ b/arch/arm/lib/xor-neon.c
> @@ -14,16 +14,6 @@ MODULE_LICENSE("GPL");
>  #error You should compile this file with '-march=armv7-a -mfloat-abi=softfp -mfpu=neon'
>  #endif
>
> -/*
> - * Pull in the reference implementations while instructing GCC (through
> - * -ftree-vectorize) to attempt to exploit implicit parallelism and emit
> - * NEON instructions.
> - */
> -#ifdef CONFIG_CC_IS_GCC
> -#pragma GCC optimize "tree-vectorize"
> -#endif
> -
> -#pragma GCC diagnostic ignored "-Wunused-variable"
>  #include <asm-generic/xor.h>
>
>  struct xor_block_template const xor_block_neon_inner = {
> --
> 2.29.2
>


-- 
Thanks,
~Nick Desaulniers
