Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D53822EF233
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 13:17:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbhAHMQJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 07:16:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726133AbhAHMQI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 07:16:08 -0500
Received: from mail-wr1-x44a.google.com (mail-wr1-x44a.google.com [IPv6:2a00:1450:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A34EAC0612F5
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jan 2021 04:15:27 -0800 (PST)
Received: by mail-wr1-x44a.google.com with SMTP id r8so4054073wro.22
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jan 2021 04:15:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=8jWtBJc1CFcZb+VXrXLCFTBvH9ZyJNX9qmbOUYXXGY0=;
        b=keePsNtl1E9gJ3ZSMLecqwf/miasl2f7G9Qw05xGjoSrd1phO1u0M4d0sD5gNWCwL3
         IfBOoKkoYFErlFOZyuJxN6wX+NukPTNuI4IJ3fFJlV5UvFdOBEkiVdVzLmeqGsNGQMLv
         Bzr1AVeWxssYqd7azGxpM14RQdhSiD+Avc6I29t/i3hH7HW4xBbAaSPO8SvQxT+ocep7
         4rKmwedbo/QeoMedDSlXM8ZHpNoBqGlOvWi6UfcDIe4eP1CI8y2K3jv7IE9KLnkjkpnF
         abRO3MCs96CHqdlUmHw4pgCBCTMpEe4Jwvt/Dt8S0BDkLff5f66rb5FDGRHmVVqRVmH+
         xPZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=8jWtBJc1CFcZb+VXrXLCFTBvH9ZyJNX9qmbOUYXXGY0=;
        b=pMc8Tzo8jlj8GDwOHbLU4CGSjHb60Uz5BxSnjqlI4OFXqp9pTJnu8Yjda1no+/McE3
         Nh8URUIDimrW4r8IPAMywb7E0jNlwph/2a//jZHqgpkO7Irqz/4VGwcnsGy9X+F2Uowl
         jbQJ7dkNnYcS0hicq2aWBqNDxrL49IIx/ZQJm2Pza+sm7VB2oOJRVuElXbFxjHikDqKc
         eELe3KmTSzdQ7LOvxmLElMiGHYT7FNOp54dC4BaPyofNNNjaLT43ptkaR3pbl3Yxl+qu
         CJ3WL2jNSqszKzmCnAgH/Gss+tYphNJ8ebjevzyXnTGGJhzrsgrACNQY4YXhGTlkMd8s
         yaxw==
X-Gm-Message-State: AOAM532uDWXBxT/yT6Nuo+oMFTXnara3ty8rUX/S8ifXvI0YwMKi87Yr
        77Jv8gHCx5XMLVTIKkDU7U8RbYSQD5HN
X-Google-Smtp-Source: ABdhPJwI2qadtflNq64nGgHy8mDYMmobmhMLyzB308p1S4AbE2li7Ch6Zqf20u6+ktNgGnvmYe+pC6V4Gd15
Sender: "qperret via sendgmr" <qperret@r2d2-qp.c.googlers.com>
X-Received: from r2d2-qp.c.googlers.com ([fda3:e722:ac3:10:28:9cb1:c0a8:1652])
 (user=qperret job=sendgmr) by 2002:a7b:cc94:: with SMTP id
 p20mr2807021wma.22.1610108126249; Fri, 08 Jan 2021 04:15:26 -0800 (PST)
Date:   Fri,  8 Jan 2021 12:14:58 +0000
Message-Id: <20210108121524.656872-1-qperret@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [RFC PATCH v2 00/26] KVM/arm64: A stage 2 for the host
From:   Quentin Perret <qperret@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     devicetree@vger.kernel.org, android-kvm@google.com,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        Fuad Tabba <tabba@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        David Brazdil <dbrazdil@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This is the v2 of the series previously posted here:

  https://lore.kernel.org/kvmarm/20201117181607.1761516-1-qperret@google.com/

This basically allows us to wrap the host with a stage 2 when running in
nVHE, hence paving the way for protecting guest memory from the host in
the future (among other use-cases). For more details about the
motivation and the design angle taken here, I would recommend to have a
look at the cover letter of v1, and/or to watch these presentations at
LPC [1] and KVM forum 2020 [2].

In short, the changes since v1 include:

 - Renamed most pkvm-specific pgtable functions as pkvm_* to avoid
   confusion with the host's (Fuad)

 - Added an IC flush when switching pgtables (Fuad, Mark)

 - Cleaned-up the PI aliasing in image-vars.h (David)

 - Added a TLB flush when enabling the host stage 2 to avoid stale TLBs
   from bootloader

 - Fixed the early memory reservation by using NR_CPUS instead of
   num_possible_cpus() (which is always 1 that early)

 - Added missing preempt_{dis,en}able() guards in
   kvm_hyp_enable_protection()

 - Rebased on latest kvmarm/next

And if you'd like a branch that has all the goodies, there it is:

    https://android-kvm.googlesource.com/linux qperret/host-stage2-v2

Thanks!
Quentin

[1] https://youtu.be/54q6RzS9BpQ?t=10859
[2] https://kvmforum2020.sched.com/event/eE24/virtualization-for-the-masses-exposing-kvm-on-android-will-deacon-google

Quentin Perret (23):
  KVM: arm64: Initialize kvm_nvhe_init_params early
  KVM: arm64: Avoid free_page() in page-table allocator
  KVM: arm64: Factor memory allocation out of pgtable.c
  KVM: arm64: Introduce a BSS section for use at Hyp
  KVM: arm64: Make kvm_call_hyp() a function call at Hyp
  KVM: arm64: Allow using kvm_nvhe_sym() in hyp code
  KVM: arm64: Introduce an early Hyp page allocator
  KVM: arm64: Stub CONFIG_DEBUG_LIST at Hyp
  KVM: arm64: Introduce a Hyp buddy page allocator
  KVM: arm64: Enable access to sanitized CPU features at EL2
  KVM: arm64: Factor out vector address calculation
  of/fdt: Introduce early_init_dt_add_memory_hyp()
  KVM: arm64: Prepare Hyp memory protection
  KVM: arm64: Elevate Hyp mappings creation at EL2
  KVM: arm64: Use kvm_arch for stage 2 pgtable
  KVM: arm64: Use kvm_arch in kvm_s2_mmu
  KVM: arm64: Set host stage 2 using kvm_nvhe_init_params
  KVM: arm64: Refactor kvm_arm_setup_stage2()
  KVM: arm64: Refactor __load_guest_stage2()
  KVM: arm64: Refactor __populate_fault_info()
  KVM: arm64: Make memcache anonymous in pgtable allocator
  KVM: arm64: Reserve memory for host stage 2
  KVM: arm64: Wrap the host with a stage 2

Will Deacon (3):
  arm64: lib: Annotate {clear,copy}_page() as position-independent
  KVM: arm64: Link position-independent string routines into .hyp.text
  arm64: kvm: Add standalone ticket spinlock implementation for use at
    hyp

 arch/arm64/include/asm/cpufeature.h           |   1 +
 arch/arm64/include/asm/hyp_image.h            |   7 +
 arch/arm64/include/asm/kvm_asm.h              |   7 +
 arch/arm64/include/asm/kvm_cpufeature.h       |  19 ++
 arch/arm64/include/asm/kvm_host.h             |  16 +-
 arch/arm64/include/asm/kvm_hyp.h              |   8 +
 arch/arm64/include/asm/kvm_mmu.h              |  69 +++++-
 arch/arm64/include/asm/kvm_pgtable.h          |  41 +++-
 arch/arm64/include/asm/sections.h             |   1 +
 arch/arm64/kernel/asm-offsets.c               |   3 +
 arch/arm64/kernel/cpufeature.c                |  12 +
 arch/arm64/kernel/image-vars.h                |  33 +++
 arch/arm64/kernel/vmlinux.lds.S               |   7 +
 arch/arm64/kvm/arm.c                          | 144 ++++++++++--
 arch/arm64/kvm/hyp/Makefile                   |   2 +-
 arch/arm64/kvm/hyp/include/hyp/switch.h       |  36 +--
 arch/arm64/kvm/hyp/include/nvhe/early_alloc.h |  14 ++
 arch/arm64/kvm/hyp/include/nvhe/gfp.h         |  32 +++
 arch/arm64/kvm/hyp/include/nvhe/mem_protect.h |  33 +++
 arch/arm64/kvm/hyp/include/nvhe/memory.h      |  55 +++++
 arch/arm64/kvm/hyp/include/nvhe/mm.h          | 107 +++++++++
 arch/arm64/kvm/hyp/include/nvhe/spinlock.h    |  92 ++++++++
 arch/arm64/kvm/hyp/nvhe/Makefile              |   9 +-
 arch/arm64/kvm/hyp/nvhe/cache.S               |  13 ++
 arch/arm64/kvm/hyp/nvhe/cpufeature.c          |   8 +
 arch/arm64/kvm/hyp/nvhe/early_alloc.c         |  60 +++++
 arch/arm64/kvm/hyp/nvhe/hyp-init.S            |  41 ++++
 arch/arm64/kvm/hyp/nvhe/hyp-main.c            |  48 ++++
 arch/arm64/kvm/hyp/nvhe/hyp.lds.S             |   1 +
 arch/arm64/kvm/hyp/nvhe/mem_protect.c         | 191 ++++++++++++++++
 arch/arm64/kvm/hyp/nvhe/mm.c                  | 174 ++++++++++++++
 arch/arm64/kvm/hyp/nvhe/page_alloc.c          | 185 +++++++++++++++
 arch/arm64/kvm/hyp/nvhe/psci-relay.c          |   4 +-
 arch/arm64/kvm/hyp/nvhe/setup.c               | 214 ++++++++++++++++++
 arch/arm64/kvm/hyp/nvhe/stub.c                |  22 ++
 arch/arm64/kvm/hyp/nvhe/switch.c              |  12 +-
 arch/arm64/kvm/hyp/nvhe/tlb.c                 |   4 +-
 arch/arm64/kvm/hyp/pgtable.c                  |  98 ++++----
 arch/arm64/kvm/hyp/reserved_mem.c             | 104 +++++++++
 arch/arm64/kvm/mmu.c                          | 114 +++++++++-
 arch/arm64/kvm/reset.c                        |  42 +---
 arch/arm64/lib/clear_page.S                   |   4 +-
 arch/arm64/lib/copy_page.S                    |   4 +-
 arch/arm64/mm/init.c                          |   3 +
 drivers/of/fdt.c                              |   5 +
 45 files changed, 1954 insertions(+), 145 deletions(-)
 create mode 100644 arch/arm64/include/asm/kvm_cpufeature.h
 create mode 100644 arch/arm64/kvm/hyp/include/nvhe/early_alloc.h
 create mode 100644 arch/arm64/kvm/hyp/include/nvhe/gfp.h
 create mode 100644 arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
 create mode 100644 arch/arm64/kvm/hyp/include/nvhe/memory.h
 create mode 100644 arch/arm64/kvm/hyp/include/nvhe/mm.h
 create mode 100644 arch/arm64/kvm/hyp/include/nvhe/spinlock.h
 create mode 100644 arch/arm64/kvm/hyp/nvhe/cache.S
 create mode 100644 arch/arm64/kvm/hyp/nvhe/cpufeature.c
 create mode 100644 arch/arm64/kvm/hyp/nvhe/early_alloc.c
 create mode 100644 arch/arm64/kvm/hyp/nvhe/mem_protect.c
 create mode 100644 arch/arm64/kvm/hyp/nvhe/mm.c
 create mode 100644 arch/arm64/kvm/hyp/nvhe/page_alloc.c
 create mode 100644 arch/arm64/kvm/hyp/nvhe/setup.c
 create mode 100644 arch/arm64/kvm/hyp/nvhe/stub.c
 create mode 100644 arch/arm64/kvm/hyp/reserved_mem.c

-- 
2.30.0.284.gd98b1dd5eaa7-goog

