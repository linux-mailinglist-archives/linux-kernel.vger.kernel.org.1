Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2820F2675DE
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Sep 2020 00:27:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725931AbgIKW1o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Sep 2020 18:27:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbgIKW06 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 18:26:58 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32402C061573
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 15:26:56 -0700 (PDT)
Received: from apollo.fritz.box (unknown [IPv6:2a02:810c:c200:2e91:6257:18ff:fec4:ca34])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id A3FAE22F2E;
        Sat, 12 Sep 2020 00:26:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1599863208;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=N21HfssIA+Ny2QRAHLy3LJxBjxEJaeceLfDNhRC291E=;
        b=B4rhph7lSqhJYIDYoEMBQID/HLU4YUnOUVS8Gc5/bgTm/DBO3fvapc0HDCOTy/N3kjEyXU
        HgyZo5ZpK4ZqJTpuND7XkXStItmBC1gyCEvG/++eYWQ4Feyh7K5Q5Fvd2UQQviPx6TYnmB
        Uo4nLqTXXrRbpLwkWkNyJFBuHeGnUoI=
From:   Michael Walle <michael@walle.cc>
To:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Jungseung Lee <js07.lee@samsung.com>,
        Michael Walle <michael@walle.cc>,
        Rahul Bedarkar <rahul.bedarkar@imgtec.com>
Subject: [PATCH v2 2/4] mtd: spi-nor: add OTP support
Date:   Sat, 12 Sep 2020 00:26:32 +0200
Message-Id: <20200911222634.31804-3-michael@walle.cc>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200911222634.31804-1-michael@walle.cc>
References: <20200911222634.31804-1-michael@walle.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement the MTD callbacks for the OTP methods for the SPI NOR
subsystem.

Usually, the OTP area of a SPI flash can be accessed like the normal
memory, eg by offset addressing; except that you either have to use
special read/write commands (Winbond) or you have to enter (and exit) a
specific OTP mode (Macronix, Micron). Sometimes there are individual
regions, which might have individual offsets. Therefore, it is possible
to specify the starting address of the first regions as well as the
distance between two regions (Winbond).

Additionally, the regions might be locked down. Once locked, no further
write access is possible.

Cc: Rahul Bedarkar <rahul.bedarkar@imgtec.com>
Signed-off-by: Michael Walle <michael@walle.cc>
---
 drivers/mtd/chips/Kconfig  |   2 +-
 drivers/mtd/spi-nor/core.c | 143 +++++++++++++++++++++++++++++++++++++
 drivers/mtd/spi-nor/core.h |  48 +++++++++++++
 3 files changed, 192 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/chips/Kconfig b/drivers/mtd/chips/Kconfig
index aef14990e5f7..3b7ba9448118 100644
--- a/drivers/mtd/chips/Kconfig
+++ b/drivers/mtd/chips/Kconfig
@@ -152,7 +152,7 @@ config MTD_CFI_I8
 
 config MTD_OTP
 	bool "Protection Registers aka one-time programmable (OTP) bits"
-	depends on MTD_CFI_ADV_OPTIONS
+	depends on MTD_CFI_ADV_OPTIONS || MTD_SPI_NOR
 	default n
 	help
 	  This enables support for reading, writing and locking so called
diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index b06b160a5c9c..4244f98e4948 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -2689,6 +2689,12 @@ static void spi_nor_info_init_params(struct spi_nor *nor)
 	spi_nor_set_erase_type(&map->erase_type[i], info->sector_size,
 			       SPINOR_OP_SE);
 	spi_nor_init_uniform_erase_map(map, erase_mask, params->size);
