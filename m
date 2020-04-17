Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACE971AE1DD
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Apr 2020 18:08:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729898AbgDQQIr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Apr 2020 12:08:47 -0400
Received: from zimbra2.kalray.eu ([92.103.151.219]:33424 "EHLO
        zimbra2.kalray.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729282AbgDQQIr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 12:08:47 -0400
Received: from localhost (localhost [127.0.0.1])
        by zimbra2.kalray.eu (Postfix) with ESMTP id 5059527E0309;
        Fri, 17 Apr 2020 18:08:45 +0200 (CEST)
Received: from zimbra2.kalray.eu ([127.0.0.1])
        by localhost (zimbra2.kalray.eu [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 3U24o2SO9cAJ; Fri, 17 Apr 2020 18:08:45 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra2.kalray.eu (Postfix) with ESMTP id ECAFB27E1067;
        Fri, 17 Apr 2020 18:08:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 zimbra2.kalray.eu ECAFB27E1067
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalray.eu;
        s=32AE1B44-9502-11E5-BA35-3734643DEF29; t=1587139725;
        bh=sx+djYT6EDn7Q6RGYYL44ynm4lV5rbPgKHjmZiKPWGg=;
        h=From:To:Date:Message-Id;
        b=pttHWZjwG2thkyPGHMatgEPY/UdUcFC+hIO7kc7Lcxc6VKHBmUZpsMe3CqdCOLoM9
         +zjm/6GuR7RtW9VstkcGrQkovWea+YL931GohBXN/aA7rwFcO6gWTJSnmC61MepyRk
         MClHbYBOq7wkh735Bum83g01EUUT6+GrxkTeTFDw=
X-Virus-Scanned: amavisd-new at zimbra2.kalray.eu
Received: from zimbra2.kalray.eu ([127.0.0.1])
        by localhost (zimbra2.kalray.eu [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 0Xej-1LMJ6RT; Fri, 17 Apr 2020 18:08:44 +0200 (CEST)
Received: from triton.lin.mbt.kalray.eu (unknown [192.168.37.25])
        by zimbra2.kalray.eu (Postfix) with ESMTPSA id D494327E0309;
        Fri, 17 Apr 2020 18:08:44 +0200 (CEST)
From:   Clement Leger <cleger@kalray.eu>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Clement Leger <cleger@kalray.eu>
Subject: [PATCH] mtd: spi-nor: Add support for is25lp01g
Date:   Fri, 17 Apr 2020 18:08:39 +0200
Message-Id: <20200417160839.25880-1-cleger@kalray.eu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the issi_parts table for is25lp01g (128MB) device from ISSI.
Tested on Kalray K200 board.

Signed-off-by: Clement Leger <cleger@kalray.eu>
---
 drivers/mtd/spi-nor/issi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mtd/spi-nor/issi.c b/drivers/mtd/spi-nor/issi.c
index ffcb60e54a80..c3c3438e3d08 100644
--- a/drivers/mtd/spi-nor/issi.c
+++ b/drivers/mtd/spi-nor/issi.c
@@ -49,6 +49,8 @@ static const struct flash_info issi_parts[] = {
 			     SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
 			     SPI_NOR_4B_OPCODES)
 		.fixups = &is25lp256_fixups },
+	{ "is25lp01g",  INFO(0x9d601b, 0, 64 * 1024, 2048,
+			     SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
 	{ "is25wp032",  INFO(0x9d7016, 0, 64 * 1024,  64,
 			     SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
 	{ "is25wp064",  INFO(0x9d7017, 0, 64 * 1024, 128,
-- 
2.17.1

