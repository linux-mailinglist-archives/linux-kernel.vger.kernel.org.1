Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42F632AD679
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 13:39:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730061AbgKJMjT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 07:39:19 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:34266 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726462AbgKJMjT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 07:39:19 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1kcSvb-0003U0-N4; Tue, 10 Nov 2020 12:39:15 +0000
From:   Colin King <colin.king@canonical.com>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        linux-bluetooth@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] Bluetooth: btrtl: fix incorrect skb allocation failure check
Date:   Tue, 10 Nov 2020 12:39:15 +0000
Message-Id: <20201110123915.3356601-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Currently the check for a failed bt_skb_alloc allocation is incorrectly
checking using IS_ERR and this can lead to a null pointer dereference. Fix
this by checking for a null pointer return using the !skb idiom.

Addresses-Coverity: ("Dereference null return")
Fixes: 1996d9cad6ad ("Bluetooth: btrtl: Ask 8821C to drop old firmware")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/bluetooth/btrtl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
index 0ac0f8874ef7..12099c40f8d6 100644
--- a/drivers/bluetooth/btrtl.c
+++ b/drivers/bluetooth/btrtl.c
@@ -572,7 +572,7 @@ struct btrtl_device_info *btrtl_initialize(struct hci_dev *hdev,
 		cmd[1] = opcode >> 8;
 
 		skb = bt_skb_alloc(sizeof(cmd), GFP_KERNEL);
-		if (IS_ERR(skb))
+		if (!skb)
 			goto out_free;
 
 		skb_put_data(skb, cmd, sizeof(cmd));
-- 
2.28.0

