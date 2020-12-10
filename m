Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 709682D5210
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 04:53:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731730AbgLJDvW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 22:51:22 -0500
Received: from twhmllg3.macronix.com ([211.75.127.131]:54571 "EHLO
        TWHMLLG3.macronix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731587AbgLJDut (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 22:50:49 -0500
Received: from TWHMLLG3.macronix.com (localhost [127.0.0.2] (may be forged))
        by TWHMLLG3.macronix.com with ESMTP id 0BA3Nr3R012276
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 11:23:53 +0800 (GMT-8)
        (envelope-from ycllin@mxic.com.tw)
Received: from localhost.localdomain ([172.17.195.95])
        by TWHMLLG3.macronix.com with ESMTP id 0BA3MURe011440;
        Thu, 10 Dec 2020 11:22:30 +0800 (GMT-8)
        (envelope-from ycllin@mxic.com.tw)
From:   YouChing Lin <ycllin@mxic.com.tw>
To:     miquel.raynal@bootlin.com, vigneshr@ti.com
Cc:     juliensu@mxic.com.tw, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, ycllin@mxic.com.tw
Subject: [PATCH 0/2] mtd: spinand: add support for MX35LFxG24AD & Fix bug of BCH
Date:   Thu, 10 Dec 2020 11:22:07 +0800
Message-Id: <1607570529-22341-1-git-send-email-ycllin@mxic.com.tw>
X-Mailer: git-send-email 1.9.1
X-MAIL: TWHMLLG3.macronix.com 0BA3MURe011440
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This series adds support for MX35LF1/2/4G24AD, are 3V, 1G/2G/4Gbit serial
SLC NAND flash device (without on-die ECC).

And fix a bug of BCH, the size of calc_buf/code_buf is limited to 64 bytes.
If someone uses Flash with pagesize: 4096 (for example: MX35LF4G24AD, 
eccbyte: 104 bytes), some errors will occur during the read operation.
So we correct the size of calc_buf/code_buf to mtd->oobsize.

This series has been tested on Xilinx Zynq PicoZed FPGA board.

Thanks for your time.

YouChing Lin (2):
  mtd: nand: ecc-bch: Fix the size of calc_buf/code_buf of the BCH
  mtd: spinand: macronix: Add support for MX35LFxG24AD

 drivers/mtd/nand/ecc-sw-bch.c   |  4 ++--
 drivers/mtd/nand/spi/macronix.c | 27 +++++++++++++++++++++++++++
 2 files changed, 29 insertions(+), 2 deletions(-)

-- 
1.9.1

