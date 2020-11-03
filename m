Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A12172A3D98
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 08:24:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727527AbgKCHYc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 02:24:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:49938 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725958AbgKCHYb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 02:24:31 -0500
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0E28A222B9
        for <linux-kernel@vger.kernel.org>; Tue,  3 Nov 2020 07:24:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604388270;
        bh=4gHxD+7uD+KILg31KqY40G0HO+FIorGuchCTh0bvdw4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=SHGOUY6neVKOGjxAF7ks6GKQQSVtt9XnCEMVWVIO0qJbSF/xFH5h0VGMQZ1fbVwTj
         gAC+QZGS+WA+aKbOVfRo6mVR7pBBGTyQu251ZxCcKSOk48/miVCC/l7gYbhtjWIjxT
         MHgzqAhXbKpz0V17su5glB0zJ8wZkO5xjihqOSxE=
Received: by mail-oo1-f48.google.com with SMTP id o129so3966275ooo.11
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 23:24:30 -0800 (PST)
X-Gm-Message-State: AOAM530rR3j8wfhVKCtKxojw1F4wXwU1nL6RqN3Dhu5u8H++KHRZWqmn
        xkLEjZY7BnsO+SEB/5wUvT1jMCsz9fE5g8bZJac=
X-Google-Smtp-Source: ABdhPJwl3dN+W/2a4XuJe2PT23GVwwnK1kDyPzzXE93dVmCCBmg5miMGGGbnBbFSyvkkeGQosVmccmkU1cvXeyo9b4Y=
X-Received: by 2002:a4a:9806:: with SMTP id y6mr14608231ooi.45.1604388269247;
 Mon, 02 Nov 2020 23:24:29 -0800 (PST)
MIME-Version: 1.0
References: <202010211637.7CFD8435@keescook> <773fbdb0-5fc4-ab39-e72d-89845faa4c6d@gmail.com>
 <202010212028.32E8A5EF9B@keescook> <CAMj1kXHXN56xmuwVG3P93Jjwd+NxXTYHtfibPWg5TUADucOdWg@mail.gmail.com>
 <1d2e2b5d-3035-238c-d2ca-14c0c209a6a1@gmail.com> <CAMj1kXERX_Bv1MdfafOVmdmDXPio6Uj897ZZZ7qRERbCXYw_iQ@mail.gmail.com>
 <20201022161118.GP1551@shell.armlinux.org.uk> <CAMj1kXGExnUrTuosMpX2NN3=j0HF-8_s1SzLaTyBvq4_LQNT-w@mail.gmail.com>
 <20201022162334.GQ1551@shell.armlinux.org.uk> <CAMj1kXF+2kJrUaDyA-Xw4rz2bsuEipX3P4JyPrY1bim76LQvoA@mail.gmail.com>
 <20201022174826.GS1551@shell.armlinux.org.uk> <CAMj1kXHpPbwS8zjsr8S65EMj9XOwPxWiQ5WN_ok8ZAFZg9kSAg@mail.gmail.com>
 <CAMj1kXGok50R+2FZ=LqRAx5N3otC3AvC26=+NUqNC6kSvY2-Lg@mail.gmail.com> <CAMj1kXF6EdrJWASQQp57L=3gni6R_pLvZfCaFxCoH=rMRzK_6A@mail.gmail.com>
In-Reply-To: <CAMj1kXF6EdrJWASQQp57L=3gni6R_pLvZfCaFxCoH=rMRzK_6A@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 3 Nov 2020 08:24:17 +0100
X-Gmail-Original-Message-ID: <CAMj1kXFMiTSakUGnopb8eWRHTM9-0XM0kDaJvTXWDhRPJ3Vsow@mail.gmail.com>
Message-ID: <CAMj1kXFMiTSakUGnopb8eWRHTM9-0XM0kDaJvTXWDhRPJ3Vsow@mail.gmail.com>
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

