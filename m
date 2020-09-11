Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF76726652C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Sep 2020 18:55:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726350AbgIKQy6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Sep 2020 12:54:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725951AbgIKPGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 11:06:12 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23228C0612EE
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 07:47:21 -0700 (PDT)
Received: from dude02.hi.pengutronix.de ([2001:67c:670:100:1d::28])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1kGkKU-0006Pv-NW; Fri, 11 Sep 2020 16:47:10 +0200
Received: from mfe by dude02.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1kGkKP-0006nd-40; Fri, 11 Sep 2020 16:47:05 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     tudor.ambarus@microchip.com, miquel.raynal@bootlin.com,
        richard@nod.at, vigneshr@ti.com,
        sergei.shtylyov@cogentembedded.com, boris.brezillon@collabora.com,
        michael@walle.cc, j.neuschaefer@gmx.net
Cc:     linux-mtd@lists.infradead.org, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] mtd: spi-nor: sst: add missing write_enable
Date:   Fri, 11 Sep 2020 16:47:02 +0200
Message-Id: <20200911144703.25409-3-m.felsch@pengutronix.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200911144703.25409-1-m.felsch@pengutronix.de>
References: <20200911144703.25409-1-m.felsch@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::28
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According the datasheet [1] the WEL is automatically reset after the
Byte-Program instruction completion. So if we program the device with
byte-size set to 32 and starting from an odd address only the first and
the last byte is written. Fix this by (re-)anble the write support for
the first SPINOR_OP_AAI_WP sequence.

[1] http://ww1.microchip.com/downloads/en/DeviceDoc/20005044C.pdf;
    "4.3.2 WRITE ENABLE LATCH (WEL)"

Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
---
 drivers/mtd/spi-nor/sst.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/mtd/spi-nor/sst.c b/drivers/mtd/spi-nor/sst.c
index e0af6d25d573..644252e27a2a 100644
--- a/drivers/mtd/spi-nor/sst.c
+++ b/drivers/mtd/spi-nor/sst.c
@@ -79,6 +79,13 @@ static int sst_write(struct mtd_info *mtd, loff_t to, size_t len,
 
 	/* Write out most of the data here. */
 	for (; actual < len - 1; actual += 2) {
+		/* Enable write support if odd address was written before */
+		if (actual == 1) {
+			ret = spi_nor_write_enable(nor);
+			if (ret)
+				goto out;
+		}
+
 		nor->program_opcode = SPINOR_OP_AAI_WP;
 
 		/* write two bytes. */
-- 
2.20.1

