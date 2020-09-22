Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 500FB274A5F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 22:49:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbgIVUtj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 16:49:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726739AbgIVUt3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 16:49:29 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 187C4C0613D0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 13:49:29 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id m6so18595067wrn.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 13:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=f1GdIOWvJZ8YlHGGMuhVEFDO/Kt84MDgjn8Ofz2/F8Y=;
        b=azQ6vvREaJe8Do0qZN6GQzBVklyNx5Fr7I0RCit7+LNk9Nu6hIJ5iajNxgnG6vC3Lf
         XIStyls3mFQ8JYHAUPb7MK5pGzQPzPgOMnmOyGBphdffl/MfRYNKvvvCC0JJoVIt9CWq
         ghrAUDM7lWkEqH3SzKqCkKGk8myCkYcxJjqIpb1Xly3MKqsa7k8046Vsp8mghugAIUsT
         gInExqmUg5URhoHAEDicXjj3NAYeP7d0o0jZHKYlJ+e+wWxDVJ7EcaBnZN3MBPwJ8HVn
         GmPJStXW4fiNEtVDFAbhwti4jlE3Rv7JDjXNVsH4fKh2gyMtIra0IGklIUUNkT0eP8d8
         jsUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=f1GdIOWvJZ8YlHGGMuhVEFDO/Kt84MDgjn8Ofz2/F8Y=;
        b=BGULdrxNtuZwN73FLhOau8KH/3PpUESjZZ/ljPkQEbZIEeI9hPE5DxHR/jJ4lC8Ggt
         n9hwBhSCGcisb5YqqYtnjfe5jBsLe+8fYuabJ/qTImsuiTRwp3XJLDdh7a2KikomvEP9
         xlkmgYDrB7k74yiMIuJ9MSTJLCFqQJjv/XaCGK6rbgkOns+9uAJrPdUjxcVFr53BhROV
         jAhI6QWjTpfYPVJEyoTldeOHGhYQWkJMlW7pwOjTC4nJ7xK8TLNqyIkjMT5gcryeuQQz
         7I2V7Z0G5DYNb9M+VTAx0/x7nwTtEY3ZDCMtWDsOH+a34VnUWb3eZQk/RKcW0zY8o6zk
         uGhg==
X-Gm-Message-State: AOAM5320W+vjcqVXxPMrnR6+liS9YGIMDk5qVMu8vPXK3rFdyBQ2UKVZ
        QV1Vzy64arf7wYC7gMs69yoRDw==
X-Google-Smtp-Source: ABdhPJzAVCI8XgY8zMXDXMyLMYGebhemAOYVzv8iTLVceOpS4x3HeU5X736mpWygTAtBBIyX18em7Q==
X-Received: by 2002:adf:ef45:: with SMTP id c5mr7278188wrp.384.1600807767566;
        Tue, 22 Sep 2020 13:49:27 -0700 (PDT)
Received: from localhost ([2a01:4b00:8523:2d03:1105:630f:e990:272f])
        by smtp.gmail.com with ESMTPSA id s12sm5916222wmd.20.2020.09.22.13.49.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Sep 2020 13:49:26 -0700 (PDT)
From:   David Brazdil <dbrazdil@google.com>
To:     kvmarm@lists.cs.columbia.edu
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com, David Brazdil <dbrazdil@google.com>
Subject: [PATCH v4 09/10] kvm: arm64: Set up hyp percpu data for nVHE
Date:   Tue, 22 Sep 2020 21:49:09 +0100
Message-Id: <20200922204910.7265-10-dbrazdil@google.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200922204910.7265-1-dbrazdil@google.com>
References: <20200922204910.7265-1-dbrazdil@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add hyp percpu section to linker script and rename the corresponding ELF
sections of hyp/nvhe object files. This moves all nVHE-specific percpu
variables to the new hyp percpu section.

Allocate sufficient amount of memory for all percpu hyp regions at global KVM
init time and create corresponding hyp mappings.

The base addresses of hyp percpu regions are kept in a dynamically allocated
array in the kernel.

Add NULL checks in PMU event-reset code as it may run before KVM memory is
initialized.

Signed-off-by: David Brazdil <dbrazdil@google.com>
---
 arch/arm64/include/asm/kvm_asm.h  | 19 +++++++++--
 arch/arm64/kernel/vmlinux.lds.S   |  8 +++++
 arch/arm64/kvm/arm.c              | 55 +++++++++++++++++++++++++++++--
 arch/arm64/kvm/hyp/nvhe/hyp.lds.S |  6 ++++
 arch/arm64/kvm/pmu.c              |  5 ++-
 5 files changed, 87 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_asm.h b/arch/arm64/include/asm/kvm_asm.h
