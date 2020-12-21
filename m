Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D4872DFDE4
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Dec 2020 17:06:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726070AbgLUQFJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 11:05:09 -0500
Received: from conssluserg-04.nifty.com ([210.131.2.83]:41609 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725875AbgLUQFI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 11:05:08 -0500
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id 0BLG4BUL000395
        for <linux-kernel@vger.kernel.org>; Tue, 22 Dec 2020 01:04:12 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com 0BLG4BUL000395
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1608566652;
        bh=lt7QJ/ViUhaR2sTHND7KcpA46D+mwqoFuyo5jkatY2U=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=fjiQ1zC6YNg91jNA/IMAaDkUDdmbeAzXe5QRZ3fg1duOQml4lujmKvKYdJHc5sTV0
         im32kxiabVnN/0J4r7rWlBUXzmCIP4hdnL3YJcrC9sbs+4jBtYyWyt0RxWf0ZfimXP
         06i8iH9Lysyh43uyRYOoAyT3fEvvbWy+hMxkI4eylH5Q71MSdM5lzhMR1wfSawQWKw
         bkPg6siFH/q401rCh10FStGYQXzkUqpWgfJTEoeRV78bxxNOzzg7qWMdeW6CuQH393
         WSSoyiZ0uQGD5O67UFO3cBd4IcSorUgZf7lA3d/LWigV1DqfGNJLPT8BEcQAXjvgDS
         iZp/DxaYCdBOw==
X-Nifty-SrcIP: [209.85.210.181]
Received: by mail-pf1-f181.google.com with SMTP id f9so6669894pfc.11
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 08:04:12 -0800 (PST)
X-Gm-Message-State: AOAM532h4kFrgit1tdklL5zF2mCeV/qEvoBH0gksAKkOzPyPPuiOUA5i
        JQ5eEYFkaQmFPab0ti2jbOfRfTTH1WOA2UXBawc=
X-Google-Smtp-Source: ABdhPJwl7Lg7YHs2Shs8fcvpayfxnSI08fjhU9jYZ9rZj5+bYXTzebgUdc91NdRhLm3/+rGmEu8ea8cgY0a2eTd1cvY=
X-Received: by 2002:a62:d142:0:b029:19e:62a0:ca1a with SMTP id
 t2-20020a62d1420000b029019e62a0ca1amr15841173pfl.80.1608566650503; Mon, 21
 Dec 2020 08:04:10 -0800 (PST)
MIME-Version: 1.0
References: <20201218024540.1102650-1-masahiroy@kernel.org> <55dc2724-cdfe-28ad-395d-707fe9bae2db@arm.com>
In-Reply-To: <55dc2724-cdfe-28ad-395d-707fe9bae2db@arm.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 22 Dec 2020 01:03:33 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQY18miT=yPJBe9ycn7V=7ZO2XxKym6zdfGyCyFJWw9Hg@mail.gmail.com>
Message-ID: <CAK7LNAQY18miT=yPJBe9ycn7V=7ZO2XxKym6zdfGyCyFJWw9Hg@mail.gmail.com>
Subject: Re: [PATCH] arm64: do not descend to vdso directories twice
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 21, 2020 at 11:36 PM Vincenzo Frascino
<vincenzo.frascino@arm.com> wrote:
>
> Hi Masahiro,
>
> On 12/18/20 2:45 AM, Masahiro Yamada wrote:
> > arm64 descends into each vdso directory twice; first in vdso_prepare,
> > second during the ordinary build process.
> >
> > PPC mimicked it and uncovered a problem [1]. In the first descend,
> > Kbuild directly visits the vdso directories, therefore it does not
> > inherit subdir-ccflags-y from upper directories.
> >
> > This means the command line parameters may differ between the two.
> > If it happens, the offset values in the generated headers might be
> > different from real offsets of vdso.so in the kernel.
> >
> > This potential danger should be avoided. The vdso directories are
> > built in the vdso_prepare stage, so the second descend is unneeded.
> >
> > [1]: https://lore.kernel.org/linux-kbuild/CAK7LNARAkJ3_-4gX0VA2UkapbOftuzfSTVMBbgbw=HD8n7N+7w@mail.gmail.com/T/#ma10dcb961fda13f36d42d58fa6cb2da988b7e73a
> >
>
> I could not reproduce the problem you are reporting on arm64. Could you please
> provide some steps?


As far as I see in arm64 Makefiles, you cannot reproduce it.
So, this is a _potential_ problem.

When somebody adds subdir-ccflags-y to arch/arm64/Kbuild or
arch/arm64/kernel/Makefile,
the real issue will suddenly come up.


arm64 is the first arch that implemented vdso-offsets.h

arch maintainers tend to copy Makefiles from existing ones.

Now PPC is the second with almost the same Makefile implementation.

This time, powerpc hit the problem because arch/powerpc/Kbuild
has subdir-ccflags-y.

I do not want to be bothered every time arch maintainers hit this issue.
So, I want to fix arm64 first,
then powerpc will eventually copy the correct Makefiles.




> In my case the vDSO library is not rebuilt as a result of the procedure reported
> in the email you linked at [1].
>
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > ---
> >
> >  arch/arm64/Makefile                                | 10 ++++++----
> >  arch/arm64/kernel/Makefile                         |  5 +++--
> >  arch/arm64/kernel/{vdso/vdso.S => vdso-wrap.S}     |  0
> >  arch/arm64/kernel/vdso/Makefile                    |  1 -
> >  arch/arm64/kernel/{vdso32/vdso.S => vdso32-wrap.S} |  0
> >  arch/arm64/kernel/vdso32/Makefile                  |  1 -
> >  6 files changed, 9 insertions(+), 8 deletions(-)
> >  rename arch/arm64/kernel/{vdso/vdso.S => vdso-wrap.S} (100%)
> >  rename arch/arm64/kernel/{vdso32/vdso.S => vdso32-wrap.S} (100%)
> >
> > diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
> > index 6a87d592bd00..f18d20a68170 100644
> > --- a/arch/arm64/Makefile
> > +++ b/arch/arm64/Makefile
> > @@ -179,10 +179,12 @@ ifeq ($(KBUILD_EXTMOD),)
> >  # this hack.
> >  prepare: vdso_prepare
> >  vdso_prepare: prepare0
> > -     $(Q)$(MAKE) $(build)=arch/arm64/kernel/vdso include/generated/vdso-offsets.h
> > -     $(if $(CONFIG_COMPAT_VDSO),$(Q)$(MAKE) \
> > -             $(build)=arch/arm64/kernel/vdso32  \
> > -             include/generated/vdso32-offsets.h)
> > +     $(Q)$(MAKE) $(build)=arch/arm64/kernel/vdso \
> > +     include/generated/vdso-offsets.h arch/arm64/kernel/vdso/vdso.so
> > +ifdef CONFIG_COMPAT_VDSO
> > +     $(Q)$(MAKE) $(build)=arch/arm64/kernel/vdso32 \
> > +     include/generated/vdso32-offsets.h arch/arm64/kernel/vdso32/vdso.so
> > +endif
> >  endif
>
> The reason why it is currently done in two phases (a bit hacky as per comment)
> is because vdso-offsets.h is required to be generated before compiling kernel/.
> Please refer to the comment in arch/arm64/Makefile.

Yes, I know.

>
> Could you explain how your change satisfies the dependency?

vdso_prepare completes before Kbuild starts ordinary descending.
So *.so files and vdso-offsets.h exist
when Kbuild builds arch/arm64/kernel/.






> >
> >  define archhelp
> > diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
> > index 86364ab6f13f..42f6ad2c7eac 100644
> > --- a/arch/arm64/kernel/Makefile
> > +++ b/arch/arm64/kernel/Makefile
> > @@ -59,9 +59,10 @@ obj-$(CONFIG_CRASH_CORE)           += crash_core.o
> >  obj-$(CONFIG_ARM_SDE_INTERFACE)              += sdei.o
> >  obj-$(CONFIG_ARM64_PTR_AUTH)         += pointer_auth.o
> >  obj-$(CONFIG_ARM64_MTE)                      += mte.o
> > +obj-y                                        += vdso-wrap.o
> > +obj-$(CONFIG_COMPAT_VDSO)            += vdso32-wrap.o
> >
> > -obj-y                                        += vdso/ probes/
> > -obj-$(CONFIG_COMPAT_VDSO)            += vdso32/
> > +obj-y                                        += probes/
> >  head-y                                       := head.o
> >  extra-y                                      += $(head-y) vmlinux.lds
> >
> > diff --git a/arch/arm64/kernel/vdso/vdso.S b/arch/arm64/kernel/vdso-wrap.S
> > similarity index 100%
> > rename from arch/arm64/kernel/vdso/vdso.S
> > rename to arch/arm64/kernel/vdso-wrap.S
> > diff --git a/arch/arm64/kernel/vdso/Makefile b/arch/arm64/kernel/vdso/Makefile
> > index a8f8e409e2bf..85222f64f394 100644
> > --- a/arch/arm64/kernel/vdso/Makefile
> > +++ b/arch/arm64/kernel/vdso/Makefile
> > @@ -45,7 +45,6 @@ endif
> >  # Disable gcov profiling for VDSO code
> >  GCOV_PROFILE := n
> >
> > -obj-y += vdso.o
> >  targets += vdso.lds
> >  CPPFLAGS_vdso.lds += -P -C -U$(ARCH)
> >
> > diff --git a/arch/arm64/kernel/vdso32/vdso.S b/arch/arm64/kernel/vdso32-wrap.S
> > similarity index 100%
> > rename from arch/arm64/kernel/vdso32/vdso.S
> > rename to arch/arm64/kernel/vdso32-wrap.S
> > diff --git a/arch/arm64/kernel/vdso32/Makefile b/arch/arm64/kernel/vdso32/Makefile
> > index a1e0f91e6cea..789ad420f16b 100644
> > --- a/arch/arm64/kernel/vdso32/Makefile
> > +++ b/arch/arm64/kernel/vdso32/Makefile
> > @@ -155,7 +155,6 @@ c-obj-vdso-gettimeofday := $(addprefix $(obj)/, $(c-obj-vdso-gettimeofday))
> >  asm-obj-vdso := $(addprefix $(obj)/, $(asm-obj-vdso))
> >  obj-vdso := $(c-obj-vdso) $(c-obj-vdso-gettimeofday) $(asm-obj-vdso)
> >
> > -obj-y += vdso.o
> >  targets += vdso.lds
> >  CPPFLAGS_vdso.lds += -P -C -U$(ARCH)
> >
> >
>
> --
> Regards,
> Vincenzo



--
Best Regards
Masahiro Yamada
