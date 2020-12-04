Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42DE72CEF1C
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 15:00:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729223AbgLDN5g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 08:57:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:40780 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727855AbgLDN5f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 08:57:35 -0500
From:   Arnd Bergmann <arnd@kernel.org>
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        CK Hu <ck.hu@mediatek.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Colin Ian King <colin.king@canonical.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] [v2] phy: mediatek: allow compile-testing the hdmi phy
Date:   Fri,  4 Dec 2020 14:56:43 +0100
Message-Id: <20201204135650.2744481-1-arnd@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

Compile-testing the DRM_MEDIATEK_HDMI driver shows two missing
dependencies, one results in a link failure:

arm-linux-gnueabi-ld: drivers/phy/mediatek/phy-mtk-hdmi.o: in function `mtk_hdmi_phy_probe':
phy-mtk-hdmi.c:(.text+0xd8): undefined reference to `__clk_get_name'
arm-linux-gnueabi-ld: phy-mtk-hdmi.c:(.text+0x12c): undefined reference to `devm_clk_register'
arm-linux-gnueabi-ld: phy-mtk-hdmi.c:(.text+0x250): undefined reference to `of_clk_add_provider'
arm-linux-gnueabi-ld: phy-mtk-hdmi.c:(.text+0x298): undefined reference to `of_clk_src_simple_get'

The other one is a harmless warning:

WARNING: unmet direct dependencies detected for PHY_MTK_HDMI
  Depends on [n]: ARCH_MEDIATEK [=n] && OF [=y]
  Selected by [y]:
  - DRM_MEDIATEK_HDMI [=y] && HAS_IOMEM [=y] && DRM_MEDIATEK [=y]

Fix these by adding dependencies on CONFIG_OF and CONFIG_COMMON_CLK.
With that done, there is also no reason against adding
CONFIG_COMPILE_TEST.

Fixes: b28be59a2e26 ("phy: mediatek: Move mtk_hdmi_phy driver into drivers/phy/mediatek folder")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
v2: reword changelog text
---
 drivers/phy/mediatek/Kconfig | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/phy/mediatek/Kconfig b/drivers/phy/mediatek/Kconfig
index 65ed26e40c9f..29a85b2738f8 100644
--- a/drivers/phy/mediatek/Kconfig
+++ b/drivers/phy/mediatek/Kconfig
@@ -40,7 +40,9 @@ config PHY_MTK_XSPHY
 
 config PHY_MTK_HDMI
 	tristate "MediaTek HDMI-PHY Driver"
-	depends on ARCH_MEDIATEK && OF
+	depends on ARCH_MEDIATEK || COMPILE_TEST
+	depends on COMMON_CLK
+	depends on OF
 	select GENERIC_PHY
 	help
 	  Support HDMI PHY for Mediatek SoCs.
-- 
2.27.0

