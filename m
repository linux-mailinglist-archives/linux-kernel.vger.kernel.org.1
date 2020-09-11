Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31DF626651F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Sep 2020 18:53:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726146AbgIKQx5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Sep 2020 12:53:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726335AbgIKPGO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 11:06:14 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C8A8C06137F
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 07:47:20 -0700 (PDT)
Received: from dude02.hi.pengutronix.de ([2001:67c:670:100:1d::28])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1kGkKU-0006Pu-NW; Fri, 11 Sep 2020 16:47:10 +0200
Received: from mfe by dude02.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1kGkKP-0006nb-3N; Fri, 11 Sep 2020 16:47:05 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     tudor.ambarus@microchip.com, miquel.raynal@bootlin.com,
        richard@nod.at, vigneshr@ti.com,
        sergei.shtylyov@cogentembedded.com, boris.brezillon@collabora.com,
        michael@walle.cc, j.neuschaefer@gmx.net
Cc:     linux-mtd@lists.infradead.org, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] mtd: spi-nor: sst: fix write support for SST_WRITE marked devices
Date:   Fri, 11 Sep 2020 16:47:01 +0200
Message-Id: <20200911144703.25409-2-m.felsch@pengutronix.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200911144703.25409-1-m.felsch@pengutronix.de>
References: <20200911144703.25409-1-m.felsch@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::28
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sst write support for devices using the special SST_WRITE routine
is broken since commit commit df5c21002cf4 ("mtd: spi-nor: use spi-mem
dirmap API") because the spi_nor_create_write_dirmap() function checks
SPINOR_OP_AAI_WP and sst_write_second. These checks are not valid during
probe. The check seems also to be broken since the "op->addr.nbytes = 0"
causes the devm_spi_mem_dirmap_create() function to return
PTR_ERR(-EINVAL) and the probe() function will fail.

It seems that the commit only copy'n'pasted the existing logic. Use the
correct SST_WRITE flag and return 0 to fix both issues.

Fixes: df5c21002cf4 ("mtd: spi-nor: use spi-mem dirmap API")
Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
---
 drivers/mtd/spi-nor/core.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index 65eff4ce6ab1..31869ac245a8 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -3289,15 +3289,21 @@ static int spi_nor_create_write_dirmap(struct spi_nor *nor)
 	};
 	struct spi_mem_op *op = &info.op_tmpl;
 
+	/*
+	 * Most SST SPI-NOR's have a special write routine.which should so
+	 * dirmap.wdesc is not supported for these.
+	 */
+	if (nor->info->flags & SST_WRITE) {
+		nor->dirmap.wdesc = NULL;
+		return 0;
+	}
+
 	/* get transfer protocols. */
 	op->cmd.buswidth = spi_nor_get_protocol_inst_nbits(nor->write_proto);
 	op->addr.buswidth = spi_nor_get_protocol_addr_nbits(nor->write_proto);
 	op->dummy.buswidth = op->addr.buswidth;
 	op->data.buswidth = spi_nor_get_protocol_data_nbits(nor->write_proto);
 
-	if (nor->program_opcode == SPINOR_OP_AAI_WP && nor->sst_write_second)
-		op->addr.nbytes = 0;
-
 	nor->dirmap.wdesc = devm_spi_mem_dirmap_create(nor->dev, nor->spimem,
 						       &info);
 	return PTR_ERR_OR_ZERO(nor->dirmap.wdesc);
-- 
2.20.1

