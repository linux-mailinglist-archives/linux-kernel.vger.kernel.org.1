Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 576FC2FC487
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 00:15:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726212AbhASXMd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 18:12:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726828AbhASXLQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 18:11:16 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E4F0C061757
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 15:10:36 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id q20so13276593pfu.8
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 15:10:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yc+iZPAoEfYuwC32vfILEtYohiPDc+ecLJoHB/5av04=;
        b=LhWvTljfReic7CKreAe27m2eXjgN5quQoLpBNkyfD6kyC7fvFN67x3WzgydizQeZpX
         QHUr8pyMOWWgsWTCI9EZEPR4VVdIR53EqFLrzymt0haqh8jqXbt2liRnn9LA9h23/si5
         zs5hHFg+YXCudqbmyHMoAeHTK2FqjihtHpq0AiB2nDC2ON/dAUKfYDX5MQjOurHEJAuC
         CF/jFlZLN6cnymBnAA8zs27FN2pIz9LWC82+EZh7BGBKqTOhBN0tjr7NGAWXihIjdaPc
         QvioPD7khw5WFKknTbTOJAjI5NeqT+uWoRDfKpKO9hkmHBnoBWXYgjlgTKT/X5/VmKl9
         ruAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yc+iZPAoEfYuwC32vfILEtYohiPDc+ecLJoHB/5av04=;
        b=MPcqoLQJH0d/n31hqXg7EP6j8S0scMFNHUXG+AKoW4fu2CgNRy/Q3RPzknsQfmL8GM
         QMdlmDcVrMMX0q928eenzawZr07x64674nsJxa0R4BCEXEICYCLif73/tJDP/sbXGPjw
         M/ff0X7fI0mAmAa5iB+fYWdzRqBVraKVjmMyL7c/CF0RO6BPeq1910tRycwbM6VFKIcK
         xO0q6MacExdtIdGBqgf/PaPMM+GDJ2j1kJiQ/QCiPNe5aChEFtjmRiTq1nAw6h6/cdc+
         3HvLavxAQH911lbDuk8PBdhOnQI8yHPG70ttgiS6UignPDuNIC2Ue7vIZaLbeAM0KLN1
         9HXA==
X-Gm-Message-State: AOAM5306MKKAuiDOjWlReC0jsQ/w8l16pfBteCzXlbKqS3Ikx7sXDbh0
        8PcUmRqCwoqTVQpQmzgs7R3XPoRdUifWf6URwu6bzQ==
X-Google-Smtp-Source: ABdhPJytR/pnMLVH5rNG9YFjjCcNPc3W4wII4uEWPMjecfYVxyH642jAvxQIwOyx25SMyyFNuCCgogtDVv2Ga93zryk=
X-Received: by 2002:a63:5701:: with SMTP id l1mr6516095pgb.381.1611097835433;
 Tue, 19 Jan 2021 15:10:35 -0800 (PST)
MIME-Version: 1.0
References: <20210119131724.308884-1-adrian.ratiu@collabora.com>
 <20210119131724.308884-2-adrian.ratiu@collabora.com> <CAKwvOdkNZ09kkzi+A8diaxViqSufxrHizuBu-7quG6an3Z8iDA@mail.gmail.com>
 <CAK8P3a0XWVu-oG3YaGppZDedRL=SA37Gr8YM4cojVap5Bwk2TA@mail.gmail.com> <CAKwvOdmPr8T9T=tjiVGWJAw-pGzDgsKxtkLxTW4CwTrHjT-v7A@mail.gmail.com>
In-Reply-To: <CAKwvOdmPr8T9T=tjiVGWJAw-pGzDgsKxtkLxTW4CwTrHjT-v7A@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 19 Jan 2021 15:10:24 -0800
Message-ID: <CAKwvOdkoKEve-SAFgnAGyRCCHWACdFRYJpuhsCTyrsk47EG9zQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] arm: lib: xor-neon: remove unnecessary GCC < 4.6 warning
To:     Arnd Bergmann <arnd@kernel.org>
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

