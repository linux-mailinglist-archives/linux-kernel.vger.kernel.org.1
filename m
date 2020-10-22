Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1AD8296292
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 18:20:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2901630AbgJVQUz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 12:20:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:37298 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2896713AbgJVQUy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 12:20:54 -0400
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B4F2524656
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 16:20:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603383653;
        bh=zLqPCnk51tZOSJUktaRPPsIPSiTVlLOBrvuROFwALEM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=PpacB0q4l3++xJYxlDqYZ0g7N6Rp3n2/Td6NUXgQwAqKPW51LSJTIuVYtrPfbhMPm
         tTelzlU+QrDXyGoHVNnvAoiKoA0CUajmk7kk03Rf75riK0k5Hz05vqwhT4scyMS7ze
         aElTp4H0yhR+PjLyPw4fLHtNqoAnorNxXIs9NCT0=
Received: by mail-oi1-f172.google.com with SMTP id u127so2321533oib.6
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 09:20:53 -0700 (PDT)
X-Gm-Message-State: AOAM5304QJ28dxIlpmYR1HQvldA69GqsYiif1wPaBReX3kCpMOLVy1VV
        qGbPEeRTNoM5FvHfOnLhPifO5P3UkdFGELkuTmM=
X-Google-Smtp-Source: ABdhPJyJKWzQKMkBe++rhloUaXwWaemfXfUZLhD4OjX76YJPM98Y/eZmOvVODdnxLvscLE2BWGxbYOJqW6dDwbk49Gw=
X-Received: by 2002:aca:4085:: with SMTP id n127mr2135345oia.33.1603383652814;
 Thu, 22 Oct 2020 09:20:52 -0700 (PDT)
MIME-Version: 1.0
References: <20201021225737.739-1-digetx@gmail.com> <202010211637.7CFD8435@keescook>
 <773fbdb0-5fc4-ab39-e72d-89845faa4c6d@gmail.com> <202010212028.32E8A5EF9B@keescook>
 <CAMj1kXHXN56xmuwVG3P93Jjwd+NxXTYHtfibPWg5TUADucOdWg@mail.gmail.com>
 <1d2e2b5d-3035-238c-d2ca-14c0c209a6a1@gmail.com> <CAMj1kXERX_Bv1MdfafOVmdmDXPio6Uj897ZZZ7qRERbCXYw_iQ@mail.gmail.com>
 <20201022161118.GP1551@shell.armlinux.org.uk>
