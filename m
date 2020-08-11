Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40A1C24163E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Aug 2020 08:18:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727995AbgHKGSE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Aug 2020 02:18:04 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:34288 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726154AbgHKGSD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 02:18:03 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 63EBD988F5302519B287
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 14:17:59 +0800 (CST)
Received: from [127.0.0.1] (10.174.177.157) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.487.0; Tue, 11 Aug 2020
 14:17:49 +0800
To:     <tglx@linutronix.de>
CC:     Shiyuan Hu <hushiyuan@huawei.com>,
        Hewenliang <hewenliang4@huawei.com>,
        <linux-kernel@vger.kernel.org>
From:   Yunfeng Ye <yeyunfeng@huawei.com>
Subject: [PATCH] genirq/affinity: show managed irq affinity correctly
Message-ID: <b55d8b8c-8afc-0046-44b6-514ad012936f@huawei.com>
Date:   Tue, 11 Aug 2020 14:17:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.157]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "managed_irq" for isolcpus is supported after the commit
11ea68f553e2 ("genirq, sched/isolation: Isolate from handling managed
interrupts"), but the interrupt affinity shown in proc directory is
still the original affinity.

So modify the interrupt affinity correctly for managed_irq.

Signed-off-by: yeyunfeng <yeyunfeng@huawei.com>
---
 kernel/irq/manage.c | 38 ++++++++++++++++++++++++--------------
 1 file changed, 24 insertions(+), 14 deletions(-)

diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index d55ba625d426..6ad4fe01942a 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -218,8 +218,8 @@ static inline void irq_init_effective_affinity(struct irq_data *data,
 					       const struct cpumask *mask) { }
 #endif

-int irq_do_set_affinity(struct irq_data *data, const struct cpumask *mask,
-			bool force)
+static int irq_chip_set_affinity(struct irq_data *data,
+				const struct cpumask *mask, bool force)
 {
 	struct irq_desc *desc = irq_data_to_desc(data);
 	struct irq_chip *chip = irq_data_get_irq_chip(data);
@@ -228,6 +228,26 @@ int irq_do_set_affinity(struct irq_data *data, const struct cpumask *mask,
 	if (!chip || !chip->irq_set_affinity)
 		return -EINVAL;

+	ret = chip->irq_set_affinity(data, mask, force);
+	switch (ret) {
+	case IRQ_SET_MASK_OK:
+	case IRQ_SET_MASK_OK_DONE:
+		cpumask_copy(desc->irq_common_data.affinity, mask);
+		/* fall through */
+	case IRQ_SET_MASK_OK_NOCOPY:
+		irq_validate_effective_affinity(data);
+		irq_set_thread_affinity(desc);
+		ret = 0;
+	}
+
+	return ret;
+}
+
+int irq_do_set_affinity(struct irq_data *data, const struct cpumask *mask,
+			bool force)
+{
+	int ret;
+
 	/*
 	 * If this is a managed interrupt and housekeeping is enabled on
 	 * it check whether the requested affinity mask intersects with
@@ -262,20 +282,10 @@ int irq_do_set_affinity(struct irq_data *data, const struct cpumask *mask,
 			prog_mask = mask;
 		else
 			prog_mask = &tmp_mask;
-		ret = chip->irq_set_affinity(data, prog_mask, force);
+		ret = irq_chip_set_affinity(data, prog_mask, force);
 		raw_spin_unlock(&tmp_mask_lock);
 	} else {
-		ret = chip->irq_set_affinity(data, mask, force);
-	}
-	switch (ret) {
-	case IRQ_SET_MASK_OK:
-	case IRQ_SET_MASK_OK_DONE:
-		cpumask_copy(desc->irq_common_data.affinity, mask);
-		/* fall through */
-	case IRQ_SET_MASK_OK_NOCOPY:
-		irq_validate_effective_affinity(data);
-		irq_set_thread_affinity(desc);
-		ret = 0;
+		ret = irq_chip_set_affinity(data, mask, force);
 	}

 	return ret;
-- 
1.8.3.1

