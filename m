Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DB3E2D5C6F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 14:55:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389676AbgLJNyH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 08:54:07 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:9590 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389631AbgLJNxn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 08:53:43 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4CsFhx4DSjzM1SM
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 21:52:17 +0800 (CST)
Received: from ubuntu.network (10.175.138.68) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.487.0; Thu, 10 Dec 2020 21:52:50 +0800
From:   Zheng Yongjun <zhengyongjun3@huawei.com>
To:     <p.zabel@pengutronix.de>, <linux-kernel@vger.kernel.org>
CC:     Zheng Yongjun <zhengyongjun3@huawei.com>
Subject: [PATCH -next] phy: cadence: simplify the return expression of cdns_torrent_phy_configure_multilink()
Date:   Thu, 10 Dec 2020 21:53:18 +0800
Message-ID: <20201210135318.1194-1-zhengyongjun3@huawei.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.138.68]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simplify the return expression.

Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>
---
 drivers/phy/cadence/phy-cadence-torrent.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/phy/cadence/phy-cadence-torrent.c b/drivers/phy/cadence/phy-cadence-torrent.c
index f310e15d94cb..2c60ac58f207 100644
--- a/drivers/phy/cadence/phy-cadence-torrent.c
+++ b/drivers/phy/cadence/phy-cadence-torrent.c
@@ -1939,7 +1939,7 @@ int cdns_torrent_phy_configure_multilink(struct cdns_torrent_phy *cdns_phy)
 	struct cdns_torrent_vals *link_cmn_vals, *xcvr_diag_vals;
 	enum cdns_torrent_phy_type phy_t1, phy_t2, tmp_phy_type;
 	struct cdns_torrent_vals *pcs_cmn_vals;
-	int i, j, node, mlane, num_lanes, ret;
+	int i, j, node, mlane, num_lanes;
 	struct cdns_reg_pairs *reg_pairs;
 	enum cdns_torrent_ssc_mode ssc;
 	struct regmap *regmap;
@@ -2064,11 +2064,7 @@ int cdns_torrent_phy_configure_multilink(struct cdns_torrent_phy *cdns_phy)
 	}
 
 	/* Take the PHY out of reset */
-	ret = reset_control_deassert(cdns_phy->phy_rst);
-	if (ret)
-		return ret;
-
-	return 0;
+	return reset_control_deassert(cdns_phy->phy_rst);
 }
 
 static int cdns_torrent_phy_probe(struct platform_device *pdev)
-- 
2.22.0

