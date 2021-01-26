Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6B7D3043DC
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 17:29:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392915AbhAZQ2c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 11:28:32 -0500
Received: from smtp.asem.it ([151.1.184.197]:52086 "EHLO smtp.asem.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390984AbhAZJ1w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 04:27:52 -0500
Received: from webmail.asem.it
        by asem.it (smtp.asem.it)
        (SecurityGateway 6.5.2)
        with ESMTP id SG000732223.MSG 
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 10:25:20 +0100S
Received: from ASAS044.asem.intra (172.16.16.44) by ASAS044.asem.intra
 (172.16.16.44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 26
 Jan 2021 10:25:18 +0100
Received: from flavio-x.asem.intra (172.16.17.208) by ASAS044.asem.intra
 (172.16.16.44) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Tue, 26 Jan 2021 10:25:18 +0100
From:   Flavio Suligoi <f.suligoi@asem.it>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Jonathan Neuschaefer <j.neuschaefer@gmx.net>
CC:     <linux-mtd@lists.infradead.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Flavio Suligoi <f.suligoi@asem.it>
Subject: [PATCH v1] mtd: spi-nor: core: fix/remove references to spi-nor.c
Date:   Tue, 26 Jan 2021 10:25:16 +0100
Message-ID: <20210126092516.1431913-1-f.suligoi@asem.it>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-SGHeloLookup-Result: pass smtp.helo=webmail.asem.it (ip=172.16.16.44)
X-SGSPF-Result: none (smtp.asem.it)
X-SGOP-RefID: str=0001.0A782F22.600FDFFF.0009,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0 (_st=1 _vt=0 _iwf=0)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The old file:

drivers/mtd/spi-nor/spi-nor.c

is not more present and now some of its code is
contained in:

drivers/mtd/spi-nor/core.c

This patch fix/remove the references to the old
spi-nor.c file.

Signed-off-by: Flavio Suligoi <f.suligoi@asem.it>
---
 Documentation/driver-api/mtd/spi-nor.rst | 2 +-
 drivers/mtd/spi-nor/core.c               | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/driver-api/mtd/spi-nor.rst b/Documentation/driver-api/mtd/spi-nor.rst
index 4a3adca417fd..bf2db371d3fb 100644
--- a/Documentation/driver-api/mtd/spi-nor.rst
+++ b/Documentation/driver-api/mtd/spi-nor.rst
@@ -61,7 +61,7 @@ Part III - How can drivers use the framework?
 
 The main API is spi_nor_scan(). Before you call the hook, a driver should
 initialize the necessary fields for spi_nor{}. Please see
-drivers/mtd/spi-nor/spi-nor.c for detail. Please also refer to spi-fsl-qspi.c
+drivers/mtd/spi-nor/core.c for detail. Please also refer to spi-fsl-qspi.c
 when you want to write a new driver for a SPI NOR controller.
 Another API is spi_nor_restore(), this is used to restore the status of SPI
 flash chip such as addressing mode. Call it whenever detach the driver from
diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index 20df44b753da..6ae7d4c2d2b6 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -3701,8 +3701,8 @@ static void spi_nor_shutdown(struct spi_mem *spimem)
  * encourage new users to add support to the spi-nor library, and simply bind
  * against a generic string here (e.g., "jedec,spi-nor").
  *
- * Many flash names are kept here in this list (as well as in spi-nor.c) to
- * keep them available as module aliases for existing platforms.
+ * Many flash names are kept here in this list to keep them available
+ * as module aliases for existing platforms.
  */
 static const struct spi_device_id spi_nor_dev_ids[] = {
 	/*
-- 
2.25.1

