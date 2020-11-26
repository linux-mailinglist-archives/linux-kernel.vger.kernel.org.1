Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36E372C58AA
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 16:55:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391320AbgKZPya (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 10:54:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730181AbgKZPy3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 10:54:29 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE913C0613D4
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 07:54:27 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id e7so2640154wrv.6
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 07:54:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PYeJaSm88hY1OXHAOwbtBVxKGHgJPc5mwzbhhlyynEE=;
        b=dbbWmaFGzmEM/5ruz4/Z+DeG8I1QJ3E7BZZIUlz04xlmm5mpXCXyDNZuQEBkdhMaMl
         AS/3kbrq6ApEJVDa1EWQ7GE3Zv+43ZDFCu8ZgL6c2in1kkmdfc3Xfb56Nbw+I4tyzZ0d
         cZfOb5fGLtaLONRw5bxxovN0HifciY0MSOOaqB8tHbaiNFVZgbyB68yI7gdIxEcwWDkU
         vwfFPgrG7LFDXj1G/CIUMjwKu5AxT/h9i6BiTmLEmW3vf6euE0U8dVUGZT6nIdsbJnQD
         pwVKLM8IK4mJUYQTOBDyoBAyy+P1dvspXdNdJiZdnyOnj3LkxIwHH6CqJof5p6AlYAxA
         GNsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PYeJaSm88hY1OXHAOwbtBVxKGHgJPc5mwzbhhlyynEE=;
        b=jj4GZ0DT135CUekbK7g19GM/Tugo0dw0DqaCOIfzNRJMuECymELEg3GCGUuw5Hta/0
         zF3sOq+SQpXfYeBPbCR2HrG/n0CSr4Qavxxsdbjzw11bSYlQss5dYr/MfS+W34AMfkHY
         TJQLoePSnA1e8zFg01h48GCm6wYK/w2IlZEBMCmXZqsZQVwybuDJ9s8QpsiD4IPuJv5W
         2rMrySfrGjau8+rlHROjZtnJTvJ9RPwo+ZWkahqh4QlNGjvmrUIJTHZa+dhlq8WrPsJK
         WEQjav/dvuqltnOnom16DrPyjFTtQg5QM/1IXUB72l+wyeYw5TwEo/8eIdvyu52SyqO0
         bwcw==
X-Gm-Message-State: AOAM530ptSjdRcb5bSLP7eRaodMf5UV3NtXYeDC2Qgymnma55SlhZofe
        ywWpasuRE6XC8JYTbs0SopWSQg==
X-Google-Smtp-Source: ABdhPJw48M5ZmOT1FESI9opelMUihSUq3ZOHJRFXfPns+z2bHZ7YU5uZ5kH5mgL1y3kcqmMB5aOkvw==
X-Received: by 2002:a5d:5604:: with SMTP id l4mr4564625wrv.127.1606406066449;
        Thu, 26 Nov 2020 07:54:26 -0800 (PST)
Received: from localhost ([2a01:4b00:8523:2d03:f008:704d:8d4b:9951])
        by smtp.gmail.com with ESMTPSA id r21sm9938901wrc.16.2020.11.26.07.54.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Nov 2020 07:54:25 -0800 (PST)
From:   David Brazdil <dbrazdil@google.com>
To:     kvmarm@lists.cs.columbia.edu
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel-team@android.com, David Brazdil <dbrazdil@google.com>
Subject: [PATCH v3 00/23] Opt-in always-on nVHE hypervisor
Date:   Thu, 26 Nov 2020 15:53:58 +0000
Message-Id: <20201126155421.14901-1-dbrazdil@google.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As we progress towards being able to keep guest state private to the
host running nVHE hypervisor, this series allows the hypervisor to
install itself on newly booted CPUs before the host is allowed to run
on them.

All functionality described below is opt-in, guarded by an early param
'kvm-arm.protected'. Future patches specific to the new "protected" mode
should be hidden behind the same param.

The hypervisor starts trapping host SMCs and intercepting host's PSCI
CPU_ON/SUSPEND calls. It replaces the host's entry point with its own,
initializes the EL2 state of the new CPU and installs the nVHE hyp vector
before ERETing to the host's entry point.

The kernel checks new cores' features against the finalized system
capabilities. To avoid the need to move this code/data to EL2, the
implementation only allows to boot cores that were online at the time of
KVM initialization and therefore had been checked already.

Other PSCI SMCs are forwarded to EL3, though only the known set of SMCs
implemented in the kernel is allowed. Non-PSCI SMCs are also forwarded
to EL3. Future changes will need to ensure the safety of all SMCs wrt.
private guests.

The host is still allowed to reset EL2 back to the stub vector, eg. for
hibernation or kexec, but will not disable nVHE when there are no VMs.

Tested on Rock Pi 4B, based on kvmarm/queue, itself on top of 5.10-rc4.

Patches also available at:
    https://android-kvm.googlesource.com/linux topic/psci-on-master_v3

changes since v2:
  * avoid non-spec error in CPU_SUSPEND
  * refuse to init without PSCI
  * compute hyp VA args of hyp-init in hyp instead of using params struct
  * use hyp_symbol_addr in per-cpu calls
  * simplify memory.h/sysreg.h includes
  * rebase on kvmarm/queue, use trap handler args macros

changes since v1:
  * early param sets a capability instead of a static key
  * assume SMCCC v1.2 for host SMC forwarding
  * fix reserved SMC ID range for PSCI
  * split init_el2_state into smaller macros, move to el2_setup.h
  * many small cleanups

changes since RFC:
  * add early param to make features opt-in
  * simplify CPU_ON/SUSPEND implementation
  * replace spinlocks with CAS atomic
  * make cpu_logical_map ro_after_init

David Brazdil (23):
  psci: Support psci_ops.get_version for v0.1
  psci: Accessor for configured PSCI function IDs
  arm64: Make cpu_logical_map() take unsigned int
  arm64: Move MAIR_EL1_SET to asm/memory.h
  arm64: Extract parts of el2_setup into a macro
  kvm: arm64: Add kvm-arm.protected early kernel parameter
  kvm: arm64: Initialize MAIR_EL2 using a constant
  kvm: arm64: Remove vector_ptr param of hyp-init
  kvm: arm64: Move hyp-init params to a per-CPU struct
  kvm: arm64: Add .hyp.data..ro_after_init ELF section
  kvm: arm64: Support per_cpu_ptr in nVHE hyp code
  kvm: arm64: Create nVHE copy of cpu_logical_map
  kvm: arm64: Add SMC handler in nVHE EL2
  kvm: arm64: Bootstrap PSCI SMC handler in nVHE EL2
  kvm: arm64: Add offset for hyp VA <-> PA conversion
  kvm: arm64: Forward safe PSCI SMCs coming from host
  kvm: arm64: Extract __do_hyp_init into a helper function
  kvm: arm64: Add function to enter host from KVM nVHE hyp code
  kvm: arm64: Intercept host's CPU_ON SMCs
  kvm: arm64: Intercept host's CPU_SUSPEND PSCI SMCs
  kvm: arm64: Keep nVHE EL2 vector installed
  kvm: arm64: Trap host SMCs in protected mode
  kvm: arm64: Fix EL2 mode availability checks

 .../admin-guide/kernel-parameters.txt         |   5 +
 arch/arm64/include/asm/cpucaps.h              |   3 +-
 arch/arm64/include/asm/el2_setup.h            | 182 +++++++++++
 arch/arm64/include/asm/kvm_arm.h              |   1 +
 arch/arm64/include/asm/kvm_asm.h              |   8 +-
 arch/arm64/include/asm/kvm_hyp.h              |   4 +-
 arch/arm64/include/asm/kvm_mmu.h              |  26 +-
 arch/arm64/include/asm/memory.h               |  13 +
 arch/arm64/include/asm/percpu.h               |   6 +
 arch/arm64/include/asm/sections.h             |   1 +
 arch/arm64/include/asm/smp.h                  |   4 +-
 arch/arm64/include/asm/virt.h                 |  26 ++
 arch/arm64/kernel/asm-offsets.c               |   3 +
 arch/arm64/kernel/cpufeature.c                |  29 ++
 arch/arm64/kernel/head.S                      | 144 +--------
 arch/arm64/kernel/image-vars.h                |   3 +
 arch/arm64/kernel/setup.c                     |   2 +-
 arch/arm64/kernel/vmlinux.lds.S               |  10 +
 arch/arm64/kvm/arm.c                          | 101 ++++--
 .../arm64/kvm/hyp/include/nvhe/trap_handler.h |  18 ++
 arch/arm64/kvm/hyp/nvhe/Makefile              |   3 +-
 arch/arm64/kvm/hyp/nvhe/host.S                |  47 +++
 arch/arm64/kvm/hyp/nvhe/hyp-init.S            |  97 +++++-
 arch/arm64/kvm/hyp/nvhe/hyp-main.c            |  45 ++-
 arch/arm64/kvm/hyp/nvhe/hyp-smp.c             |  40 +++
 arch/arm64/kvm/hyp/nvhe/hyp.lds.S             |   1 +
 arch/arm64/kvm/hyp/nvhe/psci-relay.c          | 296 ++++++++++++++++++
 arch/arm64/kvm/hyp/nvhe/switch.c              |   5 +-
 arch/arm64/kvm/va_layout.c                    |  30 +-
 arch/arm64/mm/proc.S                          |  15 +-
 drivers/firmware/psci/psci.c                  |  23 +-
 include/linux/psci.h                          |  10 +
 32 files changed, 999 insertions(+), 202 deletions(-)
 create mode 100644 arch/arm64/include/asm/el2_setup.h
 create mode 100644 arch/arm64/kvm/hyp/include/nvhe/trap_handler.h
 create mode 100644 arch/arm64/kvm/hyp/nvhe/hyp-smp.c
 create mode 100644 arch/arm64/kvm/hyp/nvhe/psci-relay.c

--
2.29.2.454.gaff20da3a2-goog
