Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B5D82A66CD
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 15:55:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729862AbgKDOzB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 09:55:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:48696 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728380AbgKDOy7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 09:54:59 -0500
Received: from suppilovahvero.lan (83-245-197-237.elisa-laajakaista.fi [83.245.197.237])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4F0552151B;
        Wed,  4 Nov 2020 14:54:51 +0000 (UTC)
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
Subject: [PATCH v40 03/24] x86/sgx: Initialize metadata for Enclave Page Cache (EPC) sections
Date:   Wed,  4 Nov 2020 16:54:09 +0200
Message-Id: <20201104145430.300542-4-jarkko.sakkinen@linux.intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201104145430.300542-1-jarkko.sakkinen@linux.intel.com>
References: <20201104145430.300542-1-jarkko.sakkinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Christopherson <sean.j.christopherson@intel.com>

Although carved out of normal DRAM, enclave memory is marked in the
system memory map as reserved and is not managed by the core mm.  There
may be several regions spread across the system.  Each contiguous region
is called an Enclave Page Cache (EPC) section.  EPC sections are
enumerated via CPUID

Enclave pages can only be accessed when they are mapped as part of an
enclave, by a hardware thread running inside the enclave.

Parse CPUID data, create metadata for EPC pages and populate a simple
EPC page allocator.  Although much smaller, ‘struct sgx_epc_page’
metadata is the SGX analog of the core mm ‘struct page’.

Similar to how the core mm’s page->flags encode zone and NUMA
information, embed the EPC section index to the first eight bits of
sgx_epc_page->desc.  This allows a quick reverse lookup from EPC page to
EPC section.  Existing client hardware supports only a single section,
while upcoming server hardware will support at most eight sections.
Thus, eight bits should be enough for long term needs.

Acked-by: Jethro Beekman <jethro@fortanix.com>
Reviewed-by: Darren Kenny <darren.kenny@oracle.com>
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Co-developed-by: Serge Ayoun <serge.ayoun@intel.com>
Signed-off-by: Serge Ayoun <serge.ayoun@intel.com>
Co-developed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
---
Change from v39:
* Replace CONFIG_INTEL_SGX with CONFIG_X86_SGX.

 arch/x86/Kconfig                 |  17 +++
 arch/x86/kernel/cpu/Makefile     |   1 +
 arch/x86/kernel/cpu/sgx/Makefile |   2 +
 arch/x86/kernel/cpu/sgx/main.c   | 190 +++++++++++++++++++++++++++++++
 arch/x86/kernel/cpu/sgx/sgx.h    |  60 ++++++++++
 5 files changed, 270 insertions(+)
 create mode 100644 arch/x86/kernel/cpu/sgx/Makefile
 create mode 100644 arch/x86/kernel/cpu/sgx/main.c
 create mode 100644 arch/x86/kernel/cpu/sgx/sgx.h

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index f6946b81f74a..618d1aabccb8 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1930,6 +1930,23 @@ config X86_INTEL_TSX_MODE_AUTO
 	  side channel attacks- equals the tsx=auto command line parameter.
 endchoice
 
+config X86_SGX
+	bool "Software Guard eXtensions (SGX)"
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
index 93792b457b81..637b499450d1 100644
--- a/arch/x86/kernel/cpu/Makefile
+++ b/arch/x86/kernel/cpu/Makefile
@@ -48,6 +48,7 @@ obj-$(CONFIG_X86_MCE)			+= mce/
 obj-$(CONFIG_MTRR)			+= mtrr/
 obj-$(CONFIG_MICROCODE)			+= microcode/
 obj-$(CONFIG_X86_CPU_RESCTRL)		+= resctrl/
