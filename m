Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2B722CDB42
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 17:33:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731311AbgLCQa4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 11:30:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731286AbgLCQax (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 11:30:53 -0500
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 814DBC061A52
        for <linux-kernel@vger.kernel.org>; Thu,  3 Dec 2020 08:30:13 -0800 (PST)
Received: from apollo.fritz.box (unknown [IPv6:2a02:810c:c200:2e91:6257:18ff:fec4:ca34])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id A90C223E5F;
        Thu,  3 Dec 2020 17:30:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1607013011;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=P9+5crto50tZ0vhSSiu1lZR4i5hs1Q2shZ8lu2aiJfo=;
        b=EeZBo7PMvWm0bKUNPv8FHkj9njfepCBpSryqI+ME8FzBPHnWuf0U72d7/nGH05EIEnB7ST
        5EKp4TM+rzw6iUNHbBtK444y907jYdFdHkIzVAkaB2tIOk8EIZiHVDxqzwQmUQ+6KTdAjv
        5OS/5+U+hO7ex8DQ5uX5+kbAwKkhZ2Y=
From:   Michael Walle <michael@walle.cc>
To:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH v8 5/7] mtd: spi-nor: intel: remove global protection flag
Date:   Thu,  3 Dec 2020 17:29:57 +0100
Message-Id: <20201203162959.29589-6-michael@walle.cc>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201203162959.29589-1-michael@walle.cc>
References: <20201203162959.29589-1-michael@walle.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For the Atmel and SST parts this flag was already moved to individual
flash parts because it is considered bad esp. because newer flash chips
will automatically inherit the "has locking" support. While this won't
likely be the case for the Intel parts, we do it for consistency
reasons.

Signed-off-by: Michael Walle <michael@walle.cc>
Reviewed-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
changes since v7
 - none

changes since v6
 - none

changes since v5
 - new patch

 drivers/mtd/spi-nor/intel.c | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/drivers/mtd/spi-nor/intel.c b/drivers/mtd/spi-nor/intel.c
index d8196f101368..6c31bef3fc60 100644
--- a/drivers/mtd/spi-nor/intel.c
+++ b/drivers/mtd/spi-nor/intel.c
@@ -10,23 +10,13 @@
 
 static const struct flash_info intel_parts[] = {
 	/* Intel/Numonyx -- xxxs33b */
-	{ "160s33b",  INFO(0x898911, 0, 64 * 1024,  32, 0) },
-	{ "320s33b",  INFO(0x898912, 0, 64 * 1024,  64, 0) },
-	{ "640s33b",  INFO(0x898913, 0, 64 * 1024, 128, 0) },
-};
-
-static void intel_default_init(struct spi_nor *nor)
-{
-	nor->flags |= SNOR_F_HAS_LOCK;
-}
-
-static const struct spi_nor_fixups intel_fixups = {
-	.default_init = intel_default_init,
+	{ "160s33b",  INFO(0x898911, 0, 64 * 1024,  32, SPI_NOR_HAS_LOCK) },
+	{ "320s33b",  INFO(0x898912, 0, 64 * 1024,  64, SPI_NOR_HAS_LOCK) },
+	{ "640s33b",  INFO(0x898913, 0, 64 * 1024, 128, SPI_NOR_HAS_LOCK) },
 };
 
 const struct spi_nor_manufacturer spi_nor_intel = {
 	.name = "intel",
 	.parts = intel_parts,
 	.nparts = ARRAY_SIZE(intel_parts),
-	.fixups = &intel_fixups,
 };
-- 
2.20.1

