Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77BAF2DB4F9
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 21:23:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727749AbgLOUXG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 15:23:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727658AbgLOUW2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 15:22:28 -0500
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33C8FC0611C5;
        Tue, 15 Dec 2020 12:21:48 -0800 (PST)
Received: by mail-lf1-x142.google.com with SMTP id o17so39802947lfg.4;
        Tue, 15 Dec 2020 12:21:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cJqQuNC/mfXNFGNx5Da7HZGyoqOlnkc4HHGflJlaRm4=;
        b=ZsjRm7/2+WwS5yMDVcqBtINZ8NDdQo4KrJ9zfjqNm0tClLEdvC8mytysIseDyHSrI7
         4PA/oHo2PFB1hyPau4DNMe51/ydX6WA1EhgFmrlQPPTCyegnNEEb5Zs+F1fUs9VlbwOm
         V6a6M9xUyfJKN8oy1wHqKBixRQraL64CY4GT16xeg9v4QNnikuZ43hKLCm3H7vvYZOF0
         E/1UyKCvgZSmGadb4IKs2WJ2of2d+XWqEATc/z9o6cbevHk22pgK+7weGFWIACsuJn6h
         k0HD3HkMURpv4VMK8KLsEq23+nzyreNMr8JktfYEOX1yw1BjLw6CxzNlsjCY39Aa0i21
         hyMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cJqQuNC/mfXNFGNx5Da7HZGyoqOlnkc4HHGflJlaRm4=;
        b=ZPyoPFi6JMUIJ5Hxjc0HiQujb5rozyL3/by/sQZE6XiL45MXfIvN/sHizYuqEFmbV9
         IPtgglB+QrxwLnRztd3HllSkX/x0zMklhiaF6cMosmG3kRaLXEVKYeI1NOwY85jNx4GP
         hDt6ZQFiI6xBzCQJFhVDvgNJndVHx/U0M2pvsiz3wmdulDC4CZ8bBZiSAG8bWsmFNyTT
         Ap1EBJbyG6+XbpqGZTBOzLBSzgqLrYQTADCKbXAlSdGwGiXVwgje/G7PspGy2bhfq5z5
         65zI2ycOFRRFLnKESaoRYebmZWxH5LOnYhIaFWHu1zYCtwPBQlPY08pT+E+KvuQoMqTN
         +VIg==
X-Gm-Message-State: AOAM533ZrOnnCZlqAJiZm7+irJpFllS+rWcEHIjypAPmNCMsXfcf+suN
        N0PLSGoelzas9GeAKdQ2cMs=
X-Google-Smtp-Source: ABdhPJylXdFXDL+gGmub2vLkwmt6ax30waBWb81m8BXl7CIAZujkuNCOGwXc1qvKDiacjNkgvQen4g==
X-Received: by 2002:a2e:858a:: with SMTP id b10mr2358904lji.227.1608063706721;
        Tue, 15 Dec 2020 12:21:46 -0800 (PST)
Received: from localhost.localdomain (109-252-192-57.dynamic.spd-mgts.ru. [109.252.192.57])
        by smtp.gmail.com with ESMTPSA id f3sm2873711ljp.114.2020.12.15.12.21.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Dec 2020 12:21:46 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter Chen <Peter.Chen@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Felipe Balbi <balbi@kernel.org>,
        Matt Merhar <mattmerhar@protonmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Peter Geis <pgwipeout@gmail.com>
Cc:     linux-tegra@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/8] usb: phy: tegra: Support waking up from a low power mode
Date:   Tue, 15 Dec 2020 23:21:07 +0300
Message-Id: <20201215202113.30394-3-digetx@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201215202113.30394-1-digetx@gmail.com>
References: <20201215202113.30394-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support programming of waking up from a low power mode by implementing the
generic set_wakeup() callback of the USB PHY API.

Tested-by: Matt Merhar <mattmerhar@protonmail.com>
Tested-by: Nicolas Chauvet <kwizart@gmail.com>
Tested-by: Peter Geis <pgwipeout@gmail.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/usb/phy/phy-tegra-usb.c   | 79 ++++++++++++++++++++++++++++---
 include/linux/usb/tegra_usb_phy.h |  2 +
 2 files changed, 75 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/phy/phy-tegra-usb.c b/drivers/usb/phy/phy-tegra-usb.c
