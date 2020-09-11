Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B56A02664CB
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Sep 2020 18:46:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726413AbgIKQqF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Sep 2020 12:46:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726247AbgIKPIM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 11:08:12 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13F45C0612EC
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 07:47:21 -0700 (PDT)
Received: from dude02.hi.pengutronix.de ([2001:67c:670:100:1d::28])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1kGkKU-0006Pn-NW; Fri, 11 Sep 2020 16:47:10 +0200
Received: from mfe by dude02.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1kGkKP-0006nZ-2p; Fri, 11 Sep 2020 16:47:05 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     tudor.ambarus@microchip.com, miquel.raynal@bootlin.com,
        richard@nod.at, vigneshr@ti.com,
        sergei.shtylyov@cogentembedded.com, boris.brezillon@collabora.com,
        michael@walle.cc, j.neuschaefer@gmx.net
Cc:     linux-mtd@lists.infradead.org, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] MTD: SST SPI-NOR fixes
Date:   Fri, 11 Sep 2020 16:47:00 +0200
Message-Id: <20200911144703.25409-1-m.felsch@pengutronix.de>
X-Mailer: git-send-email 2.20.1
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

Hi,

Patch 1-2: write path fixes
The sst write path is completely broken since v5.7-rc1 and in rare cases
since the support of the sst_write() function (49aac4aec53c).

Patch 3: cleanup

I've tested my patches with a small test app to ensure writes starting
on an odd address and with dd to test even start addresses. My dut was
an public available imx6q-sabrelite (rev.D).
Other testers are welcome :)

Regards,
  Marco

Marco Felsch (3):
  mtd: spi-nor: sst: fix write support for SST_WRITE marked devices
  mtd: spi-nor: sst: add missing write_enable
  mtd: spi-nor: sst: move sst_write_second to local driver

 drivers/mtd/spi-nor/core.c  | 15 +++++++++------
 drivers/mtd/spi-nor/sst.c   | 15 +++++++++++----
 include/linux/mtd/spi-nor.h |  2 --
 3 files changed, 20 insertions(+), 12 deletions(-)

-- 
2.20.1

