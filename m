Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D86A2AE4D1
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 01:19:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732200AbgKKATC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 19:19:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726706AbgKKATB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 19:19:01 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0210C0613D1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 16:18:59 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id w4so150111pgg.13
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 16:18:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AEiAgZw9G02MtGpg1xfKr5SR9IWLclqQ32M+RKFyvw8=;
        b=hKTKy5CT37mKM1h5Bix6Wxrju7ajkltdue2NhXSwmSEJjUC/OGewzhAKL9Xo9mw+Mu
         jBXdLzu5yOME+l28whRgqWqgpVCcQqQWVfadVPFG30GXo0nqgRwHsDDHcbb20ZAceaYQ
         uFbcNEnSoM44eD6cKPYgMsBLvaPhniduNVsVAKVmO1CPZrKrd3gSYrc+G9ARXLzAHfWL
         Fu8ravLVPE/CSHevWh0oh8z9FQKxqJ1STwvOOjA4A/8LdNDdKXHrmIJwiWUNa2GwRhig
         3Z7b9sqoojEYceo2dCBTwqo4kKtgrkJtWZ3OsrGSdZLCPmWBNNHA6lq35xC+bnqG7icC
         5X1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AEiAgZw9G02MtGpg1xfKr5SR9IWLclqQ32M+RKFyvw8=;
        b=qcU0kU8erNgydICx7kuq1B06PhxWHS3XFQpvMaKl2pPKET85sWCRsgCoM6msyoOw9r
         LzSyR3TDzYNtDeZ3v46sM/R0t/dZCeASyJM9/3oN/dc+AEO4nmUiMoghgXtwwom8nDd1
         nAHOkmEe9Up73A+kJPkw91oIQDhgkAYlaiwC+CS00bWvKKuSA1X3w7xYd/oFplHbaIqn
         Zcvde45bL/VOCzNmVbKDhGfdXf9GBKQQ4nKg0EarXiR5jrDsJXqUleS0vET86Nn9NWn8
         LjlcK6dmg9m6PT2UFWc0g0gK+36IG7qvKCLdrx6VGOp/Bz7Ewn+GbtZvCf+ebCrJy3dd
         U5SA==
X-Gm-Message-State: AOAM533ZwpptbeOe49Av3FFkH0rzk4dY9doNS2ZrMAEdWrYOl8VASl7d
        4P5XZTNdFC0Bs6x3WA+uBNLUno2PzKzxQQm9KRnrgw==
X-Google-Smtp-Source: ABdhPJxWNlFPPGl7Vsv8V2y+CBlnOn6N6jJwHtbCbvkQVkKVsx1BcxMewrz6k8okQDlfXULI60m8AeRIXfK0WWBI6Eg=
X-Received: by 2002:a63:b55e:: with SMTP id u30mr18497132pgo.381.1605053939029;
 Tue, 10 Nov 2020 16:18:59 -0800 (PST)
MIME-Version: 1.0
References: <20201106051436.2384842-1-adrian.ratiu@collabora.com>
 <20201106051436.2384842-3-adrian.ratiu@collabora.com> <20201106101419.GB3811063@ubuntu-m3-large-x86>
 <87wnyyvh56.fsf@collabora.com> <CAKwvOdkodob0M0r_AK_4nG3atLGMyNENMd6qVAHSPa92Zh7UZA@mail.gmail.com>
 <871rh2i9xg.fsf@iwork.i-did-not-set--mail-host-address--so-tickle-me>
 <CAKwvOdkm3u83TQDBB-fC0TwKZCFXGh5sAfahKXxA+mnzgDid_w@mail.gmail.com> <87sg9ghil5.fsf@collabora.com>
In-Reply-To: <87sg9ghil5.fsf@collabora.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 10 Nov 2020 16:18:47 -0800
Message-ID: <CAKwvOd=QrU6rCQ4_Ji=XsskPovOSXpk0NkjTqVjLijw1-CZ17Q@mail.gmail.com>
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

