Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DA972B10AA
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 22:50:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727407AbgKLVur (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 16:50:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727175AbgKLVuq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 16:50:46 -0500
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 083E7C0613D1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 13:50:28 -0800 (PST)
Received: by mail-qv1-xf43.google.com with SMTP id 63so3624785qva.7
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 13:50:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=t9uXZCibzviLXlkgFY4GlBUcWyC+ILxJ08Y+bCgohJU=;
        b=VyGxocSmPg4RrrGNwXgWztdjbpB73rGxNVKmW+2IY6Egk1yzOg40htvWXAB4naQnu/
         l2n0HX7ghW6xjkoVRopg/KjX69zGaoEDNm5eY+7Ma6iZ+D3vkL17ZcTECxqcZoZxp+Uz
         iE0631W6P6SaIbr7TNMPqRlhGaAAT96lLMXJifjjHbw0WhP2wx7QhuBT/YPfL0XSN1LV
         RasrnAFj54wOXI7wTaxrs7CMU9/KyrMO4CGnJWlcywhxFUZo0RwTSxVt+HL45SiyM0P2
         dwb79kAqyef1KwfAhOGkDC9i2ZhL9Ca6sX3WBr5pEp0cpmYgp1arsy1yvLpnftjEOIX5
         7CvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=t9uXZCibzviLXlkgFY4GlBUcWyC+ILxJ08Y+bCgohJU=;
        b=X4urTyBoYAcZa4Jk5hif7F57xmsU4HMLPHUMyb6IRD+eERNIDgsdUeZEOMR6dMWRer
         GSpoCh9BeM8vKVmsWF/e7r8DnRyxUVjauHDZg2Zi0rM5DgeTR2zI1MDrkPZ7vEns+LO7
         I+b4ljIPCajYK5yYCj0j4tC/1V30wCLZaE7IYwb7IMDrwiy5naoNAP+4va1jKIqZhk1M
         Dx18ekFNjHr9QyGA1iFzuCerGPnef2dHBoghVesrNaJSM21SPa8D/HA22+JWQOKzc/hL
         6+sy/KWT1INFwUD++GTPEGYqZglCKXnDLdncBL8khAwwRTHwbpfDymeb4lJDDlQtKiXA
         8UuQ==
X-Gm-Message-State: AOAM533hreDwd0A2QpCWi2KsaHaFFlqEhWUUA4M4vVAoqYxISvENoYCG
        jOpl8dXm/CeePWG0NoLwxfY=
X-Google-Smtp-Source: ABdhPJwwjeIGSpEqK0ybnz7jrBCdWnJ4NhCVGZAglGDWhPcSFc0w3wl6TadNymaYztLPsibE5s/bSQ==
X-Received: by 2002:a0c:b65b:: with SMTP id q27mr1836700qvf.8.1605217827183;
        Thu, 12 Nov 2020 13:50:27 -0800 (PST)
Received: from ubuntu-m3-large-x86 ([2604:1380:45f1:1d00::1])
        by smtp.gmail.com with ESMTPSA id l3sm6045092qkj.114.2020.11.12.13.50.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 13:50:26 -0800 (PST)
Date:   Thu, 12 Nov 2020 14:50:25 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Adrian Ratiu <adrian.ratiu@collabora.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Ard Biesheuvel <ardb@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>, kernel@collabora.com,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] arm: lib: xor-neon: move pragma options to
 makefile
Message-ID: <20201112215025.GA55620@ubuntu-m3-large-x86>
References: <20201112212457.2042105-1-adrian.ratiu@collabora.com>
 <20201112212457.2042105-3-adrian.ratiu@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201112212457.2042105-3-adrian.ratiu@collabora.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 12, 2020 at 11:24:57PM +0200, Adrian Ratiu wrote:
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

Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>

> ---
>  arch/arm/lib/Makefile   |  2 +-
>  arch/arm/lib/xor-neon.c | 10 ----------
>  2 files changed, 1 insertion(+), 11 deletions(-)
> 
> diff --git a/arch/arm/lib/Makefile b/arch/arm/lib/Makefile
> index 6d2ba454f25b..12d31d1a7630 100644
> --- a/arch/arm/lib/Makefile
> +++ b/arch/arm/lib/Makefile
> @@ -45,6 +45,6 @@ $(obj)/csumpartialcopyuser.o:	$(obj)/csumpartialcopygeneric.S
>  
>  ifeq ($(CONFIG_KERNEL_MODE_NEON),y)
>    NEON_FLAGS			:= -march=armv7-a -mfloat-abi=softfp -mfpu=neon
> -  CFLAGS_xor-neon.o		+= $(NEON_FLAGS)
> +  CFLAGS_xor-neon.o		+= $(NEON_FLAGS) -ftree-vectorize -Wno-unused-variable
>    obj-$(CONFIG_XOR_BLOCKS)	+= xor-neon.o
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
