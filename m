Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A103529918A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 16:58:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1784584AbgJZP6N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 11:58:13 -0400
Received: from foss.arm.com ([217.140.110.172]:43202 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1784567AbgJZP5k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 11:57:40 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0E5F11042;
        Mon, 26 Oct 2020 08:57:40 -0700 (PDT)
Received: from e112269-lin.arm.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7EC673F719;
        Mon, 26 Oct 2020 08:57:37 -0700 (PDT)
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
Subject: [PATCH v4 0/2] MTE support for KVM guest
Date:   Mon, 26 Oct 2020 15:57:25 +0000
Message-Id: <20201026155727.36685-1-steven.price@arm.com>
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

Changes since v3[2]:

 * Rebased on v5.10-rc1 (required updating KVM_CAP number).

 * Clarified redundant test for system_supports_mte() with a comment.

 * Added Reviewed-by tags from Andrew - thanks!

[2] https://lore.kernel.org/r/20200925093607.3051-1-steven.price%40arm.com

Haibo plans to start looking at the QEMU support for this. I believe
what is in this series should be sufficient, but there is still some
concern that we need more kernel support for easily accessing the tags
for migrating the VM. I don't expect any extra support to change the
interfaces defined here, but rather build on them. My only reservation
would be whether we want to expose the KVM_CAP before everything is
ready.

Steven Price (2):
  arm64: kvm: Save/restore MTE registers
  arm64: kvm: Introduce MTE VCPU feature

 arch/arm64/include/asm/kvm_emulate.h       |  3 +++
 arch/arm64/include/asm/kvm_host.h          |  7 +++++++
 arch/arm64/include/asm/sysreg.h            |  3 ++-
 arch/arm64/kvm/arm.c                       |  9 +++++++++
 arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h | 14 ++++++++++++++
 arch/arm64/kvm/mmu.c                       | 20 ++++++++++++++++++++
 arch/arm64/kvm/sys_regs.c                  | 20 +++++++++++++++-----
 include/uapi/linux/kvm.h                   |  1 +
 8 files changed, 71 insertions(+), 6 deletions(-)

-- 
2.20.1

