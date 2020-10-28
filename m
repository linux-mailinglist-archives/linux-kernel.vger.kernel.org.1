Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAD1429D38B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Oct 2020 22:45:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726261AbgJ1VoT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 17:44:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726710AbgJ1VoQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 17:44:16 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9481DC0613CF
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 14:44:16 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id h19so654060qtq.4
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 14:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eclypsium.com; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=g3/ic8OrjoDKmQmHTz6BlbiXsmNSocXsV5IfSMKXiao=;
        b=Meq4xraQC6HPSphKKaYQJ7ytRmCjZ2ScJNeqHg+SnW/ek3Fq7/PoNjK4TQkUIodSn1
         u/6C8xFY+65YB+kufssP9OT9/A7FrT1/3aRDUBQBJC+6oDFlJdXG/91Y+Ys9WJe6Xm2o
         YUmND+CJWSDcZjRg2kG2iiEPZEKF+vGGmkQDtrZIoxGmC0Vqv7YxyJf2BI/ycp+ilJkZ
         36buVYQ+eDZkzOXJrFGygHbMtV3APWNeoGBH78FhE1APU2OM5NY4cLnR0FfR6iwQesk9
         m4o80/zMELksLZCp7DyDVccWPej+NMi3oDTpq2Vy+huPBBPZUKhMAk20kM0AOTFli8jB
         b0jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=g3/ic8OrjoDKmQmHTz6BlbiXsmNSocXsV5IfSMKXiao=;
        b=g45W/qJIPTLJEibQkJg8GTw8DW1+rODTD+VlzLvZHiyClIqhe4vPitR7Yw3rm7XV17
         S+46iYPWFqBoQCqhnPTZPy0v4044gP5zNDaV1EDqe9w4nY52V8dLB5gt4FufwF5abp0R
         UrU7BBPaJ+V0H0Qo3pJun9sp5IFOVWCxJSROmOk7mXwo3ZCJYR109Jjaqq8ZfPqXwDvN
         nmr4oyKE9xaHmyGU3RG0EPxqM9VQv/oFbHY7lqTjHKw/NaaEbAuu6k0AYzPTH1cE6WoQ
         LsWiCakBcPDZdCHb4SdLKZaJio68Iz+t9JXcetn6TWOCdbOgNU6UqaTlxyjyaUDc5QEK
         HTdA==
X-Gm-Message-State: AOAM532GlLpw8im730FoBOStvH5FknNiGH73OiMft6Io95KIIz+dzQnm
        SIVxAO98J7AuMw2a6+mXDC+pcQ==
X-Google-Smtp-Source: ABdhPJyHnOpf1IaFbVjmq/hiAC+w5EEILCtV5qRHcu78WhXx97XnxnZzhhtyC5AaAynfqXVPhJ/x+Q==
X-Received: by 2002:ac8:46c1:: with SMTP id h1mr901158qto.361.1603921455680;
        Wed, 28 Oct 2020 14:44:15 -0700 (PDT)
Received: from localhost ([190.190.138.51])
        by smtp.gmail.com with ESMTPSA id 22sm313023qtw.61.2020.10.28.14.44.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Oct 2020 14:44:15 -0700 (PDT)
From:   Daniel Gutson <daniel.gutson@eclypsium.com>
To:     Daniel Gutson <daniel.gutson@eclypsium.com>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Richard Hughes <hughsient@gmail.com>,
        Alex Bazhaniuk <alex@eclypsium.com>,
        linux-mtd@lists.infradead.org
Subject: [PATCH] mtd: spi-nor: intel-spi: Split intel-spi reading from writing
Date:   Wed, 28 Oct 2020 18:43:59 -0300
Message-Id: <20201028214359.384918-1-daniel.gutson@eclypsium.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch separates the writing part of the intel-spi drivers
so the 'dangerous' part can be set/unset independently.
This way, the kernel can be configured to include the reading
parts of the driver which can be used without
the dangerous write operations that can turn the system
unbootable.

Signed-off-by: Daniel Gutson <daniel.gutson@eclypsium.com>
---
 drivers/mtd/spi-nor/controllers/Kconfig     | 39 ++++++++++++---------
 drivers/mtd/spi-nor/controllers/intel-spi.c | 12 +++++--
 2 files changed, 33 insertions(+), 18 deletions(-)

diff --git a/drivers/mtd/spi-nor/controllers/Kconfig b/drivers/mtd/spi-nor/controllers/Kconfig
index 5c0e0ec2e6d1..491c755fea49 100644
--- a/drivers/mtd/spi-nor/controllers/Kconfig
+++ b/drivers/mtd/spi-nor/controllers/Kconfig
@@ -31,34 +31,41 @@ config SPI_INTEL_SPI
 	tristate
 
 config SPI_INTEL_SPI_PCI
-	tristate "Intel PCH/PCU SPI flash PCI driver (DANGEROUS)"
+	tristate "Intel PCH/PCU SPI flash PCI driver"
 	depends on X86 && PCI
 	select SPI_INTEL_SPI
 	help
