Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A0E52CD544
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 13:16:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728969AbgLCMPj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 07:15:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726148AbgLCMPj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 07:15:39 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23ED3C061A4E
        for <linux-kernel@vger.kernel.org>; Thu,  3 Dec 2020 04:14:59 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id B9CD51F45A6A
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     Collabora Kernel ML <kernel@collabora.com>, matthias.bgg@gmail.com,
        drinkcat@chromium.org, hsinyi@chromium.org,
        kernel test robot <lkp@intel.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH] soc: mediatek: mmsys: Specify HAS_IOMEM dependency for MTK_MMSYS
Date:   Thu,  3 Dec 2020 13:14:47 +0100
Message-Id: <20201203121447.3366406-1-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Because mtk-mmsys uses the 'devm_platform_ioremap_resource' function, it
should depend on HAS_IOMEM.

Fixes: cc6576029aed ("soc: mediatek: mmsys: Use devm_platform_ioremap_resource()")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

 drivers/soc/mediatek/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/mediatek/Kconfig b/drivers/soc/mediatek/Kconfig
index 67cef12dc585..90ba6134e861 100644
--- a/drivers/soc/mediatek/Kconfig
+++ b/drivers/soc/mediatek/Kconfig
@@ -59,6 +59,7 @@ config MTK_SCPSYS_PM_DOMAINS
 config MTK_MMSYS
 	bool "MediaTek MMSYS Support"
 	default ARCH_MEDIATEK
+	depends on HAS_IOMEM
 	help
 	  Say yes here to add support for the MediaTek Multimedia
 	  Subsystem (MMSYS).
-- 
2.29.2

