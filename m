Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97D7825B886
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Sep 2020 04:00:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727923AbgICCA3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Sep 2020 22:00:29 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:10802 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726177AbgICCA2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 22:00:28 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id ED899317590B7B52DD2C;
        Thu,  3 Sep 2020 10:00:26 +0800 (CST)
Received: from huawei.com (10.175.127.227) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.487.0; Thu, 3 Sep 2020
 10:00:20 +0800
From:   Ye Bin <yebin10@huawei.com>
To:     <tglx@linutronix.de>, <jason@lakedaemon.net>, <maz@kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Ye Bin <yebin10@huawei.com>
Subject: [PATCH] irqchip/tango: Fix possible null ptr reference in tangox_irq_init
Date:   Thu, 3 Sep 2020 09:59:52 +0800
Message-ID: <20200903015952.308888-1-yebin10@huawei.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In tangox_irq_init allocate chip but not test.

Signed-off-by: Ye Bin <yebin10@huawei.com>
---
 drivers/irqchip/irq-tango.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/irqchip/irq-tango.c b/drivers/irqchip/irq-tango.c
index 34290f09b853..25da120230ad 100644
--- a/drivers/irqchip/irq-tango.c
+++ b/drivers/irqchip/irq-tango.c
@@ -187,6 +187,8 @@ static int __init tangox_irq_init(void __iomem *base, struct resource *baseres,
 		panic("%pOFn: failed to get address", node);
 
 	chip = kzalloc(sizeof(*chip), GFP_KERNEL);
+	if (!chip)
+		panic("%pOFn: failed to get chip", node);
 	chip->ctl = res.start - baseres->start;
 	chip->base = base;
 
-- 
2.25.4

