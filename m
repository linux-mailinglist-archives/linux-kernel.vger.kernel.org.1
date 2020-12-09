Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 546EC2D46F2
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 17:42:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732037AbgLIQks (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 11:40:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:44384 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731923AbgLIQkl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 11:40:41 -0500
From:   Will Deacon <will@kernel.org>
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jan Kara <jack@suse.cz>, Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Vinayak Menon <vinmenon@codeaurora.org>,
        kernel-team@android.com
Subject: [PATCH 2/2] arm64: mm: Implement arch_wants_old_faultaround_pte()
Date:   Wed,  9 Dec 2020 16:39:50 +0000
Message-Id: <20201209163950.8494-3-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201209163950.8494-1-will@kernel.org>
References: <20201209163950.8494-1-will@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On CPUs with hardware AF/DBM, initialising prefaulted PTEs as 'old'
improves vmscan behaviour and does not appear to introduce any overhead.

Implement arch_wants_old_faultaround_pte() to return 'true' if we detect
hardware access flag support at runtime. This can be extended in future
based on MIDR matching if necessary.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Will Deacon <will@kernel.org>
---
 arch/arm64/include/asm/cpufeature.h | 12 ++++++++++++
 arch/arm64/include/asm/pgtable.h    |  8 +++++++-
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index da250e4741bd..3424f5881390 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -764,6 +764,18 @@ static inline bool cpu_has_hw_af(void)
 						ID_AA64MMFR1_HADBS_SHIFT);
 }
 
+static inline bool system_has_hw_af(void)
+{
+	u64 mmfr1;
+
+	if (!IS_ENABLED(CONFIG_ARM64_HW_AFDBM))
+		return false;
+
+	mmfr1 = read_sanitised_ftr_reg(SYS_ID_AA64MMFR1_EL1);
+	return cpuid_feature_extract_unsigned_field(mmfr1,
+						ID_AA64MMFR1_HADBS_SHIFT);
+}
+
 #ifdef CONFIG_ARM64_AMU_EXTN
 /* Check whether the cpu supports the Activity Monitors Unit (AMU) */
 extern bool cpu_has_amu_feat(int cpu);
diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 5628289b9d5e..d5c2a7625e9a 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -974,7 +974,13 @@ static inline bool arch_faults_on_old_pte(void)
 
 	return !cpu_has_hw_af();
 }
-#define arch_faults_on_old_pte arch_faults_on_old_pte
+#define arch_faults_on_old_pte		arch_faults_on_old_pte
+
+/*
+ * Experimentally, it's cheap to set the access flag in hardware and we
+ * benefit from prefaulting mappings as 'old' to start with.
+ */
+#define arch_wants_old_faultaround_pte	system_has_hw_af
 
 #endif /* !__ASSEMBLY__ */
 
-- 
2.29.2.576.ga3fc446d84-goog

