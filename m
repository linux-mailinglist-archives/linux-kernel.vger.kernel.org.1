Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EB411E54B3
	for <lists+linux-kernel@lfdr.de>; Thu, 28 May 2020 05:36:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727069AbgE1Dgg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 May 2020 23:36:36 -0400
Received: from smtpbg704.qq.com ([203.205.195.105]:35699 "EHLO
        smtpproxy21.qq.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726563AbgE1Dgg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 23:36:36 -0400
X-Greylist: delayed 1213 seconds by postgrey-1.27 at vger.kernel.org; Wed, 27 May 2020 23:36:35 EDT
X-QQ-mid: bizesmtp18t1590636991tn6x3lor
Received: from localhost.localdomain (unknown [119.145.4.99])
        by esmtp6.qq.com (ESMTP) with 
        id ; Thu, 28 May 2020 11:36:01 +0800 (CST)
X-QQ-SSF: 01400000008000Z0ZM30B00A0000000
X-QQ-FEAT: 3fDsO+rzVm6vxUQZLxLhjvVN3N9mnI50eByOaPlvNNW98meQoerJ388iDn2Sz
        xqi9KpNqgdcUPOaiG4HtFazoNKR8I6AuRTnrXAlxSKp3GNFWwp/MRRlvO4rRVamgnLrmzjI
        O79MybbaR2J/XTjlKsN/8J9A5Gy3iQ+a6OBBvs6ckwTevUWjNTimwSWrbc+YHDrz9l8enbx
        wil8DbkYIzGQn5ESAZdQtKFLzwyBdthmHOs8/W72BoDWfvdxxMgbhU2uh1CTC2NjUP+tJt9
        MCo2wu/FvFNuZT0hmU/sHlI/BGK9kuMGcQx/+POu5Uv3yW9bFvbGr2yd6S+0XmiqONLFIxj
        5h7n1R7UuLWG4Q+ZKg=
X-QQ-GoodBg: 2
From:   wuxy@bitland.com.cn
To:     tudor.ambarus@microchip.com, miquel.raynal@bootlin.com,
        linux-kernel@vger.kernel.org, drinkcat@chromium.org,
        linux-mtd@lists.infradead.org, stlin2@winbond.com, vigneshr@ti.com
Cc:     wuxy <wuxy@bitland.corp-partner.google.com>
Subject: [PATCH] [v3]mtd: spi-nor: winbond: add 1.8v SPI NOR Flash IDs
Date:   Thu, 28 May 2020 11:36:00 +0800
Message-Id: <20200528033600.26105-1-wuxy@bitland.com.cn>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:bitland.com.cn:qybgforeign:qybgforeign5
X-QQ-Bgrelay: 1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: wuxy <wuxy@bitland.corp-partner.google.com>

Winbond has new 1.8V SPI NOR Flash IDs,we need to use the SPI
flash IDs in kukui series,this patch can support the new flash IDs.

Signed-off-by: Xingyu Wu <wuxy@bitland.corp-partner.google.com>
Signed-off-by: ST Lin <stlin2@winbond.com>
Test-by: Nicolas Boichat <drinkcat@chromium.org>

---
This patch copied from:https://patchwork.ozlabs.org/patch/1150756/,
The original patch is invalid,so re-submit a new patch for this.
 drivers/mtd/spi-nor/winbond.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/mtd/spi-nor/winbond.c b/drivers/mtd/spi-nor/winbond.c
index 17deabad57e1..cda4f8847bd6 100644
--- a/drivers/mtd/spi-nor/winbond.c
+++ b/drivers/mtd/spi-nor/winbond.c
@@ -61,6 +61,15 @@ static const struct flash_info winbond_parts[] = {
 			     SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
 	{ "w25m512jv", INFO(0xef7119, 0, 64 * 1024, 1024,
 			    SECT_4K | SPI_NOR_QUAD_READ | SPI_NOR_DUAL_READ) },
+	{ "w25q64jwxxIM", INFO(0xef8017, 0, 64 * 1024, 128,
+			    SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
+			    SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB) },
+	{ "w25q128jwxxIM", INFO(0xef8018, 0, 64 * 1024, 256,
+			    SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
+			    SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB) },
+	{ "w25q256jwxxIM", INFO(0xef8019, 0, 64 * 1024, 512,
+			    SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
+			    SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB) },
 };
 
 /**
-- 
2.20.1



