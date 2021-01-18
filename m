Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A18CE2FACC9
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 22:38:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394762AbhARVhE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 16:37:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:39340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389453AbhARKDY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 05:03:24 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 929DD22B39;
        Mon, 18 Jan 2021 10:00:30 +0000 (UTC)
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1l1R6t-008RhD-Hw; Mon, 18 Jan 2021 09:46:07 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        David Brazdil <dbrazdil@google.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Jing Zhang <jingzhangos@google.com>,
        Ajay Patil <pajay@qti.qualcomm.com>,
        Prasad Sodagudi <psodagud@codeaurora.org>,
        Srinivas Ramana <sramana@codeaurora.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        kernel-team@android.com
Subject: [PATCH v4 11/21] arm64: Extract early FDT mapping from kaslr_early_init()
Date:   Mon, 18 Jan 2021 09:45:23 +0000
Message-Id: <20210118094533.2874082-12-maz@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210118094533.2874082-1-maz@kernel.org>
References: <20210118094533.2874082-1-maz@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org, catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com, dbrazdil@google.com, alexandru.elisei@arm.com, ardb@kernel.org, jingzhangos@google.com, pajay@qti.qualcomm.com, psodagud@codeaurora.org, sramana@codeaurora.org, james.morse@arm.com, julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As we want to parse more options very early in the kernel lifetime,
let's always map the FDT early. This is achieved by moving that
code out of kaslr_early_init().

No functionnal change expected.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 arch/arm64/include/asm/setup.h | 11 +++++++++++
 arch/arm64/kernel/head.S       |  3 ++-
 arch/arm64/kernel/kaslr.c      |  7 +++----
 arch/arm64/kernel/setup.c      | 15 +++++++++++++++
 4 files changed, 31 insertions(+), 5 deletions(-)
 create mode 100644 arch/arm64/include/asm/setup.h

diff --git a/arch/arm64/include/asm/setup.h b/arch/arm64/include/asm/setup.h
new file mode 100644
index 000000000000..d3320618ed14
--- /dev/null
+++ b/arch/arm64/include/asm/setup.h
@@ -0,0 +1,11 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#ifndef __ARM64_ASM_SETUP_H
+#define __ARM64_ASM_SETUP_H
+
+#include <uapi/asm/setup.h>
+
+void *get_early_fdt_ptr(void);
+void early_fdt_map(u64 dt_phys);
+
+#endif
diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index b425d2587cdb..d74e5f84042e 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -433,6 +433,8 @@ SYM_FUNC_START_LOCAL(__primary_switched)
 	bl	__pi_memset
 	dsb	ishst				// Make zero page visible to PTW
 
+	mov	x0, x21				// pass FDT address in x0
+	bl	early_fdt_map			// Try mapping the FDT early
 	bl	switch_to_vhe
 #if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
 	bl	kasan_early_init
@@ -440,7 +442,6 @@ SYM_FUNC_START_LOCAL(__primary_switched)
 #ifdef CONFIG_RANDOMIZE_BASE
 	tst	x23, ~(MIN_KIMG_ALIGN - 1)	// already running randomized?
 	b.ne	0f
-	mov	x0, x21				// pass FDT address in x0
 	bl	kaslr_early_init		// parse FDT for KASLR options
 	cbz	x0, 0f				// KASLR disabled? just proceed
 	orr	x23, x23, x0			// record KASLR offset
diff --git a/arch/arm64/kernel/kaslr.c b/arch/arm64/kernel/kaslr.c
index 1c74c45b9494..5fc86e7d01a1 100644
--- a/arch/arm64/kernel/kaslr.c
+++ b/arch/arm64/kernel/kaslr.c
@@ -19,6 +19,7 @@
 #include <asm/memory.h>
 #include <asm/mmu.h>
 #include <asm/sections.h>
+#include <asm/setup.h>
 
 enum kaslr_status {
 	KASLR_ENABLED,
@@ -92,12 +93,11 @@ static __init bool is_kaslr_disabled_cmdline(void *fdt)
  * containing function pointers) to be reinitialized, and zero-initialized
  * .bss variables will be reset to 0.
  */
-u64 __init kaslr_early_init(u64 dt_phys)
+u64 __init kaslr_early_init(void)
 {
 	void *fdt;
 	u64 seed, offset, mask, module_range;
 	unsigned long raw;
-	int size;
 
 	/*
 	 * Set a reasonable default for module_alloc_base in case
@@ -111,8 +111,7 @@ u64 __init kaslr_early_init(u64 dt_phys)
 	 * and proceed with KASLR disabled. We will make another
 	 * attempt at mapping the FDT in setup_machine()
 	 */
-	early_fixmap_init();
-	fdt = fixmap_remap_fdt(dt_phys, &size, PAGE_KERNEL);
+	fdt = get_early_fdt_ptr();
 	if (!fdt) {
 		kaslr_status = KASLR_DISABLED_FDT_REMAP;
 		return 0;
diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index c18aacde8bb0..01a994730754 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -168,6 +168,21 @@ static void __init smp_build_mpidr_hash(void)
 		pr_warn("Large number of MPIDR hash buckets detected\n");
 }
 
+static void *early_fdt_ptr __initdata;
+
+void __init *get_early_fdt_ptr(void)
+{
+	return early_fdt_ptr;
+}
+
+void __init early_fdt_map(u64 dt_phys)
+{
+	int fdt_size;
+
+	early_fixmap_init();
+	early_fdt_ptr = fixmap_remap_fdt(dt_phys, &fdt_size, PAGE_KERNEL);
+}
+
 static void __init setup_machine_fdt(phys_addr_t dt_phys)
 {
 	int size;
-- 
2.29.2

