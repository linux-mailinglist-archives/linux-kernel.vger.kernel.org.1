Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 407A72D4873
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 19:00:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730210AbgLIR6g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 12:58:36 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:56360 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725972AbgLIR6W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 12:58:22 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0B9HvPea044251;
        Wed, 9 Dec 2020 11:57:25 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1607536645;
        bh=xSo6kkY/WAzvZWiG0QrjkyrBLPDwYGU9Z/gfY9LWwv8=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=s392Hq/6ukwNSrUVi9G49fjRFR+pNSTDUbKofRr6tEUIBBNhHF4cVFRp8rPq0RP7R
         bdGIot+bNVYMOr1TDWsU3l7XW0LyDknmRbMgG7cb/LAuL7Ukx2O7pwfGZG6xb3CLKB
         XQc3ROtdG7If/mYD8W3sa5FrCnEiA//hfEylYFqU=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0B9HvPTc088842
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 9 Dec 2020 11:57:25 -0600
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 9 Dec
 2020 11:57:24 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 9 Dec 2020 11:57:24 -0600
Received: from gsaswath-HP-ProBook-640-G5.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0B9HvATH094634;
        Wed, 9 Dec 2020 11:57:21 -0600
From:   Aswath Govindraju <a-govindraju@ti.com>
CC:     Rob Herring <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vadym Kochan <vadym.kochan@plvision.eu>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Sekhar Nori <nsekhar@ti.com>,
        Aswath Govindraju <a-govindraju@ti.com>
Subject: [PATCH RFC 2/2] eeprom: eeprom_93xx46: Add support for ignoring the dummy bit preceding data during read transfer
Date:   Wed, 9 Dec 2020 23:27:08 +0530
Message-ID: <20201209175708.16252-3-a-govindraju@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201209175708.16252-1-a-govindraju@ti.com>
References: <20201209175708.16252-1-a-govindraju@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A dummy zero bit is sent by eeprom preceding the data of every read
transfer. This results in right shift of data during a read. In order to
ignore the dummy bits preceding the data, extra zero bits are transferred
after the read address.

This feature can be added by including the property read-op-dummy-cycles
with the number of zero bits to be transferred as the value, in device tree
node.

Fix read by sending extra zero bits after the read address to ignore the
zero bits sent by eeprom before data.

Suggested-by: Vignesh Raghavendra <vigneshr@ti.com>
Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
---
 drivers/misc/eeprom/eeprom_93xx46.c | 23 +++++++++++++++++++++++
 include/linux/eeprom_93xx46.h       |  6 ++++++
 2 files changed, 29 insertions(+)

diff --git a/drivers/misc/eeprom/eeprom_93xx46.c b/drivers/misc/eeprom/eeprom_93xx46.c
index 7c45f82b4302..e778ae54a6f1 100644
--- a/drivers/misc/eeprom/eeprom_93xx46.c
+++ b/drivers/misc/eeprom/eeprom_93xx46.c
@@ -55,6 +55,16 @@ static inline bool has_quirk_instruction_length(struct eeprom_93xx46_dev *edev)
 	return edev->pdata->quirks & EEPROM_93XX46_QUIRK_INSTRUCTION_LENGTH;
 }
 
+static inline bool needs_extra_read_cycle(struct eeprom_93xx46_dev *edev)
+{
+	return edev->pdata->flags & EE_EXTRA_CYCLE_READ;
+}
+
+static inline u32 get_read_op_dummy_cycles(struct eeprom_93xx46_dev *edev)
+{
+	return edev->pdata->read_op_dummy_cycles;
+}
+
 static int eeprom_93xx46_read(void *priv, unsigned int off,
 			      void *val, size_t count)
 {
@@ -80,6 +90,7 @@ static int eeprom_93xx46_read(void *priv, unsigned int off,
 		u16 cmd_addr = OP_READ << edev->addrlen;
 		size_t nbytes = count;
 		int bits;
+		u32 read_op_dummy_cycles;
 
 		if (edev->addrlen == 7) {
 			cmd_addr |= off & 0x7f;
@@ -93,6 +104,12 @@ static int eeprom_93xx46_read(void *priv, unsigned int off,
 				nbytes = 2;
 		}
 
+		if (needs_extra_read_cycle(edev)) {
+			read_op_dummy_cycles = get_read_op_dummy_cycles(edev);
+			cmd_addr = cmd_addr << read_op_dummy_cycles;
+			bits += read_op_dummy_cycles;
+		}
+
 		dev_dbg(&edev->spi->dev, "read cmd 0x%x, %d Hz\n",
 			cmd_addr, edev->spi->max_speed_hz);
 
@@ -398,6 +415,12 @@ static int eeprom_93xx46_probe_dt(struct spi_device *spi)
 	if (of_property_read_bool(np, "read-only"))
 		pd->flags |= EE_READONLY;
 
+	ret = of_property_read_u32(np, "read-op-dummy-cycles", &tmp);
+	if (ret == 0) {
+		pd->flags |= EE_EXTRA_CYCLE_READ;
+		pd->read_op_dummy_cycles = tmp;
+	}
+
 	pd->select = devm_gpiod_get_optional(&spi->dev, "select",
 					     GPIOD_OUT_LOW);
 	if (IS_ERR(pd->select))
diff --git a/include/linux/eeprom_93xx46.h b/include/linux/eeprom_93xx46.h
index eec7928ff8fe..f0d37e921aba 100644
--- a/include/linux/eeprom_93xx46.h
+++ b/include/linux/eeprom_93xx46.h
@@ -11,6 +11,12 @@ struct eeprom_93xx46_platform_data {
 #define EE_ADDR16	0x02		/* 16 bit addr. cfg */
 #define EE_READONLY	0x08		/* forbid writing */
 
+/* Add extra zero bits of data after the address during read transfer
+ * to ignore the dummy bits sent before data
+ */
+#define EE_EXTRA_CYCLE_READ 0x04
+	u32 read_op_dummy_cycles;
+
 	unsigned int	quirks;
 /* Single word read transfers only; no sequential read. */
 #define EEPROM_93XX46_QUIRK_SINGLE_WORD_READ		(1 << 0)
-- 
2.17.1

