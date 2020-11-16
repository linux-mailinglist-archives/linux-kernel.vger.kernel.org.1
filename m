Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D56532B54A8
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 23:56:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbgKPW4B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 17:56:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725379AbgKPW4B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 17:56:01 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32A6DC0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 14:56:01 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id 131so5054522pfb.9
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 14:56:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gGQQSbaDVAU1vlvpaceSFbxVHAcyF7FfLo2QxzhNlZQ=;
        b=C5BO4bydvajGP/mGvPihXiXvMZz2c7aB2Q3/MBFyIAVF1fF9Z7Y+ptE0UZdQCIEgr4
         XNR8MhaFG7BMsU1sZ4/gk+083UDsxM+isovn//AV0yfa5S8+5BG75Ge4qFUtl8Fa4YVt
         c18UculviUHeSHWnXsfAl8PJN19H+J5DgTM2qg8Y2fJToREvKOApHYiPsDLWbcTFiCnE
         zy8TOc1ZBgvVfwaAlktxKmtwFg9meYy9Nfp5jGwABghRyQrBv6gX+N4MZqSvJe7Dz+00
         YxouLtikATtKEOvPAT35JQvOpvocc1Paf045FoLgnyjw5o5qDdhAA3emZMfS1Q5N5FP7
         4Isg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gGQQSbaDVAU1vlvpaceSFbxVHAcyF7FfLo2QxzhNlZQ=;
        b=L27TKuC7R1oDvf2QZ35z7RZxgiK8G4KHhOJGlECseownW1/y2lQTWxNtDr7jyA1WUA
         qsX4jR6//bLYzJJjsI2oLsbYD2SXLN4VcTlXvyGKsN2PiLWL4jLxfV9VTy387TuUGPJv
         WR7o1ibxQxK8nCUaTscHVZ5VYq2Ckn0R9L7GBlHOn/wTG+tpmHeayBKJDIYk1MkNhgwz
         XJGLrYOB3cjp0HNWVvHBy4WiiatfjIsi1RLXIlLy6E6aMtAiW6d5pJ+fInQBnJgOVClA
         qzqyq/aAkN2mj6U4UpncWYOK+v6eqfUn7nfxRZ0gsL09i23ASq1t8mVIwVAE3efTrgAV
         NKlg==
X-Gm-Message-State: AOAM5301RkSQKhp35o8wY9M9YJl/P1+U/H616eawVjHCxbYcGJ4sj0U2
        Pp8B6vj68R0CUDrOwnc3xV+jxA==
X-Google-Smtp-Source: ABdhPJygE31LfesK/DA/JPLBnwLWVO38gKqHhPhrl5ZibxECFESIHqyCO+iCX7y2d2GH7gdaLu4uyA==
X-Received: by 2002:a63:581b:: with SMTP id m27mr1242198pgb.204.1605567360502;
        Mon, 16 Nov 2020 14:56:00 -0800 (PST)
Received: from google.com (15.4.198.104.bc.googleusercontent.com. [104.198.4.15])
        by smtp.gmail.com with ESMTPSA id a17sm17007387pga.56.2020.11.16.14.55.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 14:55:59 -0800 (PST)
Date:   Mon, 16 Nov 2020 22:55:55 +0000
From:   William Mcvicker <willmcvicker@google.com>
To:     Will Deacon <will@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Andrei Vagin <avagin@gmail.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com, kernel-team@android.com
Subject: Re: [PATCH] arm64: Fix off-by-one vdso trampoline return value
Message-ID: <20201116225555.GA160862@google.com>
References: <20201112001422.340449-1-willmcvicker@google.com>
 <20201112101204.GA19506@willie-the-truck>
 <20201112185136.GA585063@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201112185136.GA585063@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

After digging into this even deeper with Nick, we found that the underlying
issue is with ld.lld not carrying over the st_type for the VDSO_compat* symbol
assignments in `arch/arm64/kernel/vdso32/vdso.lds.S`.

From my Android Common Kernel 4.19 build:
$ llvm-readelf -s arch/arm64/kernel/vdso32/vdso.so.raw | grep thumb | sort
    26: 0000094d     0 NOTYPE  LOCAL  DEFAULT    11 VDSO_compat_sigreturn_thumb
    28: 00000955     0 NOTYPE  LOCAL  DEFAULT    11 VDSO_compat_rt_sigreturn_thumb
    37: 0000094d     4 FUNC    GLOBAL DEFAULT    11 __kernel_sigreturn_thumb
    38: 00000955     4 FUNC    GLOBAL DEFAULT    11 __kernel_rt_sigreturn_thumb
     8: 0000094d     4 FUNC    GLOBAL DEFAULT    11 __kernel_sigreturn_thumb@@LINUX_2.6
     9: 00000955     4 FUNC    GLOBAL DEFAULT    11 __kernel_rt_sigreturn_thumb@@LINUX_2.6

