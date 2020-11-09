Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05C5D2AB6D8
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 12:32:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729373AbgKILcm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 06:32:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729292AbgKILcl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 06:32:41 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47ABAC0613CF
        for <linux-kernel@vger.kernel.org>; Mon,  9 Nov 2020 03:32:41 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id p8so7502122wrx.5
        for <linux-kernel@vger.kernel.org>; Mon, 09 Nov 2020 03:32:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0ZRwpWqiRxh6H0dUE4gLBKSGk4q2tKmquRejIxcgxFE=;
        b=BXaNTDV/I9A+Ior9s2SMJWvnZvN3f8FvwZ1ZxGgerLSQJ8qM+G9dnZTuJ5gnntBYcR
         rWKHFep/4eNrOkmlVjA8KtaSh2Gr21go+Dw3Gmi2lI0FifKAi/4vV9liP2vmu7tjJNnn
         NyOmf0yW+IpfyKrLs0Co5BX0RysMtqmmLjKUI9rCTbqC7CFbQw8gNIMVwtNptBovLv01
         k1g/LGidp549GuxAnjb+9U/05zR1kXPz35KHPcnXQwJhkAxwsaGU5Vew0zxBbu2EafU5
         LdpHE2h6Lt2VJGGcnTNtcLes3yIYOhAktTFXJKztOm+cKRN/TZpG2qNyY/QMue+8cLYM
         3M8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0ZRwpWqiRxh6H0dUE4gLBKSGk4q2tKmquRejIxcgxFE=;
        b=nfhnjeSQzhYBNi8v3lhc9wXDq3yL1bQUxXq0Uw+aDUp0fTK/xUYI9ybL+zi6vASeCb
         srvu6vvze+43QNqsCjU9sYPkSYTjyz59iPOHtijPcMhkdaOEsePdW1cmb1keZu1woh65
         tIxIuKVfSSDiWIxexid0hQAM50i1a+snPcK8rDhflcjJ/te13ATbtLos2+oOWX5XdUpi
         pECdN/8iiZPRdCwR/u5h1bJTu7rVHkoO8H2XSIsCbZLJoJcZ6rJdJLZv5dfEniIHncdV
         f+shbLYbRawkaR1IUceujEQCp8ErITj0kwm3ZX4MXKQWVkaGRBZqzpfk7L4GgVEzStoJ
         dwJg==
X-Gm-Message-State: AOAM532gNiRtaFH7Icu3UiMyPZqIo5d3eJm4YCkQ6CgwY5winjfnCJ+d
        UeNOL5GUloB1ciqaTglXGaWMZg==
X-Google-Smtp-Source: ABdhPJzDsIAHjs/TbQ/3Gce0pr8CVqmGsBHIkcGYcAHffi2qKUhqIo5HkYvg7EyAu3nXBqwQxOkmfw==
X-Received: by 2002:adf:fe82:: with SMTP id l2mr12800711wrr.406.1604921559749;
        Mon, 09 Nov 2020 03:32:39 -0800 (PST)
Received: from localhost ([2a01:4b00:8523:2d03:209d:10b7:c480:3e1f])
        by smtp.gmail.com with ESMTPSA id s202sm12524126wme.39.2020.11.09.03.32.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Nov 2020 03:32:38 -0800 (PST)
From:   David Brazdil <dbrazdil@google.com>
To:     kvmarm@lists.cs.columbia.edu
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Dennis Zhou <dennis@kernel.org>,
        Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Quentin Perret <qperret@google.com>,
        Andrew Scull <ascull@google.com>,
        Andrew Walbran <qwandor@google.com>, kernel-team@android.com,
        David Brazdil <dbrazdil@google.com>
Subject: [PATCH v1 00/24] Opt-in always-on nVHE hypervisor
Date:   Mon,  9 Nov 2020 11:32:09 +0000
Message-Id: <20201109113233.9012-1-dbrazdil@google.com>
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
CPU_ON/OFF/SUSPEND calls. It replaces the host's entry point with its
own, initializes the EL2 state of the new CPU and installs the nVHE hyp
vector before ERETing to the host's entry point.

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

