Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2CFF2B1A22
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 12:37:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726502AbgKMLgf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 06:36:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726773AbgKMLfx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 06:35:53 -0500
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 188F7C0617A7;
        Fri, 13 Nov 2020 03:34:32 -0800 (PST)
Received: by mail-lj1-x242.google.com with SMTP id s9so10224583ljo.11;
        Fri, 13 Nov 2020 03:34:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0fTLiXtZpLLPcFQIFC7geS8UdiET+AvLEFDfYJsVl74=;
        b=tfm5W4es9Mp3wBjyVvXtOuBVKgodSzR5gBCU27i6rquycr6FkdqGUnDw2IK+tQr4hf
         ynPwAsN/ps3Lt1GxrMN0bRITLTX+5Vye+R3n8Cqx504fhLDV9CnThU/ipRrT7rYJ0jAu
         h4TzlePhHAwBI8Aio90UNmkDdDdPlbuUNNGEMyY9a6FH2UEqO7LMnSDEusgbcrY1p8L4
         J9hnZdEWgMPU6KYaCDGTBMyCsrTaJPKKQYQAp8I8pdZpJAcmsF7/DMilyndGzSseCe8s
         DuF9VMzict1QnAlsOeXZPgalvX/J+ZOpWS90+XKu5qbb6XnO1A+z78753r8NNbXC86s6
         cm5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0fTLiXtZpLLPcFQIFC7geS8UdiET+AvLEFDfYJsVl74=;
        b=Z2boWemdI8TmbxXWOSPbua70jKq9yfySxFWvYxbVHo/NS6JfdIOrYN9XjxI/LAkydU
         Os4pOhWBFUjeENDIXppAo7vh5yxYwbl3D8/Gp4QJby6BnPFHrV5z2cxRWi3pAP2ZyHDs
         ZhK/jAFd+6VdURMD/sjdkN+hKjEPfNuI+hYoUTR+oRmK/J/DbGQWh5FrRBRYjRbG1O47
         zpVc6SbtDfFjT8dsibbiqdxjaAODLXvkzlf76ZYU0d/Q6NS4LXdn71acLy0oXM8R883Z
         Vs36bgh8PJNelmi6GtGSXWxQxEKNXeFYJ0D8+6pRdT4V5WcXelRP0N7FrFpeWLDVZr5Q
         Sp3A==
X-Gm-Message-State: AOAM531ryJJoCGJp7nWUK7YGbqSyhUjlgl18/HivbuDxJpkZL8VcPWeB
        CToZginipMcuOG8JP5itqEU=
X-Google-Smtp-Source: ABdhPJwsqrXrizxTDkV0zQX3sYEm4qfj/wppWnWYk0nvArIAJPrdlDqSakJEe6IuXXdD/ImeOnxtlQ==
X-Received: by 2002:a2e:9083:: with SMTP id l3mr867170ljg.118.1605267270593;
        Fri, 13 Nov 2020 03:34:30 -0800 (PST)
Received: from localhost.localdomain (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.gmail.com with ESMTPSA id r19sm1620096ljn.73.2020.11.13.03.34.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2020 03:34:29 -0800 (PST)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Hauke Mehrtens <hauke@hauke-m.de>,
        bcm-kernel-feedback-list@broadcom.com,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH] phy: phy-bcm-ns-usb3: drop support for deprecated DT binding
Date:   Fri, 13 Nov 2020 12:34:23 +0100
Message-Id: <20201113113423.9466-1-zajec5@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafał Miłecki <rafal@milecki.pl>

Initially this PHY driver was implementing MDIO access on its own. It
was caused by lack of proper hardware design understanding.

It has been changed back in 2017. DT bindings were changed and driver
was updated to use MDIO layer.

It should be really safe now to drop the old deprecated code. All Linux
stored DT files don't use it for 3,5 year. There is close to 0 chance
there is any bootloader with its own DTB using old the binding.

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
 drivers/phy/broadcom/phy-bcm-ns-usb3.c | 159 +------------------------
 1 file changed, 5 insertions(+), 154 deletions(-)

