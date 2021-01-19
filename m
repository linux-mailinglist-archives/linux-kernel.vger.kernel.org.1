Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8BF02FC2F8
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 23:07:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729137AbhASWGK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 17:06:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728843AbhASWFP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 17:05:15 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8150AC061573
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 14:04:31 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id q20so13167176pfu.8
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 14:04:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=km0tLx3Hb+77Yn2mV9SD+nXc5uKHViN4cP4UCVTdwFw=;
        b=bXveCDmegZK7Dg+MXhIQShuMS/xuSf2+iMzkzJ0qHV+xN+Dx9mkmfYHphHG4EjeZUt
         zbWJkvBpPcdwuJiNzcO5yUclwgDQCZpN2krmP3NpehzelE0mh86ww/qLOKKtyvsv3HX6
         PqAq9TwxWw9V2hjDpD9zIoji3k57xE4sef5OeKbS6glCur+L1rEo7cpLOPz7vVwNPUVR
         0Cp0XZWOTksA6gq5QkyvTtIQrNSKpD4TJcNsqSJS2bsmzPUvGPW3NGCIMbPqE2XBdv+a
         R/tYfV9EBfYVSlKg2DAoDKhnuGBthnOyhZ/xfP5p0RkER+/J2fgciCT6Ybzu9SomngCC
         huLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=km0tLx3Hb+77Yn2mV9SD+nXc5uKHViN4cP4UCVTdwFw=;
        b=IOVCiUrdiKBL3BJjt4Tp2HrwOFn4CaB63ZM0NeyaFtDwiT3Wtc4p+y+lTrSFigyMF3
         +zBgdf44NiPbeJ2ChPd2ZcmeRl6ASE0qJxo1n/Td+b6R1RP7sq9vYc6aocWp0Ovqe+Ch
         21fIHA6VjCZcFUE5e7OtgV2dLxan13W37tXW8zDJ0nw8zfs3JrfBgSlTF5B4CYlg3KSo
         yHpMuw6HMnRAbui08M7i6pLbewqBsLC9P+X8ZQ4FQsGHk1Vj7+rwGO3g8GG94ZBPGLjK
         ec5ve1q4HRGN7ZuVcowjhzjEyvPrpzIzaP15IkHCEMLRCFQmVu6r5yVbVSQwo5VJd2oQ
         WtQw==
X-Gm-Message-State: AOAM531mOsZc8ZMz0l0Oi7lsWLKT6EVpMWKYnQNrvszdKQCwgY8mM2bX
        H+Qr/G34o/fE3WP6L6hJOFWJi9XWb7qym+hFmmsZRw==
X-Google-Smtp-Source: ABdhPJzQwwcAkLru8Gxy5lZvCPBvEUijRCb6QEO1IugJWKnfsfADLbiM9n7r2/b4i8Mk5i/6XE2X3Q45DiFU8KTywp4=
X-Received: by 2002:a63:1142:: with SMTP id 2mr6367757pgr.263.1611093870873;
 Tue, 19 Jan 2021 14:04:30 -0800 (PST)
MIME-Version: 1.0
References: <20210119131724.308884-1-adrian.ratiu@collabora.com>
 <20210119131724.308884-2-adrian.ratiu@collabora.com> <CAKwvOdkNZ09kkzi+A8diaxViqSufxrHizuBu-7quG6an3Z8iDA@mail.gmail.com>
 <CAK8P3a0XWVu-oG3YaGppZDedRL=SA37Gr8YM4cojVap5Bwk2TA@mail.gmail.com>
In-Reply-To: <CAK8P3a0XWVu-oG3YaGppZDedRL=SA37Gr8YM4cojVap5Bwk2TA@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 19 Jan 2021 14:04:19 -0800
Message-ID: <CAKwvOdmPr8T9T=tjiVGWJAw-pGzDgsKxtkLxTW4CwTrHjT-v7A@mail.gmail.com>
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

