Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0D1D29E7ED
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 10:56:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbgJ2J4g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 05:56:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:42052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725779AbgJ2J4f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 05:56:35 -0400
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4E79E2076D
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 09:56:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603965394;
        bh=UIUUMTuyyFka0yoGb4mpTbAWzZnbo3bGVVQRoUp8wo4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=OtLUM0aPNA3YlDXPv4hEUQBPXiNMyw1JGQfALl024K4Hs0bBx0IuTDJcZ9A2ambLe
         N7z2km37pTevSz/a8IL4IfDL5VCv+ffNw5csk0c3TUy6QGXO/iBoFFyjcx+HOpw0NM
         vPFqJh4/P742+7N7imEO9tZyMRbouaFK3ZCaisTU=
Received: by mail-ot1-f42.google.com with SMTP id f97so1738918otb.7
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 02:56:34 -0700 (PDT)
X-Gm-Message-State: AOAM5307dS8k68bJEOBfczeXNQ80ZBH2ZZg1muwGMxfTRjO+1B3W0oTV
        iyl8h2OOrxaLVjp2ggDhJX/RduGweDuuIcPI79M=
X-Google-Smtp-Source: ABdhPJxRkfkZrvAxRvFjp6Zlen190OAfO9c/QC6uwVt1GmRyExyB2hyYDvcla47YZFawIBcnYzCkwwLd72cFcPTHs3A=
X-Received: by 2002:a9d:2daa:: with SMTP id g39mr2734821otb.77.1603965393472;
 Thu, 29 Oct 2020 02:56:33 -0700 (PDT)
MIME-Version: 1.0
References: <202010211637.7CFD8435@keescook> <773fbdb0-5fc4-ab39-e72d-89845faa4c6d@gmail.com>
 <202010212028.32E8A5EF9B@keescook> <CAMj1kXHXN56xmuwVG3P93Jjwd+NxXTYHtfibPWg5TUADucOdWg@mail.gmail.com>
 <1d2e2b5d-3035-238c-d2ca-14c0c209a6a1@gmail.com> <CAMj1kXERX_Bv1MdfafOVmdmDXPio6Uj897ZZZ7qRERbCXYw_iQ@mail.gmail.com>
 <20201022161118.GP1551@shell.armlinux.org.uk> <CAMj1kXGExnUrTuosMpX2NN3=j0HF-8_s1SzLaTyBvq4_LQNT-w@mail.gmail.com>
 <20201022162334.GQ1551@shell.armlinux.org.uk> <CAMj1kXF+2kJrUaDyA-Xw4rz2bsuEipX3P4JyPrY1bim76LQvoA@mail.gmail.com>
 <20201022174826.GS1551@shell.armlinux.org.uk> <CAMj1kXHpPbwS8zjsr8S65EMj9XOwPxWiQ5WN_ok8ZAFZg9kSAg@mail.gmail.com>
 <CAMj1kXGok50R+2FZ=LqRAx5N3otC3AvC26=+NUqNC6kSvY2-Lg@mail.gmail.com>
In-Reply-To: <CAMj1kXGok50R+2FZ=LqRAx5N3otC3AvC26=+NUqNC6kSvY2-Lg@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 29 Oct 2020 10:56:22 +0100
X-Gmail-Original-Message-ID: <CAMj1kXF6EdrJWASQQp57L=3gni6R_pLvZfCaFxCoH=rMRzK_6A@mail.gmail.com>
Message-ID: <CAMj1kXF6EdrJWASQQp57L=3gni6R_pLvZfCaFxCoH=rMRzK_6A@mail.gmail.com>
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

