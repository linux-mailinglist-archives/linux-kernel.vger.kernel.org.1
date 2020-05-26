Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B753B1D4BF5
	for <lists+linux-kernel@lfdr.de>; Fri, 15 May 2020 13:00:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726362AbgEOK7t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 May 2020 06:59:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726283AbgEOK7H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 06:59:07 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 029A9C061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 03:59:07 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id i15so2978327wrx.10
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 03:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tabIxhAS7YNuq5iCO/oFZ2hYhqRnLr3yUyNvBgRfCZI=;
        b=Cv2Z3CuGJLkWoPoCimitXSrNUULHZxg1cIHDIbhkX9ythTDj6NPfhsSKwZfQMAad7R
         G8L8qGHU2YdJSJs0vMwW0bHciNFnynqNqifp9zUqPK8jvxI0+FrCWHWLl5GKZ7kiQuq+
         2Ct0mAyOeRk7Vfi+KB2MVlbHyKMLXAwB8AWaY6jx/tMnkkYy6Jqr6RwcPTT6lEsSuBdU
         d0Ytjdh5mz9lTlZep52k8KAq+aey6p69CRiy2wcG3bQxAm7g7uempDZEOngS+LaLfWxO
         xXWJbeoD+BxMKhWq98ygvo2MJK3RfqowrM2Z7UEr1SpDAIhXDcpirBfCPfxNAVQnQPH5
         fm6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tabIxhAS7YNuq5iCO/oFZ2hYhqRnLr3yUyNvBgRfCZI=;
        b=D9Ira+OdvcsWqYD0VlF2FShyOJLBuypdCE3i6OEpZOxjTAvKVc12B2P4op5PIahp4h
         XfSIctGL8+GM8Ka7cTHUOF6qLtdtWI21BmOQhmtTQSA4FHXPgzJ5MELH8qxy7Llpyp2p
         yBYFXJtXiceESqMCrCO0zxcfNK+3KdaC7XfBx9+Fr98WL8d87Dbcg1OE8OO9IhE0FPey
         mfegukg3Rs6J/yscccy0CiTISlKCzAQ/bgyM83/LLX9G+gqrhGWMkzITq03joImLocQv
         pMDJZOmd6KMJN3na4ltxKrD06LoLz2N7B8KlXMKnJQCPcTZKh18Zk+bWI/V9qqOHSm3p
         KxMg==
X-Gm-Message-State: AOAM5317wmyBx6CQNWHRcHHjV++9GjHBbrbcOTIuenNfitIWnQUoToBg
        Ej7XznNWITk2UVS8nw4H43spHQ==
X-Google-Smtp-Source: ABdhPJxZuvOZCjCg1QHmgjP/CO6h4HqfQEUTFoOeBq82tqx37xijcHNEIVHnSkTzffpIwQpq9a0jhQ==
X-Received: by 2002:adf:8403:: with SMTP id 3mr3511259wrf.186.1589540345053;
        Fri, 15 May 2020 03:59:05 -0700 (PDT)
Received: from localhost ([2a01:4b00:8523:2d03:d11b:f847:8002:7411])
        by smtp.gmail.com with ESMTPSA id p10sm3072695wrn.10.2020.05.15.03.59.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 May 2020 03:59:04 -0700 (PDT)
From:   David Brazdil <dbrazdil@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Marc Zyngier <maz@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, David Brazdil <dbrazdil@google.com>
Subject: [PATCH v2 06/14] arm64: kvm: Split hyp/tlb.c to VHE/nVHE
Date:   Fri, 15 May 2020 11:58:33 +0100
Message-Id: <20200515105841.73532-7-dbrazdil@google.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200515105841.73532-1-dbrazdil@google.com>
References: <20200515105841.73532-1-dbrazdil@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is part of a series which builds KVM's non-VHE hyp code separately
from VHE and the rest of the kernel.

tlb.c contains code for flushing the TLB, with parts shared between VHE/nVHE.
These common routines are moved into a header file tlb.h, VHE-specific code
remains in tlb.c and nVHE-specific code is moved to nvhe/tlb.c.

The header file expects its users to implement two helper functions declared
at the top of the file.

