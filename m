Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6901E2B52FA
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 21:45:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387445AbgKPUnd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 15:43:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726200AbgKPUnd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 15:43:33 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9FEFC0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 12:43:32 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id a65so586425wme.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 12:43:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QlMR2fhUIhxw06ik3ZhMESov9sgfWs+L8rQ6iDwTxeg=;
        b=ckOgL/XcXmzoFPa38YuXoHMeAR9K/h3Lwh32nXroabX2ewUvFUSApQ2xYngzuy+ZSc
         slJjEPf2zDCXUMtZW3STAbZo2SErjL+5tAPI4vKU6teBsW59cgFybiHzxWKeTvqal/UX
         a+wG//8o7z9gjaxhLFN1eDQKj8PID5qY00QlPT+0WwyEWdquQBrXaIRrSNOJHplY6t+1
         SirNyvrEG2cn75Ab/LgNhvsJQxjMDhW3I3OG7S5QA/4dhI0rhTBXZJ2BLARf0VtRNi6b
         H2AdD1gW2lWmZTsH4MVkhMyJVkkcQF2NQNXRh/yKrOQFyovCBRqki3JWm8utq/lUuOOg
         tMCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QlMR2fhUIhxw06ik3ZhMESov9sgfWs+L8rQ6iDwTxeg=;
        b=H7s0HMxe4Z0ryPR/bdS9bX6U+JmkR8XB+gtLHwc8ap9TsqwFR+MXGSelnGxChAgZ+t
         W5ZGhgSBuxCM1c858PZCxZwwEl9g3yHANEgltU3uXYz4cM4leOtR8TgGVvmsT4BKsY8i
         73gznQE8K9ziMUIXSEFSJWp839TB0C0K4YhheE61UULapZSXedENcnw8XT5L1iAgN9Ya
         3cs3E5xx+rUXx/OUeb+xEk+0L5D8IDWbh0d7h8sHqt5qK8/ckgMS48jWhHrf8oAMiiI+
         X5EkaNVvRyTktf9Kaif+qch1fJCL+naAPFdqrDTm4Wzc0xVH1Ym3IBuVBt/rNGQjho35
         lriw==
X-Gm-Message-State: AOAM5336MP8ihKqdGE3WnWAvgYeUnXew6loZh7oJzEnr/O/NH/L3bJjN
        SSqJ7TZVFfQNxZT/RE4yGSDCcQ==
X-Google-Smtp-Source: ABdhPJzKJ+aizqXge4AnyEaKAmJihT9yZO4enNtb4XFVvxg/gtJ90UcaLqf0W+73Sq4BM5iN5I9xeg==
X-Received: by 2002:a1c:20d0:: with SMTP id g199mr797125wmg.68.1605559411340;
        Mon, 16 Nov 2020 12:43:31 -0800 (PST)
Received: from localhost ([2a01:4b00:8523:2d03:bc40:bd71:373a:1b33])
        by smtp.gmail.com with ESMTPSA id f5sm25099875wrg.32.2020.11.16.12.43.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Nov 2020 12:43:30 -0800 (PST)
From:   David Brazdil <dbrazdil@google.com>
To:     kvmarm@lists.cs.columbia.edu
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Dennis Zhou <dennis@kernel.org>,
        Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Quentin Perret <qperret@google.com>,
        Andrew Scull <ascull@google.com>,
        Andrew Walbran <qwandor@google.com>, kernel-team@android.com,
        David Brazdil <dbrazdil@google.com>
Subject: [PATCH v2 04/24] arm64: Move MAIR_EL1_SET to asm/memory.h
Date:   Mon, 16 Nov 2020 20:42:58 +0000
Message-Id: <20201116204318.63987-5-dbrazdil@google.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201116204318.63987-1-dbrazdil@google.com>
References: <20201116204318.63987-1-dbrazdil@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

KVM currently initializes MAIR_EL2 to the value of MAIR_EL1. In
preparation for initializing MAIR_EL2 before MAIR_EL1, move the constant
into a shared header file. Since it is used for EL1 and EL2, rename to
MAIR_ELx_SET.