+
+	/* OTP parameters */
+	nor->params->otp_info.otp_size = info->otp_size;
+	nor->params->otp_info.n_otps = info->n_otps;
+	nor->params->otp_info.otp_start_addr = info->otp_start_addr;
+	nor->params->otp_info.otp_addr_offset = info->otp_addr_offset;
 }
 
 /**
@@ -2972,6 +2978,127 @@ static const struct flash_info *spi_nor_get_flash_info(struct spi_nor *nor,
 	return info;
 }
 
+static loff_t spi_nor_otp_region_start(struct spi_nor *nor, int region)
+{
+	struct spi_nor_otp_info *info = &nor->params->otp_info;
+
+	return info->otp_start_addr + region * info->otp_addr_offset;
+}
+
+static loff_t spi_nor_otp_region_end(struct spi_nor *nor, int region)
+{
+	struct spi_nor_otp_info *info = &nor->params->otp_info;
+
+	return spi_nor_otp_region_start(nor, region) + info->otp_size - 1;
+}
+
+static int spi_nor_mtd_otp_info(struct mtd_info *mtd, size_t len,
+				size_t *retlen, struct otp_info *buf)
+{
+	struct spi_nor *nor = mtd_to_spi_nor(mtd);
+	int locked;
+	int i;
+
+	for (i = 0; i < nor->params->otp_info.n_otps; i++) {
+		buf[i].start = spi_nor_otp_region_start(nor, i);
+		buf[i].length = nor->params->otp_info.otp_size;
+
+		locked = nor->params->otp_ops->is_locked(nor, i);
+		if (locked < 0)
+			return locked;
+
+		buf[i].locked = !!locked;
+	}
+
+	*retlen = nor->params->otp_info.n_otps * sizeof(*buf);
+
+	return 0;
+}
+
+static int spi_nor_otp_addr_to_region(struct spi_nor *nor, loff_t addr)
+{
+	int i;
+
+	for (i = 0; i < nor->params->otp_info.n_otps; i++)
+		if (addr >= spi_nor_otp_region_start(nor, i) &&
+		    addr <= spi_nor_otp_region_end(nor, i))
+			return i;
+
+	return -EINVAL;
+}
+
+static int spi_nor_mtd_otp_read_write(struct mtd_info *mtd, loff_t ofs,
+				      size_t len, size_t *retlen, u_char *buf,
+				      bool is_write)
+{
+	struct spi_nor *nor = mtd_to_spi_nor(mtd);
+	int region;
+	int ret;
+
+	*retlen = 0;
+
+	region = spi_nor_otp_addr_to_region(nor, ofs);
+	if (region < 0)
+		return 0;
+
+	if (ofs < spi_nor_otp_region_start(nor, region))
+		return 0;
+
+	if ((ofs + len - 1) > spi_nor_otp_region_end(nor, region))
+		return 0;
+
+	ret = spi_nor_lock_and_prep(nor);
+
+	if (is_write)
+		ret = nor->params->otp_ops->write(nor, ofs, len, buf);
+	else
+		ret = nor->params->otp_ops->read(nor, ofs, len, buf);
+
+	spi_nor_unlock_and_unprep(nor);
+
+	if (ret < 0)
+		return ret;
+
+	*retlen = len;
+	return 0;
+}
+
+static int spi_nor_mtd_otp_read(struct mtd_info *mtd, loff_t from, size_t len,
+				size_t *retlen, u_char *buf)
+{
+	return spi_nor_mtd_otp_read_write(mtd, from, len, retlen, buf, false);
+}
+
+static int spi_nor_mtd_otp_write(struct mtd_info *mtd, loff_t to, size_t len,
+				 size_t *retlen, u_char *buf)
+{
+	return spi_nor_mtd_otp_read_write(mtd, to, len, retlen, buf, true);
+}
+
+static int spi_nor_mtd_otp_lock(struct mtd_info *mtd, loff_t from, size_t len)
+{
+	struct spi_nor *nor = mtd_to_spi_nor(mtd);
+	int region;
+	int ret;
+
+	region = spi_nor_otp_addr_to_region(nor, from);
+	if (region < 0)
+		return -EINVAL;
+
+	if (len != nor->params->otp_info.otp_size)
+		return -EINVAL;
+
+	ret = spi_nor_lock_and_prep(nor);
+	if (ret)
+		return ret;
+
+	ret = nor->params->otp_ops->lock(nor, region);
+
+	spi_nor_unlock_and_unprep(nor);
+
+	return ret;
+}
+
 int spi_nor_scan(struct spi_nor *nor, const char *name,
 		 const struct spi_nor_hwcaps *hwcaps)
 {
@@ -3050,6 +3177,22 @@ int spi_nor_scan(struct spi_nor *nor, const char *name,
 		mtd->_is_locked = spi_nor_is_locked;
 	}
 
+	if (nor->params->otp_ops) {
+		/*
+		 * We only support user_prot callbacks (yet).
+		 *
+		 * Some SPI flashes like Macronix ones support factory locked
+		 * OTP areas, usually they are preprogrammed with an
+		 * "electrical serial number".
+		 * Most of the time the OTP area is unprogrammed and left up to
+		 * the user. This is what we support at the moment.
+		 */
+		mtd->_get_user_prot_info = spi_nor_mtd_otp_info;
+		mtd->_read_user_prot_reg = spi_nor_mtd_otp_read;
+		mtd->_write_user_prot_reg = spi_nor_mtd_otp_write;
+		mtd->_lock_user_prot_reg = spi_nor_mtd_otp_lock;
+	}
+
 	if (info->flags & USE_FSR)
 		nor->flags |= SNOR_F_USE_FSR;
 	if (info->flags & SPI_NOR_HAS_TB) {
diff --git a/drivers/mtd/spi-nor/core.h b/drivers/mtd/spi-nor/core.h
index fb3ef86e350c..516c5973bf88 100644
--- a/drivers/mtd/spi-nor/core.h
+++ b/drivers/mtd/spi-nor/core.h
@@ -170,6 +170,21 @@ struct spi_nor_erase_map {
 	u8				uniform_erase_type;
 };
 
+/**
+ * struct spi_nor_otp_info - Structure to describe the SPI NOR OTP region
+ * @otp_size:		size of one OTP region in bytes.
+ * @n_otps:		number of individual OTP regions.
+ * @otp_start_addr:	start address of the OTP area.
+ * @otp_addr_offset:	offset between consecutive OTP regions if there are
+ *			more than one.
+ */
+struct spi_nor_otp_info {
+	u32 otp_size;
+	int n_otps;
+	u32 otp_start_addr;
+	u32 otp_addr_offset;
+};
+
 /**
  * struct spi_nor_locking_ops - SPI NOR locking methods
  * @lock:	lock a region of the SPI NOR.
@@ -182,6 +197,20 @@ struct spi_nor_locking_ops {
 	int (*is_locked)(struct spi_nor *nor, loff_t ofs, uint64_t len);
 };
 
+/**
+ * struct spi_nor_otp_ops - SPI NOR OTP methods
+ * @read:	read from the SPI NOR OTP area.
+ * @write:	write to the SPI NOR OTP area.
+ * @lock:	lock an OTP region.
+ * @is_locked:	check if an OTP region of the SPI NOR is locked.
+ */
+struct spi_nor_otp_ops {
+	int (*read)(struct spi_nor *nor, loff_t ofs, uint64_t len, u8 *buf);
+	int (*write)(struct spi_nor *nor, loff_t ofs, uint64_t len, u8 *buf);
+	int (*lock)(struct spi_nor *nor, unsigned int region);
+	int (*is_locked)(struct spi_nor *nor, unsigned int region);
+};
+
 /**
  * struct spi_nor_flash_parameter - SPI NOR flash parameters and settings.
  * Includes legacy flash parameters and settings that can be overwritten
@@ -198,6 +227,7 @@ struct spi_nor_locking_ops {
  *                      higher index in the array, the higher priority.
  * @erase_map:		the erase map parsed from the SFDP Sector Map Parameter
  *                      Table.
+ * @otp_info:		describes the OTP regions.
  * @quad_enable:	enables/disables SPI NOR Quad mode.
  * @set_4byte_addr_mode: puts the SPI NOR in 4 byte addressing mode.
  * @convert_addr:	converts an absolute address into something the flash
@@ -208,6 +238,7 @@ struct spi_nor_locking_ops {
  *                      e.g. different opcodes, specific address calculation,
  *                      page size, etc.
  * @locking_ops:	SPI NOR locking methods.
+ * @otp_ops:		SPI NOR OTP methods.
  */
 struct spi_nor_flash_parameter {
 	u64				size;
@@ -218,6 +249,7 @@ struct spi_nor_flash_parameter {
 	struct spi_nor_pp_command	page_programs[SNOR_CMD_PP_MAX];
 
 	struct spi_nor_erase_map        erase_map;
+	struct spi_nor_otp_info		otp_info;
 
 	int (*quad_enable)(struct spi_nor *nor, bool enable);
 	int (*set_4byte_addr_mode)(struct spi_nor *nor, bool enable);
@@ -225,6 +257,7 @@ struct spi_nor_flash_parameter {
 	int (*setup)(struct spi_nor *nor, const struct spi_nor_hwcaps *hwcaps);
 
 	const struct spi_nor_locking_ops *locking_ops;
+	const struct spi_nor_otp_ops *otp_ops;
 };
 
 /**
@@ -314,6 +347,15 @@ struct flash_info {
 
 	/* Part specific fixup hooks. */
 	const struct spi_nor_fixups *fixups;
+
+	/* OTP size in bytes */
+	u16 otp_size;
+	/* Number of OTP banks */
+	u16 n_otps;
+	/* Start address of OTP area */
+	u32 otp_start_addr;
+	/* Offset between consecutive OTP banks if there are more than one */
+	u32 otp_addr_offset;
 };
 
 /* Used when the "_ext_id" is two bytes at most */
@@ -366,6 +408,12 @@ struct flash_info {
 		.addr_width = 3,					\
 		.flags = SPI_NOR_NO_FR | SPI_NOR_XSR_RDY,
 
+#define OTP_INFO(_otp_size, _n_otps, _otp_start_addr, _otp_addr_offset)	\
+		.otp_size = (_otp_size),				\
+		.n_otps = (_n_otps),					\
+		.otp_start_addr = (_otp_start_addr),			\
+		.otp_addr_offset = (_otp_addr_offset),
+
 /**
  * struct spi_nor_manufacturer - SPI NOR manufacturer object
  * @name: manufacturer name
-- 
2.20.1

