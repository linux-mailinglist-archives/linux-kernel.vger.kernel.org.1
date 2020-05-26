Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58F4A1D4BD1
	for <lists+linux-kernel@lfdr.de>; Fri, 15 May 2020 12:59:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726097AbgEOK65 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 May 2020 06:58:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725919AbgEOK65 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 06:58:57 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCA22C061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 03:58:55 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id m12so1881489wmc.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 03:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nz5T7Ti8J6fFByDN7jOu8omjWEMvQxD/kfVl2PcIzCU=;
        b=T+jG2gdoHAiFMGlPBUlnH03zcMMorDiITXPXucXkn/GIGjnkQO+jeBVCZ2a5wadM5r
         moE4Sx4biP9FnWYkKowwtGpFns0jtPDK9cYB0VrB6HSWaAHHSifPvmDwq6pKLyoRtvag
         MaKowrZyO66h/EL1u/mBdDVvZDI+jlSkCYyd7p+rN7LhxzUUqiBzFik/3rAwwMeCUDHb
         YCsAzblgWg8QrIGJzlpH1dNC7EklX67Qs4MW8egbDagsgAmbA+bYX2erCDO5+pRXPw3P
         pXuGoQj5cFaYfmwHWU6Klmm/PsF4wGtEeRSQ9U6AVPZBz9NZ9koDinlhv96IKplT7LhI
         Omrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nz5T7Ti8J6fFByDN7jOu8omjWEMvQxD/kfVl2PcIzCU=;
        b=RcdGOXQfk9F04nSatU2LRBP/mKcysYXS1pkru0dmkb2vbnV7fce/mpr1NytdZb6Woj
         wXWOdMj/j9Cqxp3t7Rr6YXiGLsKVjMynyjBMDF1KxZ82L4Ekh5UB+tP5JqzRn/Jew/UY
         f2BSwN9K9RY1AHPJJKafsRujLg5/wwv4MTP3O6vJdzLy5yqI5jagKc4qqRFyWclBwH/D
         5b6lR4/W0cZmmwGPd76Jhiq3srCdFFTL/j+CJHnaHTL+bP74bzOXvi3pD+eUZ5H4kJk8
         LghFtAr7rxDUL7RzaIlX+G4EgodPAYUVPus1yj+xRbUZVHKt2ymZYqS19pRO47qiMDhj
         Z35Q==
X-Gm-Message-State: AOAM5305yvlic0EnZmy1VCXzLrdHSh1VqSRsx05qyNATy8onZP+QiwgJ
        pQvW6AYnjAtN60TxPhjYRTfpCw==
X-Google-Smtp-Source: ABdhPJxWMYThFcLucYF0IjewRo2gtUyqiGrfOuZ3Lj0ioN+1L/iHTKXER/IB0GkMggNvnKrZEH6YSw==
X-Received: by 2002:a05:600c:2dd0:: with SMTP id e16mr3626689wmh.121.1589540333968;
        Fri, 15 May 2020 03:58:53 -0700 (PDT)
Received: from localhost ([2a01:4b00:8523:2d03:d11b:f847:8002:7411])
        by smtp.gmail.com with ESMTPSA id y3sm3005132wrm.64.2020.05.15.03.58.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 May 2020 03:58:52 -0700 (PDT)
From:   David Brazdil <dbrazdil@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Marc Zyngier <maz@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, David Brazdil <dbrazdil@google.com>
Subject: [PATCH v2 00/14] Split off nVHE hyp code
Date:   Fri, 15 May 2020 11:58:27 +0100
Message-Id: <20200515105841.73532-1-dbrazdil@google.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Refactor files in arch/arm64/kvm/hyp to compile all code which runs in EL2
under nVHE into separate object files from the rest of KVM. This is done in
preparation for being able to unmap hyp code from EL1 and kernel code/data
from EL2 but has other benefits too, notably:
 * safe use of KASAN/UBSAN/GCOV instrumentation on VHE code,
 * cleaner HVC API,
 * no need for __hyp_text annotations.

nVHE-specific code is moved to hyp/nvhe and compiled with custom build rules
similar to those used by EFI stub. Shared source files are compiled under both
VHE and nVHE build rules. Where a source file contained both VHE and nVHE code,
it is split into a shared header file and two C source files. This is done one
file per commit to make review easier.

All nVHE symbols are prefixed with "__kvm_nvhe_" to avoid collisions with VHE
variants (also inspired by EFI stub). Since this prefixes unresolved symbols
too, image-vars.h contains a list of kernel symbol aliases where nVHE code
still refers to kernel proper. The list grows fairly large as the patch series
progresses and code is moved around, but at the end contains 17 symbols. These
remaining dependencies on kernel proper will be further reduced in the future.

No functional changes are intended but code was simplified whenever the
refactoring made it possible.

Tested by running kvm-unit-tests on QEMU 5.0 with VHE/nVHE and GIC v2/v3.

Dual compilation of code shared by VHE/nVHE increase the size of the kernel.
Bloat-o-meter vmlinux diff shows an increase of 21 KB on the ELF symbol level.
Size of Image.gz is up by 10 KB; size of Image is unchanged, presumably due
to ELF section alignment.

This is based off Fuad Tabba's patch series "KVM: arm64: Tidy up arch Kconfig
and Makefiles". Available in branch 'topic/el2-obj-v2' of git repo:
  https://android-kvm.googlesource.com/linux