Signed-off-by: David Brazdil <dbrazdil@google.com>
---
 arch/arm64/kernel/image-vars.h   |   8 +-
 arch/arm64/kvm/hyp/nvhe/Makefile |   2 +-
 arch/arm64/kvm/hyp/nvhe/tlb.c    |  69 +++++++++++++
 arch/arm64/kvm/hyp/tlb.c         | 170 +++----------------------------
 arch/arm64/kvm/hyp/tlb.h         | 134 ++++++++++++++++++++++++
 5 files changed, 221 insertions(+), 162 deletions(-)
 create mode 100644 arch/arm64/kvm/hyp/nvhe/tlb.c
 create mode 100644 arch/arm64/kvm/hyp/tlb.h

diff --git a/arch/arm64/kernel/image-vars.h b/arch/arm64/kernel/image-vars.h
index dc9c14d91d39..7cafa0266847 100644
--- a/arch/arm64/kernel/image-vars.h
+++ b/arch/arm64/kernel/image-vars.h
@@ -62,14 +62,11 @@ __efistub__ctype		= _ctype;
  */
 
 __kvm_nvhe___guest_exit = __guest_exit;
+__kvm_nvhe___icache_flags = __icache_flags;
 __kvm_nvhe___kvm_enable_ssbs = __kvm_enable_ssbs;
-__kvm_nvhe___kvm_flush_vm_context = __kvm_flush_vm_context;
 __kvm_nvhe___kvm_get_mdcr_el2 = __kvm_get_mdcr_el2;
 __kvm_nvhe___kvm_handle_stub_hvc = __kvm_handle_stub_hvc;
 __kvm_nvhe___kvm_timer_set_cntvoff = __kvm_timer_set_cntvoff;
-__kvm_nvhe___kvm_tlb_flush_local_vmid = __kvm_tlb_flush_local_vmid;
-__kvm_nvhe___kvm_tlb_flush_vmid = __kvm_tlb_flush_vmid;
-__kvm_nvhe___kvm_tlb_flush_vmid_ipa = __kvm_tlb_flush_vmid_ipa;
 __kvm_nvhe___kvm_vcpu_run_nvhe = __kvm_vcpu_run_nvhe;
 __kvm_nvhe___vgic_v3_get_ich_vtr_el2 = __vgic_v3_get_ich_vtr_el2;
 __kvm_nvhe___vgic_v3_init_lrs = __vgic_v3_init_lrs;
@@ -79,8 +76,11 @@ __kvm_nvhe___vgic_v3_save_aprs = __vgic_v3_save_aprs;
 __kvm_nvhe___vgic_v3_write_vmcr = __vgic_v3_write_vmcr;
 __kvm_nvhe_abort_guest_exit_end = abort_guest_exit_end;
 __kvm_nvhe_abort_guest_exit_start = abort_guest_exit_start;
+__kvm_nvhe_arm64_const_caps_ready = arm64_const_caps_ready;
 __kvm_nvhe_arm64_enable_wa2_handling = arm64_enable_wa2_handling;
 __kvm_nvhe_arm64_ssbd_callback_required = arm64_ssbd_callback_required;
+__kvm_nvhe_cpu_hwcap_keys = cpu_hwcap_keys;
+__kvm_nvhe_cpu_hwcaps = cpu_hwcaps;
 __kvm_nvhe_hyp_panic = hyp_panic;
 __kvm_nvhe_kimage_voffset = kimage_voffset;
 __kvm_nvhe_kvm_host_data = kvm_host_data;
diff --git a/arch/arm64/kvm/hyp/nvhe/Makefile b/arch/arm64/kvm/hyp/nvhe/Makefile
index c68801e24950..bed7260097f5 100644
--- a/arch/arm64/kvm/hyp/nvhe/Makefile
+++ b/arch/arm64/kvm/hyp/nvhe/Makefile
@@ -7,7 +7,7 @@ asflags-y := -D__KVM_NVHE_HYPERVISOR__
 ccflags-y := -D__KVM_NVHE_HYPERVISOR__ -fno-stack-protector \
 	     -DDISABLE_BRANCH_PROFILING $(DISABLE_STACKLEAK_PLUGIN)
 
