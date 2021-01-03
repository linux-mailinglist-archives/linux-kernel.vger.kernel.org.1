Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C25492E8C65
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jan 2021 14:58:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbhACN4K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jan 2021 08:56:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:34900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726983AbhACN4K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jan 2021 08:56:10 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0F28B20DD4;
        Sun,  3 Jan 2021 13:55:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609682129;
        bh=I8/8m7XCo+o6DMFOKhb0sO1ao1C/CETgg0rwagCHQ9I=;
        h=From:To:Cc:Subject:Date:From;
        b=CvjWPqsDDh4uOEMJz6NAAWmjjOgY83/ejjwLjzMLyMFXYNejmeMG2oeGHwZOTAStW
         /si/MEn1LNJ7SnN63AmLQPJ5xWf3L+16RGB4qo54nJiX0b+pa8EQsTbGlGz4k+OCfz
         R/mLmhpxEXT5MKmD6JRSLcQWHApy4ZUpTD7+RPfvlxY+MQlXelQOAfhjHZbZSgV1CH
         FG6Cc+LA7IFYQFBuPDH+RtDlmPlcE9IY5EI1VTVYe+I0NRaxwFot5khnMTePXP/2i3
         9j1+QyR2SJQSZeL9CRDchDQT4ys7QhbqEc7dqAJUyMWRkebyVFZQmZ9hwjRGYyuwAo
         HDvJmwEYboxpQ==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Colin Ian King <colin.king@canonical.com>,
        CK Hu <ck.hu@mediatek.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] phy: mediatek: allow compile-testing the dsi phy
Date:   Sun,  3 Jan 2021 14:55:17 +0100
Message-Id: <20210103135524.3678664-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

Randconfig builds show another broken dependency:

WARNING: unmet direct dependencies detected for PHY_MTK_MIPI_DSI
  Depends on [n]: ARCH_MEDIATEK [=n] && OF [=y]
  Selected by [m]:
  - DRM_MEDIATEK [=m] && HAS_IOMEM [=y] && DRM [=m] && (ARCH_MEDIATEK [=n] || ARM [=y] && COMPILE_TEST [=y]) && COMMON_CLK [=y] &&
HAVE_ARM_SMCCC [=y] && OF [=y] && MTK_MMSYS [=y]

This is similar to the hdmi driver I fixed earlier, and I guess the
common-clk bug would sooner or later also manifest here, so just use
the exact same solution I chose for the other driver, and hope that
any future drivers just copy it from here.

Fixes: 90f80d95992f ("phy: mediatek: Move mtk_mipi_dsi_phy driver into drivers/phy/mediatek folder")
Fixes: f5f6e01f9164 ("phy: mediatek: allow compile-testing the hdmi phy")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/phy/mediatek/Kconfig | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/phy/mediatek/Kconfig b/drivers/phy/mediatek/Kconfig
index d38def43b1bf..55f8e6c048ab 100644
--- a/drivers/phy/mediatek/Kconfig
+++ b/drivers/phy/mediatek/Kconfig
@@ -49,7 +49,9 @@ config PHY_MTK_HDMI
 
 config PHY_MTK_MIPI_DSI
 	tristate "MediaTek MIPI-DSI Driver"
-	depends on ARCH_MEDIATEK && OF
+	depends on ARCH_MEDIATEK || COMPILE_TEST
+	depends on COMMON_CLK
+	depends on OF
 	select GENERIC_PHY
 	help
 	  Support MIPI DSI for Mediatek SoCs.
-- 
2.29.2

