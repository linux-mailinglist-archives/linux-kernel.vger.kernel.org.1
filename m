Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9B0E296255
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 18:06:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2509932AbgJVQGs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 12:06:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:55294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2509835AbgJVQGs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 12:06:48 -0400
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B40E72464B
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 16:06:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603382806;
        bh=Ls/MQbLtf0PDEzX6lAouIYKIJzqCegg9SbnTQc3KmPE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=qeXu2VEWABudWPdRTNxnCefRi8ZA7m0w+GRR1bHc23gqCOpJssPsjExDSqOwc4Bco
         TuP70VFjhmF+U8QPKWef+Y/EDmXEYkcJCffjHMT6IAs58J7Ur2OzxLJbg5CGP60kWg
         gPvO2dRciznUYAWWJsf/mueDWqD0NjghPHu5MZLM=
Received: by mail-oi1-f172.google.com with SMTP id u127so2270214oib.6
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 09:06:46 -0700 (PDT)
X-Gm-Message-State: AOAM533lxRrBZugPXbAhIkbrNJ21BrjAjQqU92f18VGHmpUA+WxwgR0+
        GOqaw4tFi2UVMw9Lw4Q/TP3gOpRFoV0+UleSzgs=
X-Google-Smtp-Source: ABdhPJy/bosloqFElVvH/7AjbIudCNTYS3FmYtNlsv4g30JW15h2mG34rw2NX9DHlI0Ct+7MeuwOYy6eeUyHPdxwufg=
X-Received: by 2002:aca:d64f:: with SMTP id n76mr2223077oig.174.1603382805853;
 Thu, 22 Oct 2020 09:06:45 -0700 (PDT)
MIME-Version: 1.0
References: <20201021225737.739-1-digetx@gmail.com> <202010211637.7CFD8435@keescook>
 <773fbdb0-5fc4-ab39-e72d-89845faa4c6d@gmail.com> <202010212028.32E8A5EF9B@keescook>
 <CAMj1kXHXN56xmuwVG3P93Jjwd+NxXTYHtfibPWg5TUADucOdWg@mail.gmail.com> <1d2e2b5d-3035-238c-d2ca-14c0c209a6a1@gmail.com>
In-Reply-To: <1d2e2b5d-3035-238c-d2ca-14c0c209a6a1@gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 22 Oct 2020 18:06:32 +0200
X-Gmail-Original-Message-ID: <CAMj1kXERX_Bv1MdfafOVmdmDXPio6Uj897ZZZ7qRERbCXYw_iQ@mail.gmail.com>
Message-ID: <CAMj1kXERX_Bv1MdfafOVmdmDXPio6Uj897ZZZ7qRERbCXYw_iQ@mail.gmail.com>
Subject: Re: [PATCH v1] ARM: vfp: Use long jump to fix THUMB2 kernel
 compilation error
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Ingo Molnar <mingo@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Oct 2020 at 17:57, Dmitry Osipenko <digetx@gmail.com> wrote:
>
> 22.10.2020 10:06, Ard Biesheuvel =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > On Thu, 22 Oct 2020 at 05:30, Kees Cook <keescook@chromium.org> wrote:
> >>
> >> On Thu, Oct 22, 2020 at 03:00:06AM +0300, Dmitry Osipenko wrote:
> >>> 22.10.2020 02:40, Kees Cook =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> >>>> On Thu, Oct 22, 2020 at 01:57:37AM +0300, Dmitry Osipenko wrote:
> >>>>> The vfp_kmode_exception() function now is unreachable using relativ=
e
> >>>>> branching in THUMB2 kernel configuration, resulting in a "relocatio=
n
> >>>>> truncated to fit: R_ARM_THM_JUMP19 against symbol `vfp_kmode_except=
ion'"
> >>>>> linker error. Let's use long jump in order to fix the issue.
> >>>>
> >>>> Eek. Is this with gcc or clang?
> >>>
> >>> GCC 9.3.0
> >>>
> >>>>> Fixes: eff8728fe698 ("vmlinux.lds.h: Add PGO and AutoFDO input sect=
ions")
> >>>>
> >>>> Are you sure it wasn't 512dd2eebe55 ("arm/build: Add missing section=
s") ?
> >>>> That commit may have implicitly moved the location of .vfp11_veneer,
> >>>> though I thought I had chosen the correct position.
> >>>
> >>> I re-checked that the fixes tag is correct.
> >>>
> >>>>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> >>>>> ---
> >>>>>  arch/arm/vfp/vfphw.S | 3 ++-
> >>>>>  1 file changed, 2 insertions(+), 1 deletion(-)
> >>>>>
> >>>>> diff --git a/arch/arm/vfp/vfphw.S b/arch/arm/vfp/vfphw.S
> >>>>> index 4fcff9f59947..6e2b29f0c48d 100644
> >>>>> --- a/arch/arm/vfp/vfphw.S
> >>>>> +++ b/arch/arm/vfp/vfphw.S
> >>>>> @@ -82,7 +82,8 @@ ENTRY(vfp_support_entry)
> >>>>>    ldr     r3, [sp, #S_PSR]        @ Neither lazy restore nor FP ex=
ceptions
> >>>>>    and     r3, r3, #MODE_MASK      @ are supported in kernel mode
> >>>>>    teq     r3, #USR_MODE
> >>>>> -  bne     vfp_kmode_exception     @ Returns through lr
> >>>>> +  ldr     r1, =3Dvfp_kmode_exception
> >>>>> +  bxne    r1                      @ Returns through lr
> >>>>>
> >>>>>    VFPFMRX r1, FPEXC               @ Is the VFP enabled?
> >>>>>    DBGSTR1 "fpexc %08x", r1
> >>>>
> >>>> This seems like a workaround though? I suspect the vfp11_veneer need=
s
> >>>> moving?
> >>>>
> >>>
> >>> I don't know where it needs to be moved. Please feel free to make a
> >>> patch if you have a better idea, I'll be glad to test it.
> >>
> >> I might have just been distracted by the common "vfp" prefix. It's
> >> possible that the text section shuffling just ended up being very larg=
e,
> >> so probably this patch is right then!
> >>
> >
> > I already sent a fix for this issue:
> >
> > https://www.armlinux.org.uk/developer/patches/viewpatch.php?id=3D9018/1
> >
>
> The offending commit contains stable tag, so I assume that fixes tag is
> mandatory. Yours patch misses the fixes tag.

Russell, mind adding that? Or would you like me to update the patch in
the patch system?
