Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BB0528BF5A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 20:04:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404149AbgJLSEa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 14:04:30 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:58592 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404138AbgJLSE1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 14:04:27 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 09CI48q7055209;
        Mon, 12 Oct 2020 13:04:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1602525848;
        bh=ueTk+NXUctZm45WSAn64xT320s7C7sPFAPrludm8rhA=;
        h=From:To:CC:Subject:Date;
        b=yBJLGoVCIfUK24UfG/ogh6qS62wqpKEpkfU2yGmH4UpBS9toH/VjbT54px8KYAyb1
         em3APbdkZYxCKSJs1bnSYD6RiM5QjcKyJJroMOHXHgK0SayH4DJouGHOnnrdaqcsql
         JJwqKLB1IjO0frGUf0hwQe40hPoeKETxrT1271Jg=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 09CI481F100700
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 12 Oct 2020 13:04:08 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 12
 Oct 2020 13:04:08 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 12 Oct 2020 13:04:08 -0500
Received: from pratyush-OptiPlex-790.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 09CI45j2021531;
        Mon, 12 Oct 2020 13:04:06 -0500
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC:     Pratyush Yadav <p.yadav@ti.com>
Subject: [PATCH 0/3] mtd: Make sure UBIFS does not do multi-pass page programming on flashes that don't support it
Date:   Mon, 12 Oct 2020 23:34:01 +0530
Message-ID: <20201012180404.6476-1-p.yadav@ti.com>
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

This series fixes that problem by introducing a flag
MTD_NO_MULTI_PASS_WRITE that tells the file system layer that it can't
do multi-pass writes. It also sets the writesize to the page size for
such flashes to make sure file systems know that they should write the
entire page in one go.

It is based on the xSPI/8D series that adds support for Cypress S28
flash [0]. The patches themselves are independent of that series in the
sense that they don't rely on 8D support. But since S28 flash is not
supported without that series, these patches don't make much sense
without it.

Tested on Cypress S28HS512T and MT35XU512ABA on J7200 and J721E
respectively.

[0] https://lore.kernel.org/linux-mtd/20201005153138.6437-1-p.yadav@ti.com/

Pratyush Yadav (3):
  mtd: abi: Introduce MTD_NO_MULTI_PASS_WRITE
  UBI: Do not zero out EC and VID when multi-pass writes are not
    supported
  mtd: spi-nor: core: Introduce SPI_NOR_NO_MULTI_PASS_PP

 drivers/mtd/spi-nor/core.c     | 5 +++++
 drivers/mtd/spi-nor/core.h     | 6 ++++++
 drivers/mtd/spi-nor/spansion.c | 2 +-
 drivers/mtd/ubi/io.c           | 2 +-
 include/uapi/mtd/mtd-abi.h     | 1 +
 5 files changed, 14 insertions(+), 2 deletions(-)

--
2.28.0

