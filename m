Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 634502CDB3F
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 17:33:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731274AbgLCQaw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 11:30:52 -0500
Received: from ssl.serverraum.org ([176.9.125.105]:44215 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726253AbgLCQaw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 11:30:52 -0500
Received: from apollo.fritz.box (unknown [IPv6:2a02:810c:c200:2e91:6257:18ff:fec4:ca34])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id B8A0623E4A;
        Thu,  3 Dec 2020 17:30:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1607013009;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fKrToEzI7zLxipdco5M7EpeAl5FS23oUkIyjF+kpKxY=;
        b=fuUedeTOmTcNJ/t+s3w/Tso0Tsu3L9f4EbtVdu1TJB7cHHDFkTRtFshceRbkvG1DnH3M+m
        FxDj2Bu08tK3NaYE/sioCRWqiKr5m7FrZvFjVqMKh5S4PMXQUgtyJsZhPor8sdD0oJf/QU
        BA+WPDLtQtUQeL5TAZKvu/SFiB0dxOk=
From:   Michael Walle <michael@walle.cc>
To:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH v8 1/7] mtd: spi-nor: sst: fix BPn bits for the SST25VF064C
Date:   Thu,  3 Dec 2020 17:29:53 +0100
Message-Id: <20201203162959.29589-2-michael@walle.cc>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201203162959.29589-1-michael@walle.cc>
References: <20201203162959.29589-1-michael@walle.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This flash part actually has 4 block protection bits.

Please note, that this patch is just based on information of the
datasheet of the datasheet and wasn't tested.

Reported-by: Tudor Ambarus <tudor.ambarus@microchip.com>
Fixes: 3e0930f109e7 ("mtd: spi-nor: Rework the disabling of block write protection")
Signed-off-by: Michael Walle <michael@walle.cc>
Reviewed-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
changes since v7:
 - removed Cc: stable
 - added Fixes: tag
 - added note in commit message about not being tested on real hardware

changes since v6:
 - new patch

 drivers/mtd/spi-nor/sst.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/spi-nor/sst.c b/drivers/mtd/spi-nor/sst.c
index e0af6d25d573..0ab07624fb73 100644
--- a/drivers/mtd/spi-nor/sst.c
+++ b/drivers/mtd/spi-nor/sst.c
@@ -18,7 +18,8 @@ static const struct flash_info sst_parts[] = {
 			      SECT_4K | SST_WRITE) },
 	{ "sst25vf032b", INFO(0xbf254a, 0, 64 * 1024, 64,
 			      SECT_4K | SST_WRITE) },
-	{ "sst25vf064c", INFO(0xbf254b, 0, 64 * 1024, 128, SECT_4K) },
+	{ "sst25vf064c", INFO(0xbf254b, 0, 64 * 1024, 128,
+			      SECT_4K | SPI_NOR_4BIT_BP) },
 	{ "sst25wf512",  INFO(0xbf2501, 0, 64 * 1024,  1,
 			      SECT_4K | SST_WRITE) },
 	{ "sst25wf010",  INFO(0xbf2502, 0, 64 * 1024,  2,
-- 
2.20.1

