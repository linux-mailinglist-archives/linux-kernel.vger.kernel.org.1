Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA7602FB774
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 15:26:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404740AbhASKyn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 05:54:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:45114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404490AbhASKp1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 05:45:27 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6213023132;
        Tue, 19 Jan 2021 10:44:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611053086;
        bh=rLzU+XPDcS60e7yQChZgksvBlUX5FDeW8KQxqXYWVoI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=T3i6ILf7eVGYddJ6d7TRX09RZnnbVH11fpIeQSteBB1bP+lzt+OKl+adxuwyWhnQr
         CYFLlB2W7OSb0OcnBK0IwrOvgqH5Lwk+w3Hs1olDtYOUVlHeRxtFm+FD8YEOqbqGvI
         pM7HzfyHWdezIIvYJBRWANprbSRKMZrInoyTKf+dYoL4/aJ0xpG2FV4aWGcZ99JTME
         E5n/qskYotlIu56ai/yWQvP9ORgFVl0XnFazMLoH/0ZzeMITUacOzzykTGp931MwHZ
         PjT9t3yeDWLdG7Y/YRLtGM8RkW92E4TwnF8DlRNPkI55filKPZx/0hQDYKHN3ARzxx
         VY3hYxklGsMyw==
Received: by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1l1oVA-000u2J-6h; Tue, 19 Jan 2021 11:44:44 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Alex Dewar <alex.dewar90@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Yu Chen <chenyu56@huawei.com>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 3/5] staging: hikey9xx: phy-hi3670-usb3: hi3670_is_abbclk_seleted() returns bool
Date:   Tue, 19 Jan 2021 11:44:41 +0100
Message-Id: <a579004cfa0cb3cca55c2124a8574a7aeb4eacc3.1611052729.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1611052729.git.mchehab+huawei@kernel.org>
References: <cover.1611052729.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are a few issues on this function:

1. Instead of using 1/0 for true/false, change the type to boolean;
2. there's a typo there:
	seleted -> selected
3. It's logic is reversed.

Address them.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/staging/hikey9xx/phy-hi3670-usb3.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/hikey9xx/phy-hi3670-usb3.c b/drivers/staging/hikey9xx/phy-hi3670-usb3.c
index cffe6c58dfd7..8918f3665f8e 100644
--- a/drivers/staging/hikey9xx/phy-hi3670-usb3.c
+++ b/drivers/staging/hikey9xx/phy-hi3670-usb3.c
@@ -326,24 +326,24 @@ static int hi3670_phy_set_params(struct hi3670_priv *priv)
 	return ret;
 }
 
-static int hi3670_is_abbclk_seleted(struct hi3670_priv *priv)
+static bool hi3670_is_abbclk_selected(struct hi3670_priv *priv)
 {
 	u32 reg;
 
 	if (!priv->sctrl) {
 		dev_err(priv->dev, "priv->sctrl is null!\n");
-		return 1;
+		return false;
 	}
 
 	if (regmap_read(priv->sctrl, SCTRL_SCDEEPSLEEPED, &reg)) {
 		dev_err(priv->dev, "SCTRL_SCDEEPSLEEPED read failed!\n");
-		return 1;
+		return false;
 	}
 
 	if ((reg & USB_CLK_SELECTED) == 0)
-		return 1;
+		return false;
 
-	return 0;
+	return true;
 }
 
 static int hi3670_config_phy_clock(struct hi3670_priv *priv)
@@ -351,7 +351,7 @@ static int hi3670_config_phy_clock(struct hi3670_priv *priv)
 	u32 val, mask;
 	int ret;
 
-	if (hi3670_is_abbclk_seleted(priv)) {
+	if (!hi3670_is_abbclk_selected(priv)) {
 		/* usb refclk iso disable */
 		ret = regmap_write(priv->peri_crg, PERI_CRG_ISODIS,
 				   USB_REFCLK_ISO_EN);
@@ -568,7 +568,7 @@ static int hi3670_phy_exit(struct phy *phy)
 	if (ret)
 		goto out;
 
-	if (hi3670_is_abbclk_seleted(priv)) {
+	if (!hi3670_is_abbclk_selected(priv)) {
 		/* disable usb_tcxo_en */
 		ret = regmap_write(priv->pctrl, PCTRL_PERI_CTRL3,
 				   USB_TCXO_EN << PCTRL_PERI_CTRL3_MSK_START);
-- 
2.29.2

