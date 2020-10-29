Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 391EE29EBD8
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 13:27:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbgJ2M1p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 08:27:45 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:6929 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725791AbgJ2M1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 08:27:43 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4CMPpg4Jpwz70Xq;
        Thu, 29 Oct 2020 20:27:39 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.487.0; Thu, 29 Oct 2020 20:27:29 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        <linux-kernel@vger.kernel.org>
CC:     Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH 2/4] clocksource/drivers/sp804: Use clk_prepare_enable and clk_disable_unprepare
Date:   Thu, 29 Oct 2020 20:33:15 +0800
Message-ID: <20201029123317.90286-3-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201029123317.90286-1-wangkefeng.wang@huawei.com>
References: <20201029123317.90286-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Directly use clk_prepare_enable and clk_disable_unprepare.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 drivers/clocksource/timer-sp804.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/drivers/clocksource/timer-sp804.c b/drivers/clocksource/timer-sp804.c
index 43d31bf09a18..9e0cc029b06a 100644
--- a/drivers/clocksource/timer-sp804.c
+++ b/drivers/clocksource/timer-sp804.c
@@ -68,17 +68,9 @@ static long __init sp804_get_clock_rate(struct clk *clk, const char *name)
 		return PTR_ERR(clk);
 	}
 
-	err = clk_prepare(clk);
-	if (err) {
-		pr_err("sp804: clock failed to prepare: %d\n", err);
-		clk_put(clk);
-		return err;
-	}
-
-	err = clk_enable(clk);
+	err = clk_prepare_enable(clk);
 	if (err) {
 		pr_err("sp804: clock failed to enable: %d\n", err);
-		clk_unprepare(clk);
 		clk_put(clk);
 		return err;
 	}
@@ -86,8 +78,7 @@ static long __init sp804_get_clock_rate(struct clk *clk, const char *name)
 	rate = clk_get_rate(clk);
 	if (rate < 0) {
 		pr_err("sp804: clock failed to get rate: %ld\n", rate);
-		clk_disable(clk);
-		clk_unprepare(clk);
+		clk_disable_unprepare(clk);
 		clk_put(clk);
 	}
 
-- 
2.26.2

