Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96F0928215E
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Oct 2020 06:51:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725890AbgJCEv3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Oct 2020 00:51:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:49896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725848AbgJCEvW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Oct 2020 00:51:22 -0400
Received: from localhost (83-245-197-237.elisa-laajakaista.fi [83.245.197.237])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CBF1F21D7A;
        Sat,  3 Oct 2020 04:51:21 +0000 (UTC)
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     x86@kernel.org, linux-sgx@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Jethro Beekman <jethro@fortanix.com>,
        Darren Kenny <darren.kenny@oracle.com>,
        Serge Ayoun <serge.ayoun@intel.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        akpm@linux-foundation.org, andriy.shevchenko@linux.intel.com,
        asapek@google.com, bp@alien8.de, cedric.xing@intel.com,
        chenalexchen@google.com, conradparker@google.com,
        cyhanish@google.com, dave.hansen@intel.com, haitao.huang@intel.com,
        kai.huang@intel.com, kai.svahn@intel.com, kmoy@google.com,
        ludloff@google.com, luto@kernel.org, nhorman@redhat.com,
        npmccallum@redhat.com, puiterwijk@redhat.com, rientjes@google.com,
        tglx@linutronix.de, yaozhangx@google.com, mikko.ylinen@intel.com
Subject: [PATCH v39 08/24] x86/sgx: Initialize metadata for Enclave Page Cache (EPC) sections
Date:   Sat,  3 Oct 2020 07:50:43 +0300
Message-Id: <20201003045059.665934-9-jarkko.sakkinen@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201003045059.665934-1-jarkko.sakkinen@linux.intel.com>
References: <20201003045059.665934-1-jarkko.sakkinen@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Christopherson <sean.j.christopherson@intel.com>

Enumerate Enclave Page Cache (EPC) sections via CPUID and add the data
structures necessary to track EPC pages so that they can be easily borrowed
for different uses.

Embed section index to the first eight bits of the EPC page descriptor.
Existing client hardware supports only a single section, while upcoming
server hardware will support at most eight sections. Thus, eight bits
should be enough for long term needs.

Acked-by: Jethro Beekman <jethro@fortanix.com>
Reviewed-by: Darren Kenny <darren.kenny@oracle.com>
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Co-developed-by: Serge Ayoun <serge.ayoun@intel.com>
Signed-off-by: Serge Ayoun <serge.ayoun@intel.com>
Co-developed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
---
 arch/x86/Kconfig                 |  17 +++
 arch/x86/kernel/cpu/Makefile     |   1 +
 arch/x86/kernel/cpu/sgx/Makefile |   2 +
 arch/x86/kernel/cpu/sgx/main.c   | 216 +++++++++++++++++++++++++++++++
 arch/x86/kernel/cpu/sgx/sgx.h    |  52 ++++++++
 5 files changed, 288 insertions(+)
 create mode 100644 arch/x86/kernel/cpu/sgx/Makefile
 create mode 100644 arch/x86/kernel/cpu/sgx/main.c
 create mode 100644 arch/x86/kernel/cpu/sgx/sgx.h

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 5a604353ec42..9787253ea61e 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1930,6 +1930,23 @@ config X86_INTEL_TSX_MODE_AUTO
 	  side channel attacks- equals the tsx=auto command line parameter.
 endchoice
 
+config INTEL_SGX
+	bool "Intel SGX"
+	depends on X86_64 && CPU_SUP_INTEL
+	depends on CRYPTO=y
+	depends on CRYPTO_SHA256=y
+	select SRCU
+	select MMU_NOTIFIER
+	help
+	  Intel(R) Software Guard eXtensions (SGX) is a set of CPU instructions
+	  that can be used by applications to set aside private regions of code
+	  and data, referred to as enclaves. An enclave's private memory can
+	  only be accessed by code running within the enclave. Accesses from
+	  outside the enclave, including other enclaves, are disallowed by
+	  hardware.
+
+	  If unsure, say N.
+
 config EFI
 	bool "EFI runtime service support"
 	depends on ACPI
diff --git a/arch/x86/kernel/cpu/Makefile b/arch/x86/kernel/cpu/Makefile
index 93792b457b81..c80d804fd02b 100644
--- a/arch/x86/kernel/cpu/Makefile
+++ b/arch/x86/kernel/cpu/Makefile
@@ -48,6 +48,7 @@ obj-$(CONFIG_X86_MCE)			+= mce/
 obj-$(CONFIG_MTRR)			+= mtrr/
 obj-$(CONFIG_MICROCODE)			+= microcode/
 obj-$(CONFIG_X86_CPU_RESCTRL)		+= resctrl/
