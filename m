Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5340D2202DE
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jul 2020 05:20:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728399AbgGODUR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jul 2020 23:20:17 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:7313 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725977AbgGODUQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 23:20:16 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 2AF97B10241DC79DDCCC;
        Wed, 15 Jul 2020 11:20:14 +0800 (CST)
Received: from localhost (10.174.179.108) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.487.0; Wed, 15 Jul 2020
 11:20:04 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <mpe@ellerman.id.au>, <benh@kernel.crashing.org>,
        <paulus@samba.org>, <haren@linux.ibm.com>,
        <dave.hansen@linux.intel.com>, <npiggin@gmail.com>
CC:     <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH] powerpc: Fix inconsistent function names
Date:   Wed, 15 Jul 2020 11:19:39 +0800
Message-ID: <20200715031939.31968-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.179.108]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The stub helpers name should be consistent with prototypes.

mm_context_add_vas_windows() --> mm_context_add_vas_window()
mm_context_remove_vas_windows() --> mm_context_remove_vas_window()

Fixes: c420644c0a8f ("powerpc: Use mm_context vas_windows counter to issue CP_ABORT")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 arch/powerpc/include/asm/mmu_context.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/mmu_context.h b/arch/powerpc/include/asm/mmu_context.h
index 1a474f6b1992..00fd1d44731a 100644
--- a/arch/powerpc/include/asm/mmu_context.h
+++ b/arch/powerpc/include/asm/mmu_context.h
@@ -218,8 +218,8 @@ static inline void inc_mm_active_cpus(struct mm_struct *mm) { }
 static inline void dec_mm_active_cpus(struct mm_struct *mm) { }
 static inline void mm_context_add_copro(struct mm_struct *mm) { }
 static inline void mm_context_remove_copro(struct mm_struct *mm) { }
-static inline void mm_context_add_vas_windows(struct mm_struct *mm) { }
-static inline void mm_context_remove_vas_windows(struct mm_struct *mm) { }
+static inline void mm_context_add_vas_window(struct mm_struct *mm) { }
+static inline void mm_context_remove_vas_window(struct mm_struct *mm) { }
 #endif
 
 
-- 
2.17.1


