Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3BB82B965C
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 16:40:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728531AbgKSPjK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 10:39:10 -0500
Received: from foss.arm.com ([217.140.110.172]:60854 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727758AbgKSPjK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 10:39:10 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A59AC1478;
        Thu, 19 Nov 2020 07:39:09 -0800 (PST)
Received: from e112269-lin.arm.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 03C5E3F719;
        Thu, 19 Nov 2020 07:39:06 -0800 (PST)
From:   Steven Price <steven.price@arm.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>
Cc:     Steven Price <steven.price@arm.com>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Dave Martin <Dave.Martin@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>, qemu-devel@nongnu.org,
        Juan Quintela <quintela@redhat.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        Peter Maydell <peter.maydell@linaro.org>,
        Haibo Xu <Haibo.Xu@arm.com>, Andrew Jones <drjones@redhat.com>
Subject: [PATCH v5 0/2] MTE support for KVM guest
Date:   Thu, 19 Nov 2020 15:38:59 +0000
Message-Id: <20201119153901.53705-1-steven.price@arm.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds support for Arm's Memory Tagging Extension (MTE) to
KVM, allowing KVM guests to make use of it. This builds on the existing
user space support already in v5.10-rc1, see [1] for an overview.

[1] https://lwn.net/Articles/834289/

Changes since v4[2]:

 * Rebased on v5.10-rc4.

 * Require the VMM to map all guest memory PROT_MTE if MTE is enabled
   for the guest.

 * Add a kvm_has_mte() accessor.

[2] http://lkml.kernel.org/r/20201026155727.36685-1-steven.price%40arm.com

The change to require the VMM to map all guest memory PROT_MTE is
significant as it means that the VMM has to deal with the MTE tags even
if it doesn't care about them (e.g. for virtual devices or if the VMM
doesn't support migration). Also unfortunately because the VMM can
change the memory layout at any time the check for PROT_MTE/VM_MTE has
to be done very late (at the point of faulting pages into stage 2).

The alternative would be to modify the set_pte_at() handler to always
check if there is MTE data relating to a swap page even if the PTE
doesn't have the MTE bit set. I haven't initially done this because of
ordering issues during early boot, but could investigate further if the
above VMM requirement is too strict.

Steven Price (2):
  arm64: kvm: Save/restore MTE registers
  arm64: kvm: Introduce MTE VCPU feature

 arch/arm64/include/asm/kvm_emulate.h       |  3 +++
 arch/arm64/include/asm/kvm_host.h          |  8 ++++++++
 arch/arm64/include/asm/sysreg.h            |  3 ++-
 arch/arm64/kvm/arm.c                       |  9 +++++++++
 arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h | 14 ++++++++++++++
 arch/arm64/kvm/mmu.c                       |  6 ++++++
 arch/arm64/kvm/sys_regs.c                  | 20 +++++++++++++++-----
 include/uapi/linux/kvm.h                   |  1 +
 8 files changed, 58 insertions(+), 6 deletions(-)

-- 
2.20.1

