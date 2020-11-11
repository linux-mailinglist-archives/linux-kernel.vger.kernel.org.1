Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 640BF2AF65C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 17:29:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727453AbgKKQ2u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 11:28:50 -0500
Received: from foss.arm.com ([217.140.110.172]:57714 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726552AbgKKQ2t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 11:28:49 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B17931042;
        Wed, 11 Nov 2020 08:28:48 -0800 (PST)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DD9C53F6CF;
        Wed, 11 Nov 2020 08:28:47 -0800 (PST)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        LAKML <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 1/2] arm64: cpufeature: Add GIC CPUIF v4.1 detection
Date:   Wed, 11 Nov 2020 16:28:40 +0000
Message-Id: <20201111162841.3151-2-lorenzo.pieralisi@arm.com>
X-Mailer: git-send-email 2.29.1
In-Reply-To: <20201111162841.3151-1-lorenzo.pieralisi@arm.com>
References: <20201111162841.3151-1-lorenzo.pieralisi@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GIC v4.1 introduced changes to the GIC CPU interface; systems that
integrate CPUs that do not support GIC v4.1 features (as reported in the
ID_AA64PFR0_EL1.GIC bitfield) and a GIC v4.1 controller must disable in
software virtual SGIs support since the CPUIF and GIC controller version
mismatch results in CONSTRAINED UNPREDICTABLE behaviour at architectural
level.

Add a cpufeature and related capability to detect GIC v4.1 CPUIF
features so that the GIC driver can probe it to detect GIC CPUIF
hardware configuration and take action accordingly.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Marc Zyngier <maz@kernel.org>
---
 arch/arm64/include/asm/cpucaps.h |  3 ++-
 arch/arm64/kernel/cpufeature.c   | 10 ++++++++++
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/cpucaps.h b/arch/arm64/include/asm/cpucaps.h
index 42868dbd29fd..35ef0319f422 100644
--- a/arch/arm64/include/asm/cpucaps.h
+++ b/arch/arm64/include/asm/cpucaps.h
@@ -65,7 +65,8 @@
 #define ARM64_HAS_ARMv8_4_TTL			55
 #define ARM64_HAS_TLB_RANGE			56
 #define ARM64_MTE				57
+#define ARM64_HAS_GIC_CPUIF_VSGI		58
 
-#define ARM64_NCAPS				58
+#define ARM64_NCAPS				59
 
 #endif /* __ASM_CPUCAPS_H */
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index dcc165b3fc04..9eabbaddfe5e 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -2136,6 +2136,16 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 		.cpu_enable = cpu_enable_mte,
 	},
 #endif /* CONFIG_ARM64_MTE */
+	{
+		.desc = "GIC CPUIF virtual SGI",
+		.capability = ARM64_HAS_GIC_CPUIF_VSGI,
+		.type = ARM64_CPUCAP_BOOT_CPU_FEATURE,
+		.matches = has_cpuid_feature,
+		.sys_reg = SYS_ID_AA64PFR0_EL1,
+		.field_pos = ID_AA64PFR0_GIC_SHIFT,
+		.sign = FTR_UNSIGNED,
+		.min_field_value = 3,
+	},
 	{},
 };
 
-- 
2.29.1

