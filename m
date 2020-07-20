Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72EF62269D3
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jul 2020 18:31:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729452AbgGTQaC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jul 2020 12:30:02 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:44762 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732020AbgGTQ35 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 12:29:57 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1jxYfp-0007ej-3W; Mon, 20 Jul 2020 16:29:53 +0000
From:   Colin King <colin.king@canonical.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Seungwon Jeon <essuuj@gmail.com>,
        Kiwoong Kim <kwmad.kim@samsung.com>,
        Alim Akhtar <alim.akhtar@samsung.com>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] phy: samsung-ufs: fix check on failed devm_clk_get call for rx1_symbol_clk
Date:   Mon, 20 Jul 2020 17:29:52 +0100
Message-Id: <20200720162952.339697-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The check to see if the call to devm_clk_get on rx1_symbol_clk is checking
the wrong variable, this looks like a copy-paste error. Fix this to check
phy->rx1_symbol instead of phy->rx0_symbol.

Addresses-Coverity: ("Copy-paste error")
Fixes: bca21e930451 ("phy: samsung-ufs: add UFS PHY driver for samsung SoC")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/phy/samsung/phy-samsung-ufs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/samsung/phy-samsung-ufs.c b/drivers/phy/samsung/phy-samsung-ufs.c
index 43ef77d1d96c..9832599a0283 100644
--- a/drivers/phy/samsung/phy-samsung-ufs.c
+++ b/drivers/phy/samsung/phy-samsung-ufs.c
@@ -147,7 +147,7 @@ static int samsung_ufs_phy_symbol_clk_init(struct samsung_ufs_phy *phy)
 	}
 
 	phy->rx1_symbol_clk = devm_clk_get(phy->dev, "rx1_symbol_clk");
-	if (IS_ERR(phy->rx0_symbol_clk)) {
+	if (IS_ERR(phy->rx1_symbol_clk)) {
 		dev_err(phy->dev, "failed to get rx1_symbol_clk clock\n");
 		return PTR_ERR(phy->rx1_symbol_clk);
 	}
-- 
2.27.0

