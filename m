Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 334302A7397
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 01:06:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387876AbgKEAFF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 19:05:05 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:35642 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbgKEAFB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 19:05:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1604534701; x=1636070701;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9LXIU6uBowXoagPOvdiTOz1DEXbfskoKX8F/DlcY3rg=;
  b=j385yTw7Kg74MulnF5GNlWJOlscD5z2pu5pxOZbEuSE9cTqupKno1CF7
   PVAHpZ9dhycWFld7f4U1fK/Z6RSM3AKY+CPJS/MC1hdVj6vC+Kj+XJPHW
   FetW2duVnvRO5rTGsArDDnTdjsXHKZ4KYiU5q6YIpb3jT2u4Oxaa08EMr
   UukxQP6Ns2CyxuGpzgSfQ6s1NXIuBwwBOSgIlZZPvI2MV1pvIOgQhKT4n
   icraVI+rTVnrTH+CRK1PnlMO35ZyMcetYh3GpgtY0xs5LhrNXZtp2lx55
   Kbbsn3717KsTXQGLtZmWIWvEzb6RSYVOG9hGlBqGJeK9w2bi1y7URxDHV
   A==;
IronPort-SDR: ywsBTvterxOkBkXSU1aFNTvqVyb2AFrbKSsE4nKA7+tJ01KJF4LZaftIzg68Oz7lpt6z0720KW
 bpbOzhHby9RqZudHOuEpPdbig/yJz+8ty9QfhV3LbOZeEqCICLUobRLqc7Cmd+2jNGyIkE50h0
 TnAe4V6zUPX9iSqhNOf6r/9krceEdMKe3d4PBp+GNYKuBLfe7yueBAtdEl1g1jehKmfMb7cGgo
 Ysy11U9nKUfX1KKh2UtwzZ0Dq6wr+FbPpq3/J27DdVJqyHYct5szqvTvJ+3JWK+Jissa+y3ZxZ
 XuA=
X-IronPort-AV: E=Sophos;i="5.77,451,1596470400"; 
   d="scan'208";a="151945117"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 05 Nov 2020 08:05:01 +0800
IronPort-SDR: pGfunootntm4/21gu4xNRfEkC1IyxUPLKsI/XrQUUg8etjOEP8sQ0zDFrNU2VkYb2k+WzQZs5L
 qsExUC3I4YwdXFKvSbpEExzpaTi8fDv7JZtPBjyXo97ZhebrneUy9kTblHbOzAltRl+PhAaDJT
 OHB6sQ5mvsD1pvLlzr8HHqH8J9C0WVLb1vuapTU/D0u5QJZdxJRtAtVtD5bP27rOsS0Ui6nF1k
 qRRjzMLsxdVyf+XYO7ZZi88ALYPi8MC18hP6akPc5+E8qku0VlQAhyhhiD2oCQedFdwSNLkJSS
 XAEIq6d3ymbBE/VgglDcVjXb
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2020 15:51:08 -0800
IronPort-SDR: VjqcOTAU4bApn5VGbAwSOp9Egjq3jCCKzrTI7gslDFhyCh8ji0NStWFx3qVPI68gSIzWqdSdPt
 CyFFu6ha3fvoYjzvriYI7jfvPjfv3zudT2WrELfbn8rGFMDyem6FjXsM/kQ2fBVvD5EwYaEVFg
 lkSU+ONvzotbz0drAN3a3+rGCRR2+WIwREzUrxIzabnfUiPLT2Dd7BuLIIxHOHEyGUJ/48ypsJ
 VMVK5QSZZnjDj2Cg6PK4XEgDFOpkNZDcompELIWaRXWZ1WiSElX57TKsYhnG7xFFrvQ01FCxA/
 4Go=
WDCIronportException: Internal
Received: from 6hj08h2.ad.shared (HELO jedi-01.hgst.com) ([10.86.60.117])
  by uls-op-cesaip02.wdc.com with ESMTP; 04 Nov 2020 16:05:01 -0800
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anup Patel <anup@brainfault.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Greentime Hu <greentime.hu@sifive.com>,
        Guo Ren <ren_guo@c-sky.com>, linux-riscv@lists.infradead.org,
        Michel Lespinasse <walken@google.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Zong Li <zong.li@sifive.com>
Subject: [PATCH v3 4/5] RISC-V: Protect all kernel sections including init early
Date:   Wed,  4 Nov 2020 16:04:38 -0800
Message-Id: <20201105000439.1491243-5-atish.patra@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201105000439.1491243-1-atish.patra@wdc.com>
References: <20201105000439.1491243-1-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, .init.text & .init.data are intermixed which makes it impossible
apply different permissions to them. .init.data shouldn't need exec
permissions while .init.text shouldn't have write permission. Moreover,
the strict permission are only enforced /init starts. This leaves the
kernel vulnerable from possible buggy built-in modules.

