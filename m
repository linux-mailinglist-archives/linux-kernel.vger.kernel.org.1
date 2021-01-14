Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C3F22F67DA
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 18:36:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728318AbhANRgb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 12:36:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:33866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725922AbhANRg2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 12:36:28 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0DB6A23B45;
        Thu, 14 Jan 2021 17:35:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610645748;
        bh=xa37m5Q/FryyLUx/FnM3xo2yMtvSkpnfWMgpl5fR0oo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HLv1ORWu9ZxRwe8pdpdw9HhGXLnNx3xoN0PEeyIKbfkRmFESf5EaBKxJMWNr+FaN4
         tMS7i7VsFShd92LgkQfBEJiFJRMR3JQAeMR76ciYK/5X1rLeGUjkehRmtL5YR4emeV
         LZRgVEUZZHwcI8zB6AOaHMDJRJLaBtJNwnDJXCQ2dxxMlBeE7jD3f3k9mcVSRMKhXR
         CNy9Zf2mG22DRSMlC8MTOtjU8//iIshEn+J1JEJ2h6cIUKFOsY20Isn6P0FXEnZ/lm
         jehNb9QqWIOAPYKMJyyqUqRrxhFdEOdZAmrFPHlqq/2jBDXxsdkEMXSoEepFEE+RFx
         WVdQZcKwZX7IA==
Received: by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1l06XB-00FQtx-I5; Thu, 14 Jan 2021 18:35:45 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Alex Dewar <alex.dewar90@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Yu Chen <chenyu56@huawei.com>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/4] staging: hikey9xx: phy-hi3670-usb3.c: hi3670_is_abbclk_seleted() returns bool
Date:   Thu, 14 Jan 2021 18:35:43 +0100
Message-Id: <d1e0d94381e214157545d6808835fdfe99448f76.1610645385.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1610645385.git.mchehab+huawei@kernel.org>
References: <cover.1610645385.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of using 1/0 for true/false, change the type to boolean
and change the returned value.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/staging/hikey9xx/phy-hi3670-usb3.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/hikey9xx/phy-hi3670-usb3.c b/drivers/staging/hikey9xx/phy-hi3670-usb3.c
index cffe6c58dfd7..b5fed306fcbf 100644
--- a/drivers/staging/hikey9xx/phy-hi3670-usb3.c
+++ b/drivers/staging/hikey9xx/phy-hi3670-usb3.c
@@ -326,24 +326,24 @@ static int hi3670_phy_set_params(struct hi3670_priv *priv)
 	return ret;
 }
 
-static int hi3670_is_abbclk_seleted(struct hi3670_priv *priv)
+static bool hi3670_is_abbclk_seleted(struct hi3670_priv *priv)
 {
 	u32 reg;
 
 	if (!priv->sctrl) {
 		dev_err(priv->dev, "priv->sctrl is null!\n");
-		return 1;
+		return true;
 	}
 
 	if (regmap_read(priv->sctrl, SCTRL_SCDEEPSLEEPED, &reg)) {
 		dev_err(priv->dev, "SCTRL_SCDEEPSLEEPED read failed!\n");
-		return 1;
+		return true;
 	}
 
 	if ((reg & USB_CLK_SELECTED) == 0)
-		return 1;
+		return true;
 
-	return 0;
+	return false;
 }
 
 static int hi3670_config_phy_clock(struct hi3670_priv *priv)
-- 
2.29.2

