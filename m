Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 672AA2FC293
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 22:44:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729374AbhASVhX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 16:37:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:44848 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728534AbhASVfn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 16:35:43 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4C1EB23108
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 21:35:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611092102;
        bh=keqlKtOQD4XedOyHnagcNlojhAjx8I81gQvxO1o/NBs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=lvGlPC0JWcNJCPwvWTZ4IBXuN3ILNAun90WbALBbkbgjUQCJUD8kiILj3Vw60iKMT
         xeAg4f4kMox2t/yp0okEnSfLCyWqO1CURvgRWypZY7j7UuvDDOYVcuEQWlPJyKmy4Y
         Pz7ihHKwLTdULmcazSNbJUP/I3SIr7ZJQkBNEWreuIF7wry4dXD6IDKw04nl7qfPf1
         RQ4cKrOlGX/NtPZxUWgOC7QWylnG5BQloCQd3K0Eq1bFLHszjz9yEaaV7I5jvggl7q
         NrX9cA/I0ArPasWsYWYqK5SxCFsbveHYNA1pPIJRlAklkqrQohxLAsoFx7+IyyvKx3
         0IGYS+vbX3sfQ==
Received: by mail-ot1-f44.google.com with SMTP id b24so21340846otj.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 13:35:02 -0800 (PST)
X-Gm-Message-State: AOAM530H2uWScJNFYSgFuVJU4s1/guVXG8M91QV4ORAM6A1//tZayLKB
        yjxE/Z1tNj8WIyRspBJxHYRE4WuoE3AEAUJufnE=
X-Google-Smtp-Source: ABdhPJw0ENVDjB/znaas4uhePniF7Y+ibmCXWojYKtwjd3FZdbeHG5Sxq+Qvg44w5EvXekS6S+t98cpXgn8NExbJuTg=
X-Received: by 2002:a9d:3bb7:: with SMTP id k52mr5017892otc.251.1611092101555;
 Tue, 19 Jan 2021 13:35:01 -0800 (PST)
MIME-Version: 1.0
References: <20210119131724.308884-1-adrian.ratiu@collabora.com>
 <20210119131724.308884-2-adrian.ratiu@collabora.com> <CAKwvOdkNZ09kkzi+A8diaxViqSufxrHizuBu-7quG6an3Z8iDA@mail.gmail.com>
In-Reply-To: <CAKwvOdkNZ09kkzi+A8diaxViqSufxrHizuBu-7quG6an3Z8iDA@mail.gmail.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Tue, 19 Jan 2021 22:34:45 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0XWVu-oG3YaGppZDedRL=SA37Gr8YM4cojVap5Bwk2TA@mail.gmail.com>
Message-ID: <CAK8P3a0XWVu-oG3YaGppZDedRL=SA37Gr8YM4cojVap5Bwk2TA@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] arm: lib: xor-neon: remove unnecessary GCC < 4.6 warning
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Adrian Ratiu <adrian.ratiu@collabora.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Ard Biesheuvel <ardb@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Collabora Kernel ML <kernel@collabora.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 19, 2021 at 10:18 PM 'Nick Desaulniers' via Clang Built
Linux <clang-built-linux@googlegroups.com> wrote:
>
> On Tue, Jan 19, 2021 at 5:17 AM Adrian Ratiu <adrian.ratiu@collabora.com> wrote:
> > diff --git a/arch/arm/lib/xor-neon.c b/arch/arm/lib/xor-neon.c
> > index b99dd8e1c93f..f9f3601cc2d1 100644
> > --- a/arch/arm/lib/xor-neon.c
> > +++ b/arch/arm/lib/xor-neon.c
> > @@ -14,20 +14,22 @@ MODULE_LICENSE("GPL");
> >  #error You should compile this file with '-march=armv7-a -mfloat-abi=softfp -mfpu=neon'
> >  #endif
> >
> > +/*
> > + * TODO: Even though -ftree-vectorize is enabled by default in Clang, the
> > + * compiler does not produce vectorized code due to its cost model.
> > + * See: https://github.com/ClangBuiltLinux/linux/issues/503
> > + */
> > +#ifdef CONFIG_CC_IS_CLANG
> > +#warning Clang does not vectorize code in this file.
> > +#endif
>
> Arnd, remind me again why it's a bug that the compiler's cost model
> says it's faster to not produce a vectorized version of these loops?
> I stand by my previous comment: https://bugs.llvm.org/show_bug.cgi?id=40976#c8

The point is that without vectorizing the code, there is no point in building
both the default xor code and a "neon" version that has to save/restore
the neon registers but doesn't actually use them.

          Arnd
