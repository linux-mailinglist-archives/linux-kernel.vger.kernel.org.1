Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C08492B83C6
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 19:27:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726673AbgKRSZZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 13:25:25 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:59500 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726544AbgKRSZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 13:25:24 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0AIIP3pZ061801;
        Wed, 18 Nov 2020 12:25:03 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1605723903;
        bh=b0W4/IilRswe4N7gZ6kusQuEDxud1SbCTxxWP2WJD9U=;
        h=From:To:CC:Subject:Date;
        b=mLDululR1VayWRN2kQplMAFBUbVFygaWjDCY+Oi/GVZNL9+ehAh34setFbcB7+5U/
         WgTUYZdLtcfd4J+0Q38kzyqnKBG5aFbe6WLYzY4Vy147uVAxlMDEcCboymj0WzmKgS
         CNp3TpLTOWVgFo2EkaaT3ajZn+KXF1aQYCvDCTPA=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0AIIP39V130876
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 18 Nov 2020 12:25:03 -0600
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 18
 Nov 2020 12:25:03 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 18 Nov 2020 12:25:03 -0600
Received: from pratyush-OptiPlex-790.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0AIIP0Du022682;
        Wed, 18 Nov 2020 12:25:00 -0600
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC:     Pratyush Yadav <p.yadav@ti.com>
Subject: [PATCH v2 0/3] mtd: Make sure UBIFS does not do multi-pass page programming on flashes that don't support it
Date:   Wed, 18 Nov 2020 23:54:56 +0530
Message-ID: <20201118182459.18197-1-p.yadav@ti.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The Cypress Semper S28 flash family uses 2-bit ECC by default. Under
this ECC scheme, multi-pass page programs result in a program error.
This means that unlike many other SPI NOR flashes, bit-walking cannot be
done. In other words, once a page is programmed, its bits cannot then be
flipped to 0 without an erase in between.

This causes problems with UBIFS because it uses bit-walking to clear EC
and VID magic numbers from a PEB before issuing an erase to preserve the
file system correctness in case of power cuts.

This series fixes that by setting mtd->writesize to the ECC block size
(16) and making sure UBIFS does not try to do a multi-pass write on
flashes with writesize > 1.

It is based on the xSPI/8D series that adds support for Cypress S28
flash [0] (it is in next now). The patches themselves are independent of
that series in the sense that they don't rely on 8D support. But since
S28 flash is not supported without that series, these patches don't make
much sense without it.

Tested on Cypress S28HS512T and MT35XU512ABA on J7200 and J721E
respectively.

[0] https://lore.kernel.org/linux-mtd/20201005153138.6437-1-p.yadav@ti.com/

Pratyush Yadav (3):
  UBI: Do not zero out EC and VID on ECC-ed NOR flashes
  mtd: spi-nor: core: Allow flashes to specify MTD writesize
  mtd: spi-nor: spansion: Set ECC block size

 drivers/mtd/spi-nor/core.c     | 4 +++-
 drivers/mtd/spi-nor/core.h     | 3 +++
 drivers/mtd/spi-nor/spansion.c | 1 +
 drivers/mtd/ubi/build.c        | 4 +---
 drivers/mtd/ubi/io.c           | 9 ++++++++-
 5 files changed, 16 insertions(+), 5 deletions(-)

--
2.28.0