-obj-y := ../hyp-entry.o
+obj-y := tlb.o ../hyp-entry.o
 
 obj-y := $(patsubst %.o,%.hyp.o,$(obj-y))
 extra-y := $(patsubst %.hyp.o,%.hyp.tmp.o,$(obj-y))
diff --git a/arch/arm64/kvm/hyp/nvhe/tlb.c b/arch/arm64/kvm/hyp/nvhe/tlb.c
new file mode 100644
index 000000000000..1b8f4000f98c
--- /dev/null
+++ b/arch/arm64/kvm/hyp/nvhe/tlb.c
@@ -0,0 +1,69 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2015 - ARM Ltd
+ * Author: Marc Zyngier <marc.zyngier@arm.com>
+ */
+
+#include <linux/irqflags.h>
+
+#include <asm/kvm_hyp.h>
+#include <asm/kvm_mmu.h>
+#include <asm/tlbflush.h>
+
+#include "../tlb.h"
+
+static void __hyp_text __tlb_switch_to_guest(struct kvm *kvm,
+					     struct tlb_inv_context *cxt)
+{
+	if (cpus_have_final_cap(ARM64_WORKAROUND_SPECULATIVE_AT_NVHE)) {
+		u64 val;
+
+		/*
+		 * For CPUs that are affected by ARM 1319367, we need to
+		 * avoid a host Stage-1 walk while we have the guest's
+		 * VMID set in the VTTBR in order to invalidate TLBs.
+		 * We're guaranteed that the S1 MMU is enabled, so we can
+		 * simply set the EPD bits to avoid any further TLB fill.
+		 */
+		val = cxt->tcr = read_sysreg_el1(SYS_TCR);
+		val |= TCR_EPD1_MASK | TCR_EPD0_MASK;
+		write_sysreg_el1(val, SYS_TCR);
+		isb();
+	}
+
+	__load_guest_stage2(kvm);
+	isb();
+}
+
+static void __hyp_text __tlb_switch_to_host(struct kvm *kvm,
+					    struct tlb_inv_context *cxt)
+{
+	write_sysreg(0, vttbr_el2);
+
+	if (cpus_have_final_cap(ARM64_WORKAROUND_SPECULATIVE_AT_NVHE)) {
+		/* Ensure write of the host VMID */
+		isb();
+		/* Restore the host's TCR_EL1 */
+		write_sysreg_el1(cxt->tcr, SYS_TCR);
+	}
+}
+
+void __hyp_text __kvm_tlb_flush_vmid_ipa(struct kvm *kvm, phys_addr_t ipa)
+{
+	__tlb_flush_vmid_ipa(kvm, ipa);
+}
+
+void __hyp_text __kvm_tlb_flush_vmid(struct kvm *kvm)
+{
+	__tlb_flush_vmid(kvm);
+}
+
+void __hyp_text __kvm_tlb_flush_local_vmid(struct kvm_vcpu *vcpu)
+{
+	__tlb_flush_local_vmid(vcpu);
+}
+
+void __hyp_text __kvm_flush_vm_context(void)
+{
+	__tlb_flush_vm_context();
+}
diff --git a/arch/arm64/kvm/hyp/tlb.c b/arch/arm64/kvm/hyp/tlb.c
index ceaddbe4279f..ab55b0c4a80c 100644
--- a/arch/arm64/kvm/hyp/tlb.c
+++ b/arch/arm64/kvm/hyp/tlb.c
@@ -10,14 +10,10 @@
 #include <asm/kvm_mmu.h>
 #include <asm/tlbflush.h>
 
-struct tlb_inv_context {
-	unsigned long	flags;
-	u64		tcr;
-	u64		sctlr;
-};
+#include "tlb.h"
 
