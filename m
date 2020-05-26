Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA28C1A8DB3
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Apr 2020 23:32:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633891AbgDNVcT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Apr 2020 17:32:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:40108 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2633848AbgDNVbg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 17:31:36 -0400
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4A29E2076B;
        Tue, 14 Apr 2020 21:31:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586899896;
        bh=GfhtXnhbWjI+0uvJbr13btlA5xQXBNo799Ku7twdf1s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hHm16xP1mJuxof7IgkpgHhk8uVL3LU/2o2JHpXaixP3VBb3Lsv/G35SjilgjAjzao
         GW93ORXQVNDBKESRmxoSLozvoZRy/tOb0CMgm4scLDnH9oU8Jugsi3aW0ofFL2vOKy
         MNjUkqBphASqZEuho+BI5vS9ljrrZpZK+mFCgWNM=
From:   Will Deacon <will@kernel.org>
To:     linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu
Cc:     linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Doug Anderson <dianders@chromium.org>, kernel-team@android.com
Subject: [PATCH 5/8] arm64: cpufeature: Factor out checking of AArch32 features
Date:   Tue, 14 Apr 2020 22:31:11 +0100
Message-Id: <20200414213114.2378-6-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200414213114.2378-1-will@kernel.org>
References: <20200414213114.2378-1-will@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

update_cpu_features() is pretty large, so split out the checking of the
AArch32 features into a separate function and call it after checking the
AArch64 features.

Signed-off-by: Will Deacon <will@kernel.org>
---
 arch/arm64/kernel/cpufeature.c | 108 +++++++++++++++++++--------------
 1 file changed, 61 insertions(+), 47 deletions(-)

diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 7dfcdd9e75c1..32828a77acc3 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -715,6 +715,65 @@ static int check_update_ftr_reg(u32 sys_id, int cpu, u64 val, u64 boot)
 	return 1;
 }
 
