Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3828C2AD6A9
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 13:46:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732093AbgKJMp7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 07:45:59 -0500
Received: from foss.arm.com ([217.140.110.172]:55078 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731969AbgKJMp4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 07:45:56 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D81511396;
        Tue, 10 Nov 2020 04:45:55 -0800 (PST)
Received: from p8cg001049571a15.blr.arm.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 90A613F6CF;
        Tue, 10 Nov 2020 04:45:53 -0800 (PST)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org
Cc:     linux-kernel@vger.kernel.org, suzuki.poulose@arm.com,
        mathieu.poirier@linaro.org, mike.leach@linaro.org,
        Anshuman Khandual <anshuman.khandual@arm.com>
Subject: [RFC 01/11] arm64: Add TRBE definitions
Date:   Tue, 10 Nov 2020 18:14:59 +0530
Message-Id: <1605012309-24812-2-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1605012309-24812-1-git-send-email-anshuman.khandual@arm.com>
References: <1605012309-24812-1-git-send-email-anshuman.khandual@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds TRBE related registers and corresponding feature macros.

Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/arm64/include/asm/sysreg.h | 49 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index 8bfca08..14cb156 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -330,6 +330,55 @@
 
 #define SYS_PMMIR_EL1			sys_reg(3, 0, 9, 14, 6)
 
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
+#define TRBLIMITR_LIMIT_MASK		GENMASK(51, 0)
+#define TRBLIMITR_LIMIT_SHIFT		12
+#define TRBLIMITR_NVM			(1UL << 5)
+#define TRBLIMITR_TRIG_MODE_MASK	GENMASK(1, 0)
+#define TRBLIMITR_TRIG_MODE_SHIFT	2
+#define TRBLIMITR_FILL_MODE_MASK	GENMASK(1, 0)
+#define TRBLIMITR_FILL_MODE_SHIFT	1
+#define TRBLIMITR_ENABLE		(1UL << 0)
+#define TRBPTR_PTR_MASK			GENMASK(63, 0)
+#define TRBPTR_PTR_SHIFT		0
+#define TRBBASER_BASE_MASK		GENMASK(51, 0)
+#define TRBBASER_BASE_SHIFT		12
+#define TRBSR_EC_MASK			GENMASK(5, 0)
+#define TRBSR_EC_SHIFT			26
+#define TRBSR_IRQ			(1UL << 22)
+#define TRBSR_TRG			(1UL << 21)
+#define TRBSR_WRAP			(1UL << 20)
+#define TRBSR_ABORT			(1UL << 18)
+#define TRBSR_STOP			(1UL << 17)
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
+#define TRBIDR_FLAG			(1UL << 5)
+#define TRBIDR_PROG			(1UL << 4)
+#define TRBIDR_ALIGN_MASK		GENMASK(3, 0)
+#define TRBIDR_ALIGN_SHIFT		0
+
 #define SYS_MAIR_EL1			sys_reg(3, 0, 10, 2, 0)
 #define SYS_AMAIR_EL1			sys_reg(3, 0, 10, 3, 0)
 
-- 
2.7.4

