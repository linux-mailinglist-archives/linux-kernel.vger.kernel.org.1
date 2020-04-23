Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48AAE1B5752
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Apr 2020 10:38:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726398AbgDWIiy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Apr 2020 04:38:54 -0400
Received: from twhmllg3.macronix.com ([122.147.135.201]:54827 "EHLO
        TWHMLLG3.macronix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbgDWIiy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 04:38:54 -0400
Received: from localhost.localdomain ([172.17.195.96])
        by TWHMLLG3.macronix.com with ESMTP id 03N8ck1n034673;
        Thu, 23 Apr 2020 16:38:46 +0800 (GMT-8)
        (envelope-from masonccyang@mxic.com.tw)
From:   Mason Yang <masonccyang@mxic.com.tw>
To:     tudor.ambarus@microchip.com, miquel.raynal@bootlin.com,
        richard@nod.at, vigneshr@ti.com
Cc:     juliensu@mxic.com.tw, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, Mason Yang <masonccyang@mxic.com.tw>
Subject: [PATCH v2 0/2] mtd: spi-nor: macronix: Add support for mx25l512/mx25u512
Date:   Thu, 23 Apr 2020 16:38:41 +0800
Message-Id: <1587631123-25474-1-git-send-email-masonccyang@mxic.com.tw>
X-Mailer: git-send-email 1.9.1
X-MAIL: TWHMLLG3.macronix.com 03N8ck1n034673
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

mx25l51245g/mx25u51245g is a mass production for new design and
replace mx66l51235l/mx66u51235f(phase out).

Validated by read, erase, read back, write and read back
on Xilinx Zynq PicoZed FPGA board which included
Macronix SPI Host (driver/spi/spi-mxic.c).

change log:
v2:
Add which controller we tested the mx25l/u51245g.

Mason Yang (2):
  mtd: spi-nor: macronix: Add support for mx25l51245g
  mtd: spi-nor: macronix: Add support for mx25u51245g

 drivers/mtd/spi-nor/macronix.c | 6 ++++++
 1 file changed, 6 insertions(+)

-- 
1.9.1

