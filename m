Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BD982EB03F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 17:39:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729062AbhAEQhr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 11:37:47 -0500
Received: from foss.arm.com ([217.140.110.172]:57226 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728499AbhAEQhr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 11:37:47 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 287EC11D4;
        Tue,  5 Jan 2021 08:37:01 -0800 (PST)
Received: from donnerap.arm.com (donnerap.cambridge.arm.com [10.1.195.35])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4820B3F70D;
        Tue,  5 Jan 2021 08:36:59 -0800 (PST)
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
Subject: [PATCH v5 1/5] firmware: smccc: Add SMCCC TRNG function call IDs
Date:   Tue,  5 Jan 2021 16:36:48 +0000
Message-Id: <20210105163652.23646-2-andre.przywara@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210105163652.23646-1-andre.przywara@arm.com>
References: <20210105163652.23646-1-andre.przywara@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ard Biesheuvel <ardb@kernel.org>

The ARM architected TRNG firmware interface, described in ARM spec
DEN0098, define an ARM SMCCC based interface to a true random number
generator, provided by firmware.

Add the definitions of the SMCCC functions as defined by the spec.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Andre Przywara <andre.przywara@arm.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
---
 include/linux/arm-smccc.h | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/include/linux/arm-smccc.h b/include/linux/arm-smccc.h
index f860645f6512..62c54234576c 100644
--- a/include/linux/arm-smccc.h
+++ b/include/linux/arm-smccc.h
@@ -102,6 +102,37 @@
 			   ARM_SMCCC_OWNER_STANDARD_HYP,	\
 			   0x21)
 
+/* TRNG entropy source calls (defined by ARM DEN0098) */
+#define ARM_SMCCC_TRNG_VERSION					\
+	ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL,			\
+			   ARM_SMCCC_SMC_32,			\
+			   ARM_SMCCC_OWNER_STANDARD,		\
+			   0x50)
+
+#define ARM_SMCCC_TRNG_FEATURES					\
+	ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL,			\
+			   ARM_SMCCC_SMC_32,			\
+			   ARM_SMCCC_OWNER_STANDARD,		\
+			   0x51)
+
+#define ARM_SMCCC_TRNG_GET_UUID					\
+	ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL,			\
+			   ARM_SMCCC_SMC_32,			\
+			   ARM_SMCCC_OWNER_STANDARD,		\
+			   0x52)
+
+#define ARM_SMCCC_TRNG_RND32					\
+	ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL,			\
+			   ARM_SMCCC_SMC_32,			\
+			   ARM_SMCCC_OWNER_STANDARD,		\
+			   0x53)
+
+#define ARM_SMCCC_TRNG_RND64					\
+	ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL,			\
+			   ARM_SMCCC_SMC_64,			\
+			   ARM_SMCCC_OWNER_STANDARD,		\
+			   0x53)
+
 /*
  * Return codes defined in ARM DEN 0070A
  * ARM DEN 0070A is now merged/consolidated into ARM DEN 0028 C
-- 
2.17.1

