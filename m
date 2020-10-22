Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A473C296404
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 19:48:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S369366AbgJVRsL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 13:48:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:52058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S369261AbgJVRsK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 13:48:10 -0400
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 89238205CA
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 17:48:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603388889;
        bh=VAm56CTOl0xcs/lcnD7w/i+eq+IA2JPQXF7xmAB/6vA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=rQcvKP5A8DtAvg+1nA1lNxv8VinvqWHgJTyjy7P8kNFgKAiWueYYlQUpIOmD6Pb8D
         bC4f5pu4zDELbCArz+1PGH0A914P4RPRETa/LBNcX2fTxWhPpwHu1XP3xZwL/dC/DX
         RPhF+KIXcHLCpnxnNpjY4qgY1BMZqQn9uZhDYFH8=
Received: by mail-oi1-f171.google.com with SMTP id m128so2623232oig.7
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 10:48:09 -0700 (PDT)
X-Gm-Message-State: AOAM531w9l/rGb4IspT0U8kT/t8P6shNbmeDFogp1WIni+oKAC3aNvc4
        c73NLdX8+IDCyWyiPu/wzH02wjOwMST9oWbjSgs=
X-Google-Smtp-Source: ABdhPJz58h+LcN7MCClzz+jWJyDqnRjakIgflxKhOKEsTVmTU4NBtDd4Mtg5Dku9iDFDdCQyMg+JGFoDMcNPlDgHn2s=
X-Received: by 2002:aca:5a56:: with SMTP id o83mr2194769oib.47.1603388888675;
 Thu, 22 Oct 2020 10:48:08 -0700 (PDT)
MIME-Version: 1.0
References: <202010211637.7CFD8435@keescook> <773fbdb0-5fc4-ab39-e72d-89845faa4c6d@gmail.com>
 <202010212028.32E8A5EF9B@keescook> <CAMj1kXHXN56xmuwVG3P93Jjwd+NxXTYHtfibPWg5TUADucOdWg@mail.gmail.com>
 <1d2e2b5d-3035-238c-d2ca-14c0c209a6a1@gmail.com> <CAMj1kXERX_Bv1MdfafOVmdmDXPio6Uj897ZZZ7qRERbCXYw_iQ@mail.gmail.com>
 <20201022161118.GP1551@shell.armlinux.org.uk> <CAMj1kXGExnUrTuosMpX2NN3=j0HF-8_s1SzLaTyBvq4_LQNT-w@mail.gmail.com>
 <20201022162334.GQ1551@shell.armlinux.org.uk> <53e78602-6370-aeb1-398b-5c065dd562f8@gmail.com>
 <20201022173843.GR1551@shell.armlinux.org.uk>
In-Reply-To: <20201022173843.GR1551@shell.armlinux.org.uk>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 22 Oct 2020 19:47:57 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHFVH=_bp1GAae3tfEnyYyVJz7UfZv=+n=F+355ePWS+g@mail.gmail.com>
Message-ID: <CAMj1kXHFVH=_bp1GAae3tfEnyYyVJz7UfZv=+n=F+355ePWS+g@mail.gmail.com>
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

