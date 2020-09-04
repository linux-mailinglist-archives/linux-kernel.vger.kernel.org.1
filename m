Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CAC525DEDD
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Sep 2020 18:01:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727877AbgIDQBR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Sep 2020 12:01:17 -0400
Received: from foss.arm.com ([217.140.110.172]:53260 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726789AbgIDQA1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 12:00:27 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2935E11B3;
        Fri,  4 Sep 2020 09:00:27 -0700 (PDT)
Received: from e112269-lin.arm.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AD76B3F66F;
        Fri,  4 Sep 2020 09:00:24 -0700 (PDT)
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
        Peter Maydell <Peter.Maydell@arm.com>,
        Haibo Xu <Haibo.Xu@arm.com>
Subject: [PATCH v2 0/2] MTE support for KVM guest
Date:   Fri,  4 Sep 2020 17:00:16 +0100
Message-Id: <20200904160018.29481-1-steven.price@arm.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arm's Memory Tagging Extension (MTE) adds 4 bits of tag data to every 16
bytes of memory in the system. This along with stashing a tag within the
high bit of virtual addresses allows runtime checking of memory
accesses.

These patches add support to KVM to enable MTE within a guest. They are
based on Catalin's v9 MTE user-space support series[1].

I'd welcome feedback on the proposed user-kernel ABI. Specifically this
series currently:

 1. Requires the VMM to enable MTE per-VCPU.
 2. Automatically promotes (normal host) memory given to the guest to be
    tag enabled (sets PG_mte_tagged), if any VCPU has MTE enabled. The
    tags are cleared if the memory wasn't previously MTE enabled.
 3. Doesn't provide any new methods for the VMM to access the tags on
    memory.

(2) and (3) are particularly interesting from the aspect of VM migration.
The guest is able to store/retrieve data in the tags (presumably for the
purpose of tag checking, but architecturally it could be used as just
storage). This means that when migrating a guest the data needs to be
transferred (or saved/restored).

MTE tags are controlled by the same permission model as normal pages
(i.e. a read-only page has read-only tags), so the normal methods of
detecting guest changes to pages can be used. But this would also
require the tags within a page to be migrated at the same time as the
data (since the access control for tags is the same as the normal data
within a page).

(3) may be problematic and I'd welcome input from those familiar with
VMMs. User space cannot access tags unless the memory is mapped with the
PROT_MTE flag. However enabling PROT_MTE will also enable tag checking
for the user space process (assuming the VMM enables tag checking for
the process) and since the tags in memory are controlled by the guest
it's unlikely the VMM would have an appropriately tagged pointer for its
access. This means the VMM would either need to maintain two mappings of
memory (one to access tags, the other to access data) or disable tag
checking during the accesses to data.

If it's not practical to either disable tag checking in the VMM or
maintain multiple mappings then the alternatives I'm aware of are:

 * Provide a KVM-specific method to extract the tags from guest memory.
   This might also have benefits in terms of providing an easy way to
   read bulk tag data from guest memory (since the LDGM instruction
   isn't available at EL0).
 * Provide support for user space setting the TCMA0 or TCMA1 bits in
   TCR_EL1. These would allow the VMM to generate pointers which are not
   tag checked.

Feedback is welcome, and feel free to ask questions if anything in the
above doesn't make sense.

Changes since the previous v1 posting[2]:

 * Rebasing clean-ups
 * sysreg visibility is now controlled based on whether the VCPU has MTE
   enabled or not

[1] https://lore.kernel.org/r/20200904103029.32083-1-catalin.marinas@arm.com
[2] https://lore.kernel.org/r/20200713100102.53664-1-steven.price%40arm.com

Steven Price (2):
  arm64: kvm: Save/restore MTE registers
  arm64: kvm: Introduce MTE VCPU feature

 arch/arm64/include/asm/kvm_emulate.h       |  3 +++
 arch/arm64/include/asm/kvm_host.h          |  9 ++++++++-
 arch/arm64/include/asm/sysreg.h            |  3 ++-
 arch/arm64/include/uapi/asm/kvm.h          |  1 +
 arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h | 14 ++++++++++++++
 arch/arm64/kvm/mmu.c                       | 15 +++++++++++++++
 arch/arm64/kvm/reset.c                     |  8 ++++++++
 arch/arm64/kvm/sys_regs.c                  | 20 +++++++++++++++-----
 8 files changed, 66 insertions(+), 7 deletions(-)

-- 
2.20.1

