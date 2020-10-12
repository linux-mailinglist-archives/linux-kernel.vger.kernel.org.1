Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 549A928AB52
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 03:10:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727260AbgJLBJa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Oct 2020 21:09:30 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:33894 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727132AbgJLBJa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Oct 2020 21:09:30 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 68EE0DFF88410E0B8066;
        Mon, 12 Oct 2020 09:09:27 +0800 (CST)
Received: from huawei.com (10.174.187.17) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.487.0; Mon, 12 Oct 2020
 09:09:19 +0800
From:   l00484210 <limingwang@huawei.com>
To:     <catalin.marinas@arm.com>, <will@kernel.org>, <broonie@kernel.org>,
        <maz@kernel.org>, <suzuki.poulose@arm.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <fanhenglong@huawei.com>,
        <wanghaibin.wang@huawei.com>, <tangnianyao@huawei.com>,
        <jiangyifei@huawei.com>, <dengkai1@huawei.com>,
        <zhang.zhanghailiang@huawei.com>,
        <victor.zhangxiaofeng@huawei.com>,
        "MingWang Li" <limingwang@huawei.com>
Subject: [PATCH] arm64: KVM: marking pages as XN in Stage-2 does not care about CTR_EL0.DIC
Date:   Mon, 12 Oct 2020 09:08:52 +0800
Message-ID: <20201012010852.15932-1-limingwang@huawei.com>
X-Mailer: git-send-email 2.19.1.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.187.17]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: MingWang Li <limingwang@huawei.com>

When testing the ARMv8.2-TTS2UXN feature, setting bits of XN is unavailable.
Because the control bit CTR_EL0.DIC is set by default on system.

But when CTR_EL0.DIC is set, software does not need to flush icache actively,
instead of clearing XN bits.The patch, the commit id of which
is 6ae4b6e0578886eb36cedbf99f04031d93f9e315, has implemented the function
of CTR_EL0.DIC.

Signed-off-by: MingWang Li <limingwang@huawei.com>
Signed-off-by: Henglong Fan <fanhenglong@huawei.com>
---
 arch/arm64/include/asm/pgtable-prot.h | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/arch/arm64/include/asm/pgtable-prot.h b/arch/arm64/include/asm/pgtable-prot.h
index 4d867c6446c4..5feb94882bf7 100644
--- a/arch/arm64/include/asm/pgtable-prot.h
+++ b/arch/arm64/include/asm/pgtable-prot.h
@@ -79,17 +79,7 @@ extern bool arm64_use_ng_mappings;
 		__val;							\
 	 })
 
-#define PAGE_S2_XN							\
-	({								\
-		u64 __val;						\
-		if (cpus_have_const_cap(ARM64_HAS_CACHE_DIC))		\
-			__val = 0;					\
-		else							\
-			__val = PTE_S2_XN;				\
-		__val;							\
-	})
-
-#define PAGE_S2			__pgprot(_PROT_DEFAULT | PAGE_S2_MEMATTR(NORMAL) | PTE_S2_RDONLY | PAGE_S2_XN)
+#define PAGE_S2			__pgprot(_PROT_DEFAULT | PAGE_S2_MEMATTR(NORMAL) | PTE_S2_RDONLY | PTE_S2_XN)
 #define PAGE_S2_DEVICE		__pgprot(_PROT_DEFAULT | PAGE_S2_MEMATTR(DEVICE_nGnRE) | PTE_S2_RDONLY | PTE_S2_XN)
 
 #define PAGE_NONE		__pgprot(((_PAGE_DEFAULT) & ~PTE_VALID) | PTE_PROT_NONE | PTE_RDONLY | PTE_NG | PTE_PXN | PTE_UXN)
-- 
2.19.1

