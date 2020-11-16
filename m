Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFED42B3D12
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 07:27:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbgKPGZX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 01:25:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:35328 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726748AbgKPGZX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 01:25:23 -0500
Received: from embeddedor (187-162-31-110.static.axtel.net [187.162.31.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 37E3C2222E;
        Mon, 16 Nov 2020 06:25:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605507922;
        bh=6iMXPpdRwjfJl1AzT9UUVU5OjRz0k5d7CTscWPqcFcw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Aqxp/8zPPN9Fi+Sgx/nuDXqV3YG+y3D6wb6vftxs9HrS77om7VCthmWK5V4RzsUG/
         H9gWro2oS4+nS5GQvv4dBPzccnFstDjBtEOUGX/yB99VYknvMPs1YCN+/2ZMBkU9HE
         CTeG81QWZTg0O1AQtp3NhuzzFXyCMS1ZeuXRB3bI=
Date:   Mon, 16 Nov 2020 00:25:15 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        clang-built-linux@googlegroups.com, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] powerpc: boot: include compiler_attributes.h
Message-ID: <20201116062515.GA7265@embeddedor>
References: <20201116043532.4032932-1-ndesaulniers@google.com>
 <20201116043532.4032932-2-ndesaulniers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201116043532.4032932-2-ndesaulniers@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
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

Acked-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks, Nick.
--
Gustavo

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
