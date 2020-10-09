Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19CBC289A7B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 23:14:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391464AbgJIVOI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 17:14:08 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:50437 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391321AbgJIVNz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 17:13:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1602278541; x=1633814541;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Fglb0o2Ozn6JOzVy78SpXXGYj0jpbArC9/S0MZnBZpA=;
  b=mzmHS7YOlkpjQ4ljyXaO1NZ2Q1b2HC0U1p8zqzXE18Tr7djAsa5Djqaj
   vJVRx9WZaEOTh+15k78FVchdWWvHBEklJ2bx3Z2wrIf1/BMHIQLNr2vtk
   5qfG74tfr1relE5nvwJSuEOKnq5dxNID/jOqmhBTKXXVdJ50jBLkAu19X
   dCCgXLtmfn3/aJuT/d4mgZmeWPS76coUxdF+xTIfRMB1/l+JnTw7ssRYB
   nFzdVjNSaZYIeXy9UHDrGQ6jFIeEHW39ymDfJgWVBHg/VDqaNfZ2Fl7LH
   P1pKwLpN5yQmipmmYim6iFI6+p7yFlX+U4Nwpt/niukaDKQf1CAfCVmXG
   Q==;
IronPort-SDR: LE+5nH5EEra8SmpWUDJ2aO9pNH1HAzShMWl0SATvuV1A1MHblx75m+zhStMdFiyMwhKV3PwpjG
 yOUUnPZCvJHGkDi//m8KANGAiCyi5B2b7cjjGUBbXrQCe4PAZdKDFBFY8UUn42R5z0EQ0pybei
 e7iKL1fl/yLAGXfZBWHZXbEOmmK0utVndCPrgdCgMT65jWrnJM0j3WdhNrKkHOF2IRy41Qq3Kw
 HN+9T5mFLjMGBKbjavMN4gaaP68SNwoKr+X/P0TtYg+o/qHOtwdCu7mMK3bCW0qlyr4xg2gksn
 rUU=
X-IronPort-AV: E=Sophos;i="5.77,356,1596470400"; 
   d="scan'208";a="252936937"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 10 Oct 2020 05:22:21 +0800
IronPort-SDR: 6R2VbyT48R60U3t8RdWoiA/1weQN3dEQIFBX5aCfLH8C0d4GYe4y72hUx242kEQg6HCMIvPaIK
 /H7XMPfzgpB5nPTQMfNdxsIsRVTlcy/XzmfxXjCrmNfnuXCZuiMQUyJLXP2NEmwWMfsnwgsUuW
 Gi25MzBl8dLLVtvwkYU25IoeocHRzo+5mz54eVDDKh3DEYaMarpmgLSXpEB58PDMYVr+PBVHzJ
 Vodyj+O9I5MQRnGcKpUr9Vvo8y4V1WVr9R6Dx/y0kUoTSdGb3MqbENVXpCaF03WcpXTgKLT1Lc
 rmKvX6a4N3pAUL6Us+R0hTtm
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2020 13:59:42 -0700
IronPort-SDR: eXGMo36/52VIraPdKKeyD28xmyCV+mQZPzhV/YTH64o581o6ScGk7bLiN93yXBMQTCkjGuOkms
 0N3E+GW1tdh1bVCCL+QBeaHOw6asvHx1UicY9iUd+c7IwJC+woP9ogmP4SjWFEqSXWoZ68n8AD
 O7Altp7APqErBc3jAA0g2uQ7iaM6hBC35fHXn6hUhEGKsJKLgTASVOqhsG+/UTKMHTj6+gSF8l
 4Q/1ezkRYQmZ27+AEIEptvxYcveQOB3bPouGAM9EXcXwnvA526DJKdotAeu/3T6TgoxTKknKj1
 H+E=
WDCIronportException: Internal
Received: from usa003000.ad.shared (HELO jedi-01.hgst.com) ([10.86.60.38])
  by uls-op-cesaip01.wdc.com with ESMTP; 09 Oct 2020 14:13:54 -0700
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
Subject: [PATCH 3/5] RISC-V: Enforce protections for kernel sections early
Date:   Fri,  9 Oct 2020 14:13:42 -0700
Message-Id: <20201009211344.2358688-4-atish.patra@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201009211344.2358688-1-atish.patra@wdc.com>
References: <20201009211344.2358688-1-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, all memblocks are mapped with PAGE_KERNEL_EXEC and the strict
permissions are only enforced after /init starts. This leaves the kernel
vulnerable from possible buggy built-in modules.

Apply permissions to individual sections as early as possible.

Signed-off-by: Atish Patra <atish.patra@wdc.com>
---
 arch/riscv/include/asm/set_memory.h |  2 ++
 arch/riscv/kernel/setup.c           |  2 ++
 arch/riscv/mm/init.c                | 11 +++++++++--
 3 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/include/asm/set_memory.h b/arch/riscv/include/asm/set_memory.h
index 4c5bae7ca01c..4cc3a4e2afd3 100644
--- a/arch/riscv/include/asm/set_memory.h
+++ b/arch/riscv/include/asm/set_memory.h
@@ -15,11 +15,13 @@ int set_memory_ro(unsigned long addr, int numpages);
 int set_memory_rw(unsigned long addr, int numpages);
 int set_memory_x(unsigned long addr, int numpages);
 int set_memory_nx(unsigned long addr, int numpages);
+void protect_kernel_text_data(void);
 #else
 static inline int set_memory_ro(unsigned long addr, int numpages) { return 0; }
 static inline int set_memory_rw(unsigned long addr, int numpages) { return 0; }
 static inline int set_memory_x(unsigned long addr, int numpages) { return 0; }
 static inline int set_memory_nx(unsigned long addr, int numpages) { return 0; }
+static inline void protect_kernel_text_data(void) {};
 #endif
 
 int set_direct_map_invalid_noflush(struct page *page);
diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
index a5cac440aadf..4176a2affd1d 100644
--- a/arch/riscv/kernel/setup.c
+++ b/arch/riscv/kernel/setup.c
@@ -23,6 +23,7 @@
 #include <asm/cpu_ops.h>
 #include <asm/early_ioremap.h>
 #include <asm/setup.h>
+#include <asm/set_memory.h>
 #include <asm/sections.h>
 #include <asm/sbi.h>
 #include <asm/tlbflush.h>
@@ -93,6 +94,7 @@ void __init setup_arch(char **cmdline_p)
 #if IS_ENABLED(CONFIG_RISCV_SBI)
 	sbi_init();
 #endif
+	protect_kernel_text_data();
 #ifdef CONFIG_SWIOTLB
 	swiotlb_init(1);
 #endif
diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index c888c4470b34..7859a1d1b34d 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -623,7 +623,7 @@ static inline void setup_vm_final(void)
 #endif /* CONFIG_MMU */
 
 #ifdef CONFIG_STRICT_KERNEL_RWX
-void mark_rodata_ro(void)
+void protect_kernel_text_data(void)
 {
 	unsigned long text_start = (unsigned long)_text;
 	unsigned long text_end = (unsigned long)_etext;
@@ -632,9 +632,16 @@ void mark_rodata_ro(void)
 	unsigned long max_low = (unsigned long)(__va(PFN_PHYS(max_low_pfn)));
 
 	set_memory_ro(text_start, (text_end - text_start) >> PAGE_SHIFT);
-	set_memory_ro(rodata_start, (data_start - rodata_start) >> PAGE_SHIFT);
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
-- 
2.25.1