-	  This enables PCI support for the Intel PCH/PCU SPI controller in
-	  master mode. This controller is present in modern Intel hardware
-	  and is used to hold BIOS and other persistent settings. Using
-	  this driver it is possible to upgrade BIOS directly from Linux.
-
-	  Say N here unless you know what you are doing. Overwriting the
-	  SPI flash may render the system unbootable.
+	  This enables read only PCI support for the Intel PCH/PCU SPI
+	  controller in master mode. This controller is present in modern
+	  Intel hardware and is used to hold BIOS and other persistent settings.
+	  Using this driver it is possible to read the SPI chip directly
+	  from Linux.
 
 	  To compile this driver as a module, choose M here: the module
 	  will be called intel-spi-pci.
 
 config SPI_INTEL_SPI_PLATFORM
-	tristate "Intel PCH/PCU SPI flash platform driver (DANGEROUS)"
+	tristate "Intel PCH/PCU SPI flash platform driver"
 	depends on X86
 	select SPI_INTEL_SPI
 	help
-	  This enables platform support for the Intel PCH/PCU SPI
+	  This enables read only platform support for the Intel PCH/PCU SPI
 	  controller in master mode. This controller is present in modern
-	  Intel hardware and is used to hold BIOS and other persistent
-	  settings. Using this driver it is possible to upgrade BIOS
-	  directly from Linux.
+	  Intel hardware and is used to hold BIOS and other persistent settings.
+	  Using this driver it is possible to read the SPI chip directly
+	  from Linux.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called intel-spi-pci.
+
+config SPI_INTEL_SPI_WRITE
+	bool "Intel PCH/PCU SPI flash drivers write operations (DANGEROUS)"
+	depends on SPI_INTEL_SPI_PCI || SPI_INTEL_SPI_PLATFORM
+	help
+	  This enables full read/write support for the Intel PCH/PCU SPI
+	  controller.
+	  Using this option it may be possible to upgrade BIOS directly
+	  from Linux.
 
 	  Say N here unless you know what you are doing. Overwriting the
 	  SPI flash may render the system unbootable.
-
-	  To compile this driver as a module, choose M here: the module
-	  will be called intel-spi-platform.
diff --git a/drivers/mtd/spi-nor/controllers/intel-spi.c b/drivers/mtd/spi-nor/controllers/intel-spi.c
index b54a56a68100..8d8053395c3d 100644
--- a/drivers/mtd/spi-nor/controllers/intel-spi.c
+++ b/drivers/mtd/spi-nor/controllers/intel-spi.c
@@ -266,6 +266,7 @@ static int intel_spi_read_block(struct intel_spi *ispi, void *buf, size_t size)
 	return 0;
 }
 
+#ifdef CONFIG_SPI_INTEL_SPI_WRITE
 /* Writes max INTEL_SPI_FIFO_SZ bytes to the device fifo */
 static int intel_spi_write_block(struct intel_spi *ispi, const void *buf,
 				 size_t size)
@@ -286,6 +287,7 @@ static int intel_spi_write_block(struct intel_spi *ispi, const void *buf,
 
 	return 0;
 }
+#endif /* CONFIG_SPI_INTEL_SPI_WRITE */
 
 static int intel_spi_wait_hw_busy(struct intel_spi *ispi)
 {
@@ -576,6 +578,7 @@ static int intel_spi_read_reg(struct spi_nor *nor, u8 opcode, u8 *buf,
 	return intel_spi_read_block(ispi, buf, len);
 }
 
+#ifdef CONFIG_SPI_INTEL_SPI_WRITE
 static int intel_spi_write_reg(struct spi_nor *nor, u8 opcode, const u8 *buf,
 			       size_t len)
 {
@@ -633,6 +636,7 @@ static int intel_spi_write_reg(struct spi_nor *nor, u8 opcode, const u8 *buf,
 					  OPTYPE_WRITE_NO_ADDR);
 	return intel_spi_hw_cycle(ispi, opcode, len);
 }
+#endif /* CONFIG_SPI_INTEL_SPI_WRITE */
 
 static ssize_t intel_spi_read(struct spi_nor *nor, loff_t from, size_t len,
 			      u_char *read_buf)
@@ -705,6 +709,7 @@ static ssize_t intel_spi_read(struct spi_nor *nor, loff_t from, size_t len,
 	return retlen;
 }
 
+#ifdef CONFIG_SPI_INTEL_SPI_WRITE
 static ssize_t intel_spi_write(struct spi_nor *nor, loff_t to, size_t len,
 			       const u_char *write_buf)
 {
@@ -829,6 +834,7 @@ static int intel_spi_erase(struct spi_nor *nor, loff_t offs)
 
 	return 0;
 }
+#endif /* CONFIG_SPI_INTEL_SPI_WRITE */
 
 static bool intel_spi_is_protected(const struct intel_spi *ispi,
 				   unsigned int base, unsigned int limit)
@@ -897,10 +903,12 @@ static void intel_spi_fill_partition(struct intel_spi *ispi,
 
 static const struct spi_nor_controller_ops intel_spi_controller_ops = {
 	.read_reg = intel_spi_read_reg,
-	.write_reg = intel_spi_write_reg,
 	.read = intel_spi_read,
+#ifdef CONFIG_SPI_INTEL_SPI_WRITE
+	.write_reg = intel_spi_write_reg,
 	.write = intel_spi_write,
-	.erase = intel_spi_erase,
+	.erase = intel_spi_erase
+#endif
 };
 
 struct intel_spi *intel_spi_probe(struct device *dev,
-- 
2.25.1

