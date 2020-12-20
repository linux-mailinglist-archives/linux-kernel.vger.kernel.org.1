Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B14D12DF718
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Dec 2020 00:25:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728329AbgLTXGQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Dec 2020 18:06:16 -0500
Received: from mx.h4ck.space ([159.69.146.50]:59752 "EHLO mx.h4ck.space"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726507AbgLTXGL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Dec 2020 18:06:11 -0500
X-Greylist: delayed 512 seconds by postgrey-1.27 at vger.kernel.org; Sun, 20 Dec 2020 18:06:10 EST
From:   Andreas Rammhold <andreas@rammhold.de>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Andreas Rammhold <andreas@rammhold.de>,
        microcai <microcaicai@gmail.com>,
        Daniel Golle <daniel@makrotopia.org>
Subject: [PATCH] spi-nor: Add support for xt25f128b
Date:   Sun, 20 Dec 2020 23:43:15 +0100
Message-Id: <20201220224314.2659-1-andreas@rammhold.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds support for the xt25f128b as found on the rockpi4b SBC.

Signed-off-by: Andreas Rammhold <andreas@rammhold.de>
---

This continues the efforts done in [1] & [2] that went stale. I've
tested this patch on my RockPi4b which only has the xt25f128b (and not
the xt25f32b as also propsed in [2]). I have tried to obtain a copy of
the datasheets but was unable to find them. Not sure whre you would get
them.

While [1] was already for the new spi-nor layout it was missing the bits
in the core.{c,h} files.


[1]: https://patchwork.ozlabs.org/project/linux-mtd/patch/CAMgqO2y9MYDj6antOaWLBRKU8vGEwqCB-Y1TkXTSWsmsed+W6A@mail.gmail.com/
[2]: https://patchwork.ozlabs.org/project/linux-mtd/patch/20200206171941.GA2398@makrotopia.org/

 drivers/mtd/spi-nor/Makefile |  1 +
 drivers/mtd/spi-nor/core.c   |  1 +
 drivers/mtd/spi-nor/core.h   |  1 +
 drivers/mtd/spi-nor/xtx.c    | 16 ++++++++++++++++
 4 files changed, 19 insertions(+)
 create mode 100644 drivers/mtd/spi-nor/xtx.c

diff --git a/drivers/mtd/spi-nor/Makefile b/drivers/mtd/spi-nor/Makefile
index 653923896205..3f7a52d7fa0b 100644
--- a/drivers/mtd/spi-nor/Makefile
+++ b/drivers/mtd/spi-nor/Makefile
@@ -17,6 +17,7 @@ spi-nor-objs			+= sst.o
 spi-nor-objs			+= winbond.o
 spi-nor-objs			+= xilinx.o
 spi-nor-objs			+= xmc.o
+spi-nor-objs			+= xtx.o
 obj-$(CONFIG_MTD_SPI_NOR)	+= spi-nor.o
 
 obj-$(CONFIG_MTD_SPI_NOR)	+= controllers/
diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index f0ae7a01703a..ca1988554945 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -2024,6 +2024,7 @@ static const struct spi_nor_manufacturer *manufacturers[] = {
 	&spi_nor_winbond,
 	&spi_nor_xilinx,
 	&spi_nor_xmc,
+	&spi_nor_xtx,
 };
 
 static const struct flash_info *
diff --git a/drivers/mtd/spi-nor/core.h b/drivers/mtd/spi-nor/core.h
index 6f2f6b27173f..cea8c0c25c9f 100644
--- a/drivers/mtd/spi-nor/core.h
+++ b/drivers/mtd/spi-nor/core.h
@@ -398,6 +398,7 @@ extern const struct spi_nor_manufacturer spi_nor_sst;
 extern const struct spi_nor_manufacturer spi_nor_winbond;
 extern const struct spi_nor_manufacturer spi_nor_xilinx;
 extern const struct spi_nor_manufacturer spi_nor_xmc;
+extern const struct spi_nor_manufacturer spi_nor_xtx;
 
 int spi_nor_write_enable(struct spi_nor *nor);
 int spi_nor_write_disable(struct spi_nor *nor);
diff --git a/drivers/mtd/spi-nor/xtx.c b/drivers/mtd/spi-nor/xtx.c
new file mode 100644
index 000000000000..a10102d8b3e2
--- /dev/null
+++ b/drivers/mtd/spi-nor/xtx.c
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/mtd/spi-nor.h>
+
+#include "core.h"
+
+static const struct flash_info xtx_parts[] = {
+ /* XTX (Shenzhen Xin Tian Xia Tech) */
+ { "xt25f128b", INFO(0x0b4018, 0, 64 * 1024, 256, SECT_4K) },
+};
+
+const struct spi_nor_manufacturer spi_nor_xtx = {
+ .name = "xtx",
+ .parts = xtx_parts,
+ .nparts = ARRAY_SIZE(xtx_parts),
+};
-- 
2.29.2