On Tue, Jan 19, 2021 at 1:35 PM Arnd Bergmann <arnd@kernel.org> wrote:
>
> On Tue, Jan 19, 2021 at 10:18 PM 'Nick Desaulniers' via Clang Built
> Linux <clang-built-linux@googlegroups.com> wrote:
> >
> > On Tue, Jan 19, 2021 at 5:17 AM Adrian Ratiu <adrian.ratiu@collabora.com> wrote:
> > > diff --git a/arch/arm/lib/xor-neon.c b/arch/arm/lib/xor-neon.c
> > > index b99dd8e1c93f..f9f3601cc2d1 100644
> > > --- a/arch/arm/lib/xor-neon.c
> > > +++ b/arch/arm/lib/xor-neon.c
> > > @@ -14,20 +14,22 @@ MODULE_LICENSE("GPL");
> > >  #error You should compile this file with '-march=armv7-a -mfloat-abi=softfp -mfpu=neon'
> > >  #endif
> > >
> > > +/*
> > > + * TODO: Even though -ftree-vectorize is enabled by default in Clang, the
> > > + * compiler does not produce vectorized code due to its cost model.
> > > + * See: https://github.com/ClangBuiltLinux/linux/issues/503
> > > + */
> > > +#ifdef CONFIG_CC_IS_CLANG
> > > +#warning Clang does not vectorize code in this file.
> > > +#endif
> >
> > Arnd, remind me again why it's a bug that the compiler's cost model
> > says it's faster to not produce a vectorized version of these loops?
> > I stand by my previous comment: https://bugs.llvm.org/show_bug.cgi?id=40976#c8
>
> The point is that without vectorizing the code, there is no point in building
> both the default xor code and a "neon" version that has to save/restore
> the neon registers but doesn't actually use them.
>
>           Arnd

Thoughts?  Also, Nathan brings up my previous point about restrict.
This would benefit both GCC and Clang as they would not produce 2
"versions" of the loop; one vectorized if the std::distance between x
& y >= 8, one scalar otherwise.  But the callers would have to ensure
no overlap otherwise UB.

diff --git a/include/asm-generic/xor.h b/include/asm-generic/xor.h
index b62a2a56a4d4..7db16adc7d89 100644
--- a/include/asm-generic/xor.h
+++ b/include/asm-generic/xor.h
@@ -7,12 +7,21 @@

 #include <linux/prefetch.h>

+/* Overrule LLVM's cost model in order to always produce a vectorized loop
+ * version.
+ */
+#if defined(__clang__) && defined(CONFIG_ARM)
+#define FORCE_VECTORIZE _Pragma("clang loop vectorize(enable)")
+#else
+#define CLANG_FORCE_VECTORIZE
+#endif
+
 static void
 xor_8regs_2(unsigned long bytes, unsigned long *p1, unsigned long *p2)
 {
        long lines = bytes / (sizeof (long)) / 8;

-       do {
+       FORCE_VECTORIZE do {
                p1[0] ^= p2[0];
                p1[1] ^= p2[1];
                p1[2] ^= p2[2];
@@ -32,7 +41,7 @@ xor_8regs_3(unsigned long bytes, unsigned long *p1,
unsigned long *p2,
 {
        long lines = bytes / (sizeof (long)) / 8;

-       do {
+       FORCE_VECTORIZE do {
                p1[0] ^= p2[0] ^ p3[0];
                p1[1] ^= p2[1] ^ p3[1];
                p1[2] ^= p2[2] ^ p3[2];
@@ -53,7 +62,7 @@ xor_8regs_4(unsigned long bytes, unsigned long *p1,
unsigned long *p2,
 {
        long lines = bytes / (sizeof (long)) / 8;

-       do {
+       FORCE_VECTORIZE do {
                p1[0] ^= p2[0] ^ p3[0] ^ p4[0];
                p1[1] ^= p2[1] ^ p3[1] ^ p4[1];
                p1[2] ^= p2[2] ^ p3[2] ^ p4[2];
@@ -75,7 +84,7 @@ xor_8regs_5(unsigned long bytes, unsigned long *p1,
unsigned long *p2,
 {
        long lines = bytes / (sizeof (long)) / 8;

-       do {
+       FORCE_VECTORIZE do {
                p1[0] ^= p2[0] ^ p3[0] ^ p4[0] ^ p5[0];
                p1[1] ^= p2[1] ^ p3[1] ^ p4[1] ^ p5[1];
                p1[2] ^= p2[2] ^ p3[2] ^ p4[2] ^ p5[2];
-- 
Thanks,
~Nick Desaulniers