On Thu, 29 Oct 2020 at 10:56, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Mon, 26 Oct 2020 at 09:58, Ard Biesheuvel <ardb@kernel.org> wrote:
> >
> > On Thu, 22 Oct 2020 at 19:59, Ard Biesheuvel <ardb@kernel.org> wrote:
> > >
> > > On Thu, 22 Oct 2020 at 19:48, Russell King - ARM Linux admin
> > > <linux@armlinux.org.uk> wrote:
> > > >
> > > > On Thu, Oct 22, 2020 at 06:33:17PM +0200, Ard Biesheuvel wrote:
> > > > > On Thu, 22 Oct 2020 at 18:23, Russell King - ARM Linux admin
> > > > > <linux@armlinux.org.uk> wrote:
> > > > > >
> > > > > > On Thu, Oct 22, 2020 at 06:20:40PM +0200, Ard Biesheuvel wrote:
> > > > > > > On Thu, 22 Oct 2020 at 18:11, Russell King - ARM Linux admin
> > > > > > > <linux@armlinux.org.uk> wrote:
> > > > > > > >
> > > > > > > > On Thu, Oct 22, 2020 at 06:06:32PM +0200, Ard Biesheuvel wr=
ote:
> > > > > > > > > On Thu, 22 Oct 2020 at 17:57, Dmitry Osipenko <digetx@gma=
il.com> wrote:
> > > > > > > > > >
> > > > > > > > > > 22.10.2020 10:06, Ard Biesheuvel =D0=BF=D0=B8=D1=88=D0=
=B5=D1=82:
> > > > > > > > > > > On Thu, 22 Oct 2020 at 05:30, Kees Cook <keescook@chr=
omium.org> wrote:
> > > > > > > > > > >>
> > > > > > > > > > >> On Thu, Oct 22, 2020 at 03:00:06AM +0300, Dmitry Osi=
penko wrote:
> > > > > > > > > > >>> 22.10.2020 02:40, Kees Cook =D0=BF=D0=B8=D1=88=D0=
=B5=D1=82:
> > > > > > > > > > >>>> On Thu, Oct 22, 2020 at 01:57:37AM +0300, Dmitry O=
sipenko wrote:
> > > > > > > > > > >>>>> The vfp_kmode_exception() function now is unreach=
able using relative
> > > > > > > > > > >>>>> branching in THUMB2 kernel configuration, resulti=
ng in a "relocation
> > > > > > > > > > >>>>> truncated to fit: R_ARM_THM_JUMP19 against symbol=
 `vfp_kmode_exception'"
> > > > > > > > > > >>>>> linker error. Let's use long jump in order to fix=
 the issue.
> > > > > > > > > > >>>>
> > > > > > > > > > >>>> Eek. Is this with gcc or clang?
> > > > > > > > > > >>>
> > > > > > > > > > >>> GCC 9.3.0
> > > > > > > > > > >>>
> > > > > > > > > > >>>>> Fixes: eff8728fe698 ("vmlinux.lds.h: Add PGO and =
AutoFDO input sections")
> > > > > > > > > > >>>>
> > > > > > > > > > >>>> Are you sure it wasn't 512dd2eebe55 ("arm/build: A=
dd missing sections") ?
> > > > > > > > > > >>>> That commit may have implicitly moved the location=
 of .vfp11_veneer,
> > > > > > > > > > >>>> though I thought I had chosen the correct position=
.
> > > > > > > > > > >>>
> > > > > > > > > > >>> I re-checked that the fixes tag is correct.
> > > > > > > > > > >>>
> > > > > > > > > > >>>>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> > > > > > > > > > >>>>> ---
> > > > > > > > > > >>>>>  arch/arm/vfp/vfphw.S | 3 ++-
> > > > > > > > > > >>>>>  1 file changed, 2 insertions(+), 1 deletion(-)
> > > > > > > > > > >>>>>
> > > > > > > > > > >>>>> diff --git a/arch/arm/vfp/vfphw.S b/arch/arm/vfp/=
vfphw.S
> > > > > > > > > > >>>>> index 4fcff9f59947..6e2b29f0c48d 100644
> > > > > > > > > > >>>>> --- a/arch/arm/vfp/vfphw.S
> > > > > > > > > > >>>>> +++ b/arch/arm/vfp/vfphw.S
> > > > > > > > > > >>>>> @@ -82,7 +82,8 @@ ENTRY(vfp_support_entry)
> > > > > > > > > > >>>>>    ldr     r3, [sp, #S_PSR]        @ Neither lazy=
 restore nor FP exceptions
> > > > > > > > > > >>>>>    and     r3, r3, #MODE_MASK      @ are supporte=
d in kernel mode
> > > > > > > > > > >>>>>    teq     r3, #USR_MODE
> > > > > > > > > > >>>>> -  bne     vfp_kmode_exception     @ Returns thro=
ugh lr
> > > > > > > > > > >>>>> +  ldr     r1, =3Dvfp_kmode_exception
> > > > > > > > > > >>>>> +  bxne    r1                      @ Returns thro=
ugh lr
> > > > > > > > > > >>>>>
> > > > > > > > > > >>>>>    VFPFMRX r1, FPEXC               @ Is the VFP e=
nabled?
> > > > > > > > > > >>>>>    DBGSTR1 "fpexc %08x", r1
> > > > > > > > > > >>>>
> > > > > > > > > > >>>> This seems like a workaround though? I suspect the=
 vfp11_veneer needs
> > > > > > > > > > >>>> moving?
> > > > > > > > > > >>>>
> > > > > > > > > > >>>
> > > > > > > > > > >>> I don't know where it needs to be moved. Please fee=
l free to make a
> > > > > > > > > > >>> patch if you have a better idea, I'll be glad to te=
st it.
> > > > > > > > > > >>
> > > > > > > > > > >> I might have just been distracted by the common "vfp=
" prefix. It's
> > > > > > > > > > >> possible that the text section shuffling just ended =
up being very large,
> > > > > > > > > > >> so probably this patch is right then!
> > > > > > > > > > >>
> > > > > > > > > > >
> > > > > > > > > > > I already sent a fix for this issue:
> > > > > > > > > > >
> > > > > > > > > > > https://www.armlinux.org.uk/developer/patches/viewpat=
ch.php?id=3D9018/1
> > > > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > The offending commit contains stable tag, so I assume t=
hat fixes tag is
> > > > > > > > > > mandatory. Yours patch misses the fixes tag.
> > > > > > > > >
> > > > > > > > > Russell, mind adding that? Or would you like me to update=
 the patch in
> > > > > > > > > the patch system?
> > > > > > > >
> > > > > > > > Rather than adding the IT, I'm suggesting that we solve it =
a different
> > > > > > > > way - ensuring that the two bits of code are co-located. Th=
ere's no
> > > > > > > > reason for them to be separated, and the assembly code entr=
y point is
> > > > > > > > already called indirectly.
> > > > > > > >
> > > > > > > > The problem is the assembly ends up in the .text section wh=
ich ends up
> > > > > > > > at the start of the binary, but depending on the compiler, =
functions
> > > > > > > > in .c files end up in their own sections. It would be good =
if, as
> > > > > > > > Dmitry has shown that it is indeed possible, to have them c=
o-located.
> > > > > > >
> > > > > > > Why is that better? I provided a minimal fix which has zero i=
mpact on
> > > > > > > ARM builds, and minimal impact on Thumb2 builds, given that i=
t retains
> > > > > > > the exact same semantics as before, but using a different opc=
ode.
> > > > > >
> > > > > > I think you just described the reason there. Why should we forc=
e
> > > > > > everything to use a different opcode when a short jump _should_
> > > > > > suffice?
> > > > > >
> > > > >
> > > > > Why should a short jump suffice? The call is to vfp_kmode_excepti=
on(),
> > > > > which we only call in exceptional cases. Why would we want to kee=
p
> > > > > that in close proximity?
> > > >
> > > > You're thinking about it in terms of what happens when the branch i=
s
> > > > taken, rather than also considering that this code path is also
> > > > traversed for _every_ single time that we enter the support code
> > > > not just for kernel mode.
> > > >
> > >
> > > True. If 2 bytes of additional opcode are the concern here, we can
> > > change the current sequence
> > >
> > >    6:   f093 0f10       teq     r3, #16
> > >    a:   f47f affe       bne.w   0 <vfp_kmode_exception>
> > >
> > > to
> > >
> > >    6:   2b10            cmp     r3, #16
> > >    8:   bf18            it      ne
> > >    a:   f7ff bffe       bne.w   0 <vfp_kmode_exception>
> > >
> > > which takes up the exact same space.
> >
> > BTW this code path looks slightly broken for Thumb-2 in any case: if a
> > FP exception is taken in kernel mode on a Thumb2 kernel, we enter the
> > emulation sequence via call_fpe, which will use the wrong set of
> > value/mask pairs to match the opcode. The minimal fix is to move the
> > call_fpe label to the right place, but I think it might be better to
> > move the check for a FP exception in kernel mode to the handling of
> > __und_svc.
>
> Do we have a resolution here? This is causing breakage in kernelci
>
> https://kernelci.org/build/id/5f9a834c5ed3c05dd538101b/

Still broken today

https://kernelci.org/build/id/5fa0c1a74bdb1ea4063fe7e4/

So the options are

a) merge my patch that adds 2 bytes of opcode to the Thumb2 build
b) merge Dmitry's patch that adds an unconditional literal load to all buil=
ds
c) remove kernel mode handling from vfp_support_entry() [my other patch]
d) move sections around so that vfp_kmode_exception is guaranteed to
be in range.
e) do nothing

Given the lack of reports about this issue, it is pretty clear that
few people use the Thumb2 build (which I find odd, tbh, since it
really is much smaller). However, that means that a) is a reasonable
fix, since nobody will notice the potential performance hit either,
and it can easily be backported to wherever the breakage was
introduced. (Note that eff8728fe698, which created the problem is
marked cc:stable itself).

Going forward, I can refine d) so that we can get rid of the kernel
mode path entirely.
