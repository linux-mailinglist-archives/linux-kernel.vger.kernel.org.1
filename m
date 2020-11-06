Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39B512A93DE
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 11:14:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbgKFKOX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 05:14:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725868AbgKFKOW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 05:14:22 -0500
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D583C0613CF
        for <linux-kernel@vger.kernel.org>; Fri,  6 Nov 2020 02:14:22 -0800 (PST)
Received: by mail-il1-x144.google.com with SMTP id n5so601634ile.7
        for <linux-kernel@vger.kernel.org>; Fri, 06 Nov 2020 02:14:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=iOjO/+SmXIjhhMmb/arLW6PNxmPECHhSo5uEUFHznhs=;
        b=EI/iO/205kjlnCe4kyJsvbZU2XLrtFbwebhRxt8IpJrlEKATzuUDcd5FWbCRjd0QPf
         +GboFAJoE/TUFKOaqNozcWX0BAxQDzZfb661OOIp0nbZ+qZ6HKk4P9nQolwCZ8PxStjY
         ZUmQFTH15NJbCjZp8sRPIDimWLKW0JrLsvgJEI9tV/WDGrjkOvtHbu0Tqh2ebX13vQhp
         4uoUCjyT4UmG7KMwZoD/ShUVnccerjsUKIGjkXa5vt557+zYUakE7Qvaa76xc4COAyzU
         lczit1FAuK2gP8JK8cwUUAc/rnQQbWYRvJInNBYB446LJsHLk/B/oKhLiXB/2r04Sujl
         xGjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iOjO/+SmXIjhhMmb/arLW6PNxmPECHhSo5uEUFHznhs=;
        b=Xk2OaramoqyYAFxSMPVDmrosAecBQtvaWbqmSdUBdwEJ+8Ky+0zUSwm2FmGn9VznVB
         SoKS77DTsO+CwfR/Ses24I4vGS90BNlnS4BK19g5EfbKSpbqtwSXPtVCXnrZ31NGupud
         tm4F6+QBJ/S5yzuywCc8iLFnr4q32TNEa0yQDCaU99IGQOhPU8adYIfLNcL5JaMqDi1S
         AarOBMqWlZMlgU+lGcN5Yi4zah6TrYap9Pma9ZMUl1AXd0u0LBY/A+EapBk04bKgH3Zi
         FKMruRUIEQsPnvX85D00UKSph2fsZXw3ApXrtNcqpBzN+sXRxOdieAPf2hDZUTSHip2A
         0bdQ==
X-Gm-Message-State: AOAM530O+aXr/TrDdxSQN6FTt14nxsRf7DXMMEYwWK/fy/MQWXP4Shds
        qqUn7Xuw6e86n/YIteUMHzg=
X-Google-Smtp-Source: ABdhPJy+aMsmwQ5T6MGifDqDt3Bg1N13Nz0Mj0a+bv9L9zFp6mnExd1W67qYEsmMTSxasMIMj3lt/Q==
X-Received: by 2002:a92:d449:: with SMTP id r9mr809204ilm.276.1604657661703;
        Fri, 06 Nov 2020 02:14:21 -0800 (PST)
Received: from ubuntu-m3-large-x86 ([2604:1380:45f1:1d00::1])
        by smtp.gmail.com with ESMTPSA id r16sm557880ioc.45.2020.11.06.02.14.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2020 02:14:20 -0800 (PST)
Date:   Fri, 6 Nov 2020 03:14:19 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Adrian Ratiu <adrian.ratiu@collabora.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        clang-built-linux@googlegroups.com,
        Russell King <linux@armlinux.org.uk>,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH 2/2] arm: lib: xor-neon: disable clang vectorization
Message-ID: <20201106101419.GB3811063@ubuntu-m3-large-x86>
References: <20201106051436.2384842-1-adrian.ratiu@collabora.com>
 <20201106051436.2384842-3-adrian.ratiu@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201106051436.2384842-3-adrian.ratiu@collabora.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Ard, who wrote this code.