+obj-$(CONFIG_X86_SGX)			+= sgx/
 
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
index 000000000000..956055a0eff6
--- /dev/null
+++ b/arch/x86/kernel/cpu/sgx/main.c
@@ -0,0 +1,190 @@
+// SPDX-License-Identifier: GPL-2.0
+/*  Copyright(c) 2016-20 Intel Corporation. */
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
+/*
+ * Reset dirty EPC pages to uninitialized state. Laundry can be left with SECS
+ * pages whose child pages blocked EREMOVE.
+ */
+static void sgx_sanitize_section(struct sgx_epc_section *section)
+{
+	struct sgx_epc_page *page;
+	LIST_HEAD(dirty);
+	int ret;
+
+	while (!list_empty(&section->laundry_list)) {
+		if (kthread_should_stop())
+			return;
+
+		spin_lock(&section->lock);
+
+		page = list_first_entry(&section->laundry_list,
+					struct sgx_epc_page, list);
+
+		ret = __eremove(sgx_get_epc_virt_addr(page));
+		if (!ret)
+			list_move(&page->list, &section->page_list);
+		else
+			list_move_tail(&page->list, &dirty);
+
+		spin_unlock(&section->lock);
+
+		cond_resched();
+	}
+
+	list_splice(&dirty, &section->laundry_list);
+}
+
+static int ksgxswapd(void *p)
+{
+	int i;
+
+	set_freezable();
+
+	/*
+	 * Sanitize pages in order to recover from kexec(). The 2nd pass is
+	 * required for SECS pages, whose child pages blocked EREMOVE.
+	 */
+	for (i = 0; i < sgx_nr_epc_sections; i++)
+		sgx_sanitize_section(&sgx_epc_sections[i]);
+
+	for (i = 0; i < sgx_nr_epc_sections; i++) {
+		sgx_sanitize_section(&sgx_epc_sections[i]);
+
+		/* Should never happen. */
+		if (!list_empty(&sgx_epc_sections[i].laundry_list))
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
+static bool __init sgx_setup_epc_section(u64 phys_addr, u64 size,
+					 unsigned long index,
+					 struct sgx_epc_section *section)
+{
+	unsigned long nr_pages = size >> PAGE_SHIFT;
+	unsigned long i;
+
+	section->virt_addr = memremap(phys_addr, size, MEMREMAP_WB);
+	if (!section->virt_addr)
+		return false;
+
+	section->pages = vmalloc(nr_pages * sizeof(struct sgx_epc_page));
+	if (!section->pages) {
+		memunmap(section->virt_addr);
+		return false;
+	}
+
+	section->phys_addr = phys_addr;
+	spin_lock_init(&section->lock);
+	INIT_LIST_HEAD(&section->page_list);
+	INIT_LIST_HEAD(&section->laundry_list);
+
+	for (i = 0; i < nr_pages; i++) {
+		section->pages[i].section = index;
+		list_add_tail(&section->pages[i].list, &section->laundry_list);
+	}
+
+	return true;
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
+		cpuid_count(SGX_CPUID, i + SGX_CPUID_EPC, &eax, &ebx, &ecx, &edx);
+
+		type = eax & SGX_CPUID_EPC_MASK;
+		if (type == SGX_CPUID_EPC_INVALID)
+			break;
+
+		if (type != SGX_CPUID_EPC_SECTION) {
+			pr_err_once("Unknown EPC section type: %u\n", type);
+			break;
+		}
+
+		pa   = sgx_calc_section_metric(eax, ebx);
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
+	int i;
+
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
+	for (i = 0; i < sgx_nr_epc_sections; i++) {
+		vfree(sgx_epc_sections[i].pages);
+		memunmap(sgx_epc_sections[i].virt_addr);
+	}
+}
+
+device_initcall(sgx_init);
diff --git a/arch/x86/kernel/cpu/sgx/sgx.h b/arch/x86/kernel/cpu/sgx/sgx.h
new file mode 100644
index 000000000000..02afa84dd8fd
--- /dev/null
+++ b/arch/x86/kernel/cpu/sgx/sgx.h
@@ -0,0 +1,60 @@
+/* SPDX-License-Identifier: GPL-2.0 */
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
+#define SGX_MAX_EPC_SECTIONS		8
+
+struct sgx_epc_page {
+	unsigned int section;
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
+	unsigned long phys_addr;
+	void *virt_addr;
+	struct list_head page_list;
+	struct list_head laundry_list;
+	struct sgx_epc_page *pages;
+	spinlock_t lock;
+};
+
+extern struct sgx_epc_section sgx_epc_sections[SGX_MAX_EPC_SECTIONS];
+
+static inline unsigned long sgx_get_epc_phys_addr(struct sgx_epc_page *page)
+{
+	struct sgx_epc_section *section = &sgx_epc_sections[page->section];
+	unsigned long index;
+
+	index = ((unsigned long)page - (unsigned long)section->pages) / sizeof(*page);
+
+	return section->phys_addr + index * PAGE_SIZE;
+}
+
+static inline void *sgx_get_epc_virt_addr(struct sgx_epc_page *page)
+{
+	struct sgx_epc_section *section = &sgx_epc_sections[page->section];
+	unsigned long index;
+
+	index = ((unsigned long)page - (unsigned long)section->pages) / sizeof(*page);
+
+	return section->virt_addr + index * PAGE_SIZE;
+}
+
+#endif /* _X86_SGX_H */
-- 
2.27.0

