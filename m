Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70F39299A18
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 00:03:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395155AbgJZXDb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 19:03:31 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:51586 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2395136AbgJZXD0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 19:03:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1603753405; x=1635289405;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iPUv/PUCUw9poafNmoCWlV7tTLouxKtDuq6y3HZQDjc=;
  b=YYyZdkGP3eRFgm6yGjwEYony/XzrwIF2cTGZ9kfxKlflrCCzEKz5x/qh
   4zFQ2RcWI/G0RNLozniKPS/zE/j7S2qJO/SqOboCoBYMMJHruFMaelAlO
   OhemXMY8+cgQ/GdvuI54XJASZNs5kxmr17htrJl//rmtJoRA1tT0fhj1o
   DXgav/JbBQw1RbI07rJK5xQO8/TdiVG/+nqmZICw06z8OnqhFKe5R7CWf
   1k7Ok1iEhjnrboyp7/JieXWXlpoOFYNcetbbrK7KRzSv7B44OhM+Yxe5a
   H3Bk1vb6uDjSzR3GtN7RgXzgwYyeXmuSQNHASRtrAgHIQsFWPcySvBpbK
   w==;
IronPort-SDR: LyJH8U8JBmidq0SUfKocvqBCNYdOfxrTuNRud/zVzakCZiY3vb7J8X8yl532uuMjMJm7F+K26e
 VL5G0Huv5bfG/ew+rhxClKONcIYhq4UO6R1kJVyfgRcD+SWaL77kO1jXdKHqNMDWJFRft0xpcA
 L++VlZRyW+et2yRkgZEoupTVer3IJOGhhI8w1a4KRK064qMvzTDnoRl8KDajwzvGvyoXoriKZk
 UM4V3RNop8erPdhDR93UGQ95SNxna1x3/qPQK3O7qJhXPm2RF/rEyyF1ytUJClPfYQKnOHnWYl
 quY=
X-IronPort-AV: E=Sophos;i="5.77,421,1596470400"; 
   d="scan'208";a="151009496"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 27 Oct 2020 07:03:25 +0800
IronPort-SDR: JBFQRiZq2aRNPhunO720Ur0r0/ESN7pwjeCxMvd4fsF5hfQ1jKuAsypnSAYzYlxsnzZeXkbF4n
 hIBk1W2atZBLBv8iNrMV1PXkemJ5ot2qKJYKEVp5t4wKbzMkIeRpUnwO9qq+WoDMQRmMczGvED
 gL4Lr0okoUgiNfB0Zq2EaVO+Mn6pZcc11TqRQvrL1Yy64NnomMcEdtWaue3cjnBO44nrNRVt+9
 nJm30qpcqm4+mgFcv/WlTo6XBGt01a6pXK+pjDZjTBSk6Sw8QdvcdPNxPUBXuAeTwjmQgfqaUu
 Zw907FQgjvqQ8jn7MjM57/sa
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2020 15:49:44 -0700
IronPort-SDR: ey/+IpD7q+PZFkntsCEL5kRkGMghTUQ92D4aSwCY0hicm+MUionuNfl6dBlx3Gh91OzXB6oKuq
 FIrt8TuWoscWKGL5FZGzu4oj0jqXFxfqAjrHGnQLM0h4LD3Er1WjUcaV2wAoJI00VcLs3/mXyS
 /Prep/fH4qGRAmABa+qjbQbvBrGkfszca5mZUfa2SOTn3Nb0sYaGlEKe6wEY2Vo3ZSHVRn7fll
 21NHZZZaa3XJN3YV/d0MMiVrPYSdIbcOhg7XGcbFSgMmsM0NEy7Y5E1i8priVbwPj6Z7qmOgj+
 tBg=
WDCIronportException: Internal
Received: from 8223p12.ad.shared (HELO jedi-01.hgst.com) ([10.86.60.110])
  by uls-op-cesaip02.wdc.com with ESMTP; 26 Oct 2020 16:03:26 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anup Patel <anup@brainfault.org>,
        Ard Biesheuvel <ardb@kernel.org>, Borislav Petkov <bp@suse.de>,
        Greentime Hu <greentime.hu@sifive.com>,
        Kees Cook <keescook@chromium.org>,
        linux-riscv@lists.infradead.org,
        Michel Lespinasse <walken@google.com>,
        Mike Rapoport <rppt@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Zong Li <zong.li@sifive.com>
Subject: [PATCH v2 5/6] RISC-V: Protect .init.text & .init.data
Date:   Mon, 26 Oct 2020 16:02:53 -0700
Message-Id: <20201026230254.911912-6-atish.patra@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201026230254.911912-1-atish.patra@wdc.com>
References: <20201026230254.911912-1-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, .init.text & .init.data are intermixed which makes it impossible
apply different permissions to them. .init.data shouldn't need exec
permissions while .init.text shouldn't have write permission.

Keep them in separate sections so that different permissions are applied to
each section. This improves the kernel protection under
CONFIG_STRICT_KERNEL_RWX. We also need to restore the permissions for the
entire _init section after it is freed so that those pages can be used for
other purpose.

Signed-off-by: Atish Patra <atish.patra@wdc.com>
---
 arch/riscv/include/asm/sections.h   |  2 ++
 arch/riscv/include/asm/set_memory.h |  2 ++
 arch/riscv/kernel/setup.c           |  9 +++++
 arch/riscv/kernel/vmlinux.lds.S     | 51 ++++++++++++++++-------------
 arch/riscv/mm/init.c                |  8 ++++-
 arch/riscv/mm/pageattr.c            |  6 ++++
 6 files changed, 54 insertions(+), 24 deletions(-)

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
index 4cc3a4e2afd3..913429c9c1ae 100644
--- a/arch/riscv/include/asm/set_memory.h
+++ b/arch/riscv/include/asm/set_memory.h
@@ -15,6 +15,7 @@ int set_memory_ro(unsigned long addr, int numpages);
 int set_memory_rw(unsigned long addr, int numpages);
 int set_memory_x(unsigned long addr, int numpages);
 int set_memory_nx(unsigned long addr, int numpages);