Signed-off-by: David Brazdil <dbrazdil@google.com>
---
 arch/arm64/include/asm/memory.h | 29 ++++++++++++++---------------
 arch/arm64/include/asm/sysreg.h | 30 ++++++++++++++++++++++++++++++
 arch/arm64/mm/proc.S            | 15 +--------------
 3 files changed, 45 insertions(+), 29 deletions(-)

diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
index cd61239bae8c..8ae8fd883a0c 100644
--- a/arch/arm64/include/asm/memory.h
+++ b/arch/arm64/include/asm/memory.h
@@ -13,6 +13,7 @@
 #include <linux/const.h>
 #include <linux/sizes.h>
 #include <asm/page-def.h>
+#include <asm/sysreg.h>
 
 /*
  * Size of the PCI I/O space. This must remain a power of two so that
@@ -124,21 +125,6 @@
  */
 #define SEGMENT_ALIGN		SZ_64K
 
-/*
- * Memory types available.
- *
- * IMPORTANT: MT_NORMAL must be index 0 since vm_get_page_prot() may 'or' in
- *	      the MT_NORMAL_TAGGED memory type for PROT_MTE mappings. Note
- *	      that protection_map[] only contains MT_NORMAL attributes.
- */
-#define MT_NORMAL		0
-#define MT_NORMAL_TAGGED	1
-#define MT_NORMAL_NC		2
-#define MT_NORMAL_WT		3
-#define MT_DEVICE_nGnRnE	4
-#define MT_DEVICE_nGnRE		5
-#define MT_DEVICE_GRE		6
-
 /*
  * Memory types for Stage-2 translation
  */
@@ -152,6 +138,19 @@
 #define MT_S2_FWB_NORMAL	6
 #define MT_S2_FWB_DEVICE_nGnRE	1
 
+/*
+ * Default MAIR_EL1. MT_NORMAL_TAGGED is initially mapped as Normal memory and
+ * changed during __cpu_setup to Normal Tagged if the system supports MTE.
+ */
+#define MAIR_ELx_SET							\
+	(MAIR_ATTRIDX(MAIR_ATTR_DEVICE_nGnRnE, MT_DEVICE_nGnRnE) |	\
+	 MAIR_ATTRIDX(MAIR_ATTR_DEVICE_nGnRE, MT_DEVICE_nGnRE) |	\
+	 MAIR_ATTRIDX(MAIR_ATTR_DEVICE_GRE, MT_DEVICE_GRE) |		\
+	 MAIR_ATTRIDX(MAIR_ATTR_NORMAL_NC, MT_NORMAL_NC) |		\
+	 MAIR_ATTRIDX(MAIR_ATTR_NORMAL, MT_NORMAL) |			\
+	 MAIR_ATTRIDX(MAIR_ATTR_NORMAL_WT, MT_NORMAL_WT) |		\
+	 MAIR_ATTRIDX(MAIR_ATTR_NORMAL, MT_NORMAL_TAGGED))
+
 #ifdef CONFIG_ARM64_4K_PAGES
 #define IOREMAP_MAX_ORDER	(PUD_SHIFT)
 #else
diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index e2ef4c2edf06..24e773414cb4 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -635,6 +635,34 @@
 /* Position the attr at the correct index */
 #define MAIR_ATTRIDX(attr, idx)		((attr) << ((idx) * 8))
 
