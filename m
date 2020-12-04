Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21B112CE559
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 02:47:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbgLDBpi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 20:45:38 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:9102 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725885AbgLDBph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 20:45:37 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4CnFqh4rkdzM04b;
        Fri,  4 Dec 2020 09:44:16 +0800 (CST)
Received: from vm107-89-192.huawei.com (100.107.89.192) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.487.0; Fri, 4 Dec 2020 09:44:43 +0800
From:   Wei Li <liwei213@huawei.com>
To:     <catalin.marinas@arm.com>, <rppt@linux.ibm.com>, <will@kernel.org>,
        <liwei213@huawei.com>
CC:     <fengbaopeng2@hisilicon.com>, <nsaenzjulienne@suse.de>,
        <steve.capper@arm.com>, <song.bao.hua@hisilicon.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <butao@hisilicon.com>
Subject: [PATCH] arm64: mm: decrease the section size to reduce the memory reserved for the page map
Date:   Fri, 4 Dec 2020 09:44:43 +0800
Message-ID: <20201204014443.43329-1-liwei213@huawei.com>
X-Mailer: git-send-email 2.15.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [100.107.89.192]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For the memory hole, sparse memory model that define SPARSEMEM_VMEMMAP
do not free the reserved memory for the page map, decrease the section
size can reduce the waste of reserved memory.

Signed-off-by: Wei Li <liwei213@huawei.com>
Signed-off-by: Baopeng Feng <fengbaopeng2@hisilicon.com>
Signed-off-by: Xia Qing <saberlily.xia@hisilicon.com>
---
 arch/arm64/include/asm/sparsemem.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/sparsemem.h b/arch/arm64/include/asm/sparsemem.h
index 1f43fcc79738..8963bd3def28 100644
--- a/arch/arm64/include/asm/sparsemem.h
+++ b/arch/arm64/include/asm/sparsemem.h
@@ -7,7 +7,7 @@

 #ifdef CONFIG_SPARSEMEM
 #define MAX_PHYSMEM_BITS	CONFIG_ARM64_PA_BITS
-#define SECTION_SIZE_BITS	30
+#define SECTION_SIZE_BITS	27
 #endif

 #endif
--
2.15.0