In-Reply-To: <20201022161118.GP1551@shell.armlinux.org.uk>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 22 Oct 2020 18:20:40 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGExnUrTuosMpX2NN3=j0HF-8_s1SzLaTyBvq4_LQNT-w@mail.gmail.com>
Message-ID: <CAMj1kXGExnUrTuosMpX2NN3=j0HF-8_s1SzLaTyBvq4_LQNT-w@mail.gmail.com>
Subject: Re: [PATCH v1] ARM: vfp: Use long jump to fix THUMB2 kernel
 compilation error
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Dmitry Osipenko <digetx@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Ingo Molnar <mingo@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Oct 2020 at 18:11, Russell King - ARM Linux admin
<linux@armlinux.org.uk> wrote:
>
> On Thu, Oct 22, 2020 at 06:06:32PM +0200, Ard Biesheuvel wrote:
> > On Thu, 22 Oct 2020 at 17:57, Dmitry Osipenko <digetx@gmail.com> wrote:
> > >
> > > 22.10.2020 10:06, Ard Biesheuvel =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > > > On Thu, 22 Oct 2020 at 05:30, Kees Cook <keescook@chromium.org> wro=
te:
> > > >>
> > > >> On Thu, Oct 22, 2020 at 03:00:06AM +0300, Dmitry Osipenko wrote:
> > > >>> 22.10.2020 02:40, Kees Cook =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > > >>>> On Thu, Oct 22, 2020 at 01:57:37AM +0300, Dmitry Osipenko wrote:
> > > >>>>> The vfp_kmode_exception() function now is unreachable using rel=
ative
> > > >>>>> branching in THUMB2 kernel configuration, resulting in a "reloc=
ation
> > > >>>>> truncated to fit: R_ARM_THM_JUMP19 against symbol `vfp_kmode_ex=
ception'"
> > > >>>>> linker error. Let's use long jump in order to fix the issue.
> > > >>>>
> > > >>>> Eek. Is this with gcc or clang?
> > > >>>
> > > >>> GCC 9.3.0
> > > >>>
> > > >>>>> Fixes: eff8728fe698 ("vmlinux.lds.h: Add PGO and AutoFDO input =
sections")
> > > >>>>
> > > >>>> Are you sure it wasn't 512dd2eebe55 ("arm/build: Add missing sec=
tions") ?
> > > >>>> That commit may have implicitly moved the location of .vfp11_ven=
eer,
> > > >>>> though I thought I had chosen the correct position.
> > > >>>
> > > >>> I re-checked that the fixes tag is correct.
> > > >>>
> > > >>>>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> > > >>>>> ---
> > > >>>>>  arch/arm/vfp/vfphw.S | 3 ++-
> > > >>>>>  1 file changed, 2 insertions(+), 1 deletion(-)
> > > >>>>>
> > > >>>>> diff --git a/arch/arm/vfp/vfphw.S b/arch/arm/vfp/vfphw.S
> > > >>>>> index 4fcff9f59947..6e2b29f0c48d 100644
> > > >>>>> --- a/arch/arm/vfp/vfphw.S
> > > >>>>> +++ b/arch/arm/vfp/vfphw.S
> > > >>>>> @@ -82,7 +82,8 @@ ENTRY(vfp_support_entry)
> > > >>>>>    ldr     r3, [sp, #S_PSR]        @ Neither lazy restore nor F=
P exceptions
> > > >>>>>    and     r3, r3, #MODE_MASK      @ are supported in kernel mo=
de
> > > >>>>>    teq     r3, #USR_MODE
> > > >>>>> -  bne     vfp_kmode_exception     @ Returns through lr
> > > >>>>> +  ldr     r1, =3Dvfp_kmode_exception
> > > >>>>> +  bxne    r1                      @ Returns through lr
> > > >>>>>
> > > >>>>>    VFPFMRX r1, FPEXC               @ Is the VFP enabled?
> > > >>>>>    DBGSTR1 "fpexc %08x", r1
> > > >>>>
> > > >>>> This seems like a workaround though? I suspect the vfp11_veneer =
needs
> > > >>>> moving?
> > > >>>>
> > > >>>
> > > >>> I don't know where it needs to be moved. Please feel free to make=
 a
> > > >>> patch if you have a better idea, I'll be glad to test it.
> > > >>
> > > >> I might have just been distracted by the common "vfp" prefix. It's
> > > >> possible that the text section shuffling just ended up being very =
large,
> > > >> so probably this patch is right then!
> > > >>
> > > >
> > > > I already sent a fix for this issue:
> > > >
> > > > https://www.armlinux.org.uk/developer/patches/viewpatch.php?id=3D90=
18/1
> > > >
> > >
> > > The offending commit contains stable tag, so I assume that fixes tag =
is
> > > mandatory. Yours patch misses the fixes tag.
> >
> > Russell, mind adding that? Or would you like me to update the patch in
> > the patch system?
>
> Rather than adding the IT, I'm suggesting that we solve it a different
> way - ensuring that the two bits of code are co-located. There's no
> reason for them to be separated, and the assembly code entry point is
> already called indirectly.
>
> The problem is the assembly ends up in the .text section which ends up
> at the start of the binary, but depending on the compiler, functions
> in .c files end up in their own sections. It would be good if, as
> Dmitry has shown that it is indeed possible, to have them co-located.
>

Why is that better? I provided a minimal fix which has zero impact on
ARM builds, and minimal impact on Thumb2 builds, given that it retains
the exact same semantics as before, but using a different opcode.

R_ARM_THM_JUMP19 only has -/+ 1 MB range, i.e., smaller than the size
of .text, and so using it for calls to external symbols is still going
to be risky, unless we create a completely separate code section for
VFP related routines. So we may need the IT instruction anyway, at
which point we don't need anything more.