+int set_memory_default(unsigned long addr, int numpages);
 void protect_kernel_text_data(void);
 #else
 static inline int set_memory_ro(unsigned long addr, int numpages) { return 0; }
@@ -22,6 +23,7 @@ static inline int set_memory_rw(unsigned long addr, int numpages) { return 0; }
 static inline int set_memory_x(unsigned long addr, int numpages) { return 0; }
 static inline int set_memory_nx(unsigned long addr, int numpages) { return 0; }
 static inline void protect_kernel_text_data(void) {};
+static inline int set_memory_default(unsigned long addr, int numpages) { return 0; }
 #endif
 
 int set_direct_map_invalid_noflush(struct page *page);
diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
index b722c5bf892c..abfbdc8cfef3 100644
--- a/arch/riscv/kernel/setup.c
+++ b/arch/riscv/kernel/setup.c
@@ -123,3 +123,12 @@ static int __init topology_init(void)
 	return 0;
 }
 subsys_initcall(topology_init);
+
+void free_initmem(void)
+{
+	unsigned long init_begin = (unsigned long)__init_begin;
+	unsigned long init_end = (unsigned long)__init_end;
+
+	set_memory_default(init_begin, (init_end - init_begin) >> PAGE_SHIFT);
+	free_initmem_default(POISON_FREE_INITMEM);
+}
diff --git a/arch/riscv/kernel/vmlinux.lds.S b/arch/riscv/kernel/vmlinux.lds.S
index cacd7898ba7f..0a1874e48e8a 100644
--- a/arch/riscv/kernel/vmlinux.lds.S
+++ b/arch/riscv/kernel/vmlinux.lds.S
@@ -29,6 +29,26 @@ SECTIONS
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
+#ifdef CONFIG_EFI
+	. = ALIGN(PECOFF_SECTION_ALIGNMENT);
+	__pecoff_text_end = .;
+#endif
+	. = ALIGN(SECTION_ALIGN);
 	__init_begin = .;
 	__init_text_begin = .;
 	.init.text : AT(ADDR(.init.text) - LOAD_OFFSET) ALIGN(SECTION_ALIGN) { \
@@ -53,35 +73,20 @@ SECTIONS
 	{
 		EXIT_TEXT
 	}
+
+	__init_text_end = .;
+	. = ALIGN(SECTION_ALIGN);
+	/* Start of init data section */
+	__init_data_begin = .;
+	INIT_DATA_SECTION(16)
 	.exit.data :
 	{
 		EXIT_DATA
 	}
 	PERCPU_SECTION(L1_CACHE_BYTES)
-	__init_end = .;
 
-	. = ALIGN(SECTION_ALIGN);
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
-#ifdef CONFIG_EFI
-	. = ALIGN(PECOFF_SECTION_ALIGNMENT);
-	__pecoff_text_end = .;
-#endif
-
-	INIT_DATA_SECTION(16)
+	__init_data_end = .;
+	__init_end = .;
 
 	/* Start of data section */
 	_sdata = .;
diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index 5f196f8158d4..1bb3821d81d5 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -610,13 +610,19 @@ static inline void setup_vm_final(void)
 #ifdef CONFIG_STRICT_KERNEL_RWX
 void protect_kernel_text_data(void)
 {
-	unsigned long text_start = (unsigned long)_text;
+	unsigned long text_start = (unsigned long)_start;
 	unsigned long text_end = (unsigned long)_etext;
+	unsigned long init_text_start = (unsigned long)__init_text_begin;
+	unsigned long init_text_end = (unsigned long)__init_text_end;
+	unsigned long init_data_start = (unsigned long)__init_data_begin;
+	unsigned long init_data_end = (unsigned long)__init_data_end;
 	unsigned long rodata_start = (unsigned long)__start_rodata;
 	unsigned long data_start = (unsigned long)_data;
 	unsigned long max_low = (unsigned long)(__va(PFN_PHYS(max_low_pfn)));
 
+	set_memory_ro(init_text_start, (init_text_end - init_text_start) >> PAGE_SHIFT);
 	set_memory_ro(text_start, (text_end - text_start) >> PAGE_SHIFT);
+	set_memory_nx(init_data_start, (init_data_end - init_data_start) >> PAGE_SHIFT);
 	set_memory_nx(rodata_start, (data_start - rodata_start) >> PAGE_SHIFT);
 	set_memory_nx(data_start, (max_low - data_start) >> PAGE_SHIFT);
 }
diff --git a/arch/riscv/mm/pageattr.c b/arch/riscv/mm/pageattr.c
index 19fecb362d81..04f3fc16aa9c 100644
--- a/arch/riscv/mm/pageattr.c
+++ b/arch/riscv/mm/pageattr.c
@@ -128,6 +128,12 @@ static int __set_memory(unsigned long addr, int numpages, pgprot_t set_mask,
 	return ret;
 }
 
+int set_memory_default(unsigned long addr, int numpages)
+{
+	return __set_memory(addr, numpages, __pgprot(_PAGE_KERNEL),
+			    __pgprot(_PAGE_EXEC));
+}
+
 int set_memory_ro(unsigned long addr, int numpages)
 {
 	return __set_memory(addr, numpages, __pgprot(_PAGE_READ),
-- 
2.25.1

