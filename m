Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07FD72AACA7
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Nov 2020 18:40:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728537AbgKHRkS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Nov 2020 12:40:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727570AbgKHRkS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Nov 2020 12:40:18 -0500
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20ACAC0613CF
        for <linux-kernel@vger.kernel.org>; Sun,  8 Nov 2020 09:40:18 -0800 (PST)
Received: by mail-qk1-x743.google.com with SMTP id r7so5952142qkf.3
        for <linux-kernel@vger.kernel.org>; Sun, 08 Nov 2020 09:40:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BgT2CP26pzdejYHyc1QoimRmV9Baz6Lnq3lNUhEBR1U=;
        b=oTiZFw3p+N+PvikLX4+DAzQiM6BSG4w4ttHWPMqGHiNIRb9obfo91xrHOq2e7Vi3/F
         +tv1rlZ/uiojHfLfWfzoZKWtKH+OwqggVWT4DpkH7ggAxeIhxutHkdsRqIH8NGNJbda8
         Yh1QdaYwrF0H/tLXYXac6AdB6pjJgdYHEr7G6sYna+yILlgVXj1H+/3u/62tQCM8zU07
         0bqyf0aIEUt8KZBD3x8mJFz+XinlMFEx6s1lKABpn9RqDrFPKyyFBAziSnSioq/tqk7e
         w3o2zTwGNImgNATxDMg1yqjH/3ToH9wXTzSbg1PUfwD81PE9zlS1UQtHkBpm1AnZA3Eq
         pMqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=BgT2CP26pzdejYHyc1QoimRmV9Baz6Lnq3lNUhEBR1U=;
        b=JLLAkPxcuwB7efWNQE0vHtGEcMiA9VYyqWl5995KDtFNLh25xKvQBnyIvCn98HodNU
         IHFVYqMWL8DI7SL9ppjElbyV48o+dG3EQY3n+RpnoHZ3+kZCtxE8PFAOllIwHiZebH/y
         yuFCupTgc822qQo5zJK+vAD1tw4mXU6Zv0zwslMRZon9xUDBspulkcJcEhJpgfOfIDvE
         xNc1MXRcTrmd1IB/8XfLWB5PHwUfPBh+qgJxEtzPH17bgY2dz1d9RIdZALob5w69TrFZ
         hRy9ofhbI6TvDy9i7BHlccehebwaUJYuWTyUs204wMCszixRE90XZZinit5nZH6JD83m
         wK3Q==
X-Gm-Message-State: AOAM533IstBjYhBz8sZdYbZIBr4koGqHByEXUbQDMeC6Ct5bMTElCDM9
        MmIhr7FVbLFFwFATzXGMFsE=
X-Google-Smtp-Source: ABdhPJxEn8FFMo8ZvgDetMdWJcp3APOG6Lq+Nvj71XjGeAzlU4WcoJzrs8OLhaHlnx4m/BefT/NQ7w==
X-Received: by 2002:a37:458c:: with SMTP id s134mr10034685qka.405.1604857216288;
        Sun, 08 Nov 2020 09:40:16 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id y14sm2723654qkj.56.2020.11.08.09.40.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2020 09:40:15 -0800 (PST)
Sender: Arvind Sankar <niveditas98@gmail.com>
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Sun, 8 Nov 2020 12:40:14 -0500
To:     Adrian Ratiu <adrian.ratiu@collabora.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        clang-built-linux@googlegroups.com,
        Russell King <linux@armlinux.org.uk>,
        linux-kernel@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCH 2/2] arm: lib: xor-neon: disable clang vectorization
Message-ID: <20201108174014.GA219672@rani.riverdale.lan>
References: <20201106051436.2384842-1-adrian.ratiu@collabora.com>
 <20201106051436.2384842-3-adrian.ratiu@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201106051436.2384842-3-adrian.ratiu@collabora.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

It's actually a bad idea to use #pragma GCC optimize. This is basically
the same as tagging all the functions with __attribute__((optimize)),
which GCC does not recommend for production use, as it _replaces_
optimization options rather than appending to them, and has been
observed to result in dropping important compiler flags.

There've been a few discussions recently around other such cases:
https://lore.kernel.org/lkml/20201028171506.15682-1-ardb@kernel.org/
https://lore.kernel.org/lkml/20201028081123.GT2628@hirez.programming.kicks-ass.net/

For this file, given that it is supposed to use -ftree-vectorize for the
whole file anyway, is there any reason it's not just added to CFLAGS via
the Makefile? This seems to be the only use of pragma optimize in the
kernel.
