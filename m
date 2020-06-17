Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C5911FCD8E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jun 2020 14:39:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726688AbgFQMjY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Jun 2020 08:39:24 -0400
Received: from foss.arm.com ([217.140.110.172]:57150 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725860AbgFQMjX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 08:39:23 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CA0781045;
        Wed, 17 Jun 2020 05:39:20 -0700 (PDT)
Received: from e112269-lin.arm.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 078483F71F;
        Wed, 17 Jun 2020 05:39:18 -0700 (PDT)
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
        Thomas Gleixner <tglx@linutronix.de>
Subject: [RFC PATCH 0/2] MTE support for KVM guest
Date:   Wed, 17 Jun 2020 13:38:42 +0100
Message-Id: <20200617123844.29960-1-steven.price@arm.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These patches add support to KVM to enable MTE within a guest. It is
based on Catalin's v4 MTE user space series[1].

[1] http://lkml.kernel.org/r/20200515171612.1020-1-catalin.marinas%40arm.com

Posting as an RFC as I'd like feedback on the approach taken. First a
little background on how MTE fits within the architecture:

The stage 2 page tables have limited scope for controlling the
availability of MTE. If a page is mapped as Normal and cached in stage 2
then it's the stage 1 tables that get to choose whether the memory is
tagged or not. So the only way of forbidding tags on a page from the
hypervisor is to change the cacheability (or make it device memory)
which would cause other problems.  Note this restriction fits the
intention that a system should have all (general purpose) memory
supporting tags if it support MTE, so it's not too surprising.

However, the upshot of this is that to enable MTE within a guest all
pages of memory mapped into the guest as normal cached pages in stage 2
*must* support MTE (i.e. we must ensure the tags are appropriately
sanitised and save/restore the tags during swap etc).

My current approach is that KVM transparently upgrades any pages
provided by the VMM to be tag-enabled when they are faulted in (i.e.
sets the PG_mte_tagged flag on the page) which has the benefit of
requiring fewer changes in the VMM. However, save/restore of the VM
state still requires the VMM to have a PROT_MTE enabled mapping so that
it can access the tag values. A VMM which 'forgets' to enable PROT_MTE
would lose the tag values when saving/restoring (tags are RAZ/WI when
PROT_MTE isn't set).

An alternative approach would be to enforce the VMM provides PROT_MTE
memory in the first place. This seems appealing to prevent the above
potentially unexpected gotchas with save/restore, however this would
also extend to memory that you might not expect to have PROT_MTE (e.g. a
shared frame buffer for an emulated graphics card). 

Comments on the approach (or ideas for alternative approaches) are very
welcome.

Steven Price (2):
  arm64: kvm: Save/restore MTE registers
  arm64: kvm: Introduce MTE VCPU feature

 arch/arm64/include/asm/kvm_emulate.h |  3 +++
 arch/arm64/include/asm/kvm_host.h    |  9 ++++++++-
 arch/arm64/include/uapi/asm/kvm.h    |  1 +
 arch/arm64/kvm/hyp/sysreg-sr.c       | 12 ++++++++++++
 arch/arm64/kvm/reset.c               |  8 ++++++++
 arch/arm64/kvm/sys_regs.c            |  8 ++++++++
 virt/kvm/arm/mmu.c                   | 11 +++++++++++
 7 files changed, 51 insertions(+), 1 deletion(-)

-- 
2.20.1

