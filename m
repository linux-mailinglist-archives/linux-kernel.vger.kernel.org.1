Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49D102724B2
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 15:10:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbgIUNKd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 09:10:33 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:42916 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727352AbgIUNKc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 09:10:32 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 490FC73346CE3917A716;
        Mon, 21 Sep 2020 21:10:27 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.487.0; Mon, 21 Sep 2020 21:10:18 +0800
From:   Qinglang Miao <miaoqinglang@huawei.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Qinglang Miao <miaoqinglang@huawei.com>
Subject: [PATCH -next] mmc: rtsx_usb_sdmmc: simplify the return expression of sd_change_phase()
Date:   Mon, 21 Sep 2020 21:10:42 +0800
Message-ID: <20200921131042.92340-1-miaoqinglang@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simplify the return expression.

Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>
---
 drivers/mmc/host/rtsx_usb_sdmmc.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/mmc/host/rtsx_usb_sdmmc.c b/drivers/mmc/host/rtsx_usb_sdmmc.c
index 598f49573..5fe4528e2 100644
--- a/drivers/mmc/host/rtsx_usb_sdmmc.c
+++ b/drivers/mmc/host/rtsx_usb_sdmmc.c
@@ -579,7 +579,6 @@ static void sd_normal_rw(struct rtsx_usb_sdmmc *host,
 static int sd_change_phase(struct rtsx_usb_sdmmc *host, u8 sample_point, int tx)
 {
 	struct rtsx_ucr *ucr = host->ucr;
-	int err;
 
 	dev_dbg(sdmmc_dev(host), "%s: %s sample_point = %d\n",
 			__func__, tx ? "TX" : "RX", sample_point);
@@ -601,11 +600,7 @@ static int sd_change_phase(struct rtsx_usb_sdmmc *host, u8 sample_point, int tx)
 	rtsx_usb_add_cmd(ucr, WRITE_REG_CMD, CLK_DIV, CLK_CHANGE, 0);
 	rtsx_usb_add_cmd(ucr, WRITE_REG_CMD, SD_CFG1, SD_ASYNC_FIFO_RST, 0);
 
-	err = rtsx_usb_send_cmd(ucr, MODE_C, 100);
-	if (err)
-		return err;
-
-	return 0;
+	return rtsx_usb_send_cmd(ucr, MODE_C, 100);
 }
 
 static inline u32 get_phase_point(u32 phase_map, unsigned int idx)
-- 
2.23.0

