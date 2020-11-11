Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E98B2AE55C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 02:13:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732565AbgKKBNX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 20:13:23 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:7167 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731657AbgKKBNV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 20:13:21 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4CW6DP4SQSz15V4c;
        Wed, 11 Nov 2020 09:13:09 +0800 (CST)
Received: from huawei.com (10.175.127.227) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.487.0; Wed, 11 Nov 2020
 09:13:09 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <michal.simek@xilinx.com>, <daniel.lezcano@linaro.org>,
        <tglx@linutronix.de>, <soren.brinkmann@xilinx.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <yukuai3@huawei.com>,
        <yi.zhang@huawei.com>, <zhangxiaoxu5@huawei.com>
Subject: [PATCH V2] clocksource/drivers/cadence_ttc: fix memory leak in ttc_setup_clockevent()
Date:   Wed, 11 Nov 2020 09:16:52 +0800
Message-ID: <20201111011652.328500-1-yukuai3@huawei.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <b3170c38-086a-5d6d-80dd-5424c53ed336@xilinx.com>
References: <b3170c38-086a-5d6d-80dd-5424c53ed336@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If clk_notifier_register() failed, ttc_setup_clockevent() will return
without freeing 'ttcce', which will leak memory.

Fixes: 70504f311d4b ("clocksource/drivers/cadence_ttc: Convert init function to return error")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
Reviewed-by: Michal Simek <michal.simek@xilinx.com>
---
 drivers/clocksource/timer-cadence-ttc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clocksource/timer-cadence-ttc.c b/drivers/clocksource/timer-cadence-ttc.c
index 80e960602030..32b9560ce408 100644
--- a/drivers/clocksource/timer-cadence-ttc.c
+++ b/drivers/clocksource/timer-cadence-ttc.c
@@ -426,6 +426,7 @@ static int __init ttc_setup_clockevent(struct clk *clk,
 				    &ttcce->ttc.clk_rate_change_nb);
 	if (err) {
 		pr_warn("Unable to register clock notifier.\n");
+		kfree(ttcce);
 		return err;
 	}
 
-- 
2.25.4

