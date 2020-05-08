Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5C951CB16A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 May 2020 16:08:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727945AbgEHOI2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 May 2020 10:08:28 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:4307 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727882AbgEHOI1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 10:08:27 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 827FE8275CCD21E11AD5;
        Fri,  8 May 2020 22:08:17 +0800 (CST)
Received: from localhost (10.166.215.154) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.487.0; Fri, 8 May 2020
 22:08:10 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <x86@kernel.org>, <hpa@zytor.com>
CC:     <linux-kernel@vger.kernel.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] x86/ioapic: Remove unused inline function mp_init_irq_at_boot
Date:   Fri, 8 May 2020 22:08:08 +0800
Message-ID: <20200508140808.49428-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.166.215.154]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's no callers in-tree anymore since commit
ef9e56d894ea ("x86/ioapic: Remove obsolete post hotplug update")

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 arch/x86/kernel/apic/io_apic.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/arch/x86/kernel/apic/io_apic.c b/arch/x86/kernel/apic/io_apic.c
index 913c88617848..ce61e3e7d399 100644
--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -154,19 +154,6 @@ static inline bool mp_is_legacy_irq(int irq)
 	return irq >= 0 && irq < nr_legacy_irqs();
 }
 
-/*
- * Initialize all legacy IRQs and all pins on the first IOAPIC
- * if we have legacy interrupt controller. Kernel boot option "pirq="
- * may rely on non-legacy pins on the first IOAPIC.
- */
-static inline int mp_init_irq_at_boot(int ioapic, int irq)
-{
-	if (!nr_legacy_irqs())
-		return 0;
-
-	return ioapic == 0 || mp_is_legacy_irq(irq);
-}
-
 static inline struct irq_domain *mp_ioapic_irqdomain(int ioapic)
 {
 	return ioapics[ioapic].irqdomain;
-- 
2.17.1


