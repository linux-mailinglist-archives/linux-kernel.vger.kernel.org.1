Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF4B72CDB40
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 17:33:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731289AbgLCQay (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 11:30:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731276AbgLCQaw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 11:30:52 -0500
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6077FC061A4F
        for <linux-kernel@vger.kernel.org>; Thu,  3 Dec 2020 08:30:12 -0800 (PST)
Received: from apollo.fritz.box (unknown [IPv6:2a02:810c:c200:2e91:6257:18ff:fec4:ca34])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 7242023E55;
        Thu,  3 Dec 2020 17:30:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1607013010;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZeHHC6ibatiXFsSw6OgCY5dVPTbz2DRnswg8Mx3uWd0=;
        b=l33Bseuv1xqodpLKJo2Vh/tsB7wiphNkOgrI2b08d+oL4Dg0vMk2RnYlrYZ1Ucnw8I0j8y
        kftmSk7Jdu10yKgNK0XYhjUWu+DVF+VDDh38iMhVlxUNhFI3dFXg42ilxaWWLv5B5CMuE6
        DxTgpgZz1y6214X8zzYPVtN/TP86lEg=
From:   Michael Walle <michael@walle.cc>
To:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH v8 2/7] mtd: spi-nor: ignore errors in spi_nor_unlock_all()
Date:   Thu,  3 Dec 2020 17:29:54 +0100
Message-Id: <20201203162959.29589-3-michael@walle.cc>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201203162959.29589-1-michael@walle.cc>
References: <20201203162959.29589-1-michael@walle.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just try to unlock the whole SPI-NOR flash array. Don't abort the
probing in case of an error. Justifications:
 (1) For some boards, this just works because
     spi_nor_write_16bit_sr_and_check() is broken and just checks the
     second half of the 16bit. Once that will be fixed, SPI probe will
     fail for boards which has hardware-write protected SPI-NOR flashes.
 (2) Until now, hardware write-protection was the only viable solution
     to use the block protection bits. This is because this very
     function spi_nor_unlock_all() will be called unconditionally on
     every linux boot. Therefore, this bits only makes sense in
     combination with the hardware write-protection. If we would fail
     the SPI probe on an error in spi_nor_unlock_all() we'd break
     virtually all users of the block protection bits.
 (3) We should try hard to keep the MTD working even if the flash might
     not be writable/erasable.

Fixes: 3e0930f109e7 ("mtd: spi-nor: Rework the disabling of block write protection")
Signed-off-by: Michael Walle <michael@walle.cc>
Reviewed-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
changes since v7:
 - none

changes since v6:
 - new patch

 drivers/mtd/spi-nor/core.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index 5bee7c8da4dc..013198abe929 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -3121,20 +3121,27 @@ static int spi_nor_quad_enable(struct spi_nor *nor)
 }
 
 /**
- * spi_nor_unlock_all() - Unlocks the entire flash memory array.
+ * spi_nor_try_unlock_all() - Tries to unlock the entire flash memory array.
  * @nor:	pointer to a 'struct spi_nor'.
  *
  * Some SPI NOR flashes are write protected by default after a power-on reset
  * cycle, in order to avoid inadvertent writes during power-up. Backward
  * compatibility imposes to unlock the entire flash memory array at power-up
  * by default.
+ *
+ * Unprotecting the entire flash array will fail for boards which are hardware
+ * write-protected. Thus any errors are ignored.
  */
-static int spi_nor_unlock_all(struct spi_nor *nor)
+static void spi_nor_try_unlock_all(struct spi_nor *nor)
 {
-	if (nor->flags & SNOR_F_HAS_LOCK)
-		return spi_nor_unlock(&nor->mtd, 0, nor->params->size);
+	int ret;
 
-	return 0;
+	if (!(nor->flags & SNOR_F_HAS_LOCK))
+		return;
+
+	ret = spi_nor_unlock(&nor->mtd, 0, nor->params->size);
+	if (ret)
+		dev_dbg(nor->dev, "Failed to unlock the entire flash memory array\n");
 }
 
 static int spi_nor_init(struct spi_nor *nor)
@@ -3153,11 +3160,7 @@ static int spi_nor_init(struct spi_nor *nor)
 		return err;
 	}
 
-	err = spi_nor_unlock_all(nor);
-	if (err) {
-		dev_dbg(nor->dev, "Failed to unlock the entire flash memory array\n");
-		return err;
-	}
+	spi_nor_try_unlock_all(nor);
 
 	if (nor->addr_width == 4 &&
 	    nor->read_proto != SNOR_PROTO_8_8_8_DTR &&
-- 
2.20.1

