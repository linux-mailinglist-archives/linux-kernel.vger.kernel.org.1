Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08437274A4D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 22:49:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726629AbgIVUtQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 16:49:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726550AbgIVUtP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 16:49:15 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69FBEC061755
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 13:49:15 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id q9so4770118wmj.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 13:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ih3O4/69tbNzYNtuvvMQexZCyfb110eF4LQYqz6A1a8=;
        b=K83wTisrAwlvmXTXomdfwfYdR+KKAheFXSQTxKIbaWO6fOX4sYgYKapzMoywaaExyq
         dC8tlcfiLPZLpkLyIblwjbkrnEIc1wFb0FkMdzWZfiIFeeAOp54t+KpGAf82sTmDmlsd
         QjuOwQ2R6W5pm/EN+1c/yu8dVdvZjYV+GCgQYVqyBcikz21Fub3hwgYhYSOvggWN6EMb
         1Wmm4/oFqPQyyxn+fLfSBJ0TnzGXN5UfNimIYp8kAzjMm09iBdavlR0occ4iMOZJzbGY
         4UerOmaCAvVJIusPngbCOfuUyLIj4Q/Nvxos9mgojwGSF28QsBG2PbxePqjmuuryLygG
         duOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ih3O4/69tbNzYNtuvvMQexZCyfb110eF4LQYqz6A1a8=;
        b=GGOG5eivqDMxGC6U4nvZOLRHV1N+QaoVIcu2qHC90uLoJq1p5UXGkiobYj5coWeVHf
         IF2Db+qfCucHImt+QPNfSTo6rUhU2GxQbJBcogqACmcQUfJxXDy3FIxnycaqgavaR6Wa
         IJ/xSeiadD5WMY22/P5/wIf9rDKjyKGO/h8T5Wd4+zXb0ThOsdRzWbei1FoDG5jEXfTz
         SD36oklMmOS6tx/K4MKw+d9+5lWFr74In9tJrhbejHDpy4l55A7SkUfUanWSoqGq+T5l
         AdICZf5ZgH3FF8RwyGxtOiyVGNPMzK1e4vDfO0E5In5NXnMz/BTJwhkJHroPUJxwZwWx
         VIVA==
X-Gm-Message-State: AOAM532f1oQBJtwfsMj6+GKoqpKAZ8e7ULzRZIKXsm18R/c12Rdt/xBt
        wR+2rhOVVK3dTXH7kNlG0dKumg==
X-Google-Smtp-Source: ABdhPJzF5MdHkN30rMxhM08Dll+pFjuoVo1hfpDDj1pyl+exwrIuUkJQyF/Ca4oAKOpWlwnK0WAGXA==
X-Received: by 2002:a7b:c749:: with SMTP id w9mr2705330wmk.29.1600807753779;
        Tue, 22 Sep 2020 13:49:13 -0700 (PDT)
Received: from localhost ([2a01:4b00:8523:2d03:1105:630f:e990:272f])
        by smtp.gmail.com with ESMTPSA id y1sm5745394wma.36.2020.09.22.13.49.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Sep 2020 13:49:13 -0700 (PDT)
From:   David Brazdil <dbrazdil@google.com>
To:     kvmarm@lists.cs.columbia.edu
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com, David Brazdil <dbrazdil@google.com>
Subject: [PATCH v4 00/10] Independent per-CPU data section for nVHE
Date:   Tue, 22 Sep 2020 21:49:00 +0100
Message-Id: <20200922204910.7265-1-dbrazdil@google.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce '.hyp.data..percpu' as part of ongoing effort to make nVHE
hyp code self-contained and independent of the rest of the kernel.

Main benefits:
 * independent nVHE per-CPU data section that can be unmapped from host,
 * more robust linking of nVHE hyp code,
 * no need for hyp-specific macros to access per-CPU variables.

The series is structured as follows:

 - patch 1: Improve existing hyp build rules. This could be sent and merged
    independently of per-CPU but this series builds on it.

 - patches 2-3: Minor cleanups.

 - patches 4-5: Replace hyp helpers for accessing per-CPU variables
     with common helpers modified to work correctly in hyp. Per-CPU
     variables can now be accessed with one API anywhere.

 - patches 6-8: Where VHE and nVHE use per-CPU variables defined in
     kernel proper, move their definitions to hyp/ where they are
     duplicated and owned by VHE/nVHE, respectively. Non-VHE hyp code
     now refers only to per-CPU variables defined in its source files.
     Helpers are added so that kernel proper can continue to access
     nVHE hyp variables, same way as it does with other nVHE symbols.

 - patches 9-10: Introduce '.hyp.data..percpu' ELF section and allocate
     memory for every CPU core during KVM init. All nVHE per-CPU state
     is now grouped together in ELF and in memory. Introducing a new
     per-CPU variable does not require adding new memory mappings any
     more. nVHE hyp code cannot accidentally refer to kernel-proper
     per-CPU data as it only has the pointer to its own per-CPU memory.

