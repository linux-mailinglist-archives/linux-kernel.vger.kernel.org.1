Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAD7C26BA58
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 04:50:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726402AbgIPCuH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 22:50:07 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:53862 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726373AbgIPCuA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 22:50:00 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 86395F139311534FEE2D;
        Wed, 16 Sep 2020 10:49:57 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.177.253) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.487.0; Wed, 16 Sep 2020 10:49:49 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>,
        Libin <huawei.libin@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Jianguo Chen <chenjianguo3@huawei.com>
Subject: [PATCH v3 1/2] ARM: fix trivial comments in head.S
Date:   Wed, 16 Sep 2020 10:49:26 +0800
Message-ID: <20200916024927.3191-2-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
In-Reply-To: <20200916024927.3191-1-thunder.leizhen@huawei.com>
References: <20200916024927.3191-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.177.253]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1. Change pv_offset to __pv_offset.
2. Change PHYS_OFFSET to PHYS_PFN_OFFSET.
   commit e26a9e00afc4 ("ARM: Better virt_to_page() handling") replaced
   __pv_phys_offset with __pv_phys_pfn_offset, but forgot updating the
   related PHYS_OFFSET to PHYS_PFN_OFFSET.
   #define PHYS_PFN_OFFSET   (__pv_phys_pfn_offset)

Fixes: f52bb722547f ("ARM: mm: Correct virt_to_phys patching for 64 bit physical addresses")
Fixes: e26a9e00afc4 ("ARM: Better virt_to_page() handling")
Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 arch/arm/kernel/head.S | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/kernel/head.S b/arch/arm/kernel/head.S
index f8904227e7fdc44..02d78c9198d0e8d 100644
--- a/arch/arm/kernel/head.S
+++ b/arch/arm/kernel/head.S
@@ -612,7 +612,7 @@ __fixup_pv_table:
 	add	r6, r6, r3	@ adjust __pv_phys_pfn_offset address
 	add	r7, r7, r3	@ adjust __pv_offset address
 	mov	r0, r8, lsr #PAGE_SHIFT	@ convert to PFN
-	str	r0, [r6]	@ save computed PHYS_OFFSET to __pv_phys_pfn_offset
+	str	r0, [r6]	@ save computed PHYS_PFN_OFFSET to __pv_phys_pfn_offset
 	strcc	ip, [r7, #HIGH_OFFSET]	@ save to __pv_offset high bits
 	mov	r6, r3, lsr #24	@ constant for add/sub instructions
 	teq	r3, r6, lsl #24 @ must be 16MiB aligned
@@ -634,8 +634,8 @@ __fixup_a_pv_table:
 	adr	r0, 3f
 	ldr	r6, [r0]
 	add	r6, r6, r3
-	ldr	r0, [r6, #HIGH_OFFSET]	@ pv_offset high word
-	ldr	r6, [r6, #LOW_OFFSET]	@ pv_offset low word
+	ldr	r0, [r6, #HIGH_OFFSET]	@ __pv_offset high word
+	ldr	r6, [r6, #LOW_OFFSET]	@ __pv_offset low word
 	mov	r6, r6, lsr #24
 	cmn	r0, #1
 #ifdef CONFIG_THUMB2_KERNEL
-- 
1.8.3


