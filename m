Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DCDE2DC24F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 15:35:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726572AbgLPOd5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 09:33:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbgLPOd4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 09:33:56 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E54BC0617A6;
        Wed, 16 Dec 2020 06:33:16 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id 23so48840406lfg.10;
        Wed, 16 Dec 2020 06:33:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fH2l2Ia7BO3y3r4emJ9xAC0yjRKyCBVHd/WRfzCfaN8=;
        b=gomnBTgmxslprhhUPQAyiWF/o4oS7jcCEqTu2NgOniBhMPEcqaHVV4WBVbA5yKGUGT
         eUUswHnaQjQBCgeg7VDd7fCJkZSN2I+errDul/B2HhwhSnUAuBNqarx/gmyqPrZgjngc
         FJzOIn0hIXN4bkI9cVokFFxweSjXR/Z1/mdUwettlOlvbzyAAIilmAegYdCdQ3+8sisD
         UtgGXdLoTT+tc00/EtbrWCyXhUZwdxWe8SZEij56SSWiYX8uv9DEUAbYDO81BlYHhHHF
         8H7Lcj76bvpGNvPlzB8gQiE4pZy32t1156+SusGItVhmP3cPEv13JaoyTruLMyiHFNOB
         3H2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fH2l2Ia7BO3y3r4emJ9xAC0yjRKyCBVHd/WRfzCfaN8=;
        b=gVlp/wOBtrZcgPOpX1iaphtX7nS90/mvRncB+d9ujjfqtg4PBRw6VpHVWZgxHB+qyy
         2+HHpd3/qZxJgOHMccZMtFkqUFhXI+gf5Kp1kGapC9Qd8dcaNtMBdv4nmwxRe7ai9Yge
         J8hKSrdDzOqAdUT1TSpteqMVwlip4OOxXsE/svDKEIV+b2BTpraSvmyRODuMymV7q+jg
         SRGDEpeklP8dnn/K52i7h6mY7JpzL2OOHPAovH/PMG6gm3ply7S6fF11OV3KqQQVSHdT
         16WfpUo/hJACnmCP6y8gBvgtF5MNMerJHsm7koYMKbFGJ9/mhJa6BUfeRnt8nUb9ZcGR
         ajTQ==
X-Gm-Message-State: AOAM531N2oXewFSbRAkXV68DTzhQWNVamun++b56oTAflkMuKNgZjWvH
        Yb5vzHGAq50uIUvfOnQ4ACU=
X-Google-Smtp-Source: ABdhPJxClypsqHFX6VxGE5iSsayx4QiIkOMc8/mMOiQM0p6mqeirdNniV70/KbQo0XmJ+sZdXeCfHg==
X-Received: by 2002:a05:651c:1312:: with SMTP id u18mr13663281lja.200.1608129194415;
        Wed, 16 Dec 2020 06:33:14 -0800 (PST)
Received: from localhost.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.gmail.com with ESMTPSA id q21sm302803ljj.31.2020.12.16.06.33.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 06:33:13 -0800 (PST)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Al Cooper <alcooperx@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH 2/2] phy: phy-brcm-usb: specify init function format at struct level
Date:   Wed, 16 Dec 2020 15:33:05 +0100
Message-Id: <20201216143305.12179-2-zajec5@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201216143305.12179-1-zajec5@gmail.com>
References: <20201216143305.12179-1-zajec5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafał Miłecki <rafal@milecki.pl>

This is slightly cleaner solution that assures noone assings a wrong
function to the pointer.

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
 drivers/phy/broadcom/phy-brcm-usb.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/phy/broadcom/phy-brcm-usb.c b/drivers/phy/broadcom/phy-brcm-usb.c
index f0f01060bd12..116fb23aebd9 100644
--- a/drivers/phy/broadcom/phy-brcm-usb.c
+++ b/drivers/phy/broadcom/phy-brcm-usb.c
@@ -35,7 +35,7 @@ struct value_to_name_map {
 };
 
 struct match_chip_info {
-	void *init_func;
+	void (*init_func)(struct brcm_usb_init_params *params);
 	u8 required_regs[BRCM_REGS_MAX + 1];
 	u8 optional_reg;
 };
@@ -432,7 +432,6 @@ static int brcm_usb_phy_probe(struct platform_device *pdev)
 	struct device_node *dn = pdev->dev.of_node;
 	int err;
 	const char *mode;
-	void (*dvr_init)(struct brcm_usb_init_params *params);
 	const struct match_chip_info *info;
 	struct regmap *rmap;
 	int x;
@@ -448,8 +447,8 @@ static int brcm_usb_phy_probe(struct platform_device *pdev)
 	info = of_device_get_match_data(&pdev->dev);
 	if (!info)
 		return -ENOENT;
-	dvr_init = info->init_func;
-	(*dvr_init)(&priv->ini);
+
+	info->init_func(&priv->ini);
 
 	dev_dbg(dev, "Best mapping table is for %s\n",
 		priv->ini.family_name);
-- 
2.26.2