+/*
+ * Memory types available.
+ *
+ * IMPORTANT: MT_NORMAL must be index 0 since vm_get_page_prot() may 'or' in
+ *	      the MT_NORMAL_TAGGED memory type for PROT_MTE mappings. Note
+ *	      that protection_map[] only contains MT_NORMAL attributes.
+ */
+#define MT_NORMAL		0
+#define MT_NORMAL_TAGGED	1
+#define MT_NORMAL_NC		2
+#define MT_NORMAL_WT		3
+#define MT_DEVICE_nGnRnE	4
+#define MT_DEVICE_nGnRE		5
+#define MT_DEVICE_GRE		6
+
+/*
+ * Default MAIR_ELx. MT_NORMAL_TAGGED is initially mapped as Normal memory and
+ * changed during __cpu_setup to Normal Tagged if the system supports MTE.
+ */
+#define MAIR_ELx_SET							\
+	(MAIR_ATTRIDX(MAIR_ATTR_DEVICE_nGnRnE, MT_DEVICE_nGnRnE) |	\
+	 MAIR_ATTRIDX(MAIR_ATTR_DEVICE_nGnRE, MT_DEVICE_nGnRE) |	\
+	 MAIR_ATTRIDX(MAIR_ATTR_DEVICE_GRE, MT_DEVICE_GRE) |		\
+	 MAIR_ATTRIDX(MAIR_ATTR_NORMAL_NC, MT_NORMAL_NC) |		\
+	 MAIR_ATTRIDX(MAIR_ATTR_NORMAL, MT_NORMAL) |			\
+	 MAIR_ATTRIDX(MAIR_ATTR_NORMAL_WT, MT_NORMAL_WT) |		\
+	 MAIR_ATTRIDX(MAIR_ATTR_NORMAL, MT_NORMAL_TAGGED))
+
 /* id_aa64isar0 */
 #define ID_AA64ISAR0_RNDR_SHIFT		60
 #define ID_AA64ISAR0_TLB_SHIFT		56
@@ -992,6 +1020,7 @@
 /* Safe value for MPIDR_EL1: Bit31:RES1, Bit30:U:0, Bit24:MT:0 */
 #define SYS_MPIDR_SAFE_VAL	(BIT(31))
 
+#ifndef LINKER_SCRIPT
 #ifdef __ASSEMBLY__
 
 	.irp	num,0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30
@@ -1109,5 +1138,6 @@
 })
 
 #endif
+#endif	/* LINKER_SCRIPT */
 
 #endif	/* __ASM_SYSREG_H */
diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
index 23c326a06b2d..e3b9aa372b96 100644
--- a/arch/arm64/mm/proc.S
+++ b/arch/arm64/mm/proc.S
@@ -45,19 +45,6 @@
 #define TCR_KASAN_FLAGS 0
 #endif
 
-/*
- * Default MAIR_EL1. MT_NORMAL_TAGGED is initially mapped as Normal memory and
- * changed during __cpu_setup to Normal Tagged if the system supports MTE.
- */
-#define MAIR_EL1_SET							\
-	(MAIR_ATTRIDX(MAIR_ATTR_DEVICE_nGnRnE, MT_DEVICE_nGnRnE) |	\
-	 MAIR_ATTRIDX(MAIR_ATTR_DEVICE_nGnRE, MT_DEVICE_nGnRE) |	\
-	 MAIR_ATTRIDX(MAIR_ATTR_DEVICE_GRE, MT_DEVICE_GRE) |		\
-	 MAIR_ATTRIDX(MAIR_ATTR_NORMAL_NC, MT_NORMAL_NC) |		\
-	 MAIR_ATTRIDX(MAIR_ATTR_NORMAL, MT_NORMAL) |			\
-	 MAIR_ATTRIDX(MAIR_ATTR_NORMAL_WT, MT_NORMAL_WT) |		\
-	 MAIR_ATTRIDX(MAIR_ATTR_NORMAL, MT_NORMAL_TAGGED))
-
 #ifdef CONFIG_CPU_PM
 /**
  * cpu_do_suspend - save CPU registers context
@@ -425,7 +412,7 @@ SYM_FUNC_START(__cpu_setup)
 	/*
 	 * Memory region attributes
 	 */
-	mov_q	x5, MAIR_EL1_SET
+	mov_q	x5, MAIR_ELx_SET
 #ifdef CONFIG_ARM64_MTE
 	/*
 	 * Update MAIR_EL1, GCR_EL1 and TFSR*_EL1 if MTE is supported
-- 
2.29.2.299.gdc1121823c-goog

