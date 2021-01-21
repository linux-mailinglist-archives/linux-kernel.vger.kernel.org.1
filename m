Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B60B52FE2D8
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 07:29:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727129AbhAUG2t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 01:28:49 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:42586 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725764AbhAUG0q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 01:26:46 -0500
X-UUID: a347601d477e49238e2e91dcebbe502d-20210121
X-UUID: a347601d477e49238e2e91dcebbe502d-20210121
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 279293618; Thu, 21 Jan 2021 14:25:34 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 21 Jan 2021 14:25:30 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 21 Jan 2021 14:25:29 +0800
From:   Yong Wu <yong.wu@mediatek.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>, Tomasz Figa <tfiga@google.com>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>, <yong.wu@mediatek.com>,
        <youlin.pei@mediatek.com>, Nicolas Boichat <drinkcat@chromium.org>,
        <anan.sun@mediatek.com>, <yi.kuo@mediatek.com>
Subject: [PATCH 3/3] memory: mtk-smi: Switch MTK_SMI to tristate
Date:   Thu, 21 Jan 2021 14:24:29 +0800
Message-ID: <20210121062429.26504-4-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210121062429.26504-1-yong.wu@mediatek.com>
References: <20210121062429.26504-1-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch switches MTK_SMI to tristate. Support it could be 'm'.

Meanwhile, Fix a build issue while MTK_SMI is built as module.

Signed-off-by: Yong Wu <yong.wu@mediatek.com>
---
This patch has a little conflict with the mt8192 iommu patch which
delete the MTK_LARB_NR_MAX in smi.h(It's still reviewing).
This patch rebase on the clean v5.11-rc1.
---
 drivers/memory/Kconfig     | 2 +-
 include/soc/mediatek/smi.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/memory/Kconfig b/drivers/memory/Kconfig
index 3ea6913df176..d5f0f4680880 100644
--- a/drivers/memory/Kconfig
+++ b/drivers/memory/Kconfig
@@ -173,7 +173,7 @@ config JZ4780_NEMC
 	  memory devices such as NAND and SRAM.
 
 config MTK_SMI
-	bool "Mediatek SoC Memory Controller driver" if COMPILE_TEST
+	tristate "Mediatek SoC Memory Controller driver" if COMPILE_TEST
 	depends on ARCH_MEDIATEK || COMPILE_TEST
 	help
 	  This driver is for the Memory Controller module in MediaTek SoCs,
diff --git a/include/soc/mediatek/smi.h b/include/soc/mediatek/smi.h
index 5a34b87d89e3..29e2fb8f33d6 100644
--- a/include/soc/mediatek/smi.h
+++ b/include/soc/mediatek/smi.h
@@ -9,7 +9,7 @@
 #include <linux/bitops.h>
 #include <linux/device.h>
 
-#ifdef CONFIG_MTK_SMI
+#if IS_ENABLED(CONFIG_MTK_SMI)
 
 #define MTK_LARB_NR_MAX		16
 
-- 
2.18.0

