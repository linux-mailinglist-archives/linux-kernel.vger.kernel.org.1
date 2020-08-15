Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED42F24551C
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Aug 2020 02:45:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729182AbgHPApJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Aug 2020 20:45:09 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:9739 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726022AbgHPApI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Aug 2020 20:45:08 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id ADEC9DB92E382919FF46
        for <linux-kernel@vger.kernel.org>; Sat, 15 Aug 2020 16:59:30 +0800 (CST)
Received: from huawei.com (10.175.104.175) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.487.0; Sat, 15 Aug 2020
 16:59:20 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <tglx@linutronix.de>
CC:     <linux-kernel@vger.kernel.org>, <linmiaohe@huawei.com>
Subject: [PATCH] genirq: Convert to use the preferred fallthrough macro
Date:   Sat, 15 Aug 2020 04:58:17 -0400
Message-ID: <20200815085817.64335-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.175]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the uses of fallthrough comments to fallthrough macro.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 kernel/irq/manage.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index d55ba625d426..375fcd78fdd3 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -271,7 +271,7 @@ int irq_do_set_affinity(struct irq_data *data, const struct cpumask *mask,
 	case IRQ_SET_MASK_OK:
 	case IRQ_SET_MASK_OK_DONE:
 		cpumask_copy(desc->irq_common_data.affinity, mask);
-		/* fall through */
+		fallthrough;
 	case IRQ_SET_MASK_OK_NOCOPY:
 		irq_validate_effective_affinity(data);
 		irq_set_thread_affinity(desc);
@@ -868,7 +868,7 @@ int __irq_set_trigger(struct irq_desc *desc, unsigned long flags)
 	case IRQ_SET_MASK_OK_DONE:
 		irqd_clear(&desc->irq_data, IRQD_TRIGGER_MASK);
 		irqd_set(&desc->irq_data, flags);
-		/* fall through */
+		fallthrough;
 
 	case IRQ_SET_MASK_OK_NOCOPY:
 		flags = irqd_get_trigger_type(&desc->irq_data);
-- 
2.19.1

