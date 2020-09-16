Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DA9D26CA88
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 22:06:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727752AbgIPUGy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 16:06:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726310AbgIPRfS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 13:35:18 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F764C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 10:34:46 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id z4so7803394wrr.4
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 10:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7mFDfLRc/4coa4w4PmVZiF39D3EbfTO0poh1JSaf3tg=;
        b=vGAU2kWRhekFoBDT7sUBYbd7AQ/0NP8rSF7wCZ5cc1mqJHfnkU2LjdxpqgvLSzC8C6
         HgK02bdPHtLbqtZn4q0RnS1+zmNXG6b9m/TES+lyBYb2TqNi/8kRzN7/jf0y7NjX7EpS
         pt6qAOuPo6oyK//jwyuGbT6kcxGnovcDDEppAUOdKxofvqiqaZmpGbz73Jb0jc5ytCne
         Elp8PtK3xec2AV24MDV0HI1V2eP53YwAN77CLySTA5Lm1UefJnEEepbtf3Ad6NktHs8V
         rKpZjaC58ODG5D60rOWatOiXUAirqTD58E++PKgCBvPwbwpXA3sRP3PQRGW3dcAiasL/
         Fqgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7mFDfLRc/4coa4w4PmVZiF39D3EbfTO0poh1JSaf3tg=;
        b=c8+q7T4KqdRpIEYZYBUaGGQK/UhZiOoYcoBbFT0CzHGB1+0b/RdKHs6lvD2TbKOMf+
         ym+Mp8iKcphaOZqbAkTljID1JqsrRAWB1gtV5s/qzvk68a9Yg4wVxDDxdrVXh4EAlQV/
         GXYle02v5oaug5QPdo1ZZAa2iaL3LY0nDh5RtJcduC+e1z40QMoYc7+yiKCpFuO64j7o
         IyHWkQhfRCUre9GduMHLHJnhZnzhAjlgdR3mzNT4TnWj0BF0sww+TbJ7noQymc/Uu+Xa
         +1LO4AuJUC+g0PP7Q3vx6OfyPnNRKdxTqiRIP0u5Jo8fy14YxGT66HBhH/DG6bEYpphd
         AZ1Q==
X-Gm-Message-State: AOAM533ei/dG+XlD1nah/wPE3547SNwmt+VWSS4rxuN6m7PDCM7h1X2q
        amC6RFMcIHrZzPurI24PoARvwg==
X-Google-Smtp-Source: ABdhPJzmjFCynjgBuUkJ+b5Puz0KOw8KtSCoG1vuE4eR8lKjcBVC8JI8uRWOwLM4nzTsOVZRlwYx+A==
X-Received: by 2002:adf:d845:: with SMTP id k5mr26012928wrl.285.1600277685420;
        Wed, 16 Sep 2020 10:34:45 -0700 (PDT)
Received: from localhost ([2a01:4b00:8523:2d03:e49d:f6be:d31b:ad3c])
        by smtp.gmail.com with ESMTPSA id a5sm246603wrp.37.2020.09.16.10.34.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Sep 2020 10:34:44 -0700 (PDT)
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
Subject: [PATCH v3 00/10] Independent per-CPU data section for nVHE
Date:   Wed, 16 Sep 2020 18:34:28 +0100
Message-Id: <20200916173439.32265-1-dbrazdil@google.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
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

 - patches 9-11: Introduce '.hyp.data..percpu' ELF section and allocate
     memory for every CPU core during KVM init. All nVHE per-CPU state
     is now grouped together in ELF and in memory. Introducing a new
     per-CPU variable does not require adding new memory mappings any
     more. nVHE hyp code cannot accidentally refer to kernel-proper
     per-CPU data as it only has the pointer to its own per-CPU memory.

Patches are rebased on v5.9-rc5 and available in branch 'topic/percpu-v3' at:
    https://android-kvm.googlesource.com/linux

For maintainers: In case of interest, there are patches that remove the need
for redefining macros under DEBUG_PREEMPT available at the same repo, branch
'topic/percpu-v3-debug-preempt'. Since they are non-trivial, I am not going
to post them here so late in the 5.10 window. I plan to post them for 5.11
when they will also be useful for other patches.

Changes v2 -> v3:
 * Use PERCPU_INPUT in hyp.ld instead of modifying PERCPU_SECTION
 * Only pass linker script once to LD (fix error message)
 * Renamed '.hyp.o' to '.nvhe.o'
 * Use __KVM_VHE_HYPERVISOR__ to select TPIDR_EL2 instead of alternatives
 * Move all prefixing-related macros to hyp_image.h

Changes v1 -> v2:
 * partially link hyp code, add linker script

David Brazdil (11):
  kvm: arm64: Partially link nVHE hyp code, simplify HYPCOPY
  kvm: arm64: Move nVHE hyp namespace macros to hyp_image.h
  kvm: arm64: Only define __kvm_ex_table for CONFIG_KVM
  kvm: arm64: Remove __hyp_this_cpu_read
  kvm: arm64: Remove hyp_adr/ldr_this_cpu
  kvm: arm64: Add helpers for accessing nVHE hyp per-cpu vars
  kvm: arm64: Duplicate arm64_ssbd_callback_required for nVHE hyp
  kvm: arm64: Create separate instances of kvm_host_data for VHE/nVHE
  kvm: arm64: Mark hyp stack pages reserved
  kvm: arm64: Set up hyp percpu data for nVHE
  kvm: arm64: Remove unnecessary hyp mappings

 arch/arm64/include/asm/assembler.h        |  27 ++++--
 arch/arm64/include/asm/hyp_image.h        |  36 +++++++
 arch/arm64/include/asm/kvm_asm.h          |  82 ++++++++--------
 arch/arm64/include/asm/kvm_host.h         |   2 +-
 arch/arm64/include/asm/kvm_mmu.h          |  19 ++--
 arch/arm64/include/asm/percpu.h           |  33 ++++++-
 arch/arm64/include/asm/sections.h         |   1 +
 arch/arm64/kernel/image-vars.h            |   4 -
 arch/arm64/kernel/vmlinux.lds.S           |  13 +++
 arch/arm64/kvm/arm.c                      | 109 +++++++++++++++++++---
 arch/arm64/kvm/hyp/hyp-entry.S            |   2 +-
 arch/arm64/kvm/hyp/include/hyp/debug-sr.h |   4 +-
 arch/arm64/kvm/hyp/include/hyp/switch.h   |   8 +-
 arch/arm64/kvm/hyp/nvhe/Makefile          |  60 ++++++------
 arch/arm64/kvm/hyp/nvhe/hyp.lds.S         |  19 ++++
 arch/arm64/kvm/hyp/nvhe/switch.c          |   8 +-
 arch/arm64/kvm/hyp/vhe/switch.c           |   5 +-
 arch/arm64/kvm/hyp/vhe/sysreg-sr.c        |   4 +-
 arch/arm64/kvm/pmu.c                      |  13 ++-
 19 files changed, 320 insertions(+), 129 deletions(-)
 create mode 100644 arch/arm64/include/asm/hyp_image.h
 create mode 100644 arch/arm64/kvm/hyp/nvhe/hyp.lds.S

-- 
2.28.0.618.gf4bc123cb7-goog

