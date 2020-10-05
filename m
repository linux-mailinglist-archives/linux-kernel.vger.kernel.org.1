Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2ACFE2832B2
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 11:03:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725932AbgJEJDl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 05:03:41 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:33716 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725885AbgJEJDl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 05:03:41 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 09593UqQ117722;
        Mon, 5 Oct 2020 04:03:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1601888610;
        bh=34zB5rxU6oGZs0aqc0RCPFb2g/4HaIl26DX44jowZg0=;
        h=From:To:CC:Subject:Date;
        b=x0I55o1nHe4WURr1DGQW8EWhcmXIlf7fPM9nKXRuc78W6G/0s729Q4rPYQ5+AiJg2
         zxdbpnulNKbby/quBIltos1z1155+vIBU7w6Q1gHz38+nyAWqjv9UP5Dz5lSfUKoHS
         PvdqcjXh0EQuQdqFt4qvsTD9M1RKvsJQluLqs7Z0=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 09593U7B075801
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 5 Oct 2020 04:03:30 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 5 Oct
 2020 04:03:30 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 5 Oct 2020 04:03:30 -0500
Received: from ula0132425.ent.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 09593Rkr005614;
        Mon, 5 Oct 2020 04:03:27 -0500
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     Vignesh Raghavendra <vigneshr@ti.com>
CC:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Doug Anderson <dianders@chromium.org>,
        Michael Walle <michael@walle.cc>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] Revert "mtd: spi-nor: Prefer asynchronous probe"
Date:   Mon, 5 Oct 2020 14:33:21 +0530
Message-ID: <20201005090321.8724-1-vigneshr@ti.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 03edda0e1edaa3c2e99239c66e3c14d749318fd6.

This leads to warn dump like [1] on some platforms and reorders MTD
devices thus may break user space expectations. So revert the change.

[1]:

[    1.849801] ------------[ cut here ]------------
[    1.854271] mscc_felix 0000:00:00.5: device is disabled, skipping
[    1.858753] WARNING: CPU: 1 PID: 7 at kernel/kmod.c:136 __request_module+0x3a4/0x568

[...]

Reported-by: Michael Walle <michael@walle.cc>
Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
---
 drivers/mtd/spi-nor/core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index 2add4a01fce2..0369d98b2d12 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -3451,7 +3451,6 @@ static struct spi_mem_driver spi_nor_driver = {
 		.driver = {
 			.name = "spi-nor",
 			.of_match_table = spi_nor_of_table,
-			.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 		},
 		.id_table = spi_nor_dev_ids,
 	},
-- 
2.28.0

