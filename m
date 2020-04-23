Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E98111B5754
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Apr 2020 10:39:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbgDWIi6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Apr 2020 04:38:58 -0400
Received: from twhmllg3.macronix.com ([122.147.135.201]:54832 "EHLO
        TWHMLLG3.macronix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbgDWIi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 04:38:57 -0400
Received: from localhost.localdomain ([172.17.195.96])
        by TWHMLLG3.macronix.com with ESMTP id 03N8ck1o034673;
        Thu, 23 Apr 2020 16:38:47 +0800 (GMT-8)
        (envelope-from masonccyang@mxic.com.tw)
From:   Mason Yang <masonccyang@mxic.com.tw>
To:     tudor.ambarus@microchip.com, miquel.raynal@bootlin.com,
        richard@nod.at, vigneshr@ti.com
Cc:     juliensu@mxic.com.tw, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, Mason Yang <masonccyang@mxic.com.tw>
Subject: [PATCH v2 1/2] mtd: spi-nor: macronix: Add support for mx25l51245g
Date:   Thu, 23 Apr 2020 16:38:42 +0800
Message-Id: <1587631123-25474-2-git-send-email-masonccyang@mxic.com.tw>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1587631123-25474-1-git-send-email-masonccyang@mxic.com.tw>
References: <1587631123-25474-1-git-send-email-masonccyang@mxic.com.tw>
X-MAIL: TWHMLLG3.macronix.com 03N8ck1o034673
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mx25l51245g is a mass production for new design and
replace mx66l51235l(phase out).

Validated by read, erase, read back, write and read back
on Xilinx Zynq PicoZed FPGA board which included
Macronix SPI Host (driver/spi/spi-mxic.c).

Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
---
 drivers/mtd/spi-nor/macronix.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mtd/spi-nor/macronix.c b/drivers/mtd/spi-nor/macronix.c
index ab0f963..c864ac8 100644
--- a/drivers/mtd/spi-nor/macronix.c
+++ b/drivers/mtd/spi-nor/macronix.c
@@ -67,6 +67,9 @@
 			      SECT_4K | SPI_NOR_DUAL_READ |
 			      SPI_NOR_QUAD_READ) },
 	{ "mx25l25655e", INFO(0xc22619, 0, 64 * 1024, 512, 0) },
+	{ "mx25l51245g", INFO(0xc2201a, 0, 64 * 1024, 1024,
+			      SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
+			      SPI_NOR_4B_OPCODES) },
 	{ "mx66l51235l", INFO(0xc2201a, 0, 64 * 1024, 1024,
 			      SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
 			      SPI_NOR_4B_OPCODES) },
-- 
1.9.1

