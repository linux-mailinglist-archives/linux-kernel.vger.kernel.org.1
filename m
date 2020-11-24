Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C4292C2205
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 10:48:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731192AbgKXJrZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 04:47:25 -0500
Received: from mail.loongson.cn ([114.242.206.163]:60602 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729704AbgKXJrY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 04:47:24 -0500
Received: from linux.localdomain (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dx33+i1rxf0+gVAA--.35867S2;
        Tue, 24 Nov 2020 17:47:14 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Heiko Stuebner <heiko@sntech.de>,
        Xuefeng Li <lixuefeng@loongson.cn>
Subject: [PATCH] phy/mediatek: Make PHY_MTK_XSPHY depend on HAS_IOMEM and OF_ADDRESS to fix build errors
Date:   Tue, 24 Nov 2020 17:47:13 +0800
Message-Id: <1606211233-7425-1-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
X-CM-TRANSID: AQAAf9Dx33+i1rxf0+gVAA--.35867S2
X-Coremail-Antispam: 1UD129KBjvdXoWrtw47Xw13uryDur48AFy5Arb_yoWkWrXEg3
        ZI9rn7Xr1UZr1SkrW5Zr1ru34I93W7WryrGa4YqFy5ury2gF17K3sFqF1kur17GwsYgF4D
        XrWfZr10vr1jyjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbckFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
        Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
        0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
        jxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr
        1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkIecxEwVAFwVW8uwCF
        04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r
        18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vI
        r41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr
        1lIxAIcVCF04k26cxKx2IYs7xG6rWUJVWrZr1UMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF
        0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUsTmhUUUUU=
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

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 drivers/phy/mediatek/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/phy/mediatek/Kconfig b/drivers/phy/mediatek/Kconfig
index 50c5e93..66df045 100644
--- a/drivers/phy/mediatek/Kconfig
+++ b/drivers/phy/mediatek/Kconfig
@@ -30,6 +30,8 @@ config PHY_MTK_XSPHY
 	tristate "MediaTek XS-PHY Driver"
 	depends on ARCH_MEDIATEK || COMPILE_TEST
 	depends on OF
+	depends on HAS_IOMEM
+	depends on OF_ADDRESS
 	select GENERIC_PHY
 	help
 	  Enable this to support the SuperSpeedPlus XS-PHY transceiver for
-- 
2.1.0