+static int update_32bit_cpu_features(int cpu, struct cpuinfo_arm64 *info,
+				     struct cpuinfo_arm64 *boot)
+{
+	int taint = 0;
+	u64 pfr0 = read_sanitised_ftr_reg(SYS_ID_AA64PFR0_EL1);
+
+	/*
+	 * If we don't have AArch32 at all then skip the checks entirely
+	 * as the register values may be UNKNOWN and we're not going to be
+	 * using them for anything.
+	 */
+	if (!id_aa64pfr0_32bit_el0(pfr0))
+		return taint;
+
+	taint |= check_update_ftr_reg(SYS_ID_DFR0_EL1, cpu,
+				      info->reg_id_dfr0, boot->reg_id_dfr0);
+	taint |= check_update_ftr_reg(SYS_ID_ISAR0_EL1, cpu,
+				      info->reg_id_isar0, boot->reg_id_isar0);
+	taint |= check_update_ftr_reg(SYS_ID_ISAR1_EL1, cpu,
+				      info->reg_id_isar1, boot->reg_id_isar1);
+	taint |= check_update_ftr_reg(SYS_ID_ISAR2_EL1, cpu,
+				      info->reg_id_isar2, boot->reg_id_isar2);
+	taint |= check_update_ftr_reg(SYS_ID_ISAR3_EL1, cpu,
+				      info->reg_id_isar3, boot->reg_id_isar3);
+	taint |= check_update_ftr_reg(SYS_ID_ISAR4_EL1, cpu,
+				      info->reg_id_isar4, boot->reg_id_isar4);
+	taint |= check_update_ftr_reg(SYS_ID_ISAR5_EL1, cpu,
+				      info->reg_id_isar5, boot->reg_id_isar5);
+	taint |= check_update_ftr_reg(SYS_ID_ISAR6_EL1, cpu,
+				      info->reg_id_isar6, boot->reg_id_isar6);
+
+	/*
+	 * Regardless of the value of the AuxReg field, the AIFSR, ADFSR, and
+	 * ACTLR formats could differ across CPUs and therefore would have to
+	 * be trapped for virtualization anyway.
+	 */
+	taint |= check_update_ftr_reg(SYS_ID_MMFR0_EL1, cpu,
+				      info->reg_id_mmfr0, boot->reg_id_mmfr0);
+	taint |= check_update_ftr_reg(SYS_ID_MMFR1_EL1, cpu,
+				      info->reg_id_mmfr1, boot->reg_id_mmfr1);
+	taint |= check_update_ftr_reg(SYS_ID_MMFR2_EL1, cpu,
+				      info->reg_id_mmfr2, boot->reg_id_mmfr2);
+	taint |= check_update_ftr_reg(SYS_ID_MMFR3_EL1, cpu,
+				      info->reg_id_mmfr3, boot->reg_id_mmfr3);
+	taint |= check_update_ftr_reg(SYS_ID_PFR0_EL1, cpu,
+				      info->reg_id_pfr0, boot->reg_id_pfr0);
+	taint |= check_update_ftr_reg(SYS_ID_PFR1_EL1, cpu,
+				      info->reg_id_pfr1, boot->reg_id_pfr1);
+	taint |= check_update_ftr_reg(SYS_MVFR0_EL1, cpu,
+				      info->reg_mvfr0, boot->reg_mvfr0);
+	taint |= check_update_ftr_reg(SYS_MVFR1_EL1, cpu,
+				      info->reg_mvfr1, boot->reg_mvfr1);
+	taint |= check_update_ftr_reg(SYS_MVFR2_EL1, cpu,
+				      info->reg_mvfr2, boot->reg_mvfr2);
+
+	return taint;
+}
+
+
 /*
  * Update system wide CPU feature registers with the values from a
  * non-boot CPU. Also performs SANITY checks to make sure that there
@@ -788,53 +847,6 @@ void update_cpu_features(int cpu,
 	taint |= check_update_ftr_reg(SYS_ID_AA64ZFR0_EL1, cpu,
 				      info->reg_id_aa64zfr0, boot->reg_id_aa64zfr0);
 
-	/*
-	 * If we have AArch32, we care about 32-bit features for compat.
-	 * If the system doesn't support AArch32, don't update them.
-	 */
-	if (id_aa64pfr0_32bit_el0(read_sanitised_ftr_reg(SYS_ID_AA64PFR0_EL1))) {
-		taint |= check_update_ftr_reg(SYS_ID_DFR0_EL1, cpu,
-					info->reg_id_dfr0, boot->reg_id_dfr0);
-		taint |= check_update_ftr_reg(SYS_ID_ISAR0_EL1, cpu,
-					info->reg_id_isar0, boot->reg_id_isar0);
-		taint |= check_update_ftr_reg(SYS_ID_ISAR1_EL1, cpu,
-					info->reg_id_isar1, boot->reg_id_isar1);
-		taint |= check_update_ftr_reg(SYS_ID_ISAR2_EL1, cpu,
-					info->reg_id_isar2, boot->reg_id_isar2);
-		taint |= check_update_ftr_reg(SYS_ID_ISAR3_EL1, cpu,
-					info->reg_id_isar3, boot->reg_id_isar3);
-		taint |= check_update_ftr_reg(SYS_ID_ISAR4_EL1, cpu,
-					info->reg_id_isar4, boot->reg_id_isar4);
-		taint |= check_update_ftr_reg(SYS_ID_ISAR5_EL1, cpu,
-					info->reg_id_isar5, boot->reg_id_isar5);
-		taint |= check_update_ftr_reg(SYS_ID_ISAR6_EL1, cpu,
-					info->reg_id_isar6, boot->reg_id_isar6);
-
-		/*
-		 * Regardless of the value of the AuxReg field, the AIFSR, ADFSR, and
-		 * ACTLR formats could differ across CPUs and therefore would have to
-		 * be trapped for virtualization anyway.
-		 */
-		taint |= check_update_ftr_reg(SYS_ID_MMFR0_EL1, cpu,
-					info->reg_id_mmfr0, boot->reg_id_mmfr0);
-		taint |= check_update_ftr_reg(SYS_ID_MMFR1_EL1, cpu,
-					info->reg_id_mmfr1, boot->reg_id_mmfr1);
-		taint |= check_update_ftr_reg(SYS_ID_MMFR2_EL1, cpu,
-					info->reg_id_mmfr2, boot->reg_id_mmfr2);
-		taint |= check_update_ftr_reg(SYS_ID_MMFR3_EL1, cpu,
-					info->reg_id_mmfr3, boot->reg_id_mmfr3);
-		taint |= check_update_ftr_reg(SYS_ID_PFR0_EL1, cpu,
-					info->reg_id_pfr0, boot->reg_id_pfr0);
-		taint |= check_update_ftr_reg(SYS_ID_PFR1_EL1, cpu,
-					info->reg_id_pfr1, boot->reg_id_pfr1);
-		taint |= check_update_ftr_reg(SYS_MVFR0_EL1, cpu,
-					info->reg_mvfr0, boot->reg_mvfr0);
-		taint |= check_update_ftr_reg(SYS_MVFR1_EL1, cpu,
-					info->reg_mvfr1, boot->reg_mvfr1);
-		taint |= check_update_ftr_reg(SYS_MVFR2_EL1, cpu,
-					info->reg_mvfr2, boot->reg_mvfr2);
-	}
-
 	if (id_aa64pfr0_sve(info->reg_id_aa64pfr0)) {
 		taint |= check_update_ftr_reg(SYS_ZCR_EL1, cpu,
 					info->reg_zcr, boot->reg_zcr);
@@ -845,6 +857,8 @@ void update_cpu_features(int cpu,
 			sve_update_vq_map();
 	}
 
+	taint |= update_32bit_cpu_features(cpu, info, boot);
+
 	/*
 	 * Mismatched CPU features are a recipe for disaster. Don't even
 	 * pretend to support them.
-- 
2.26.0.110.g2183baf09c-goog