-static void __hyp_text __tlb_switch_to_guest_vhe(struct kvm *kvm,
-						 struct tlb_inv_context *cxt)
+static void __hyp_text __tlb_switch_to_guest(struct kvm *kvm,
+					     struct tlb_inv_context *cxt)
 {
 	u64 val;
 
@@ -60,40 +56,8 @@ static void __hyp_text __tlb_switch_to_guest_vhe(struct kvm *kvm,
 	isb();
 }
 
-static void __hyp_text __tlb_switch_to_guest_nvhe(struct kvm *kvm,
-						  struct tlb_inv_context *cxt)
-{
-	if (cpus_have_final_cap(ARM64_WORKAROUND_SPECULATIVE_AT_NVHE)) {
-		u64 val;
-
-		/*
-		 * For CPUs that are affected by ARM 1319367, we need to
-		 * avoid a host Stage-1 walk while we have the guest's
-		 * VMID set in the VTTBR in order to invalidate TLBs.
-		 * We're guaranteed that the S1 MMU is enabled, so we can
-		 * simply set the EPD bits to avoid any further TLB fill.
-		 */
-		val = cxt->tcr = read_sysreg_el1(SYS_TCR);
-		val |= TCR_EPD1_MASK | TCR_EPD0_MASK;
-		write_sysreg_el1(val, SYS_TCR);
-		isb();
-	}
-
-	__load_guest_stage2(kvm);
-	isb();
-}
-
-static void __hyp_text __tlb_switch_to_guest(struct kvm *kvm,
-					     struct tlb_inv_context *cxt)
-{
-	if (has_vhe())
-		__tlb_switch_to_guest_vhe(kvm, cxt);
-	else
-		__tlb_switch_to_guest_nvhe(kvm, cxt);
-}
-
-static void __hyp_text __tlb_switch_to_host_vhe(struct kvm *kvm,
-						struct tlb_inv_context *cxt)
+static void __hyp_text __tlb_switch_to_host(struct kvm *kvm,
+					    struct tlb_inv_context *cxt)
 {
 	/*
 	 * We're done with the TLB operation, let's restore the host's
@@ -112,130 +76,22 @@ static void __hyp_text __tlb_switch_to_host_vhe(struct kvm *kvm,
 	local_irq_restore(cxt->flags);
 }
 
-static void __hyp_text __tlb_switch_to_host_nvhe(struct kvm *kvm,
-						 struct tlb_inv_context *cxt)
+void __kvm_tlb_flush_vmid_ipa(struct kvm *kvm, phys_addr_t ipa)
 {
-	write_sysreg(0, vttbr_el2);
-
-	if (cpus_have_final_cap(ARM64_WORKAROUND_SPECULATIVE_AT_NVHE)) {
-		/* Ensure write of the host VMID */
-		isb();
-		/* Restore the host's TCR_EL1 */
-		write_sysreg_el1(cxt->tcr, SYS_TCR);
-	}
+	__tlb_flush_vmid_ipa(kvm, ipa);
 }
 
-static void __hyp_text __tlb_switch_to_host(struct kvm *kvm,
-					    struct tlb_inv_context *cxt)
+void __kvm_tlb_flush_vmid(struct kvm *kvm)
 {
-	if (has_vhe())
-		__tlb_switch_to_host_vhe(kvm, cxt);
-	else
-		__tlb_switch_to_host_nvhe(kvm, cxt);
+	__tlb_flush_vmid(kvm);
 }
 