On Thu, 22 Oct 2020 at 19:38, Russell King - ARM Linux admin
<linux@armlinux.org.uk> wrote:
>
> On Thu, Oct 22, 2020 at 07:34:38PM +0300, Dmitry Osipenko wrote:
> > 22.10.2020 19:23, Russell King - ARM Linux admin =D0=BF=D0=B8=D1=88=D0=
=B5=D1=82:
> > > On Thu, Oct 22, 2020 at 06:20:40PM +0200, Ard Biesheuvel wrote:
> > >> On Thu, 22 Oct 2020 at 18:11, Russell King - ARM Linux admin
> > >> <linux@armlinux.org.uk> wrote:
> > >>>
> > >>> On Thu, Oct 22, 2020 at 06:06:32PM +0200, Ard Biesheuvel wrote:
> > >>>> On Thu, 22 Oct 2020 at 17:57, Dmitry Osipenko <digetx@gmail.com> w=
rote:
> > >>>>>
> > >>>>> 22.10.2020 10:06, Ard Biesheuvel =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > >>>>>> On Thu, 22 Oct 2020 at 05:30, Kees Cook <keescook@chromium.org> =
wrote:
> > >>>>>>>
> > >>>>>>> On Thu, Oct 22, 2020 at 03:00:06AM +0300, Dmitry Osipenko wrote=
:
> > >>>>>>>> 22.10.2020 02:40, Kees Cook =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > >>>>>>>>> On Thu, Oct 22, 2020 at 01:57:37AM +0300, Dmitry Osipenko wro=
te:
> > >>>>>>>>>> The vfp_kmode_exception() function now is unreachable using =
relative
> > >>>>>>>>>> branching in THUMB2 kernel configuration, resulting in a "re=
location
> > >>>>>>>>>> truncated to fit: R_ARM_THM_JUMP19 against symbol `vfp_kmode=
_exception'"
> > >>>>>>>>>> linker error. Let's use long jump in order to fix the issue.
> > >>>>>>>>>
> > >>>>>>>>> Eek. Is this with gcc or clang?
> > >>>>>>>>
> > >>>>>>>> GCC 9.3.0
> > >>>>>>>>
> > >>>>>>>>>> Fixes: eff8728fe698 ("vmlinux.lds.h: Add PGO and AutoFDO inp=
ut sections")
> > >>>>>>>>>
> > >>>>>>>>> Are you sure it wasn't 512dd2eebe55 ("arm/build: Add missing =
sections") ?
> > >>>>>>>>> That commit may have implicitly moved the location of .vfp11_=
veneer,
> > >>>>>>>>> though I thought I had chosen the correct position.
> > >>>>>>>>
> > >>>>>>>> I re-checked that the fixes tag is correct.
> > >>>>>>>>
> > >>>>>>>>>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> > >>>>>>>>>> ---
> > >>>>>>>>>>  arch/arm/vfp/vfphw.S | 3 ++-
> > >>>>>>>>>>  1 file changed, 2 insertions(+), 1 deletion(-)
> > >>>>>>>>>>
> > >>>>>>>>>> diff --git a/arch/arm/vfp/vfphw.S b/arch/arm/vfp/vfphw.S
> > >>>>>>>>>> index 4fcff9f59947..6e2b29f0c48d 100644
> > >>>>>>>>>> --- a/arch/arm/vfp/vfphw.S
> > >>>>>>>>>> +++ b/arch/arm/vfp/vfphw.S
> > >>>>>>>>>> @@ -82,7 +82,8 @@ ENTRY(vfp_support_entry)
> > >>>>>>>>>>    ldr     r3, [sp, #S_PSR]        @ Neither lazy restore no=
r FP exceptions
> > >>>>>>>>>>    and     r3, r3, #MODE_MASK      @ are supported in kernel=
 mode
> > >>>>>>>>>>    teq     r3, #USR_MODE
> > >>>>>>>>>> -  bne     vfp_kmode_exception     @ Returns through lr
> > >>>>>>>>>> +  ldr     r1, =3Dvfp_kmode_exception
> > >>>>>>>>>> +  bxne    r1                      @ Returns through lr
> > >>>>>>>>>>
> > >>>>>>>>>>    VFPFMRX r1, FPEXC               @ Is the VFP enabled?
> > >>>>>>>>>>    DBGSTR1 "fpexc %08x", r1
> > >>>>>>>>>
> > >>>>>>>>> This seems like a workaround though? I suspect the vfp11_vene=
er needs
> > >>>>>>>>> moving?
> > >>>>>>>>>
> > >>>>>>>>
> > >>>>>>>> I don't know where it needs to be moved. Please feel free to m=
ake a
> > >>>>>>>> patch if you have a better idea, I'll be glad to test it.
> > >>>>>>>
> > >>>>>>> I might have just been distracted by the common "vfp" prefix. I=
t's
> > >>>>>>> possible that the text section shuffling just ended up being ve=
ry large,
> > >>>>>>> so probably this patch is right then!
> > >>>>>>>
> > >>>>>>
> > >>>>>> I already sent a fix for this issue:
> > >>>>>>
> > >>>>>> https://www.armlinux.org.uk/developer/patches/viewpatch.php?id=
=3D9018/1
> > >>>>>>
> > >>>>>
> > >>>>> The offending commit contains stable tag, so I assume that fixes =
tag is
> > >>>>> mandatory. Yours patch misses the fixes tag.
> > >>>>
> > >>>> Russell, mind adding that? Or would you like me to update the patc=
h in
> > >>>> the patch system?
> > >>>
> > >>> Rather than adding the IT, I'm suggesting that we solve it a differ=
ent
> > >>> way - ensuring that the two bits of code are co-located. There's no
> > >>> reason for them to be separated, and the assembly code entry point =
is
> > >>> already called indirectly.
> > >>>
> > >>> The problem is the assembly ends up in the .text section which ends=
 up
> > >>> at the start of the binary, but depending on the compiler, function=
s
> > >>> in .c files end up in their own sections. It would be good if, as
> > >>> Dmitry has shown that it is indeed possible, to have them co-locate=
d.
> > >>
> > >> Why is that better? I provided a minimal fix which has zero impact o=
n
> > >> ARM builds, and minimal impact on Thumb2 builds, given that it retai=
ns
> > >> the exact same semantics as before, but using a different opcode.
> > >
> > > I think you just described the reason there. Why should we force
> > > everything to use a different opcode when a short jump _should_
> > > suffice?
> > >
> > > Your patch may be a single line, but it has a slightly greater
> > > impact than the alternative two line solution.
> > >
> >
> > But the two line change isn't portable to stable kernels as-is, isn't i=
t?
>
> Why not?
>

In any case, I'd prefer not to dump VFP exception handling code into
the .vfp11_veneer section, which is documented as below, and typically
empty in our case, given that the only FP code we have in the kernel
is NEON code.



"""
   The '--vfp11-denorm-fix' switch enables a link-time workaround for a
bug in certain VFP11 coprocessor hardware, which sometimes allows
instructions with denorm operands (which must be handled by support
code) to have those operands overwritten by subsequent instructions
before the support code can read the intended values.

   The bug may be avoided in scalar mode if you allow at least one
intervening instruction between a VFP11 instruction which uses a
register and another instruction which writes to the same register, or
at least two intervening instructions if vector mode is in use.  The bug
only affects full-compliance floating-point mode: you do not need this
workaround if you are using "runfast" mode.  Please contact ARM for
further details.

   If you know you are using buggy VFP11 hardware, you can enable this
workaround by specifying the linker option '--vfp-denorm-fix=3Dscalar' if
you are using the VFP11 scalar mode only, or '--vfp-denorm-fix=3Dvector'
if you are using vector mode (the latter also works for scalar code).
The default is '--vfp-denorm-fix=3Dnone'.

   If the workaround is enabled, instructions are scanned for
potentially-troublesome sequences, and a veneer is created for each such
sequence which may trigger the erratum.  The veneer consists of the
first instruction of the sequence and a branch back to the subsequent
instruction.  The original instruction is then replaced with a branch to
the veneer.  The extra cycles required to call and return from the
veneer are sufficient to avoid the erratum in both the scalar and vector
cases.
"""
