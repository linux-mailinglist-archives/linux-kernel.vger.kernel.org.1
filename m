Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D7E92A7F3A
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 13:57:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730950AbgKEM5N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 07:57:13 -0500
Received: from foss.arm.com ([217.140.110.172]:60108 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730567AbgKEM5K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 07:57:10 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 35FB81516;
        Thu,  5 Nov 2020 04:57:09 -0800 (PST)
Received: from donnerap.arm.com (donnerap.cambridge.arm.com [10.1.195.35])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8B3293F719;
        Thu,  5 Nov 2020 04:57:07 -0800 (PST)
From:   Andre Przywara <andre.przywara@arm.com>
To:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Russell King <linux@armlinux.org.uk>
Cc:     linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v2 2/5] firmware: smccc: Introduce SMCCC TRNG framework
Date:   Thu,  5 Nov 2020 12:56:53 +0000
Message-Id: <20201105125656.25259-3-andre.przywara@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201105125656.25259-1-andre.przywara@arm.com>
References: <20201105125656.25259-1-andre.przywara@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ARM DEN0098 document describe an SMCCC based firmware service to
deliver hardware generated random numbers. Its existence is advertised
according to the SMCCC v1.1 specification.

Add a (dummy) call to probe functions implemented in each architecture
(ARM and arm64), to determine the existence of this interface.
For now this return false, but this will be overwritten by each
architecture's support patch.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 arch/arm/include/asm/archrandom.h   | 10 ++++++++++
 arch/arm64/include/asm/archrandom.h | 12 ++++++++++++
 drivers/firmware/smccc/smccc.c      |  5 +++++
 3 files changed, 27 insertions(+)
 create mode 100644 arch/arm/include/asm/archrandom.h

diff --git a/arch/arm/include/asm/archrandom.h b/arch/arm/include/asm/archrandom.h
new file mode 100644
index 000000000000..a8e84ca5c2ee
--- /dev/null
+++ b/arch/arm/include/asm/archrandom.h
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_ARCHRANDOM_H
+#define _ASM_ARCHRANDOM_H
+
+static inline bool __init smccc_probe_trng(void)
+{
+	return false;
+}
+
+#endif /* _ASM_ARCHRANDOM_H */
diff --git a/arch/arm64/include/asm/archrandom.h b/arch/arm64/include/asm/archrandom.h
index ffb1a40d5475..abe07c21da8e 100644
--- a/arch/arm64/include/asm/archrandom.h
+++ b/arch/arm64/include/asm/archrandom.h
@@ -8,6 +8,11 @@
 #include <linux/kernel.h>
 #include <asm/cpufeature.h>
 
+static inline bool __init smccc_probe_trng(void)
+{
+	return false;
+}
+
 static inline bool __arm64_rndr(unsigned long *v)
 {
 	bool ok;
@@ -79,5 +84,12 @@ arch_get_random_seed_long_early(unsigned long *v)
 }
 #define arch_get_random_seed_long_early arch_get_random_seed_long_early
 
+#else /* !CONFIG_ARCH_RANDOM */
+
+static inline bool __init smccc_probe_trng(void)
+{
+	return false;
+}
+
 #endif /* CONFIG_ARCH_RANDOM */
 #endif /* _ASM_ARCHRANDOM_H */
diff --git a/drivers/firmware/smccc/smccc.c b/drivers/firmware/smccc/smccc.c
index 00c88b809c0c..74c84b9559f6 100644
--- a/drivers/firmware/smccc/smccc.c
+++ b/drivers/firmware/smccc/smccc.c
@@ -7,14 +7,19 @@
 
 #include <linux/init.h>
 #include <linux/arm-smccc.h>
+#include <asm/archrandom.h>
 
 static u32 smccc_version = ARM_SMCCC_VERSION_1_0;
 static enum arm_smccc_conduit smccc_conduit = SMCCC_CONDUIT_NONE;
 
+bool __ro_after_init smccc_trng_available = false;
+
 void __init arm_smccc_version_init(u32 version, enum arm_smccc_conduit conduit)
 {
 	smccc_version = version;
 	smccc_conduit = conduit;
+
+	smccc_trng_available = smccc_probe_trng();
 }
 
 enum arm_smccc_conduit arm_smccc_1_1_get_conduit(void)
-- 
2.17.1

