Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B542327C1CC
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 12:00:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727856AbgI2KAC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 06:00:02 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:32824 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725535AbgI2J77 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 05:59:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1601373599; x=1632909599;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Cu69HIcgGSdlgNuwF6Hj+SbTIxuPhxtas1dOTY7FDXA=;
  b=ViP5tDhrKy8ywAi+Hl0MLiHwQ8mlZ43bp6Juj61ddHI6ilAolPI8KuUA
   Ky9+KbpZTnB+nl8GzU9LioaTuC5NhjFnBMabcpDlswXxpv3ZNb/ya4re6
   udiHh/N126SBXTge8kb1g93xOH3Aekcd+FD/I0wdkyDOSgu+8GcuHnMQt
   /UpZi+G1NIp1bAIdfX8XXm4YbUbmbxFkfRQp7N7SDF3aWc3ybT4VRjA3/
   9mFOMsFsL6OMtV78wOmG79xeCDcHLmPG6sZ88pE46B6Q9D5NrXFIkgl31
   zWvY0dwzlp3p7VScCpub2Sgb1PQsXV3BYj1zcJ6Fw8WL7tS2QqNitoQOY
   g==;
IronPort-SDR: j4sKAl3FTdf4+QbHv7XYJHwqRp08gLHFmKENBn3POez2WgR5k1TBd8Kh5XEfCUOhCFsuztG+YR
 jDX53CUGHQ3v/rKaoxKkljujYXwrh0AqtQAQvwHegqICdKFMuBkE9t6TY6rHH//+5dWPYsufHw
 vvKJjtrLcfxtb+COOXLXom8AquanXMUZMrXkeHLqiZeValMn0rDZkx7ebiepEmaWtoL1X9fK/j
 QDQf3I1rPx96aYEPNYWuI1ngf9NOuVm4rRhKTseSnCl3KM/PuUWqTYVcepcN9Ln0iPIKkai1tq
 jjM=
X-IronPort-AV: E=Sophos;i="5.77,318,1596524400"; 
   d="scan'208";a="92761633"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 29 Sep 2020 02:59:59 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 29 Sep 2020 02:59:49 -0700
Received: from atudor-ThinkPad-T470p.amer.actel.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Tue, 29 Sep 2020 02:59:47 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <p.yadav@ti.com>, <vigneshr@ti.com>,
        <boris.brezillon@collabora.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        "Tudor Ambarus" <tudor.ambarus@microchip.com>
Subject: [RFC PATCH 2/3] mtd: spi-nor: Introduce MTD_SPI_NOR_ALLOW_STATEFUL_MODES
Date:   Tue, 29 Sep 2020 12:59:50 +0300
Message-ID: <20200929095951.1575658-3-tudor.ambarus@microchip.com>
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

Some users may teach their bootloaders to discover and recover a
flash even when left in a statefull mode (a X-X-X I/O mode that is
configured via a non-volatile bit).

Provide a way for those users to enter in stateful modes. A reset
or a crash will leave the flash in full I/O mode and if the bootloader
does not know how to recover, the SPI NOR boot will be broken.

Flashes that will enable stateful modes will be accepted only if a
hook to recover from the stateful mode is provided in the kernel.
With this, even if a user will break its SPI NOR boot, it'll be able
to recover the flash at the kernel level (on those systems that have
at least another boot media). Both the Kconfig and the acceptance
restriction are needed, so that we don't end up completely hopeless
and look at a flash for which there is no software to discover and
recover the flash. Even if we can recover the flash from a stateful
mode in kernel, entering the stateful mode is still dangerous if one's
bootloader can't handle it. We need a way to pass the responsibility
to the user and let him decide conciously about the risks of allowing
stateful modes.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/mtd/spi-nor/Kconfig | 10 ++++++++++
 drivers/mtd/spi-nor/core.c  |  2 ++
 2 files changed, 12 insertions(+)

diff --git a/drivers/mtd/spi-nor/Kconfig b/drivers/mtd/spi-nor/Kconfig
index ffc4b380f2b1..ab62457559b2 100644
--- a/drivers/mtd/spi-nor/Kconfig
+++ b/drivers/mtd/spi-nor/Kconfig
@@ -24,6 +24,16 @@ config MTD_SPI_NOR_USE_4K_SECTORS
 	  Please note that some tools/drivers/filesystems may not work with
 	  4096 B erase size (e.g. UBIFS requires 15 KiB as a minimum).
 
+config MTD_SPI_NOR_ALLOW_STATEFUL_MODES
+	bool "Allow stateful modes (DANGEROUS)"
+	help
+	  Allow the flash to enter in full I/O mode via a non-volatile bit.
+	  A reset or a crash will leave the flash in the full I/O mode and if
+	  the bootloader does not know how to recover, the SPI NOR boot will be
+	  broken.
+
+	  Say N, unless you absolutely know what you are doing.
+
 source "drivers/mtd/spi-nor/controllers/Kconfig"
 
 endif # MTD_SPI_NOR
diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index c149b318e2e8..e89c3ea9a736 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -3089,8 +3089,10 @@ static int spi_nor_octal_dtr_enable(struct spi_nor *nor, bool enable)
 	      nor->write_proto == SNOR_PROTO_8_8_8_DTR))
 		return 0;
 
+#ifndef CONFIG_MTD_SPI_NOR_ALLOW_STATEFUL_MODES
 	if (!(nor->flags & SNOR_F_IO_MODE_EN_VOLATILE))
 		return 0;
+#endif
 
 	ret = nor->params->octal_dtr_enable(nor, enable);
 	if (ret)
-- 
2.25.1

