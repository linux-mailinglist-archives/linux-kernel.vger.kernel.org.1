Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67B5D2D7A74
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 17:02:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406704AbgLKQBs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 11:01:48 -0500
Received: from foss.arm.com ([217.140.110.172]:37274 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406691AbgLKQBH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 11:01:07 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3BA33142F;
        Fri, 11 Dec 2020 08:00:21 -0800 (PST)
Received: from donnerap.arm.com (donnerap.cambridge.arm.com [10.1.195.35])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 56C9B3F66B;
        Fri, 11 Dec 2020 08:00:19 -0800 (PST)
From:   Andre Przywara <andre.przywara@arm.com>
To:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Marc Zyngier <maz@kernel.org>
Cc:     Theodore Ts'o <tytso@mit.edu>, Sudeep Holla <sudeep.holla@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 4/5] arm64: Add support for SMCCC TRNG entropy source
Date:   Fri, 11 Dec 2020 16:00:04 +0000
Message-Id: <20201211160005.187336-5-andre.przywara@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201211160005.187336-1-andre.przywara@arm.com>
References: <20201211160005.187336-1-andre.przywara@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ARM architected TRNG firmware interface, described in ARM spec
DEN0098, defines an ARM SMCCC based interface to a true random number
generator, provided by firmware.
This can be discovered via the SMCCC >=v1.1 interface, and provides
up to 192 bits of entropy per call.

Hook this SMC call into arm64's arch_get_random_*() implementation,
coming to the rescue when the CPU does not implement the ARM v8.5 RNG
system registers.

For the detection, we piggy back on the PSCI/SMCCC discovery (which gives
us the conduit to use (hvc/smc)), then try to call the
ARM_SMCCC_TRNG_VERSION function, which returns -1 if this interface is
not implemented.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 arch/arm64/include/asm/archrandom.h | 72 ++++++++++++++++++++++++-----
 1 file changed, 61 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/include/asm/archrandom.h b/arch/arm64/include/asm/archrandom.h
index abe07c21da8e..e188228b2bcc 100644
--- a/arch/arm64/include/asm/archrandom.h
+++ b/arch/arm64/include/asm/archrandom.h
@@ -4,13 +4,24 @@
 
 #ifdef CONFIG_ARCH_RANDOM
 
+#include <linux/arm-smccc.h>
 #include <linux/bug.h>
 #include <linux/kernel.h>
 #include <asm/cpufeature.h>
 
+#define ARM_SMCCC_TRNG_MIN_VERSION	0x10000UL
+
+extern bool smccc_trng_available;
+
 static inline bool __init smccc_probe_trng(void)
 {
-	return false;
+	struct arm_smccc_res res;
+
+	arm_smccc_1_1_invoke(ARM_SMCCC_TRNG_VERSION, &res);
+	if ((s32)res.a0 < 0)
+		return false;
+
+	return res.a0 >= ARM_SMCCC_TRNG_MIN_VERSION;
 }
 
 static inline bool __arm64_rndr(unsigned long *v)
@@ -43,26 +54,55 @@ static inline bool __must_check arch_get_random_int(unsigned int *v)
 
 static inline bool __must_check arch_get_random_seed_long(unsigned long *v)
 {
+	struct arm_smccc_res res;
+
+	/*
+	 * We prefer the SMCCC call, since its semantics (return actual
+	 * hardware backed entropy) is closer to the idea behind this
+	 * function here than what even the RNDRSS register provides
+	 * (the output of a pseudo RNG freshly seeded by a TRNG).
+	 */
+	if (smccc_trng_available) {
+		arm_smccc_1_1_invoke(ARM_SMCCC_TRNG_RND64, 64, &res);
+		if ((int)res.a0 >= 0) {
+			*v = res.a3;
+			return true;
+		}
+	}
+
 	/*
 	 * Only support the generic interface after we have detected
 	 * the system wide capability, avoiding complexity with the
 	 * cpufeature code and with potential scheduling between CPUs
 	 * with and without the feature.
 	 */
-	if (!cpus_have_const_cap(ARM64_HAS_RNG))
-		return false;
+	if (cpus_have_const_cap(ARM64_HAS_RNG))
+		return __arm64_rndr(v);
 
-	return __arm64_rndr(v);
+	return false;
 }
 
-
 static inline bool __must_check arch_get_random_seed_int(unsigned int *v)
 {
+	struct arm_smccc_res res;
 	unsigned long val;
-	bool ok = arch_get_random_seed_long(&val);
 
-	*v = val;
-	return ok;
+	if (smccc_trng_available) {
+		arm_smccc_1_1_invoke(ARM_SMCCC_TRNG_RND64, 32, &res);
+		if ((int)res.a0 >= 0) {
+			*v = res.a3 & GENMASK(31, 0);
+			return true;
+		}
+	}
+
+	if (cpus_have_const_cap(ARM64_HAS_RNG)) {
+		if (__arm64_rndr(&val)) {
+			*v = val;
+			return true;
+		}
+	}
+
+	return false;
 }
 
 static inline bool __init __early_cpu_has_rndr(void)
@@ -77,10 +117,20 @@ arch_get_random_seed_long_early(unsigned long *v)
 {
 	WARN_ON(system_state != SYSTEM_BOOTING);
 
-	if (!__early_cpu_has_rndr())
-		return false;
+	if (__early_cpu_has_rndr())
+		return __arm64_rndr(v);
+
+	if (smccc_trng_available) {
+		struct arm_smccc_res res;
 
-	return __arm64_rndr(v);
+		arm_smccc_1_1_invoke(ARM_SMCCC_TRNG_RND64, 64, &res);
+		if ((int)res.a0 >= 0) {
+			*v = res.a3;
+			return true;
+		}
+	}
+
+	return false;
 }
 #define arch_get_random_seed_long_early arch_get_random_seed_long_early
 
-- 
2.17.1