Tested on Rock Pi 4b, based on 5.10-rc3.

changes since rfc:
  * add early param to make features opt-in
  * simplify CPU_ON/SUSPEND implementation
  * replace spinlocks with CAS atomic
  * make cpu_logical_map ro_after_init

  -David

David Brazdil (24):
  psci: Accessor for configured PSCI version
  psci: Accessor for configured PSCI function IDs
  arm64: Move MAIR_EL1_SET to asm/memory.h
  kvm: arm64: Initialize MAIR_EL2 using a constant
  kvm: arm64: Add .hyp.data..ro_after_init ELF section
  kvm: arm64: Support per_cpu_ptr in nVHE hyp code
  kvm: arm64: Create nVHE copy of cpu_logical_map
  kvm: arm64: Move hyp-init params to a per-CPU struct
  kvm: arm64: Refactor handle_trap to use a switch
  kvm: arm64: Extract parts of el2_setup into a macro
  kvm: arm64: Add SMC handler in nVHE EL2
  kvm: arm64: Extract __do_hyp_init into a helper function
  kvm: arm64: Add CPU entry point in nVHE hyp
  kvm: arm64: Add function to enter host from KVM nVHE hyp code
  kvm: arm64: Bootstrap PSCI SMC handler in nVHE EL2
  kvm: arm64: Add offset for hyp VA <-> PA conversion
  kvm: arm64: Add __hyp_pa_symbol helper macro
  kvm: arm64: Forward safe PSCI SMCs coming from host
  kvm: arm64: Intercept host's PSCI_CPU_ON SMCs
  kvm: arm64: Intercept host's CPU_SUSPEND PSCI SMCs
  kvm: arm64: Add kvm-arm.protected early kernel parameter
  kvm: arm64: Keep nVHE EL2 vector installed
  kvm: arm64: Trap host SMCs in protected mode.
  kvm: arm64: Fix EL2 mode availability checks

 arch/arm64/include/asm/kvm_arm.h   |   1 +
 arch/arm64/include/asm/kvm_asm.h   | 136 ++++++++++++++
 arch/arm64/include/asm/kvm_hyp.h   |   9 +
 arch/arm64/include/asm/memory.h    |  13 ++
 arch/arm64/include/asm/percpu.h    |   6 +
 arch/arm64/include/asm/sections.h  |   1 +
 arch/arm64/include/asm/virt.h      |  26 +++
 arch/arm64/kernel/asm-offsets.c    |   5 +
 arch/arm64/kernel/head.S           | 140 ++------------
 arch/arm64/kernel/image-vars.h     |   7 +
 arch/arm64/kernel/vmlinux.lds.S    |  10 +
 arch/arm64/kvm/arm.c               | 157 ++++++++++++++--
 arch/arm64/kvm/hyp/nvhe/Makefile   |   3 +-
 arch/arm64/kvm/hyp/nvhe/host.S     |   9 +
 arch/arm64/kvm/hyp/nvhe/hyp-init.S |  84 +++++++--
 arch/arm64/kvm/hyp/nvhe/hyp-main.c |  56 +++++-
 arch/arm64/kvm/hyp/nvhe/hyp.lds.S  |   1 +
 arch/arm64/kvm/hyp/nvhe/percpu.c   |  38 ++++
 arch/arm64/kvm/hyp/nvhe/psci.c     | 291 +++++++++++++++++++++++++++++
 arch/arm64/kvm/hyp/nvhe/switch.c   |   5 +-
 arch/arm64/mm/proc.S               |  13 --
 drivers/firmware/psci/psci.c       |  25 ++-
 include/linux/psci.h               |  18 ++
 include/uapi/linux/psci.h          |   1 +
 24 files changed, 865 insertions(+), 190 deletions(-)
 create mode 100644 arch/arm64/kvm/hyp/nvhe/percpu.c
 create mode 100644 arch/arm64/kvm/hyp/nvhe/psci.c

-- 
2.29.2.222.g5d2a92d10f8-goog

