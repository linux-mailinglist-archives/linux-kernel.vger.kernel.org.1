Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E06412B7199
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 23:31:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729067AbgKQWai (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 17:30:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728044AbgKQWai (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 17:30:38 -0500
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 081B9C0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 14:30:38 -0800 (PST)
Received: by mail-qt1-x844.google.com with SMTP id f93so88077qtb.10
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 14:30:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6UpOAhvGOOk2ewOvXmMzn6cPIkdxIFd9wzKXGMY8TT0=;
        b=l95DD1yAoHtR1mBEU5zvmO0YUKK5XuEjDkNVrDstszRlQczHLAsdHV/Mmb6eIAD0x9
         XufocxDpqqTl1rpEPYE+MNL1U87kwvwLV1zMRBt0BLSqyBn5opJhgvvJ4Fx2StTm+yz1
         D1MFl3W37RJR/QzJOD+aMxhvc//tPW/t/sql7LqNHuB1hLQKzlZZCR6xs2gZ0sAsSnlX
         +r99vKx9bRbQyTSHzH6SAtptLtKnJBVRwsUFeb64eO4vNH3NNjr6wjDr9ToUCptO7I6a
         I4tzbT45MJiq4leeGs3jtZ/TEN/ZanqU9lOt0l671eSSseANEK0wrGFS2Ew7QJ8wg7Pz
         +cxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=6UpOAhvGOOk2ewOvXmMzn6cPIkdxIFd9wzKXGMY8TT0=;
        b=W7ZwDZxcaX2y0otvnM45dxo6qcmr8jAzstpturetj8fXV7TNoWc8MIRt7OlIV7fHko
         XYZebqILd+bWJImyVEoV9hWR2BMkIElvhzxYNWJq3Cbhbai4Ke9b5t606e2cTitqFx/z
         iifQyzbVcJfz572S1zns+rwaSSdZCkC6Yko75rGS8StTN+OtpJkxCWPrLb2jYOwFpNSA
         mK/+P8/Hdj1DJRiyq3zB+4EMu2ZaJTJU7y508tjxvLxzDaFtsoS50AQSOEo5kqYI4yFD
         8VxbAdigux/Evx52LkrvQFmGXAInkFQPJtg3BuYYAODSri8O+gXgKuvBFkT3UhT6LmoY
         d46A==
X-Gm-Message-State: AOAM533oDaBvQQil/W+ssw1qoQSRqiUSxYpdf0ul4bxkh3pnjboKnR+r
        jpyZQA9S9X1LMHkH5zO37MU=
X-Google-Smtp-Source: ABdhPJz8a5cDcx1y+L9qG9bzPYayTTf3BP7O0zJowaV3p4MU3PLuXyIqvDkehl7YwsVH/v27Xa53HA==
X-Received: by 2002:ac8:4cdb:: with SMTP id l27mr1974889qtv.74.1605652237175;
        Tue, 17 Nov 2020 14:30:37 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id n93sm14757574qtd.7.2020.11.17.14.30.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2020 14:30:36 -0800 (PST)
Sender: Arvind Sankar <niveditas98@gmail.com>
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Tue, 17 Nov 2020 17:30:34 -0500
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        clang-built-linux@googlegroups.com, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] powerpc: boot: include compiler_attributes.h
Message-ID: <20201117223034.GA1614446@rani.riverdale.lan>
References: <20201116043532.4032932-1-ndesaulniers@google.com>
 <20201116043532.4032932-2-ndesaulniers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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

This should be "compiler_attributes.h".

> 
> Link: https://github.com/ClangBuiltLinux/linux/issues/236
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
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