-void __hyp_text __kvm_tlb_flush_vmid_ipa(struct kvm *kvm, phys_addr_t ipa)
+void __kvm_tlb_flush_local_vmid(struct kvm_vcpu *vcpu)
 {
-	struct tlb_inv_context cxt;
-
-	dsb(ishst);
-
-	/* Switch to requested VMID */
-	kvm = kern_hyp_va(kvm);
-	__tlb_switch_to_guest(kvm, &cxt);
-
-	/*
-	 * We could do so much better if we had the VA as well.
-	 * Instead, we invalidate Stage-2 for this IPA, and the
-	 * whole of Stage-1. Weep...
-	 */
-	ipa >>= 12;
-	__tlbi(ipas2e1is, ipa);
-
-	/*
-	 * We have to ensure completion of the invalidation at Stage-2,
-	 * since a table walk on another CPU could refill a TLB with a
-	 * complete (S1 + S2) walk based on the old Stage-2 mapping if
-	 * the Stage-1 invalidation happened first.
-	 */
-	dsb(ish);
-	__tlbi(vmalle1is);
-	dsb(ish);
-	isb();
-
-	/*
-	 * If the host is running at EL1 and we have a VPIPT I-cache,
-	 * then we must perform I-cache maintenance at EL2 in order for
-	 * it to have an effect on the guest. Since the guest cannot hit
-	 * I-cache lines allocated with a different VMID, we don't need
-	 * to worry about junk out of guest reset (we nuke the I-cache on
-	 * VMID rollover), but we do need to be careful when remapping
-	 * executable pages for the same guest. This can happen when KSM
-	 * takes a CoW fault on an executable page, copies the page into
-	 * a page that was previously mapped in the guest and then needs
-	 * to invalidate the guest view of the I-cache for that page
-	 * from EL1. To solve this, we invalidate the entire I-cache when
-	 * unmapping a page from a guest if we have a VPIPT I-cache but
-	 * the host is running at EL1. As above, we could do better if
-	 * we had the VA.
-	 *
-	 * The moral of this story is: if you have a VPIPT I-cache, then
-	 * you should be running with VHE enabled.
-	 */
-	if (!has_vhe() && icache_is_vpipt())
-		__flush_icache_all();
-
-	__tlb_switch_to_host(kvm, &cxt);
+	__tlb_flush_local_vmid(vcpu);
 }
 
-void __hyp_text __kvm_tlb_flush_vmid(struct kvm *kvm)
+void __kvm_flush_vm_context(void)
 {
-	struct tlb_inv_context cxt;
-
-	dsb(ishst);
-
-	/* Switch to requested VMID */
-	kvm = kern_hyp_va(kvm);
-	__tlb_switch_to_guest(kvm, &cxt);
-
-	__tlbi(vmalls12e1is);
-	dsb(ish);
-	isb();
-
-	__tlb_switch_to_host(kvm, &cxt);
-}
-
-void __hyp_text __kvm_tlb_flush_local_vmid(struct kvm_vcpu *vcpu)
-{
-	struct kvm *kvm = kern_hyp_va(kern_hyp_va(vcpu)->kvm);
-	struct tlb_inv_context cxt;
-
-	/* Switch to requested VMID */
-	__tlb_switch_to_guest(kvm, &cxt);
-
-	__tlbi(vmalle1);
-	dsb(nsh);
-	isb();
-
-	__tlb_switch_to_host(kvm, &cxt);
-}
-
-void __hyp_text __kvm_flush_vm_context(void)
-{
-	dsb(ishst);
-	__tlbi(alle1is);
-
-	/*
-	 * VIPT and PIPT caches are not affected by VMID, so no maintenance
-	 * is necessary across a VMID rollover.
-	 *
-	 * VPIPT caches constrain lookup and maintenance to the active VMID,
-	 * so we need to invalidate lines with a stale VMID to avoid an ABA
-	 * race after multiple rollovers.
-	 *
-	 */
-	if (icache_is_vpipt())
-		asm volatile("ic ialluis");
-
-	dsb(ish);
+	__tlb_flush_vm_context();
 }
