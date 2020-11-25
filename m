Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CACA42C3A39
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 08:39:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728120AbgKYHiC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 02:38:02 -0500
Received: from mail.loongson.cn ([114.242.206.163]:57744 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725308AbgKYHiC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 02:38:02 -0500
Received: from linux.localdomain (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9AxytHJCb5fJnAWAA--.50625S2;
        Wed, 25 Nov 2020 15:37:46 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Heiko Stuebner <heiko@sntech.de>,
        Randy Dunlap <rdunlap@infradead.org>,
        Xuefeng Li <lixuefeng@loongson.cn>
Subject: [PATCH v2] phy: mediatek: Make PHY_MTK_{XSPHY,TPHY} depend on HAS_IOMEM and OF_ADDRESS to fix build errors
Date:   Wed, 25 Nov 2020 15:37:45 +0800
Message-Id: <1606289865-692-1-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
X-CM-TRANSID: AQAAf9AxytHJCb5fJnAWAA--.50625S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ArWfXryfGF1DJrWrAr1xAFb_yoW8ZF48p3
        93Ka10kry8XFyDCw4xXFy7GFs8CFZrZ3y5GrsxWw13Xa15A3y7AwsYy34agFWUArWv93y7
        t34rWayUGaykJFUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkm14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
        6r4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc2xSY4AK67AK6r4x
        MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr
        0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0E
        wIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJV
        W8JwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI
        42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUYgAwDUUUU
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

devm_ioremap_resource() will be not built in lib/devres.c if
CONFIG_HAS_IOMEM is not set, of_address_to_resource() will be
not built in drivers/of/address.c if CONFIG_OF_ADDRESS is not
set, and then there exists two build errors about undefined
reference to "devm_ioremap_resource" and "of_address_to_resource"
in phy-mtk-xsphy.c under COMPILE_TEST and CONFIG_PHY_MTK_XSPHY,
make PHY_MTK_XSPHY depend on HAS_IOMEM and OF_ADDRESS to fix it.

The above issue is reported by kernel test robot <lkp@intel.com>,
through the discussion in the v1 patch, as Chunfeng said we need
also do this for config PHY_MTK_TPHY:

drivers/phy/mediatek/phy-mtk-tphy.c:1157:		retval = of_address_to_resource(child_np, 0, &res);
drivers/phy/mediatek/phy-mtk-tphy.c:1123:		tphy->sif_base = devm_ioremap_resource(dev, sif_res);
drivers/phy/mediatek/phy-mtk-tphy.c:1164:		instance->port_base = devm_ioremap_resource(&phy->dev, &res);

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
Acked-by: Randy Dunlap <rdunlap@infradead.org>
---
 drivers/phy/mediatek/Kconfig | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/phy/mediatek/Kconfig b/drivers/phy/mediatek/Kconfig
index 50c5e93..f44800b 100644
--- a/drivers/phy/mediatek/Kconfig
+++ b/drivers/phy/mediatek/Kconfig
@@ -5,7 +5,8 @@
 config PHY_MTK_TPHY
 	tristate "MediaTek T-PHY Driver"
 	depends on ARCH_MEDIATEK || COMPILE_TEST
-	depends on OF
+	depends on OF && OF_ADDRESS
+	depends on HAS_IOMEM
 	select GENERIC_PHY
 	help
 	  Say 'Y' here to add support for MediaTek T-PHY driver,
@@ -29,7 +30,8 @@ config PHY_MTK_UFS
 config PHY_MTK_XSPHY
 	tristate "MediaTek XS-PHY Driver"
 	depends on ARCH_MEDIATEK || COMPILE_TEST
-	depends on OF
+	depends on OF && OF_ADDRESS
+	depends on HAS_IOMEM
 	select GENERIC_PHY
 	help
 	  Enable this to support the SuperSpeedPlus XS-PHY transceiver for
-- 
2.1.0

