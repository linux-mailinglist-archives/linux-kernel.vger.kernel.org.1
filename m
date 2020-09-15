Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45AFF269FAB
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 09:26:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726299AbgIOH0H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 03:26:07 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:51828 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726276AbgIOHZg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 03:25:36 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id F211E6C0183021CA70D0;
        Tue, 15 Sep 2020 15:25:31 +0800 (CST)
Received: from DESKTOP-7FEPK9S.china.huawei.com (10.174.184.59) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.487.0; Tue, 15 Sep 2020 15:25:23 +0800
From:   Shenming Lu <lushenming@huawei.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <wanghaibin.wang@huawei.com>
Subject: [PATCH] irqchip/gic-v4.1: Optimize the delay time of the poll on the GICR_VENPENDBASER.Dirty bit
Date:   Tue, 15 Sep 2020 15:22:13 +0800
Message-ID: <20200915072213.62-1-lushenming@huawei.com>
X-Mailer: git-send-email 2.27.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.184.59]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Every time the vPE is scheduled, the code starts polling the
GICR_VPENDBASER.Dirty bit until it becomes 0. It's OK. But
the delay_us of the poll function is directly set to 10, which
is a long time for most interrupts. In our measurement, it takes
only 1~2 microseconds, or even hundreds of nanoseconds, to finish
parsing the VPT in most cases. However, in the current implementation,
if the GICR_VPENDBASER.Dirty bit is not 0 immediately after the
vPE is scheduled, it will directly wait for 10 microseconds,
resulting in meaningless waiting.

In order to avoid meaningless waiting, we can set the delay_us
to 0, which can exit the poll function immediately when the Dirty
bit becomes 0.

Signed-off-by: Shenming Lu <lushenming@huawei.com>
---
 drivers/irqchip/irq-gic-v3-its.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 548de7538632..5cfcf0c2ce1a 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -3803,7 +3803,7 @@ static void its_wait_vpt_parse_complete(void)
 	WARN_ON_ONCE(readq_relaxed_poll_timeout_atomic(vlpi_base + GICR_VPENDBASER,
 						       val,
 						       !(val & GICR_VPENDBASER_Dirty),
-						       10, 500));
+						       0, 500));
 }
 
 static void its_vpe_schedule(struct its_vpe *vpe)
-- 
2.19.1

