Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2F752B0CFF
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 19:51:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726547AbgKLSvn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 13:51:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726148AbgKLSvm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 13:51:42 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54523C0613D1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 10:51:42 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id x15so4055393pfm.9
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 10:51:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RaVZ5jM2Kq305TknFdq232t++qdgFqkARu+DxrhGvhw=;
        b=k01pYQ5Hf6kJ1SYxIRgRrYC+IjYSruWAzp1Sf4DrFIHHHtX7vtLVp+1M2+xLmsUEWz
         85BuREFwJrN8AygA5FG/Cia8YTgzBEc1FtGjYXNSJ7tWHJmOkbg/8Eoz7x+YwQV7VEEc
         JvtcNnjje92yVghJshGR5sYaImJwCleNqSq+7CIH33qUHbDZ5Gtq2vi3TL+Gk7zBXN9Y
         UStSsNsS6/VD/oxomEJd7CC0N9G37OWykfxgvik+vwQAH2EYrjom5gyYOOi9aNT6HrT/
         TMOK0U7+sKos4mIzObAK4dfT0pDVoQg/9gWXdDV/wlCTRfw1GCWRkr0C2VV2ZbLShd01
         hDKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RaVZ5jM2Kq305TknFdq232t++qdgFqkARu+DxrhGvhw=;
        b=TKta5dmT6r9wBxzvYedAILMfqlWeYA26TH4oJ23JyiElF4yPlQTopco+/trcnHtTdV
         LJkFeqsaHpkFOC2LsRAJ7fSuGjbUkGr+2qmFheUwEAiZhfLBf8U3IZaVcIFDlsyqKnQn
         XrvLtwRhAQGNGhf7lW/zEdxhCrHwYluDqPwojcDic3uQxNzTg6CM+bC0nj1VKTUv6o2S
         Ajn6Xzxd6PRYvqbbqKTvpKZh4SZ7cmSZxSiAAAoHrrCcmHW3h9zviWqJPhkuZm15VI/8
         S5aXzusqjPS3gmS7Jz0cAMQr3Rg/EMY0qKTyO1KifvGZG8e9WDWCGNyQnYOsRTnDKxWC
         k9AA==
X-Gm-Message-State: AOAM5329mA4PFWyOoPjiCWca9jcM3L7SeacwRea4lRRXWVal5APrwBT9
        x1KdbUaO2srItt9wmY7HGHfT6Q==
X-Google-Smtp-Source: ABdhPJwP4mdW68OARGlJ0t9NI8QWmMpS2Pf3Qqj2Q0RDhpx5qiPCzdJNFkbGKrc7eiUgLswR2wHT7g==
X-Received: by 2002:a17:90a:8543:: with SMTP id a3mr600513pjw.13.1605207101503;
        Thu, 12 Nov 2020 10:51:41 -0800 (PST)
Received: from google.com (15.4.198.104.bc.googleusercontent.com. [104.198.4.15])
        by smtp.gmail.com with ESMTPSA id k21sm6824459pfu.7.2020.11.12.10.51.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 10:51:40 -0800 (PST)
Date:   Thu, 12 Nov 2020 18:51:36 +0000
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
Message-ID: <20201112185136.GA585063@google.com>
References: <20201112001422.340449-1-willmcvicker@google.com>
 <20201112101204.GA19506@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201112101204.GA19506@willie-the-truck>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nick,

Regarding llvm-nm, this extra thumb +1 is noticed after porting
https://lore.kernel.org/linux-arm-kernel/20201013033947.2257501-1-natechancellor@gmail.com/
to the Android Common Kernel android-4.19-stable. I'm not sure why using ld.lld
causes this difference, but this proposed patch ensures that we don't rely on
the nm tool used.

Will D.,
Regarding applying this to some stable kernels vs backporting 2d071968a405
("arm64: compat: Remove 32-bit sigreturn code from the vDSO"), I am hesitant to
backport commit 2d071968a405 due it's dependencies. For 4.19 at least, I would
also need to backport these:

8e411be6aad13 will@kernel.org  arm64: compat: Always use sigpage for sigreturn trampoline
a39060b009ca0 will@kernel.org  arm64: compat: Allow 32-bit vdso and sigpage to co-exist
1d09094aa6205 mark.rutland@arm.com  arm64: vdso: use consistent 'map' nomenclature
d3418f3839b66 mark.rutland@arm.com  arm64: vdso: use consistent 'abi' nomenclature
3ee16ff3437ca mark.rutland@arm.com  arm64: vdso: simplify arch_vdso_type ifdeffery
74fc72e77dc5c mark.rutland@arm.com  arm64: vdso: remove aarch32_vdso_pages[]

I have done this in my local tree and verified it fixes the SIGBUS error I'm
seeing; however, it seems a lot cleaner and safer to just patch the VDSO_SYMBOL
macro.  Please let me know what route you prefer. I'm happy to backport all of
these if that's the recommended approach.

Thanks,
Will

On 11/12/2020, Will Deacon wrote:
> On Thu, Nov 12, 2020 at 12:14:22AM +0000, Will McVicker wrote:
> > Depending on your host nm version, the generated header
> > `include/generated/vdso32-offsets.h` may have the bottom bit set for the
> > thumb vdso offset addresses (as observed when using llvm-nm). This
> > results in an additional +1 for thumb vdso trampoline return values
> > since compat_setup_return() already includes `vdso_trampoline + thumb`.
> > As a result, I see a SIGBUS error when running the LTP test
> > syscalls.rt_sigaction01. To fix this, let's clear the bottom bit of the
> > vdso_offset in the VDSO_SYMBOL macro.
> > 
> > Test: LTP test syscalls.rt_sigaction01
> > Fixes: f01703b3d2e6 ("arm64: compat: Get sigreturn trampolines from vDSO")
> > Signed-off-by: Will McVicker <willmcvicker@google.com>
> > ---
> >  arch/arm64/include/asm/vdso.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm64/include/asm/vdso.h b/arch/arm64/include/asm/vdso.h
> > index f99dcb94b438..a7384379e8e1 100644
> > --- a/arch/arm64/include/asm/vdso.h
> > +++ b/arch/arm64/include/asm/vdso.h
> > @@ -23,7 +23,7 @@
> >  
> >  #define VDSO_SYMBOL(base, name)						   \
> >  ({									   \
> > -	(void *)(vdso_offset_##name - VDSO_LBASE + (unsigned long)(base)); \
> > +	(void *)((vdso_offset_##name & ~1UL) - VDSO_LBASE + (unsigned long)(base)); \
> 
> I don't think we need this in mainline, because the sigreturn trampoline
> is just a bunch of .byte directives and I removed the sigreturn code from
> the compat vdso in 2d071968a405 ("arm64: compat: Remove 32-bit sigreturn code
> from the vDSO").
> 
> Might be needed in some stable kernels though (or we just backport the
> patch I mentioned above)
> 
> Will
