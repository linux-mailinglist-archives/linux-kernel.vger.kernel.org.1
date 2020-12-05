Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B76C2CFADD
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Dec 2020 10:40:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726000AbgLEJhi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Dec 2020 04:37:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:35900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728666AbgLEJeZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Dec 2020 04:34:25 -0500
From:   Vinod Koul <vkoul@kernel.org>
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] phy: mediatek: statify mtk_hdmi_phy_driver
Date:   Sat,  5 Dec 2020 14:41:46 +0530
Message-Id: <20201205091146.3184305-1-vkoul@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mtk_hdmi_phy_driver is not declared as static, so statify it.

drivers/phy/mediatek/phy-mtk-hdmi.c:204:24: warning: symbol 'mtk_hdmi_phy_driver' was not declared. Should it be static?

Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 drivers/phy/mediatek/phy-mtk-hdmi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/mediatek/phy-mtk-hdmi.c b/drivers/phy/mediatek/phy-mtk-hdmi.c
index 47c029d4b270..c5c61f5a9ea0 100644
--- a/drivers/phy/mediatek/phy-mtk-hdmi.c
+++ b/drivers/phy/mediatek/phy-mtk-hdmi.c
@@ -201,7 +201,7 @@ static const struct of_device_id mtk_hdmi_phy_match[] = {
 	{},
 };
 
-struct platform_driver mtk_hdmi_phy_driver = {
+static struct platform_driver mtk_hdmi_phy_driver = {
 	.probe = mtk_hdmi_phy_probe,
 	.driver = {
 		.name = "mediatek-hdmi-phy",
-- 
2.26.2

