Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B0322A5A3D
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 23:44:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730629AbgKCWoO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 17:44:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730568AbgKCWoM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 17:44:12 -0500
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFBC6C061A04
        for <linux-kernel@vger.kernel.org>; Tue,  3 Nov 2020 14:44:10 -0800 (PST)
Received: by mail-pl1-x644.google.com with SMTP id 1so9306517ple.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Nov 2020 14:44:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I/uB5S23puPABQIKDt8mffgwxH7OPp4NpnA8AnbObM4=;
        b=SZx8405XnPwkU3fqqiWAXp4mJDnmeWBjsko6l86k3D5fexc9ISIogJmm96oG5/1aEf
         29ctupR0WedmDjGFqhkvtV0r48SJeFfH32j3vgJWNfUUkbKWFapu0AjIP4qbfQpViLlF
         jsIRWS4/TXfGHK6aooZQ9iiZN7MkGdEW8IPo/xSWFRVvFlvxgkVSiPe5MIpjATTVb46G
         lMKRBrufLPq8tDD+IEivQC+zRmlJbrd2ydgSFRoy+ugHS67B/LEi4H8tw2IEx3SsxxQG
         QWVPY5Lh1Cnga4/deGRZUD8zdjaiVmbRF1H7ah8JGD/FUMSf/LrPvqoSk6TOAKRg4qEV
         pTuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I/uB5S23puPABQIKDt8mffgwxH7OPp4NpnA8AnbObM4=;
        b=iQQ5VmvyeK0Nsx0X+9ZtMVdN8Palqe7NuUnzVC1jfivU7UOyKEDEcUXzwwBmOAgt6I
         5aNGzDPqeX2hPyX1ZKuMcVZBB5VARFBcNukcC1E6wgfBuBLx+vi8iI9gW4tO5GhGFTSM
         qODWDnbn0PcP4E9/sKetCSDFYSGlQaOojSYODWiie39BJgYU8h3DU8oHsYmpuIXWe0FL
         246O/AGt33J+deHuWfmHrUUDpRnUzWWdUZaYpyBhsjIETyZIoXBv47qanWtBjHXBNTWT
         OUr1IdvZu88TjqroxkwPUicBIWm30cwN1sTfBnnJKsip4hrzEHeEQ37pcbDWco8VG1VS
         7iJw==
X-Gm-Message-State: AOAM530yukvC/Uqtl5KwjoMAm6JIZHPNB9V4KVFM1EJh82tXETNZkAtd
        KbxlpgA+BriNZjl9i5fSptPvnmZZLYfWOGDt+Vd3mQ==
X-Google-Smtp-Source: ABdhPJyoBmO3B7bFqrghvHKrH+223fIRwnGaNUGq7KGBDFFe2r2Cn+oohMtlRo2y7XucXuYg1h6zaqD2LO49AVhR42Y=
X-Received: by 2002:a17:902:8ecc:b029:d6:991d:1193 with SMTP id
 x12-20020a1709028eccb02900d6991d1193mr22527630plo.56.1604443450113; Tue, 03
 Nov 2020 14:44:10 -0800 (PST)
MIME-Version: 1.0
References: <20201103012358.168682-1-maskray@google.com> <20201103014602.GA3271702@ubuntu-m3-large-x86>
In-Reply-To: <20201103014602.GA3271702@ubuntu-m3-large-x86>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 3 Nov 2020 14:43:59 -0800
Message-ID: <CAKwvOdkiSUesFPD30EqhU0Np=BsM2hJ6Cu+qv38r4yyVCi3rag@mail.gmail.com>
Subject: Re: [PATCH v2] x86_64: Change .weak to SYM_FUNC_START_WEAK for arch/x86/lib/mem*_64.S
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Fangrui Song <maskray@google.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Jian Cai <jiancai@google.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        "# 3.4.x" <stable@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ LKML so I can find this easier to fetch via b4

