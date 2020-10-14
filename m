Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8BCB28E643
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 20:27:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388453AbgJNS1P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 14:27:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388112AbgJNS1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 14:27:10 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4183EC0613D6
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 11:27:10 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id h20so73266plr.9
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 11:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=PzIR+EOh/unf0NU1aPgGvKEmZudPmqlf31mWPtYkVEU=;
        b=SLHFxfklstQR4pen4l7RRE7SamkB/oxdWYCdNd1cIZ5z7Fi8sOUFfSj+Az6RSOS0G5
         P9QhAqV3T1gBOhE8urco8dRVODvYEcJd8xp/MpQJxJ4xlFd/3EGZVIrh3atdZ+BEuK2z
         2kGT6VjBOnrYdF7iB+hRuIVJuAiaJcZs9gFex/2jZZJ2oxhI/V8w89n5Go/pisG8H4R+
         F5dl1aV6xir2B7jxCOlvNI5mV0cO8vRKv5FdJSM0ivucolW7xHqCeNtti30zWoGtZFg3
         dIrX9ZvIREB563k/eemtEBgm6EJQsPkKQes3cOzEFSneJzBnH4PjGayPzwwxeqdVzHKq
         MP3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=PzIR+EOh/unf0NU1aPgGvKEmZudPmqlf31mWPtYkVEU=;
        b=UTp6DIT0k9eNuG5Fv5/qsjbP9QZES7FpFKJWeVz4tW1ICc5WHg7ax0iKgsl3yu16rO
         mTGvjP9mLqb2ey//zmWMBWPgaRKkCVdOvR4EQ2yAKwvRlKAO3uBLiTqk9IKz4o7kTd+Z
         uYcVrzPjFd90mmVkeFOX3n5Qvpnv25HnOiQCvGvRjair+de8Ryk0tadSFDA1LiBIVInI
         9q6QWjbonIt4cqAqmLR2w5XKeovmu356s39iHWMTJXny7yrYIwJFxbY0HkzkLFsWkC2j
         0jxngmOdhwBADwmSMhoypb7Bc+tfBZOgtQlwNcL14BKleyHwXLj6+Krut1MjAHwTrOAr
         3D2A==
X-Gm-Message-State: AOAM533r1rBkIIsOzFdAnAdG70sJ+sBUnOG+MxyGm/2u4ST10gC7RzZQ
        Telpm1lNhQHSRIPT6QiBEjeV5UIFiIUC1RvbmaLg4tJnQ9NPpaoblnu9+cQAr3SV1XjSQOhhpmP
        nRtixrIH0rxIx6dliUy+EIwNZS1eLFudy8kNDeMha3Cz2zXfGU/Pqk/NfrZe92fpqxbnMixI/
X-Google-Smtp-Source: ABdhPJzPFxHNlrphi/IM33kezXuNfCffMAGt262orHLd0qa33LMT1aK1wrJKTwkkfLgE1hX4WUkSeTTp+BGA
Sender: "bgardon via sendgmr" <bgardon@bgardon.sea.corp.google.com>
X-Received: from bgardon.sea.corp.google.com ([2620:15c:100:202:f693:9fff:fef4:a293])
 (user=bgardon job=sendgmr) by 2002:a17:902:7884:b029:d3:7817:ed58 with SMTP
 id q4-20020a1709027884b02900d37817ed58mr692291pll.14.1602700029486; Wed, 14
 Oct 2020 11:27:09 -0700 (PDT)
Date:   Wed, 14 Oct 2020 11:26:43 -0700
In-Reply-To: <20201014182700.2888246-1-bgardon@google.com>
Message-Id: <20201014182700.2888246-4-bgardon@google.com>
Mime-Version: 1.0
References: <20201014182700.2888246-1-bgardon@google.com>
X-Mailer: git-send-email 2.28.0.1011.ga647a8990f-goog
Subject: [PATCH v2 03/20] kvm: x86/mmu: Init / Uninit the TDP MMU
From:   Ben Gardon <bgardon@google.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Cannon Matthews <cannonmatthews@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Peter Shier <pshier@google.com>,
        Peter Feiner <pfeiner@google.com>,
        Junaid Shahid <junaids@google.com>,
        Jim Mattson <jmattson@google.com>,
        Yulei Zhang <yulei.kernel@gmail.com>,
        Wanpeng Li <kernellwp@gmail.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
        Ben Gardon <bgardon@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The TDP MMU offers an alternative mode of operation to the x86 shadow
paging based MMU, optimized for running an L1 guest with TDP. The TDP MMU
will require new fields that need to be initialized and torn down. Add
hooks into the existing KVM MMU initialization process to do that
initialization / cleanup. Currently the initialization and cleanup
fucntions do not do very much, however more operations will be added in
future patches.

Tested by running kvm-unit-tests and KVM selftests on an Intel Haswell
machine. This series introduced no new failures.

This series can be viewed in Gerrit at:
	https://linux-review.googlesource.com/c/virt/kvm/kvm/+/2538

