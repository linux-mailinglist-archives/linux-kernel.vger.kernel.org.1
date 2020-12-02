Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 069B82CCA34
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 00:02:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387934AbgLBXBm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 18:01:42 -0500
Received: from ssl.serverraum.org ([176.9.125.105]:32859 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727557AbgLBXBk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 18:01:40 -0500
Received: from apollo.fritz.box (unknown [IPv6:2a02:810c:c200:2e91:6257:18ff:fec4:ca34])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 76ABC23E5B;
        Thu,  3 Dec 2020 00:00:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1606950058;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tA/aM6lWMfa7TmNVA8dfiG+itOvZgqH1cE8LTQP5Qes=;
        b=qTIbY8IdbkBb03JKv09ERJyQryGyyn0LDkdFpnZaMzWuFqk2t6yTeC3kokoPU2Hm2619TM
        FSxUi1G7sy50T/pe3sxBiGBaJD00g/r9bGG7LWzI+Kjo5cDk9XidfGzVCdvjWPWxQ1X9l5
        XoSWo0G4Enik+j+L/twUr2sNgVwZy5o=
From:   Michael Walle <michael@walle.cc>
To:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH v7 2/7] mtd: spi-nor: ignore errors in spi_nor_unlock_all()
Date:   Thu,  3 Dec 2020 00:00:35 +0100
Message-Id: <20201202230040.14009-3-michael@walle.cc>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201202230040.14009-1-michael@walle.cc>
References: <20201202230040.14009-1-michael@walle.cc>
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
---
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

