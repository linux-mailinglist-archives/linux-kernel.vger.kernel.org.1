Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E83A726B762
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 02:23:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727401AbgIPAW5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 20:22:57 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:12275 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726845AbgIOOVI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 10:21:08 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 88FA16A3310B1B5CE8E9;
        Tue, 15 Sep 2020 22:01:55 +0800 (CST)
Received: from localhost (10.174.179.108) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.487.0; Tue, 15 Sep 2020
 22:01:46 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <shawnguo@kernel.org>, <s.hauer@pengutronix.de>,
        <kernel@pengutronix.de>, <festevam@gmail.com>, <linux-imx@nxp.com>,
        <yuehaibing@huawei.com>
CC:     <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] clk: imx35: Make mx35_clocks_init static
Date:   Tue, 15 Sep 2020 22:01:41 +0800
Message-ID: <20200915140141.42876-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.179.108]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix sparse warning:

drivers/clk/imx/clk-imx35.c:251:12: warning:
 symbol 'mx35_clocks_init' was not declared. Should it be static?

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/clk/imx/clk-imx35.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/imx/clk-imx35.c b/drivers/clk/imx/clk-imx35.c
index e595f559907f..2594f41d0980 100644
--- a/drivers/clk/imx/clk-imx35.c
+++ b/drivers/clk/imx/clk-imx35.c
@@ -248,7 +248,7 @@ static void __init _mx35_clocks_init(void)
 	imx_print_silicon_rev("i.MX35", mx35_revision());
 }
 
-int __init mx35_clocks_init(void)
+static int __init mx35_clocks_init(void)
 {
 	_mx35_clocks_init();
 
-- 
2.17.1


