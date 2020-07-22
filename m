Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2812F2293F4
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jul 2020 10:50:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731026AbgGVIuw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jul 2020 04:50:52 -0400
Received: from twhmllg3.macronix.com ([211.75.127.131]:40497 "EHLO
        TWHMLLG3.macronix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726526AbgGVIus (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 04:50:48 -0400
Received: from TWHMLLG3.macronix.com (localhost [127.0.0.2] (may be forged))
        by TWHMLLG3.macronix.com with ESMTP id 06M83qBo003032
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 16:03:52 +0800 (GMT-8)
        (envelope-from ycllin@mxic.com.tw)
Received: from localhost.localdomain ([172.17.195.96])
        by TWHMLLG3.macronix.com with ESMTP id 06M83Cpi002700;
        Wed, 22 Jul 2020 16:03:12 +0800 (GMT-8)
        (envelope-from ycllin@mxic.com.tw)
From:   YouChing Lin <ycllin@mxic.com.tw>
To:     miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        juliensu@mxic.com.tw, YouChing Lin <ycllin@mxic.com.tw>
Subject: [PATCH 0/2] mtd: spinand: macronix: Add MX31LF1GE4BC/MX31UF1GE4BC support
Date:   Wed, 22 Jul 2020 16:02:56 +0800
Message-Id: <1595404978-31079-1-git-send-email-ycllin@mxic.com.tw>
X-Mailer: git-send-email 1.9.1
X-MAIL: TWHMLLG3.macronix.com 06M83Cpi002700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The Macronix MX31LF1GE4BC/MX31UF1GE4BC are 3V/1.8V, 1Gbit (128MB) serial
NAND flash devices.

Validated by read, erase, read back, write and read back
on Xilinx Zynq PicoZed FPGA board which included
Macronix SPI Host (driver/spi/spi-mxic.c).

Thanks for your time and review.
Best Regards,
YouChing


YouChing Lin (2):
  mtd: spinand: macronix: Add support for MX31LF1GE4BC
  mtd: spinand: macronix: Add support for MX31UF1GE4BC

 drivers/mtd/nand/spi/macronix.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

-- 
1.9.1

