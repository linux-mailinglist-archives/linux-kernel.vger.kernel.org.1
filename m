Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B820B28BC07
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 17:34:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390130AbgJLPef (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 11:34:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388881AbgJLPee (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 11:34:34 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7AFAC0613D0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 08:34:33 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id dn5so17403618edb.10
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 08:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=sd/r7feX+waUmCuH9ghOVlWmPSUIeMBgSYL2TkIIEhY=;
        b=fA4JUllwIYe+onJaV9Z3yKBQD08cm+mhv4xsSGU/1j48aDVWIxM/OfjMmUCkBa1uGp
         Dm5DVR4TPj2aONLL9+eSqg96H0KdETxze2bGFvpCkfg736iocrfg5y2eg5evavMIxwu1
         S5grP0aoYeHbhcbynPaojK+uDZ7TY6SmyQeLUusVqfFbQ67rg3vHFMhYSkyXUqpq3HyN
         xt7tA8TWeg96JKn79IZ5edXrM99cYbNlr8LL/3Lc3ZL2yB55sh3ilPC3dcYRsqnSGI5+
         lc+JlPz6oqOk1eYJtuCeFACRPv4bi85/H9QuGH17wva0h9Fzdd0bcPUg06m3tjJAKFnU
         /1xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=sd/r7feX+waUmCuH9ghOVlWmPSUIeMBgSYL2TkIIEhY=;
        b=IpH6GERUGOie8gB6WgQGGb9yOwDO4ruTjhFUH8ILM1V61uNf/vjls+PVz+bdWSdb+X
         3ABG7ca8Bhnydabjg/n0UVtzF1aRotPSVgE6SIegFNK9JHP5gVq5U/NqD82zh6AlTPJh
         bJ9lQRl7Cu7ULxqCcAVpeGaQRVjXKQDqGRJZ/RwIfCFT8b2wtC5bDrdFdLJSQ4qt0qFR
         3iLv3hbZ6l1EnEWRElUaoALamgL6b6HI4zxspBXpqTTGG9BKjBIZKYuJB6p7TkpEQjEj
         5KB1/KcXtMKnRpHWCI9Je3KH6+eCeR3N9G9tM0Ke9Ta+iscKKRRjYz0NY6y0s3aDGxY4
         TDVA==
X-Gm-Message-State: AOAM531aii4vy3Ua1RRTF+saqYAFl9w2qizK7lAEMV8s6TIp+zGRaGs2
        zNwlspa4ORdTRryFgtJzpqo=
X-Google-Smtp-Source: ABdhPJxXXtILev+oXZ63UAUWqW1MabuRxagtAp+kyyRj44l0ydsS6wloRKflHfnXBIZxhPaJrPFOnw==
X-Received: by 2002:aa7:c90a:: with SMTP id b10mr15058706edt.163.1602516872644;
        Mon, 12 Oct 2020 08:34:32 -0700 (PDT)
Received: from gmail.com (563B81C8.dsl.pool.telekom.hu. [86.59.129.200])
        by smtp.gmail.com with ESMTPSA id ok21sm4394119ejb.96.2020.10.12.08.34.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2020 08:34:32 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Mon, 12 Oct 2020 17:34:30 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Kees Cook <keescook@chromium.org>
Subject: [GIT PULL] core/build changes for v5.10: Add orphan section checking
 for x86, ARM and ARM64
Message-ID: <20201012153430.GA3491427@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest core/build git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-build-2020-10-12

   # HEAD: 6e0bf0e0e55000742a53c5f3b58f8669e0091a11 x86/boot/compressed: Warn on orphan section placement

Orphan link sections were a long-standing source of obscure bugs,
because the heuristics that various linkers & compilers use to handle them
(include these bits into the output image vs discarding them silently)
are both highly idiosyncratic and also version dependent.

Instead of this historically problematic mess, this tree by Kees Cook (et al)
adds build time asserts and build time warnings if there's any orphan section
in the kernel or if a section is not sized as expected.

And because we relied on so many silent assumptions in this area, fix a metric
ton of dependencies and some outright bugs related to this, before we can
finally enable the checks on the x86, ARM and ARM64 platforms.

 Thanks,

	Ingo

------------------>
Ard Biesheuvel (3):
      x86/boot/compressed: Move .got.plt entries out of the .got section
      x86/boot/compressed: Force hidden visibility for all symbol references
      x86/boot/compressed: Get rid of GOT fixup code

Arvind Sankar (4):
      x86/boot: Add .text.* to setup.ld
      x86/boot: Remove run-time relocations from .head.text code
      x86/boot: Remove run-time relocations from head_{32,64}.S
      x86/boot: Check that there are no run-time relocations

Kees Cook (28):
      vmlinux.lds.h: Create COMMON_DISCARDS
      vmlinux.lds.h: Add .gnu.version* to COMMON_DISCARDS
      vmlinux.lds.h: Avoid KASAN and KCSAN's unwanted sections
      vmlinux.lds.h: Split ELF_DETAILS from STABS_DEBUG
      vmlinux.lds.h: Add .symtab, .strtab, and .shstrtab to ELF_DETAILS
      efi/libstub: Disable -mbranch-protection
      arm64/mm: Remove needless section quotes
      arm64/kernel: Remove needless Call Frame Information annotations
      arm64/build: Remove .eh_frame* sections due to unwind tables
      arm64/build: Use common DISCARDS in linker script
      arm64/build: Add missing DWARF sections
      arm64/build: Assert for unwanted sections
      arm/build: Refactor linker script headers
      arm/build: Explicitly keep .ARM.attributes sections
      arm/build: Add missing sections
      arm/build: Assert for unwanted sections
      arm/boot: Handle all sections explicitly
      x86/asm: Avoid generating unused kprobe sections
      x86/build: Enforce an empty .got.plt section
      x86/build: Add asserts for unwanted sections
      x86/boot/compressed: Reorganize zero-size section asserts
      x86/boot/compressed: Remove, discard, or assert for unwanted sections
      x86/boot/compressed: Add missing debugging sections to output
      arm64/build: Warn on orphan section placement
      arm/build: Warn on orphan section placement
      arm/boot: Warn on orphan section placement
      x86/build: Warn on orphan section placement
      x86/boot/compressed: Warn on orphan section placement

Nick Desaulniers (1):
      vmlinux.lds.h: Add PGO and AutoFDO input sections


 arch/alpha/kernel/vmlinux.lds.S                |   1 +
 arch/arc/kernel/vmlinux.lds.S                  |   1 +
 arch/arm/Makefile                              |   4 +
 arch/arm/boot/compressed/Makefile              |   2 +
 arch/arm/boot/compressed/vmlinux.lds.S         |  20 +--
 arch/arm/{kernel => include/asm}/vmlinux.lds.h |  30 ++++-
 arch/arm/kernel/vmlinux-xip.lds.S              |   8 +-
 arch/arm/kernel/vmlinux.lds.S                  |   8 +-
 arch/arm64/Makefile                            |   9 +-
 arch/arm64/kernel/smccc-call.S                 |   2 -
 arch/arm64/kernel/vmlinux.lds.S                |  28 ++++-
 arch/arm64/mm/mmu.c                            |   2 +-
 arch/csky/kernel/vmlinux.lds.S                 |   1 +
 arch/hexagon/kernel/vmlinux.lds.S              |   1 +
 arch/ia64/kernel/vmlinux.lds.S                 |   1 +
 arch/mips/kernel/vmlinux.lds.S                 |   1 +
 arch/nds32/kernel/vmlinux.lds.S                |   1 +
 arch/nios2/kernel/vmlinux.lds.S                |   1 +
 arch/openrisc/kernel/vmlinux.lds.S             |   1 +
 arch/parisc/boot/compressed/vmlinux.lds.S      |   1 +
 arch/parisc/kernel/vmlinux.lds.S               |   1 +
 arch/powerpc/kernel/vmlinux.lds.S              |   2 +-
 arch/riscv/kernel/vmlinux.lds.S                |   1 +
 arch/s390/kernel/vmlinux.lds.S                 |   1 +
 arch/sh/kernel/vmlinux.lds.S                   |   1 +
 arch/sparc/kernel/vmlinux.lds.S                |   1 +
 arch/um/kernel/dyn.lds.S                       |   2 +-
 arch/um/kernel/uml.lds.S                       |   2 +-
 arch/x86/Makefile                              |   4 +
 arch/x86/boot/compressed/Makefile              |  41 ++----
 arch/x86/boot/compressed/head_32.S             |  99 +++++----------
 arch/x86/boot/compressed/head_64.S             | 165 ++++++++++---------------
 arch/x86/boot/compressed/mkpiggy.c             |   6 +
 arch/x86/boot/compressed/vmlinux.lds.S         |  50 +++++++-
 arch/x86/boot/setup.ld                         |   2 +-
 arch/x86/include/asm/asm.h                     |   6 +-
 arch/x86/kernel/vmlinux.lds.S                  |  39 +++++-
 drivers/firmware/efi/libstub/Makefile          |  11 +-
 drivers/firmware/efi/libstub/hidden.h          |   6 -
 include/asm-generic/vmlinux.lds.h              |  49 ++++++--
 include/linux/hidden.h                         |  19 +++
 41 files changed, 378 insertions(+), 253 deletions(-)
 rename arch/arm/{kernel => include/asm}/vmlinux.lds.h (84%)
 delete mode 100644 drivers/firmware/efi/libstub/hidden.h
 create mode 100644 include/linux/hidden.h