On Mon, 26 Oct 2020 at 09:58, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Thu, 22 Oct 2020 at 19:59, Ard Biesheuvel <ardb@kernel.org> wrote:
> >
> > On Thu, 22 Oct 2020 at 19:48, Russell King - ARM Linux admin
> > <linux@armlinux.org.uk> wrote:
> > >
> > > On Thu, Oct 22, 2020 at 06:33:17PM +0200, Ard Biesheuvel wrote:
> > > > On Thu, 22 Oct 2020 at 18:23, Russell King - ARM Linux admin
> > > > <linux@armlinux.org.uk> wrote:
> > > > >
> > > > > On Thu, Oct 22, 2020 at 06:20:40PM +0200, Ard Biesheuvel wrote:
> > > > > > On Thu, 22 Oct 2020 at 18:11, Russell King - ARM Linux admin
> > > > > > <linux@armlinux.org.uk> wrote:
> > > > > > >
> > > > > > > On Thu, Oct 22, 2020 at 06:06:32PM +0200, Ard Biesheuvel wrot=
e:
> > > > > > > > On Thu, 22 Oct 2020 at 17:57, Dmitry Osipenko <digetx@gmail=
.com> wrote:
> > > > > > > > >
> > > > > > > > > 22.10.2020 10:06, Ard Biesheuvel =D0=BF=D0=B8=D1=88=D0=B5=
=D1=82:
> > > > > > > > > > On Thu, 22 Oct 2020 at 05:30, Kees Cook <keescook@chrom=
ium.org> wrote:
> > > > > > > > > >>
> > > > > > > > > >> On Thu, Oct 22, 2020 at 03:00:06AM +0300, Dmitry Osipe=
nko wrote:
> > > > > > > > > >>> 22.10.2020 02:40, Kees Cook =D0=BF=D0=B8=D1=88=D0=B5=
=D1=82:
> > > > > > > > > >>>> On Thu, Oct 22, 2020 at 01:57:37AM +0300, Dmitry Osi=
penko wrote:
> > > > > > > > > >>>>> The vfp_kmode_exception() function now is unreachab=
le using relative
> > > > > > > > > >>>>> branching in THUMB2 kernel configuration, resulting=
 in a "relocation
