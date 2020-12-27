Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9343F2E2FC6
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Dec 2020 04:34:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726203AbgL0DcG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Dec 2020 22:32:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726025AbgL0DcF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Dec 2020 22:32:05 -0500
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0141C0613ED
        for <linux-kernel@vger.kernel.org>; Sat, 26 Dec 2020 19:31:25 -0800 (PST)
Received: by mail-qt1-x82b.google.com with SMTP id 7so5035540qtp.1
        for <linux-kernel@vger.kernel.org>; Sat, 26 Dec 2020 19:31:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=EbFmFXuAZx6U2A2wGjp3rcMvZ/cJc1YG+CVcb98AIDQ=;
        b=pRBlCLWfpSm/czQFn4KO/tjj8CMRWXnfLcu2SM1JbeuH8Z3/Yp17zjZ91oFnHfpIIB
         /AeoqtZDVZp1U0LIqRrUu40CxBKSrg3srbm/CssolPabw/caiQBuGbplLFj+a2d3ylaz
         EUtp9eht7AG0oIb6eO4HFlJHnrvwvXVdK1XwLHuunuwHhCUK9NuqzLf8xcN+Vm+8r9nk
         uNexcmExvx6JcEvDEvSEnu8KHqhIBP3xqWoNhFVJSyS3/alHyNsuxL6DshF1vTyHXPU7
         y3hrlGfB1DX0d3iY05J0oua0LYxwyIcHbnU+68px8/afYaEAhn4ywMRQbHZvDiZpSA0A
         f/jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=EbFmFXuAZx6U2A2wGjp3rcMvZ/cJc1YG+CVcb98AIDQ=;
        b=UeH69ELIwCw8PCHVrEfx+YWexJIXiqcWXNLDkBe4H51pTBdrPoWnNVQmwRQzON3o/Y
         lYARr2tyWurH3vLGYCVbK9wLstM/6p4wiLd6Yhx8jqdL6tinoWs6Y3z0dIfzFxVp5xV1
         5mN61eimUSYfpNDwFeqT7KpVCIb2TA0jZUwuUjYzbapCQXO0z7jIzN+OssVcGoP+TRQ8
         aqLf6oSXt6ywtTgUyzQzwlonbv4HZ57ougHIgehxLPxA0NU6JJG0p7lJEMwCpY3Dotxc
         n2UoB6qo03h0LyxKvoaM57WEmoyYVbdXf8VYx1/1CnWgFOHdLX+xu7EPbZK6zY2w+hRm
         32Mw==
X-Gm-Message-State: AOAM533lZ4pmBwJrjwI5jtQto1Guh0JfwjaNmPGYtyPgUErcs/GLuBOw
        AsYV7h0d54r37srktQZ3/yo=
X-Google-Smtp-Source: ABdhPJy0GHmpBw5myQo22C8NYsSFjuHii6uVB/6JCGJWWirQZO85h9Dw7a1OVAqdYr9oInA3Vmhvsw==
X-Received: by 2002:ac8:7654:: with SMTP id i20mr37758757qtr.291.1609039884505;
        Sat, 26 Dec 2020 19:31:24 -0800 (PST)
Received: from ubuntu-m3-large-x86 ([2604:1380:45f1:1d00::1])
        by smtp.gmail.com with ESMTPSA id 198sm20708580qkk.4.2020.12.26.19.31.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Dec 2020 19:31:23 -0800 (PST)
Date:   Sat, 26 Dec 2020 20:31:22 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     John Millikin <jmillikin@gmail.com>
Cc:     hpa@zytor.com, x86@kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        John Millikin <john@john-millikin.com>
Subject: Re: [PATCH v2] arch/x86: Propagate $(CLANG_FLAGS) to
 $(REALMODE_FLAGS)
Message-ID: <20201227033122.GA1993664@ubuntu-m3-large-x86>
References: <cceb074c-861c-d716-5e19-834a8492f245@gmail.com>
 <37DE7046-5096-4C0C-A96D-FD168A849DFD@zytor.com>
 <20201226075347.GA1977841@ubuntu-m3-large-x86>
 <3b793c42-8983-4502-1f9e-729cc0ebec47@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3b793c42-8983-4502-1f9e-729cc0ebec47@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 26, 2020 at 05:41:25PM +0900, John Millikin wrote:
> When cross-compiling with Clang, the `$(CLANG_FLAGS)' variable
> contains additional flags needed to build C and assembly sources
> for the target platform. Normally this variable is automatically
> included in `$(KBUILD_CFLAGS)' by via the top-level Makefile.
> 
> The x86 real-mode makefile builds `$(REALMODE_CFLAGS)' from a
> plain assignment and therefore drops the Clang flags. This causes
> Clang to not recognize x86-specific assembler directives:
> 
>   arch/x86/realmode/rm/header.S:36:1: error: unknown directive
>   .type real_mode_header STT_OBJECT ; .size real_mode_header, .-real_mode_header
>   ^
> 
> Explicit propagation of `$(CLANG_FLAGS)' to `$(REALMODE_CFLAGS)',
> which is inherited by real-mode make rules, fixes cross-compilation
> with Clang for x86 targets.
> 
> Relevant flags:
> 
> * `--target' sets the target architecture when cross-compiling. This
>   flag must be set for both compilation and assembly (`KBUILD_AFLAGS')
>   to support architecture-specific assembler directives.
> 
> * `-no-integrated-as' tells clang to assemble with GNU Assembler
>   instead of its built-in LLVM assembler. This flag is set by default
>   unless `LLVM_IAS=1' is set, because the LLVM assembler can't yet
>   parse certain GNU extensions.
> 
> Signed-off-by: John Millikin <john@john-millikin.com>

Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>

> ---
> Changes in v2:
>   - Reworded the commit message to highlight that this is for
>     cross-compilation.
>   - Removed the `ifdef CONFIG_CC_IS_CLANG' guard.
> 
>  arch/x86/Makefile | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/x86/Makefile b/arch/x86/Makefile
> index 7116da3980be..412b849063ec 100644
> --- a/arch/x86/Makefile
> +++ b/arch/x86/Makefile
> @@ -33,6 +33,7 @@ REALMODE_CFLAGS += -ffreestanding
>  REALMODE_CFLAGS += -fno-stack-protector
>  REALMODE_CFLAGS += $(call __cc-option, $(CC), $(REALMODE_CFLAGS), -Wno-address-of-packed-member)
>  REALMODE_CFLAGS += $(call __cc-option, $(CC), $(REALMODE_CFLAGS), $(cc_stack_align4))
> +REALMODE_CFLAGS += $(CLANG_FLAGS)
>  export REALMODE_CFLAGS
>  
>  # BITS is used as extension for files which are available in a 32 bit
> -- 
> 2.29.2
> 
> 