On Tue, Jan 19, 2021 at 2:04 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Tue, Jan 19, 2021 at 1:35 PM Arnd Bergmann <arnd@kernel.org> wrote:
> >
> > On Tue, Jan 19, 2021 at 10:18 PM 'Nick Desaulniers' via Clang Built
> > Linux <clang-built-linux@googlegroups.com> wrote:
> > >
> > > On Tue, Jan 19, 2021 at 5:17 AM Adrian Ratiu <adrian.ratiu@collabora.com> wrote:
> > > > diff --git a/arch/arm/lib/xor-neon.c b/arch/arm/lib/xor-neon.c
> > > > index b99dd8e1c93f..f9f3601cc2d1 100644
> > > > --- a/arch/arm/lib/xor-neon.c
> > > > +++ b/arch/arm/lib/xor-neon.c
> > > > @@ -14,20 +14,22 @@ MODULE_LICENSE("GPL");
> > > >  #error You should compile this file with '-march=armv7-a -mfloat-abi=softfp -mfpu=neon'
> > > >  #endif
> > > >
> > > > +/*
> > > > + * TODO: Even though -ftree-vectorize is enabled by default in Clang, the
> > > > + * compiler does not produce vectorized code due to its cost model.
> > > > + * See: https://github.com/ClangBuiltLinux/linux/issues/503
> > > > + */
> > > > +#ifdef CONFIG_CC_IS_CLANG
> > > > +#warning Clang does not vectorize code in this file.
> > > > +#endif
> > >
> > > Arnd, remind me again why it's a bug that the compiler's cost model
> > > says it's faster to not produce a vectorized version of these loops?
> > > I stand by my previous comment: https://bugs.llvm.org/show_bug.cgi?id=40976#c8
> >
> > The point is that without vectorizing the code, there is no point in building
> > both the default xor code and a "neon" version that has to save/restore
> > the neon registers but doesn't actually use them.
> >
> >           Arnd
>
> Thoughts?  Also, Nathan brings up my previous point about restrict.
> This would benefit both GCC and Clang as they would not produce 2
> "versions" of the loop; one vectorized if the std::distance between x
> & y >= 8, one scalar otherwise.  But the callers would have to ensure
> no overlap otherwise UB.
>
> diff --git a/include/asm-generic/xor.h b/include/asm-generic/xor.h
> index b62a2a56a4d4..7db16adc7d89 100644
> --- a/include/asm-generic/xor.h
> +++ b/include/asm-generic/xor.h
> @@ -7,12 +7,21 @@
>
>  #include <linux/prefetch.h>
>
> +/* Overrule LLVM's cost model in order to always produce a vectorized loop
> + * version.
> + */
> +#if defined(__clang__) && defined(CONFIG_ARM)
> +#define FORCE_VECTORIZE _Pragma("clang loop vectorize(enable)")
> +#else
> +#define CLANG_FORCE_VECTORIZE

^ err, I had renamed it, but missed this. Should have been
`FORCE_VECTORIZE` but you catch the drift.

> +#endif
> +
>  static void
>  xor_8regs_2(unsigned long bytes, unsigned long *p1, unsigned long *p2)
>  {
>         long lines = bytes / (sizeof (long)) / 8;
>
> -       do {
> +       FORCE_VECTORIZE do {
>                 p1[0] ^= p2[0];
>                 p1[1] ^= p2[1];
>                 p1[2] ^= p2[2];
> @@ -32,7 +41,7 @@ xor_8regs_3(unsigned long bytes, unsigned long *p1,
> unsigned long *p2,
>  {
>         long lines = bytes / (sizeof (long)) / 8;
>
> -       do {
> +       FORCE_VECTORIZE do {
>                 p1[0] ^= p2[0] ^ p3[0];
>                 p1[1] ^= p2[1] ^ p3[1];
>                 p1[2] ^= p2[2] ^ p3[2];
> @@ -53,7 +62,7 @@ xor_8regs_4(unsigned long bytes, unsigned long *p1,
> unsigned long *p2,
>  {
>         long lines = bytes / (sizeof (long)) / 8;
>
> -       do {
> +       FORCE_VECTORIZE do {
>                 p1[0] ^= p2[0] ^ p3[0] ^ p4[0];
>                 p1[1] ^= p2[1] ^ p3[1] ^ p4[1];
>                 p1[2] ^= p2[2] ^ p3[2] ^ p4[2];
> @@ -75,7 +84,7 @@ xor_8regs_5(unsigned long bytes, unsigned long *p1,
> unsigned long *p2,
>  {
>         long lines = bytes / (sizeof (long)) / 8;
>
> -       do {
> +       FORCE_VECTORIZE do {
>                 p1[0] ^= p2[0] ^ p3[0] ^ p4[0] ^ p5[0];
>                 p1[1] ^= p2[1] ^ p3[1] ^ p4[1] ^ p5[1];
>                 p1[2] ^= p2[2] ^ p3[2] ^ p4[2] ^ p5[2];
> --
> Thanks,
> ~Nick Desaulniers



-- 
Thanks,
~Nick Desaulniers
