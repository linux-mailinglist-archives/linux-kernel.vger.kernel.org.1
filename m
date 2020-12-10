Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A70A2D5209
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 04:53:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731202AbgLJDt4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 22:49:56 -0500
Received: from twhmllg3.macronix.com ([211.75.127.131]:54439 "EHLO
        TWHMLLG3.macronix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730431AbgLJDtz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 22:49:55 -0500
Received: from TWHMLLG3.macronix.com (localhost [127.0.0.2] (may be forged))
        by TWHMLLG3.macronix.com with ESMTP id 0BA3NrMV012279
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 11:23:53 +0800 (GMT-8)
        (envelope-from ycllin@mxic.com.tw)
Received: from localhost.localdomain ([172.17.195.95])
        by TWHMLLG3.macronix.com with ESMTP id 0BA3MURf011440;
        Thu, 10 Dec 2020 11:22:36 +0800 (GMT-8)
        (envelope-from ycllin@mxic.com.tw)
From:   YouChing Lin <ycllin@mxic.com.tw>
To:     miquel.raynal@bootlin.com, vigneshr@ti.com
Cc:     juliensu@mxic.com.tw, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, ycllin@mxic.com.tw
Subject: [PATCH 1/2] mtd: nand: ecc-bch: Fix the size of calc_buf/code_buf of the BCH
Date:   Thu, 10 Dec 2020 11:22:08 +0800
Message-Id: <1607570529-22341-2-git-send-email-ycllin@mxic.com.tw>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1607570529-22341-1-git-send-email-ycllin@mxic.com.tw>
References: <1607570529-22341-1-git-send-email-ycllin@mxic.com.tw>
X-MAIL: TWHMLLG3.macronix.com 0BA3MURf011440
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If eccbyte exceeds 64 bytes, the read operation will get wrong results.
For example: Flash with a page size of 4096 bytes (eccbyte: 104 bytes).
During the read operation, after executing nand_ecc_sw_bch_calculate(),
since the calc_buf/code_buf ranges overlap each other, the last three
steps of ecc_code (read from oob) will be changed.

The root cause is that the size of calc_buf/code_buf is limited to 64
bytes, although sizeof(mtd->oobsize) returns 4, kzalloc() will allocate
64 bytes (cache size alignment).

So we correct the size of calc_buf/code_buf to mtd->oobsize.

Signed-off-by: YouChing Lin <ycllin@mxic.com.tw>
---
 drivers/mtd/nand/ecc-sw-bch.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/ecc-sw-bch.c b/drivers/mtd/nand/ecc-sw-bch.c
index 4d8a979..0a0ac11 100644
--- a/drivers/mtd/nand/ecc-sw-bch.c
+++ b/drivers/mtd/nand/ecc-sw-bch.c
@@ -237,8 +237,8 @@ int nand_ecc_sw_bch_init_ctx(struct nand_device *nand)
 
 	engine_conf->code_size = code_size;
 	engine_conf->nsteps = nsteps;
-	engine_conf->calc_buf = kzalloc(sizeof(mtd->oobsize), GFP_KERNEL);
-	engine_conf->code_buf = kzalloc(sizeof(mtd->oobsize), GFP_KERNEL);
+	engine_conf->calc_buf = kzalloc(mtd->oobsize, GFP_KERNEL);
+	engine_conf->code_buf = kzalloc(mtd->oobsize, GFP_KERNEL);
 	if (!engine_conf->calc_buf || !engine_conf->code_buf) {
 		ret = -ENOMEM;
 		goto free_bufs;
-- 
1.9.1