index cee9c9dbb775..ed5f6611b36a 100644
--- a/drivers/usb/phy/phy-tegra-usb.c
+++ b/drivers/usb/phy/phy-tegra-usb.c
@@ -45,6 +45,7 @@
 #define TEGRA_PORTSC1_RWC_BITS	(PORT_CSC | PORT_PEC | PORT_OCC)
 
 #define USB_SUSP_CTRL				0x400
+#define   USB_WAKE_ON_RESUME_EN			BIT(2)
 #define   USB_WAKE_ON_CNNT_EN_DEV		BIT(3)
 #define   USB_WAKE_ON_DISCON_EN_DEV		BIT(4)
 #define   USB_SUSP_CLR				BIT(5)
@@ -56,6 +57,9 @@
 #define   USB_SUSP_SET				BIT(14)
 #define   USB_WAKEUP_DEBOUNCE_COUNT(x)		(((x) & 0x7) << 16)
 
+#define USB_PHY_VBUS_WAKEUP_ID			0x408
+#define   VBUS_WAKEUP_WAKEUP_EN			BIT(30)
+
 #define USB1_LEGACY_CTRL			0x410
 #define   USB1_NO_LEGACY_MODE			BIT(0)
 #define   USB1_VBUS_SENSE_CTL_MASK		(3 << 1)
@@ -334,6 +338,11 @@ static int utmip_pad_power_on(struct tegra_usb_phy *phy)
 		writel_relaxed(val, base + UTMIP_BIAS_CFG0);
 	}
 
+	if (phy->pad_wakeup) {
+		phy->pad_wakeup = false;
+		utmip_pad_count--;
+	}
+
 	spin_unlock(&utmip_pad_lock);
 
 	clk_disable_unprepare(phy->pad_clk);
@@ -359,6 +368,17 @@ static int utmip_pad_power_off(struct tegra_usb_phy *phy)
 		goto ulock;
 	}
 
+	/*
+	 * In accordance to TRM, OTG and Bias pad circuits could be turned off
+	 * to save power if wake is enabled, but the VBUS-change detection
+	 * method is board-specific and these circuits may need to be enabled
+	 * to generate wakeup event, hence we will just keep them both enabled.
+	 */
+	if (phy->wakeup_enabled) {
+		phy->pad_wakeup = true;
+		utmip_pad_count++;
+	}
+
 	if (--utmip_pad_count == 0) {
 		val = readl_relaxed(base + UTMIP_BIAS_CFG0);
 		val |= UTMIP_OTGPD | UTMIP_BIASPD;
@@ -503,11 +523,19 @@ static int utmi_phy_power_on(struct tegra_usb_phy *phy)
 		writel_relaxed(val, base + UTMIP_PLL_CFG1);
 	}
 
