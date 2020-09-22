Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4945A2747C7
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 19:52:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726667AbgIVRwN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 13:52:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726573AbgIVRwM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 13:52:12 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7818AC061755
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 10:52:12 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id a9so1855437pjg.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 10:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=jTXWpy7gfL9tTR5TRIOW48TXOYuyfWFDt2cXXxVYgbY=;
        b=fm+0QykdpIQZ7Hdgez9GBzdIlCHNIqTR++Nag4UnHlJ+PLsYzLQcS1ZpdPiGVvhgnm
         VF81+OLt+X6wXFPazlY0kurYe2ojb3u9GE80YNQ3CbRIxz6wC5VXwVfF4YJmJpLj2kU7
         Dpgx3q9+HpTyFxBccYlEhF8edz7zz+pp0Z6dG5J3GjeXFrHHIYPRsn1+arGP9k0RmpFl
         nSmIOqxREvaUrng/5/oSfcHW/s99FxO5Wwg9sdjoAQTwmHFIWQoTMYZynZplXOyZFEjs
         UqMi0Ekzyp0NgdmyWDHUAkTHIsQ5/NIL7yDTRS0PZmWu32lGAlswycO8FhlTyuzPpBKR
         RCgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jTXWpy7gfL9tTR5TRIOW48TXOYuyfWFDt2cXXxVYgbY=;
        b=fs9+vgHexzc5wAnpJB1IiDofuteAJeZLkkEC8w5kf2pjRUxF19C3a0YTmQXpAO63N0
         iiL+hbt+1IvDPNfU0GEOr0D3/Ua0R2HhLRZxVc2uasad2zj+qLvMMXj7EZGjnebaVwfc
         P5EYja/CsakHmv+RnTjV9KA7251n3COiSGaz2LYW+BwJLchbipSVT1lRzQC48tsLRIkW
         Sio2Xqf4nyWjH/2HnW12dkRhD3X9sndEZbVyaAy+zASx2P+nfwp+Y+ROPZ+r8hquXQht
         yNjS0iWTdUmFLGkIiWuXz/K4bo6zQSu08aRzNbRBgwE/bYjesOE4W/m92l2S/ETPM7W4
         mtew==
X-Gm-Message-State: AOAM533/5pnfE7lpQUyHX/qUkBZ9FoYRv7CuJYtJSqQHHeLNlwsXzq16
        9OkNvXFQwv/hfFbFa9/MG6U16HHe13V8TZg/6ngcDA==
X-Google-Smtp-Source: ABdhPJybp31soq+4+b4wQn49XDxS0ZwCmxt15L4k3fSdTzGZddBT6d5jD8rItCS4eJYkxeIFPAy0f6mwhxYvFHADcHU=
X-Received: by 2002:a17:90b:f18:: with SMTP id br24mr4768321pjb.32.1600797131731;
 Tue, 22 Sep 2020 10:52:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200624203200.78870-1-samitolvanen@google.com>
 <20200903203053.3411268-1-samitolvanen@google.com> <CAKwvOdkbkvXdfXLzTNOj8m8_YWjL6=bSn4-AbRyd-5oYGJVNSw@mail.gmail.com>
 <MW2PR2101MB1099A1D58A9C062006E92569FF3B0@MW2PR2101MB1099.namprd21.prod.outlook.com>
In-Reply-To: <MW2PR2101MB1099A1D58A9C062006E92569FF3B0@MW2PR2101MB1099.namprd21.prod.outlook.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 22 Sep 2020 10:52:00 -0700
Message-ID: <CAKwvOd=F0_0RyjCzZKarbVXTsG+NfVdANF9mENHe7=8+LNc+Rw@mail.gmail.com>
Subject: Re: [EXTERNAL] Re: [PATCH v2 00/28] Add support for Clang LTO
To:     Ian Bearman <Ian.Bearman@microsoft.com>, rhadley@microsoft.com
Cc:     clang-built-linux <clang-built-linux@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Sasha Levin <sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 22, 2020 at 9:27 AM Ian Bearman <Ian.Bearman@microsoft.com> wro=
te:
>
> Hi, Nick. Thanks for reaching out again. I'm excited to see other groups =
taking an interest in LTO and PGO for Linux. CFI for the kernel sounds like=
 a huge deal, nice!

Yes, CFI is quite nice.  There are some hardware extensions in the
works, but CFI has some additional coverage implemented in software.
That said, all new compiler technologies have bugs, and expose issues
in various code bases.