+obj-$(CONFIG_INTEL_SGX)			+= sgx/
 
 obj-$(CONFIG_X86_LOCAL_APIC)		+= perfctr-watchdog.o
 
diff --git a/arch/x86/kernel/cpu/sgx/Makefile b/arch/x86/kernel/cpu/sgx/Makefile
new file mode 100644
index 000000000000..79510ce01b3b
--- /dev/null
+++ b/arch/x86/kernel/cpu/sgx/Makefile
@@ -0,0 +1,2 @@
+obj-y += \
+	main.o
diff --git a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
new file mode 100644
index 000000000000..c5831e3db14a
--- /dev/null
+++ b/arch/x86/kernel/cpu/sgx/main.c
@@ -0,0 +1,216 @@
+// SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
+// Copyright(c) 2016-17 Intel Corporation.
+
+#include <linux/freezer.h>
+#include <linux/highmem.h>
+#include <linux/kthread.h>
+#include <linux/pagemap.h>
+#include <linux/ratelimit.h>
+#include <linux/sched/mm.h>
+#include <linux/sched/signal.h>
+#include <linux/slab.h>
+#include "encls.h"
+
+struct sgx_epc_section sgx_epc_sections[SGX_MAX_EPC_SECTIONS];
+static int sgx_nr_epc_sections;
+static struct task_struct *ksgxswapd_tsk;
+
+static void sgx_sanitize_section(struct sgx_epc_section *section)
+{
+	struct sgx_epc_page *page;
+	LIST_HEAD(secs_list);
+	int ret;
+
+	while (!list_empty(&section->unsanitized_page_list)) {
+		if (kthread_should_stop())
+			return;
+
+		spin_lock(&section->lock);
+
+		page = list_first_entry(&section->unsanitized_page_list,
+					struct sgx_epc_page, list);
+
+		ret = __eremove(sgx_get_epc_addr(page));
+		if (!ret)
+			list_move(&page->list, &section->page_list);
+		else
+			list_move_tail(&page->list, &secs_list);
+
+		spin_unlock(&section->lock);
+
+		cond_resched();
+	}
+}
+
+static int ksgxswapd(void *p)
+{
+	int i;
+
+	set_freezable();
+
+	/*
+	 * Reset all pages to uninitialized state. Pages could be in initialized
+	 * on kmemexec.
+	 */
+	for (i = 0; i < sgx_nr_epc_sections; i++)
+		sgx_sanitize_section(&sgx_epc_sections[i]);
+
+	/*
+	 * 2nd round for the SECS pages as they cannot be removed when they
+	 * still hold child pages.
+	 */
+	for (i = 0; i < sgx_nr_epc_sections; i++) {
+		sgx_sanitize_section(&sgx_epc_sections[i]);
+
+		/* Should never happen. */
+		if (!list_empty(&sgx_epc_sections[i].unsanitized_page_list))
+			WARN(1, "EPC section %d has unsanitized pages.\n", i);
+	}
+
+	return 0;
+}
+
+static bool __init sgx_page_reclaimer_init(void)
+{
+	struct task_struct *tsk;
+
+	tsk = kthread_run(ksgxswapd, NULL, "ksgxswapd");
+	if (IS_ERR(tsk))
+		return false;
+
+	ksgxswapd_tsk = tsk;
+
+	return true;
+}
+
+static void __init sgx_free_epc_section(struct sgx_epc_section *section)
+{
+	struct sgx_epc_page *page;
+
+	while (!list_empty(&section->page_list)) {
+		page = list_first_entry(&section->page_list,
+					struct sgx_epc_page, list);
+		list_del(&page->list);
+		kfree(page);
+	}
+
+	while (!list_empty(&section->unsanitized_page_list)) {
+		page = list_first_entry(&section->unsanitized_page_list,
+					struct sgx_epc_page, list);
+		list_del(&page->list);
+		kfree(page);
+	}
+
+	memunmap(section->va);
+}
+
+static bool __init sgx_setup_epc_section(u64 addr, u64 size,
+					 unsigned long index,
+					 struct sgx_epc_section *section)
+{
+	unsigned long nr_pages = size >> PAGE_SHIFT;
+	struct sgx_epc_page *page;
+	unsigned long i;
+
+	section->va = memremap(addr, size, MEMREMAP_WB);
+	if (!section->va)
+		return false;
+
+	section->pa = addr;
+	spin_lock_init(&section->lock);
+	INIT_LIST_HEAD(&section->page_list);
+	INIT_LIST_HEAD(&section->unsanitized_page_list);
+
+	for (i = 0; i < nr_pages; i++) {
+		page = kzalloc(sizeof(*page), GFP_KERNEL);
+		if (!page)
+			goto err_out;
+
+		page->desc = (addr + (i << PAGE_SHIFT)) | index;
+		list_add_tail(&page->list, &section->unsanitized_page_list);
+	}
+
+	return true;
+
+err_out:
+	sgx_free_epc_section(section);
+	return false;
+}
+
+static void __init sgx_page_cache_teardown(void)
+{
+	int i;
+
+	for (i = 0; i < sgx_nr_epc_sections; i++)
+		sgx_free_epc_section(&sgx_epc_sections[i]);
+}
+
+/**
+ * A section metric is concatenated in a way that @low bits 12-31 define the
+ * bits 12-31 of the metric and @high bits 0-19 define the bits 32-51 of the
+ * metric.
+ */
+static inline u64 __init sgx_calc_section_metric(u64 low, u64 high)
+{
+	return (low & GENMASK_ULL(31, 12)) +
+	       ((high & GENMASK_ULL(19, 0)) << 32);
+}
+
+static bool __init sgx_page_cache_init(void)
+{
+	u32 eax, ebx, ecx, edx, type;
+	u64 pa, size;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(sgx_epc_sections); i++) {
+		cpuid_count(SGX_CPUID, i + SGX_CPUID_FIRST_VARIABLE_SUB_LEAF,
+			    &eax, &ebx, &ecx, &edx);
+
+		type = eax & SGX_CPUID_SUB_LEAF_TYPE_MASK;
+		if (type == SGX_CPUID_SUB_LEAF_INVALID)
+			break;
+
+		if (type != SGX_CPUID_SUB_LEAF_EPC_SECTION) {
+			pr_err_once("Unknown EPC section type: %u\n", type);
+			break;
+		}
+
+		pa = sgx_calc_section_metric(eax, ebx);
+		size = sgx_calc_section_metric(ecx, edx);
+
+		pr_info("EPC section 0x%llx-0x%llx\n", pa, pa + size - 1);
+
+		if (!sgx_setup_epc_section(pa, size, i, &sgx_epc_sections[i])) {
+			pr_err("No free memory for an EPC section\n");
+			break;
+		}
+
+		sgx_nr_epc_sections++;
+	}
+
+	if (!sgx_nr_epc_sections) {
+		pr_err("There are zero EPC sections.\n");
+		return false;
+	}
+
+	return true;
+}
+
+static void __init sgx_init(void)
+{
+	if (!boot_cpu_has(X86_FEATURE_SGX))
+		return;
+
+	if (!sgx_page_cache_init())
+		return;
+
+	if (!sgx_page_reclaimer_init())
+		goto err_page_cache;
+
+	return;
+
+err_page_cache:
+	sgx_page_cache_teardown();
+}
+
+device_initcall(sgx_init);
diff --git a/arch/x86/kernel/cpu/sgx/sgx.h b/arch/x86/kernel/cpu/sgx/sgx.h
new file mode 100644
index 000000000000..dff4f5f16d09
--- /dev/null
+++ b/arch/x86/kernel/cpu/sgx/sgx.h
@@ -0,0 +1,52 @@
+/* SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause) */
+#ifndef _X86_SGX_H
+#define _X86_SGX_H
+
+#include <linux/bitops.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/rwsem.h>
+#include <linux/types.h>
+#include <asm/asm.h>
+#include "arch.h"
+
+#undef pr_fmt
+#define pr_fmt(fmt) "sgx: " fmt
+
+struct sgx_epc_page {
+	unsigned long desc;
+	struct list_head list;
+};
+
+/*
+ * The firmware can define multiple chunks of EPC to the different areas of the
+ * physical memory e.g. for memory areas of the each node. This structure is
+ * used to store EPC pages for one EPC section and virtual memory area where
+ * the pages have been mapped.
+ */
+struct sgx_epc_section {
+	unsigned long pa;
+	void *va;
+	struct list_head page_list;
+	struct list_head unsanitized_page_list;
+	spinlock_t lock;
+};
+
+#define SGX_EPC_SECTION_MASK		GENMASK(7, 0)
+#define SGX_MAX_EPC_SECTIONS		(SGX_EPC_SECTION_MASK + 1)
+
+extern struct sgx_epc_section sgx_epc_sections[SGX_MAX_EPC_SECTIONS];
+
+static inline struct sgx_epc_section *sgx_get_epc_section(struct sgx_epc_page *page)
+{
+	return &sgx_epc_sections[page->desc & SGX_EPC_SECTION_MASK];
+}
+
+static inline void *sgx_get_epc_addr(struct sgx_epc_page *page)
+{
+	struct sgx_epc_section *section = sgx_get_epc_section(page);
+
+	return section->va + (page->desc & PAGE_MASK) - section->pa;
+}
+
+#endif /* _X86_SGX_H */
-- 
2.25.1