Changes v1 -> v2:
 * change nVHE symbol prefix from __hyp_text_ to __kvm_nvhe_
 * rename __HYPERVISOR__ macro to __KVM_NVHE_HYPERVISOR__
 * use hcall jump table instead of array of function pointers
 * drop patch to unify HVC callers
 * move __smccc_workaround_1_smc to own file
 * header guards for hyp/*.h
 * improve helpers for handling VHE/nVHE hyp syms in kernel proper
 * improve commit messages, cover letter

-David

David Brazdil (14):
  arm64: kvm: Fix symbol dependency in __hyp_call_panic_nvhe
  arm64: kvm: Move __smccc_workaround_1_smc to .rodata
  arm64: kvm: Formalize hypcall ABI
  arm64: kvm: Add build rules for separate nVHE object files
  arm64: kvm: Build hyp-entry.S separately for VHE/nVHE
  arm64: kvm: Split hyp/tlb.c to VHE/nVHE
  arm64: kvm: Split hyp/switch.c to VHE/nVHE
  arm64: kvm: Split hyp/debug-sr.c to VHE/nVHE
  arm64: kvm: Split hyp/sysreg-sr.c to VHE/nVHE
  arm64: kvm: Split hyp/timer-sr.c to VHE/nVHE
  arm64: kvm: Compile remaining hyp/ files for both VHE/nVHE
  arm64: kvm: Add comments around __kvm_nvhe_ symbol aliases
  arm64: kvm: Remove __hyp_text macro, use build rules instead
  arm64: kvm: Lift instrumentation restrictions on VHE

 arch/arm64/include/asm/kvm_asm.h             |  29 +-
 arch/arm64/include/asm/kvm_emulate.h         |   2 +-
 arch/arm64/include/asm/kvm_host.h            |  12 +-
 arch/arm64/include/asm/kvm_host_hypercalls.h |  59 ++
 arch/arm64/include/asm/kvm_hyp.h             |  15 +-
 arch/arm64/include/asm/kvm_mmu.h             |  16 +-
 arch/arm64/include/asm/mmu.h                 |   7 -
 arch/arm64/kernel/cpu_errata.c               |   4 +-
 arch/arm64/kernel/image-vars.h               |  43 ++
 arch/arm64/kvm/arm.c                         |   6 +-
 arch/arm64/kvm/hyp.S                         |  18 +-
 arch/arm64/kvm/hyp/Makefile                  |  13 +-
 arch/arm64/kvm/hyp/aarch32.c                 |   6 +-
 arch/arm64/kvm/hyp/debug-sr.c                | 214 +-----
 arch/arm64/kvm/hyp/debug-sr.h                | 170 +++++
 arch/arm64/kvm/hyp/entry.S                   |   1 -
 arch/arm64/kvm/hyp/fpsimd.S                  |   1 -
 arch/arm64/kvm/hyp/hyp-entry.S               |  77 +--
 arch/arm64/kvm/hyp/nvhe/Makefile             |  42 ++
 arch/arm64/kvm/hyp/nvhe/debug-sr.c           |  77 +++
 arch/arm64/kvm/hyp/nvhe/switch.c             | 271 ++++++++
 arch/arm64/kvm/hyp/nvhe/sysreg-sr.c          |  56 ++
 arch/arm64/kvm/hyp/nvhe/timer-sr.c           |  43 ++
 arch/arm64/kvm/hyp/nvhe/tlb.c                |  67 ++
 arch/arm64/kvm/hyp/smccc_wa.S                |  30 +
 arch/arm64/kvm/hyp/switch.c                  | 688 +------------------
 arch/arm64/kvm/hyp/switch.h                  | 443 ++++++++++++
 arch/arm64/kvm/hyp/sysreg-sr.c               | 233 +------
 arch/arm64/kvm/hyp/sysreg-sr.h               | 216 ++++++
 arch/arm64/kvm/hyp/timer-sr.c                |  38 +-
 arch/arm64/kvm/hyp/tlb.c                     | 168 +----
 arch/arm64/kvm/hyp/tlb.h                     | 131 ++++
 arch/arm64/kvm/hyp/vgic-v2-cpuif-proxy.c     |   4 +-
 arch/arm64/kvm/hyp/vgic-v3-sr.c              | 130 ++--
 arch/arm64/kvm/va_layout.c                   |   2 +-
 scripts/kallsyms.c                           |   1 +
 36 files changed, 1867 insertions(+), 1466 deletions(-)
 create mode 100644 arch/arm64/include/asm/kvm_host_hypercalls.h
 create mode 100644 arch/arm64/kvm/hyp/debug-sr.h
 create mode 100644 arch/arm64/kvm/hyp/nvhe/Makefile
 create mode 100644 arch/arm64/kvm/hyp/nvhe/debug-sr.c
 create mode 100644 arch/arm64/kvm/hyp/nvhe/switch.c
 create mode 100644 arch/arm64/kvm/hyp/nvhe/sysreg-sr.c
 create mode 100644 arch/arm64/kvm/hyp/nvhe/timer-sr.c
 create mode 100644 arch/arm64/kvm/hyp/nvhe/tlb.c
 create mode 100644 arch/arm64/kvm/hyp/smccc_wa.S
 create mode 100644 arch/arm64/kvm/hyp/switch.h
 create mode 100644 arch/arm64/kvm/hyp/sysreg-sr.h
 create mode 100644 arch/arm64/kvm/hyp/tlb.h

-- 
2.26.2