index 911d91787fa0..863f669d4dc8 100644
--- a/arch/arm64/include/asm/kvm_asm.h
+++ b/arch/arm64/include/asm/kvm_asm.h
@@ -66,8 +66,19 @@
 #define CHOOSE_VHE_SYM(sym)	sym
 #define CHOOSE_NVHE_SYM(sym)	kvm_nvhe_sym(sym)
 
-#define this_cpu_ptr_nvhe_sym(sym)	this_cpu_ptr(&kvm_nvhe_sym(sym))
-#define per_cpu_ptr_nvhe_sym(sym, cpu)	per_cpu_ptr(&kvm_nvhe_sym(sym), cpu)
+/*
+ * Compute pointer to a symbol defined in nVHE percpu region.
+ * Returns NULL if percpu memory has not been allocated yet.
+ */
+#define this_cpu_ptr_nvhe_sym(sym)	per_cpu_ptr_nvhe_sym(sym, smp_processor_id())
+#define per_cpu_ptr_nvhe_sym(sym, cpu)						\
+	({									\
+		unsigned long base, off;					\
+		base = kvm_arm_hyp_percpu_base[cpu];				\
+		off = (unsigned long)&CHOOSE_NVHE_SYM(sym) -			\
+		      (unsigned long)&CHOOSE_NVHE_SYM(__per_cpu_start);		\
+		base ? (typeof(CHOOSE_NVHE_SYM(sym))*)(base + off) : NULL;	\
+	})
 
 #ifndef __KVM_NVHE_HYPERVISOR__
 /*
@@ -117,6 +128,10 @@ DECLARE_KVM_HYP_SYM(__kvm_hyp_vector);
 #define __kvm_hyp_init		CHOOSE_NVHE_SYM(__kvm_hyp_init)
 #define __kvm_hyp_vector	CHOOSE_HYP_SYM(__kvm_hyp_vector)
 
+extern unsigned long kvm_arm_hyp_percpu_base[NR_CPUS];
+DECLARE_KVM_NVHE_SYM(__per_cpu_start);
+DECLARE_KVM_NVHE_SYM(__per_cpu_end);
+
 #ifdef CONFIG_KVM_INDIRECT_VECTORS
 extern atomic_t arm64_el2_vector_last_slot;
 DECLARE_KVM_HYP_SYM(__bp_harden_hyp_vecs);
diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
index d14166012e51..d52e6b5dbfd3 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -28,8 +28,15 @@ jiffies = jiffies_64;
 	__start___kvm_ex_table = .;				\
 	*(__kvm_ex_table)					\
 	__stop___kvm_ex_table = .;
+
+#define HYPERVISOR_PERCPU_SECTION				\
+	. = ALIGN(PAGE_SIZE);					\
+	HYP_SECTION_NAME(.data..percpu) : {			\
+		*(HYP_SECTION_NAME(.data..percpu))		\
+	}
 #else /* CONFIG_KVM */
 #define HYPERVISOR_EXTABLE
+#define HYPERVISOR_PERCPU_SECTION
 #endif
 
 #define HYPERVISOR_TEXT					\
@@ -195,6 +202,7 @@ SECTIONS
 	}
 
 	PERCPU_SECTION(L1_CACHE_BYTES)
+	HYPERVISOR_PERCPU_SECTION
 
 	.rela.dyn : ALIGN(8) {
 		*(.rela .rela*)
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 0424667c4c0a..cd5293e55fec 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -47,6 +47,7 @@ __asm__(".arch_extension	virt");
 #endif
 
 static DEFINE_PER_CPU(unsigned long, kvm_arm_hyp_stack_page);
+unsigned long kvm_arm_hyp_percpu_base[NR_CPUS];
 
 /* The VMID used in the VTTBR */
 static atomic64_t kvm_vmid_gen = ATOMIC64_INIT(1);
@@ -1258,6 +1259,19 @@ long kvm_arch_vm_ioctl(struct file *filp,
 	}
 }
 
