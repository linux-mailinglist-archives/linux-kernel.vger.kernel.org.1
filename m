Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2D372C27F5
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 14:33:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388327AbgKXNbz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 08:31:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388302AbgKXNby (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 08:31:54 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A9EBC0613D6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 05:31:54 -0800 (PST)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1khYQ8-0001Ju-3b; Tue, 24 Nov 2020 14:31:48 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1khYQ7-0008Ge-Oj; Tue, 24 Nov 2020 14:31:47 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>
To:     Russell King <linux@armlinux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Rob Herring <robh@kernel.org>,
        linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Subject: [PATCH v2 3/5] vfio: platform: simplify device removal
Date:   Tue, 24 Nov 2020 14:31:37 +0100
Message-Id: <20201124133139.3072124-4-uwe@kleine-koenig.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201124133139.3072124-1-uwe@kleine-koenig.org>
References: <20201124133139.3072124-1-uwe@kleine-koenig.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

vfio_platform_remove_common() cannot return non-NULL in
vfio_amba_remove() as the latter is only called if vfio_amba_probe()
returned success.

Diagnosed-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/vfio/platform/vfio_amba.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/vfio/platform/vfio_amba.c b/drivers/vfio/platform/vfio_amba.c
index 9636a2afaecd..7b3ebf1558e1 100644
--- a/drivers/vfio/platform/vfio_amba.c
+++ b/drivers/vfio/platform/vfio_amba.c
@@ -73,16 +73,12 @@ static int vfio_amba_probe(struct amba_device *adev, const struct amba_id *id)
 
 static int vfio_amba_remove(struct amba_device *adev)
 {
-	struct vfio_platform_device *vdev;
-
-	vdev = vfio_platform_remove_common(&adev->dev);
-	if (vdev) {
-		kfree(vdev->name);
-		kfree(vdev);
-		return 0;
-	}
+	struct vfio_platform_device *vdev =
+		vfio_platform_remove_common(&adev->dev);
 
-	return -EINVAL;
+	kfree(vdev->name);
+	kfree(vdev);
+	return 0;
 }
 
 static const struct amba_id pl330_ids[] = {
-- 
2.29.2

