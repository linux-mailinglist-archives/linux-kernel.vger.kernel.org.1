Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40BF92EC569
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 22:00:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727486AbhAFU7e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 15:59:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726195AbhAFU7d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 15:59:33 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D633C061799;
        Wed,  6 Jan 2021 12:58:53 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id m25so9588814lfc.11;
        Wed, 06 Jan 2021 12:58:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JwP+zFz/2tJGJq7cqXl5uLiK2iVo8O2/+HMJMszT670=;
        b=r5ov6drRZOWp+YE1g8s7nU1UotDKrkl3JsvtXtP5qJbrhFLDLlP2vGMAsTheKkXQlh
         3IkHZGsQQeDd0VH8v/0GX8ZPCsYhYBN/tYI171YIA8jm2osB/LDzUqXEQ/gL2bo7zpnC
         0R+fy6kETp5a9Vch9WqOrTdK1kS6Z5W0W5UrnaiZBSEaPa//BniqKMWyNbq9o6l7470w
         wO7AwK7AulJbs2iUXsGnF6LMps+u7boRrLUnlA/JI3Pg6hM5T0rEKg4LYHKhUNPEj31x
         XKos6zWigF6bRHb0AxgcrsiZ65SrD9et5AJB9/a4YTKLHINhvrn9lx8/3MjCtIOlfxGI
         s+Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JwP+zFz/2tJGJq7cqXl5uLiK2iVo8O2/+HMJMszT670=;
        b=ZnV0yhcqb4iJxlreIWfl1UkyB6Rv5XCfhl3VbjRfI44jCRkL/Uw6oUg/sW/sm98AwP
         716Xu0Dg+OBWSE+f/5EyrenWmJTl+rdlkCnYaNC6sdd8SLQEgAwrUQQBKXLdXFNvDfFI
         oy2rvtXr9Yb/tcQX7AJ2jxytj3iEUN+1XUDhu6BBpBaK8UduLbY9mPRCdk/e9zj8D72a
         iSpUUcKUl7Q/uWLpE8SjVnfH1qWa9b6shzmZH2y9fW8KsSvm/fKF4FA1SMrgCnme9oV8
         lLAS+SBBX+EA8Q/loUbvJJUMei2s7J500xn9tpAf+vEoOiDVbDzNz73YNXp2sEbUTQ2v
         +aCQ==
X-Gm-Message-State: AOAM530ultF0SBZubu4q/MfbRZKzNYcG03IdOpX8NcuVq8fxHq4Eb+Mo
        YsiVlKk8DhsLFWnz9JmtZKU=
X-Google-Smtp-Source: ABdhPJwONQac4yfNQrG0w79mZ4u3LUCQ0bwiw0Mrz7EkedpAuWT5I5jaMCYC9E235zm57rtKP2sjXQ==
X-Received: by 2002:a19:904:: with SMTP id 4mr2775748lfj.64.1609966731590;
        Wed, 06 Jan 2021 12:58:51 -0800 (PST)
Received: from localhost.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.gmail.com with ESMTPSA id t3sm606970lfe.263.2021.01.06.12.58.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jan 2021 12:58:51 -0800 (PST)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Al Cooper <alcooperx@gmail.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH V4 3/3] phy: phy-brcm-usb: support PHY on the BCM4908
Date:   Wed,  6 Jan 2021 21:58:38 +0100
Message-Id: <20210106205838.10964-3-zajec5@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210106205838.10964-1-zajec5@gmail.com>
References: <20210106205838.10964-1-zajec5@gmail.com>
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
Acked-by: Florian Fainelli <f.fainelli@gmail.com>
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

