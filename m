Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 669C41B84E3
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Apr 2020 10:50:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726139AbgDYIud (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Apr 2020 04:50:33 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:40366 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725837AbgDYIuc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Apr 2020 04:50:32 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 73750CDE3F05F8D7501A;
        Sat, 25 Apr 2020 16:50:30 +0800 (CST)
Received: from huawei.com (10.67.174.156) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.487.0; Sat, 25 Apr 2020
 16:50:20 +0800
From:   ChenTao <chentao107@huawei.com>
To:     <f.fainelli@gmail.com>, <hkallweit1@gmail.com>
CC:     <linux@armlinux.org.uk>, <davem@davemloft.net>,
        <linux-kernel@vger.kernel.org>, <chentao107@huawei.com>
Subject: [PATCH] net: phy: bcm54140: Make a bunch of functions static
Date:   Sat, 25 Apr 2020 16:49:44 +0800
Message-ID: <20200425084944.152130-1-chentao107@huawei.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.174.156]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following warning:

drivers/net/phy/bcm54140.c:663:5: warning:
symbol 'bcm54140_did_interrupt' was not declared. Should it be static?
drivers/net/phy/bcm54140.c:672:5: warning:
symbol 'bcm54140_ack_intr' was not declared. Should it be static?
drivers/net/phy/bcm54140.c:684:5: warning:
symbol 'bcm54140_config_intr' was not declared. Should it be static?

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: ChenTao <chentao107@huawei.com>
---
 drivers/net/phy/bcm54140.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/phy/bcm54140.c b/drivers/net/phy/bcm54140.c
index 7341f0126cc4..c009ac2856a5 100644
--- a/drivers/net/phy/bcm54140.c
+++ b/drivers/net/phy/bcm54140.c
@@ -660,7 +660,7 @@ static int bcm54140_config_init(struct phy_device *phydev)
 				  BCM54140_RDB_C_PWR_ISOLATE, 0);
 }
 
-int bcm54140_did_interrupt(struct phy_device *phydev)
+static int bcm54140_did_interrupt(struct phy_device *phydev)
 {
 	int ret;
 
@@ -669,7 +669,7 @@ int bcm54140_did_interrupt(struct phy_device *phydev)
 	return (ret < 0) ? 0 : ret;
 }
 
-int bcm54140_ack_intr(struct phy_device *phydev)
+static int bcm54140_ack_intr(struct phy_device *phydev)
 {
 	int reg;
 
@@ -681,7 +681,7 @@ int bcm54140_ack_intr(struct phy_device *phydev)
 	return 0;
 }
 
-int bcm54140_config_intr(struct phy_device *phydev)
+static int bcm54140_config_intr(struct phy_device *phydev)
 {
 	struct bcm54140_priv *priv = phydev->priv;
 	static const u16 port_to_imr_bit[] = {
-- 
2.22.0

