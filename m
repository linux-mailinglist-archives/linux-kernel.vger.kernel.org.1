Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B700E2C9619
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 04:53:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727772AbgLADwg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 22:52:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726151AbgLADwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 22:52:35 -0500
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 595F2C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 19:51:49 -0800 (PST)
Received: by mail-qk1-x741.google.com with SMTP id u4so166402qkk.10
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 19:51:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VtFp9fnvahVT0MIsHCMbum8vI3YEDjLRm/v1ir2OiuY=;
        b=deIJDzd6FBhuTLc8mVVMFzm3hAwHv0IU7Su61XrRIT+nqATJjyFfFGIFKGLphAYtZO
         w6vsICSbDUOkCxsb+2HTgpXo9YNCtfFZVtV21vts2fjPfVPVf6XIeBJms/Xhyv4hqhO+
         M2lRBMvSPG1xZR78RkkjHwFvIVYOMirtOIuuldpP6CPh1vknv8NPgVUTGcICN2Fj5qEO
         9uVvORr/APPKaUBgNqa15T2pfTw87MmovRAPh9fqyNxfJJkrxCw/Oi/a2bsSCHNQb/H7
         Emrw2EiXNBNoQF2SMZuDjymP26Mwrqc5tYESRSnQ+rnfr9hX0l/eCxw8aZgn8ycN8xKI
         TlXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VtFp9fnvahVT0MIsHCMbum8vI3YEDjLRm/v1ir2OiuY=;
        b=mnYL8c9jYWNuir0Jd2SmasoSf5llRUVXmLTtFjh+QaOGVHn0sTf5FyrHCCWEH4SSAF
         gt6PEmXXpSNfJAtvuzbgl4EAW3epff9eOdRyZ0zGNX9lJGJkdCTLZoq5adRVFJgdRDYE
         C98YxwxSaTqUPY4DDzKIhK4xd0Wo57laifaiJX37JMkRjGhkVSedBBobN+zBl8evrbts
         o62NUw8wKe5auSNA2LSNVky/J787tPa0g0d6Y6G//E34TdetDrC+w2XflYpc3v0yvRDX
         YpCHh0mkAlnGlbAys/fjl+B/nSgDF03AyVwyBFYZVCFeyVy2upEdSoflKIqQ045rZc9H
         g+tQ==
X-Gm-Message-State: AOAM530JD55iqInaG84jbuJC42GUWKOz36d5xjUQWbDYC7Ojvr28UM2/
        sjk8OI2OgSgFwcxoluje1fc=
X-Google-Smtp-Source: ABdhPJylduVhbKOY3tRHbyn/Vmi1V6OyE1JsCnLr/Ih9ui3CE2ztOOu3Gg9iyU1abzoT9Oj+5nZT0A==
X-Received: by 2002:a37:6191:: with SMTP id v139mr988147qkb.92.1606794708345;
        Mon, 30 Nov 2020 19:51:48 -0800 (PST)
Received: from ubuntu-m3-large-x86 ([2604:1380:45f1:1d00::1])
        by smtp.gmail.com with ESMTPSA id i4sm691832qti.78.2020.11.30.19.51.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Nov 2020 19:51:47 -0800 (PST)
Date:   Mon, 30 Nov 2020 20:51:46 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        David Woodhouse <dwmw2@infradead.org>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH] x86, build: remove -m16 workaround for unsupported
 versions of GCC
Message-ID: <20201201035146.GA1469908@ubuntu-m3-large-x86>
References: <20201201011307.3676986-1-ndesaulniers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201201011307.3676986-1-ndesaulniers@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 30, 2020 at 05:13:06PM -0800, 'Nick Desaulniers' via Clang Built Linux wrote:
> A revert of the following two commits.
> commit de3accdaec88 ("x86, build: Build 16-bit code with -m16 where
> possible")
> commit a9cfccee6604 ("x86, build: Change code16gcc.h from a C header to
> an assembly header")
> 
> Since commit 0bddd227f3dc ("Documentation: update for gcc 4.9
> requirement") the minimum supported version of GCC is gcc-4.9.  It's now
> safe to remove this code.
> 
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>

Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>

> ---
>  arch/x86/Makefile         |  9 +--------
>  arch/x86/boot/code16gcc.h | 12 ------------
>  2 files changed, 1 insertion(+), 20 deletions(-)
>  delete mode 100644 arch/x86/boot/code16gcc.h
> 
> diff --git a/arch/x86/Makefile b/arch/x86/Makefile
> index 1bf21746f4ce..7116da3980be 100644
> --- a/arch/x86/Makefile
> +++ b/arch/x86/Makefile
> @@ -24,14 +24,7 @@ endif
>  
>  # How to compile the 16-bit code.  Note we always compile for -march=i386;
>  # that way we can complain to the user if the CPU is insufficient.
> -#
> -# The -m16 option is supported by GCC >= 4.9 and clang >= 3.5. For
> -# older versions of GCC, include an *assembly* header to make sure that
> -# gcc doesn't play any games behind our back.
> -CODE16GCC_CFLAGS := -m32 -Wa,$(srctree)/arch/x86/boot/code16gcc.h
> -M16_CFLAGS	 := $(call cc-option, -m16, $(CODE16GCC_CFLAGS))
> -
> -REALMODE_CFLAGS	:= $(M16_CFLAGS) -g -Os -DDISABLE_BRANCH_PROFILING \
> +REALMODE_CFLAGS	:= -m16 -g -Os -DDISABLE_BRANCH_PROFILING \
>  		   -Wall -Wstrict-prototypes -march=i386 -mregparm=3 \
>  		   -fno-strict-aliasing -fomit-frame-pointer -fno-pic \
>  		   -mno-mmx -mno-sse
> diff --git a/arch/x86/boot/code16gcc.h b/arch/x86/boot/code16gcc.h
> deleted file mode 100644
> index e19fd7536307..000000000000
> --- a/arch/x86/boot/code16gcc.h
> +++ /dev/null
> @@ -1,12 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> -#
> -# code16gcc.h
> -#
> -# This file is added to the assembler via -Wa when compiling 16-bit C code.
> -# This is done this way instead via asm() to make sure gcc does not reorder
> -# things around us.
> -#
> -# gcc 4.9+ has a real -m16 option so we can drop this hack long term.
> -#
> -
> -	.code16gcc
> -- 
> 2.29.2.454.gaff20da3a2-goog
> 