diff --git a/arch/arm64/kvm/hyp/tlb.h b/arch/arm64/kvm/hyp/tlb.h
new file mode 100644
index 000000000000..841ef400c8ec
--- /dev/null
+++ b/arch/arm64/kvm/hyp/tlb.h
@@ -0,0 +1,134 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2015 - ARM Ltd
+ * Author: Marc Zyngier <marc.zyngier@arm.com>
+ */
+
+#ifndef __ARM64_KVM_HYP_TLB_H__
+#define __ARM64_KVM_HYP_TLB_H__
+
+#include <linux/irqflags.h>
+
+#include <asm/kvm_hyp.h>
+#include <asm/kvm_mmu.h>
+#include <asm/tlbflush.h>
+
+struct tlb_inv_context {
+	unsigned long	flags;
+	u64		tcr;
+	u64		sctlr;
+};
+
+static void __hyp_text __tlb_switch_to_guest(struct kvm *kvm,
+					     struct tlb_inv_context *cxt);
+static void __hyp_text __tlb_switch_to_host(struct kvm *kvm,
+					    struct tlb_inv_context *cxt);
+
+static inline void __hyp_text
+__tlb_flush_vmid_ipa(struct kvm *kvm, phys_addr_t ipa)
+{
+	struct tlb_inv_context cxt;
+
+	dsb(ishst);
+
+	/* Switch to requested VMID */
+	kvm = kern_hyp_va(kvm);
+	__tlb_switch_to_guest(kvm, &cxt);
+
+	/*
+	 * We could do so much better if we had the VA as well.
+	 * Instead, we invalidate Stage-2 for this IPA, and the
+	 * whole of Stage-1. Weep...
+	 */
+	ipa >>= 12;
+	__tlbi(ipas2e1is, ipa);
+
+	/*
+	 * We have to ensure completion of the invalidation at Stage-2,
+	 * since a table walk on another CPU could refill a TLB with a
+	 * complete (S1 + S2) walk based on the old Stage-2 mapping if
+	 * the Stage-1 invalidation happened first.
+	 */
+	dsb(ish);
+	__tlbi(vmalle1is);
+	dsb(ish);
+	isb();
+
+	/*
+	 * If the host is running at EL1 and we have a VPIPT I-cache,
+	 * then we must perform I-cache maintenance at EL2 in order for
+	 * it to have an effect on the guest. Since the guest cannot hit
+	 * I-cache lines allocated with a different VMID, we don't need
+	 * to worry about junk out of guest reset (we nuke the I-cache on
+	 * VMID rollover), but we do need to be careful when remapping
+	 * executable pages for the same guest. This can happen when KSM
+	 * takes a CoW fault on an executable page, copies the page into
+	 * a page that was previously mapped in the guest and then needs
+	 * to invalidate the guest view of the I-cache for that page
+	 * from EL1. To solve this, we invalidate the entire I-cache when
+	 * unmapping a page from a guest if we have a VPIPT I-cache but
+	 * the host is running at EL1. As above, we could do better if
+	 * we had the VA.
+	 *
+	 * The moral of this story is: if you have a VPIPT I-cache, then
+	 * you should be running with VHE enabled.
+	 */
+	if (!has_vhe() && icache_is_vpipt())
+		__flush_icache_all();
+
+	__tlb_switch_to_host(kvm, &cxt);
+}
+
+static inline void __hyp_text __tlb_flush_vmid(struct kvm *kvm)
+{
+	struct tlb_inv_context cxt;
+
+	dsb(ishst);
+
+	/* Switch to requested VMID */
+	kvm = kern_hyp_va(kvm);
+	__tlb_switch_to_guest(kvm, &cxt);
+
+	__tlbi(vmalls12e1is);
+	dsb(ish);
+	isb();
+
+	__tlb_switch_to_host(kvm, &cxt);
+}
+
+static inline void __hyp_text __tlb_flush_local_vmid(struct kvm_vcpu *vcpu)
+{
+	struct kvm *kvm = kern_hyp_va(kern_hyp_va(vcpu)->kvm);
+	struct tlb_inv_context cxt;
+
+	/* Switch to requested VMID */
+	__tlb_switch_to_guest(kvm, &cxt);
+
+	__tlbi(vmalle1);
+	dsb(nsh);
+	isb();
+
+	__tlb_switch_to_host(kvm, &cxt);
+}
+
+static inline void __hyp_text __tlb_flush_vm_context(void)
+{
+	dsb(ishst);
+	__tlbi(alle1is);
+
+	/*
+	 * VIPT and PIPT caches are not affected by VMID, so no maintenance
+	 * is necessary across a VMID rollover.
+	 *
+	 * VPIPT caches constrain lookup and maintenance to the active VMID,
+	 * so we need to invalidate lines with a stale VMID to avoid an ABA
+	 * race after multiple rollovers.
+	 *
+	 */
+	if (icache_is_vpipt())
+		asm volatile("ic ialluis");
+
+	dsb(ish);
+}
+
+#endif /* __ARM64_KVM_HYP_TLB_H__ */
-- 
2.26.2

