Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDCD628BF55
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 20:04:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404155AbgJLSEa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 14:04:30 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:58586 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404127AbgJLSE0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 14:04:26 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 09CI4BDZ055219;
        Mon, 12 Oct 2020 13:04:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1602525851;
        bh=azEppzwQrP6Fp1xWnR9MjTTXT2K8wTwQGMzH5evrkQw=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=fW/0kdqWG2irn8/SYs1V3aJT/mlvi+npXEAejaS38XZLZTmR4tQfO6sY3BgerhngN
         y9w9h/FwpBi5xdFlqDtmiRV3Ng+HjYIfc/7/j5nllorJSPqI7GnjdlotTKPONIbieu
         6ikVqHixgZikyKmo+TxtfFpfvhH7E3ZCOOx1v7Go=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 09CI4BZZ100729
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 12 Oct 2020 13:04:11 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 12
 Oct 2020 13:04:10 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 12 Oct 2020 13:04:10 -0500
Received: from pratyush-OptiPlex-790.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 09CI45j3021531;
        Mon, 12 Oct 2020 13:04:08 -0500
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC:     Pratyush Yadav <p.yadav@ti.com>
Subject: [PATCH 1/3] mtd: abi: Introduce MTD_NO_MULTI_PASS_WRITE
Date:   Mon, 12 Oct 2020 23:34:02 +0530
Message-ID: <20201012180404.6476-2-p.yadav@ti.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201012180404.6476-1-p.yadav@ti.com>
References: <20201012180404.6476-1-p.yadav@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some flashes like the Semper S28 family do not support multi-pass page
programming. Introduce the flag MTD_NO_MULTI_PASS_WRITE to allow telling
upper layers this information so they can issue write commands with this
limitation in mind.

Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
---
 include/uapi/mtd/mtd-abi.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/uapi/mtd/mtd-abi.h b/include/uapi/mtd/mtd-abi.h
index 65b9db936557..a2cab30adac5 100644
--- a/include/uapi/mtd/mtd-abi.h
+++ b/include/uapi/mtd/mtd-abi.h
@@ -105,6 +105,7 @@ struct mtd_write_req {
 #define MTD_NO_ERASE		0x1000	/* No erase necessary */
 #define MTD_POWERUP_LOCK	0x2000	/* Always locked after reset */
 #define MTD_SLC_ON_MLC_EMULATION 0x4000	/* Emulate SLC behavior on MLC NANDs */
+#define MTD_NO_MULTI_PASS_WRITE	0x8000
 
 /* Some common devices / combinations of capabilities */
 #define MTD_CAP_ROM		0
-- 
2.28.0

