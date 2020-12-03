Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68AAB2CE1B3
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 23:33:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731794AbgLCWdE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 17:33:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:55608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726208AbgLCWdD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 17:33:03 -0500
From:   Arnd Bergmann <arnd@kernel.org>
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Amit Daniel Kachhap <amit.kachhap@arm.com>,
        Kristina Martsenko <kristina.martsenko@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: cpufeature: fix unused function warning
Date:   Thu,  3 Dec 2020 23:32:11 +0100
Message-Id: <20201203223217.1238899-1-arnd@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The __system_matches_cap() function is now only used in an #ifdef
section:

arch/arm64/kernel/cpufeature.c:2649:13: error: unused function '__system_matches_cap' [-Werror,-Wunused-function]

Move it into that #ifdef section.

Fixes: 7cf283c7bd62 ("arm64: uaccess: remove redundant PAN toggling")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm64/kernel/cpufeature.c | 36 ++++++++++++++++------------------
 1 file changed, 17 insertions(+), 19 deletions(-)

diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 6bdb03400581..2c4e526c6e78 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -156,8 +156,6 @@ EXPORT_SYMBOL(cpu_hwcap_keys);
 
 static void cpu_enable_cnp(struct arm64_cpu_capabilities const *cap);
 
-static bool __system_matches_cap(unsigned int n);
-
 /*
  * NOTE: Any changes to the visibility of features should be kept in
  * sync with the documentation of the CPU feature register ABI.
@@ -1617,6 +1615,23 @@ static void cpu_clear_disr(const struct arm64_cpu_capabilities *__unused)
 #endif /* CONFIG_ARM64_RAS_EXTN */
 
 #ifdef CONFIG_ARM64_PTR_AUTH
+/*
+ * This helper function is used in a narrow window when,
+ * - The system wide safe registers are set with all the SMP CPUs and,
+ * - The SYSTEM_FEATURE cpu_hwcaps may not have been set.
+ * In all other cases cpus_have_{const_}cap() should be used.
+ */
+static bool __system_matches_cap(unsigned int n)
+{
+	if (n < ARM64_NCAPS) {
+		const struct arm64_cpu_capabilities *cap = cpu_hwcaps_ptrs[n];
+
+		if (cap)
+			return cap->matches(cap, SCOPE_SYSTEM);
+	}
+	return false;
+}
+
 static bool has_address_auth_cpucap(const struct arm64_cpu_capabilities *entry, int scope)
 {
 	int boot_val, sec_val;
@@ -2640,23 +2655,6 @@ bool this_cpu_has_cap(unsigned int n)
 	return false;
 }
 
-/*
- * This helper function is used in a narrow window when,
- * - The system wide safe registers are set with all the SMP CPUs and,
- * - The SYSTEM_FEATURE cpu_hwcaps may not have been set.
- * In all other cases cpus_have_{const_}cap() should be used.
- */
-static bool __system_matches_cap(unsigned int n)
-{
-	if (n < ARM64_NCAPS) {
-		const struct arm64_cpu_capabilities *cap = cpu_hwcaps_ptrs[n];
-
-		if (cap)
-			return cap->matches(cap, SCOPE_SYSTEM);
-	}
-	return false;
-}
-
 void cpu_set_feature(unsigned int num)
 {
 	WARN_ON(num >= MAX_CPU_FEATURES);
-- 
2.27.0

