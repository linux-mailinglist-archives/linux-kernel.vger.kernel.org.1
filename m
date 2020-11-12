Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A4C92AFE25
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 06:34:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728714AbgKLFe0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 00:34:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726042AbgKLCO2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 21:14:28 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CABBC0613D1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 18:14:28 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id c20so3066400pfr.8
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 18:14:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f79nMHVN8pv5/YKFzlWN37GawHBvq0Jjxuf2DH5PRsQ=;
        b=KRuBmPx0j6RB/spfbXT+hnt4AA19u53vgZDvN9/qxbJ0suS4eNtHtiQLIJTJtMC/aE
         Niw+du8T64qm5+uCHjrPjKqJ5aUJkcaxn3cFCLUHmxtlJwJR9saGKtHQ4sOV8aJs1Oxy
         bB8kN2kOebHj0g4Ge7i4zqSnpxOUv6SDxN8CylGPypT0ZBfYPyUccCTYDbgAcUtotcvx
         IfkWDtQ+9/mXX/3TiCb6r+JkEb84rjvV4zWpSKdMjN+QY5lWcLpNyW3+clD4iAuQ3/N9
         069xwU3rX+zhDLMT0X0id3S1M+Cg4nscvDNxKh8kH9L4iA76VKZiNvfx4A414GnqCmeq
         tuUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f79nMHVN8pv5/YKFzlWN37GawHBvq0Jjxuf2DH5PRsQ=;
        b=E/rNkWRp5ndfitaOgVCJ+9wZzJOnzjtvECDTnKNx2iiZwU81tYj4i0Xdn5nNpVJeJZ
         yOftN6fbmxck3uaZn98vDI2CXVTaBzsauggQy2AOoFv8+dEZkpRp3jXgi9RaVxIc3+1T
         pJ/Tu87Uk9OcjJTVJ9JrLHb4c9uKdVQTKHKZwsUk8Fng2FFw2S0cBJVz1ifcWNg7PNwH
         dNQZt30tyh96JIe9LBQvc4r3+Q8re52LqB99yKf6QF1aQdcO3b6QRXTDiFpYHf/tFBfC
         Pz/trYaP8MHhhd7f7LQsVctp+GjO86D75tCPU/5FNAa553UjWK7lYyY3OInqEEvKCTAe
         XweA==
X-Gm-Message-State: AOAM533LnsMMTvp/z8AvcqMiRo3I5Cw95obZVo2qJ2urNs6a3zOxkeNw
        ED91GD9mTUVq5OYD8R/gkVNEkT4i8Qop3gb5uB6AL5n92ogAQg==
X-Google-Smtp-Source: ABdhPJy9xgdSdOx+SZqZ1ij1E/mkeTghIhIV1PIo6Wehk3R7WiwQbBrvfjlWMt2FXpkUcmSX2ztUozvqC4cZJFn5pXE=
X-Received: by 2002:a17:90a:4881:: with SMTP id b1mr6886626pjh.32.1605147267894;
 Wed, 11 Nov 2020 18:14:27 -0800 (PST)
