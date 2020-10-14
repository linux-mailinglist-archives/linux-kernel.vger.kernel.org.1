Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC29E28E7E2
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 22:29:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387591AbgJNU32 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 16:29:28 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:51984 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729022AbgJNU32 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 16:29:28 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: aratiu)
        with ESMTPSA id C020B1F4582E
From:   Adrian Ratiu <adrian.ratiu@collabora.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, kernel@collabora.com
Subject: [PATCH v2] regmap: mmio: add config option to allow relaxed MMIO accesses
Date:   Wed, 14 Oct 2020 23:30:24 +0300
Message-Id: <20201014203024.954369-1-adrian.ratiu@collabora.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On some platforms (eg armv7 due to the CONFIG_ARM_DMA_MEM_BUFFERABLE)
MMIO R/W operations always add memory barriers which can increase load,
decrease battery life or in general reduce performance unnecessarily
on devices which access a lot of configuration registers and where
ordering does not matter (eg. media accelerators like the Verisilicon /
Hantro video decoders).

Drivers used to call the relaxed MMIO variants directly but since they
are now accessing the MMIO registers via regmaps (to compensate for
different VPU HW reg layouts via regmap fields), there is a need for a
relaxed API / config to preserve existing behaviour.

Cc: Mark Brown <broonie@kernel.org>
Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
---
Changes in v2:
  - Moved conditional outside of I/O call path, to be done just
  once during context initialization (Mark)
---
 drivers/base/regmap/regmap-mmio.c | 90 ++++++++++++++++++++++++++++---
 include/linux/regmap.h            |  5 ++
 2 files changed, 87 insertions(+), 8 deletions(-)

