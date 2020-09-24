Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 637A9276B82
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 10:12:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727248AbgIXIMf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 04:12:35 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:57604 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727221AbgIXIMc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 04:12:32 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08O8CIxW072402;
        Thu, 24 Sep 2020 03:12:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1600935138;
        bh=xwH13LSwykyhSdyda27TbW05It0IDeIuKgx2/iPSsnU=;
        h=From:To:CC:Subject:Date;
        b=L3xPH5/qyQOf/iQ1HWeKCoaovvtdRpXA+eW8cK/VrK335wn3ZQgsQTpz7rN4ZLk1P
         R46oNsnkBfYtDyQHZGpjdC0/XtWZyCFXKaO6Jz3qZ3izkuHRfpsoh1uN5ME6JktBe6
         SaBypAhrQJKzijQ1Iy0wZSAw3T8qiIcOi/7mmo1E=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 08O8CIAh089362
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 24 Sep 2020 03:12:18 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 24
 Sep 2020 03:12:18 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 24 Sep 2020 03:12:18 -0500
Received: from ula0132425.ent.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08O8CFFH002000;
        Thu, 24 Sep 2020 03:12:16 -0500
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     Vignesh Raghavendra <vigneshr@ti.com>
CC:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2 0/4] mtd: hyperbus: hbmc-am654: Add DMA support
Date:   Thu, 24 Sep 2020 13:42:10 +0530
Message-ID: <20200924081214.16934-1-vigneshr@ti.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series add DMA support for reading data from HyperBus memory
devices for TI's AM654/J721e SoCs

With DMA there is ~5x improvement in read througput.

v2:
Fix DMAengine APIs usage issues pointed out by Peter.

Vignesh Raghavendra (4):
  mtd: hyperbus: Provide per device private pointer
  mtd: hyperbus: hbmc-am654: Fix direct mapping setup flash access
  mtd: hyperbus: hbmc-am654: Drop pm_runtime* calls from probe
  mtd: hyperbus: hbmc-am654: Add DMA support for reads

 drivers/mtd/hyperbus/hbmc-am654.c | 144 ++++++++++++++++++++++++++----
 include/linux/mtd/hyperbus.h      |   2 +
 2 files changed, 130 insertions(+), 16 deletions(-)

-- 
2.28.0

