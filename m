Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FDAC2E6E64
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Dec 2020 06:56:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726305AbgL2FwV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Dec 2020 00:52:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725986AbgL2FwU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Dec 2020 00:52:20 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51950C061793
        for <linux-kernel@vger.kernel.org>; Mon, 28 Dec 2020 21:51:34 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id s21so7441399pfu.13
        for <linux-kernel@vger.kernel.org>; Mon, 28 Dec 2020 21:51:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qsY+1M4FJ0q/q5YlR2X9LFRy8FN/y5SCHLrVoOdMv3E=;
        b=G0M+6Hdg48ktCcJMT3GquHm2iHxZkmS7bPcWWauqhzk3x9hjHyzQ91bMShs431GyGF
         iUc9P6xXrFJtZTqvPOHe3FsQW/iR7Fn+hdczC0ghwN5wXqzUA+yE8zBp9u2+Ql89phMc
         LbNv2pm4qpWA+P+KS1EmhSwWzY5JQ6Od55GMg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qsY+1M4FJ0q/q5YlR2X9LFRy8FN/y5SCHLrVoOdMv3E=;
        b=tvvIVo6lTyzWUcGCZeHh5l108ZghkJxEbHnqIz3CA0a7oGLCaOUdGKvbVOqjsBqSW+
         1fn1rmuTqaNdjxmKV+s2ETNzNS8o2OTL58fEG0WCGjAz1NqOgONz5rZQs863Q1HeYY2/
         l/tM6kWtHNEFSCheLhlICSxshapMF0RxXs4Fx/Y5QDMjkFMw0hIQtpLEGWE4W4hG/JPw
         FoWdMr3+F1xF6DiPsar5pMDYbUe53kiGXR1zCRMsCbypaTv64tangk2fY6MrhdSES4oG
         j08J4VU30V/POUyuyRBVvtXIMW1u8aZSRw98DpSPSDSc9Qyqw2FbBedlv1DOhoi1/3Zq
         WNQQ==
X-Gm-Message-State: AOAM531o2qFa4thmPe3WqWV3MPjQ2D2f8z/WnvkvlsNxCoKLQl2ReLrd
        kNB95ZefWgx9wicBpQhVzhABMw==
X-Google-Smtp-Source: ABdhPJx3bOkV3xDOnF50Qnq0yVTsSGdFcATNAFITAie1uaeDMZgORmBwE3oTYLZGx9BkwcModmwp3Q==
X-Received: by 2002:a63:da58:: with SMTP id l24mr46264434pgj.178.1609221093884;
        Mon, 28 Dec 2020 21:51:33 -0800 (PST)
Received: from shiro.work (p1268123-ipngn200803sizuokaden.shizuoka.ocn.ne.jp. [118.13.124.123])
        by smtp.googlemail.com with ESMTPSA id x23sm45041113pge.47.2020.12.28.21.51.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Dec 2020 21:51:33 -0800 (PST)
From:   Daniel Palmer <daniel@0x0f.com>
To:     linux-mtd@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, miquel.raynal@bootlin.com,
        richard@nod.at, vigneshr@ti.com, Daniel Palmer <daniel@0x0f.com>
Subject: [PATCH 1/1] mtd: spinand: add support for Foresee FS35ND01G
Date:   Tue, 29 Dec 2020 14:50:59 +0900
Message-Id: <20201229055059.2255021-2-daniel@0x0f.com>
X-Mailer: git-send-email 2.30.0.rc2
In-Reply-To: <20201229055059.2255021-1-daniel@0x0f.com>
References: <20201229055059.2255021-1-daniel@0x0f.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the Foresee FS35ND01G manufactured by Longsys.

Signed-off-by: Daniel Palmer <daniel@0x0f.com>
---
 drivers/mtd/nand/spi/Makefile  |  2 +-
 drivers/mtd/nand/spi/core.c    |  1 +
 drivers/mtd/nand/spi/longsys.c | 45 ++++++++++++++++++++++++++++++++++
 include/linux/mtd/spinand.h    |  1 +
 4 files changed, 48 insertions(+), 1 deletion(-)
 create mode 100644 drivers/mtd/nand/spi/longsys.c

