Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D12129D5E9
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Oct 2020 23:09:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730377AbgJ1WJo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 18:09:44 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:6702 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730241AbgJ1WI6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:08:58 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4CLjT252lSzkZf5;
        Wed, 28 Oct 2020 17:09:58 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.487.0; Wed, 28 Oct 2020 17:09:46 +0800
From:   Qinglang Miao <miaoqinglang@huawei.com>
To:     Lubomir Rintel <lkundrak@v3.sk>,
        Russell King <linux@armlinux.org.uk>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Qinglang Miao <miaoqinglang@huawei.com>
Subject: [PATCH] ARM: mmp: fix missing clk_disable_unprepare() on error in mmp_dt_init_timer
Date:   Wed, 28 Oct 2020 17:15:42 +0800
Message-ID: <20201028091542.136120-1-miaoqinglang@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the missing clk_disable_unprepare() before return from
mmp_dt_init_timer() in the error handling case.

Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>
---
 arch/arm/mach-mmp/time.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-mmp/time.c b/arch/arm/mach-mmp/time.c
index 41b2e8abc..212823800 100644
--- a/arch/arm/mach-mmp/time.c
+++ b/arch/arm/mach-mmp/time.c
@@ -209,12 +209,15 @@ static int __init mmp_dt_init_timer(struct device_node *np)
 	}
 
 	irq = irq_of_parse_and_map(np, 0);
-	if (!irq)
+	if (!irq) {
+		clk_disable_unprepare(clk);
 		return -EINVAL;
-
+	}
 	mmp_timer_base = of_iomap(np, 0);
-	if (!mmp_timer_base)
+	if (!mmp_timer_base) {
+		clk_disable_unprepare(clk);
 		return -ENOMEM;
+	}
 
 	mmp_timer_init(irq, rate);
 	return 0;
-- 
2.23.0

