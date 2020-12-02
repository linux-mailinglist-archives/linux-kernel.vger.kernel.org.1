Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 073C02CCA3A
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 00:04:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388027AbgLBXCX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 18:02:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387723AbgLBXCW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 18:02:22 -0500
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12FE4C0613D6
        for <linux-kernel@vger.kernel.org>; Wed,  2 Dec 2020 15:01:42 -0800 (PST)
Received: from apollo.fritz.box (unknown [IPv6:2a02:810c:c200:2e91:6257:18ff:fec4:ca34])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 9DF3023E64;
        Thu,  3 Dec 2020 00:01:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1606950060;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Nn6eJpF1jsQ1oUQaahO2YeyWCJfTbxlUhx54mRiQKII=;
        b=ueMLruPuv9i/decGf1JmWOnU2Z2QgzH/1PLQ9p9QOhSHzKORIlPwL7EGimxsIIrYGivihZ
        HuyRxusrcs/ds14Y7WQm7FgA4yVdSm9wXHTRFklxkETdYZUjGSJk8dmc/op9Uf/TGWsmVb
        S/Hp3SxmJiMKljJvjORUFsCoF27CghI=
From:   Michael Walle <michael@walle.cc>
To:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH v7 7/7] mtd: spi-nor: keep lock bits if they are non-volatile
Date:   Thu,  3 Dec 2020 00:00:40 +0100
Message-Id: <20201202230040.14009-8-michael@walle.cc>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201202230040.14009-1-michael@walle.cc>
References: <20201202230040.14009-1-michael@walle.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Traditionally, linux unlocks the whole flash because there are legacy
devices which has the write protections bits set by default at startup.
If you actually want to use the flash protection bits, eg. because there
is a read-only part for a bootloader, this automatic unlocking is
harmful. If there is no hardware write protection in place (usually
called WP#), a startup of the kernel just discards this protection.

I've gone through the datasheets of all the flashes (except the Intel
ones where I could not find any datasheet nor reference) which supports
the unlocking feature and looked how the sector protection was
implemented. The currently supported flashes can be divided into the
following two categories:
 (1) block protection bits are non-volatile. Thus they keep their values
     at reset and power-cycle
 (2) flashes where these bits are volatile. After reset or power-cycle,
     the whole memory array is protected.
     (a) some devices needs a special "Global Unprotect" command, eg.
         the Atmel AT25DF041A.
     (b) some devices require to clear the BPn bits in the status
         register.

Due to the reasons above, we do not want to clear the bits for flashes
which belong to category (1). Fortunately for us, only Atmel flashes
fall into category (2a). Implement the "Global Protect" and "Global
Unprotect" commands for these. For (2b) we can use normal block
protection locking scheme.

This patch adds a new flag to indicate the case (2). Only if we have
such a flash we unlock the whole flash array. To be backwards compatible
it also introduces a kernel configuration option which restores the
complete legacy behavior ("Disable write protection on any flashes").
Hopefully, this will clean up "unlock the entire flash for legacy
devices" once and for all.

For reference here are the actually commits which introduced the legacy
behavior (and extended the behavior to other chip manufacturers):

commit f80e521c916cb ("mtd: m25p80: add support for the Intel/Numonyx {16,32,64}0S33B SPI flash chips")
commit ea60658a08f8f ("mtd: m25p80: disable SST software protection bits by default")
commit 7228982442365 ("[MTD] m25p80: fix bug - ATmel spi flash fails to be copied to")

