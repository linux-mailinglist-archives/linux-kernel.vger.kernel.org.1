Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CBEB2852FF
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 22:19:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727251AbgJFUSz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 16:18:55 -0400
Received: from foss.arm.com ([217.140.110.172]:56228 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727214AbgJFUSw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 16:18:52 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3D47B113E;
        Tue,  6 Oct 2020 13:18:51 -0700 (PDT)
Received: from donnerap.arm.com (donnerap.cambridge.arm.com [10.1.195.35])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C6A993F71F;
        Tue,  6 Oct 2020 13:18:49 -0700 (PDT)
From:   Andre Przywara <andre.przywara@arm.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Richard Henderson <richard.henderson@linaro.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] arm64: Add support for SMCCC TRNG firmware interface
Date:   Tue,  6 Oct 2020 21:18:08 +0100
Message-Id: <20201006201808.37665-3-andre.przywara@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201006201808.37665-1-andre.przywara@arm.com>
References: <20201006201808.37665-1-andre.przywara@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ARM architected TRNG firmware interface, described in ARM spec
DEN0098[1], defines an ARM SMCCC based interface to a true random number
generator, provided by firmware.
This can be discovered via the SMCCC >=v1.1 interface, and provides
up to 192 bits of entropy per call.

Hook this SMC call into arm64's arch_get_random_*() implementation,
coming to the rescue when the CPU does not implement the ARM v8.5 RNG
system registers.

For the detection, we piggy back on the PSCI/SMCCC discovery (which gives
us the conduit to use: hvc or smc), then try to call the
ARM_SMCCC_TRNG_VERSION function, which returns -1 if this interface is
not implemented.

[1] https://developer.arm.com/documentation/den0098/latest/

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 arch/arm64/include/asm/archrandom.h | 83 +++++++++++++++++++++++++----
 1 file changed, 73 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/include/asm/archrandom.h b/arch/arm64/include/asm/archrandom.h
index ffb1a40d5475..b6c291c42a48 100644
--- a/arch/arm64/include/asm/archrandom.h
+++ b/arch/arm64/include/asm/archrandom.h
@@ -7,6 +7,13 @@
 #include <linux/bug.h>
 #include <linux/kernel.h>
 #include <asm/cpufeature.h>
+#include <linux/arm-smccc.h>
+
+static enum smc_trng_status {
+	SMC_TRNG_UNKNOWN,
+	SMC_TRNG_NOT_SUPPORTED,
+	SMC_TRNG_SUPPORTED
+} smc_trng_status = SMC_TRNG_UNKNOWN;
 
 static inline bool __arm64_rndr(unsigned long *v)
 {
@@ -26,6 +33,36 @@ static inline bool __arm64_rndr(unsigned long *v)
 	return ok;
 }
 
+static inline bool __check_smc_trng(void)
+{
+	struct arm_smccc_res res;
+
+	if (smc_trng_status == SMC_TRNG_UNKNOWN) {
+		/*
+		 * The variable behind the get_version() call is initialised
+		 * as ARM_SMCCC_VERSION_1_0, so getting this could mean:
+		 * a) not checked yet (early at boot, before PSCI init), or
+		 * b) not implemented by firmware.
+		 * Since we don't know which one it is, we return false, but
+		 * don't fix the answer yet.
+		 */
+		if (arm_smccc_get_version() <= ARM_SMCCC_VERSION_1_0)
+			return false;
+
+		/*
+		 * With the knowledge at having at least SMCCC v1.1, we
+		 * can now test the existence of the interface.
+		 */
+		arm_smccc_1_1_invoke(ARM_SMCCC_TRNG_VERSION, &res);
+		if ((int)res.a0 < 0)
+			smc_trng_status = SMC_TRNG_NOT_SUPPORTED;
+		else
+			smc_trng_status = SMC_TRNG_SUPPORTED;
+	}
+
+	return smc_trng_status == SMC_TRNG_SUPPORTED;
+}
+
 static inline bool __must_check arch_get_random_long(unsigned long *v)
 {
 	return false;
@@ -38,26 +75,52 @@ static inline bool __must_check arch_get_random_int(unsigned int *v)
 
 static inline bool __must_check arch_get_random_seed_long(unsigned long *v)
 {
+	struct arm_smccc_res res;
+
 	/*
-	 * Only support the generic interface after we have detected
-	 * the system wide capability, avoiding complexity with the
-	 * cpufeature code and with potential scheduling between CPUs
+	 * Try the ARMv8.5-A RNDR instruction first, but only after
+	 * we have detected the system wide capability, avoiding complexity
+	 * with the cpufeature code and with potential scheduling between CPUs
 	 * with and without the feature.
 	 */
-	if (!cpus_have_const_cap(ARM64_HAS_RNG))
-		return false;
+	if (cpus_have_const_cap(ARM64_HAS_RNG))
+		return __arm64_rndr(v);
 
-	return __arm64_rndr(v);
-}
+	if (__check_smc_trng()) {
+		arm_smccc_1_1_invoke(ARM_SMCCC_TRNG_RND64, 64, &res);
+		if ((int)res.a0 < 0)
+			return false;
 
+		*v = res.a3;
+		return true;
+	}
+
+	return false;
+}
 
 static inline bool __must_check arch_get_random_seed_int(unsigned int *v)
 {
+	struct arm_smccc_res res;
 	unsigned long val;
-	bool ok = arch_get_random_seed_long(&val);
 
-	*v = val;
-	return ok;
+	if (cpus_have_const_cap(ARM64_HAS_RNG)) {
+		if (arch_get_random_seed_long(&val)) {
+			*v = val;
+			return true;
+		}
+		return false;
+	}
+
+	if (__check_smc_trng()) {
+		arm_smccc_1_1_invoke(ARM_SMCCC_TRNG_RND64, 32, &res);
+		if ((int)res.a0 < 0)
+			return false;
+
+		*v = res.a3 & GENMASK(31, 0);
+		return true;
+	}
+
+	return false;
 }
 
 static inline bool __init __early_cpu_has_rndr(void)
-- 
2.17.1