diff --git a/drivers/base/regmap/regmap-mmio.c b/drivers/base/regmap/regmap-mmio.c
index af967d8f975e..f9cd51afb9d2 100644
--- a/drivers/base/regmap/regmap-mmio.c
+++ b/drivers/base/regmap/regmap-mmio.c
@@ -16,6 +16,7 @@
 struct regmap_mmio_context {
 	void __iomem *regs;
 	unsigned val_bytes;
+	bool relaxed_mmio;
 
 	bool attached_clk;
 	struct clk *clk;
@@ -75,6 +76,13 @@ static void regmap_mmio_write8(struct regmap_mmio_context *ctx,
 	writeb(val, ctx->regs + reg);
 }
 
+static void regmap_mmio_write8_relaxed(struct regmap_mmio_context *ctx,
+				unsigned int reg,
+				unsigned int val)
+{
+	writeb_relaxed(val, ctx->regs + reg);
+}
+
 static void regmap_mmio_write16le(struct regmap_mmio_context *ctx,
 				  unsigned int reg,
 				  unsigned int val)
@@ -82,6 +90,13 @@ static void regmap_mmio_write16le(struct regmap_mmio_context *ctx,
 	writew(val, ctx->regs + reg);
 }
 
+static void regmap_mmio_write16le_relaxed(struct regmap_mmio_context *ctx,
+				  unsigned int reg,
+				  unsigned int val)
+{
+	writew_relaxed(val, ctx->regs + reg);
+}
+
 static void regmap_mmio_write16be(struct regmap_mmio_context *ctx,
 				  unsigned int reg,
 				  unsigned int val)
@@ -96,6 +111,13 @@ static void regmap_mmio_write32le(struct regmap_mmio_context *ctx,
 	writel(val, ctx->regs + reg);
 }
 
+static void regmap_mmio_write32le_relaxed(struct regmap_mmio_context *ctx,
+				  unsigned int reg,
+				  unsigned int val)
+{
+	writel_relaxed(val, ctx->regs + reg);
+}
+
 static void regmap_mmio_write32be(struct regmap_mmio_context *ctx,
 				  unsigned int reg,
 				  unsigned int val)
@@ -110,6 +132,13 @@ static void regmap_mmio_write64le(struct regmap_mmio_context *ctx,
 {
 	writeq(val, ctx->regs + reg);
 }
+
+static void regmap_mmio_write64le_relaxed(struct regmap_mmio_context *ctx,
+				  unsigned int reg,
+				  unsigned int val)
+{
+	writeq_relaxed(val, ctx->regs + reg);
+}
 #endif
 
 static int regmap_mmio_write(void *context, unsigned int reg, unsigned int val)
@@ -137,12 +166,24 @@ static unsigned int regmap_mmio_read8(struct regmap_mmio_context *ctx,
 	return readb(ctx->regs + reg);
 }
 
+static unsigned int regmap_mmio_read8_relaxed(struct regmap_mmio_context *ctx,
+				      unsigned int reg)
+{
+	return readb_relaxed(ctx->regs + reg);
+}
+
 static unsigned int regmap_mmio_read16le(struct regmap_mmio_context *ctx,
 				         unsigned int reg)
 {
 	return readw(ctx->regs + reg);
 }
 
+static unsigned int regmap_mmio_read16le_relaxed(struct regmap_mmio_context *ctx,
+						 unsigned int reg)
+{
+	return readw_relaxed(ctx->regs + reg);
+}
+
 static unsigned int regmap_mmio_read16be(struct regmap_mmio_context *ctx,
 				         unsigned int reg)
 {
@@ -155,6 +196,12 @@ static unsigned int regmap_mmio_read32le(struct regmap_mmio_context *ctx,
 	return readl(ctx->regs + reg);
 }
 
+static unsigned int regmap_mmio_read32le_relaxed(struct regmap_mmio_context *ctx,
+						 unsigned int reg)
+{
+	return readl_relaxed(ctx->regs + reg);
+}
+
 static unsigned int regmap_mmio_read32be(struct regmap_mmio_context *ctx,
 				         unsigned int reg)
 {
@@ -167,6 +214,12 @@ static unsigned int regmap_mmio_read64le(struct regmap_mmio_context *ctx,
 {
 	return readq(ctx->regs + reg);
 }
+
+static unsigned int regmap_mmio_read64le_relaxed(struct regmap_mmio_context *ctx,
+						 unsigned int reg)
+{
+	return readq_relaxed(ctx->regs + reg);
+}
 #endif
 
 static int regmap_mmio_read(void *context, unsigned int reg, unsigned int *val)
@@ -237,6 +290,7 @@ static struct regmap_mmio_context *regmap_mmio_gen_context(struct device *dev,
 
 	ctx->regs = regs;
 	ctx->val_bytes = config->val_bits / 8;
+	ctx->relaxed_mmio = config->use_relaxed_mmio;
 	ctx->clk = ERR_PTR(-ENODEV);
 
 	switch (regmap_get_val_endian(dev, &regmap_mmio, config)) {
@@ -247,21 +301,41 @@ static struct regmap_mmio_context *regmap_mmio_gen_context(struct device *dev,
 #endif
 		switch (config->val_bits) {
 		case 8:
-			ctx->reg_read = regmap_mmio_read8;
-			ctx->reg_write = regmap_mmio_write8;
+			if (ctx->relaxed_mmio) {
+				ctx->reg_read = regmap_mmio_read8_relaxed;
+				ctx->reg_write = regmap_mmio_write8_relaxed;
+			} else {
+				ctx->reg_read = regmap_mmio_read8;
+				ctx->reg_write = regmap_mmio_write8;
+			}
 			break;
 		case 16:
-			ctx->reg_read = regmap_mmio_read16le;
-			ctx->reg_write = regmap_mmio_write16le;
+			if (ctx->relaxed_mmio) {
+				ctx->reg_read = regmap_mmio_read16le_relaxed;
+				ctx->reg_write = regmap_mmio_write16le_relaxed;
+			} else {
+				ctx->reg_read = regmap_mmio_read16le;
+				ctx->reg_write = regmap_mmio_write16le;
+			}
 			break;
 		case 32:
-			ctx->reg_read = regmap_mmio_read32le;
-			ctx->reg_write = regmap_mmio_write32le;
+			if (ctx->relaxed_mmio) {
+				ctx->reg_read = regmap_mmio_read32le_relaxed;
+				ctx->reg_write = regmap_mmio_write32le_relaxed;
+			} else {
+				ctx->reg_read = regmap_mmio_read32le;
+				ctx->reg_write = regmap_mmio_write32le;
+			}
 			break;
 #ifdef CONFIG_64BIT
 		case 64:
-			ctx->reg_read = regmap_mmio_read64le;
-			ctx->reg_write = regmap_mmio_write64le;
+			if (ctx->relaxed_mmio) {
+				ctx->reg_read = regmap_mmio_read64le_relaxed;
+				ctx->reg_write = regmap_mmio_write64le_relaxed;
+			} else {
+				ctx->reg_read = regmap_mmio_read64le;
+				ctx->reg_write = regmap_mmio_write64le;
+			}
 			break;
 #endif
 		default:
diff --git a/include/linux/regmap.h b/include/linux/regmap.h
index e7834d98207f..126fe700d1d8 100644
--- a/include/linux/regmap.h
+++ b/include/linux/regmap.h
@@ -315,6 +315,10 @@ typedef void (*regmap_unlock)(void *);
  *                   masks are used.
  * @zero_flag_mask: If set, read_flag_mask and write_flag_mask are used even
  *                   if they are both empty.
+ * @use_relaxed_mmio: If set, MMIO R/W operations will not use memory barriers.
+ *                    This can avoid load on devices which don't require strict
+ *                    orderings, but drivers should carefully add any explicit
+ *                    memory barriers when they may require them.
  * @use_single_read: If set, converts the bulk read operation into a series of
  *                   single read operations. This is useful for a device that
  *                   does not support  bulk read.
@@ -388,6 +392,7 @@ struct regmap_config {
 
 	bool use_single_read;
 	bool use_single_write;
+	bool use_relaxed_mmio;
 	bool can_multi_write;
 
 	enum regmap_endian reg_format_endian;
-- 
2.28.0