On Tue, Nov 10, 2020 at 3:54 PM Adrian Ratiu <adrian.ratiu@collabora.com> wrote:
>
> On Tue, 10 Nov 2020, Nick Desaulniers <ndesaulniers@google.com>
> wrote:
> > On Mon, Nov 9, 2020 at 11:51 AM Adrian Ratiu
> > <adrian.ratiu@collabora.com> wrote:
> >>
> >> On Fri, 06 Nov 2020, Nick Desaulniers <ndesaulniers@google.com>
> >> wrote:
> >> > +#pragma clang loop vectorize(enable)
> >> >         do {
> >> >                 p1[0] ^= p2[0] ^ p3[0] ^ p4[0] ^ p5[0]; p1[1]
> >> >                 ^= p2[1] ^ p3[1] ^ p4[1] ^ p5[1];
> >> > ``` seems to generate the vectorized code.
> >> >
> >> > Why don't we find a way to make those pragma's more toolchain
> >> > portable, rather than open coding them like I have above
> >> > rather than this series?
> >>
> >> Hi again Nick,
> >>
> >> How did you verify the above pragmas generate correct
> >> vectorized code?  Have you tested this specific use case?
> >
> > I read the disassembly before and after my suggested use of
> > pragmas; look for vld/vstr.  You can also add
> > -Rpass-missed=loop-vectorize to CFLAGS_xor-neon.o in
> > arch/arm/lib/Makefile and rebuild arch/arm/lib/xor-neon.o with
> > CONFIG_BTRFS enabled.
> >
> >>
> >> I'm asking because overrulling the cost model might not be
> >> enough, the only thing I can confirm is that the generated code
> >> is changed, but not that it is correct in any way. The object
> >> disasm also looks weird, but I don't have enough knowledge to
> >> start debugging what's happening within LLVM/Clang itself.
> >
> > It doesn't "look weird" to me. The loop is versioned based on a
> > comparison whether the parameters alias or not. There's a
> > non-vectorized version if the parameters are equal or close
> > enough to overlap.  There's another version of the loop that's
> > vectorized.  If you want just the vectorized version, then you
> > have to mark the parameters as __restrict qualified, then check
> > that all callers are ok with that.
> >
>
> Thank you for the explanation, that does make sense now. I'm just
> a compiler optimization noob, sorry. All your help is much
> appreciated.

Don't worry about it; you'll get the hang of it in no time, just stick with it.

>
> >>
> >> I also get some new warnings with your code [1], besides the
> >> previously 'vectorization was possible but not beneficial'
> >> which is still present. It is quite funny because these two
> >> warnings seem to contradict themselves. :)
> >
> > From which compiler?  ``` $ clang
> > -Wpass-failed=transform-warning -c -x c /dev/null warning:
> > unknown warning option '-Wpass-failed=transform-warning'; did
> > you mean '-Wprofile-instr-missing'? [-Wunknown-warning-option]
> > ```
>
> I'm using Clang 10.0.1-1 from the Arch Linux repo.
>
> In the LLVM sources that transform-warning appears to be
> documented under
> llvm-10.0.1.src/docs/Passes.rst:1227:-transform-warning
>
> Here's a build log: http://ix.io/2DIc
>
> I always get those warnings with the pragma change you suggested,
> even on clean builds on latest linux-next.
>
> I looked at the Arch PKGBUILD and they don't appear to do anything
> special other than patching to enable SSP and PIE by default (eg
> llvm bug 13410).

Ah, custom builds of LLVM.  Grepping for transform-warning in LLVM's
sources, I can indeed see such a pass. I'm curious whether Arch is
turning on that pass by default or if you manually enabled
-Wpass-failed=transform-warning in the Makefile?  Maybe I need to do
an assertions enabled build of LLVM or a debug build. Reading through
llvm/docs/Passes.rst and llvm/docs/TransformMetadata.rst, it sounds
like this should be triggered when a "forced optimization has failed."
So I wonder what's the missing variable between it working for me, vs
warning for you?

Godbolt seems to agree with me here: https://godbolt.org/z/Wf6YKv.
Maybe related to the "New Pass Manager" ... digging into that...

>
> >
> > The pragma is clang specific, hence my recommendation to wrap it
> > in an #ifdef __clang__.
> >
>
> Yes, I understand that. :)
>
> >>
> >> At this point I do not trust the compiler and am inclined to do
> >
> > Nonsense.
> >
> >> like was done for GCC when it was broken: disable the
> >> optimization and warn users to upgrade after the compiler is
> >> fixed and confirmed to work.
> >>
> >> If you agree I can send a v2 with this and also drop the GCC
> >> pragma as Arvind and Ard suggested.
> >
> > If you resend "this" as in 2/2, I will NACK it.  There's nothing
> > wrong with the cost model; it's saying there's little point in
> > generating the vectorized version because you're still going to
> > need a non-vectorized loop version anyways.  Claiming there is a
> > compiler bug here is dubious just because the cost models
> > between two compilers differ slightly.
>
> Ok, so that "remark" from the compiler is safe to ignore.

Are you always seeing it when building with the pragma's added, no
change to CFLAGS_xor-neon.o in arch/arm/lib/Makefile?

>
> >
> > Resend the patch removing the warning, remove the GCC pragma,
> > but if you want to change anything here for Clang, use `#pragma
> > clang loop vectorize(enable)` wrapped in an `#ifdef __clang__`.
> >
>
> Thanks for making the NACK clear, so the way forward is to either
> use the pragma if I can figure out the new 'loop not vectorized'
> warning (which might also be a red herring) or just leave Clang as
> is. :)

Yes, though additionally Arvind points out that this code is kind of
curious if there was overlap; maybe the parameters should just be
restrict-qualified.

>
> >>
> >> Kind regards,
> >> Adrian
> >>
> >> [1]
> >> ./include/asm-generic/xor.h:11:1: warning: loop not vectorized:
> >> the optimizer was unable to perform the requested transformation;
> >> the transformation might be disabled or specified as part of an
> >> unsupported transformation ordering
> >> [-Wpass-failed=transform-warning] xor_8regs_2(unsigned long bytes,
> >> unsigned long *p1, unsigned long *p2)

-- 
Thanks,
~Nick Desaulniers
