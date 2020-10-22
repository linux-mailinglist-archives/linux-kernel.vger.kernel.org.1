Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25B942958CA
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 09:06:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505112AbgJVHGk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 03:06:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:59444 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2504797AbgJVHGk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 03:06:40 -0400
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5E0C221534
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 07:06:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603350399;
        bh=P+1vZ8unu+0ns0wljqnT1FgTdU/YiidiqdFoESKRWCs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=VVfx0awhyqBJqfMYvDQBfd6ICEVb8eLQ3+JnHI0TlfuegiD0eWrjKAZFPBGB3BGZB
         kYZPcuKXu8DJeb9X9TAUa0AQQg07i5sXjaCLkLb1VXH4cxtvnIVNHxyh08QxuSZapP
         BlPCVIFsd49f0q4IJ2SJ7xSWJbcMcjdyP0OFQPY0=
Received: by mail-oi1-f171.google.com with SMTP id n3so723531oie.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 00:06:39 -0700 (PDT)
X-Gm-Message-State: AOAM532saDP0DDjzXoGsfkkySONodwhLHjtSycV/aA2GN+DiFzPCl5VS
        scU/kq2l3AFkSqTLEORfGWlrujCzKXYZq71aySg=
X-Google-Smtp-Source: ABdhPJwCjYtB5nNwE4OfiydcST8z0itvvgSzMtW3Mo/CktytbXqt8eBtjFeuc57QkLfWjunTGtnpO0gB9a6+BFcttj0=
X-Received: by 2002:aca:4085:: with SMTP id n127mr639122oia.33.1603350398525;
 Thu, 22 Oct 2020 00:06:38 -0700 (PDT)
MIME-Version: 1.0
References: <20201021225737.739-1-digetx@gmail.com> <202010211637.7CFD8435@keescook>
 <773fbdb0-5fc4-ab39-e72d-89845faa4c6d@gmail.com> <202010212028.32E8A5EF9B@keescook>
In-Reply-To: <202010212028.32E8A5EF9B@keescook>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 22 Oct 2020 09:06:27 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHXN56xmuwVG3P93Jjwd+NxXTYHtfibPWg5TUADucOdWg@mail.gmail.com>
Message-ID: <CAMj1kXHXN56xmuwVG3P93Jjwd+NxXTYHtfibPWg5TUADucOdWg@mail.gmail.com>
Subject: Re: [PATCH v1] ARM: vfp: Use long jump to fix THUMB2 kernel
 compilation error
To:     Kees Cook <keescook@chromium.org>
Cc:     Dmitry Osipenko <digetx@gmail.com>,
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

On Thu, 22 Oct 2020 at 05:30, Kees Cook <keescook@chromium.org> wrote:
>
> On Thu, Oct 22, 2020 at 03:00:06AM +0300, Dmitry Osipenko wrote:
> > 22.10.2020 02:40, Kees Cook =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > > On Thu, Oct 22, 2020 at 01:57:37AM +0300, Dmitry Osipenko wrote:
> > >> The vfp_kmode_exception() function now is unreachable using relative
> > >> branching in THUMB2 kernel configuration, resulting in a "relocation
> > >> truncated to fit: R_ARM_THM_JUMP19 against symbol `vfp_kmode_excepti=
on'"
> > >> linker error. Let's use long jump in order to fix the issue.
> > >
> > > Eek. Is this with gcc or clang?
> >
> > GCC 9.3.0
> >
> > >> Fixes: eff8728fe698 ("vmlinux.lds.h: Add PGO and AutoFDO input secti=
ons")
> > >
> > > Are you sure it wasn't 512dd2eebe55 ("arm/build: Add missing sections=
") ?
> > > That commit may have implicitly moved the location of .vfp11_veneer,
> > > though I thought I had chosen the correct position.
> >
> > I re-checked that the fixes tag is correct.
> >
> > >> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> > >> ---
> > >>  arch/arm/vfp/vfphw.S | 3 ++-
> > >>  1 file changed, 2 insertions(+), 1 deletion(-)
> > >>
> > >> diff --git a/arch/arm/vfp/vfphw.S b/arch/arm/vfp/vfphw.S
> > >> index 4fcff9f59947..6e2b29f0c48d 100644
> > >> --- a/arch/arm/vfp/vfphw.S
> > >> +++ b/arch/arm/vfp/vfphw.S
> > >> @@ -82,7 +82,8 @@ ENTRY(vfp_support_entry)
> > >>    ldr     r3, [sp, #S_PSR]        @ Neither lazy restore nor FP exc=
eptions
> > >>    and     r3, r3, #MODE_MASK      @ are supported in kernel mode
> > >>    teq     r3, #USR_MODE
> > >> -  bne     vfp_kmode_exception     @ Returns through lr
> > >> +  ldr     r1, =3Dvfp_kmode_exception
> > >> +  bxne    r1                      @ Returns through lr
> > >>
> > >>    VFPFMRX r1, FPEXC               @ Is the VFP enabled?
> > >>    DBGSTR1 "fpexc %08x", r1
> > >
> > > This seems like a workaround though? I suspect the vfp11_veneer needs
> > > moving?
> > >
> >
> > I don't know where it needs to be moved. Please feel free to make a
> > patch if you have a better idea, I'll be glad to test it.
>
> I might have just been distracted by the common "vfp" prefix. It's
> possible that the text section shuffling just ended up being very large,
> so probably this patch is right then!
>

I already sent a fix for this issue:

https://www.armlinux.org.uk/developer/patches/viewpatch.php?id=3D9018/1
