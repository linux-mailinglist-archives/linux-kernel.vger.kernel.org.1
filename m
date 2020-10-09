Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1703B289A7C
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 23:14:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391399AbgJIVOE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 17:14:04 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:50446 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391339AbgJIVN4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 17:13:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1602278542; x=1633814542;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/rFWaVS2Mp29X2G5njahMGadr4BBV3Wqr3D/UpzWpM8=;
  b=nI1KzleqwopTHZwjjWoB6JNNdPSGKvDx6ToqItUPBIu2k25W8iftgivw
   4x/lgkJ9iH9LnR1+k35DyRgIZJYOUvXVWosKLy9L9qUYEV9InZSgVF3Rw
   QXWH2ijswIA3j4T4N73LRIiE01oKJmMq1ubN8t9Sbr5xYHbSMSQoBEyu+
   Aob8x0xjMdnkyRo9KTZpTDSv7AyCRAhwjVjdIufvKKlVb8jCVlxqWytsS
   hVFaYAshTKLGuB5YCo3D9jUhloSsD/voe83p3FunfMl+mMDkhbkHhvGUY
   5tiIvEDrVdWY+u5Je1+7H7Zuyt6aYoSxiXgrPkrIkf7eyY/hMCVYf2C9g
   w==;
IronPort-SDR: g2g+anQOCCSS6IXwVIJG97nt/W58OmpZJKjirWvfA3UiUvKQlcReV12q/trhQnS7jKXi1qZohe
 Z+yI35nqUUirj1BZCyC/X18l4aSQzFvBapZndXJYI2mvSplFKLfin4cYmFS8cVb3/hCDyxjz2K
 5I+L9cIoGmUVTX9wWj7IImjdkJg7OzDLYgRg10h527M1wp0kWiKX+dcePZ4bSknBPeVEs40Gfa
 YZ4KIF1XOyYgvxMGR0ez0+T3om8wR2qrzuHy4r/1tDAOwV2lFfwFRMJV6YD29VHPYWaggwybG6
 ud8=
X-IronPort-AV: E=Sophos;i="5.77,356,1596470400"; 
   d="scan'208";a="252936941"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 10 Oct 2020 05:22:21 +0800
IronPort-SDR: +TvCtfhpjbMHT2aDMvfGXpmFRab7VHVZjIGJGeSOOiuQs1VnnA+mXMJq9SvF7KdW1JCpdKReSg
 LHsSQXivNq+rROkfqIjxhIgmoJJnL/HlTiqPa/9YubkmI5ravacmIGAvCgBwBU650hiZJUGSqg
 VA/TGVUqYihcPYPvqPXQhofzWdWuSL284zvrw+lCPgrCRYc2h+nvjqKSF9aXG5OEEtXlZKS816
 HJgfdCAJGQ94K99TfYGZrr5bfQbKgfe+lW6LINTI3vf6MYrt4cx8yh4KurBVLJiG/C3xwZdUOW
 AGNo0fet2LNC0qs1MubsaoqJ
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2020 13:59:42 -0700
IronPort-SDR: vm6/p5xIqey4ku5y72/6cCg/OOc897k5XjcVj4FdaEbbZDVCqcq4mtvLumHn2E24vNG6BFLfrL
 912oWzPCuZmN2zDXb3PgxZBnOqpcCPq9fMDZBxTuUudr23AxRDHvlHa/zPDeiMfZxxDFhvTuky
 7czWnLbJZ6V5eBNSjxQCyeAoKDbjENsMPgEGOrZXdrH8gm1AKioXf1z5JKxljqEWNrxJhp/uho
 Giuf2oHZim1ErI19qM5Uuo/QkTDEP+CwFfP7hmgoD3GA3kPXZTihlsKZfLn55pv/KHYwvJ9z++
 1UA=
