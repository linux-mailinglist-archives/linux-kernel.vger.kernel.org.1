Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CDB11D94A5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 May 2020 12:46:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728824AbgESKqx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 May 2020 06:46:53 -0400
Received: from mail-eopbgr690040.outbound.protection.outlook.com ([40.107.69.40]:62341
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728803AbgESKqv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 06:46:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BYTFo5yobr2jxyQOGWgO7WxpSBHfbYTixXjB8BZz/rbhZ9FdKmw0FnCMfkvUUhu0SE5McFOYIXYPZYfynV1kz/oiDfJW2gvQGgfmSfW7b749eRmQ324T4/YPkC+PA9XsMLrGjeF3KzSG6Cn03oFY+IBoC2C7SVfm11pQEX1cEMxVvGw0F69zcTJ6qAGZKl07YNqNVFSMWVypIj/Pzr7O7NMqnWDAx95FSwAw+bue9475lAxRGzIsADt0sSCNPgUF3qOIaCLUJLraTrEiUO2sZuDd68rBf2o5RsxNgyTY4KOzAjno+Ymin7k17L5X//ufwzmVKyBoqjT+XMhaG0F0AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=taJio7gOvTsJJGhtfvqPWsCYQMjvrOv4oUA34CME/SY=;
 b=Pn5lquQzJzq+xIJMQZlxPjYOhQbvcTYGGlvnzXaDa/B5O6udSV0ft989Wcy0g1mZyqEep2E9gAtDMiOJm9BZoUyu+AaQMSzvjRqAsIy685lgKaK1ZEYmeTBMlDusrh6mVohPnchriGMAlPXnPbeoKjaFcY4rRtPPRt2X/6CXQc4UFZoMbfQV9wOCBuCIz6G0x6M6V6IwuN6YmwyWoYZrLyy8yNIYIzu+s7EXTPdir0Y9BXe/of3ZxZjhFXAjZwV7LwgzoRNfl6nAQR9Z73sh49mylxYup3Z9EbJ3JwMxGifgjPCA3+1+/eb5nyxvbgk8waO6rBN6YHByXv3t8gkJXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sifive.com; dmarc=pass action=none header.from=sifive.com;
 dkim=pass header.d=sifive.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=taJio7gOvTsJJGhtfvqPWsCYQMjvrOv4oUA34CME/SY=;
 b=jV0SuSnUiixX0PnAuuHxgivuK9RoxGnVlZjVX164ELpbsWsJkYu2vy8yzNV4YT3zilGOSBjO57Da3FDAbNa/efOocAsQVlipef1mbU/sKLQKiqI6KS/3l+O8NufsRGB/vhEKk3kYn5/IzB35k0coZ5399pl5RlLq47NWNYWZuz0=
Authentication-Results: lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=none action=none
 header.from=sifive.com;
Received: from DM6PR13MB2619.namprd13.prod.outlook.com (2603:10b6:5:140::13)
 by DM6PR13MB3882.namprd13.prod.outlook.com (2603:10b6:5:22a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.11; Tue, 19 May
 2020 10:46:49 +0000
Received: from DM6PR13MB2619.namprd13.prod.outlook.com
 ([fe80::ad23:dfbe:7ec:e5ca]) by DM6PR13MB2619.namprd13.prod.outlook.com
 ([fe80::ad23:dfbe:7ec:e5ca%3]) with mapi id 15.20.3000.015; Tue, 19 May 2020
 10:46:49 +0000
From:   Sagar Shrikant Kadam <sagar.kadam@sifive.com>
To:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org
Cc:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, tudor.ambarus@microchip.com,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        anup.patel@wdc.com, Sagar Shrikant Kadam <sagar.kadam@sifive.com>
Subject: [PATCH v2 2/2] spi: nor: update page program settings for is25wp256 using post bfpt fixup
Date:   Tue, 19 May 2020 03:46:27 -0700
Message-Id: <1589885187-31247-3-git-send-email-sagar.kadam@sifive.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1589885187-31247-1-git-send-email-sagar.kadam@sifive.com>
References: <1589885187-31247-1-git-send-email-sagar.kadam@sifive.com>
Content-Type: text/plain
X-ClientProxiedBy: BYAPR05CA0073.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::14) To DM6PR13MB2619.namprd13.prod.outlook.com
 (2603:10b6:5:140::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from gamma07.internal.sifive.com (64.62.193.194) by BYAPR05CA0073.namprd05.prod.outlook.com (2603:10b6:a03:e0::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3021.10 via Frontend Transport; Tue, 19 May 2020 10:46:48 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [64.62.193.194]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8fca7df9-6276-40b5-43d3-08d7fbe1ef10
X-MS-TrafficTypeDiagnostic: DM6PR13MB3882:
X-LD-Processed: 22f88e9d-ae0d-4ed9-b984-cdc9be1529f1,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR13MB388254F4C3147B3675D3531B99B90@DM6PR13MB3882.namprd13.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 040866B734
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w21PMl9kqBwji1R4eo8OISA8ooMQaPOniDEXc7VYhKEu/MSWOlfPEz2FgY2SegG5pWVQFoBdWEYx6JQA0/bdjwA8ZRcmwaRjb0END2Kz3CaLPEYuOf+rgJeh3wGiu53bubwj4EhJ+ngy9BDzl4UNvFAdYPj1UW1nHfR+axsaw+K5AT0mAXWkEVZ8MYVJ6AZZSR5zXV9B72B9q1PFdFboLyorVmZVOaOTwf8/OYtQN+Qa5YxB0tb7FaX6Ww7HUHJ64oozVAnHGSPoVzJea6olEl+KDRY0CCYhKak9BvMTIrOif28tAhHGkEGfBXFf9stxJIR4Gp87Szk4C1rD+nYExo0POSXufSEO9jn86br7+D/ExdrgkpQ4W8xunY7NDO1JZkzwrlKteLk0GDI+0D98DgYd13Ce8XRErWckRIqOy93ikvVisKOOEpplwud9Kmme
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR13MB2619.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(136003)(346002)(396003)(39850400004)(376002)(366004)(7416002)(4326008)(86362001)(6666004)(66946007)(66556008)(66476007)(316002)(15650500001)(5660300002)(107886003)(36756003)(2906002)(26005)(6486002)(52116002)(16526019)(2616005)(7696005)(956004)(8936002)(8676002)(186003)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: puOP+nWJtJfeAbj3VcwH47THkAFXg04j8P+5FwMxMf7zjwHHEmgz0fFDwIGGagbf9pIbAgmTLMaHy1AQtS7txQPYfEBuD+kdiLnEO60VcrtH0EfDTHlOYo6cZl/sP2+hrRN4PHV1WTlxfsTz6n9+XacvmzxOzZ8Vr8aJJ/Gn6/lfVORUyVWX+h4gf7JkJZeW1vEvLWBkLagmLUuqqwXV+jDD0d9JRhoaLvbEcf0m6mfk0XNmzZcR+GDiD56sSDXb1LS3/nkPCN7JXkQVLr/sKo+Q5O3/MLACJr0lu/H4lL7BCCQAc6LpjugwkImckE6G7nI64o4svXU68TEQT9rTvWcp76C8lvhUZFVxz7eMl0OT+1mdBrcSk+QrUuklmTMZo3lKfdUTUaK9875hnwHk8HTMvVpS04EJyTFuYzsa/H7eaRXNcIWDnEe11RnkljH8JJB3MqLgN92hZNdCTaWvRrLpEgeI5pXXRo4TlfObMAw=
X-OriginatorOrg: sifive.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fca7df9-6276-40b5-43d3-08d7fbe1ef10
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2020 10:46:49.4417
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 22f88e9d-ae0d-4ed9-b984-cdc9be1529f1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZdmY5uRjTKv0fyj7yna2O5dMj9tGyzL7HfHBLhCL8eZ+FZQQsE+L/YqnGiEtP4dubqUHs9qdjq+nM7r/12cnOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR13MB3882
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make a generic post_bfpt fixup handler which uses part specific fixup's
based on device id, as done here for is25lp256 and is25wp256 devices.

During SFDP parsing it is seen that the IS25WP256d device is missing 4BAIT
(4-Byte address instruction table), due to which it's page program
capacity doesn't get correctly populated and the device gets configured
with 4-byte Address Serial Input Page Program i.e. SNOR_PROTO_1_1_1
even though it can work with SNOR_PROTO_1_1_4.

Here using the post bfpt fixup hooks we update the page program
settings to 4-byte QUAD Input Page program operations.

The patch is tested on HiFive Unleashed A00 board and it benefits
few seconds of average write time for entire flash write.

QUAD Input Page Program operations:
> time mtd_debug write /dev/mtd0 0 33554432 rd32M
Copied 33554432 bytes from rd32M to address 0x00000000 in flash
real    0m 35.23s
user    0m 0.00s
sys     0m 23.97s

Serial Input Page Program operations:
> time mtd_debug write /dev/mtd0 0 33554432 rd32M
Copied 33554432 bytes from rd32M to address 0x00000000 in flash
real    0m 39.25s
user    0m 0.00s
sys     0m 27.93s

Signed-off-by: Sagar Shrikant Kadam <sagar.kadam@sifive.com>
---
 drivers/mtd/spi-nor/issi.c | 72 ++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 60 insertions(+), 12 deletions(-)

diff --git a/drivers/mtd/spi-nor/issi.c b/drivers/mtd/spi-nor/issi.c
index ffcb60e..efa0fe7 100644
--- a/drivers/mtd/spi-nor/issi.c
+++ b/drivers/mtd/spi-nor/issi.c
@@ -8,26 +8,74 @@
 
 #include "core.h"
 
-static int
-is25lp256_post_bfpt_fixups(struct spi_nor *nor,
-			   const struct sfdp_parameter_header *bfpt_header,
-			   const struct sfdp_bfpt *bfpt,
-			   struct spi_nor_flash_parameter *params)
+static int issi_fix_addr_width(struct spi_nor *nor,
+			       const struct sfdp_bfpt *bfpt)
 {
 	/*
-	 * IS25LP256 supports 4B opcodes, but the BFPT advertises a
+	 * If device supports 4B opcodes, but the BFPT advertises a
 	 * BFPT_DWORD1_ADDRESS_BYTES_3_ONLY address width.
 	 * Overwrite the address width advertised by the BFPT.
 	 */
-	if ((bfpt->dwords[BFPT_DWORD(1)] & BFPT_DWORD1_ADDRESS_BYTES_MASK) ==
-		BFPT_DWORD1_ADDRESS_BYTES_3_ONLY)
+	if ((bfpt->dwords[BFPT_DWORD(1)] & BFPT_DWORD1_ADDRESS_BYTES_MASK)
+		== BFPT_DWORD1_ADDRESS_BYTES_3_ONLY)
 		nor->addr_width = 4;
 
 	return 0;
 }
 
-static struct spi_nor_fixups is25lp256_fixups = {
-	.post_bfpt = is25lp256_post_bfpt_fixups,
+static int issi_update_proto(struct spi_nor *nor,
+			     struct spi_nor_flash_parameter *params)
+{
+	/*
+	 * For a device whose 4-Byte address instruction table doesn't
+	 * get populated and the device get's configured with 4-byte
+	 * Address Serial Input Page Program i.e. SNOR_PROTO_1_1_1 even
+	 * though it supports SNOR_PROTO_1_1_4, so priorotize QUAD write
+	 * over SINGLE write if device id table holds SPI_NOR_QUAD_READ.
+	 */
+	if (nor->info->flags & SPI_NOR_QUAD_READ) {
+		params->hwcaps.mask |= SNOR_HWCAPS_PP_1_1_4;
+		spi_nor_set_pp_settings
+			(&params->page_programs[SNOR_CMD_PP_1_1_4],
+			 SPINOR_OP_PP_1_1_4,
+			 SNOR_PROTO_1_1_4);
+	}
+
+	return 0;
+}
+
+static int
+issi_post_bfpt_fixups(struct spi_nor *nor,
+		      const struct sfdp_parameter_header *bfpt_header,
+		      const struct sfdp_bfpt *bfpt,
+		      struct spi_nor_flash_parameter *params)
+{
+	long deviceid;
+
+	deviceid = (nor->info->id[1] << 8 | nor->info->id[2]);
+
+	/* As this is for same MFR i.e ISSI, just check the device ID's */
+	switch (deviceid) {
+	case 0x6019:
+		/* is25lp256 */
+		issi_fix_addr_width(nor, bfpt);
+		break;
+
+	case 0x7019:
+		/* is25wp256 */
+		issi_fix_addr_width(nor, bfpt);
+		issi_update_proto(nor, params);
+		break;
+
+	default:
+		break;
+	}
+
+	return 0;
+}
+
+static struct spi_nor_fixups is25_fixups = {
+	.post_bfpt = issi_post_bfpt_fixups,
 };
 
 static const struct flash_info issi_parts[] = {
@@ -48,7 +96,7 @@ static const struct flash_info issi_parts[] = {
 	{ "is25lp256",  INFO(0x9d6019, 0, 64 * 1024, 512,
 			     SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
 			     SPI_NOR_4B_OPCODES)
-		.fixups = &is25lp256_fixups },
+		.fixups = &is25_fixups },
 	{ "is25wp032",  INFO(0x9d7016, 0, 64 * 1024,  64,
 			     SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
 	{ "is25wp064",  INFO(0x9d7017, 0, 64 * 1024, 128,
@@ -58,7 +106,7 @@ static const struct flash_info issi_parts[] = {
 	{ "is25wp256", INFO(0x9d7019, 0, 64 * 1024, 512,
 			    SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
 			    SPI_NOR_4B_OPCODES)
-		.fixups = &is25lp256_fixups },
+		.fixups = &is25_fixups },
 
 	/* PMC */
 	{ "pm25lv512",   INFO(0,        0, 32 * 1024,    2, SECT_4K_PMC) },
-- 
2.7.4