+static unsigned long nvhe_percpu_size(void)
+{
+	return (unsigned long)CHOOSE_NVHE_SYM(__per_cpu_end) -
+		(unsigned long)CHOOSE_NVHE_SYM(__per_cpu_start);
+}
+
+static unsigned long nvhe_percpu_order(void)
+{
+	unsigned long size = nvhe_percpu_size();
+
+	return size ? get_order(size) : 0;
+}
+
 static void cpu_init_hyp_mode(void)
 {
 	phys_addr_t pgd_ptr;
@@ -1273,8 +1287,8 @@ static void cpu_init_hyp_mode(void)
 	 * kernel's mapping to the linear mapping, and store it in tpidr_el2
 	 * so that we can use adr_l to access per-cpu variables in EL2.
 	 */
-	tpidr_el2 = ((unsigned long)this_cpu_ptr(&kvm_host_data) -
-		     (unsigned long)kvm_ksym_ref(&kvm_host_data));
+	tpidr_el2 = (unsigned long)this_cpu_ptr_nvhe_sym(__per_cpu_start) -
+		    (unsigned long)kvm_ksym_ref(CHOOSE_NVHE_SYM(__per_cpu_start));
 
 	pgd_ptr = kvm_mmu_get_httbr();
 	hyp_stack_ptr = __this_cpu_read(kvm_arm_hyp_stack_page) + PAGE_SIZE;
@@ -1464,8 +1478,10 @@ static void teardown_hyp_mode(void)
 	int cpu;
 
 	free_hyp_pgds();
-	for_each_possible_cpu(cpu)
+	for_each_possible_cpu(cpu) {
 		free_page(per_cpu(kvm_arm_hyp_stack_page, cpu));
+		free_pages(kvm_arm_hyp_percpu_base[cpu], nvhe_percpu_order());
+	}
 }
 
 /**
@@ -1498,6 +1514,24 @@ static int init_hyp_mode(void)
 		per_cpu(kvm_arm_hyp_stack_page, cpu) = stack_page;
 	}
 
+	/*
+	 * Allocate and initialize pages for Hypervisor-mode percpu regions.
+	 */
+	for_each_possible_cpu(cpu) {
+		struct page *page;
+		void *page_addr;
+
+		page = alloc_pages(GFP_KERNEL, nvhe_percpu_order());
+		if (!page) {
+			err = -ENOMEM;
+			goto out_err;
+		}
+
+		page_addr = page_address(page);
+		memcpy(page_addr, CHOOSE_NVHE_SYM(__per_cpu_start), nvhe_percpu_size());
+		kvm_arm_hyp_percpu_base[cpu] = (unsigned long)page_addr;
+	}
+
 	/*
 	 * Map the Hyp-code called directly from the host
 	 */
@@ -1542,6 +1576,21 @@ static int init_hyp_mode(void)
 		}
 	}
 
+	/*
+	 * Map Hyp percpu pages
+	 */
+	for_each_possible_cpu(cpu) {
+		char *percpu_begin = (char *)kvm_arm_hyp_percpu_base[cpu];
+		char *percpu_end = percpu_begin + nvhe_percpu_size();
+
+		err = create_hyp_mappings(percpu_begin, percpu_end, PAGE_HYP);
+
+		if (err) {
+			kvm_err("Cannot map hyp percpu region\n");
+			goto out_err;
+		}
+	}
+
 	for_each_possible_cpu(cpu) {
 		kvm_host_data_t *cpu_data;
 
diff --git a/arch/arm64/kvm/hyp/nvhe/hyp.lds.S b/arch/arm64/kvm/hyp/nvhe/hyp.lds.S
index 3b13d1c7cd1a..bb2d986ff696 100644
--- a/arch/arm64/kvm/hyp/nvhe/hyp.lds.S
+++ b/arch/arm64/kvm/hyp/nvhe/hyp.lds.S
@@ -7,7 +7,13 @@
  */
 
 #include <asm/hyp_image.h>
+#include <asm-generic/vmlinux.lds.h>
+#include <asm/cache.h>
+#include <asm/memory.h>
 
 SECTIONS {
 	HYP_SECTION(.text)
+	HYP_SECTION_NAME(.data..percpu) : {
+		PERCPU_INPUT(L1_CACHE_BYTES)
+	}
 }
diff --git a/arch/arm64/kvm/pmu.c b/arch/arm64/kvm/pmu.c
index c869c851d2dd..faf32a44ba04 100644
--- a/arch/arm64/kvm/pmu.c
+++ b/arch/arm64/kvm/pmu.c
@@ -33,7 +33,7 @@ void kvm_set_pmu_events(u32 set, struct perf_event_attr *attr)
 {
 	struct kvm_host_data *ctx = this_cpu_ptr_hyp_sym(kvm_host_data);
 
-	if (!kvm_pmu_switch_needed(attr))
+	if (!ctx || !kvm_pmu_switch_needed(attr))
 		return;
 
 	if (!attr->exclude_host)
@@ -49,6 +49,9 @@ void kvm_clr_pmu_events(u32 clr)
 {
 	struct kvm_host_data *ctx = this_cpu_ptr_hyp_sym(kvm_host_data);
 
+	if (!ctx)
+		return;
+
 	ctx->pmu_events.events_host &= ~clr;
 	ctx->pmu_events.events_guest &= ~clr;
 }
-- 
2.28.0.681.g6f77f65b4e-goog

