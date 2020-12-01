Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 650A92C9F2A
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 11:29:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729815AbgLAK3B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 05:29:01 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:47086 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726998AbgLAK3A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 05:29:00 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0B1ARFoF026753;
        Tue, 1 Dec 2020 04:27:15 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1606818435;
        bh=dzMlfGnG8XmlsSokD5RUWqJd9nznHlbq2+gpDGLKO48=;
        h=From:To:CC:Subject:Date;
        b=dSPRwwKd4jtX3qiI4RHJJZ/9fh14BfSWgoK2Po+SBnVZ8so7MqQ6Rf0GhBGZxM6k6
         8cAtKQxpdYmDa3dU0Dhvmxfi/qqsuSpuq9pkudLVDR7WQM04FTxCi5q+EZm5z/XYJ8
         p8ZO547RselZoRC1yp/40d5zmm52KOX2i2PU42Zg=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0B1ARFmq095872
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 1 Dec 2020 04:27:15 -0600
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 1 Dec
 2020 04:27:15 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 1 Dec 2020 04:27:15 -0600
Received: from pratyush-OptiPlex-790.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0B1ARCuY080862;
        Tue, 1 Dec 2020 04:27:13 -0600
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC:     Pratyush Yadav <p.yadav@ti.com>
Subject: [PATCH v3 0/3] mtd: Make sure UBIFS does not do multi-pass page programming on flashes that don't support it
Date:   Tue, 1 Dec 2020 15:57:08 +0530
Message-ID: <20201201102711.8727-1-p.yadav@ti.com>
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

 drivers/mtd/spi-nor/core.c     | 3 ++-
 drivers/mtd/spi-nor/core.h     | 3 +++
 drivers/mtd/spi-nor/spansion.c | 1 +
 drivers/mtd/ubi/build.c        | 4 +---
 drivers/mtd/ubi/io.c           | 9 ++++++++-
 5 files changed, 15 insertions(+), 5 deletions(-)

--
2.28.0

