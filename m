Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBDD31C229B
	for <lists+linux-kernel@lfdr.de>; Sat,  2 May 2020 05:43:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726759AbgEBDnK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 May 2020 23:43:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726473AbgEBDnK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 23:43:10 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10C89C061A0C
        for <linux-kernel@vger.kernel.org>; Fri,  1 May 2020 20:43:10 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id i13so1600675oie.9
        for <linux-kernel@vger.kernel.org>; Fri, 01 May 2020 20:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=R5gKcAhtGMy8Ketx1mS4p/ONHNY9/H41NnazeLBqjX0=;
        b=T14eaIz6l5Sw2CzC8t5t34Q0gf+5KG+tJDPxVBq0eJQP9PEIhijlBDQP1ktR1+Uklz
         A4XkDfvY0ByeViP6Qk7MaasB3fIASD3NL4vF7i3of/ttceW/jBhuWw1QgTNIx3bGR6T0
         ezDWK1fdSMJ1oZLTvUj6Py41gJcKs8fq0oY1GCVTQDIKJjXBteaxTz5ZnZBT7prkxuF5
         ncVh5QbG8Qy2R7wbbwnH23NsEXFIwu9f0DOTy+XBRoEp7RvuE7m7s6GTqDz/2sWlEDqa
         M4RBVlFFfb+qhBVxc2ow8PtzDVVhZ5WE/q/E/9RPInCNzFIAABlhN4buahJLOoFUVBH2
         7JGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=R5gKcAhtGMy8Ketx1mS4p/ONHNY9/H41NnazeLBqjX0=;
        b=RZpGTv2+cAvZmTxrKAVa+3CjvLcED+eKVe+nbGNZx9squjn06J6VOiCF0+h9nwZGI1
         Yp6cZ6CmOP2LSmGRcuSORA46wGO5fn3Bfvo7J62CrNWK+zm7XLhmAO/8FWCFQ2mtoU9T
         u89fnYVV3yeyN4FcauLz1n81DlgFoIPaxFFtYJKpbLlU1cfFIoU0BCzpQV+n042UZQIo
         gWlkwa6IZdM2xAHg1SmewqtYRRfYMCqkB/FmXDvC5st+dHqXN4+MVkHQRXxygNaJDUJk
         qF0BMcKmdJSFj1mDyydFR5+lSRk33CDeoMXW1IyZlKApCK+rgZi5gmcD9vXoOKLJjJ1+
         tk+g==
X-Gm-Message-State: AGi0PuZToQfkqiFmi2vF9Pj2bs8zQF6A8f5CiDKTs5ieeKzL/W0VBsV0
        5mlW0krXZMx1a7jKrDixcHI=
X-Google-Smtp-Source: APiQypKwk41ikGZT+95iCDtykzwgAamfKs3go2D6gCZ5Tt9YPj9Kq3R+Td+FaylwaQfPvWlBXFhwKg==
X-Received: by 2002:aca:f2d5:: with SMTP id q204mr1981188oih.98.1588390989226;
        Fri, 01 May 2020 20:43:09 -0700 (PDT)
Received: from ubuntu-s3-xlarge-x86 ([2604:1380:4111:8b00::1])
        by smtp.gmail.com with ESMTPSA id e91sm1362262otb.40.2020.05.01.20.43.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2020 20:43:08 -0700 (PDT)
Date:   Fri, 1 May 2020 20:43:07 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Dmitry Golovin <dima@golovin.in>
Cc:     clang-built-linux@googlegroups.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Daniel Kiper <daniel.kiper@oracle.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/boot: allow a relocatable kernel to be linked with
 lld
Message-ID: <20200502034307.GA2971661@ubuntu-s3-xlarge-x86>
References: <20200501084215.242-1-dima@golovin.in>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200501084215.242-1-dima@golovin.in>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 01, 2020 at 08:42:13AM +0000, Dmitry Golovin wrote:
> LLD by default disallows relocations in read-only segments. For a
> relocatable kernel, we pass -z notext to the linker to explicitly
> allow relocations. This behavior is the default for BFD.
> 
> Link: https://github.com/ClangBuiltLinux/linux/issues/579
> Signed-off-by: Dmitry Golovin <dima@golovin.in>

I was able to link a Clang built i386_defconfig kernel with ld.lld and
boot it in QEMU 5.0 after this change. A GCC built kernel links still
with ld.bfd and also boots in QEMU successfully. x86_64_defconfig with
both compilers and their respective linkers did not regress.

Tested-by: Nathan Chancellor <natechancellor@gmail.com>

> ---
>  arch/x86/boot/compressed/Makefile | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
> index 5f7c262bcc99..7214751e1671 100644
> --- a/arch/x86/boot/compressed/Makefile
> +++ b/arch/x86/boot/compressed/Makefile
> @@ -57,6 +57,9 @@ else
>  KBUILD_LDFLAGS += $(shell $(LD) --help 2>&1 | grep -q "\-z noreloc-overflow" \
>  	&& echo "-z noreloc-overflow -pie --no-dynamic-linker")
>  endif
> +ifeq ($(CONFIG_RELOCATABLE), y)
> +KBUILD_LDFLAGS += -z notext
> +endif
>  LDFLAGS_vmlinux := -T
>  
>  hostprogs	:= mkpiggy
> -- 
> 2.25.1
> 
