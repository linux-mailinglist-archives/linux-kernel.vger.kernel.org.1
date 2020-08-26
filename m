Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 169712525EA
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Aug 2020 05:53:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbgHZDxf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Aug 2020 23:53:35 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:49356 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726682AbgHZDxf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 23:53:35 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id DF2ABB4A2B30A12DD9EB;
        Wed, 26 Aug 2020 11:53:32 +0800 (CST)
Received: from localhost (10.174.179.108) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.487.0; Wed, 26 Aug 2020
 11:53:26 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <nm@ti.com>, <t-kristo@ti.com>, <ssantosh@kernel.org>,
        <tglx@linutronix.de>, <jason@lakedaemon.net>, <maz@kernel.org>,
        <lokeshvutla@ti.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] irqchip/ti-sci-intr: Fix unsigned comparison to zero
Date:   Wed, 26 Aug 2020 11:53:21 +0800
Message-ID: <20200826035321.18620-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.179.108]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ti_sci_intr_xlate_irq() return -ENOENT on fail, p_hwirq
should be int type.

Fixes: a5b659bd4bc7 ("irqchip/ti-sci-intr: Add support for INTR being a parent to INTR")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/irqchip/irq-ti-sci-intr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-ti-sci-intr.c b/drivers/irqchip/irq-ti-sci-intr.c
index cbc1758228d9..85a72b56177c 100644
--- a/drivers/irqchip/irq-ti-sci-intr.c
+++ b/drivers/irqchip/irq-ti-sci-intr.c
@@ -137,8 +137,8 @@ static int ti_sci_intr_alloc_parent_irq(struct irq_domain *domain,
 	struct ti_sci_intr_irq_domain *intr = domain->host_data;
 	struct device_node *parent_node;
 	struct irq_fwspec fwspec;
-	u16 out_irq, p_hwirq;
-	int err = 0;
+	int p_hwirq, err = 0;
+	u16 out_irq;
 
 	out_irq = ti_sci_get_free_resource(intr->out_irqs);
 	if (out_irq == TI_SCI_RESOURCE_NULL)
-- 
2.20.1