diff --git a/drivers/mtd/nand/spi/Makefile b/drivers/mtd/nand/spi/Makefile
index 9662b9c1d5a9..1d6819022e43 100644
--- a/drivers/mtd/nand/spi/Makefile
+++ b/drivers/mtd/nand/spi/Makefile
@@ -1,3 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0
-spinand-objs := core.o gigadevice.o macronix.o micron.o paragon.o toshiba.o winbond.o
+spinand-objs := core.o gigadevice.o longsys.o macronix.o micron.o paragon.o toshiba.o winbond.o
 obj-$(CONFIG_MTD_SPI_NAND) += spinand.o
diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index 8ea545bb924d..bdc9cd45d232 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -856,6 +856,7 @@ static const struct nand_ops spinand_ops = {
 
 static const struct spinand_manufacturer *spinand_manufacturers[] = {
 	&gigadevice_spinand_manufacturer,
+	&longsys_spinand_manufacturer,
 	&macronix_spinand_manufacturer,
 	&micron_spinand_manufacturer,
 	&paragon_spinand_manufacturer,
diff --git a/drivers/mtd/nand/spi/longsys.c b/drivers/mtd/nand/spi/longsys.c
new file mode 100644
index 000000000000..f18271f8e9d2
--- /dev/null
+++ b/drivers/mtd/nand/spi/longsys.c
@@ -0,0 +1,45 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2020 Daniel Palmer <daniel@thingy.jp>
+ *
+ */
+
+#include <linux/device.h>
+#include <linux/kernel.h>
+#include <linux/mtd/spinand.h>
+
+#define SPINAND_MFR_LONGSYS		0xcd
+
+static SPINAND_OP_VARIANTS(read_cache_variants,
+		SPINAND_PAGE_READ_FROM_CACHE_OP(true, 0, 1, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_OP(false, 0, 1, NULL, 0));
+
+static SPINAND_OP_VARIANTS(write_cache_variants,
+		SPINAND_PROG_LOAD(true, 0, NULL, 0));
+
+static SPINAND_OP_VARIANTS(update_cache_variants,
+		SPINAND_PROG_LOAD(false, 0, NULL, 0));
+
+static const struct spinand_info longsys_spinand_table[] = {
+	SPINAND_INFO("FS35ND01G",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xea, 0x11),
+		     NAND_MEMORG(1, 2048, 64, 64, 1024, 20, 1, 1, 1),
+		     NAND_ECCREQ(4, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     SPINAND_HAS_QE_BIT,
+		     SPINAND_ECCINFO(NULL,
+				     NULL)),
+};
+
+static const struct spinand_manufacturer_ops longsys_spinand_manuf_ops = {
+};
+
+const struct spinand_manufacturer longsys_spinand_manufacturer = {
+	.id = SPINAND_MFR_LONGSYS,
+	.name = "Longsys",
+	.chips = longsys_spinand_table,
+	.nchips = ARRAY_SIZE(longsys_spinand_table),
+	.ops = &longsys_spinand_manuf_ops,
+};
diff --git a/include/linux/mtd/spinand.h b/include/linux/mtd/spinand.h
index 6bb92f26833e..8651e63a2f8a 100644
--- a/include/linux/mtd/spinand.h
+++ b/include/linux/mtd/spinand.h
@@ -239,6 +239,7 @@ struct spinand_manufacturer {
 
 /* SPI NAND manufacturers */
 extern const struct spinand_manufacturer gigadevice_spinand_manufacturer;
+extern const struct spinand_manufacturer longsys_spinand_manufacturer;
 extern const struct spinand_manufacturer macronix_spinand_manufacturer;
 extern const struct spinand_manufacturer micron_spinand_manufacturer;
 extern const struct spinand_manufacturer paragon_spinand_manufacturer;
-- 
2.30.0.rc2