Actually, this might also fix handling of the Atmel AT25DF flashes,
because the original commit 7228982442365 ("[MTD] m25p80: fix bug -
ATmel spi flash fails to be copied to") was writing a 0 to the status
register, which is a "Global Unprotect". This might not be the case in
the current code which only handles the block protection bits BP2, BP1
and BP0. Thus, it depends on the current contents of the status register
if this unlock actually corresponds to a "Global Unprotect" command. In
the worst case, the current code might leave the AT25DF flashes in a
write protected state.

The commit 191f5c2ed4b6f ("mtd: spi-nor: use 16-bit WRR command when QE
is set on spansion flashes") changed that behavior by just clearing BP2
to BP0 instead of writing a 0 to the status register.

Further, the commit 3e0930f109e76 ("mtd: spi-nor: Rework the disabling
of block write protection") expanded the unlock_all() feature to ANY
flash which supports locking.

Signed-off-by: Michael Walle <michael@walle.cc>
---
changes since v6:
 - fixed typos, small documentation changes
 - changed _WP_ to _SWP_, "write protection" to "software write
   protection"
 - use dev_dbg() instead of dev_err() to print message about WP pin

changes since v5:
 - also set SRWD bit for the "Global Protect" command
 - use spi_nor_write_sr() instead of spi_nor_write_sr_and_check() to send
   the "Global Protect" or "Global Unprotect" command
 - mark ESMT F25L32QA as non-volatile as indicated in a newer datasheet
   revision
 - rebased to latest tree

changes since v4:
 - made atmel_global_protection_default_init() static, spotted by
   lkp@intel.com

changes since v3:
 - now defaulting to MTD_SPI_NOR_WP_DISABLE_ON_VOLATILE, suggested by Vignesh
 - restored the original spi_nor_unlock_all(), instead add individual
   locking ops for the "Global Protect" scheme in atmel.c. This was tested
   partly with the AT25SL321 (for the test I added the fixups to this
   flash).
 - renamed SPI_NOR_UNPROTECT to SPI_NOR_WP_IS_VOLATILE. Suggested by
   Vingesh, although I've renamed it to a more general "WP_IS_VOLATILE"
   because either the BP bits or the individual sector locks might be
   volatile.
 - add mention of both block protection bits and "Global Unprotect" command
   in the Kconfig help text.

changes since v2:
 - add Kconfig option to be able to retain legacy behavior
 - rebased the patch due to the spi-nor rewrite
 - dropped the Fixes: tag, it doens't make sense after the spi-nor rewrite
 - mention commit 3e0930f109e76 which further modified the unlock
   behavior.

changes since v1:
 - completely rewrote patch, the first version used a device tree flag

 drivers/mtd/spi-nor/Kconfig |  44 +++++++++++++
 drivers/mtd/spi-nor/atmel.c | 128 ++++++++++++++++++++++++++++++++++--
 drivers/mtd/spi-nor/core.c  |  23 ++++++-
 drivers/mtd/spi-nor/core.h  |   8 +++
 drivers/mtd/spi-nor/esmt.c  |   2 +-
 drivers/mtd/spi-nor/intel.c |   9 ++-
 drivers/mtd/spi-nor/sst.c   |  21 +++---
 7 files changed, 211 insertions(+), 24 deletions(-)

diff --git a/drivers/mtd/spi-nor/Kconfig b/drivers/mtd/spi-nor/Kconfig
index ffc4b380f2b1..d0f17919de3a 100644
--- a/drivers/mtd/spi-nor/Kconfig
+++ b/drivers/mtd/spi-nor/Kconfig
@@ -24,6 +24,50 @@ config MTD_SPI_NOR_USE_4K_SECTORS
 	  Please note that some tools/drivers/filesystems may not work with
 	  4096 B erase size (e.g. UBIFS requires 15 KiB as a minimum).
 
+choice
+	prompt "Software write protection at boot"
+	default MTD_SPI_NOR_SWP_DISABLE_ON_VOLATILE
+
+config MTD_SPI_NOR_SWP_DISABLE
+	bool "Disable SWP on any flashes (legacy behavior)"
+	help
+	  This option disables the software write protection on any SPI
+	  flashes at boot-up.
+
+	  Depending on the flash chip this either clears the block protection
+	  bits or does a "Global Unprotect" command.
+
+	  Don't use this if you intent to use the software write protection
+	  of your SPI flash. This is only to keep backwards compatibility.
+
+config MTD_SPI_NOR_SWP_DISABLE_ON_VOLATILE
+	bool "Disable SWP on flashes w/ volatile protection bits"
+	help
+	  Some SPI flashes have volatile block protection bits, ie. after a
+	  power-up or a reset the flash is software write protected by
+	  default.
+
+	  This option disables the software write protection for these kind
+	  of flashes while keeping it enabled for any other SPI flashes
+	  which have non-volatile write protection bits.
+
+	  If the software write protection will be disabled depending on
+	  the flash either the block protection bits are cleared or a
+	  "Global Unprotect" command is issued.
+
+	  If you are unsure, select this option.
+
+config MTD_SPI_NOR_SWP_KEEP
+	bool "Keep software write protection as is"
+	help
+	  If you select this option the software write protection of any
+	  SPI flashes will not be changed. If your flash is software write
+	  protected or will be automatically software write protected after
+	  power-up you have to manually unlock it before you are able to
+	  write to it.
+
+endchoice
+
 source "drivers/mtd/spi-nor/controllers/Kconfig"
 
 endif # MTD_SPI_NOR
diff --git a/drivers/mtd/spi-nor/atmel.c b/drivers/mtd/spi-nor/atmel.c
index ee382a44bd0f..2000babc6a81 100644
--- a/drivers/mtd/spi-nor/atmel.c
+++ b/drivers/mtd/spi-nor/atmel.c
@@ -8,6 +8,8 @@
 
 #include "core.h"
 
+#define ATMEL_SR_GLOBAL_PROTECT_MASK GENMASK(5, 2)
+
 /*
  * The Atmel AT25FS010/AT25FS040 parts have some weird configuration for the
  * block protection bits. We don't support them. But legacy behavior in linux
@@ -55,6 +57,104 @@ static const struct spi_nor_fixups atmel_at25fs_fixups = {
 	.default_init = atmel_at25fs_default_init,
 };
 
+/**
+ * atmel_set_global_protection - Do a Global Protect or Unprotect command
+ * @nor:	pointer to 'struct spi_nor'
+ * @ofs:	offset in bytes
+ * @len:	len in bytes
+ * @is_protect:	if true do a Global Protect otherwise it is a Global Unprotect
+ *
+ * Return: 0 on success, -error otherwise.
+ */
+static int atmel_set_global_protection(struct spi_nor *nor, loff_t ofs,
+				       uint64_t len, bool is_protect)
+{
+	int ret;
+	u8 sr;
+
+	/* We only support locking the whole flash array */
+	if (ofs || len != nor->params->size)
+		return -EINVAL;
+
+	ret = spi_nor_read_sr(nor, nor->bouncebuf);
+	if (ret)
+		return ret;
+
+	sr = nor->bouncebuf[0];
+
+	/* SRWD bit needs to be cleared, otherwise the protection doesn't change */
+	if (sr & SR_SRWD) {
+		sr &= ~SR_SRWD;
+		ret = spi_nor_write_sr_and_check(nor, sr);
+		if (ret) {
+			dev_dbg(nor->dev, "unable to clear SRWD bit, WP# asserted?\n");
+			return ret;
+		}
+	}
+
+	if (is_protect) {
+		sr |= ATMEL_SR_GLOBAL_PROTECT_MASK;
+		/*
+		 * Set the SRWD bit again as soon as we are protecting
+		 * anything. This will ensure that the WP# pin is working
+		 * correctly. By doing this we also behave the same as
+		 * spi_nor_sr_lock(), which sets SRWD if any block protection
+		 * is active.
+		 */
+		sr |= SR_SRWD;
+	} else {
+		sr &= ~ATMEL_SR_GLOBAL_PROTECT_MASK;
+	}
+
+	nor->bouncebuf[0] = sr;
+
+	/*
+	 * We cannot use the spi_nor_write_sr_and_check() because this command
+	 * isn't really setting any bits, instead it is an pseudo command for
+	 * "Global Unprotect" or "Global Protect"
+	 */
+	return spi_nor_write_sr(nor, nor->bouncebuf, 1);
+}
+
+static int atmel_global_protect(struct spi_nor *nor, loff_t ofs, uint64_t len)
+{
+	return atmel_set_global_protection(nor, ofs, len, true);
+}
+
+static int atmel_global_unprotect(struct spi_nor *nor, loff_t ofs, uint64_t len)
+{
+	return atmel_set_global_protection(nor, ofs, len, false);
+}
+
+static int atmel_is_global_protected(struct spi_nor *nor, loff_t ofs, uint64_t len)
+{
+	int ret;
+
+	if (ofs >= nor->params->size || (ofs + len) > nor->params->size)
+		return -EINVAL;
+
+	ret = spi_nor_read_sr(nor, nor->bouncebuf);
+	if (ret)
+		return ret;
+
+	return ((nor->bouncebuf[0] & ATMEL_SR_GLOBAL_PROTECT_MASK) == ATMEL_SR_GLOBAL_PROTECT_MASK);
+}
+
+static const struct spi_nor_locking_ops atmel_global_protection_ops = {
+	.lock = atmel_global_protect,
+	.unlock = atmel_global_unprotect,
+	.is_locked = atmel_is_global_protected,
+};
+
+static void atmel_global_protection_default_init(struct spi_nor *nor)
+{
+	nor->params->locking_ops = &atmel_global_protection_ops;
+}
+
+static const struct spi_nor_fixups atmel_global_protection_fixups = {
+	.default_init = atmel_global_protection_default_init,
+};
+
 static const struct flash_info atmel_parts[] = {
 	/* Atmel -- some are (confusingly) marketed as "DataFlash" */
 	{ "at25fs010",  INFO(0x1f6601, 0, 32 * 1024,   4, SECT_4K | SPI_NOR_HAS_LOCK)
@@ -62,18 +162,32 @@ static const struct flash_info atmel_parts[] = {
 	{ "at25fs040",  INFO(0x1f6604, 0, 64 * 1024,   8, SECT_4K | SPI_NOR_HAS_LOCK)
 		.fixups = &atmel_at25fs_fixups },
 
-	{ "at25df041a", INFO(0x1f4401, 0, 64 * 1024,   8, SECT_4K | SPI_NOR_HAS_LOCK) },
-	{ "at25df321",  INFO(0x1f4700, 0, 64 * 1024,  64, SECT_4K | SPI_NOR_HAS_LOCK) },
-	{ "at25df321a", INFO(0x1f4701, 0, 64 * 1024,  64, SECT_4K | SPI_NOR_HAS_LOCK) },
-	{ "at25df641",  INFO(0x1f4800, 0, 64 * 1024, 128, SECT_4K | SPI_NOR_HAS_LOCK) },
+	{ "at25df041a", INFO(0x1f4401, 0, 64 * 1024,   8,
+			     SECT_4K | SPI_NOR_HAS_LOCK | SPI_NOR_SWP_IS_VOLATILE)
+			.fixups = &atmel_global_protection_fixups },
+	{ "at25df321",  INFO(0x1f4700, 0, 64 * 1024,  64,
+			     SECT_4K | SPI_NOR_HAS_LOCK | SPI_NOR_SWP_IS_VOLATILE)
+			.fixups = &atmel_global_protection_fixups },
+	{ "at25df321a", INFO(0x1f4701, 0, 64 * 1024,  64,
+			     SECT_4K | SPI_NOR_HAS_LOCK | SPI_NOR_SWP_IS_VOLATILE)
+			.fixups = &atmel_global_protection_fixups },
+	{ "at25df641",  INFO(0x1f4800, 0, 64 * 1024, 128,
+			     SECT_4K | SPI_NOR_HAS_LOCK | SPI_NOR_SWP_IS_VOLATILE)
+			.fixups = &atmel_global_protection_fixups },
 
 	{ "at25sl321",	INFO(0x1f4216, 0, 64 * 1024, 64,
 			     SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
 
 	{ "at26f004",   INFO(0x1f0400, 0, 64 * 1024,  8, SECT_4K) },
-	{ "at26df081a", INFO(0x1f4501, 0, 64 * 1024, 16, SECT_4K | SPI_NOR_HAS_LOCK) },
-	{ "at26df161a", INFO(0x1f4601, 0, 64 * 1024, 32, SECT_4K | SPI_NOR_HAS_LOCK) },
-	{ "at26df321",  INFO(0x1f4700, 0, 64 * 1024, 64, SECT_4K | SPI_NOR_HAS_LOCK) },
+	{ "at26df081a", INFO(0x1f4501, 0, 64 * 1024, 16,
+			     SECT_4K | SPI_NOR_HAS_LOCK | SPI_NOR_SWP_IS_VOLATILE)
+			.fixups = &atmel_global_protection_fixups },
+	{ "at26df161a", INFO(0x1f4601, 0, 64 * 1024, 32,
+			     SECT_4K | SPI_NOR_HAS_LOCK | SPI_NOR_SWP_IS_VOLATILE)
+			.fixups = &atmel_global_protection_fixups },
+	{ "at26df321",  INFO(0x1f4700, 0, 64 * 1024, 64,
+			     SECT_4K | SPI_NOR_HAS_LOCK | SPI_NOR_SWP_IS_VOLATILE)
+			.fixups = &atmel_global_protection_fixups },
 
 	{ "at45db081d", INFO(0x1f2500, 0, 64 * 1024, 16, SECT_4K) },
 };
diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index 6afcb99e9741..235acf3f4c43 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -377,7 +377,7 @@ int spi_nor_write_disable(struct spi_nor *nor)
  *
  * Return: 0 on success, -errno otherwise.
  */
-static int spi_nor_read_sr(struct spi_nor *nor, u8 *sr)
+int spi_nor_read_sr(struct spi_nor *nor, u8 *sr)
 {
 	int ret;
 
@@ -861,7 +861,7 @@ int spi_nor_wait_till_ready(struct spi_nor *nor)
  *
  * Return: 0 on success, -errno otherwise.
  */
-static int spi_nor_write_sr(struct spi_nor *nor, const u8 *sr, size_t len)
+int spi_nor_write_sr(struct spi_nor *nor, const u8 *sr, size_t len)
 {
 	int ret;
 
@@ -3139,6 +3139,8 @@ static void spi_nor_try_unlock_all(struct spi_nor *nor)
 	if (!(nor->flags & SNOR_F_HAS_LOCK))
 		return;
 
+	dev_dbg(nor->dev, "Unprotecting entire flash array\n");
+
 	ret = spi_nor_unlock(&nor->mtd, 0, nor->params->size);
 	if (ret)
 		dev_dbg(nor->dev, "Failed to unlock the entire flash memory array\n");
@@ -3160,7 +3162,20 @@ static int spi_nor_init(struct spi_nor *nor)
 		return err;
 	}
 
-	spi_nor_try_unlock_all(nor);
+	/*
+	 * Some SPI NOR flashes are write protected by default after a power-on
+	 * reset cycle, in order to avoid inadvertent writes during power-up.
+	 * Backward compatibility imposes to unlock the entire flash memory
+	 * array at power-up by default. Depending on the kernel configuration
+	 * (1) do nothing, (2) always unlock the entire flash array or (3)
+	 * unlock the entire flash array only when the software write
+	 * protection bits are volatile. The latter is indicated by
+	 * SNOR_F_SWP_IS_VOLATILE.
+	 */
+	if (IS_ENABLED(CONFIG_MTD_SPI_NOR_SWP_DISABLE) ||
+	    (IS_ENABLED(CONFIG_MTD_SPI_NOR_SWP_DISABLE_ON_VOLATILE) &&
+	     nor->flags & SNOR_F_SWP_IS_VOLATILE))
+		spi_nor_try_unlock_all(nor);
 
 	if (nor->addr_width == 4 &&
 	    nor->read_proto != SNOR_PROTO_8_8_8_DTR &&
@@ -3459,6 +3474,8 @@ int spi_nor_scan(struct spi_nor *nor, const char *name,
 		nor->flags |= SNOR_F_NO_OP_CHIP_ERASE;
 	if (info->flags & USE_CLSR)
 		nor->flags |= SNOR_F_USE_CLSR;
+	if (info->flags & SPI_NOR_SWP_IS_VOLATILE)
+		nor->flags |= SNOR_F_SWP_IS_VOLATILE;
 
 	if (info->flags & SPI_NOR_4BIT_BP) {
 		nor->flags |= SNOR_F_HAS_4BIT_BP;
diff --git a/drivers/mtd/spi-nor/core.h b/drivers/mtd/spi-nor/core.h
index 7780169d485b..89acf499aecb 100644
--- a/drivers/mtd/spi-nor/core.h
+++ b/drivers/mtd/spi-nor/core.h
@@ -28,6 +28,7 @@ enum spi_nor_option_flags {
 	SNOR_F_HAS_SR_BP3_BIT6  = BIT(13),
 	SNOR_F_IO_MODE_EN_VOLATILE = BIT(14),
 	SNOR_F_SOFT_RESET	= BIT(15),
+	SNOR_F_SWP_IS_VOLATILE	= BIT(16),
 };
 
 struct spi_nor_read_command {
@@ -329,6 +330,11 @@ struct flash_info {
 						 * available I/O mode via a
 						 * volatile bit.
 						 */
+#define SPI_NOR_SWP_IS_VOLATILE	BIT(22)	/*
+					 * Flash has volatile software write
+					 * protection bits. Usually these will
+					 * power-up in a write-protected state.
+					 */
 
 	/* Part specific fixup hooks. */
 	const struct spi_nor_fixups *fixups;
@@ -430,6 +436,8 @@ void spi_nor_unlock_and_unprep(struct spi_nor *nor);
 int spi_nor_sr1_bit6_quad_enable(struct spi_nor *nor);
 int spi_nor_sr2_bit1_quad_enable(struct spi_nor *nor);
 int spi_nor_sr2_bit7_quad_enable(struct spi_nor *nor);
+int spi_nor_read_sr(struct spi_nor *nor, u8 *sr);
+int spi_nor_write_sr(struct spi_nor *nor, const u8 *sr, size_t len);
 int spi_nor_write_sr_and_check(struct spi_nor *nor, u8 sr1);
 
 int spi_nor_xread_sr(struct spi_nor *nor, u8 *sr);
diff --git a/drivers/mtd/spi-nor/esmt.c b/drivers/mtd/spi-nor/esmt.c
index c93170008118..cfc9218c1053 100644
--- a/drivers/mtd/spi-nor/esmt.c
+++ b/drivers/mtd/spi-nor/esmt.c
@@ -11,7 +11,7 @@
 static const struct flash_info esmt_parts[] = {
 	/* ESMT */
 	{ "f25l32pa", INFO(0x8c2016, 0, 64 * 1024, 64,
-			   SECT_4K | SPI_NOR_HAS_LOCK) },
+			   SECT_4K | SPI_NOR_HAS_LOCK | SPI_NOR_SWP_IS_VOLATILE) },
 	{ "f25l32qa", INFO(0x8c4116, 0, 64 * 1024, 64,
 			   SECT_4K | SPI_NOR_HAS_LOCK) },
 	{ "f25l64qa", INFO(0x8c4117, 0, 64 * 1024, 128,
diff --git a/drivers/mtd/spi-nor/intel.c b/drivers/mtd/spi-nor/intel.c
index 6c31bef3fc60..8ece9cceb3cf 100644
--- a/drivers/mtd/spi-nor/intel.c
+++ b/drivers/mtd/spi-nor/intel.c
@@ -10,9 +10,12 @@
 
 static const struct flash_info intel_parts[] = {
 	/* Intel/Numonyx -- xxxs33b */
-	{ "160s33b",  INFO(0x898911, 0, 64 * 1024,  32, SPI_NOR_HAS_LOCK) },
-	{ "320s33b",  INFO(0x898912, 0, 64 * 1024,  64, SPI_NOR_HAS_LOCK) },
-	{ "640s33b",  INFO(0x898913, 0, 64 * 1024, 128, SPI_NOR_HAS_LOCK) },
+	{ "160s33b",  INFO(0x898911, 0, 64 * 1024,  32,
+			   SPI_NOR_HAS_LOCK | SPI_NOR_SWP_IS_VOLATILE) },
+	{ "320s33b",  INFO(0x898912, 0, 64 * 1024,  64,
+			   SPI_NOR_HAS_LOCK | SPI_NOR_SWP_IS_VOLATILE) },
+	{ "640s33b",  INFO(0x898913, 0, 64 * 1024, 128,
+			   SPI_NOR_HAS_LOCK | SPI_NOR_SWP_IS_VOLATILE) },
 };
 
 const struct spi_nor_manufacturer spi_nor_intel = {
diff --git a/drivers/mtd/spi-nor/sst.c b/drivers/mtd/spi-nor/sst.c
index 0d9d319f61e6..00e48da0744a 100644
--- a/drivers/mtd/spi-nor/sst.c
+++ b/drivers/mtd/spi-nor/sst.c
@@ -11,27 +11,28 @@
 static const struct flash_info sst_parts[] = {
 	/* SST -- large erase sizes are "overlays", "sectors" are 4K */
 	{ "sst25vf040b", INFO(0xbf258d, 0, 64 * 1024,  8,
-			      SECT_4K | SST_WRITE | SPI_NOR_HAS_LOCK) },
+			      SECT_4K | SST_WRITE | SPI_NOR_HAS_LOCK | SPI_NOR_SWP_IS_VOLATILE) },
 	{ "sst25vf080b", INFO(0xbf258e, 0, 64 * 1024, 16,
-			      SECT_4K | SST_WRITE | SPI_NOR_HAS_LOCK) },
+			      SECT_4K | SST_WRITE | SPI_NOR_HAS_LOCK | SPI_NOR_SWP_IS_VOLATILE) },
 	{ "sst25vf016b", INFO(0xbf2541, 0, 64 * 1024, 32,
-			      SECT_4K | SST_WRITE | SPI_NOR_HAS_LOCK) },
+			      SECT_4K | SST_WRITE | SPI_NOR_HAS_LOCK | SPI_NOR_SWP_IS_VOLATILE) },
 	{ "sst25vf032b", INFO(0xbf254a, 0, 64 * 1024, 64,
-			      SECT_4K | SST_WRITE | SPI_NOR_HAS_LOCK) },
+			      SECT_4K | SST_WRITE | SPI_NOR_HAS_LOCK | SPI_NOR_SWP_IS_VOLATILE) },
 	{ "sst25vf064c", INFO(0xbf254b, 0, 64 * 1024, 128,
-			      SECT_4K | SPI_NOR_4BIT_BP | SPI_NOR_HAS_LOCK) },
+			      SECT_4K | SPI_NOR_4BIT_BP | SPI_NOR_HAS_LOCK |
+			      SPI_NOR_SWP_IS_VOLATILE) },
 	{ "sst25wf512",  INFO(0xbf2501, 0, 64 * 1024,  1,
-			      SECT_4K | SST_WRITE | SPI_NOR_HAS_LOCK) },
+			      SECT_4K | SST_WRITE | SPI_NOR_HAS_LOCK | SPI_NOR_SWP_IS_VOLATILE) },
 	{ "sst25wf010",  INFO(0xbf2502, 0, 64 * 1024,  2,
-			      SECT_4K | SST_WRITE | SPI_NOR_HAS_LOCK) },
+			      SECT_4K | SST_WRITE | SPI_NOR_HAS_LOCK | SPI_NOR_SWP_IS_VOLATILE) },
 	{ "sst25wf020",  INFO(0xbf2503, 0, 64 * 1024,  4,
-			      SECT_4K | SST_WRITE | SPI_NOR_HAS_LOCK) },
+			      SECT_4K | SST_WRITE | SPI_NOR_HAS_LOCK | SPI_NOR_SWP_IS_VOLATILE) },
 	{ "sst25wf020a", INFO(0x621612, 0, 64 * 1024,  4, SECT_4K | SPI_NOR_HAS_LOCK) },
 	{ "sst25wf040b", INFO(0x621613, 0, 64 * 1024,  8, SECT_4K | SPI_NOR_HAS_LOCK) },
 	{ "sst25wf040",  INFO(0xbf2504, 0, 64 * 1024,  8,
-			      SECT_4K | SST_WRITE | SPI_NOR_HAS_LOCK) },
+			      SECT_4K | SST_WRITE | SPI_NOR_HAS_LOCK | SPI_NOR_SWP_IS_VOLATILE) },
 	{ "sst25wf080",  INFO(0xbf2505, 0, 64 * 1024, 16,
-			      SECT_4K | SST_WRITE | SPI_NOR_HAS_LOCK) },
+			      SECT_4K | SST_WRITE | SPI_NOR_HAS_LOCK | SPI_NOR_SWP_IS_VOLATILE) },
 	{ "sst26wf016b", INFO(0xbf2651, 0, 64 * 1024, 32,
 			      SECT_4K | SPI_NOR_DUAL_READ |
 			      SPI_NOR_QUAD_READ) },
-- 
2.20.1