MIME-Version: 1.0
References: <20201112001422.340449-1-willmcvicker@google.com> <CAKwvOdkDG2wt=ZT93GT7r60_qXn=tdW_zWiJ1Gr5JVdRvcU8uw@mail.gmail.com>
In-Reply-To: <CAKwvOdkDG2wt=ZT93GT7r60_qXn=tdW_zWiJ1Gr5JVdRvcU8uw@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 11 Nov 2020 18:14:15 -0800
Message-ID: <CAKwvOdnjMhjxawxNembM+XrMctitm13Cvh8gbMPEcXiPBhacPA@mail.gmail.com>
Subject: Re: [PATCH] arm64: Fix off-by-one vdso trampoline return value
To:     Will McVicker <willmcvicker@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Andrei Vagin <avagin@gmail.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        kernel-team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 11, 2020 at 5:00 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Wed, Nov 11, 2020 at 4:14 PM Will McVicker <willmcvicker@google.com> wrote:
> >
> > Depending on your host nm version, the generated header
> > `include/generated/vdso32-offsets.h` may have the bottom bit set for the
> > thumb vdso offset addresses (as observed when using llvm-nm). This
>
> Sorry, the commit message seems to imply a bug in llvm-nm, but I don't
> think that's the case.  If it is, please, send us a bugreport.
>
> $ aarch64-linux-gnu-nm arch/arm64/kernel/vdso32/vdso.so.raw | grep thumb
> 00000968 T __kernel_rt_sigreturn_thumb
> 00000960 T __kernel_sigreturn_thumb
> 00000968 t VDSO_compat_rt_sigreturn_thumb
> 00000960 t VDSO_compat_sigreturn_thumb
> $ llvm-nm arch/arm64/kernel/vdso32/vdso.so.raw | grep thumb
> 00000968 t VDSO_compat_rt_sigreturn_thumb
> 00000960 t VDSO_compat_sigreturn_thumb
> 00000968 T __kernel_rt_sigreturn_thumb
> 00000960 T __kernel_sigreturn_thumb
> $ /usr/bin/nm arch/arm64/kernel/vdso32/vdso.so.raw | grep thumb
> 00000969 T __kernel_rt_sigreturn_thumb
> 00000961 T __kernel_sigreturn_thumb
> 00000969 t VDSO_compat_rt_sigreturn_thumb
> 00000961 t VDSO_compat_sigreturn_thumb
> $ /usr/bin/nm --version
> GNU nm (GNU Binutils for Debian) 2.35.1
>
> Would you mind amending the commit message to not imply that llvm-nm is broken?

Testing another set of configs:

$ aarch64-linux-android-nm arch/arm64/kernel/vdso32/vdso.so.dbg | grep thumb
00000950 T __kernel_rt_sigreturn_thumb
00000948 T __kernel_sigreturn_thumb
00000951 t VDSO_compat_rt_sigreturn_thumb
00000949 t VDSO_compat_sigreturn_thumb
$ /path/to/older/aarch64-linux-gnu-nm
arch/arm64/kernel/vdso32/vdso.so.dbg | grep thumb
00000950 T __kernel_rt_sigreturn_thumb
00000948 T __kernel_sigreturn_thumb
00000951 t VDSO_compat_rt_sigreturn_thumb
00000949 t VDSO_compat_sigreturn_thumb
$ /usr/bin/nm out/android-4.19-stable/common/arch/arm64/kernel/vdso32/vdso.so.dbg
| grep thumb
00000951 T __kernel_rt_sigreturn_thumb
00000949 T __kernel_sigreturn_thumb
00000951 t VDSO_compat_rt_sigreturn_thumb
00000949 t VDSO_compat_sigreturn_thumb
$ llvm-nm out/android-4.19-stable/common/arch/arm64/kernel/vdso32/vdso.so.dbg
| grep thumb
00000951 t VDSO_compat_rt_sigreturn_thumb
00000949 t VDSO_compat_sigreturn_thumb
00000950 T __kernel_rt_sigreturn_thumb
00000948 T __kernel_sigreturn_thumb

(That llvm-nm sorts the output makes this trickier to follow). But
shows that only host GNU `nm` differs.

>
> It might be of interest to find out why the host `nm` was invoked,
> rather than $(NM)/$(CROSS_COMPILE)nm.

Possibly commit 7b7891c7bdfd ("arm64: vdso32: Fix '--prefix=' value
for newer versions of clang") missing from your tree, but I fail to
see how that would mess up or invoke the incorrect $(NM).

>
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
> >  #define VDSO_SYMBOL(base, name)                                                   \
> >  ({                                                                        \
> > -       (void *)(vdso_offset_##name - VDSO_LBASE + (unsigned long)(base)); \
> > +       (void *)((vdso_offset_##name & ~1UL) - VDSO_LBASE + (unsigned long)(base)); \
> >  })
> >
> >  #endif /* !__ASSEMBLY__ */
> > --
> > 2.29.2.299.gdc1121823c-goog
> >
>
>
> --
> Thanks,
> ~Nick Desaulniers



-- 
Thanks,
~Nick Desaulniers
