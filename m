Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02E26207D01
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jun 2020 22:33:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390632AbgFXUcv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Jun 2020 16:32:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388133AbgFXUcs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 16:32:48 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05762C0613ED
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 13:32:47 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 186so3453635yby.19
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 13:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=geZqQu8Pc2IZyEmyfjSbirVoyCHoNCVPX8WSrD5/a0I=;
        b=Uawx1HymTuOmFuIsE6m0edc2JOJkrIL4ohCvAqVmbJ8lL51+F8GFU8Edzr7cqZcv2w
         HodyjPnW3CEUXq8PkZVULO6ZyoUtxp9+p+vdtGUCMz8qqae3fj+ztQ8oZGg5KLQxzxtv
         WsCNEibFNfuA+bNlcIR8b4sSEDOv2SkH85c5Dy7chvY+wP/aaRR1NsYEhp1bKM54GsoI
         2QcLu0Jhfop40Tu+FeyQ89Qe5QVYishLUcPnbhRan/pilxFWfHclHWVyGJPxpvvrwTh0
         JNHLSYYTI2a6tpFbw45+Zc3Ez5EH+jMImL6HifoQ7sZW+Y10m8LKlencaSHV2sNpKm9n
         vXag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=geZqQu8Pc2IZyEmyfjSbirVoyCHoNCVPX8WSrD5/a0I=;
        b=Q47Zmb4LkoaLFBjNBMnaC276nnHrKGHhG9+AhKT2DfTwxEXm/7w59EdhDWSwwQoACH
         29hFd1nSoq5v3JjQqEujZdh1K/9n/vR6L43bS0321ZaKv/mdjzkbMAlVB8Z9d0HV7Lrs
         5G7YVoyDi9V4K5onzWI4KViY6y02ggfH/wIyrEb66SvPsVeNAMrLwOTmdbFAH2xkIKHH
         Vl9QV/qNHO7C6FQ47npLIV5cqsmmKrmKh0Fmz095Jd3zeirXw6KY2/u4Y2N2o0bkUQFo
         94OfyytxKzanJp/uCFZ3XSsdb6bda98JX68imDfJzJ+8G71D6CTqTo5oBnKX3gHe9BOT
         wYIg==
X-Gm-Message-State: AOAM532nqB9CywAIiGrmDZscU/n4YVxkmiHZ4iCMsDe5EGhJqLYCOPTZ
        EHtJeXDam+uwpqwfEixl7WgfREsUxbZCghOOr3U=
X-Google-Smtp-Source: ABdhPJxWR9GEuM9Xe3hags9/hH99MHEAXvV4G6BQoWnGF1JJpG+hf2xaFzi6meCZqAzm99eCovUBw+L4m3sg7uT3BU4=
X-Received: by 2002:a25:3342:: with SMTP id z63mr44129932ybz.200.1593030767109;
 Wed, 24 Jun 2020 13:32:47 -0700 (PDT)
Date:   Wed, 24 Jun 2020 13:31:38 -0700
Message-Id: <20200624203200.78870-1-samitolvanen@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
Subject: [PATCH 00/22] add support for Clang LTO
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com,
        kernel-hardening@lists.openwall.com, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        x86@kernel.org, Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds support for building x86_64 and arm64 kernels
with Clang's Link Time Optimization (LTO).

In addition to performance, the primary motivation for LTO is to allow
Clang's Control-Flow Integrity (CFI) to be used in the kernel. Google's
Pixel devices have shipped with LTO+CFI kernels since 2018.

Most of the patches are build system changes for handling LLVM bitcode,
which Clang produces with LTO instead of ELF object files, postponing
ELF processing until a later stage, and ensuring initcall ordering.

Note that first objtool patch in the series is already in linux-next,
but as it's needed with LTO, I'm including it also here to make testing
easier.

Sami Tolvanen (22):
  objtool: use sh_info to find the base for .rela sections
  kbuild: add support for Clang LTO
  kbuild: lto: fix module versioning
  kbuild: lto: fix recordmcount
  kbuild: lto: postpone objtool
  kbuild: lto: limit inlining
  kbuild: lto: merge module sections
  kbuild: lto: remove duplicate dependencies from .mod files
  init: lto: ensure initcall ordering
  init: lto: fix PREL32 relocations
  pci: lto: fix PREL32 relocations
  modpost: lto: strip .lto from module names
  scripts/mod: disable LTO for empty.c
  efi/libstub: disable LTO
  drivers/misc/lkdtm: disable LTO for rodata.o
  arm64: export CC_USING_PATCHABLE_FUNCTION_ENTRY
  arm64: vdso: disable LTO
  arm64: allow LTO_CLANG and THINLTO to be selected
  x86, vdso: disable LTO only for vDSO
  x86, ftrace: disable recordmcount for ftrace_make_nop
  x86, relocs: Ignore L4_PAGE_OFFSET relocations
  x86, build: allow LTO_CLANG and THINLTO to be selected

 .gitignore                            |   1 +
 Makefile                              |  27 ++-
 arch/Kconfig                          |  65 +++++++
 arch/arm64/Kconfig                    |   2 +
 arch/arm64/Makefile                   |   1 +
 arch/arm64/kernel/vdso/Makefile       |   4 +-
 arch/x86/Kconfig                      |   2 +
 arch/x86/Makefile                     |   5 +
 arch/x86/entry/vdso/Makefile          |   5 +-
 arch/x86/kernel/ftrace.c              |   1 +
 arch/x86/tools/relocs.c               |   1 +
 drivers/firmware/efi/libstub/Makefile |   2 +
 drivers/misc/lkdtm/Makefile           |   1 +
 include/asm-generic/vmlinux.lds.h     |  12 +-
 include/linux/compiler-clang.h        |   4 +
 include/linux/compiler.h              |   2 +-
 include/linux/compiler_types.h        |   4 +
 include/linux/init.h                  |  78 +++++++-
 include/linux/pci.h                   |  15 +-
 kernel/trace/ftrace.c                 |   1 +
 lib/Kconfig.debug                     |   2 +-
 scripts/Makefile.build                |  55 +++++-
 scripts/Makefile.lib                  |   6 +-
 scripts/Makefile.modfinal             |  40 +++-
 scripts/Makefile.modpost              |  26 ++-
 scripts/generate_initcall_order.pl    | 270 ++++++++++++++++++++++++++
 scripts/link-vmlinux.sh               | 100 +++++++++-
 scripts/mod/Makefile                  |   1 +
 scripts/mod/modpost.c                 |  16 +-
 scripts/mod/modpost.h                 |   9 +
 scripts/mod/sumversion.c              |   6 +-
 scripts/module-lto.lds                |  26 +++
 scripts/recordmcount.c                |   3 +-
 tools/objtool/elf.c                   |   2 +-
 34 files changed, 737 insertions(+), 58 deletions(-)
 create mode 100755 scripts/generate_initcall_order.pl
 create mode 100644 scripts/module-lto.lds


base-commit: 26e122e97a3d0390ebec389347f64f3730fdf48f
-- 
2.27.0.212.ge8ba1cc988-goog

