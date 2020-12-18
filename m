Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F9E32DE3BC
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 15:10:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727336AbgLROKX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Dec 2020 09:10:23 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:58830 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725982AbgLROKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Dec 2020 09:10:22 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0BIE8eL5118734;
        Fri, 18 Dec 2020 08:08:40 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1608300520;
        bh=cOmMPK7N76tH3xpPKjmndbcOnTWOiNkMnvf3dfW0sHE=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=qjJpn8wRe9mzcGbD3LosJuPfNT0uAVgK5FVOoBMswBoApEc1+j7QJcbF9q83QThKG
         KjMFa1ANFzaCPbuSzRTezgmDn+mqF7XGiKBa/nJ0jzpUfSEGI7faBRQ5WkPolALptj
         cN/bFG+3TS8bypoubRR91gORVTfZXszuoz9opIYs=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0BIE8eFW079359
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 18 Dec 2020 08:08:40 -0600
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 18
 Dec 2020 08:08:39 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 18 Dec 2020 08:08:39 -0600
Received: from gsaswath-HP-ProBook-640-G5.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0BIE8HoZ035666;
        Fri, 18 Dec 2020 08:08:35 -0600
From:   Aswath Govindraju <a-govindraju@ti.com>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        Sekhar Nori <nsekhar@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Aswath Govindraju <a-govindraju@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vadym Kochan <vadym.kochan@plvision.eu>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] misc: eeprom_93xx46: Add quirk to support Microchip 93LC46B eeprom
Date:   Fri, 18 Dec 2020 19:38:11 +0530
Message-ID: <20201218140815.9501-3-a-govindraju@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201218140815.9501-1-a-govindraju@ti.com>
References: <20201218140815.9501-1-a-govindraju@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A dummy zero bit is sent preceding the data during a read transfer by the
Microchip 93LC46B eeprom (section 2.7 of[1]). This results in right shift
of data during a read. In order to ignore this bit a quirk can be added to
send an extra zero bit after the read address.

Add a quirk to ignore the zero bit sent before data by adding a zero bit
after the read address.

[1] - https://www.mouser.com/datasheet/2/268/20001749K-277859.pdf

Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
---
 drivers/misc/eeprom/eeprom_93xx46.c | 15 +++++++++++++++
 include/linux/eeprom_93xx46.h       |  2 ++
 2 files changed, 17 insertions(+)

diff --git a/drivers/misc/eeprom/eeprom_93xx46.c b/drivers/misc/eeprom/eeprom_93xx46.c
index 7c45f82b4302..b144e7981f36 100644
--- a/drivers/misc/eeprom/eeprom_93xx46.c
+++ b/drivers/misc/eeprom/eeprom_93xx46.c
@@ -35,6 +35,10 @@ static const struct eeprom_93xx46_devtype_data atmel_at93c46d_data = {
 		  EEPROM_93XX46_QUIRK_INSTRUCTION_LENGTH,
 };
 
+static const struct eeprom_93xx46_devtype_data microchip_93LC46B_data = {
+	.quirks = EEPROM_93XX46_QUIRK_EXTRA_READ_CYCLE,
+};
+
 struct eeprom_93xx46_dev {
 	struct spi_device *spi;
 	struct eeprom_93xx46_platform_data *pdata;
@@ -55,6 +59,11 @@ static inline bool has_quirk_instruction_length(struct eeprom_93xx46_dev *edev)
 	return edev->pdata->quirks & EEPROM_93XX46_QUIRK_INSTRUCTION_LENGTH;
 }
 
+static inline bool has_quirk_extra_read_cycle(struct eeprom_93xx46_dev *edev)
+{
+	return edev->pdata->quirks & EEPROM_93XX46_QUIRK_EXTRA_READ_CYCLE;
+}
+
 static int eeprom_93xx46_read(void *priv, unsigned int off,
 			      void *val, size_t count)
 {
@@ -96,6 +105,11 @@ static int eeprom_93xx46_read(void *priv, unsigned int off,
 		dev_dbg(&edev->spi->dev, "read cmd 0x%x, %d Hz\n",
 			cmd_addr, edev->spi->max_speed_hz);
 
+		if (has_quirk_extra_read_cycle(edev)) {
+			cmd_addr <<= 1;
+			bits += 1;
+		}
+
 		spi_message_init(&m);
 
 		t[0].tx_buf = (char *)&cmd_addr;
@@ -363,6 +377,7 @@ static void select_deassert(void *context)
 static const struct of_device_id eeprom_93xx46_of_table[] = {
 	{ .compatible = "eeprom-93xx46", },
 	{ .compatible = "atmel,at93c46d", .data = &atmel_at93c46d_data, },
+	{ .compatible = "microchip,93LC46B", .data = &microchip_93LC46B_data, },
 	{}
 };
 MODULE_DEVICE_TABLE(of, eeprom_93xx46_of_table);
diff --git a/include/linux/eeprom_93xx46.h b/include/linux/eeprom_93xx46.h
index eec7928ff8fe..99580c22f91a 100644
--- a/include/linux/eeprom_93xx46.h
+++ b/include/linux/eeprom_93xx46.h
@@ -16,6 +16,8 @@ struct eeprom_93xx46_platform_data {
 #define EEPROM_93XX46_QUIRK_SINGLE_WORD_READ		(1 << 0)
 /* Instructions such as EWEN are (addrlen + 2) in length. */
 #define EEPROM_93XX46_QUIRK_INSTRUCTION_LENGTH		(1 << 1)
+/* Add extra cycle after address during a read */
+#define EEPROM_93XX46_QUIRK_EXTRA_READ_CYCLE		BIT(2)
 
 	/*
 	 * optional hooks to control additional logic
-- 
2.17.1

