Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE7B61A9B96
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Apr 2020 13:00:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2896691AbgDOK60 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Apr 2020 06:58:26 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2329 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2896684AbgDOK6S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 06:58:18 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 6A0BE3045232E8082CF7;
        Wed, 15 Apr 2020 18:58:06 +0800 (CST)
Received: from DESKTOP-8RFUVS3.china.huawei.com (10.173.222.27) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.487.0; Wed, 15 Apr 2020 18:58:00 +0800
From:   Zenghui Yu <yuzenghui@huawei.com>
To:     <kvmarm@lists.cs.columbia.edu>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <maz@kernel.org>, <catalin.marinas@arm.com>, <will@kernel.org>,
        <wanghaibin.wang@huawei.com>, Zenghui Yu <yuzenghui@huawei.com>
Subject: [PATCH] KVM: arm64: Drop PTE_S2_MEMATTR_MASK
Date:   Wed, 15 Apr 2020 18:57:46 +0800
Message-ID: <20200415105746.314-1-yuzenghui@huawei.com>
X-Mailer: git-send-email 2.23.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.173.222.27]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The only user of PTE_S2_MEMATTR_MASK macro had been removed since
commit a501e32430d4 ("arm64: Clean up the default pgprot setting").
It has been about six years and no one has used it again.

Let's drop it.

Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
---
 arch/arm64/include/asm/pgtable-hwdef.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/include/asm/pgtable-hwdef.h b/arch/arm64/include/asm/pgtable-hwdef.h
index 6bf5e650da78..99315bdca0e6 100644
--- a/arch/arm64/include/asm/pgtable-hwdef.h
+++ b/arch/arm64/include/asm/pgtable-hwdef.h
@@ -190,7 +190,6 @@
  * Memory Attribute override for Stage-2 (MemAttr[3:0])
  */
 #define PTE_S2_MEMATTR(t)	(_AT(pteval_t, (t)) << 2)
-#define PTE_S2_MEMATTR_MASK	(_AT(pteval_t, 0xf) << 2)
 
 /*
  * EL2/HYP PTE/PMD definitions
-- 
2.19.1


