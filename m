Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9109223A85
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jul 2020 13:29:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbgGQL3U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jul 2020 07:29:20 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:39156 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725950AbgGQL3U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 07:29:20 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 5F4B79D3570F161523B9;
        Fri, 17 Jul 2020 19:29:17 +0800 (CST)
Received: from localhost (10.174.179.108) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.487.0; Fri, 17 Jul 2020
 19:29:08 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <mpe@ellerman.id.au>, <benh@kernel.crashing.org>,
        <paulus@samba.org>, <haren@linux.ibm.com>,
        <dave.hansen@linux.intel.com>, <npiggin@gmail.com>
CC:     <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] powerpc: Remove unneeded inline functions
Date:   Fri, 17 Jul 2020 19:27:14 +0800
Message-ID: <20200717112714.19304-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
In-Reply-To: <20200715031939.31968-1-yuehaibing@huawei.com>
References: <20200715031939.31968-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.179.108]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both of those functions are only called from 64-bit only code, so the
stubs should not be needed at all.

Suggested-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 arch/powerpc/include/asm/mmu_context.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/powerpc/include/asm/mmu_context.h b/arch/powerpc/include/asm/mmu_context.h
index 1a474f6b1992..7f3658a97384 100644
--- a/arch/powerpc/include/asm/mmu_context.h
+++ b/arch/powerpc/include/asm/mmu_context.h
@@ -218,8 +218,6 @@ static inline void inc_mm_active_cpus(struct mm_struct *mm) { }
 static inline void dec_mm_active_cpus(struct mm_struct *mm) { }
 static inline void mm_context_add_copro(struct mm_struct *mm) { }
 static inline void mm_context_remove_copro(struct mm_struct *mm) { }
-static inline void mm_context_add_vas_windows(struct mm_struct *mm) { }
-static inline void mm_context_remove_vas_windows(struct mm_struct *mm) { }
 #endif
 
 
-- 
2.17.1


