Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CA1C2D4312
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 14:19:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732230AbgLINSc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 08:18:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731919AbgLINSc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 08:18:32 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B89CC0613CF
        for <linux-kernel@vger.kernel.org>; Wed,  9 Dec 2020 05:17:51 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id r14so1725412wrn.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Dec 2020 05:17:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QypmxVIIHfEpkRMXwz8jV9VsRXxLaN9Gc9MoWcFoJN0=;
        b=kn2qu9K6MOj2MXP522yIjJX7A97Hyx0Phr4xxfxonQ/CMS6ng7WChR5TEVRC/jU2Su
         QLDFFAMueBgyOZhIR07ndwQHRYzcAX4yJrUz2OCRVGpilBOzkQhlaLAaABKKbaOo2VEF
         vm89uw1HvqgH3laEQB7NJVxW/XObdLyra7NrslCf0vlFxqx2u7jdJNb7iV0jOZQSbq2Y
         d0vs+Dms5KmvwpkpRnRmDFhmF3eaZc7BPFquhJnN6ii8hgGK1fH3IELu7Upqef2nN15l
         lc04nXOiIITjkqdBMmjhqITcQracKHbhw499CO72Uc3kCIH/DtWhayfxko85ipVEYdo/
         ehqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QypmxVIIHfEpkRMXwz8jV9VsRXxLaN9Gc9MoWcFoJN0=;
        b=crTgKvdaAJMOfLk/6eGPVrl/5FaA6km9lAoXpOMZUKl+VrMoIo0+Oev7/r5kraCH/c
         XJpnZuoGTFpisLXsHR1cX+agEN/LdNWJo4equIl3em8+pPJFtR68Dcl1QMpkjGaj/RTH
         +A8HbExmJ4PoucIpnDHljiDdS57mwcJI/Q5FPzNwiM1hvtUdT28znQ+UCzkzo78mx6WP
         VBgjy2uZs97w37ZXf9iCcRwmX9spDxYsQAQNaiBoSC3ftHoQQQBSHV+zGTyRLYiLt/4t
         uOFsT9cZgypdOvNq6PRwhrqcwVZQLGF9tVmzmF0bLz2Y4KqnMiJ7262Yh69LZkKealgN
         rAmw==
X-Gm-Message-State: AOAM532zKRjPT276QlItID0sT5U2k4ntRo8StE+r3nCOtpCu0uIbtpYa
        BkynGw4aGVob8MuwyaQm7RCxiA==
X-Google-Smtp-Source: ABdhPJxePgQkSVZVEUA4FZYzEF3UdagWSgDgT9hXezo4LvnwaZ1NClGbAw10690t+P/fIDVPZfv+0Q==
X-Received: by 2002:adf:97db:: with SMTP id t27mr2599398wrb.375.1607519870252;
        Wed, 09 Dec 2020 05:17:50 -0800 (PST)
Received: from localhost ([2a01:4b00:8523:2d03:9d1b:d0eb:db43:6cd2])
        by smtp.gmail.com with ESMTPSA id d187sm3644642wmd.8.2020.12.09.05.17.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Dec 2020 05:17:48 -0800 (PST)
From:   David Brazdil <dbrazdil@google.com>
To:     kvmarm@lists.cs.columbia.edu
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com, David Brazdil <dbrazdil@google.com>
Subject: [PATCH 0/9] KVM: arm64: Relocate absolute hyp VAs
Date:   Wed,  9 Dec 2020 13:17:37 +0000
Message-Id: <20201209131746.85622-1-dbrazdil@google.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

nVHE hyp code is linked into the same kernel binary but executes under
different memory mappings. If the compiler of hyp code chooses absolute
addressing for accessing a symbol, the kernel linker will relocate that
address to a kernel image virtual address, causing a runtime exception.

So far the strategy has been to force PC-relative addressing by wrapping
all symbol references with the hyp_symbol_addr macro. This is error
prone and developer unfriendly.

The series adds a new build-time step for nVHE hyp object file where
positions targeted by R_AARCH64_ABS64 relocations are enumerated and
the information stored in a separate ELF section in the kernel image.
At runtime, the kernel first relocates all absolute addresses to their
actual virtual offset (eg. for KASLR), and then addresses listed in this
section are converted to hyp VAs.

The RFC of this series did not have a build-time step and instead relied
on filtering dynamic relocations at runtime. That approach does not work
if the kernel is built with !CONFIG_RELOCATABLE, hence an always-present
set of relocation positions was added.

The series is based on the current kvmarm/next (commit 3a514592b6) and
structured as follows:
  * patch 1 is Jamie's fix of .hyp.data..percpu alignment; already in
    master, not yet in kvmarm/next; included to avoid merge conflicts
  * patches 2-3 make sure that all sections referred to by hyp code are
    handled by the hyp linker script and prefixed with .hyp so they can
    be identified by the build-time tool
  * patches 4-6 contain the actual changes to identify and relocate VAs
  * patches 7-8 fix existing code that assumes kernel VAs
  * patch 9 removes the (now redundant) hyp_symbol_addr

The series is also available at:
  https://android-kvm.googlesource.com/linux topic/hyp-reloc_v1

-David

David Brazdil (8):
  KVM: arm64: Rename .idmap.text in hyp linker script
  KVM: arm64: Set up .hyp.rodata ELF section
  KVM: arm64: Add symbol at the beginning of each hyp section
  KVM: arm64: Generate hyp relocation data
  KVM: arm64: Apply hyp relocations at runtime
  KVM: arm64: Fix constant-pool users in hyp
  KVM: arm64: Remove patching of fn pointers in hyp
  KVM: arm64: Remove hyp_symbol_addr

Jamie Iles (1):
  KVM: arm64: Correctly align nVHE percpu data

 arch/arm64/configs/defconfig             |   1 +
 arch/arm64/include/asm/hyp_image.h       |  29 +-
 arch/arm64/include/asm/kvm_asm.h         |  20 --
 arch/arm64/include/asm/kvm_mmu.h         |  61 ++---
 arch/arm64/include/asm/sections.h        |   3 +-
 arch/arm64/kernel/image-vars.h           |   1 -
 arch/arm64/kernel/smp.c                  |   4 +-
 arch/arm64/kernel/vmlinux.lds.S          |  18 +-
 arch/arm64/kvm/arm.c                     |   7 +-
 arch/arm64/kvm/hyp/include/hyp/switch.h  |   4 +-
 arch/arm64/kvm/hyp/nvhe/Makefile         |  28 +-
 arch/arm64/kvm/hyp/nvhe/gen-hyprel.c     | 326 +++++++++++++++++++++++
 arch/arm64/kvm/hyp/nvhe/host.S           |  29 +-
 arch/arm64/kvm/hyp/nvhe/hyp-init.S       |   4 +-
 arch/arm64/kvm/hyp/nvhe/hyp-main.c       |  11 +-
 arch/arm64/kvm/hyp/nvhe/hyp-smp.c        |   4 +-
 arch/arm64/kvm/hyp/nvhe/hyp.lds.S        |  14 +-
 arch/arm64/kvm/hyp/nvhe/psci-relay.c     |  24 +-
 arch/arm64/kvm/hyp/vgic-v2-cpuif-proxy.c |   2 +-
 arch/arm64/kvm/va_layout.c               |  34 ++-
 20 files changed, 495 insertions(+), 129 deletions(-)
 create mode 100644 arch/arm64/kvm/hyp/nvhe/gen-hyprel.c

--
2.29.2.576.ga3fc446d84-goog
