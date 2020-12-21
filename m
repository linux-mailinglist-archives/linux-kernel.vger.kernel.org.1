Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B54DE2DF8CC
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Dec 2020 06:25:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728388AbgLUFYr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 00:24:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728351AbgLUFYq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 00:24:46 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13954C061257;
        Sun, 20 Dec 2020 21:24:05 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id h205so20728242lfd.5;
        Sun, 20 Dec 2020 21:24:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1kQKlYjkEsXTqfe1rTtXK6ODUo/QOHx815FNAJpR+HA=;
        b=kWE4CzRUuiLhewBN3LwV88HGv7PIeug56nZWau594podr2HIkZss2CyKdsZcE0gyZR
         fgm26t4QROUmV3aQpV8n8ApI/CukOtkg0L0dwMng+Lg2egQkPp+la72FQSGCHAUvWN59
         CkmNiFTx4+5OCGB3x7bDgIfdgfDzSqxAExxHh2iJx0AdtqvUCEMU5q4y2Ll49t3a6jrU
         8Arlv4IHYGoxC9AiT/ihKufQHGdrhd+PQ/kCbgoVlfdhtTOAAT66dxu5U1C9tDMEP+1J
         7kOb40C5c14v599n2O2MEtmQg2k/4UVJ4qaVFLjSFX4HFU05y1qPkYneo2V2HQzKBInV
         lQ8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1kQKlYjkEsXTqfe1rTtXK6ODUo/QOHx815FNAJpR+HA=;
        b=QTfCoKpZ7Z0HHsFpmgfeOsMmAf2yn8DFckRvEsl+yt1qGbcN5TIV00MjtLG2rtNs3E
         HnZ5OqtxcdqmKp9XHGXBf1tIxTnOKX8up4RB3GhB0sX3HUY4+3hOr45DodjDXznnRau0
         x3vmtC+Xn8UlUzMcTHReZmBj3nzYLU0CiTYo/bK7iJ686QVXlUm7tet/UIfXtRAbvTyv
         Okk1DxEMawc2Djqv4BY5CydZEz88A5P8IkGJvyP1PJEtU6+ye0wLZYjoon+q0DWkn+CO
         Kg4XnE0d+JqSRCDQxsjm7i8nbHfvgr6DK6suqbGaEUTqg8OHPC/ltr+gmukuzPguF6XG
         TfPw==
X-Gm-Message-State: AOAM532ybyHnVq6bTx1sCHW4KTf4rwqdPSG1u2F9gD4PPV3hRI9SlNmM
        qryk8PP0Zd0V7mu09bL9MiQ=
X-Google-Smtp-Source: ABdhPJyFOfmlQWQwMN/ER5oqWkaKbwqNXNvbRc47gdcbSQ3QB7UD2O0L8CE3Er3Osehedc87r8rDKg==
X-Received: by 2002:a05:6512:3397:: with SMTP id h23mr5701889lfg.103.1608528243644;
        Sun, 20 Dec 2020 21:24:03 -0800 (PST)
Received: from localhost.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.gmail.com with ESMTPSA id v10sm2052525lji.130.2020.12.20.21.24.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Dec 2020 21:24:03 -0800 (PST)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Al Cooper <alcooperx@gmail.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH V2 3/3] phy: phy-brcm-usb: support PHY on the BCM4908
Date:   Mon, 21 Dec 2020 06:23:39 +0100
Message-Id: <20201221052339.10100-3-zajec5@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201221052339.10100-1-zajec5@gmail.com>
References: <20201221052339.10100-1-zajec5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafał Miłecki <rafal@milecki.pl>

BCM4908 seems to have slightly different registers but works when
programmed just like the STB one.

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
V2: Update Kconfig as well
---
 drivers/phy/broadcom/Kconfig        | 3 ++-
 drivers/phy/broadcom/phy-brcm-usb.c | 4 ++++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/phy/broadcom/Kconfig b/drivers/phy/broadcom/Kconfig
index a1f1a9c90d0d..09256339bd04 100644
--- a/drivers/phy/broadcom/Kconfig
+++ b/drivers/phy/broadcom/Kconfig
@@ -91,10 +91,11 @@ config PHY_BRCM_SATA
 
 config PHY_BRCM_USB
 	tristate "Broadcom STB USB PHY driver"
-	depends on ARCH_BRCMSTB || COMPILE_TEST
+	depends on ARCH_BCM4908 || ARCH_BRCMSTB || COMPILE_TEST
 	depends on OF
 	select GENERIC_PHY
 	select SOC_BRCMSTB
+	default ARCH_BCM4908
 	default ARCH_BRCMSTB
 	help
 	  Enable this to support the Broadcom STB USB PHY.
diff --git a/drivers/phy/broadcom/phy-brcm-usb.c b/drivers/phy/broadcom/phy-brcm-usb.c
index 99fbc7e4138b..63f922a5f29b 100644
--- a/drivers/phy/broadcom/phy-brcm-usb.c
+++ b/drivers/phy/broadcom/phy-brcm-usb.c
@@ -285,6 +285,10 @@ static const struct match_chip_info chip_info_7445 = {
 };
 
 static const struct of_device_id brcm_usb_dt_ids[] = {
+	{
+		.compatible = "brcm,bcm4908-usb-phy",
+		.data = &chip_info_7445,
+	},
 	{
 		.compatible = "brcm,bcm7216-usb-phy",
 		.data = &chip_info_7216,
-- 
2.26.2

