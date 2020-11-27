Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0469F2C68A4
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 16:24:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731040AbgK0PV0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 10:21:26 -0500
Received: from foss.arm.com ([217.140.110.172]:44462 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726889AbgK0PV0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 10:21:26 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7499A1516;
        Fri, 27 Nov 2020 07:21:25 -0800 (PST)
Received: from e112269-lin.arm.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C9B463F70D;
        Fri, 27 Nov 2020 07:21:22 -0800 (PST)
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
Subject: [PATCH v6 0/2] MTE support for KVM guest
Date:   Fri, 27 Nov 2020 15:21:11 +0000
Message-Id: <20201127152113.13099-1-steven.price@arm.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's been a week, and I think the comments on v5 made it clear that
enforcing PROT_MTE requirements on the VMM was probably the wrong
approach. So since I've got swap working correctly without that I
thought I'd post a v6 which hopefully addresses all the comments so far.

This series adds support for Arm's Memory Tagging Extension (MTE) to
KVM, allowing KVM guests to make use of it. This builds on the existing
user space support already in v5.10-rc4, see [1] for an overview.

[1] https://lwn.net/Articles/834289/

Changes since v5[2]:

 * Revert back to not requiring the VMM to map all guest memory
   PROT_MTE. Instead KVM will set the PG_mte_tagged flag automatically
   if not present.

 * Fixed swap behaviour vs v4 by always checking for saved MTE tags for
   user entries in set_pte_at().

[2] https://lore.kernel.org/r/20201119153901.53705-1-steven.price%40arm.com

Steven Price (2):
  arm64: kvm: Save/restore MTE registers
  arm64: kvm: Introduce MTE VCPU feature

 arch/arm64/include/asm/kvm_emulate.h       |  3 +++
 arch/arm64/include/asm/kvm_host.h          |  8 ++++++++
 arch/arm64/include/asm/pgtable.h           |  2 +-
 arch/arm64/include/asm/sysreg.h            |  3 ++-
 arch/arm64/kernel/mte.c                    | 18 +++++++++++++-----
 arch/arm64/kvm/arm.c                       |  9 +++++++++
 arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h | 14 ++++++++++++++
 arch/arm64/kvm/mmu.c                       | 16 ++++++++++++++++
 arch/arm64/kvm/sys_regs.c                  | 20 +++++++++++++++-----
 include/uapi/linux/kvm.h                   |  1 +
 10 files changed, 82 insertions(+), 12 deletions(-)

-- 
2.20.1

