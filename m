Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B53A2D883B
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Dec 2020 17:45:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439423AbgLLQaT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Dec 2020 11:30:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:57722 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2439427AbgLLQKN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Dec 2020 11:10:13 -0500
From:   Sasha Levin <sashal@kernel.org>
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ofir Bitton <obitton@habana.ai>, Oded Gabbay <ogabbay@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.4 04/14] habanalabs: put devices before driver removal
Date:   Sat, 12 Dec 2020 11:08:21 -0500
Message-Id: <20201212160831.2335172-4-sashal@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201212160831.2335172-1-sashal@kernel.org>
References: <20201212160831.2335172-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ofir Bitton <obitton@habana.ai>

[ Upstream commit 5555b7c56bdec7a29c789fec27f84d40f52fbdfa ]

Driver never puts its device and control_device objects, hence
a memory leak is introduced every driver removal.

Signed-off-by: Ofir Bitton <obitton@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/misc/habanalabs/device.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/misc/habanalabs/device.c b/drivers/misc/habanalabs/device.c
index a7a4fed4d8995..3eeb1920ddb43 100644
--- a/drivers/misc/habanalabs/device.c
+++ b/drivers/misc/habanalabs/device.c
@@ -229,16 +229,16 @@ delete_cdev_device:
 
 static void device_cdev_sysfs_del(struct hl_device *hdev)
 {
-	/* device_release() won't be called so must free devices explicitly */
-	if (!hdev->cdev_sysfs_created) {
-		kfree(hdev->dev_ctrl);
-		kfree(hdev->dev);
-		return;
-	}
+	if (!hdev->cdev_sysfs_created)
+		goto put_devices;
 
 	hl_sysfs_fini(hdev);
 	cdev_device_del(&hdev->cdev_ctrl, hdev->dev_ctrl);
 	cdev_device_del(&hdev->cdev, hdev->dev);
+
+put_devices:
+	put_device(hdev->dev);
+	put_device(hdev->dev_ctrl);
 }
 
 /*
@@ -1285,9 +1285,9 @@ sw_fini:
 early_fini:
 	device_early_fini(hdev);
 free_dev_ctrl:
-	kfree(hdev->dev_ctrl);
+	put_device(hdev->dev_ctrl);
 free_dev:
-	kfree(hdev->dev);
+	put_device(hdev->dev);
 out_disabled:
 	hdev->disabled = true;
 	if (add_cdev_sysfs_on_err)
-- 
2.27.0

