Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF64C27F699
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 02:21:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731720AbgJAAVV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 20:21:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730268AbgJAAVV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 20:21:21 -0400
X-Greylist: delayed 1453 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 30 Sep 2020 17:21:20 PDT
Received: from yawp.biot.com (yawp.biot.com [IPv6:2a01:4f8:10a:8e::fce2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DBD4C061755
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 17:21:20 -0700 (PDT)
Received: from debian-spamd by yawp.biot.com with sa-checked (Exim 4.93)
        (envelope-from <bert@biot.com>)
        id 1kNly5-00Dh7y-Cd
        for linux-kernel@vger.kernel.org; Thu, 01 Oct 2020 01:57:05 +0200
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on yawp
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.4
Received: from [2a02:578:460c:1:1e1b:dff:fe91:1af5] (helo=sumner.biot.com)
        by yawp.biot.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <bert@biot.com>)
        id 1kNlxj-00Dh79-6T; Thu, 01 Oct 2020 01:56:43 +0200
Received: from bert by sumner.biot.com with local (Exim 4.90_1)
        (envelope-from <bert@biot.com>)
        id 1kNlxi-0001fX-U8; Thu, 01 Oct 2020 01:56:42 +0200
From:   Bert Vermeulen <bert@biot.com>
To:     tudor.ambarus@microchip.com, miquel.raynal@bootlin.com,
        richard@nod.at, vigneshr@ti.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Bert Vermeulen <bert@biot.com>
Subject: [PATCH] mtd: spi-nor: Fix 3-or-4 address byte mode logic
Date:   Thu,  1 Oct 2020 01:56:11 +0200
Message-Id: <20200930235611.6355-1-bert@biot.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Flash chips that announce BFPT_DWORD1_ADDRESS_BYTES_3_OR_4 capability
get an addr_width of 3. This breaks when the flash chip is actually
larger than 16MB, since that requires a 4-byte address. The MX25L25635F
does exactly this, breaking anything over 16MB.

spi-nor only enables 4-byte opcodes or 4-byte address mode if addr_width
is 4, so no 4-byte mode is ever enabled. The > 16MB check in
spi_nor_set_addr_width() only works if addr_width wasn't already set
by the SFDP, which it was.

It could be fixed in a post_bfpt fixup for the MX25L25635F, but setting
addr_width to 4 when BFPT_DWORD1_ADDRESS_BYTES_3_OR_4 is found fixes the
problem for all such cases.

Signed-off-by: Bert Vermeulen <bert@biot.com>
---
 drivers/mtd/spi-nor/sfdp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/spi-nor/sfdp.c b/drivers/mtd/spi-nor/sfdp.c
index e2a43d39eb5f..6fedc425bcf7 100644
--- a/drivers/mtd/spi-nor/sfdp.c
+++ b/drivers/mtd/spi-nor/sfdp.c
@@ -456,10 +456,10 @@ static int spi_nor_parse_bfpt(struct spi_nor *nor,
 	/* Number of address bytes. */
 	switch (bfpt.dwords[BFPT_DWORD(1)] & BFPT_DWORD1_ADDRESS_BYTES_MASK) {
 	case BFPT_DWORD1_ADDRESS_BYTES_3_ONLY:
-	case BFPT_DWORD1_ADDRESS_BYTES_3_OR_4:
 		nor->addr_width = 3;
 		break;
 
+	case BFPT_DWORD1_ADDRESS_BYTES_3_OR_4:
 	case BFPT_DWORD1_ADDRESS_BYTES_4_ONLY:
 		nor->addr_width = 4;
 		break;
-- 
2.17.1

