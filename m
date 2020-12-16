Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34EB62DC24D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 15:35:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbgLPOdz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 09:33:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbgLPOdz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 09:33:55 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66A74C06179C;
        Wed, 16 Dec 2020 06:33:14 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id l11so48886458lfg.0;
        Wed, 16 Dec 2020 06:33:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OgA/Qj5MoeLXprwzpH85DyU4GOR+t7v9bSyabWdDu6Y=;
        b=d189VRzhBWxK/ithEterE85fheUFT35ZpyzsvKMhWkxDdDuMCGJJs2GrJeafo6X9Lp
         hLEaO0ybylViAI94CR/hOeAS28jxwmmbNdwOUr3WME5EFr6jDJwoYJ0ODVKa6RBCDZ2H
         nkDtnCoLElQhfqbBUlHXkMGTgxWh4w54HrwAQqqk3ps3tRCzvRjg7HCTfiUZHv3etXN6
         j1xdTprRWkj51BcIuIA4L2CLCnpPc3hfu0JAMtCUhhyIi/M8JtbIPb6OvCcKXL2l0zdo
         d3MKSFf86WN2+VtrWCN04Zn6U8t0ih3pq5e9AYPUb6kpZEf/pnWs1sPW2pOM8eneWgMP
         4Z1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OgA/Qj5MoeLXprwzpH85DyU4GOR+t7v9bSyabWdDu6Y=;
        b=QXRKEBt6uTlMDMVM2NuLYDGTSvx+PXufbfbeIb8xpJTknj+ige3FCKKRxgAiKBO0Ga
         6X4gLHnfl3u/mzeHzLba8RT5lgAav6FPwtI8eZdYiQ3ovHCn2ksqInAcRbMRToUagxjF
         SmVzQoDtdqbvU8dZ3v+1OTSXg02IHIRPam+GUeAiTfFTD/i7c10lMgR7up8PgloEDLNR
         0rXk5Wmn9sE5EIlxtmzSXLdV3x6sO3LN+6fPHRPYM8QIlh/18gQeqA8NMme+AxKI5oux
         lN7G6h3zQKqiFgbwvwUe1IfY4LIlKxVoYTwMuGhj0uxvln9FPKRUDUKjbRAn78BWusBw
         g9ng==
X-Gm-Message-State: AOAM532zK0sxSLgDvpi+1HbyFZTylmcWfcQLrJv5qVUHcI6tGnLUyrza
        jTUAZb7vAEcr20A1BZiNXig=
X-Google-Smtp-Source: ABdhPJyWdqhurn5BIrt7MvgzkcIQVlqqao56ZNN6OiHvgcpof5Lfuun3wpkqk6oL+O+fXHxOIuPD5A==
X-Received: by 2002:ac2:598c:: with SMTP id w12mr12061647lfn.526.1608129192537;
        Wed, 16 Dec 2020 06:33:12 -0800 (PST)
Received: from localhost.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.gmail.com with ESMTPSA id q21sm302803ljj.31.2020.12.16.06.33.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 06:33:11 -0800 (PST)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Al Cooper <alcooperx@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH 1/2] phy: phy-brcm-usb: improve getting OF matching data
Date:   Wed, 16 Dec 2020 15:33:04 +0100
Message-Id: <20201216143305.12179-1-zajec5@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafał Miłecki <rafal@milecki.pl>

1. Use of_device_get_match_data() helper to simplify the code
2. Check for NULL as a good practice

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
 drivers/phy/broadcom/phy-brcm-usb.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/phy/broadcom/phy-brcm-usb.c b/drivers/phy/broadcom/phy-brcm-usb.c
index 63f922a5f29b..f0f01060bd12 100644
--- a/drivers/phy/broadcom/phy-brcm-usb.c
+++ b/drivers/phy/broadcom/phy-brcm-usb.c
@@ -11,6 +11,7 @@
 #include <linux/io.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/of_device.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
 #include <linux/interrupt.h>
@@ -431,7 +432,6 @@ static int brcm_usb_phy_probe(struct platform_device *pdev)
 	struct device_node *dn = pdev->dev.of_node;
 	int err;
 	const char *mode;
-	const struct of_device_id *match;
 	void (*dvr_init)(struct brcm_usb_init_params *params);
 	const struct match_chip_info *info;
 	struct regmap *rmap;
@@ -445,8 +445,9 @@ static int brcm_usb_phy_probe(struct platform_device *pdev)
 	priv->ini.family_id = brcmstb_get_family_id();
 	priv->ini.product_id = brcmstb_get_product_id();
 
-	match = of_match_node(brcm_usb_dt_ids, dev->of_node);
-	info = match->data;
+	info = of_device_get_match_data(&pdev->dev);
+	if (!info)
+		return -ENOENT;
 	dvr_init = info->init_func;
 	(*dvr_init)(&priv->ini);
 
-- 
2.26.2

