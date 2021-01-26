Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 451F330409B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 15:41:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391528AbhAZOjm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 09:39:42 -0500
Received: from smtp.asem.it ([151.1.184.197]:64868 "EHLO smtp.asem.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405924AbhAZOie (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 09:38:34 -0500
Received: from webmail.asem.it
        by asem.it (smtp.asem.it)
        (SecurityGateway 6.5.2)
        with ESMTP id SG000733461.MSG 
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 15:37:50 +0100S
Received: from ASAS044.asem.intra (172.16.16.44) by ASAS044.asem.intra
 (172.16.16.44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 26
 Jan 2021 15:37:50 +0100
Received: from flavio-x.asem.intra (172.16.17.208) by ASAS044.asem.intra
 (172.16.16.44) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Tue, 26 Jan 2021 15:37:50 +0100
From:   Flavio Suligoi <f.suligoi@asem.it>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Flavio Suligoi <f.suligoi@asem.it>
Subject: [PATCH v1] mtd: spi-nor: add ACPI support for non-JEDEC SPI-NOR
Date:   Tue, 26 Jan 2021 15:37:48 +0100
Message-ID: <20210126143748.1546187-1-f.suligoi@asem.it>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-SGHeloLookup-Result: pass smtp.helo=webmail.asem.it (ip=172.16.16.44)
X-SGSPF-Result: none (smtp.asem.it)
X-SGOP-RefID: str=0001.0A782F15.6010293E.00A0,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0 (_st=1 _vt=0 _iwf=0)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In a x86 machine, an additional device can be described
inside the BIOS ACPI tables.
For example, an I2C GPIO expander, a LED, etc.,
can be successfully declared in ACPI, so that the related
device driver can start automatically at the boot.

But for the SPI NOR devices, the ACPI description works
for JEDEC-compatible devices only.

For example, an Everspin MR25H40 MRAM device (non-JEDEC
compatible), declared using the following table,
does not work:

    Scope (\_SB.SPI1)
    {
        Device (NVR0)
        {
            Name (_HID, "PRP0001")
            Name (_DDN, "Everspin MR25H40 MRAM")
            Name (_CRS, ResourceTemplate () {
                SpiSerialBus (
                1,                      // Chip select
                PolarityLow,            // Chip select is active low
                FourWireMode,           // Full duplex
                8,                      // Bits per word is 8 (byte)
                ControllerInitiated,    // Don't care
                10000000,               // 10 MHz
                ClockPolarityLow,       // SPI mode 0 ClockPolarityLow
                ClockPhaseFirst,        // SPI mode 0 ClockPhaseFirst
                "\\_SB.SPI1",           // SPI host controller
                0,                      // Must be 0
                ResourceConsumer,
                ,
                )
            })

            Name (_DSD, Package () {
                ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
                Package () {
                    Package () {"compatible", "mr25h40"},
                }
            })
        }
    }

To enable the detection of a non-JEDEC device described
in a BIOS ACPI table, it is necessary to add its id name
in the spi_nor_of_table structure.
With this change, all the SPI NOR devices (JEDEC and
non-JEDEC) can be detected by the kernel (and the above
example of ACPI table finally works).

Signed-off-by: Flavio Suligoi <f.suligoi@asem.it>
---
 drivers/mtd/spi-nor/core.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index 6ae7d4c2d2b6..b6fb8b15c439 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -3755,6 +3755,19 @@ static const struct of_device_id spi_nor_of_table[] = {
 	 * JEDEC READ ID opcode (0x9F). Use this, if possible.
 	 */
 	{ .compatible = "jedec,spi-nor" },
+	{ .compatible = "m25p05-nonjedec" },
+	{ .compatible = "m25p10-nonjedec" },
+	{ .compatible = "m25p20-nonjedec" },
+	{ .compatible = "m25p40-nonjedec" },
+	{ .compatible = "m25p80-nonjedec" },
+	{ .compatible = "m25p16-nonjedec" },
+	{ .compatible = "m25p32-nonjedec" },
+	{ .compatible = "m25p64-nonjedec" },
+	{ .compatible = "m25p128-nonjedec" },
+	{ .compatible = "mr25h128" },
+	{ .compatible = "mr25h256" },
+	{ .compatible = "mr25h10" },
+	{ .compatible = "mr25h40" },
 	{ /* sentinel */ },
 };
 MODULE_DEVICE_TABLE(of, spi_nor_of_table);
-- 
2.25.1

