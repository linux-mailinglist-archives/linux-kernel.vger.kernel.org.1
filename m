Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2ADD32B56F1
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 03:41:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727449AbgKQCjS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 21:39:18 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:7632 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727381AbgKQCjP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 21:39:15 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4CZqrg6Qn9z15M16;
        Tue, 17 Nov 2020 10:38:59 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.487.0; Tue, 17 Nov 2020 10:39:06 +0800
From:   Jing Xiangfeng <jingxiangfeng@huawei.com>
To:     <marcel@holtmann.org>, <johan.hedberg@gmail.com>,
        <matthias.bgg@gmail.com>, <Mark-YW.Chen@mediatek.com>,
        <sean.wang@mediatek.com>
CC:     <linux-bluetooth@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <jingxiangfeng@huawei.com>
Subject: [PATCH] Bluetooth: btmtksdio: Add the missed release_firmware() in mtk_setup_firmware()
Date:   Tue, 17 Nov 2020 10:43:32 +0800
Message-ID: <20201117024332.165771-1-jingxiangfeng@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mtk_setup_firmware() misses to call release_firmware() in an error
path. Jump to free_fw to fix it.

Fixes: 737cd06072a7 ("Bluetooth: btmtksdio: fix up firmware download sequence")
Signed-off-by: Jing Xiangfeng <jingxiangfeng@huawei.com>
---
 drivers/bluetooth/btmtksdio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btmtksdio.c b/drivers/bluetooth/btmtksdio.c
index c7ab7a23bd67..c2677ffbd3c0 100644
--- a/drivers/bluetooth/btmtksdio.c
+++ b/drivers/bluetooth/btmtksdio.c
@@ -704,7 +704,7 @@ static int mtk_setup_firmware(struct hci_dev *hdev, const char *fwname)
 	err = mtk_hci_wmt_sync(hdev, &wmt_params);
 	if (err < 0) {
 		bt_dev_err(hdev, "Failed to power on data RAM (%d)", err);
-		return err;
+		goto free_fw;
 	}
 
 	fw_ptr = fw->data;
-- 
2.17.1

