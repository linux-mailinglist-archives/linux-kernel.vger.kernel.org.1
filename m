Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 101932B16BA
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 08:50:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726196AbgKMHue (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 02:50:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:48450 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725866AbgKMHue (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 02:50:34 -0500
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8A77D208D5
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 07:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605253833;
        bh=d6BGyCcCSgbHoYMKMxTIl0AJYabKgxYHNH+q+hkvaho=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=wewAVQn1W4pd4getXESlJMCq4Vj3/AT37H2Rz5gNA0D8n1QlIfVLMj29ZlqRbSikM
         tt1/C6F8v/oIIS9Hu9VRcNgay1/48d8qTFmgPxXxN/vRVwBQ+zwMmEoOm5A2dmHsgz
         Gv88P56niLiVBD1YFbAMWaegrTsRkqxMK5ZTHZcw=
Received: by mail-oo1-f46.google.com with SMTP id y3so1960252ooq.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 23:50:33 -0800 (PST)
X-Gm-Message-State: AOAM533hFWwN5MmTg7GT8XcgNXpTM6XhRifQrKnSIgmtJHaHR6pbuYOD
        4rTIhFRAfQc2L51rGbhp0JgqZFO6Al7rxLiN6cE=
X-Google-Smtp-Source: ABdhPJw8VK/Ch7r/ol4qAhpmBp/AAzGrTzQmky2H/AqXLAq1jo6xvl6Ejg/lU9sKycZJQrdBCUsGK1hb5pMvf5wDOhc=
X-Received: by 2002:a4a:8928:: with SMTP id f37mr621623ooi.41.1605253832849;
 Thu, 12 Nov 2020 23:50:32 -0800 (PST)
MIME-Version: 1.0
References: <20201112212457.2042105-1-adrian.ratiu@collabora.com> <20201112212457.2042105-3-adrian.ratiu@collabora.com>
In-Reply-To: <20201112212457.2042105-3-adrian.ratiu@collabora.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 13 Nov 2020 08:50:20 +0100
X-Gmail-Original-Message-ID: <CAMj1kXEpD1pp5uzOMeSYhgS_dzOysKuPMOMNgivUx58PGUdMJw@mail.gmail.com>
Message-ID: <CAMj1kXEpD1pp5uzOMeSYhgS_dzOysKuPMOMNgivUx58PGUdMJw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] arm: lib: xor-neon: move pragma options to makefile
To:     Adrian Ratiu <adrian.ratiu@collabora.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Arvind Sankar <nivedita@alum.mit.edu>, kernel@collabora.com,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Nov 2020 at 22:23, Adrian Ratiu <adrian.ratiu@collabora.com> wrote:
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

So what is the status now here? How does putting -ftree-vectorize on
the command line interact with Clang?
