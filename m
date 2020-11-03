Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C29182A3E5F
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 09:12:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbgKCILp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 03:11:45 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:6738 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726312AbgKCILp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 03:11:45 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4CQMtz3GL4zkXgn;
        Tue,  3 Nov 2020 16:11:39 +0800 (CST)
Received: from huawei.com (10.175.112.208) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.487.0; Tue, 3 Nov 2020
 16:11:33 +0800
From:   Xu Qiang <xuqiang36@huawei.com>
To:     <tglx@linutronix.de>, <jason@lakedaemon.net>, <maz@kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <rui.xiang@huawei.com>
Subject: [PATCH -next] irq-chip/gic-v3-its: Fixed an issue where the ITS executes the residual commands in the queue again when the ITS wakes up from sleep mode.
Date:   Tue, 3 Nov 2020 08:11:23 +0000
Message-ID: <20201103081123.119969-1-xuqiang36@huawei.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.208]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During wakeup, the ATF restore interface restores the values of
the cbaser and cwriter registers. As a result, the ITS executes
the residual commands in the queue, which may cause memory corruption.

To solve this problem, clear all data in the command queue
in the suspend interface of the ITS driver.

Signed-off-by: Xu Qiang <xuqiang36@huawei.com>
---
 drivers/irqchip/irq-gic-v3-its.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 0fec31931e11..b8487f78ac21 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -4741,6 +4741,14 @@ static int its_save_disable(void)
 	list_for_each_entry(its, &its_nodes, entry) {
 		void __iomem *base;
 
+		/*
+		 * Clear the command queue so that the ITS will not re-execute
+		 * the remaining commands in the command queue when
+		 * the cwriter and cbaser registers are restored
+		 * in the restore interface of the firmware.
+		 */
+		memset(its->cmd_base, 0, ITS_CMD_QUEUE_SZ);
+
 		if (!(its->flags & ITS_FLAGS_SAVE_SUSPEND_STATE))
 			continue;
 
-- 
2.25.0

