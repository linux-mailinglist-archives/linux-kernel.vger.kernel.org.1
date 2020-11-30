Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3542F2C7FEA
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 09:31:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727852AbgK3IaU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 03:30:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:60794 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727764AbgK3IaR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 03:30:17 -0500
Received: from ogabbay-VM.habana-labs.com (unknown [213.57.90.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F0A6B206CA;
        Mon, 30 Nov 2020 08:29:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606724977;
        bh=+n2cbpy5Za9HATx3+PZ+DB4kgojoXADfhKXEvNt8EV0=;
        h=From:To:Cc:Subject:Date:From;
        b=JdGwQt6U8Jd16cz/ugv8za/YBx0RiauKh7PrNaVRuEgHdOx4mJssJXtuWWGrNoskk
         wY9l4gYqXLmYUHskbEmdlKqYfvzoiaNYZa4G7JVKrmlLrfQ0OgEZjWpCdGvCurHUag
         5jjpZBty7qPOxP16B12iJFP1EFMQGN51w3BmeF08=
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     SW_Drivers@habana.ai, Ofir Bitton <obitton@habana.ai>
Subject: [PATCH] habanalabs: put devices before driver removal
Date:   Mon, 30 Nov 2020 10:29:32 +0200
Message-Id: <20201130082932.557-1-ogabbay@kernel.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ofir Bitton <obitton@habana.ai>

Driver never puts its device and control_device objects, hence
a memory leak is introduced every driver removal.

Signed-off-by: Ofir Bitton <obitton@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/device.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/misc/habanalabs/common/device.c b/drivers/misc/habanalabs/common/device.c
index 20572224099a..783bbdcb1e61 100644
--- a/drivers/misc/habanalabs/common/device.c
+++ b/drivers/misc/habanalabs/common/device.c
@@ -231,16 +231,16 @@ static int device_cdev_sysfs_add(struct hl_device *hdev)
 
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
@@ -1371,9 +1371,9 @@ int hl_device_init(struct hl_device *hdev, struct class *hclass)
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
2.17.1