On Mon, Nov 2, 2020 at 5:46 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> On Mon, Nov 02, 2020 at 05:23:58PM -0800, 'Fangrui Song' via Clang Built Linux wrote:
> > Commit 393f203f5fd5 ("x86_64: kasan: add interceptors for
> > memset/memmove/memcpy functions") added .weak directives to
> > arch/x86/lib/mem*_64.S instead of changing the existing ENTRY macros to
> > WEAK. This can lead to the assembly snippet `.weak memcpy ... .globl
> > memcpy` which will produce a STB_WEAK memcpy with GNU as but STB_GLOBAL
> > memcpy with LLVM's integrated assembler before LLVM 12. LLVM 12 (since
> > https://reviews.llvm.org/D90108) will error on such an overridden symbol
> > binding.
> >
> > Commit ef1e03152cb0 ("x86/asm: Make some functions local") changed ENTRY in
> > arch/x86/lib/memcpy_64.S to SYM_FUNC_START_LOCAL, which was ineffective due to
> > the preceding .weak directive.
> >
> > Use the appropriate SYM_FUNC_START_WEAK instead.
> >
> > Fixes: 393f203f5fd5 ("x86_64: kasan: add interceptors for memset/memmove/memcpy functions")
> > Fixes: ef1e03152cb0 ("x86/asm: Make some functions local")
> > Reported-by: Sami Tolvanen <samitolvanen@google.com>
> > Signed-off-by: Fangrui Song <maskray@google.com>
> > Cc: <stable@vger.kernel.org>
>
> This resolves the build error I see with LLVM_IAS=1 and ToT LLVM.
>
> Tested-by: Nathan Chancellor <natechancellor@gmail.com>

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Tested-by: Nick Desaulniers <ndesaulniers@google.com>

>
> > ---
> > Changes in v2
> > * Correct the message: SYM_FUNC_START_WEAK was not available at commit 393f203f5fd5.
> > * Mention Fixes: ef1e03152cb0
> > ---
> >  arch/x86/lib/memcpy_64.S  | 4 +---
> >  arch/x86/lib/memmove_64.S | 4 +---
> >  arch/x86/lib/memset_64.S  | 4 +---
> >  3 files changed, 3 insertions(+), 9 deletions(-)
> >
> > diff --git a/arch/x86/lib/memcpy_64.S b/arch/x86/lib/memcpy_64.S
> > index 037faac46b0c..1e299ac73c86 100644
> > --- a/arch/x86/lib/memcpy_64.S
> > +++ b/arch/x86/lib/memcpy_64.S
> > @@ -16,8 +16,6 @@
> >   * to a jmp to memcpy_erms which does the REP; MOVSB mem copy.
> >   */
> >
> > -.weak memcpy
> > -
> >  /*
> >   * memcpy - Copy a memory block.
> >   *
> > @@ -30,7 +28,7 @@
> >   * rax original destination
> >   */
> >  SYM_FUNC_START_ALIAS(__memcpy)
> > -SYM_FUNC_START_LOCAL(memcpy)
> > +SYM_FUNC_START_WEAK(memcpy)
> >       ALTERNATIVE_2 "jmp memcpy_orig", "", X86_FEATURE_REP_GOOD, \
> >                     "jmp memcpy_erms", X86_FEATURE_ERMS
> >
> > diff --git a/arch/x86/lib/memmove_64.S b/arch/x86/lib/memmove_64.S
> > index 7ff00ea64e4f..41902fe8b859 100644
> > --- a/arch/x86/lib/memmove_64.S
> > +++ b/arch/x86/lib/memmove_64.S
> > @@ -24,9 +24,7 @@
> >   * Output:
> >   * rax: dest
> >   */
> > -.weak memmove
> > -
> > -SYM_FUNC_START_ALIAS(memmove)
> > +SYM_FUNC_START_WEAK(memmove)
> >  SYM_FUNC_START(__memmove)
> >
> >       mov %rdi, %rax
> > diff --git a/arch/x86/lib/memset_64.S b/arch/x86/lib/memset_64.S
> > index 9ff15ee404a4..0bfd26e4ca9e 100644
> > --- a/arch/x86/lib/memset_64.S
> > +++ b/arch/x86/lib/memset_64.S
> > @@ -6,8 +6,6 @@
> >  #include <asm/alternative-asm.h>
> >  #include <asm/export.h>
> >
> > -.weak memset
> > -
> >  /*
> >   * ISO C memset - set a memory block to a byte value. This function uses fast
> >   * string to get better performance than the original function. The code is
> > @@ -19,7 +17,7 @@
> >   *
> >   * rax   original destination
> >   */
> > -SYM_FUNC_START_ALIAS(memset)
> > +SYM_FUNC_START_WEAK(memset)
> >  SYM_FUNC_START(__memset)
> >       /*
> >        * Some CPUs support enhanced REP MOVSB/STOSB feature. It is recommended
> > --

-- 
Thanks,
~Nick Desaulniers