Patches are rebased on v5.9-rc6 and available in branch 'topic/percpu-v4' at:
    https://android-kvm.googlesource.com/linux

For maintainers: In case of interest, there are patches that remove the need
for redefining macros under DEBUG_PREEMPT available at the same repo, branch
'topic/percpu-v3-debug-preempt'. Since they are non-trivial, I am not going
to post them here so late in the 5.10 window. I plan to post them for 5.11
when they will also be useful for other patches.

Changes v3 -> v4:
 * Drop patch that marked pages allocated for hyp reserved
 * Copy arm64_ssbd_callback_required at cpu_init_hyp_mode
 * Use read_sysreg in __hyp_my_cpu_offset
 * Simplify per-CPU region allocation code
 * Use same subsection name regex as other kernel linker scripts
 * Rename helper per-CPU macros
 * Add .gitignore for hyp linker script

Changes v2 -> v3:
 * Use PERCPU_INPUT in hyp.ld instead of modifying PERCPU_SECTION
 * Only pass linker script once to LD (fix error message)
 * Renamed '.hyp.o' to '.nvhe.o'
 * Use __KVM_VHE_HYPERVISOR__ to select TPIDR_EL2 instead of alternatives
 * Move all prefixing-related macros to hyp_image.h

Changes v1 -> v2:
 * partially link hyp code, add linker script

David Brazdil (10):
  kvm: arm64: Partially link nVHE hyp code, simplify HYPCOPY
  kvm: arm64: Move nVHE hyp namespace macros to hyp_image.h
  kvm: arm64: Only define __kvm_ex_table for CONFIG_KVM
  kvm: arm64: Remove __hyp_this_cpu_read
  kvm: arm64: Remove hyp_adr/ldr_this_cpu
  kvm: arm64: Add helpers for accessing nVHE hyp per-cpu vars
  kvm: arm64: Duplicate arm64_ssbd_callback_required for nVHE hyp
  kvm: arm64: Create separate instances of kvm_host_data for VHE/nVHE
  kvm: arm64: Set up hyp percpu data for nVHE
  kvm: arm64: Remove unnecessary hyp mappings

 arch/arm64/include/asm/assembler.h        | 29 +++++---
 arch/arm64/include/asm/hyp_image.h        | 36 ++++++++++
 arch/arm64/include/asm/kvm_asm.h          | 82 +++++++++++------------
 arch/arm64/include/asm/kvm_host.h         |  2 +-
 arch/arm64/include/asm/kvm_mmu.h          | 22 ++----
 arch/arm64/include/asm/percpu.h           | 28 +++++++-
 arch/arm64/kernel/image-vars.h            |  4 --
 arch/arm64/kernel/vmlinux.lds.S           | 13 ++++
 arch/arm64/kvm/arm.c                      | 61 +++++++++++++----
 arch/arm64/kvm/hyp/hyp-entry.S            |  2 +-
 arch/arm64/kvm/hyp/include/hyp/debug-sr.h |  4 +-
 arch/arm64/kvm/hyp/include/hyp/switch.h   |  8 +--
 arch/arm64/kvm/hyp/nvhe/.gitignore        |  2 +
 arch/arm64/kvm/hyp/nvhe/Makefile          | 60 +++++++++--------
 arch/arm64/kvm/hyp/nvhe/hyp.lds.S         | 19 ++++++
 arch/arm64/kvm/hyp/nvhe/switch.c          |  8 ++-
 arch/arm64/kvm/hyp/vhe/switch.c           |  5 +-
 arch/arm64/kvm/hyp/vhe/sysreg-sr.c        |  4 +-
 arch/arm64/kvm/pmu.c                      | 13 ++--
 19 files changed, 272 insertions(+), 130 deletions(-)
 create mode 100644 arch/arm64/include/asm/hyp_image.h
 create mode 100644 arch/arm64/kvm/hyp/nvhe/.gitignore
 create mode 100644 arch/arm64/kvm/hyp/nvhe/hyp.lds.S

--
2.28.0.681.g6f77f65b4e-goog
