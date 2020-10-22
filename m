Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED004296456
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 20:00:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S369490AbgJVSAG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 14:00:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:59014 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2901458AbgJVSAE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 14:00:04 -0400
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 81FBF24640
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 18:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603389602;
        bh=ZNjs2vBLbhliRCHCSqLJ18Q9yGwwmFLVEdQ1OoIARV0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=pXAsfTDyLtJsTD+/9seadJs8IHIBT3dkHIrDzyF3vK5pImK9sCFnYRFv+Sq6CvlA0
         e3ACR53bQ3d4BkalQaZnmTMMwxAxJUY2A/qLrI7DMakh6ba7Wsj7TwRwe4Rg6+xjmn
         fDf2gF2L7QxIgF6ONRBTtGcGE7LkJfDwQWL8LGy4=
Received: by mail-oi1-f176.google.com with SMTP id f8so2325876oij.10
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 11:00:02 -0700 (PDT)
X-Gm-Message-State: AOAM532+zNb6C0CToROThGVr4aY6sZFEjBZ4vehKrlQBE+dh1HNlSe1G
        dsiaMYzAhZxI+ziEmO3FcHxwrMIxSOvFjgreVa0=
X-Google-Smtp-Source: ABdhPJwgi2e33o5kRMo7b5/CqjpK4ZOwDQewaasnD3qEPnhbmHPEe1y2cd00yKtjI+m2W1av8FWuGkwqR7N3o0T0vSo=
X-Received: by 2002:aca:4085:: with SMTP id n127mr2432214oia.33.1603389601566;
 Thu, 22 Oct 2020 11:00:01 -0700 (PDT)
MIME-Version: 1.0
References: <202010211637.7CFD8435@keescook> <773fbdb0-5fc4-ab39-e72d-89845faa4c6d@gmail.com>
 <202010212028.32E8A5EF9B@keescook> <CAMj1kXHXN56xmuwVG3P93Jjwd+NxXTYHtfibPWg5TUADucOdWg@mail.gmail.com>
 <1d2e2b5d-3035-238c-d2ca-14c0c209a6a1@gmail.com> <CAMj1kXERX_Bv1MdfafOVmdmDXPio6Uj897ZZZ7qRERbCXYw_iQ@mail.gmail.com>
 <20201022161118.GP1551@shell.armlinux.org.uk> <CAMj1kXGExnUrTuosMpX2NN3=j0HF-8_s1SzLaTyBvq4_LQNT-w@mail.gmail.com>
 <20201022162334.GQ1551@shell.armlinux.org.uk> <CAMj1kXF+2kJrUaDyA-Xw4rz2bsuEipX3P4JyPrY1bim76LQvoA@mail.gmail.com>
 <20201022174826.GS1551@shell.armlinux.org.uk>
In-Reply-To: <20201022174826.GS1551@shell.armlinux.org.uk>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 22 Oct 2020 19:59:50 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHpPbwS8zjsr8S65EMj9XOwPxWiQ5WN_ok8ZAFZg9kSAg@mail.gmail.com>
Message-ID: <CAMj1kXHpPbwS8zjsr8S65EMj9XOwPxWiQ5WN_ok8ZAFZg9kSAg@mail.gmail.com>
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

