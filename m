Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D66AA2B239E
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 19:24:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726338AbgKMSYw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 13:24:52 -0500
Received: from foss.arm.com ([217.140.110.172]:43302 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726296AbgKMSYt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 13:24:49 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C9A2C153B;
        Fri, 13 Nov 2020 10:24:48 -0800 (PST)
Received: from donnerap.arm.com (donnerap.cambridge.arm.com [10.1.195.35])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E70903F718;
        Fri, 13 Nov 2020 10:24:46 -0800 (PST)
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
        linux-kernel@vger.kernel.org,
        Andre Przywara <andre.przywara@arm.com>
Subject: [PATCH v3 3/5] ARM: implement support for SMCCC TRNG entropy source
Date:   Fri, 13 Nov 2020 18:24:33 +0000
Message-Id: <20201113182435.64015-4-andre.przywara@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201113182435.64015-1-andre.przywara@arm.com>
References: <20201113182435.64015-1-andre.przywara@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ard Biesheuvel <ardb@kernel.org>

Implement arch_get_random_seed_*() for ARM based on the firmware
or hypervisor provided entropy source described in ARM DEN0098.

This will make the kernel's random number generator consume entropy
provided by this interface, at early boot, and periodically at
runtime when reseeding.

Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Russell King <linux@armlinux.org.uk>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
[Andre: rework to be initialised by the SMCCC firmware driver]
Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 arch/arm/Kconfig                  |  4 ++
 arch/arm/include/asm/archrandom.h | 64 +++++++++++++++++++++++++++++++
 2 files changed, 68 insertions(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index fe2f17eb2b50..a6d2d66f4110 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1667,6 +1667,10 @@ config STACKPROTECTOR_PER_TASK
 	  Enable this option to switch to a different method that uses a
 	  different canary value for each task.
 
+config ARCH_RANDOM
+	def_bool y
+	depends on HAVE_ARM_SMCCC_DISCOVERY
+
 endmenu
 
 menu "Boot options"
diff --git a/arch/arm/include/asm/archrandom.h b/arch/arm/include/asm/archrandom.h
index a8e84ca5c2ee..f3e96a5b65f8 100644
--- a/arch/arm/include/asm/archrandom.h
+++ b/arch/arm/include/asm/archrandom.h
@@ -2,9 +2,73 @@
 #ifndef _ASM_ARCHRANDOM_H
 #define _ASM_ARCHRANDOM_H
 
+#ifdef CONFIG_ARCH_RANDOM
+
+#include <linux/arm-smccc.h>
+#include <linux/kernel.h>
+
+#define ARM_SMCCC_TRNG_MIN_VERSION     0x10000UL
+
+extern bool smccc_trng_available;
+
+static inline bool __init smccc_probe_trng(void)
+{
+	struct arm_smccc_res res;
+
+	arm_smccc_1_1_invoke(ARM_SMCCC_TRNG_VERSION, &res);
+	if ((s32)res.a0 < 0)
+		return false;
+	if (res.a0 >= ARM_SMCCC_TRNG_MIN_VERSION) {
+		/* double check that the 32-bit flavor is available */
+		arm_smccc_1_1_invoke(ARM_SMCCC_TRNG_FEATURES,
+				     ARM_SMCCC_TRNG_RND32,
+				     &res);
+		if ((s32)res.a0 >= 0)
+			return true;
+	}
+
+	return false;
+}
+
+static inline bool __must_check arch_get_random_long(unsigned long *v)
+{
+	return false;
+}
+
+static inline bool __must_check arch_get_random_int(unsigned int *v)
+{
+	return false;
+}
+
+static inline bool __must_check arch_get_random_seed_long(unsigned long *v)
+{
+	struct arm_smccc_res res;
+
+	if (smccc_trng_available) {
+		arm_smccc_1_1_invoke(ARM_SMCCC_TRNG_RND32, 8 * sizeof(*v), &res);
+
+		if (res.a0 != 0)
+			return false;
+
+		*v = res.a3;
+		return true;
+	}
+
+	return false;
+}
+
+static inline bool __must_check arch_get_random_seed_int(unsigned int *v)
+{
+	return arch_get_random_seed_long((unsigned long *)v);
+}
+
+
+#else /* !CONFIG_ARCH_RANDOM */
+
 static inline bool __init smccc_probe_trng(void)
 {
 	return false;
 }
 
+#endif /* CONFIG_ARCH_RANDOM */
 #endif /* _ASM_ARCHRANDOM_H */
-- 
2.17.1