> > > > > > > > > >>>>> truncated to fit: R_ARM_THM_JUMP19 against symbol `=
vfp_kmode_exception'"
> > > > > > > > > >>>>> linker error. Let's use long jump in order to fix t=
he issue.
> > > > > > > > > >>>>
> > > > > > > > > >>>> Eek. Is this with gcc or clang?
> > > > > > > > > >>>
> > > > > > > > > >>> GCC 9.3.0
> > > > > > > > > >>>
> > > > > > > > > >>>>> Fixes: eff8728fe698 ("vmlinux.lds.h: Add PGO and Au=
toFDO input sections")
> > > > > > > > > >>>>
> > > > > > > > > >>>> Are you sure it wasn't 512dd2eebe55 ("arm/build: Add=
 missing sections") ?
> > > > > > > > > >>>> That commit may have implicitly moved the location o=
f .vfp11_veneer,
> > > > > > > > > >>>> though I thought I had chosen the correct position.
> > > > > > > > > >>>
> > > > > > > > > >>> I re-checked that the fixes tag is correct.
> > > > > > > > > >>>
> > > > > > > > > >>>>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> > > > > > > > > >>>>> ---
> > > > > > > > > >>>>>  arch/arm/vfp/vfphw.S | 3 ++-
> > > > > > > > > >>>>>  1 file changed, 2 insertions(+), 1 deletion(-)
> > > > > > > > > >>>>>
> > > > > > > > > >>>>> diff --git a/arch/arm/vfp/vfphw.S b/arch/arm/vfp/vf=
phw.S
> > > > > > > > > >>>>> index 4fcff9f59947..6e2b29f0c48d 100644
> > > > > > > > > >>>>> --- a/arch/arm/vfp/vfphw.S
> > > > > > > > > >>>>> +++ b/arch/arm/vfp/vfphw.S
> > > > > > > > > >>>>> @@ -82,7 +82,8 @@ ENTRY(vfp_support_entry)
> > > > > > > > > >>>>>    ldr     r3, [sp, #S_PSR]        @ Neither lazy r=
estore nor FP exceptions
> > > > > > > > > >>>>>    and     r3, r3, #MODE_MASK      @ are supported =
in kernel mode
> > > > > > > > > >>>>>    teq     r3, #USR_MODE
> > > > > > > > > >>>>> -  bne     vfp_kmode_exception     @ Returns throug=
h lr
> > > > > > > > > >>>>> +  ldr     r1, =3Dvfp_kmode_exception
> > > > > > > > > >>>>> +  bxne    r1                      @ Returns throug=
h lr
> > > > > > > > > >>>>>
> > > > > > > > > >>>>>    VFPFMRX r1, FPEXC               @ Is the VFP ena=
bled?
> > > > > > > > > >>>>>    DBGSTR1 "fpexc %08x", r1
> > > > > > > > > >>>>
> > > > > > > > > >>>> This seems like a workaround though? I suspect the v=
fp11_veneer needs
> > > > > > > > > >>>> moving?
> > > > > > > > > >>>>
> > > > > > > > > >>>
> > > > > > > > > >>> I don't know where it needs to be moved. Please feel =
free to make a
> > > > > > > > > >>> patch if you have a better idea, I'll be glad to test=
 it.
> > > > > > > > > >>
> > > > > > > > > >> I might have just been distracted by the common "vfp" =
prefix. It's
> > > > > > > > > >> possible that the text section shuffling just ended up=
 being very large,
> > > > > > > > > >> so probably this patch is right then!
> > > > > > > > > >>
> > > > > > > > > >
> > > > > > > > > > I already sent a fix for this issue:
> > > > > > > > > >
> > > > > > > > > > https://www.armlinux.org.uk/developer/patches/viewpatch=
.php?id=3D9018/1
> > > > > > > > > >
> > > > > > > > >
> > > > > > > > > The offending commit contains stable tag, so I assume tha=
t fixes tag is
> > > > > > > > > mandatory. Yours patch misses the fixes tag.
> > > > > > > >
> > > > > > > > Russell, mind adding that? Or would you like me to update t=
he patch in
> > > > > > > > the patch system?
> > > > > > >
> > > > > > > Rather than adding the IT, I'm suggesting that we solve it a =
different
> > > > > > > way - ensuring that the two bits of code are co-located. Ther=
e's no
> > > > > > > reason for them to be separated, and the assembly code entry =
point is
> > > > > > > already called indirectly.
> > > > > > >
> > > > > > > The problem is the assembly ends up in the .text section whic=
h ends up
> > > > > > > at the start of the binary, but depending on the compiler, fu=
nctions
> > > > > > > in .c files end up in their own sections. It would be good if=
, as
> > > > > > > Dmitry has shown that it is indeed possible, to have them co-=
located.
> > > > > >
> > > > > > Why is that better? I provided a minimal fix which has zero imp=
act on
> > > > > > ARM builds, and minimal impact on Thumb2 builds, given that it =
retains
> > > > > > the exact same semantics as before, but using a different opcod=
e.
> > > > >
> > > > > I think you just described the reason there. Why should we force
> > > > > everything to use a different opcode when a short jump _should_
> > > > > suffice?
> > > > >
> > > >
> > > > Why should a short jump suffice? The call is to vfp_kmode_exception=
(),
> > > > which we only call in exceptional cases. Why would we want to keep
> > > > that in close proximity?
> > >
> > > You're thinking about it in terms of what happens when the branch is
> > > taken, rather than also considering that this code path is also
> > > traversed for _every_ single time that we enter the support code
> > > not just for kernel mode.
> > >
> >
> > True. If 2 bytes of additional opcode are the concern here, we can
> > change the current sequence
> >
> >    6:   f093 0f10       teq     r3, #16
> >    a:   f47f affe       bne.w   0 <vfp_kmode_exception>
> >
> > to
> >
> >    6:   2b10            cmp     r3, #16
> >    8:   bf18            it      ne
> >    a:   f7ff bffe       bne.w   0 <vfp_kmode_exception>
> >
> > which takes up the exact same space.
>
> BTW this code path looks slightly broken for Thumb-2 in any case: if a
> FP exception is taken in kernel mode on a Thumb2 kernel, we enter the
> emulation sequence via call_fpe, which will use the wrong set of
> value/mask pairs to match the opcode. The minimal fix is to move the
> call_fpe label to the right place, but I think it might be better to
> move the check for a FP exception in kernel mode to the handling of
> __und_svc.

Do we have a resolution here? This is causing breakage in kernelci

https://kernelci.org/build/id/5f9a834c5ed3c05dd538101b/