diff --git a/drivers/phy/broadcom/phy-bcm-ns-usb3.c b/drivers/phy/broadcom/phy-bcm-ns-usb3.c
index 47b029fbebbd..eb10ffa13a62 100644
--- a/drivers/phy/broadcom/phy-bcm-ns-usb3.c
+++ b/drivers/phy/broadcom/phy-bcm-ns-usb3.c
@@ -22,8 +22,6 @@
 #include <linux/phy/phy.h>
 #include <linux/slab.h>
 
-#define BCM_NS_USB3_MII_MNG_TIMEOUT_US	1000	/* usecs */
-
 #define BCM_NS_USB3_PHY_BASE_ADDR_REG	0x1f
 #define BCM_NS_USB3_PHY_PLL30_BLOCK	0x8000
 #define BCM_NS_USB3_PHY_TX_PMD_BLOCK	0x8040
@@ -51,11 +49,8 @@ struct bcm_ns_usb3 {
 	struct device *dev;
 	enum bcm_ns_family family;
 	void __iomem *dmp;
-	void __iomem *ccb_mii;
 	struct mdio_device *mdiodev;
 	struct phy *phy;
-
-	int (*phy_write)(struct bcm_ns_usb3 *usb3, u16 reg, u16 value);
 };
 
 static const struct of_device_id bcm_ns_usb3_id_table[] = {
@@ -69,13 +64,9 @@ static const struct of_device_id bcm_ns_usb3_id_table[] = {
 	},
 	{},
 };