Signed-off-by: Ben Gardon <bgardon@google.com>
---
 arch/x86/include/asm/kvm_host.h |  9 ++++++++
 arch/x86/kvm/Makefile           |  2 +-
 arch/x86/kvm/mmu/mmu.c          |  5 +++++
 arch/x86/kvm/mmu/tdp_mmu.c      | 38 +++++++++++++++++++++++++++++++++
 arch/x86/kvm/mmu/tdp_mmu.h      | 10 +++++++++
 5 files changed, 63 insertions(+), 1 deletion(-)
 create mode 100644 arch/x86/kvm/mmu/tdp_mmu.c
 create mode 100644 arch/x86/kvm/mmu/tdp_mmu.h

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index d0f77235da923..6b6dbc20ce23a 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -980,6 +980,15 @@ struct kvm_arch {
 
 	struct kvm_pmu_event_filter *pmu_event_filter;
 	struct task_struct *nx_lpage_recovery_thread;
+
+	/*
+	 * Whether the TDP MMU is enabled for this VM. This contains a
+	 * snapshot of the TDP MMU module parameter from when the VM was
+	 * created and remains unchanged for the life of the VM. If this is
+	 * true, TDP MMU handler functions will run for various MMU
+	 * operations.
+	 */
+	bool tdp_mmu_enabled;
 };
 
 struct kvm_vm_stat {
diff --git a/arch/x86/kvm/Makefile b/arch/x86/kvm/Makefile
index 4525c1151bf99..fd6b1b0cc27c0 100644
--- a/arch/x86/kvm/Makefile
+++ b/arch/x86/kvm/Makefile
@@ -16,7 +16,7 @@ kvm-$(CONFIG_KVM_ASYNC_PF)	+= $(KVM)/async_pf.o
 kvm-y			+= x86.o emulate.o i8259.o irq.o lapic.o \
 			   i8254.o ioapic.o irq_comm.o cpuid.o pmu.o mtrr.o \
 			   hyperv.o debugfs.o mmu/mmu.o mmu/page_track.o \
-			   mmu/tdp_iter.o
+			   mmu/tdp_iter.o mmu/tdp_mmu.o
 
 kvm-intel-y		+= vmx/vmx.o vmx/vmenter.o vmx/pmu_intel.o vmx/vmcs12.o \
 			   vmx/evmcs.o vmx/nested.o vmx/posted_intr.o
diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 6d82784ed5679..f53d29e09367c 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -19,6 +19,7 @@
 #include "ioapic.h"
 #include "mmu.h"
 #include "mmu_internal.h"
+#include "tdp_mmu.h"
 #include "x86.h"
 #include "kvm_cache_regs.h"
 #include "kvm_emulate.h"
@@ -5833,6 +5834,8 @@ void kvm_mmu_init_vm(struct kvm *kvm)
 {
 	struct kvm_page_track_notifier_node *node = &kvm->arch.mmu_sp_tracker;
 
+	kvm_mmu_init_tdp_mmu(kvm);
+
 	node->track_write = kvm_mmu_pte_write;
 	node->track_flush_slot = kvm_mmu_invalidate_zap_pages_in_memslot;
 	kvm_page_track_register_notifier(kvm, node);
@@ -5843,6 +5846,8 @@ void kvm_mmu_uninit_vm(struct kvm *kvm)
 	struct kvm_page_track_notifier_node *node = &kvm->arch.mmu_sp_tracker;
 
 	kvm_page_track_unregister_notifier(kvm, node);
+
+	kvm_mmu_uninit_tdp_mmu(kvm);
 }
 
 void kvm_zap_gfn_range(struct kvm *kvm, gfn_t gfn_start, gfn_t gfn_end)
diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
new file mode 100644
index 0000000000000..b3809835e90b1
--- /dev/null
+++ b/arch/x86/kvm/mmu/tdp_mmu.c
@@ -0,0 +1,38 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "tdp_mmu.h"
+
+static bool __read_mostly tdp_mmu_enabled = false;
+
+static bool is_tdp_mmu_enabled(void)
+{
+#ifdef CONFIG_X86_64
+	if (!READ_ONCE(tdp_mmu_enabled))
+		return false;
+
+	if (WARN_ONCE(!tdp_enabled,
+		      "Creating a VM with TDP MMU enabled requires TDP."))
+		return false;
+
+	return true;
+
+#else
+	return false;
+#endif /* CONFIG_X86_64 */
+}
+
+/* Initializes the TDP MMU for the VM, if enabled. */
+void kvm_mmu_init_tdp_mmu(struct kvm *kvm)
+{
+	if (!is_tdp_mmu_enabled())
+		return;
+
+	/* This should not be changed for the lifetime of the VM. */
+	kvm->arch.tdp_mmu_enabled = true;
+}
+
+void kvm_mmu_uninit_tdp_mmu(struct kvm *kvm)
+{
+	if (!kvm->arch.tdp_mmu_enabled)
+		return;
+}
diff --git a/arch/x86/kvm/mmu/tdp_mmu.h b/arch/x86/kvm/mmu/tdp_mmu.h
new file mode 100644
index 0000000000000..cd4a562a70e9a
--- /dev/null
+++ b/arch/x86/kvm/mmu/tdp_mmu.h
@@ -0,0 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#ifndef __KVM_X86_MMU_TDP_MMU_H
+#define __KVM_X86_MMU_TDP_MMU_H
+
+#include <linux/kvm_host.h>
+
+void kvm_mmu_init_tdp_mmu(struct kvm *kvm);
+void kvm_mmu_uninit_tdp_mmu(struct kvm *kvm);
+#endif /* __KVM_X86_MMU_TDP_MMU_H */
-- 
2.28.0.1011.ga647a8990f-goog