+	val = readl_relaxed(base + USB_SUSP_CTRL);
+	val &= ~USB_WAKE_ON_RESUME_EN;
+	writel_relaxed(val, base + USB_SUSP_CTRL);
+
 	if (phy->mode == USB_DR_MODE_PERIPHERAL) {
 		val = readl_relaxed(base + USB_SUSP_CTRL);
 		val &= ~(USB_WAKE_ON_CNNT_EN_DEV | USB_WAKE_ON_DISCON_EN_DEV);
 		writel_relaxed(val, base + USB_SUSP_CTRL);
 
+		val = readl_relaxed(base + USB_PHY_VBUS_WAKEUP_ID);
+		val &= ~VBUS_WAKEUP_WAKEUP_EN;
+		writel_relaxed(val, base + USB_PHY_VBUS_WAKEUP_ID);
+
 		val = readl_relaxed(base + UTMIP_BAT_CHRG_CFG0);
 		val &= ~UTMIP_PD_CHRG;
 		writel_relaxed(val, base + UTMIP_BAT_CHRG_CFG0);
@@ -605,31 +633,51 @@ static int utmi_phy_power_off(struct tegra_usb_phy *phy)
 
 	utmi_phy_clk_disable(phy);
 
-	if (phy->mode == USB_DR_MODE_PERIPHERAL) {
-		val = readl_relaxed(base + USB_SUSP_CTRL);
-		val &= ~USB_WAKEUP_DEBOUNCE_COUNT(~0);
-		val |= USB_WAKE_ON_CNNT_EN_DEV | USB_WAKEUP_DEBOUNCE_COUNT(5);
-		writel_relaxed(val, base + USB_SUSP_CTRL);
-	}
+	/* PHY won't resume if reset is asserted */
+	if (phy->wakeup_enabled)
+		goto chrg_cfg0;
 
 	val = readl_relaxed(base + USB_SUSP_CTRL);
 	val |= UTMIP_RESET;
 	writel_relaxed(val, base + USB_SUSP_CTRL);
 
+chrg_cfg0:
 	val = readl_relaxed(base + UTMIP_BAT_CHRG_CFG0);
 	val |= UTMIP_PD_CHRG;
 	writel_relaxed(val, base + UTMIP_BAT_CHRG_CFG0);
 
+	if (phy->wakeup_enabled)
+		goto xcvr_cfg1;
+
 	val = readl_relaxed(base + UTMIP_XCVR_CFG0);
 	val |= UTMIP_FORCE_PD_POWERDOWN | UTMIP_FORCE_PD2_POWERDOWN |
 	       UTMIP_FORCE_PDZI_POWERDOWN;
 	writel_relaxed(val, base + UTMIP_XCVR_CFG0);
 
+xcvr_cfg1:
 	val = readl_relaxed(base + UTMIP_XCVR_CFG1);
 	val |= UTMIP_FORCE_PDDISC_POWERDOWN | UTMIP_FORCE_PDCHRP_POWERDOWN |
 	       UTMIP_FORCE_PDDR_POWERDOWN;
 	writel_relaxed(val, base + UTMIP_XCVR_CFG1);
 
+	if (phy->wakeup_enabled) {
+		val = readl_relaxed(base + USB_SUSP_CTRL);
+		val &= ~USB_WAKEUP_DEBOUNCE_COUNT(~0);
+		val |= USB_WAKEUP_DEBOUNCE_COUNT(5);
+		val |= USB_WAKE_ON_RESUME_EN;
+		writel_relaxed(val, base + USB_SUSP_CTRL);
+
+		/*
+		 * Ask VBUS sensor to generate wake event once cable is
+		 * connected.
+		 */
+		if (phy->mode == USB_DR_MODE_PERIPHERAL) {
+			val = readl_relaxed(base + USB_PHY_VBUS_WAKEUP_ID);
+			val |= VBUS_WAKEUP_WAKEUP_EN;
+			writel_relaxed(val, base + USB_PHY_VBUS_WAKEUP_ID);
+		}
+	}
+
 	return utmip_pad_power_off(phy);
 }
 
@@ -765,6 +813,15 @@ static int ulpi_phy_power_off(struct tegra_usb_phy *phy)
 	usleep_range(5000, 6000);
 	clk_disable_unprepare(phy->clk);
 
+	/*
+	 * Wakeup currently unimplemented for ULPI, thus PHY needs to be
+	 * force-resumed.
+	 */
+	if (WARN_ON_ONCE(phy->wakeup_enabled)) {
+		ulpi_phy_power_on(phy);
+		return -EOPNOTSUPP;
+	}
+
 	return 0;
 }
 
@@ -827,6 +884,15 @@ static void tegra_usb_phy_shutdown(struct usb_phy *u_phy)
 	phy->freq = NULL;
 }
 
+static int tegra_usb_phy_set_wakeup(struct usb_phy *u_phy, bool enable)
+{
+	struct tegra_usb_phy *phy = to_tegra_usb_phy(u_phy);
+
+	phy->wakeup_enabled = enable;
+
+	return 0;
+}
+
 static int tegra_usb_phy_set_suspend(struct usb_phy *u_phy, int suspend)
 {
 	struct tegra_usb_phy *phy = to_tegra_usb_phy(u_phy);
@@ -1198,6 +1264,7 @@ static int tegra_usb_phy_probe(struct platform_device *pdev)
 	tegra_phy->u_phy.dev = &pdev->dev;
 	tegra_phy->u_phy.init = tegra_usb_phy_init;
 	tegra_phy->u_phy.shutdown = tegra_usb_phy_shutdown;
+	tegra_phy->u_phy.set_wakeup = tegra_usb_phy_set_wakeup;
 	tegra_phy->u_phy.set_suspend = tegra_usb_phy_set_suspend;
 
 	platform_set_drvdata(pdev, tegra_phy);
diff --git a/include/linux/usb/tegra_usb_phy.h b/include/linux/usb/tegra_usb_phy.h
index c29d1b4c9381..fd1c9f6a4e37 100644
--- a/include/linux/usb/tegra_usb_phy.h
+++ b/include/linux/usb/tegra_usb_phy.h
@@ -79,6 +79,8 @@ struct tegra_usb_phy {
 	bool is_ulpi_phy;
 	struct gpio_desc *reset_gpio;
 	struct reset_control *pad_rst;
+	bool wakeup_enabled;
+	bool pad_wakeup;
 	bool powered_on;
 };
 
-- 
2.29.2