>
> I'd like to introduce you to @Russell Hadley. Russell wears a couple of h=
ats right now, he's both the group manager for the MSVC code generation tea=
m as well as the (interim) team for the Linux tools team that i built and l=
ead last year. He has inherited the various efforts my team was working on =
and is the right contact going forward to collaborate on Linux compiler and=
 tools efforts.

Hey Russell, Ian,

Russel, Ian mentioned shipping LTO+PGO for a "downstream customer."  I
assume they'd like to rebase at some point, so getting tweaks to the
build system upstream will help them lower their technical debt.
We're in the process of upstreaming LTO patches for Clang and would
love help collaborating on getting it working for GCC, too.

If you'd like to speak more about this virtually, we have our public
meeting every other week coming up tomorrow.  It's noon pacific time,
see https://clangbuiltlinux.github.io/ for calendar invite and Google
meet link.  Please stop by, even if it's just to say hello!

>
> ian Bearman
> Principal Software Engineering Manager
> Microsoft Visual C++ Team: ML Optimization & Code Generation
> #BlackLivesMatter
> /* Making your code faster, smaller, smarter! */
>
> -----Original Message-----
> From: Nick Desaulniers <ndesaulniers@google.com>
> Sent: Thursday, September 10, 2020 10:46 AM
> To: Ian Bearman <Ian.Bearman@microsoft.com>
> Cc: clang-built-linux <clang-built-linux@googlegroups.com>; LKML <linux-k=
ernel@vger.kernel.org>; Sami Tolvanen <samitolvanen@google.com>
> Subject: [EXTERNAL] Re: [PATCH v2 00/28] Add support for Clang LTO
>
> Hey Ian,
> It was nice to meet you at Linux plumbers.  You might want to take a look=
 at this series.  It implements builds of the Linux kernel with LTO.  It wo=
uld be good to get eyes on it and help review it from folks working on this=
 from the GCC angle.  The series has some configs that split where Clang sp=
ecific changes need to be made; it might be of interest to think about what=
 would the similar changes be needed for GCC.  Also, congrats on your LWN a=