On Thu, 22 Oct 2020 at 19:48, Russell King - ARM Linux admin
<linux@armlinux.org.uk> wrote:
>
> On Thu, Oct 22, 2020 at 06:33:17PM +0200, Ard Biesheuvel wrote:
> > On Thu, 22 Oct 2020 at 18:23, Russell King - ARM Linux admin
> > <linux@armlinux.org.uk> wrote:
> > >
> > > On Thu, Oct 22, 2020 at 06:20:40PM +0200, Ard Biesheuvel wrote:
> > > > On Thu, 22 Oct 2020 at 18:11, Russell King - ARM Linux admin
> > > > <linux@armlinux.org.uk> wrote:
> > > > >
> > > > > On Thu, Oct 22, 2020 at 06:06:32PM +0200, Ard Biesheuvel wrote:
> > > > > > On Thu, 22 Oct 2020 at 17:57, Dmitry Osipenko <digetx@gmail.com=
> wrote:
> > > > > > >
> > > > > > > 22.10.2020 10:06, Ard Biesheuvel =D0=BF=D0=B8=D1=88=D0=B5=D1=
=82:
> > > > > > > > On Thu, 22 Oct 2020 at 05:30, Kees Cook <keescook@chromium.=
org> wrote:
> > > > > > > >>
> > > > > > > >> On Thu, Oct 22, 2020 at 03:00:06AM +0300, Dmitry Osipenko =
wrote:
> > > > > > > >>> 22.10.2020 02:40, Kees Cook =D0=BF=D0=B8=D1=88=D0=B5=D1=
=82:
> > > > > > > >>>> On Thu, Oct 22, 2020 at 01:57:37AM +0300, Dmitry Osipenk=
o wrote:
> > > > > > > >>>>> The vfp_kmode_exception() function now is unreachable u=
sing relative
> > > > > > > >>>>> branching in THUMB2 kernel configuration, resulting in =
a "relocation
> > > > > > > >>>>> truncated to fit: R_ARM_THM_JUMP19 against symbol `vfp_=
kmode_exception'"
> > > > > > > >>>>> linker error. Let's use long jump in order to fix the i=
ssue.
> > > > > > > >>>>
> > > > > > > >>>> Eek. Is this with gcc or clang?
> > > > > > > >>>
> > > > > > > >>> GCC 9.3.0
> > > > > > > >>>
> > > > > > > >>>>> Fixes: eff8728fe698 ("vmlinux.lds.h: Add PGO and AutoFD=
O input sections")
> > > > > > > >>>>
> > > > > > > >>>> Are you sure it wasn't 512dd2eebe55 ("arm/build: Add mis=
sing sections") ?
> > > > > > > >>>> That commit may have implicitly moved the location of .v=
fp11_veneer,
> > > > > > > >>>> though I thought I had chosen the correct position.
> > > > > > > >>>
> > > > > > > >>> I re-checked that the fixes tag is correct.
> > > > > > > >>>
> > > > > > > >>>>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> > > > > > > >>>>> ---
> > > > > > > >>>>>  arch/arm/vfp/vfphw.S | 3 ++-
> > > > > > > >>>>>  1 file changed, 2 insertions(+), 1 deletion(-)
> > > > > > > >>>>>
> > > > > > > >>>>> diff --git a/arch/arm/vfp/vfphw.S b/arch/arm/vfp/vfphw.=
S
> > > > > > > >>>>> index 4fcff9f59947..6e2b29f0c48d 100644
> > > > > > > >>>>> --- a/arch/arm/vfp/vfphw.S
> > > > > > > >>>>> +++ b/arch/arm/vfp/vfphw.S
> > > > > > > >>>>> @@ -82,7 +82,8 @@ ENTRY(vfp_support_entry)
> > > > > > > >>>>>    ldr     r3, [sp, #S_PSR]        @ Neither lazy resto=
re nor FP exceptions
> > > > > > > >>>>>    and     r3, r3, #MODE_MASK      @ are supported in k=
ernel mode
> > > > > > > >>>>>    teq     r3, #USR_MODE
> > > > > > > >>>>> -  bne     vfp_kmode_exception     @ Returns through lr
> > > > > > > >>>>> +  ldr     r1, =3Dvfp_kmode_exception
> > > > > > > >>>>> +  bxne    r1                      @ Returns through lr
> > > > > > > >>>>>
> > > > > > > >>>>>    VFPFMRX r1, FPEXC               @ Is the VFP enabled=
?
> > > > > > > >>>>>    DBGSTR1 "fpexc %08x", r1
> > > > > > > >>>>
> > > > > > > >>>> This seems like a workaround though? I suspect the vfp11=
_veneer needs
> > > > > > > >>>> moving?
> > > > > > > >>>>
> > > > > > > >>>
> > > > > > > >>> I don't know where it needs to be moved. Please feel free=
 to make a
> > > > > > > >>> patch if you have a better idea, I'll be glad to test it.
> > > > > > > >>
> > > > > > > >> I might have just been distracted by the common "vfp" pref=
ix. It's
> > > > > > > >> possible that the text section shuffling just ended up bei=
ng very large,
> > > > > > > >> so probably this patch is right then!
> > > > > > > >>
> > > > > > > >
> > > > > > > > I already sent a fix for this issue:
> > > > > > > >
> > > > > > > > https://www.armlinux.org.uk/developer/patches/viewpatch.php=
?id=3D9018/1
> > > > > > > >
> > > > > > >
> > > > > > > The offending commit contains stable tag, so I assume that fi=
xes tag is
> > > > > > > mandatory. Yours patch misses the fixes tag.
> > > > > >
> > > > > > Russell, mind adding that? Or would you like me to update the p=
atch in
> > > > > > the patch system?
> > > > >
> > > > > Rather than adding the IT, I'm suggesting that we solve it a diff=
erent
> > > > > way - ensuring that the two bits of code are co-located. There's =
no
> > > > > reason for them to be separated, and the assembly code entry poin=
t is
> > > > > already called indirectly.
> > > > >
> > > > > The problem is the assembly ends up in the .text section which en=
ds up
> > > > > at the start of the binary, but depending on the compiler, functi=
ons
> > > > > in .c files end up in their own sections. It would be good if, as
> > > > > Dmitry has shown that it is indeed possible, to have them co-loca=
ted.
> > > >
> > > > Why is that better? I provided a minimal fix which has zero impact =
on
> > > > ARM builds, and minimal impact on Thumb2 builds, given that it reta=
ins
> > > > the exact same semantics as before, but using a different opcode.
> > >
> > > I think you just described the reason there. Why should we force
> > > everything to use a different opcode when a short jump _should_
> > > suffice?
> > >
> >
> > Why should a short jump suffice? The call is to vfp_kmode_exception(),
> > which we only call in exceptional cases. Why would we want to keep
> > that in close proximity?
>
> You're thinking about it in terms of what happens when the branch is
> taken, rather than also considering that this code path is also
> traversed for _every_ single time that we enter the support code
> not just for kernel mode.
>

True. If 2 bytes of additional opcode are the concern here, we can
change the current sequence

   6:   f093 0f10       teq     r3, #16
   a:   f47f affe       bne.w   0 <vfp_kmode_exception>

to

   6:   2b10            cmp     r3, #16
   8:   bf18            it      ne
   a:   f7ff bffe       bne.w   0 <vfp_kmode_exception>

which takes up the exact same space.
