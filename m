Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 506DB225585
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jul 2020 03:38:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726687AbgGTBiM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jul 2020 21:38:12 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:46218 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726225AbgGTBiM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 21:38:12 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 850796397271D474BF22
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 09:38:08 +0800 (CST)
Received: from huawei.com (10.175.104.82) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.487.0; Mon, 20 Jul 2020
 09:38:05 +0800
From:   Huang Guobin <huangguobin4@huawei.com>
To:     <linux-kernel@vger.kernel.org>
Subject: [PATCH] net: ag71xx: add missed clk_disable_unprepare in error path of probe
Date:   Sun, 19 Jul 2020 21:46:37 -0400
Message-ID: <20200720014637.12090-1-huangguobin4@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.104.82]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ag71xx_mdio_probe() forgets to call clk_disable_unprepare() when
of_reset_control_get_exclusive() failed. Add the missed call to fix it.

Fixes: d51b6ce441d3 ("net: ethernet: add ag71xx driver")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Huang Guobin <huangguobin4@huawei.com>
---
 drivers/net/ethernet/atheros/ag71xx.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/atheros/ag71xx.c b/drivers/net/ethernet/atheros/ag71xx.c
index 112edbd30823..38cce66ef212 100644
--- a/drivers/net/ethernet/atheros/ag71xx.c
+++ b/drivers/net/ethernet/atheros/ag71xx.c
@@ -556,7 +556,8 @@ static int ag71xx_mdio_probe(struct ag71xx *ag)
 	ag->mdio_reset = of_reset_control_get_exclusive(np, "mdio");
 	if (IS_ERR(ag->mdio_reset)) {
 		netif_err(ag, probe, ndev, "Failed to get reset mdio.\n");
-		return PTR_ERR(ag->mdio_reset);
+		err = PTR_ERR(ag->mdio_reset);
+		goto mdio_err_put_clk;
 	}
 
 	mii_bus->name = "ag71xx_mdio";
-- 
2.17.1

