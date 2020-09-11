Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1F792675DB
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Sep 2020 00:27:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725893AbgIKW1G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Sep 2020 18:27:06 -0400
Received: from ssl.serverraum.org ([176.9.125.105]:56281 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725849AbgIKW0u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 18:26:50 -0400
Received: from apollo.fritz.box (unknown [IPv6:2a02:810c:c200:2e91:6257:18ff:fec4:ca34])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 7199622ED5;
        Sat, 12 Sep 2020 00:26:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1599863207;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=y+4gVmaJok+hBPiRs2OkskuBHalIQzIaZsf/KSA3W3E=;
        b=sQCJlK83FWDo9HPakLfSg9jTcS1am9xargZ1hWb/CNC6wopeUsTCoRu+UPo3ey4rMzJWHl
        7bI9PJ+KFp6cnrVulgZrK1Oc9S5wvaPlMC4fjyIbio1wZzkBwB+/ez93MtgqV5FOps2ESs
        cB/VkuFX7PNufWUaNa5NF4jTWHGu4Zg=
From:   Michael Walle <michael@walle.cc>
To:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Jungseung Lee <js07.lee@samsung.com>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH v2 0/4] mtd: spi-nor: OTP support
Date:   Sat, 12 Sep 2020 00:26:30 +0200
Message-Id: <20200911222634.31804-1-michael@walle.cc>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset implements the MTD OTP functions to allow access to the SPI
OTP data. Specific support is added for the Adesto, Macronix and Winbond
flash chips.

In the past there was already an attempt by Rahul Bedarkar to add this, but
there was no response. These patches are slightly based on his work.

https://lore.kernel.org/linux-mtd/1489754636-21461-1-git-send-email-rahul.bedarkar@imgtec.com/

Michael Walle (4):
  mtd: spi-nor: cleanup common code
  mtd: spi-nor: add OTP support
  mtd: spi-nor: implement OTP support for Macronix and similar flashes
  mtd: spi-nor: implement OTP support for Winbond and similar flashes

 drivers/mtd/chips/Kconfig      |   2 +-
 drivers/mtd/spi-nor/atmel.c    |  13 +-
 drivers/mtd/spi-nor/core.c     | 769 ++++++++++++++++++++++++---------
 drivers/mtd/spi-nor/core.h     |  61 +++
 drivers/mtd/spi-nor/macronix.c |  13 +-
 drivers/mtd/spi-nor/winbond.c  |  18 +-
 include/linux/mtd/spi-nor.h    |  16 +
 7 files changed, 676 insertions(+), 216 deletions(-)

-- 
2.20.1