Keep .init.text & .data in separate sections so that different permissions
are applied to each section. Apply permissions to individual sections as
early as possible. This improves the kernel protection under
CONFIG_STRICT_KERNEL_RWX. We also need to restore the permissions for the
entire _init section after it is freed so that those pages can be used
for other purpose.

Signed-off-by: Atish Patra <atish.patra@wdc.com>
---
 arch/riscv/include/asm/sections.h   |  2 ++
 arch/riscv/include/asm/set_memory.h |  4 +++
 arch/riscv/kernel/setup.c           | 12 +++++++
 arch/riscv/kernel/vmlinux.lds.S     | 49 ++++++++++++++++-------------
 arch/riscv/mm/init.c                | 21 ++++++++++---
 arch/riscv/mm/pageattr.c            |  6 ++++
 6 files changed, 67 insertions(+), 27 deletions(-)

diff --git a/arch/riscv/include/asm/sections.h b/arch/riscv/include/asm/sections.h
index 3a9971b1210f..1595c5b60cfd 100644
--- a/arch/riscv/include/asm/sections.h
+++ b/arch/riscv/include/asm/sections.h
@@ -9,5 +9,7 @@
 
 extern char _start[];
 extern char _start_kernel[];
+extern char __init_data_begin[], __init_data_end[];
+extern char __init_text_begin[], __init_text_end[];
 
 #endif /* __ASM_SECTIONS_H */
diff --git a/arch/riscv/include/asm/set_memory.h b/arch/riscv/include/asm/set_memory.h
index 4c5bae7ca01c..b21f4bea6434 100644
--- a/arch/riscv/include/asm/set_memory.h
+++ b/arch/riscv/include/asm/set_memory.h
@@ -15,11 +15,15 @@ int set_memory_ro(unsigned long addr, int numpages);
 int set_memory_rw(unsigned long addr, int numpages);
 int set_memory_x(unsigned long addr, int numpages);
 int set_memory_nx(unsigned long addr, int numpages);
+int set_memory_rw_nx(unsigned long addr, int numpages);
+void protect_kernel_text_data(void);
 #else
 static inline int set_memory_ro(unsigned long addr, int numpages) { return 0; }
 static inline int set_memory_rw(unsigned long addr, int numpages) { return 0; }
 static inline int set_memory_x(unsigned long addr, int numpages) { return 0; }
 static inline int set_memory_nx(unsigned long addr, int numpages) { return 0; }
+static inline void protect_kernel_text_data(void) {};
+static inline int set_memory_rw_nx(unsigned long addr, int numpages) { return 0; }
 #endif
 
 int set_direct_map_invalid_noflush(struct page *page);
diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
index b916f4a904c4..0cbbf62c7747 100644
--- a/arch/riscv/kernel/setup.c
+++ b/arch/riscv/kernel/setup.c
@@ -22,6 +22,7 @@
 #include <asm/cpu_ops.h>
 #include <asm/early_ioremap.h>
 #include <asm/setup.h>
+#include <asm/set_memory.h>
 #include <asm/sections.h>
 #include <asm/sbi.h>
 #include <asm/tlbflush.h>
@@ -92,6 +93,8 @@ void __init setup_arch(char **cmdline_p)
 	if (IS_ENABLED(CONFIG_RISCV_SBI))
 		sbi_init();
 
+	if (IS_ENABLED(CONFIG_STRICT_KERNEL_RWX))
+		protect_kernel_text_data();
 #ifdef CONFIG_SWIOTLB
 	swiotlb_init(1);
 #endif
@@ -121,3 +124,12 @@ static int __init topology_init(void)
 	return 0;
 }
 subsys_initcall(topology_init);
+
+void free_initmem(void)
+{
+	unsigned long init_begin = (unsigned long)__init_begin;
+	unsigned long init_end = (unsigned long)__init_end;
+
+	set_memory_rw_nx(init_begin, (init_end - init_begin) >> PAGE_SHIFT);
+	free_initmem_default(POISON_FREE_INITMEM);
+}
diff --git a/arch/riscv/kernel/vmlinux.lds.S b/arch/riscv/kernel/vmlinux.lds.S
index cacd7898ba7f..ca19ee5acd0a 100644
--- a/arch/riscv/kernel/vmlinux.lds.S
+++ b/arch/riscv/kernel/vmlinux.lds.S
@@ -29,6 +29,22 @@ SECTIONS
 	HEAD_TEXT_SECTION
 	. = ALIGN(PAGE_SIZE);
 