On Fri, Nov 06, 2020 at 07:14:36AM +0200, Adrian Ratiu wrote:
> Due to a Clang bug [1] neon autoloop vectorization does not happen or
> happens badly with no gains and considering previous GCC experiences
> which generated unoptimized code which was worse than the default asm
> implementation, it is safer to default clang builds to the known good
> generic implementation.
> 
> The kernel currently supports a minimum Clang version of v10.0.1, see
> commit 1f7a44f63e6c ("compiler-clang: add build check for clang 10.0.1").
> 
> When the bug gets eventually fixed, this commit could be reverted or,
> if the minimum clang version bump takes a long time, a warning could
> be added for users to upgrade their compilers like was done for GCC.
> 
> [1] https://bugs.llvm.org/show_bug.cgi?id=40976
> 
> Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>

Thank you for the patch! We are also tracking this here:

https://github.com/ClangBuiltLinux/linux/issues/496

It was on my TODO to revist getting the warning eliminated, which likely
would have involved a patch like this as well.

I am curious if it is worth revisting or dusting off Arnd's patch in the
LLVM bug tracker first. I have not tried it personally. If that is not a
worthwhile option, I am fine with this for now. It would be nice to try
and get a fix pinned down on the LLVM side at some point but alas,
finite amount of resources and people :(

Should no other options come to fruition from further discussions, you
can carry my tag forward:

Acked-by: Nathan Chancellor <natechancellor@gmail.com>

Hopefully others can comment soon.

> ---
>  arch/arm/include/asm/xor.h | 3 ++-
>  arch/arm/lib/Makefile      | 3 +++
>  arch/arm/lib/xor-neon.c    | 4 ++++
>  3 files changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/include/asm/xor.h b/arch/arm/include/asm/xor.h
> index aefddec79286..49937dafaa71 100644
> --- a/arch/arm/include/asm/xor.h
> +++ b/arch/arm/include/asm/xor.h
> @@ -141,7 +141,8 @@ static struct xor_block_template xor_block_arm4regs = {
>  		NEON_TEMPLATES;			\
>  	} while (0)
>  
> -#ifdef CONFIG_KERNEL_MODE_NEON
> +/* disabled on clang/arm due to https://bugs.llvm.org/show_bug.cgi?id=40976 */
> +#if defined(CONFIG_KERNEL_MODE_NEON) && !defined(CONFIG_CC_IS_CLANG)
>  
>  extern struct xor_block_template const xor_block_neon_inner;
>  
> diff --git a/arch/arm/lib/Makefile b/arch/arm/lib/Makefile
> index 6d2ba454f25b..53f9e7dd9714 100644
> --- a/arch/arm/lib/Makefile
> +++ b/arch/arm/lib/Makefile
> @@ -43,8 +43,11 @@ endif
>  $(obj)/csumpartialcopy.o:	$(obj)/csumpartialcopygeneric.S
>  $(obj)/csumpartialcopyuser.o:	$(obj)/csumpartialcopygeneric.S
>  
> +# disabled on clang/arm due to https://bugs.llvm.org/show_bug.cgi?id=40976
> +ifndef CONFIG_CC_IS_CLANG
>  ifeq ($(CONFIG_KERNEL_MODE_NEON),y)
>    NEON_FLAGS			:= -march=armv7-a -mfloat-abi=softfp -mfpu=neon
>    CFLAGS_xor-neon.o		+= $(NEON_FLAGS)
>    obj-$(CONFIG_XOR_BLOCKS)	+= xor-neon.o
>  endif
> +endif
> diff --git a/arch/arm/lib/xor-neon.c b/arch/arm/lib/xor-neon.c
> index e1e76186ec23..84c91c48dfa2 100644
> --- a/arch/arm/lib/xor-neon.c
> +++ b/arch/arm/lib/xor-neon.c
> @@ -18,6 +18,10 @@ MODULE_LICENSE("GPL");
>   * Pull in the reference implementations while instructing GCC (through
>   * -ftree-vectorize) to attempt to exploit implicit parallelism and emit
>   * NEON instructions.
> +
> + * On Clang the loop vectorizer is enabled by default, but due to a bug
> + * (https://bugs.llvm.org/show_bug.cgi?id=40976) vectorization is broke
> + * so xor-neon is disabled in favor of the default reg implementations.
>   */
>  #ifdef CONFIG_CC_IS_GCC
>  #pragma GCC optimize "tree-vectorize"
> -- 
> 2.29.0
> 
