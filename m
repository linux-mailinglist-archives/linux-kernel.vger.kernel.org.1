Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91CBC20D15D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jun 2020 20:41:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728955AbgF2Sl2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Jun 2020 14:41:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:60594 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728894AbgF2SlY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:41:24 -0400
Received: from localhost.localdomain (unknown [122.182.251.219])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4F31323E20;
        Mon, 29 Jun 2020 14:50:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593442251;
        bh=wK1Rk3kfZsfoDgsBf7HTzj2bmHRr8bn6RNEwGVBN8xg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ef3NEc+IYpEgAl9CbKy7qrCwMyc0GZ+UeLHtzLYqc9ttVNNXqFC6Y6L1H3VAFI1Kp
         1111h89oadFFtaj2ilnSpJB8UGw6mjngpW75GIrA5Xq5HJZT5ngtMTNyV2kFa9ZjCc
         +JOj9cEijk7Ycd92em5y04UwOguEIEU3qI6uUaaI=
From:   Vinod Koul <vkoul@kernel.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Vinod Koul <vkoul@kernel.org>, linux-kernel@vger.kernel.org,
        Roger Quadros <rogerq@ti.com>
Subject: [PATCH 3/4] phy: ti: dm816x: remove set but unused variable
Date:   Mon, 29 Jun 2020 20:20:09 +0530
Message-Id: <20200629145010.122675-3-vkoul@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200629145010.122675-1-vkoul@kernel.org>
References: <20200629145010.122675-1-vkoul@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dm816x_usb_phy_init() sets variable 'error' but never uses it, so remove
it.

drivers/phy/ti/phy-dm816x-usb.c:85:6: warning: variable ‘error’ set but
not used [-Wunused-but-set-variable]

Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 drivers/phy/ti/phy-dm816x-usb.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/phy/ti/phy-dm816x-usb.c b/drivers/phy/ti/phy-dm816x-usb.c
index 26f194779064..57adc08a89b2 100644
--- a/drivers/phy/ti/phy-dm816x-usb.c
+++ b/drivers/phy/ti/phy-dm816x-usb.c
@@ -82,17 +82,16 @@ static int dm816x_usb_phy_init(struct phy *x)
 {
 	struct dm816x_usb_phy *phy = phy_get_drvdata(x);
 	unsigned int val;
-	int error;
 
 	if (clk_get_rate(phy->refclk) != 24000000)
 		dev_warn(phy->dev, "nonstandard phy refclk\n");
 
 	/* Set PLL ref clock and put phys to sleep */
-	error = regmap_update_bits(phy->syscon, phy->usb_ctrl,
-				   DM816X_USB_CTRL_PHYCLKSRC |
-				   DM816X_USB_CTRL_PHYSLEEP1 |
-				   DM816X_USB_CTRL_PHYSLEEP0,
-				   0);
+	regmap_update_bits(phy->syscon, phy->usb_ctrl,
+			   DM816X_USB_CTRL_PHYCLKSRC |
+			   DM816X_USB_CTRL_PHYSLEEP1 |
+			   DM816X_USB_CTRL_PHYSLEEP0,
+			   0);
 	regmap_read(phy->syscon, phy->usb_ctrl, &val);
 	if ((val & 3) != 0)
 		dev_info(phy->dev,
-- 
2.26.2

