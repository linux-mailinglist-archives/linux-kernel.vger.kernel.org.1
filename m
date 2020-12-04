Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 956882CF4CA
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 20:32:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730406AbgLDTbr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 14:31:47 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:48735 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725923AbgLDTbr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 14:31:47 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1klGnC-0006nw-Cb; Fri, 04 Dec 2020 19:30:58 +0000
From:   Colin King <colin.king@canonical.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mtd: rawnand: Clean up some spelling mistakes and grammar in Kconfig text
Date:   Fri,  4 Dec 2020 19:30:58 +0000
Message-Id: <20201204193058.1151768-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There are some spelling mistakes in the Kconfig help text, fix
these. Also clean up the grammar.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/mtd/nand/raw/Kconfig | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/nand/raw/Kconfig b/drivers/mtd/nand/raw/Kconfig
index b93e6cd23259..83b65fb1b93b 100644
--- a/drivers/mtd/nand/raw/Kconfig
+++ b/drivers/mtd/nand/raw/Kconfig
@@ -460,9 +460,9 @@ config MTD_NAND_RICOH
 	select MTD_SM_COMMON
 	help
 	  Enable support for Ricoh R5C852 xD card reader
-	  You also need to enable ether
-	  NAND SSFDC (SmartMedia) read only translation layer' or new
-	  expermental, readwrite
+	  You also need to enable either
+	  'NAND SSFDC (SmartMedia) read only translation layer' or the
+         new experimental, readwrite
 	  'SmartMedia/xD new translation layer'
 
 config MTD_NAND_DISKONCHIP
-- 
2.29.2

