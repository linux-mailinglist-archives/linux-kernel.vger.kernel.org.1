Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 506B0296411
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 19:51:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S368277AbgJVRv0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 13:51:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:53214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S368256AbgJVRv0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 13:51:26 -0400
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 72ED620936
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 17:51:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603389084;
        bh=kn6amba9nRBfk0i96wjfXTH5WmBFGVUztWOgdfUjR/0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=1JQ57i9SxgS9ybjgwhlAUPwEcEYepjhgDq4fcuHygFON30vWihVNUPzQ6Oiz5cvLZ
         xyKknBbBQe+wPh04DJ6YLY97g+NgutEhQjQjZG6MXExovAY16PQ7VAGD8R1o4z+kLy
         FWKsqKcNtiT854i1chyak/H03Tqt8hvxjT+xxzXA=
Received: by mail-ot1-f43.google.com with SMTP id e20so2251451otj.11
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 10:51:24 -0700 (PDT)
X-Gm-Message-State: AOAM530UaULR2k3E4ZOzVPW6vQrdHW3pVWM+5lQgoy4OpqNFuwFEwgSj
        puHhLvksJo+Mmip5utAKwRAURNiFBp1rn3rN4GI=
X-Google-Smtp-Source: ABdhPJwoDr+KMq2qbB9azqypx7Qg67kK5Gd5MsqZdE7zXrQKWUIZHvTkRxjUpe2OuKagGb+zLTQ6ms+0l/OvHeS2CPA=
X-Received: by 2002:a9d:6c92:: with SMTP id c18mr2570122otr.108.1603389083582;
 Thu, 22 Oct 2020 10:51:23 -0700 (PDT)
MIME-Version: 1.0
References: <202010212028.32E8A5EF9B@keescook> <CAMj1kXHXN56xmuwVG3P93Jjwd+NxXTYHtfibPWg5TUADucOdWg@mail.gmail.com>
 <1d2e2b5d-3035-238c-d2ca-14c0c209a6a1@gmail.com> <CAMj1kXERX_Bv1MdfafOVmdmDXPio6Uj897ZZZ7qRERbCXYw_iQ@mail.gmail.com>
 <20201022161118.GP1551@shell.armlinux.org.uk> <CAMj1kXGExnUrTuosMpX2NN3=j0HF-8_s1SzLaTyBvq4_LQNT-w@mail.gmail.com>
 <20201022162334.GQ1551@shell.armlinux.org.uk> <53e78602-6370-aeb1-398b-5c065dd562f8@gmail.com>
 <20201022173843.GR1551@shell.armlinux.org.uk> <CAMj1kXHFVH=_bp1GAae3tfEnyYyVJz7UfZv=+n=F+355ePWS+g@mail.gmail.com>
 <20201022175009.GT1551@shell.armlinux.org.uk>
In-Reply-To: <20201022175009.GT1551@shell.armlinux.org.uk>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 22 Oct 2020 19:51:12 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHCPYU2ak_n4y6KruteoF3vE5EeiWcWpYsfh6WKXU7xnw@mail.gmail.com>
Message-ID: <CAMj1kXHCPYU2ak_n4y6KruteoF3vE5EeiWcWpYsfh6WKXU7xnw@mail.gmail.com>
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

On Thu, 22 Oct 2020 at 19:50, Russell King - ARM Linux admin
<linux@armlinux.org.uk> wrote:
>
> On Thu, Oct 22, 2020 at 07:47:57PM +0200, Ard Biesheuvel wrote:
> > On Thu, 22 Oct 2020 at 19:38, Russell King - ARM Linux admin
> > <linux@armlinux.org.uk> wrote:
> > >
> > > On Thu, Oct 22, 2020 at 07:34:38PM +0300, Dmitry Osipenko wrote:
> > > > 22.10.2020 19:23, Russell King - ARM Linux admin =D0=BF=D0=B8=D1=88=
=D0=B5=D1=82:
> > > > > On Thu, Oct 22, 2020 at 06:20:40PM +0200, Ard Biesheuvel wrote:
> > > > >> On Thu, 22 Oct 2020 at 18:11, Russell King - ARM Linux admin
> > > > >> <linux@armlinux.org.uk> wrote:
> > > > >>>
> > > > >>> On Thu, Oct 22, 2020 at 06:06:32PM +0200, Ard Biesheuvel wrote:
> > > > >>>> On Thu, 22 Oct 2020 at 17:57, Dmitry Osipenko <digetx@gmail.co=
m> wrote:
> > > > >>>>>
> > > > >>>>> 22.10.2020 10:06, Ard Biesheuvel =D0=BF=D0=B8=D1=88=D0=B5=D1=
=82:
> > > > >>>>>> On Thu, 22 Oct 2020 at 05:30, Kees Cook <keescook@chromium.o=
rg> wrote:
> > > > >>>>>>>
> > > > >>>>>>> On Thu, Oct 22, 2020 at 03:00:06AM +0300, Dmitry Osipenko w=
rote:
> > > > >>>>>>>> 22.10.2020 02:40, Kees Cook =D0=BF=D0=B8=D1=88=D0=B5=D1=82=
:
> > > > >>>>>>>>> On Thu, Oct 22, 2020 at 01:57:37AM +0300, Dmitry Osipenko=
 wrote:
> > > > >>>>>>>>>> The vfp_kmode_exception() function now is unreachable us=
ing relative
> > > > >>>>>>>>>> branching in THUMB2 kernel configuration, resulting in a=
 "relocation
