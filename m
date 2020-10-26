Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EE8C299A1D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 00:04:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395198AbgJZXDz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 19:03:55 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:51595 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2395116AbgJZXDZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 19:03:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1603753405; x=1635289405;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rpPh1ri27/mV4Lq6GihXSvX59Cmyy4U53NNqLUWVVFg=;
  b=fhcF2pFofLjFZhEbJmquzRNNXTWwjJ5Ti8vsfr81R5JJGs4vZD/QdkGK
   wlZ8H1v07NF5CfxKsy89Ud1VDpblj6JlsM7YaTSAEK8qQ/gQs9rS255Sx
   mhh3W56e1tytCoweCypUcRwhxIMojfiQmFLr3QZc0E+u+IlKcNqd8hBiL
   0GtgVTli3HdacZE6efvBWPyygzrdFUAgt4hiuOmbYE0btPTdiJLJwLsQL
   PZVNen78VFy9Vfk5HzBJvy1vU74AFU5X5fjn0iEGPPkzlWKLpUn5OSNU1
   mSYCYj063NBkZHhgzP40+YTB8smU/cBQWxjLsqG3S5yvl3f20bafIin0j
   Q==;
IronPort-SDR: B0o7UAs69/aLCPEH+Xj56HSWfnuUBpeRCMpV9NFLT4nRew2yRoCKwsYWpR9uUM7qmagjWLi/cd
 fv6lRu9JYX8u1mcMaHyaOHVTZQG5SmOWEZr8KFMkS/2ZggJG9/AiaCU/Zmif/ODnD9HR3r0xFx
 rYhG6Eb2ZGFKnW79Qj8WKvjQ8bXLSKLxtah4Nj7LxOcsVFWi9f/wkEiiugftf9SgrdSKgXvkm/
 86eaDnPGJn/fet55C9736EjW45U2Bm2wpw5/aR5280WSN9KYDoxwVEtOcZDn7hXvsWG1egBFI1
 dt0=
X-IronPort-AV: E=Sophos;i="5.77,421,1596470400"; 
   d="scan'208";a="151009480"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 27 Oct 2020 07:03:24 +0800
IronPort-SDR: sB0DUq00WvyxkccbVjCUkNVpSYXkTFIveUNsBGigNQfp3il5Z144gOBYbn8WSO50XC8U4twOAq
 3KGWHAw1jOBb6fFgY83GeYfT+undThITXoi5iBZAE8lNI+jwAln6CieBXG2mGO/Fskbn1F5vrW
 mlDvMCpWJGcnsckM7uuJvek5Ki0N6fdf+HASQiHN4WttC7tEDvRlH5rIH0JZonlk1If0ihv7EU
 UrRfaUkSBZ8RLIP0DI+f7Qb6A3lTPZbUo9oWA2MwnJEneHZqf4Vu04O3iCI7Y2pkzbphNKBG6n
 3fsNDl9vXIF9fwnTkPXKdTh9
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2020 15:49:43 -0700
IronPort-SDR: rriut/QXTurmMnXEV+/wkdh18jeVeIaUuF5OpX2DpiAjha4uQ2m8xvQ2+CYVPztIlri/dGG9Fx
 sn4DjUGAMl9xld4i92d4WY0ChJTrDHbpMX+/nWTBiwVYjSvhmt8dWvvRfITcAe8aHbsJflfw31
 X7bMdmMoJiKhs3WflXZAL19ePomMnN9ectpJbqja3ffpDKFD6UTBM+ZaybUNAdN7ZoQ4QlFV6l
 1tP01QkDPJPYD5O1x+9fKaT5edDaRfBK6oaYcjCM8Jv0VUQ424prp5C290AGcHQRTt2fhXTuUe
 LPU=
WDCIronportException: Internal
Received: from 8223p12.ad.shared (HELO jedi-01.hgst.com) ([10.86.60.110])
  by uls-op-cesaip02.wdc.com with ESMTP; 26 Oct 2020 16:03:25 -0700
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
Subject: [PATCH v2 3/6] RISC-V: Enforce protections for kernel sections early
Date:   Mon, 26 Oct 2020 16:02:51 -0700
Message-Id: <20201026230254.911912-4-atish.patra@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201026230254.911912-1-atish.patra@wdc.com>
References: <20201026230254.911912-1-atish.patra@wdc.com>
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
index 7d6a04ae3929..b722c5bf892c 100644
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
@@ -92,6 +93,7 @@ void __init setup_arch(char **cmdline_p)
 #if IS_ENABLED(CONFIG_RISCV_SBI)
 	sbi_init();
 #endif
+	protect_kernel_text_data();
 #ifdef CONFIG_SWIOTLB
 	swiotlb_init(1);
 #endif
diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index ea933b789a88..5f196f8158d4 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -608,7 +608,7 @@ static inline void setup_vm_final(void)
 #endif /* CONFIG_MMU */
 
 #ifdef CONFIG_STRICT_KERNEL_RWX
-void mark_rodata_ro(void)
+void protect_kernel_text_data(void)
 {
 	unsigned long text_start = (unsigned long)_text;
 	unsigned long text_end = (unsigned long)_etext;
@@ -617,9 +617,16 @@ void mark_rodata_ro(void)
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

