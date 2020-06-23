Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C683204C66
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jun 2020 10:30:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731837AbgFWIad (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Jun 2020 04:30:33 -0400
Received: from winnie.ispras.ru ([83.149.199.91]:11366 "EHLO smtp.ispras.ru"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731595AbgFWIac (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 04:30:32 -0400
Received: from home.intra.ispras.ru (unknown [10.10.165.12])
        by smtp.ispras.ru (Postfix) with ESMTP id 3C388201D0;
        Tue, 23 Jun 2020 11:30:27 +0300 (MSK)
From:   Evgeny Novikov <novikov@ispras.ru>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Evgeny Novikov <novikov@ispras.ru>,
        Sam Muhammed <jane.pnx9@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, ldv-project@linuxtesting.org
Subject: [PATCH] staging: kpc2000: kpc_dma: set error code in probe
Date:   Tue, 23 Jun 2020 11:29:59 +0300
Message-Id: <20200623082959.14951-1-novikov@ispras.ru>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If device_create() fails during probing the device, kpc_dma_probe() does
not set the error code and returns 0. This can result in various bad
issues later. The patch sets the error code on the corresponding error
handling path.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Evgeny Novikov <novikov@ispras.ru>
---
 drivers/staging/kpc2000/kpc_dma/kpc_dma_driver.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/kpc2000/kpc_dma/kpc_dma_driver.c b/drivers/staging/kpc2000/kpc_dma/kpc_dma_driver.c
index c3b30551e0ca..624d47bae4d1 100644
--- a/drivers/staging/kpc2000/kpc_dma/kpc_dma_driver.c
+++ b/drivers/staging/kpc2000/kpc_dma/kpc_dma_driver.c
@@ -140,6 +140,7 @@ int  kpc_dma_probe(struct platform_device *pldev)
 	dev = MKDEV(assigned_major_num, pldev->id);
 	ldev->kpc_dma_dev = device_create(kpc_dma_class, &pldev->dev, dev, ldev, "kpc_dma%d", pldev->id);
 	if (IS_ERR(ldev->kpc_dma_dev)) {
+		rv = PTR_ERR(ldev->kpc_dma_dev);
 		dev_err(&ldev->pldev->dev, "%s: device_create failed: %d\n", __func__, rv);
 		goto err_kfree;
 	}
-- 
2.16.4