Fortunately, this has been fixed by llvm here: https://reviews.llvm.org/D86263.
So for kernels that use ld.lld and the VDSO compat sigreturn trampoline, they
need to make sure to upgrade their toolchain.

I hope this thread helps anyone running into this issue in the future.

Thanks,
Will

On 11/12/2020, William Mcvicker wrote:
> Hi Nick,
> 
> Regarding llvm-nm, this extra thumb +1 is noticed after porting
> https://lore.kernel.org/linux-arm-kernel/20201013033947.2257501-1-natechancellor@gmail.com/
> to the Android Common Kernel android-4.19-stable. I'm not sure why using ld.lld
> causes this difference, but this proposed patch ensures that we don't rely on
> the nm tool used.
> 
> Will D.,
> Regarding applying this to some stable kernels vs backporting 2d071968a405
> ("arm64: compat: Remove 32-bit sigreturn code from the vDSO"), I am hesitant to
> backport commit 2d071968a405 due it's dependencies. For 4.19 at least, I would
> also need to backport these:
> 
> 8e411be6aad13 will@kernel.org  arm64: compat: Always use sigpage for sigreturn trampoline
> a39060b009ca0 will@kernel.org  arm64: compat: Allow 32-bit vdso and sigpage to co-exist
> 1d09094aa6205 mark.rutland@arm.com  arm64: vdso: use consistent 'map' nomenclature
> d3418f3839b66 mark.rutland@arm.com  arm64: vdso: use consistent 'abi' nomenclature
> 3ee16ff3437ca mark.rutland@arm.com  arm64: vdso: simplify arch_vdso_type ifdeffery
> 74fc72e77dc5c mark.rutland@arm.com  arm64: vdso: remove aarch32_vdso_pages[]
> 
> I have done this in my local tree and verified it fixes the SIGBUS error I'm
> seeing; however, it seems a lot cleaner and safer to just patch the VDSO_SYMBOL
> macro.  Please let me know what route you prefer. I'm happy to backport all of
> these if that's the recommended approach.
> 
> Thanks,
> Will
> 
> On 11/12/2020, Will Deacon wrote:
> > On Thu, Nov 12, 2020 at 12:14:22AM +0000, Will McVicker wrote:
> > > Depending on your host nm version, the generated header
> > > `include/generated/vdso32-offsets.h` may have the bottom bit set for the
> > > thumb vdso offset addresses (as observed when using llvm-nm). This
> > > results in an additional +1 for thumb vdso trampoline return values
> > > since compat_setup_return() already includes `vdso_trampoline + thumb`.
> > > As a result, I see a SIGBUS error when running the LTP test
> > > syscalls.rt_sigaction01. To fix this, let's clear the bottom bit of the
> > > vdso_offset in the VDSO_SYMBOL macro.
> > > 
> > > Test: LTP test syscalls.rt_sigaction01
> > > Fixes: f01703b3d2e6 ("arm64: compat: Get sigreturn trampolines from vDSO")
> > > Signed-off-by: Will McVicker <willmcvicker@google.com>
> > > ---
> > >  arch/arm64/include/asm/vdso.h | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/arch/arm64/include/asm/vdso.h b/arch/arm64/include/asm/vdso.h
> > > index f99dcb94b438..a7384379e8e1 100644
> > > --- a/arch/arm64/include/asm/vdso.h
> > > +++ b/arch/arm64/include/asm/vdso.h
> > > @@ -23,7 +23,7 @@
> > >  
> > >  #define VDSO_SYMBOL(base, name)						   \
> > >  ({									   \
> > > -	(void *)(vdso_offset_##name - VDSO_LBASE + (unsigned long)(base)); \
> > > +	(void *)((vdso_offset_##name & ~1UL) - VDSO_LBASE + (unsigned long)(base)); \
> > 
> > I don't think we need this in mainline, because the sigreturn trampoline
> > is just a bunch of .byte directives and I removed the sigreturn code from
> > the compat vdso in 2d071968a405 ("arm64: compat: Remove 32-bit sigreturn code
> > from the vDSO").
> > 
> > Might be needed in some stable kernels though (or we just backport the
> > patch I mentioned above)
> > 
> > Will