-MODULE_DEVICE_TABLE(of, bcm_ns_usb3_id_table);
 
 static int bcm_ns_usb3_mdio_phy_write(struct bcm_ns_usb3 *usb3, u16 reg,
-				      u16 value)
-{
-	return usb3->phy_write(usb3, reg, value);
-}
+				      u16 value);
 
 static int bcm_ns_usb3_phy_init_ns_bx(struct bcm_ns_usb3 *usb3)
 {
@@ -187,8 +178,8 @@ static const struct phy_ops ops = {
  * MDIO driver code
  **************************************************/
 
-static int bcm_ns_usb3_mdiodev_phy_write(struct bcm_ns_usb3 *usb3, u16 reg,
-					 u16 value)
+static int bcm_ns_usb3_mdio_phy_write(struct bcm_ns_usb3 *usb3, u16 reg,
+				      u16 value)
 {
 	struct mdio_device *mdiodev = usb3->mdiodev;
 
@@ -229,8 +220,6 @@ static int bcm_ns_usb3_mdio_probe(struct mdio_device *mdiodev)
 		return PTR_ERR(usb3->dmp);
 	}
 
-	usb3->phy_write = bcm_ns_usb3_mdiodev_phy_write;
-
 	usb3->phy = devm_phy_create(dev, NULL, &ops);
 	if (IS_ERR(usb3->phy)) {
 		dev_err(dev, "Failed to create PHY\n");
@@ -254,145 +243,7 @@ static struct mdio_driver bcm_ns_usb3_mdio_driver = {
 	.probe = bcm_ns_usb3_mdio_probe,
 };
 
-/**************************************************
- * Platform driver code
- **************************************************/
-
-static int bcm_ns_usb3_wait_reg(struct bcm_ns_usb3 *usb3, void __iomem *addr,
-				u32 mask, u32 value, int usec)
-{
-	u32 val;
-	int ret;
-
-	ret = readl_poll_timeout_atomic(addr, val, ((val & mask) == value),
-					10, usec);
-	if (ret)
-		dev_err(usb3->dev, "Timeout waiting for register %p\n", addr);
-
-	return ret;
-}
-
-static inline int bcm_ns_usb3_mii_mng_wait_idle(struct bcm_ns_usb3 *usb3)
-{
-	return bcm_ns_usb3_wait_reg(usb3, usb3->ccb_mii + BCMA_CCB_MII_MNG_CTL,
-				    0x0100, 0x0000,
-				    BCM_NS_USB3_MII_MNG_TIMEOUT_US);
-}
-
-static int bcm_ns_usb3_platform_phy_write(struct bcm_ns_usb3 *usb3, u16 reg,
-					  u16 value)
-{
-	u32 tmp = 0;
-	int err;
-
-	err = bcm_ns_usb3_mii_mng_wait_idle(usb3);
-	if (err < 0) {
-		dev_err(usb3->dev, "Couldn't write 0x%08x value\n", value);
-		return err;
-	}
-
-	/* TODO: Use a proper MDIO bus layer */
-	tmp |= 0x58020000; /* Magic value for MDIO PHY write */
-	tmp |= reg << 18;
-	tmp |= value;
-	writel(tmp, usb3->ccb_mii + BCMA_CCB_MII_MNG_CMD_DATA);
-
-	return bcm_ns_usb3_mii_mng_wait_idle(usb3);
-}
-
-static int bcm_ns_usb3_probe(struct platform_device *pdev)
-{
-	struct device *dev = &pdev->dev;
-	const struct of_device_id *of_id;
-	struct bcm_ns_usb3 *usb3;
-	struct resource *res;
-	struct phy_provider *phy_provider;
-
-	usb3 = devm_kzalloc(dev, sizeof(*usb3), GFP_KERNEL);
-	if (!usb3)
-		return -ENOMEM;
-
-	usb3->dev = dev;
-
-	of_id = of_match_device(bcm_ns_usb3_id_table, dev);
-	if (!of_id)
-		return -EINVAL;
-	usb3->family = (enum bcm_ns_family)of_id->data;
-
-	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dmp");
-	usb3->dmp = devm_ioremap_resource(dev, res);
-	if (IS_ERR(usb3->dmp)) {
-		dev_err(dev, "Failed to map DMP regs\n");
-		return PTR_ERR(usb3->dmp);
-	}
-
-	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "ccb-mii");
-	usb3->ccb_mii = devm_ioremap_resource(dev, res);
-	if (IS_ERR(usb3->ccb_mii)) {
-		dev_err(dev, "Failed to map ChipCommon B MII regs\n");
-		return PTR_ERR(usb3->ccb_mii);
-	}
-
-	/* Enable MDIO. Setting MDCDIV as 26  */
-	writel(0x0000009a, usb3->ccb_mii + BCMA_CCB_MII_MNG_CTL);
-
-	/* Wait for MDIO? */
-	udelay(2);
-
-	usb3->phy_write = bcm_ns_usb3_platform_phy_write;
-
-	usb3->phy = devm_phy_create(dev, NULL, &ops);
-	if (IS_ERR(usb3->phy)) {
-		dev_err(dev, "Failed to create PHY\n");
-		return PTR_ERR(usb3->phy);
-	}
-
-	phy_set_drvdata(usb3->phy, usb3);
-	platform_set_drvdata(pdev, usb3);
-
-	phy_provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
-	if (!IS_ERR(phy_provider))
-		dev_info(dev, "Registered Broadcom Northstar USB 3.0 PHY driver\n");
-
-	return PTR_ERR_OR_ZERO(phy_provider);
-}
-
-static struct platform_driver bcm_ns_usb3_driver = {
-	.probe		= bcm_ns_usb3_probe,
-	.driver = {
-		.name = "bcm_ns_usb3",
-		.of_match_table = bcm_ns_usb3_id_table,
-	},
-};
-
-static int __init bcm_ns_usb3_module_init(void)
-{
-	int err;
-
-	/*
-	 * For backward compatibility we register as MDIO and platform driver.
-	 * After getting MDIO binding commonly used (e.g. switching all DT files
-	 * to use it) we should deprecate the old binding and eventually drop
-	 * support for it.
-	 */
-
-	err = mdio_driver_register(&bcm_ns_usb3_mdio_driver);
-	if (err)
-		return err;
-
-	err = platform_driver_register(&bcm_ns_usb3_driver);
-	if (err)
-		mdio_driver_unregister(&bcm_ns_usb3_mdio_driver);
-
-	return err;
-}
-module_init(bcm_ns_usb3_module_init);
-
-static void __exit bcm_ns_usb3_module_exit(void)
-{
-	platform_driver_unregister(&bcm_ns_usb3_driver);
-	mdio_driver_unregister(&bcm_ns_usb3_mdio_driver);
-}
-module_exit(bcm_ns_usb3_module_exit)
+mdio_module_driver(bcm_ns_usb3_mdio_driver);
 
 MODULE_LICENSE("GPL v2");
+MODULE_DEVICE_TABLE(of, bcm_ns_usb3_id_table);
-- 
2.27.0

