Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B9992B5724
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 03:56:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726654AbgKQCzQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 21:55:16 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:7547 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725554AbgKQCzP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 21:55:15 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4CZrC826GDzhYtf;
        Tue, 17 Nov 2020 10:55:00 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.487.0; Tue, 17 Nov 2020 10:55:07 +0800
From:   Jing Xiangfeng <jingxiangfeng@huawei.com>
To:     <marcel@holtmann.org>, <johan.hedberg@gmail.com>,
        <Mark-YW.Chen@mediatek.com>, <sean.wang@mediatek.com>
CC:     <linux-bluetooth@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <jingxiangfeng@huawei.com>
Subject: [PATCH] Bluetooth: btusb: Add the missed release_firmware() in btusb_mtk_setup_firmware()
Date:   Tue, 17 Nov 2020 10:59:17 +0800
Message-ID: <20201117025917.168761-1-jingxiangfeng@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

btusb_mtk_setup_firmware() misses to call release_firmware() in an error
path. Jump to err_release_fw to fix it.

Fixes: f645125711c8 ("Bluetooth: btusb: fix up firmware download sequence")
Signed-off-by: Jing Xiangfeng <jingxiangfeng@huawei.com>
---
 drivers/bluetooth/btusb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 8d2608ddfd08..14231a5f3474 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -3043,7 +3043,7 @@ static int btusb_mtk_setup_firmware(struct hci_dev *hdev, const char *fwname)
 	err = btusb_mtk_hci_wmt_sync(hdev, &wmt_params);
 	if (err < 0) {
 		bt_dev_err(hdev, "Failed to power on data RAM (%d)", err);
-		return err;
+		goto err_release_fw;
 	}
 
 	fw_ptr = fw->data;
-- 
2.17.1

