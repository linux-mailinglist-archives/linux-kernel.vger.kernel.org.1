Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 877AA1ECC1F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jun 2020 11:02:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726450AbgFCJCF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Jun 2020 05:02:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:37078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726188AbgFCJCE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 05:02:04 -0400
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BBEA12077D;
        Wed,  3 Jun 2020 09:02:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591174923;
        bh=Gyi0dOix0HwUafX8BvF9pPLKW1LCn7KvhkPrNOPA+yE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=l3wEGeAbafS8OSLg/pnCBx8dyzHrfMazgR/qjdJWE+fHU4vIwlkpi9Hn/Ec0Aq6/x
         qs6Jo256ij+mvNs2KnsGz6yrdDXkFr/PbODzZs6cGAJpiX3V8KQxQCPBioC2VvMnIL
         /aji6dPlEG6m86LFnDshou0uG9ioSUWWT2geFSRg=
Received: by mail-ot1-f51.google.com with SMTP id 69so1305252otv.2;
        Wed, 03 Jun 2020 02:02:03 -0700 (PDT)
X-Gm-Message-State: AOAM531r/NvuFAV/ll6bU3LaovovtyKX49+8rbMa7RxlfMz51vPBduDt
        8+d5M2J2o8KIi/X6b5P5rdcf4imr5okwp44ZfYE=
X-Google-Smtp-Source: ABdhPJygtMM2aN1a+Rd+U59+lk2KSXh9ekpIARsHO86YPELXRsLOOV4+DF/MlzGOVTmNOhdxiuDfmE8FIxqUnoWscII=
X-Received: by 2002:a9d:2de4:: with SMTP id g91mr2320543otb.90.1591174923040;
 Wed, 03 Jun 2020 02:02:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200603053313.3863761-1-masahiroy@kernel.org>
 <CAMj1kXGk-2pyTZ3yNW14Kk4fvtsNOb7maAHVM2C=vVAjaaFRug@mail.gmail.com>
 <CAK7LNARg70FrTmnuoUiLM6KWxeJ+AeXqgB53GS6sY7z0J+qH6g@mail.gmail.com>
 <CAMj1kXFxmgQ=YzmLNnMO-2gibSGQ1=tXBd07ntqCYYU122zEUw@mail.gmail.com> <CAK7LNARLUeuiu3Y1cFqT7550MaF8fnBmMTZxKEG0Cy3vpxVkMQ@mail.gmail.com>
In-Reply-To: <CAK7LNARLUeuiu3Y1cFqT7550MaF8fnBmMTZxKEG0Cy3vpxVkMQ@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 3 Jun 2020 11:01:51 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFKuMoYW8Sj=DHeYBSkWyeu+QgP9=fgET83K5D=-DsJ7Q@mail.gmail.com>
Message-ID: <CAMj1kXFKuMoYW8Sj=DHeYBSkWyeu+QgP9=fgET83K5D=-DsJ7Q@mail.gmail.com>
Subject: Re: [PATCH] efi/libstub: refactor Makefile to not use lib-y syntax
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Atish Patra <atish.patra@wdc.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Jun 2020 at 10:59, Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> On Wed, Jun 3, 2020 at 5:45 PM Ard Biesheuvel <ardb@kernel.org> wrote:
> >
> > On Wed, 3 Jun 2020 at 10:36, Masahiro Yamada <masahiroy@kernel.org> wrote:
> > >
> > > On Wed, Jun 3, 2020 at 3:45 PM Ard Biesheuvel <ardb@kernel.org> wrote:
> > > >
> > > > On Wed, 3 Jun 2020 at 07:34, Masahiro Yamada <masahiroy@kernel.org> wrote:
> > > > >
> > > > > Documentation/kbuild/makefiles.rst says:
> > > > >
> > > > >   Use of lib-y is normally restricted to `lib/` and `arch/*/lib`.
> > > > >
> > > > > I want to disallow lib-y outside of them.
> > > > >
> > > >
> > > > Why?
> > >
> > >
> > > Because I plan to remove lib-y entirely at some point.
> > >
> > > lib-y is not so useful to shrink the image size because:
> > >
> > >   - An object in lib.a can be omitted only when no symbol
> > >     in that object is referenced.  This rarely happens.
> > >
> > >   -  lib-y objects are often exported by nature
> > >      because lib-y is a collection of utility functions.
> > >      Even if no in-tree user, we always need to keep them
> > >      because EXPORT_SYMBOL() is the interface to modules.
> > >
> > >
> > > When I worked on commit 7273ad2b08f8ac9563579d16a3cf528857b26f49,
> > > I made some research.
> > >
> > > The benefit of lib-y is just 362 byte for x86_64_defconfig.
> > > ( Before: 26578002, After: 26578364)
> > >
> > > My hope is lib-y will be replaced by dead-code elimination or
> > > ultimately by LTO.
> > >
> > > drivers/firmware/efi/libstub/Makefile
> > > is the only Makefile that breaks the rule:
> > > "Use of lib-y is normally restricted to `lib/` and `arch/*/lib`"
> > >
> > >
> > >
> > >
> > > >
> > > > > Add a custom rule to build lib.a, which is linked to the decompressor
> > > > > for ARCH=x86, ARCH=arm.
> > > > >
> > > > > For ARCH=arm64, use obj-y to link objects to vmlinux in the ordinary
> > > > > way.
> > > > >
> > > >
> > > > The code works perfectly fine as is, and I don't see what is
> > > > fundamentally wrong with using static libraries outside of lib/ and
> > > > arch/*/lib.
> > >
> > > The intended usage of lib-y is to hook lib.a
> > > to scripts/vmlinux.sh via KBUILD_VMLINUX_LIBS.
> > >
> > > This Makefile is just what you found to work.
> > >
> > >
> > > >
> > > > Also, I would like this code to still be incorporated as a static
> > > > library into arm64 as well, so that only pieces that are actually
> > > > needed are incorporated into the final image.
> > >
> > > No.
> > > It is not working like that because you set
> > > lib.a to core-y.
> > >
> > > All objects in core-y are always linked to vmlinux.
> > >
> >
> > The lib.a file is passed to the linker as a static library, so it will
> > only grab what it needs.
> >
> > For instance, if you build arm64 from mainline today, the
> > efi_relocate_kernel will not be in the final image, even though it is
> > built as part of libstub
>
>
> I built today's mainline kernel
> (d6f9469a03d832dcd17041ed67774ffb5f3e73b3).
>
>
> I see it in vmlinux.
>
>
> $ make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu-  defconfig
> $ make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu-  -j24
>     ...
> $ aarch64-linux-gnu-nm  -n  vmlinux | grep  efi_relocate_kernel
> ffff8000114afb90 t __efistub_efi_relocate_kernel
>

That is strange. I tested this before, and it worked.

Did anything change recently in the way the linker is invoked?
