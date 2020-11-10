Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A48C72ACFC1
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 07:32:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731551AbgKJGch (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 01:32:37 -0500
Received: from smtp2207-205.mail.aliyun.com ([121.197.207.205]:33371 "EHLO
        smtp2207-205.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726462AbgKJGcg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 01:32:36 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.4007003|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0424186-0.00157801-0.956003;FP=10697710607874107063|1|1|17|0|-1|-1|-1;HT=ay29a033018047204;MF=frank@allwinnertech.com;NM=1;PH=DS;RN=10;RT=10;SR=0;TI=SMTPD_---.Iuod9cs_1604989949;
Received: from allwinnertech.com(mailfrom:frank@allwinnertech.com fp:SMTPD_---.Iuod9cs_1604989949)
          by smtp.aliyun-inc.com(10.147.41.187);
          Tue, 10 Nov 2020 14:32:33 +0800
From:   Frank Lee <frank@allwinnertech.com>
To:     tiny.windzz@gmail.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Yangtao Li <frank@allwinnertech.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Colin Ian King <colin.king@canonical.com>
Subject: [RESEND PATCH 08/19] phy: sun4i-usb: remove enable_pmu_unk1 from sun50i_h6_cfg
Date:   Tue, 10 Nov 2020 14:32:21 +0800
Message-Id: <dc8cbb7b3cd59902a6719f207d18a232903fac8a.1604988979.git.frank@allwinnertech.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1604988979.git.frank@allwinnertech.com>
References: <cover.1604988979.git.frank@allwinnertech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yangtao Li <frank@allwinnertech.com>

For the current code, enable_pmu_unk1 only works in non-a83t and non-h6
types. So let's delete it from the sun50i_h6_cfg.

Signed-off-by: Yangtao Li <frank@allwinnertech.com>
---
 drivers/phy/allwinner/phy-sun4i-usb.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/phy/allwinner/phy-sun4i-usb.c b/drivers/phy/allwinner/phy-sun4i-usb.c
index 651d5e2a25ce..0f1888b55dbd 100644
--- a/drivers/phy/allwinner/phy-sun4i-usb.c
+++ b/drivers/phy/allwinner/phy-sun4i-usb.c
@@ -969,7 +969,6 @@ static const struct sun4i_usb_phy_cfg sun50i_h6_cfg = {
 	.disc_thresh = 3,
 	.phyctl_offset = REG_PHYCTL_A33,
 	.dedicated_clocks = true,
-	.enable_pmu_unk1 = true,
 	.phy0_dual_route = true,
 	.missing_phys = BIT(1) | BIT(2),
 };
-- 
2.28.0

