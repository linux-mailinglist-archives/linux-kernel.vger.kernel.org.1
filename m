Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 919502AE1F6
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 22:42:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731808AbgKJVmh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 16:42:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731795AbgKJVl3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 16:41:29 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50474C0613D1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 13:41:29 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id q10so100032pfn.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 13:41:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q4CcE7u3K9j+955QTtLBYw45S3stN7Sf2ld0QlffWLY=;
        b=LSBoX11DTqZt5ykBJjWrLVCotXOX+VDMeduVWfHpirxS6g4oiPNSeATzedTwsIFC2/
         y2EiePGA6mZctBwYNOw9YBZyPvbjrM+Kal/pK5eJ/BTBt3f4aSRgKRIV0tbVpgvN0HRz
         NOUOwLspZVsqHeOvF9MVZT3JrrVWoKy1jKR0OON9LuYe3ytE1v892Bv4zDNzD4qEqOCm
         8Gt5pOJl+3BfB+TgugsKLaSucdby/7i1UVwOePIt1Y3uUL7NaZh/+mTSQK58DPCoxLkJ
         4de0ZEnHcGvWkx+fQmKhQtscNRTBlctPSh7CiW7OzHJOav/Ujzz6EPSYLs7tFC3HtfDT
         MxLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q4CcE7u3K9j+955QTtLBYw45S3stN7Sf2ld0QlffWLY=;
        b=XSC8VYttoMT9/m2U8sziabPyIuMp/9T1PELmHhHds26JyT9zWznDXWqW8iRIoVI+/6
         cO+Opd/yL86f0DhVy3/MTYR2Sm2CcQuGlyIYDpIUZMr4zOQlXWw+GL2u1crqFYK5Rzjl
         sDi77rcOLDA3mDJINSJF1KZZYQQO7d/XHAz8JJ3Y0slcqMR3dIzSzATdSWrnDYJbhVnM
         bFNtQAg1oJuwo/yYcGPWE47YDMVPqzkpK5GX8y7n9X3uCIAgridOj+xZCzFyMqGU76Fm
         goTKsNwY4q3Pyek8J/boHSA18j9s5vayVmAYYEElafD55V/8SE1xGN/QJ5ZeCR302pLK
         o2NQ==
X-Gm-Message-State: AOAM533ktoCUVKmIf+UxwuJunzjtg5HmhAPEsnk+gZemtdxOQ0/2c+Cz
        6DIizLXZGzCJsFGoWsxPxfUsTJCijTo8cNdVSXB/rg==
X-Google-Smtp-Source: ABdhPJyGvE2Z8lE+zLIDsR+HvD7B4XIlvgvIgM5wCqeFvC2lqKZgL08J6WkYKLGhxZCDLEkSf+E3yJ1CbTFyKmU15bk=
X-Received: by 2002:a17:90a:4881:: with SMTP id b1mr194980pjh.32.1605044488647;
 Tue, 10 Nov 2020 13:41:28 -0800 (PST)
MIME-Version: 1.0
References: <20201106051436.2384842-1-adrian.ratiu@collabora.com>
 <20201106051436.2384842-3-adrian.ratiu@collabora.com> <20201106101419.GB3811063@ubuntu-m3-large-x86>
 <87wnyyvh56.fsf@collabora.com> <CAKwvOdkodob0M0r_AK_4nG3atLGMyNENMd6qVAHSPa92Zh7UZA@mail.gmail.com>
 <871rh2i9xg.fsf@iwork.i-did-not-set--mail-host-address--so-tickle-me>
In-Reply-To: <871rh2i9xg.fsf@iwork.i-did-not-set--mail-host-address--so-tickle-me>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 10 Nov 2020 13:41:17 -0800
Message-ID: <CAKwvOdkm3u83TQDBB-fC0TwKZCFXGh5sAfahKXxA+mnzgDid_w@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm: lib: xor-neon: disable clang vectorization
To:     Adrian Ratiu <adrian.ratiu@collabora.com>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Russell King <linux@armlinux.org.uk>,
        LKML <linux-kernel@vger.kernel.org>,
        Collabora Kernel ML <kernel@collabora.com>,
        Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 9, 2020 at 11:51 AM Adrian Ratiu <adrian.ratiu@collabora.com> wrote:
>
> On Fri, 06 Nov 2020, Nick Desaulniers <ndesaulniers@google.com>
> wrote:
> > +#pragma clang loop vectorize(enable)
> >         do {
> >                 p1[0] ^= p2[0] ^ p3[0] ^ p4[0] ^ p5[0]; p1[1] ^=
> >                 p2[1] ^ p3[1] ^ p4[1] ^ p5[1];
> > ``` seems to generate the vectorized code.
> >
> > Why don't we find a way to make those pragma's more toolchain
> > portable, rather than open coding them like I have above rather
> > than this series?
>
> Hi again Nick,
>
> How did you verify the above pragmas generate correct vectorized
> code?  Have you tested this specific use case?

I read the disassembly before and after my suggested use of pragmas;
look for vld/vstr.  You can also add -Rpass-missed=loop-vectorize to
CFLAGS_xor-neon.o in arch/arm/lib/Makefile and rebuild
arch/arm/lib/xor-neon.o with CONFIG_BTRFS enabled.

>
> I'm asking because overrulling the cost model might not be enough,
> the only thing I can confirm is that the generated code is
> changed, but not that it is correct in any way. The object disasm
> also looks weird, but I don't have enough knowledge to start
> debugging what's happening within LLVM/Clang itself.

It doesn't "look weird" to me. The loop is versioned based on a
comparison whether the parameters alias or not. There's a
non-vectorized version if the parameters are equal or close enough to
overlap.  There's another version of the loop that's vectorized.  If
you want just the vectorized version, then you have to mark the
parameters as __restrict qualified, then check that all callers are ok
with that.

>
> I also get some new warnings with your code [1], besides the
> previously 'vectorization was possible but not beneficial' which
> is still present. It is quite funny because these two warnings
> seem to contradict themselves. :)

From which compiler?
```
$ clang -Wpass-failed=transform-warning -c -x c /dev/null
warning: unknown warning option '-Wpass-failed=transform-warning'; did
you mean '-Wprofile-instr-missing'? [-Wunknown-warning-option]
```

The pragma is clang specific, hence my recommendation to wrap it in an
#ifdef __clang__.

>
> At this point I do not trust the compiler and am inclined to do

Nonsense.

> like was done for GCC when it was broken: disable the optimization
> and warn users to upgrade after the compiler is fixed and
> confirmed to work.
>
> If you agree I can send a v2 with this and also drop the GCC
> pragma as Arvind and Ard suggested.

If you resend "this" as in 2/2, I will NACK it.  There's nothing wrong
with the cost model; it's saying there's little point in generating
the vectorized version because you're still going to need a
non-vectorized loop version anyways.  Claiming there is a compiler bug
here is dubious just because the cost models between two compilers
differ slightly.

Resend the patch removing the warning, remove the GCC pragma, but if
you want to change anything here for Clang, use `#pragma clang loop
vectorize(enable)` wrapped in an `#ifdef __clang__`.

>
> Kind regards,
> Adrian
>
> [1]
> ./include/asm-generic/xor.h:11:1: warning: loop not vectorized:
> the optimizer was unable to perform the requested transformation;
> the transformation might be disabled or specified as part of an
> unsupported transformation ordering
> [-Wpass-failed=transform-warning] xor_8regs_2(unsigned long bytes,
> unsigned long *p1, unsigned long *p2)


-- 
Thanks,
~Nick Desaulniers
