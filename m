Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEAE22C8A76
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 18:08:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729002AbgK3RIG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 12:08:06 -0500
Received: from foss.arm.com ([217.140.110.172]:58196 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725955AbgK3RIG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 12:08:06 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 379281042;
        Mon, 30 Nov 2020 09:07:21 -0800 (PST)
Received: from e119884-lin.cambridge.arm.com (e119884-lin.cambridge.arm.com [10.1.196.72])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 51F8F3F718;
        Mon, 30 Nov 2020 09:07:20 -0800 (PST)
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com
Cc:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Subject: [PATCH v2] arm64: mte: Fix typo in macro definition
Date:   Mon, 30 Nov 2020 17:07:09 +0000
Message-Id: <20201130170709.22309-1-vincenzo.frascino@arm.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UL in the definition of SYS_TFSR_EL1_TF1 was misspelled causing
compilation issues when trying to implement in kernel MTE async
mode.

Fix the macro correcting the typo.

Note: MTE async mode will be introduced with a future series.

Fixes: c058b1c4a5ea ("arm64: mte: system register definitions")
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
 arch/arm64/include/asm/sysreg.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index e2ef4c2edf06..801861d05426 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -987,7 +987,7 @@
 #define SYS_TFSR_EL1_TF0_SHIFT	0
 #define SYS_TFSR_EL1_TF1_SHIFT	1
 #define SYS_TFSR_EL1_TF0	(UL(1) << SYS_TFSR_EL1_TF0_SHIFT)
-#define SYS_TFSR_EL1_TF1	(UK(2) << SYS_TFSR_EL1_TF1_SHIFT)
+#define SYS_TFSR_EL1_TF1	(UL(1) << SYS_TFSR_EL1_TF1_SHIFT)
 
 /* Safe value for MPIDR_EL1: Bit31:RES1, Bit30:U:0, Bit24:MT:0 */
 #define SYS_MPIDR_SAFE_VAL	(BIT(31))
-- 
2.29.2

