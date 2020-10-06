Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5B5B2852FE
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 22:19:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727228AbgJFUSw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 16:18:52 -0400
Received: from foss.arm.com ([217.140.110.172]:56218 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725962AbgJFUSu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 16:18:50 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 947001500;
        Tue,  6 Oct 2020 13:18:49 -0700 (PDT)
Received: from donnerap.arm.com (donnerap.cambridge.arm.com [10.1.195.35])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 276FA3F71F;
        Tue,  6 Oct 2020 13:18:48 -0700 (PDT)
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
Subject: [PATCH 1/2] firmware: smccc: Add SMCCC TRNG function call IDs
Date:   Tue,  6 Oct 2020 21:18:07 +0100
Message-Id: <20201006201808.37665-2-andre.przywara@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201006201808.37665-1-andre.przywara@arm.com>
References: <20201006201808.37665-1-andre.przywara@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ard Biesheuvel <ardb@kernel.org>

The ARM architected TRNG firmware interface, described in ARM spec
DEN0098[1], defines an ARM SMCCC based interface to a true random number
generator, provided by firmware.

Add the definitions of the SMCCC function IDs, as defined by the spec.

[1] https://developer.arm.com/documentation/den0098/latest/

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 include/linux/arm-smccc.h | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/include/linux/arm-smccc.h b/include/linux/arm-smccc.h
index 15c706fb0a37..95aae50eaab4 100644
--- a/include/linux/arm-smccc.h
+++ b/include/linux/arm-smccc.h
@@ -99,6 +99,37 @@
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

