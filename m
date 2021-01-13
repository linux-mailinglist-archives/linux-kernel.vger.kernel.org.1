Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06FA82F4309
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 05:21:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726533AbhAMET5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 23:19:57 -0500
Received: from foss.arm.com ([217.140.110.172]:57998 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726365AbhAMETz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 23:19:55 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7DFE613D5;
        Tue, 12 Jan 2021 20:18:44 -0800 (PST)
Received: from p8cg001049571a15.blr.arm.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B91263F719;
        Tue, 12 Jan 2021 20:18:41 -0800 (PST)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org
Cc:     mathieu.poirier@linaro.org, suzuki.poulose@arm.com,
        mike.leach@linaro.org,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Linu Cherian <lcherian@marvell.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 07/11] arm64: Add TRBE definitions
Date:   Wed, 13 Jan 2021 09:48:14 +0530
Message-Id: <1610511498-4058-8-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1610511498-4058-1-git-send-email-anshuman.khandual@arm.com>
References: <1610511498-4058-1-git-send-email-anshuman.khandual@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds TRBE related registers and corresponding feature macros.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Mike Leach <mike.leach@linaro.org>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/arm64/include/asm/sysreg.h | 49 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index 4acff97..d60750e7 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -329,6 +329,55 @@
 
 /*** End of Statistical Profiling Extension ***/
 
+/*
+ * TRBE Registers
+ */
+#define SYS_TRBLIMITR_EL1		sys_reg(3, 0, 9, 11, 0)
+#define SYS_TRBPTR_EL1			sys_reg(3, 0, 9, 11, 1)
+#define SYS_TRBBASER_EL1		sys_reg(3, 0, 9, 11, 2)
+#define SYS_TRBSR_EL1			sys_reg(3, 0, 9, 11, 3)
+#define SYS_TRBMAR_EL1			sys_reg(3, 0, 9, 11, 4)
+#define SYS_TRBTRG_EL1			sys_reg(3, 0, 9, 11, 6)
+#define SYS_TRBIDR_EL1			sys_reg(3, 0, 9, 11, 7)
+
+#define TRBLIMITR_LIMIT_MASK		GENMASK_ULL(51, 0)
+#define TRBLIMITR_LIMIT_SHIFT		12
+#define TRBLIMITR_NVM			BIT(5)
+#define TRBLIMITR_TRIG_MODE_MASK	GENMASK(1, 0)
+#define TRBLIMITR_TRIG_MODE_SHIFT	2
+#define TRBLIMITR_FILL_MODE_MASK	GENMASK(1, 0)
+#define TRBLIMITR_FILL_MODE_SHIFT	1
+#define TRBLIMITR_ENABLE		BIT(0)
+#define TRBPTR_PTR_MASK			GENMASK_ULL(63, 0)
+#define TRBPTR_PTR_SHIFT		0
+#define TRBBASER_BASE_MASK		GENMASK_ULL(51, 0)
+#define TRBBASER_BASE_SHIFT		12
+#define TRBSR_EC_MASK			GENMASK(5, 0)
+#define TRBSR_EC_SHIFT			26
+#define TRBSR_IRQ			BIT(22)
+#define TRBSR_TRG			BIT(21)
+#define TRBSR_WRAP			BIT(20)
+#define TRBSR_ABORT			BIT(18)
+#define TRBSR_STOP			BIT(17)
+#define TRBSR_MSS_MASK			GENMASK(15, 0)
+#define TRBSR_MSS_SHIFT			0
+#define TRBSR_BSC_MASK			GENMASK(5, 0)
+#define TRBSR_BSC_SHIFT			0
+#define TRBSR_FSC_MASK			GENMASK(5, 0)
+#define TRBSR_FSC_SHIFT			0
+#define TRBMAR_SHARE_MASK		GENMASK(1, 0)
+#define TRBMAR_SHARE_SHIFT		8
+#define TRBMAR_OUTER_MASK		GENMASK(3, 0)
+#define TRBMAR_OUTER_SHIFT		4
+#define TRBMAR_INNER_MASK		GENMASK(3, 0)
+#define TRBMAR_INNER_SHIFT		0
+#define TRBTRG_TRG_MASK			GENMASK(31, 0)
+#define TRBTRG_TRG_SHIFT		0
+#define TRBIDR_FLAG			BIT(5)
+#define TRBIDR_PROG			BIT(4)
+#define TRBIDR_ALIGN_MASK		GENMASK(3, 0)
+#define TRBIDR_ALIGN_SHIFT		0
+
 #define SYS_PMINTENSET_EL1		sys_reg(3, 0, 9, 14, 1)
 #define SYS_PMINTENCLR_EL1		sys_reg(3, 0, 9, 14, 2)
 
-- 
2.7.4

