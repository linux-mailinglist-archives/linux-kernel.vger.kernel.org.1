Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC9D928AECD
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 09:11:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726456AbgJLHLI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 03:11:08 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:37930 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726530AbgJLHLI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 03:11:08 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 09C7B0B1122440;
        Mon, 12 Oct 2020 02:11:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1602486660;
        bh=olIcJ+cdar4sP++7ZrYXeWOA+vMGcs0CLq2nJqrcTaY=;
        h=From:To:CC:Subject:Date;
        b=Wh5EAKInp5rx4/Z+9tGoVCl4cEu46Fpfo1CdefxuvICpCetczWwz3U7aV1OGYuXVE
         OlsqZXVcoKxWXhb+3gbaD06g+wfp1c1bPD21CinKQ8SM96rhC4kpqpACmm1nJIxfrZ
         wZLMCvJpDaX19B7yoNDt4nDsuX03DpX1iXdn7HMI=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 09C7B0xZ039416
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 12 Oct 2020 02:11:00 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 12
 Oct 2020 02:11:00 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 12 Oct 2020 02:11:00 -0500
Received: from ula0132425.ent.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 09C7Avkj111749;
        Mon, 12 Oct 2020 02:10:58 -0500
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     Vignesh Raghavendra <vigneshr@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>
CC:     Sergei Shtylyov <sergei.shtylyov@gmail.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] mtd: hyperbus: Fix build failure when only RPCIF_HYPERBUS is enabled
Date:   Mon, 12 Oct 2020 12:39:58 +0530
Message-ID: <20201012070958.11083-1-vigneshr@ti.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit 5de15b610f78 ("mtd: hyperbus: add Renesas RPC-IF driver") leads
to build failure[1] with COMPILE_TEST and RPCIF_HYPERBUS enabled. This
is because driver needs functions RENESAS_RPCIF which is only buildable
for CONFIG_ARCH_RENESAS.

Fix this by dropping COMPILE_TEST from RPCIF_HYPERBUS Kconfig entry.
This ensures driver can be built only when RENESAS_RPCIF is also
selected.

[1]:
rpc-if.c:(.text+0x20): undefined reference to `rpcif_disable_rpm' ld:
drivers/mtd/hyperbus/rpc-if.o: in function `rpcif_hb_prepare_read':
rpc-if.c:(.text+0xd6): undefined reference to `rpcif_prepare' ld:
drivers/mtd/hyperbus/rpc-if.o: in function `rpcif_hb_read16':
[...]

Fixes: 5de15b610f78 ("mtd: hyperbus: add Renesas RPC-IF driver") leads
Reported-by: Richard Weinberger <richard@nod.at>
Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
---

Based on mtd/next

Richard,

Could you please pull this into mtd/next?

 drivers/mtd/hyperbus/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/hyperbus/Kconfig b/drivers/mtd/hyperbus/Kconfig
index 35b3ab4c8b94..46c7e407e378 100644
--- a/drivers/mtd/hyperbus/Kconfig
+++ b/drivers/mtd/hyperbus/Kconfig
@@ -24,7 +24,7 @@ config HBMC_AM654
 
 config RPCIF_HYPERBUS
 	tristate "Renesas RPC-IF HyperBus driver"
-	depends on RENESAS_RPCIF || COMPILE_TEST
+	depends on RENESAS_RPCIF
 	depends on MTD_CFI_BE_BYTE_SWAP
 	help
 	  This option includes Renesas RPC-IF HyperBus support.
-- 
2.28.0

