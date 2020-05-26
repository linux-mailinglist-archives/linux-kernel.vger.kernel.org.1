Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 780441DA2C4
	for <lists+linux-kernel@lfdr.de>; Tue, 19 May 2020 22:35:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728225AbgESUfj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 May 2020 16:35:39 -0400
Received: from rnd-relay.smtp.broadcom.com ([192.19.229.170]:34988 "EHLO
        rnd-relay.smtp.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725885AbgESUes (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 16:34:48 -0400
Received: from mail-irv-17.broadcom.com (mail-irv-17.lvn.broadcom.net [10.75.242.48])
        by rnd-relay.smtp.broadcom.com (Postfix) with ESMTP id 5FB7A30D7F7;
        Tue, 19 May 2020 13:33:24 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 rnd-relay.smtp.broadcom.com 5FB7A30D7F7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1589920404;
        bh=IsUUhtwsD/oh2f/SMvEH2GyEwKF93YifRW5ZmP5F42Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V93UrU4MAVkDGfqd3yGeIFRvw45/OMaRMYSj7RrXDWz9fhSo0txRe0c37BBwsBpRT
         bTNyKe5FMvFYEaJuCUXNQxN0mJXe4Yi6Ok60s9sOEuG3qEvHn/J+eL0ooyG9Lp55BP
         LKpP06QS+z6ojuxmjHpsdWH1LTOEwK1rSEx8HSsE=
Received: from stbsrv-and-01.and.broadcom.net (stbsrv-and-01.and.broadcom.net [10.28.16.211])
        by mail-irv-17.broadcom.com (Postfix) with ESMTP id CFFB414008B;
        Tue, 19 May 2020 13:34:45 -0700 (PDT)
From:   Jim Quinlan <james.quinlan@broadcom.com>
To:     james.quinlan@broadcom.com,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     Jim Quinlan <james.quinlan@broadcom.com>,
        Jens Axboe <axboe@kernel.dk>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-ide@vger.kernel.org (open list:LIBATA SUBSYSTEM (Serial and
        Parallel ATA drivers)), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 02/15] ahci_brcm: fix use of BCM7216 reset controller
Date:   Tue, 19 May 2020 16:34:00 -0400
Message-Id: <20200519203419.12369-3-james.quinlan@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200519203419.12369-1-james.quinlan@broadcom.com>
References: <20200519203419.12369-1-james.quinlan@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jim Quinlan <jquinlan@broadcom.com>

A reset controller "rescal" is shared between the AHCI driver
and the PCIe driver for the BrcmSTB 7216 chip.  The code is
modified to allow this sharing and to deassert() properly.

Signed-off-by: Jim Quinlan <jquinlan@broadcom.com>
---
 drivers/ata/ahci_brcm.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/ata/ahci_brcm.c b/drivers/ata/ahci_brcm.c
index 6853dbb4131d..a3c32fc29e9c 100644
--- a/drivers/ata/ahci_brcm.c
+++ b/drivers/ata/ahci_brcm.c
@@ -428,7 +428,6 @@ static int brcm_ahci_probe(struct platform_device *pdev)
 {
 	const struct of_device_id *of_id;
 	struct device *dev = &pdev->dev;
-	const char *reset_name = NULL;
 	struct brcm_ahci_priv *priv;
 	struct ahci_host_priv *hpriv;
 	struct resource *res;
@@ -452,11 +451,11 @@ static int brcm_ahci_probe(struct platform_device *pdev)
 
 	/* Reset is optional depending on platform and named differently */
 	if (priv->version == BRCM_SATA_BCM7216)
-		reset_name = "rescal";
+		priv->rcdev = devm_reset_control_get_shared(&pdev->dev,
+							    "rescal");
 	else
-		reset_name = "ahci";
-
-	priv->rcdev = devm_reset_control_get_optional(&pdev->dev, reset_name);
+		priv->rcdev = devm_reset_control_get_optional(&pdev->dev,
+							      "ahci");
 	if (IS_ERR(priv->rcdev))
 		return PTR_ERR(priv->rcdev);
 
@@ -479,10 +478,7 @@ static int brcm_ahci_probe(struct platform_device *pdev)
 		break;
 	}
 
-	if (priv->version == BRCM_SATA_BCM7216)
-		ret = reset_control_reset(priv->rcdev);
-	else
-		ret = reset_control_deassert(priv->rcdev);
+	ret = reset_control_deassert(priv->rcdev);
 	if (ret)
 		return ret;
 
-- 
2.17.1