WDCIronportException: Internal
Received: from usa003000.ad.shared (HELO jedi-01.hgst.com) ([10.86.60.38])
  by uls-op-cesaip01.wdc.com with ESMTP; 09 Oct 2020 14:13:55 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anup Patel <anup@brainfault.org>,
        Ard Biesheuvel <ardb@kernel.org>, Borislav Petkov <bp@suse.de>,
        Greentime Hu <greentime.hu@sifive.com>,
        Guo Ren <guoren@linux.alibaba.com>,
        Kees Cook <keescook@chromium.org>,
        linux-riscv@lists.infradead.org,
        Michel Lespinasse <walken@google.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Zong Li <zong.li@sifive.com>
Subject: [PATCH 4/5] RISC-V: Protect .init.text & .init.data
Date:   Fri,  9 Oct 2020 14:13:43 -0700
Message-Id: <20201009211344.2358688-5-atish.patra@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201009211344.2358688-1-atish.patra@wdc.com>
References: <20201009211344.2358688-1-atish.patra@wdc.com>
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
 arch/riscv/kernel/setup.c           |  4 ++++
 arch/riscv/kernel/vmlinux.lds.S     | 10 +++++++++-
 arch/riscv/mm/init.c                |  6 ++++++
 arch/riscv/mm/pageattr.c            |  6 ++++++
 6 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/include/asm/sections.h b/arch/riscv/include/asm/sections.h
index d60802bfafbc..730d2c4a844d 100644
--- a/arch/riscv/include/asm/sections.h
+++ b/arch/riscv/include/asm/sections.h
@@ -10,6 +10,8 @@
 #include <asm-generic/sections.h>
 extern char _start[];
 extern char _start_kernel[];
+extern char __init_data_begin[], __init_data_end[];
+extern char __init_text_begin[], __init_text_end[];
 
 extern bool init_mem_is_free;
 
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
index 4176a2affd1d..b8a35ef0eab0 100644
--- a/arch/riscv/kernel/setup.c
+++ b/arch/riscv/kernel/setup.c
@@ -129,6 +129,10 @@ bool init_mem_is_free = false;
 
 void free_initmem(void)
 {
+	unsigned long init_begin = (unsigned long)__init_begin;
+	unsigned long init_end = (unsigned long)__init_end;
+
+	set_memory_default(init_begin, (init_end - init_begin) >> PAGE_SHIFT);
 	free_initmem_default(POISON_FREE_INITMEM);
 	init_mem_is_free = true;
 }
diff --git a/arch/riscv/kernel/vmlinux.lds.S b/arch/riscv/kernel/vmlinux.lds.S
index 0807633f0dc8..15b9882588ae 100644
--- a/arch/riscv/kernel/vmlinux.lds.S
+++ b/arch/riscv/kernel/vmlinux.lds.S
@@ -30,8 +30,8 @@ SECTIONS
 	. = ALIGN(PAGE_SIZE);
 
 	__init_begin = .;
+	__init_text_begin = .;
 	INIT_TEXT_SECTION(PAGE_SIZE)
-	INIT_DATA_SECTION(16)
 	. = ALIGN(8);
 	__soc_early_init_table : {
 		__soc_early_init_table_start = .;
@@ -48,11 +48,19 @@ SECTIONS
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
+
+	__init_data_end = .;
 	__init_end = .;
 
 	. = ALIGN(SECTION_ALIGN);
diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index 7859a1d1b34d..3ef0eafcc7c7 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -627,11 +627,17 @@ void protect_kernel_text_data(void)
 {
 	unsigned long text_start = (unsigned long)_text;
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
index 19fecb362d81..aecedaf086ab 100644
--- a/arch/riscv/mm/pageattr.c
+++ b/arch/riscv/mm/pageattr.c
@@ -128,6 +128,12 @@ static int __set_memory(unsigned long addr, int numpages, pgprot_t set_mask,
 	return ret;
 }
 
+int set_memory_default(unsigned long addr, int numpages)
+{
+	return __set_memory(addr, numpages, __pgprot(_PAGE_KERNEL | _PAGE_EXEC),
+			    __pgprot(0));
+}
+
 int set_memory_ro(unsigned long addr, int numpages)
 {
 	return __set_memory(addr, numpages, __pgprot(_PAGE_READ),
-- 
2.25.1

