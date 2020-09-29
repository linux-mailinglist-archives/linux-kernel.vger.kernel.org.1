Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E4D227C1CD
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 12:00:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727963AbgI2KAJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 06:00:09 -0400
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:41943 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727851AbgI2KAC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 06:00:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1601373601; x=1632909601;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PbCfDU0S2s2udnRqZm0ylD87jZbPya712ODwCNDxOrw=;
  b=eZESUqwDV9SrobvCO3JJkmn+zfmr9mXQ8pbu6PIJb7+ScyeyaiqOSB+1
   HpfQ1zXJLeoAmf/z0EMXAG9xUopu+lvP+zHtdtMntcXMO6y1DKfWaByKf
   SFlaF/fAGAHHTD9cIYgKAFnksgfBDacNGtO2FnLHAgYY2gOe1Pnr+bwZc
   cOmIv0E8nio0g4pMrXaNfOryhuwWWy1JkDNMyJEQuQRR1mefY3C9JEeZn
   EYVCSABBF7obE6wqqJkg39fxOLYjibvNdj76Ju+9RdmpYUekFB7fh1yIp
   UOoaUkBKEfP58mG5QXHHpBMfmmOUVCGX1kvqR7+kNuYa9UlAJidXFaDnN
   A==;
IronPort-SDR: SHRISkPzNj7otgVw8fP3mtayUWwfa2zCqYpnxcM9aShRXeOYE7CL7yyaE+9dSybKTlVtMtWwbs
 3SYAoVYoEhMPgXbSA/+/SAOLgiVSlMoFWSTFVRiS/Q+zi5FQShDIeu94vNeu660C42kcMUf7BJ
 R171Toh7cyjsPcIvuHQv+rUChnbDImtyvOqaEuHLG5Q7plTI8YlJw50oWAFq/C+a6WzcPUN2hX
 unABIzFmivIdsh9PBNZlWCrNzDRS6lRwwV195bPZYbKjWBctqYkBvv5wNLW6vodzK3dM325Jyz
 zz8=
X-IronPort-AV: E=Sophos;i="5.77,318,1596524400"; 
   d="scan'208";a="28034382"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 29 Sep 2020 03:00:00 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 29 Sep 2020 03:00:00 -0700
Received: from atudor-ThinkPad-T470p.amer.actel.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Tue, 29 Sep 2020 02:59:49 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <p.yadav@ti.com>, <vigneshr@ti.com>,
        <boris.brezillon@collabora.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        "Tudor Ambarus" <tudor.ambarus@microchip.com>
Subject: [RFC PATCH 3/3] mtd: spi-nor: Parse SFDP SCCR Map
Date:   Tue, 29 Sep 2020 12:59:51 +0300
Message-ID: <20200929095951.1575658-4-tudor.ambarus@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200929095951.1575658-1-tudor.ambarus@microchip.com>
References: <20200916124418.833-1-p.yadav@ti.com>
 <20200929095951.1575658-1-tudor.ambarus@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Parse just the 22nd dword and look for the 'DTR Octal Mode Enable
Volatile bit'.

SPI_NOR_IO_MODE_EN_VOLATILE should be set just for the flashes
that don't define the optional SFDP SCCR Map. For the others,
let the SFDP do its job and fill the SNOR_F_IO_MODE_EN_VOLATILE
flag. We avoid this way polluting the flash flags when declaring
one.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/mtd/spi-nor/sfdp.c | 52 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/drivers/mtd/spi-nor/sfdp.c b/drivers/mtd/spi-nor/sfdp.c
index f192710aca31..7bca64cbba02 100644
--- a/drivers/mtd/spi-nor/sfdp.c
+++ b/drivers/mtd/spi-nor/sfdp.c
@@ -21,6 +21,10 @@
 #define SFDP_SECTOR_MAP_ID	0xff81	/* Sector Map Table */
 #define SFDP_4BAIT_ID		0xff84  /* 4-byte Address Instruction Table */
 #define SFDP_PROFILE1_ID	0xff05	/* xSPI Profile 1.0 table. */
+#define SFDP_SCCR_MAP_ID	0xff87	/*
+					 * Status, Control and Configuration
+					 * Register Map.
+					 */
 
 #define SFDP_SIGNATURE		0x50444653U
 
@@ -1199,6 +1203,50 @@ static int spi_nor_parse_profile1(struct spi_nor *nor,
 	return ret;
 }
 
+#define SCCR_DWORD22_OCTAL_DTR_EN_VOLATILE		BIT(31)
+
+/**
+ * spi_nor_parse_sccr() - Parse the Status, Control and Configuration Register
+ *                        Map.
+ * @nor:		pointer to a 'struct spi_nor'
+ * @sccr_header:	pointer to the 'struct sfdp_parameter_header' describing
+ *			the SCCR Map table length and version.
+ * @params:		pointer to the 'struct spi_nor_flash_parameter' to be.
+ *
+ * Return: 0 on success, -errno otherwise.
+ */
+static int spi_nor_parse_sccr(struct spi_nor *nor,
+			      const struct sfdp_parameter_header *sccr_header,
+			      struct spi_nor_flash_parameter *params)
+{
+	u32 *dwords, addr;
+	size_t len;
+	int ret;
+	u8 io_mode_en_volatile;
+
+	len = sccr_header->length * sizeof(*dwords);
+	dwords = kmalloc(len, GFP_KERNEL);
+	if (!dwords)
+		return -ENOMEM;
+
+	addr = SFDP_PARAM_HEADER_PTP(sccr_header);
+	ret = spi_nor_read_sfdp(nor, addr, len, dwords);
+	if (ret)
+		goto out;
+
+	le32_to_cpu_array(dwords, sccr_header->length);
+
+	io_mode_en_volatile = FIELD_GET(SCCR_DWORD22_OCTAL_DTR_EN_VOLATILE,
+					dwords[22]);
+
+	if (io_mode_en_volatile)
+		nor->flags |= SNOR_F_IO_MODE_EN_VOLATILE;
+
+out:
+	kfree(dwords);
+	return ret;
+}
+
 /**
  * spi_nor_parse_sfdp() - parse the Serial Flash Discoverable Parameters.
  * @nor:		pointer to a 'struct spi_nor'
@@ -1304,6 +1352,10 @@ int spi_nor_parse_sfdp(struct spi_nor *nor,
 			err = spi_nor_parse_profile1(nor, param_header, params);
 			break;
 
+		case SFDP_SCCR_MAP_ID:
+			err = spi_nor_parse_sccr(nor, param_header, params);
+			break;
+
 		default:
 			break;
 		}
-- 
2.25.1