> > > > >>>>>>>>>> truncated to fit: R_ARM_THM_JUMP19 against symbol `vfp_k=
mode_exception'"
> > > > >>>>>>>>>> linker error. Let's use long jump in order to fix the is=
sue.
> > > > >>>>>>>>>
> > > > >>>>>>>>> Eek. Is this with gcc or clang?
> > > > >>>>>>>>
> > > > >>>>>>>> GCC 9.3.0
> > > > >>>>>>>>
> > > > >>>>>>>>>> Fixes: eff8728fe698 ("vmlinux.lds.h: Add PGO and AutoFDO=
 input sections")
> > > > >>>>>>>>>
> > > > >>>>>>>>> Are you sure it wasn't 512dd2eebe55 ("arm/build: Add miss=
ing sections") ?
> > > > >>>>>>>>> That commit may have implicitly moved the location of .vf=
p11_veneer,
> > > > >>>>>>>>> though I thought I had chosen the correct position.
> > > > >>>>>>>>
> > > > >>>>>>>> I re-checked that the fixes tag is correct.
> > > > >>>>>>>>
> > > > >>>>>>>>>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> > > > >>>>>>>>>> ---
> > > > >>>>>>>>>>  arch/arm/vfp/vfphw.S | 3 ++-
> > > > >>>>>>>>>>  1 file changed, 2 insertions(+), 1 deletion(-)
> > > > >>>>>>>>>>
> > > > >>>>>>>>>> diff --git a/arch/arm/vfp/vfphw.S b/arch/arm/vfp/vfphw.S
> > > > >>>>>>>>>> index 4fcff9f59947..6e2b29f0c48d 100644
> > > > >>>>>>>>>> --- a/arch/arm/vfp/vfphw.S
> > > > >>>>>>>>>> +++ b/arch/arm/vfp/vfphw.S
> > > > >>>>>>>>>> @@ -82,7 +82,8 @@ ENTRY(vfp_support_entry)
> > > > >>>>>>>>>>    ldr     r3, [sp, #S_PSR]        @ Neither lazy restor=
e nor FP exceptions
> > > > >>>>>>>>>>    and     r3, r3, #MODE_MASK      @ are supported in ke=
rnel mode
> > > > >>>>>>>>>>    teq     r3, #USR_MODE
> > > > >>>>>>>>>> -  bne     vfp_kmode_exception     @ Returns through lr
> > > > >>>>>>>>>> +  ldr     r1, =3Dvfp_kmode_exception
> > > > >>>>>>>>>> +  bxne    r1                      @ Returns through lr
> > > > >>>>>>>>>>
> > > > >>>>>>>>>>    VFPFMRX r1, FPEXC               @ Is the VFP enabled?
> > > > >>>>>>>>>>    DBGSTR1 "fpexc %08x", r1
> > > > >>>>>>>>>
> > > > >>>>>>>>> This seems like a workaround though? I suspect the vfp11_=
veneer needs
> > > > >>>>>>>>> moving?
> > > > >>>>>>>>>
> > > > >>>>>>>>
> > > > >>>>>>>> I don't know where it needs to be moved. Please feel free =
to make a
> > > > >>>>>>>> patch if you have a better idea, I'll be glad to test it.
> > > > >>>>>>>
> > > > >>>>>>> I might have just been distracted by the common "vfp" prefi=
x. It's
> > > > >>>>>>> possible that the text section shuffling just ended up bein=
g very large,
> > > > >>>>>>> so probably this patch is right then!
> > > > >>>>>>>
> > > > >>>>>>
> > > > >>>>>> I already sent a fix for this issue:
> > > > >>>>>>
> > > > >>>>>> https://www.armlinux.org.uk/developer/patches/viewpatch.php?=
id=3D9018/1
> > > > >>>>>>
> > > > >>>>>
> > > > >>>>> The offending commit contains stable tag, so I assume that fi=
xes tag is
> > > > >>>>> mandatory. Yours patch misses the fixes tag.
> > > > >>>>
> > > > >>>> Russell, mind adding that? Or would you like me to update the =
patch in
> > > > >>>> the patch system?
> > > > >>>
> > > > >>> Rather than adding the IT, I'm suggesting that we solve it a di=
fferent
> > > > >>> way - ensuring that the two bits of code are co-located. There'=
s no
> > > > >>> reason for them to be separated, and the assembly code entry po=
int is
> > > > >>> already called indirectly.
> > > > >>>
> > > > >>> The problem is the assembly ends up in the .text section which =
ends up
> > > > >>> at the start of the binary, but depending on the compiler, func=
tions
> > > > >>> in .c files end up in their own sections. It would be good if, =
as
> > > > >>> Dmitry has shown that it is indeed possible, to have them co-lo=
cated.
> > > > >>
> > > > >> Why is that better? I provided a minimal fix which has zero impa=
ct on
> > > > >> ARM builds, and minimal impact on Thumb2 builds, given that it r=
etains
> > > > >> the exact same semantics as before, but using a different opcode=
.
> > > > >
> > > > > I think you just described the reason there. Why should we force
> > > > > everything to use a different opcode when a short jump _should_
> > > > > suffice?
> > > > >
> > > > > Your patch may be a single line, but it has a slightly greater
> > > > > impact than the alternative two line solution.
> > > > >
> > > >
> > > > But the two line change isn't portable to stable kernels as-is, isn=
't it?
> > >
> > > Why not?
> > >
> >
> > In any case, I'd prefer not to dump VFP exception handling code into
> > the .vfp11_veneer section, which is documented as below, and typically
> > empty in our case, given that the only FP code we have in the kernel
> > is NEON code.
>
> This is getting out of hand, and really getting beyond a joke. I
> didn't say put it in the ".vfp11_veneer" section.
>

No, but that is what Dmitry's patch proposes.
