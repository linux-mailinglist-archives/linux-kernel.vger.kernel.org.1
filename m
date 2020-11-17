Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D7392B57A1
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 04:03:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727512AbgKQDCC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 22:02:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726625AbgKQDCB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 22:02:01 -0500
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87B33C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 19:02:01 -0800 (PST)
Received: by mail-qt1-x843.google.com with SMTP id v11so14684422qtq.12
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 19:02:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/RX5/tcWvfpmbLMRcPAk9O2TQzIviRgD54vpKLoaWpo=;
        b=hE5VawGm0ZXhtyP4Qnc7smJ9fE0kivKCkJDRbzIgQpVCbM7l5C1yAgEGuAzk6a2mUt
         PIEEM7AXFJ3WKNkh9hw4ZEp9O/i/dDJQu+jH6yn3Fq4LQAF0Kt4D9oczRHO6/qUwCEkC
         QZxbdKwknqfKqBYFXPlvqJZ0hI1Y/aWUecFc7IRAwp236qdqZ3SRP3ZrL58wsGTHgowe
         GJz4eC7I9upCGh16Dniv0Wpp2wqb+4I4w0Ar6eqYqqA6LkT/zkWvEy29BwXpGYkrlk4a
         C46XndyIAaMhe78TeusGoMt7gF50hWn1UozXFop/1pI0JlZmsxnH4cWyolkhpXMwxMhg
         DpUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/RX5/tcWvfpmbLMRcPAk9O2TQzIviRgD54vpKLoaWpo=;
        b=Qv8vMRRceCHZ4DptzI0Gaz+l2uCGHbljRrG5IyaeLA95ZbLhbYy4F+K4M0U173nnA7
         kv3x1vYtsEuM1VK3G7Y692Qeg6tOMyQIbmDRdf2XucxrcfSc/LP2E5tYW1tNAZTSUa1D
         ql83qE7afQpy625uqP8m9jkK4mFzvItfTBayhCxrmkuMGq92d+DmrKcEKN3E/opO2+Wg
         VQLaflFZWkdXnd3FyZ5hRVvrz+flaSUJNJj67YM7Lgqu6MAS6edX5wTAx+uJmN2NOyKh
         joGpadXE1Xg8pixReHzaNLOfEYkB1IXjl+wNjBl1V6oA1C+vlDyNcG1y0KKYqkGcw4T2
         Au9A==
X-Gm-Message-State: AOAM531BsJnxVothMZ//wbIuLKcumHl3efcZAAC8iF9WpQjmqB6Vtw4U
        itoej3hfaCEdA/bs1LNvdas=
X-Google-Smtp-Source: ABdhPJybNXsp0ywENwQ4p8uGxyep3MTJjKfuwKRz9vzeCFZK/b/W/bGFy6NX8R8GdC5B0cMjcnKBRQ==
X-Received: by 2002:ac8:7081:: with SMTP id y1mr17205582qto.72.1605582120723;
        Mon, 16 Nov 2020 19:02:00 -0800 (PST)
Received: from ubuntu-m3-large-x86 ([2604:1380:45f1:1d00::1])
        by smtp.gmail.com with ESMTPSA id o63sm13359774qkd.96.2020.11.16.19.01.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 19:02:00 -0800 (PST)
Date:   Mon, 16 Nov 2020 20:01:58 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        clang-built-linux@googlegroups.com, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] powerpc: boot: include compiler_attributes.h
Message-ID: <20201117030158.GA1340689@ubuntu-m3-large-x86>
References: <20201116043532.4032932-1-ndesaulniers@google.com>
 <20201116043532.4032932-2-ndesaulniers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201116043532.4032932-2-ndesaulniers@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 15, 2020 at 08:35:30PM -0800, Nick Desaulniers wrote:
> The kernel uses `-include` to include include/linux/compiler_types.h
> into all translation units (see scripts/Makefile.lib), which #includes
> compiler_attributes.h.
> 
> arch/powerpc/boot/ uses different compiler flags from the rest of the
> kernel. As such, it doesn't contain the definitions from these headers,
> and redefines a few that it needs.
> 
> For the purpose of enabling -Wimplicit-fallthrough for ppc, include
> compiler_types.h via `-include`.
> 
> Link: https://github.com/ClangBuiltLinux/linux/issues/236
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>

Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>
Tested-by: Nathan Chancellor <natechancellor@gmail.com>

> ---
> We could just `#include "include/linux/compiler_types.h"` in the few .c
> sources used from lib/ (there are proper header guards in
> compiler_types.h).
> 
> It was also noted in 6a9dc5fd6170 that we could -D__KERNEL__ and
> -include compiler_types.h like the main kernel does, though testing that
> produces a whole sea of warnings to cleanup. This approach is minimally
> invasive.
> 
>  arch/powerpc/boot/Makefile     | 1 +
>  arch/powerpc/boot/decompress.c | 1 -
>  2 files changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
> index f8ce6d2dde7b..1659963a8f1d 100644
> --- a/arch/powerpc/boot/Makefile
> +++ b/arch/powerpc/boot/Makefile
> @@ -31,6 +31,7 @@ endif
>  BOOTCFLAGS    := -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs \
>  		 -fno-strict-aliasing -O2 -msoft-float -mno-altivec -mno-vsx \
>  		 -pipe -fomit-frame-pointer -fno-builtin -fPIC -nostdinc \
> +		 -include $(srctree)/include/linux/compiler_attributes.h \
>  		 $(LINUXINCLUDE)
>  
>  ifdef CONFIG_PPC64_BOOT_WRAPPER
> diff --git a/arch/powerpc/boot/decompress.c b/arch/powerpc/boot/decompress.c
> index 8bf39ef7d2df..6098b879ac97 100644
> --- a/arch/powerpc/boot/decompress.c
> +++ b/arch/powerpc/boot/decompress.c
> @@ -21,7 +21,6 @@
>  
>  #define STATIC static
>  #define INIT
> -#define __always_inline inline
>  
>  /*
>   * The build process will copy the required zlib source files and headers
> -- 
> 2.29.2.299.gdc1121823c-goog
> 
