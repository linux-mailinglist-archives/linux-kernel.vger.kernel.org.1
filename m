Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D261D229D53
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jul 2020 18:45:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728886AbgGVQpB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jul 2020 12:45:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726462AbgGVQpB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 12:45:01 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD700C0619E0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 09:45:00 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id f1so2008729wro.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 09:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uK8JM1EQn953l4hGDn7zKBHviQV8WaFyoUu/xfhEpC4=;
        b=uicjnXpHLyBycUGbJeXW1bnB5AdLJ1vIB5qSpkXxiiI0/QNUiM2C/tpeHlrOE1EsZW
         aYvVDSXzKs6F/PWWDz+eCkjv/alvVv8dpbsda0R9i3ZWyQdHh6OUTSKx0uG8uaq0E7Xc
         KeejKt/rn73e0BYz8UDnVX79SoUII3hDUDVVuUxuFDN+uBYJeKOeMmXMy4Ytimhaejil
         p7t0h/y68w3BjV9hhkphxrH3yBNiCjlrtyHfwKwGwjrx1P5gC6DlBWVRIH1SgPR8kx4b
         bOx5jIJM2pIUODErYnMEhS7zO/hOhG1NC1m8HlpCdo8FNK7fH/XWc8DkGZ5kiSLTc7eh
         nIlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uK8JM1EQn953l4hGDn7zKBHviQV8WaFyoUu/xfhEpC4=;
        b=DaOZKQ/KQEKb7XiPpAwMqdNpNves7r7F1k6NV5QJaJ7Ioenf0doDegVbEN8kCVSFAh
         qKnIy0oW6sd9LgFY6IURnPznjjPz1iBWpTXV0k1XeavqIm5AY+tTLnf7S4AbEw1TuJDS
         FTyJBiJSNt5DEzrb8J3t8scMyle34tNihPclE+RA/6FjULnyvZFw4tgcbepH25ZAOxGP
         myglVeWsI6BMYBZ80ECf89KuWyVLExURx6p7OSqGWpyQw9lvgv6l/iHCs+nAoq1BHen6
         fCbZ3As7YaAVZ8y8mBgEVlV9Q2EwK7V5fpKtr4aRErXlaEPUoM51/f6Yp9+q+uCd1WpQ
         w0+w==
X-Gm-Message-State: AOAM532axigdZCB02aPUp1FPhLLREozs1Xqce5NZ7xn/tFjyY+x61BbQ
        4OhbTAFtRqgls/Guclf6mSr2Qw==
X-Google-Smtp-Source: ABdhPJz2GhTgbxEm97Jbg+actM1Hl9ijg1JYz6533hzpsH9VeShzXrQ2seUMjDFp65Edaw0F/0nFQg==
X-Received: by 2002:a5d:4649:: with SMTP id j9mr389718wrs.270.1595436299200;
        Wed, 22 Jul 2020 09:44:59 -0700 (PDT)
Received: from localhost ([2a01:4b00:8523:2d03:b0ee:900a:e004:b9d0])
        by smtp.gmail.com with ESMTPSA id p14sm517283wrx.90.2020.07.22.09.44.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jul 2020 09:44:58 -0700 (PDT)
From:   David Brazdil <dbrazdil@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>, Arnd Bergmann <arnd@arndb.de>
Cc:     James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kvmarm@lists.cs.columbia.edu, linux-arch@vger.kernel.org,
        kernel-team@google.com, David Brazdil <dbrazdil@google.com>
Subject: [PATCH 0/9] Independent per-CPU data section for nVHE
Date:   Wed, 22 Jul 2020 17:44:15 +0100
Message-Id: <20200722164424.42225-1-dbrazdil@google.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce '.hyp.data..percpu' as part of ongoing effort to make nVHE
hyp code self-contained and independent of the rest of the kernel.

The series builds on top of the "Split off nVHE hyp code" series which
used objcopy to rename '.text' to '.hyp.text' and prefix all ELF
symbols with '__kvm_nvhe' for all object files under kvm/hyp/nvhe.

The series is structured as follows:

 - patch 1: Modify generic PERCPU_* linker script macros to make it
     possible to define multiple per-CPU ELF sections with prefixed
     section and symbol names.

 - patches 2-3: Replace hyp helpers for accessing per-CPU variables
     with common helpers modified to work correctly in hyp. Per-CPU
     variables can now be accessed with one API anywhere.

 - patches 4-6: Where VHE and nVHE use per-CPU variables defined in
     kernel proper, move their definitions to hyp/ where they are
     duplicated and owned by VHE/nVHE, respectively. Non-VHE hyp code
     now refers only to per-CPU variables defined in its source files.
     Helpers are added so that kernel proper can continue to access
     nVHE hyp variables, same way as it does with other nVHE symbols.

 - patches 7-9: Introduce '.hyp.data..percpu' ELF section and allocate
     memory for every CPU core during KVM init. All nVHE per-CPU state
     is now grouped together in ELF and in memory. Introducing a new
     per-CPU variable does not require adding new memory mappings any
     more. nVHE hyp code cannot accidentally refer to kernel-proper
     per-CPU data as it only has the pointer to its own per-CPU memory.

The patches are rebased on current kvmarm/next (commit b72eb1f6813)
and are available in branch 'topic/percpu' at:
    https://android-kvm.googlesource.com/linux

David Brazdil (9):
  Macros to override naming of percpu symbols and sections
  kvm: arm64: Remove __hyp_this_cpu_read
  kvm: arm64: Remove hyp_adr/ldr_this_cpu
  kvm: arm64: Add helpers for accessing nVHE hyp per-cpu vars
  kvm: arm64: Duplicate arm64_ssbd_callback_required for nVHE hyp
  kvm: arm64: Create separate instances of kvm_host_data for VHE/nVHE
  kvm: arm64: Mark hyp stack pages reserved
  kvm: arm64: Set up hyp percpu data for nVHE
  kvm: arm64: Remove unnecessary hyp mappings

 arch/arm64/include/asm/assembler.h        |  27 ++++--
 arch/arm64/include/asm/kvm_asm.h          |  74 ++++++++-------
 arch/arm64/include/asm/kvm_host.h         |   2 +-
 arch/arm64/include/asm/kvm_mmu.h          |  23 ++---
 arch/arm64/include/asm/percpu.h           |  33 ++++++-
 arch/arm64/include/asm/sections.h         |   1 +
 arch/arm64/kernel/image-vars.h            |   2 -
 arch/arm64/kernel/vmlinux.lds.S           |  10 ++
 arch/arm64/kvm/arm.c                      | 110 ++++++++++++++++++----
 arch/arm64/kvm/hyp/hyp-entry.S            |   2 +-
 arch/arm64/kvm/hyp/include/hyp/debug-sr.h |   4 +-
 arch/arm64/kvm/hyp/include/hyp/switch.h   |   6 +-
 arch/arm64/kvm/hyp/nvhe/Makefile          |   2 +
 arch/arm64/kvm/hyp/nvhe/switch.c          |   8 +-
 arch/arm64/kvm/hyp/vhe/switch.c           |   5 +-
 arch/arm64/kvm/hyp/vhe/sysreg-sr.c        |   4 +-
 arch/arm64/kvm/pmu.c                      |  13 ++-
 include/asm-generic/vmlinux.lds.h         |  40 +++++---
 18 files changed, 257 insertions(+), 109 deletions(-)

-- 
2.27.0

