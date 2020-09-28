Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22EB827AAB6
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 11:27:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbgI1J1E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 05:27:04 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:56708 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726559AbgI1J1C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 05:27:02 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 0F54C52B2D228130BE95;
        Mon, 28 Sep 2020 17:26:59 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.177.253) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.487.0; Mon, 28 Sep 2020 17:26:53 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Russell King <linux@armlinux.org.uk>,
        Ard Biesheuvel <ardb@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>,
        Libin <huawei.libin@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH 1/2] ARM: p2v: fix trivial comments
Date:   Mon, 28 Sep 2020 17:26:40 +0800
Message-ID: <20200928092641.2070-2-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
In-Reply-To: <20200928092641.2070-1-thunder.leizhen@huawei.com>
References: <20200928092641.2070-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.177.253]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change pv_offset to __pv_offset.

Fixes: f52bb722547f ("ARM: mm: Correct virt_to_phys patching for 64 bit physical addresses")
Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 arch/arm/kernel/phys2virt.S | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/kernel/phys2virt.S b/arch/arm/kernel/phys2virt.S
index fb53db78fe7850b..baadf2b8919a986 100644
--- a/arch/arm/kernel/phys2virt.S
+++ b/arch/arm/kernel/phys2virt.S
@@ -53,8 +53,8 @@ ENDPROC(__fixup_pv_table)
 	.text
 __fixup_a_pv_table:
 	adr_l	r6, __pv_offset
-	ldr	r0, [r6, #HIGH_OFFSET]	@ pv_offset high word
-	ldr	r6, [r6, #LOW_OFFSET]	@ pv_offset low word
+	ldr	r0, [r6, #HIGH_OFFSET]	@ __pv_offset high word
+	ldr	r6, [r6, #LOW_OFFSET]	@ __pv_offset low word
 	cmn	r0, #1
 #ifdef CONFIG_THUMB2_KERNEL
 	@
-- 
1.8.3


