Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12F722A4058
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 10:33:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727906AbgKCJdU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 04:33:20 -0500
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:58144 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727895AbgKCJdQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 04:33:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1604395996; x=1635931996;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=HlIb1TDqPqPTkeLT43BZ/oxQ5DQ4JwFhlTX3cQe6Ppk=;
  b=zv2YBFox+yKOKZKn5TL00MSXBVvEZ+gkftI6HfdRZY+esLWj7LYtf82G
   e3NQcje+zG/ZMLyr6wqjIh81yaMcC/gioyZ6s9M/nkHiyCizWdbaRHvaH
   JdFFHJxoSVKBHeWPMvyThYG8dYwY9ul1H1X7Ib1uVjClNGgNpuY48uOIf
   JYAwLL/oCheQIlIBQghohQtQmNlgVhCewW9g3sDC4oKGCtilBjpPX+MkE
   SgE1sok00ka2jU9oKR3qsTBKAE4u9vorri4JSBSBodUdZs1cDBTSbhusN
   xFjtjgPs7x8eV5GCqYwrxJIe76nyRsFyzrCqbq+sKOuyDI80ZegRVD5lv
   w==;
IronPort-SDR: 43h/BbcwN+gHozNy93mKsMGDEchoXmVDj9BqQI6KEzuxQVMQAdl6zblSUbShWgXYMGvgdYu7hd
 JBadLSBwSH7ChW1KdusnXAga3Jd8eT5AKf32Ywlbz6cbBGky5dE0KHYzDdn8BEQ5spY7GmAdeV
 mdk6eUW7nKOBW1J2WZGyfP6d03RXNQn6pDWSw6BPXdi0V4138b+a43R8JuP5r5KfdQKGAWLk8Z
 1CDCp2kwj2eX8HK+yC66Ixjjei+se4LmtbCFUUjnNj/oucy1tNPFRuBmQ0gOC13yMSqZWHyeA6
 nCQ=
X-IronPort-AV: E=Sophos;i="5.77,447,1596524400"; 
   d="scan'208";a="94873908"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 03 Nov 2020 02:33:15 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 3 Nov 2020 02:33:15 -0700
Received: from rob-ult-m19940.amer.actel.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Tue, 3 Nov 2020 02:33:12 -0700
From:   Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
To:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <radu_nicolae.pirea@upb.ro>, <lee.jones@linaro.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>,
        Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Subject: [PATCH] mfd: at91-usart: do not use compatible to register child devices
Date:   Tue, 3 Nov 2020 11:32:46 +0200
Message-ID: <20201103093246.1288956-1-codrin.ciubotariu@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are no separate serial/SPI devices under the at91-usart MFD, but
actually the MFD is used as a serial or a SPI device. There are no DT
sub-nodes for the MFD children, so we should use platform device API to
register the drivers.

Suggested-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
---
 drivers/mfd/at91-usart.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/mfd/at91-usart.c b/drivers/mfd/at91-usart.c
index 6a8351a4588e..7f08cb60c58b 100644
--- a/drivers/mfd/at91-usart.c
+++ b/drivers/mfd/at91-usart.c
@@ -15,15 +15,11 @@
 #include <linux/of.h>
 #include <linux/property.h>
 
-static const struct mfd_cell at91_usart_spi_subdev = {
-	.name = "at91_usart_spi",
-	.of_compatible = "microchip,at91sam9g45-usart-spi",
-};
+static const struct mfd_cell at91_usart_spi_subdev =
+	MFD_CELL_NAME("at91_usart_spi");
 
-static const struct mfd_cell at91_usart_serial_subdev = {
-	.name = "atmel_usart_serial",
-	.of_compatible = "atmel,at91rm9200-usart-serial",
-};
+static const struct mfd_cell at91_usart_serial_subdev =
+	MFD_CELL_NAME("atmel_usart_serial");
 
 static int at91_usart_mode_probe(struct platform_device *pdev)
 {
-- 
2.25.1