+	.text : {
+		_text = .;
+		_stext = .;
+		TEXT_TEXT
+		SCHED_TEXT
+		CPUIDLE_TEXT
+		LOCK_TEXT
+		KPROBES_TEXT
+		ENTRY_TEXT
+		IRQENTRY_TEXT
+		SOFTIRQENTRY_TEXT
+		*(.fixup)
+		_etext = .;
+	}
+
+	. = ALIGN(SECTION_ALIGN);
 	__init_begin = .;
 	__init_text_begin = .;
 	.init.text : AT(ADDR(.init.text) - LOAD_OFFSET) ALIGN(SECTION_ALIGN) { \
@@ -53,35 +69,24 @@ SECTIONS
 	{
 		EXIT_TEXT
 	}
-	.exit.data :
-	{
-		EXIT_DATA
-	}
-	PERCPU_SECTION(L1_CACHE_BYTES)
-	__init_end = .;
 
+	__init_text_end = .;
 	. = ALIGN(SECTION_ALIGN);
-	.text : {
-		_text = .;
-		_stext = .;
-		TEXT_TEXT
-		SCHED_TEXT
-		CPUIDLE_TEXT
-		LOCK_TEXT
-		KPROBES_TEXT
-		ENTRY_TEXT
-		IRQENTRY_TEXT
-		SOFTIRQENTRY_TEXT
-		*(.fixup)
-		_etext = .;
-	}
-
 #ifdef CONFIG_EFI
 	. = ALIGN(PECOFF_SECTION_ALIGNMENT);
 	__pecoff_text_end = .;
 #endif
-
+	/* Start of init data section */
+	__init_data_begin = .;
 	INIT_DATA_SECTION(16)
+	.exit.data :
+	{
+		EXIT_DATA
+	}
+	PERCPU_SECTION(L1_CACHE_BYTES)
+
+	__init_data_end = .;
+	__init_end = .;
 
 	/* Start of data section */
 	_sdata = .;
diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index 0d13d0c36a7d..00793f3c837e 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -622,18 +622,29 @@ static inline void setup_vm_final(void)
 #endif /* CONFIG_MMU */
 
 #ifdef CONFIG_STRICT_KERNEL_RWX
-void mark_rodata_ro(void)
+void protect_kernel_text_data(void)
 {
-	unsigned long text_start = (unsigned long)_text;
-	unsigned long text_end = (unsigned long)_etext;
+	unsigned long text_start = (unsigned long)_start;
+	unsigned long init_text_start = (unsigned long)__init_text_begin;
+	unsigned long init_data_start = (unsigned long)__init_data_begin;
 	unsigned long rodata_start = (unsigned long)__start_rodata;
 	unsigned long data_start = (unsigned long)_data;
 	unsigned long max_low = (unsigned long)(__va(PFN_PHYS(max_low_pfn)));
 
-	set_memory_ro(text_start, (text_end - text_start) >> PAGE_SHIFT);
-	set_memory_ro(rodata_start, (data_start - rodata_start) >> PAGE_SHIFT);
+	set_memory_ro(text_start, (init_text_start - text_start) >> PAGE_SHIFT);
+	set_memory_ro(init_text_start, (init_data_start - init_text_start) >> PAGE_SHIFT);
+	set_memory_nx(init_data_start, (rodata_start - init_data_start) >> PAGE_SHIFT);
+	/* rodata section is marked readonly in mark_rodata_ro */
 	set_memory_nx(rodata_start, (data_start - rodata_start) >> PAGE_SHIFT);
 	set_memory_nx(data_start, (max_low - data_start) >> PAGE_SHIFT);
+}
+
+void mark_rodata_ro(void)
+{
+	unsigned long rodata_start = (unsigned long)__start_rodata;
+	unsigned long data_start = (unsigned long)_data;
+
+	set_memory_ro(rodata_start, (data_start - rodata_start) >> PAGE_SHIFT);
 
 	debug_checkwx();
 }
diff --git a/arch/riscv/mm/pageattr.c b/arch/riscv/mm/pageattr.c
index 19fecb362d81..c64ec224fd0c 100644
--- a/arch/riscv/mm/pageattr.c
+++ b/arch/riscv/mm/pageattr.c
@@ -128,6 +128,12 @@ static int __set_memory(unsigned long addr, int numpages, pgprot_t set_mask,
 	return ret;
 }
 
+int set_memory_rw_nx(unsigned long addr, int numpages)
+{
+	return __set_memory(addr, numpages, __pgprot(_PAGE_READ | _PAGE_WRITE),
+			    __pgprot(_PAGE_EXEC));
+}
+
 int set_memory_ro(unsigned long addr, int numpages)
 {
 	return __set_memory(addr, numpages, __pgprot(_PAGE_READ),
-- 
2.25.1