rticle!
> https://nam06.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flwn.n=
et%2FArticles%2F830300%2F&amp;data=3D02%7C01%7Cian.bearman%40microsoft.com%=
7C9adc842104f640d3ebb308d855b17221%7C72f988bf86f141af91ab2d7cd011db47%7C1%7=
C0%7C637353568334933757&amp;sdata=3DuM6%2BGj5z0gNAuIravVWOeVeIVsRI5YaPIJqB8=
qYsZ94%3D&amp;reserved=3D0
>
> On Thu, Sep 3, 2020 at 1:30 PM Sami Tolvanen <samitolvanen@google.com> wr=
ote:
> >
> > This patch series adds support for building x86_64 and arm64 kernels
> > with Clang's Link Time Optimization (LTO).
> >
> > In addition to performance, the primary motivation for LTO is to allow
> > Clang's Control-Flow Integrity (CFI) to be used in the kernel. Google
> > has shipped millions of Pixel devices running three major kernel
> > versions with LTO+CFI since 2018.
> >
> > Most of the patches are build system changes for handling LLVM
> > bitcode, which Clang produces with LTO instead of ELF object files,
> > postponing ELF processing until a later stage, and ensuring initcall
> > ordering.
> >
> > Note that patches 1-4 are not directly related to LTO, but are needed
> > to compile LTO kernels with ToT Clang, so I'm including them in the
> > series for your convenience:
> >
> >  - Patches 1-3 are required for building the kernel with ToT Clang,
> >    and IAS, and patch 4 is needed to build allmodconfig with LTO.
> >
> >  - Patches 3-4 are already in linux-next, but not yet in 5.9-rc.
> >
> > ---
> > Changes in v2:
> >
> >   - Fixed -Wmissing-prototypes warnings with W=3D1.
> >
> >   - Dropped cc-option from -fsplit-lto-unit and added .thinlto-cache
> >     scrubbing to make distclean.
> >
> >   - Added a comment about Clang >=3D11 being required.
> >
> >   - Added a patch to disable LTO for the arm64 KVM nVHE code.
> >
> >   - Disabled objtool's noinstr validation with LTO unless enabled.
> >
> >   - Included Peter's proposed objtool mcount patch in the series
> >     and replaced recordmcount with the objtool pass to avoid
> >     whitelisting relocations that are not calls.
> >
> >   - Updated several commit messages with better explanations.
> >
> >
> > Arvind Sankar (2):
> >   x86/boot/compressed: Disable relocation relaxation
> >   x86/asm: Replace __force_order with memory clobber
> >
> > Luca Stefani (1):
> >   RAS/CEC: Fix cec_init() prototype
> >
> > Nick Desaulniers (1):
> >   lib/string.c: implement stpcpy
> >
> > Peter Zijlstra (1):
> >   objtool: Add a pass for generating __mcount_loc
> >
> > Sami Tolvanen (23):
> >   objtool: Don't autodetect vmlinux.o
> >   kbuild: add support for objtool mcount
> >   x86, build: use objtool mcount
> >   kbuild: add support for Clang LTO
> >   kbuild: lto: fix module versioning
> >   kbuild: lto: postpone objtool
> >   kbuild: lto: limit inlining
> >   kbuild: lto: merge module sections
> >   kbuild: lto: remove duplicate dependencies from .mod files
> >   init: lto: ensure initcall ordering
> >   init: lto: fix PREL32 relocations
> >   PCI: Fix PREL32 relocations for LTO
> >   modpost: lto: strip .lto from module names
> >   scripts/mod: disable LTO for empty.c
> >   efi/libstub: disable LTO
> >   drivers/misc/lkdtm: disable LTO for rodata.o
> >   arm64: export CC_USING_PATCHABLE_FUNCTION_ENTRY
> >   arm64: vdso: disable LTO
> >   KVM: arm64: disable LTO for the nVHE directory
> >   arm64: allow LTO_CLANG and THINLTO to be selected
> >   x86, vdso: disable LTO only for vDSO
> >   x86, relocs: Ignore L4_PAGE_OFFSET relocations
> >   x86, build: allow LTO_CLANG and THINLTO to be selected
> >
> >  .gitignore                            |   1 +
> >  Makefile                              |  65 ++++++-
> >  arch/Kconfig                          |  67 +++++++
> >  arch/arm64/Kconfig                    |   2 +
> >  arch/arm64/Makefile                   |   1 +
> >  arch/arm64/kernel/vdso/Makefile       |   4 +-
> >  arch/arm64/kvm/hyp/nvhe/Makefile      |   4 +-
> >  arch/x86/Kconfig                      |   3 +
> >  arch/x86/Makefile                     |   5 +
> >  arch/x86/boot/compressed/Makefile     |   2 +
> >  arch/x86/boot/compressed/pgtable_64.c |   9 -
> >  arch/x86/entry/vdso/Makefile          |   5 +-
> >  arch/x86/include/asm/special_insns.h  |  28 +--
> >  arch/x86/kernel/cpu/common.c          |   4 +-
> >  arch/x86/tools/relocs.c               |   1 +
> >  drivers/firmware/efi/libstub/Makefile |   2 +
> >  drivers/misc/lkdtm/Makefile           |   1 +
> >  drivers/ras/cec.c                     |   9 +-
> >  include/asm-generic/vmlinux.lds.h     |  11 +-
> >  include/linux/init.h                  |  79 +++++++-
> >  include/linux/pci.h                   |  19 +-
> >  kernel/trace/Kconfig                  |   5 +
> >  lib/string.c                          |  24 +++
> >  scripts/Makefile.build                |  55 +++++-
> >  scripts/Makefile.lib                  |   6 +-
> >  scripts/Makefile.modfinal             |  31 ++-
> >  scripts/Makefile.modpost              |  26 ++-
> >  scripts/generate_initcall_order.pl    | 270 ++++++++++++++++++++++++++
> >  scripts/link-vmlinux.sh               |  94 ++++++++-
> >  scripts/mod/Makefile                  |   1 +
> >  scripts/mod/modpost.c                 |  16 +-
> >  scripts/mod/modpost.h                 |   9 +
> >  scripts/mod/sumversion.c              |   6 +-
> >  scripts/module-lto.lds                |  26 +++
> >  tools/objtool/builtin-check.c         |  13 +-
> >  tools/objtool/builtin.h               |   2 +-
> >  tools/objtool/check.c                 |  83 ++++++++
> >  tools/objtool/check.h                 |   1 +
> >  tools/objtool/objtool.h               |   1 +
> >  39 files changed, 883 insertions(+), 108 deletions(-)  create mode
> > 100755 scripts/generate_initcall_order.pl
> >  create mode 100644 scripts/module-lto.lds
> >
> >
> > base-commit: e28f0104343d0c132fa37f479870c9e43355fee4
> > --
> > 2.28.0.402.g5ffc5be6b7-goog
> >
>
>
> --
> Thanks,
> ~Nick Desaulniers



--=20
Thanks,
~Nick Desaulniers
