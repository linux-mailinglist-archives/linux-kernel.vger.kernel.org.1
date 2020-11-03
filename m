Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DA112A44EF
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 13:17:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729061AbgKCMRe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 07:17:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:38334 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729053AbgKCMRc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 07:17:32 -0500
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5694D22264;
        Tue,  3 Nov 2020 12:17:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604405851;
        bh=3FVhtSt7TWFvDa3Dm4j/8byOe/bcNaRnmbZrrCvNraI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GPNk3mwKceW9H0aZbFlpIMAqMvky+Y8cOzXPt/kTaDTjROZQflBHWrwQIvPB80juR
         xgQZ6vkz2cI7+PMnYrhHMHJ4PXFhwwHb6XkHqm/zKqfAoTnwzyUHSPB2B6Qxjz5sdl
         +NdrANQE+VqxvmCao7TUNm3CPuHSSYeZUnfEx1yM=
From:   Will Deacon <will@kernel.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Will Deacon <will@kernel.org>, Kees Cook <keescook@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/4] arm64: cpufeatures: Add capability for LDAPR instruction
Date:   Tue,  3 Nov 2020 12:17:19 +0000
Message-Id: <20201103121721.5166-3-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201103121721.5166-1-will@kernel.org>
References: <20201103121721.5166-1-will@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Armv8.3 introduced the LDAPR instruction, which provides weaker memory
ordering semantics than LDARi (RCpc vs RCsc). Generally, we provide an
RCsc implementation when implementing the Linux memory model, but LDAPR
can be used as a useful alternative to dependency ordering, particularly
when the compiler is capable of breaking the dependencies.

Since LDAPR is not available on all CPUs, add a cpufeature to detect it at
runtime and allow the instruction to be used with alternative code
patching.

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Will Deacon <will@kernel.org>
---
 arch/arm64/Kconfig               |  3 +++
 arch/arm64/include/asm/cpucaps.h |  3 ++-
 arch/arm64/kernel/cpufeature.c   | 10 ++++++++++
 3 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 1d466addb078..356c50b0447f 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1388,6 +1388,9 @@ config ARM64_PAN
 	 The feature is detected at runtime, and will remain as a 'nop'
 	 instruction if the cpu does not implement the feature.
 
+config AS_HAS_LDAPR
+	def_bool $(as-instr,.arch_extension rcpc)
+
 config ARM64_LSE_ATOMICS
 	bool
 	default ARM64_USE_LSE_ATOMICS
diff --git a/arch/arm64/include/asm/cpucaps.h b/arch/arm64/include/asm/cpucaps.h
index e7d98997c09c..64ea0bb9f420 100644
--- a/arch/arm64/include/asm/cpucaps.h
+++ b/arch/arm64/include/asm/cpucaps.h
@@ -66,7 +66,8 @@
 #define ARM64_HAS_TLB_RANGE			56
 #define ARM64_MTE				57
 #define ARM64_WORKAROUND_1508412		58
+#define ARM64_HAS_LDAPR				59
 
-#define ARM64_NCAPS				59
+#define ARM64_NCAPS				60
 
 #endif /* __ASM_CPUCAPS_H */
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index dcc165b3fc04..b7b6804cb931 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -2136,6 +2136,16 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 		.cpu_enable = cpu_enable_mte,
 	},
 #endif /* CONFIG_ARM64_MTE */
+	{
+		.desc = "RCpc load-acquire (LDAPR)",
+		.capability = ARM64_HAS_LDAPR,
+		.type = ARM64_CPUCAP_SYSTEM_FEATURE,
+		.sys_reg = SYS_ID_AA64ISAR1_EL1,
+		.sign = FTR_UNSIGNED,
+		.field_pos = ID_AA64ISAR1_LRCPC_SHIFT,
+		.matches = has_cpuid_feature,
+		.min_field_value = 1,
+	},
 	{},
 };
 
-- 
2.29.1.341.ge80a0c044ae-goog

