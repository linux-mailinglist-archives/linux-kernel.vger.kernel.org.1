Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49BEE276B84
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 10:12:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727235AbgIXIMd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 04:12:33 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:57598 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727013AbgIXIMc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 04:12:32 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08O8CK4Q072428;
        Thu, 24 Sep 2020 03:12:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1600935140;
        bh=GQf2mrBMP5jSalqwKWbonLXiaPuvhMhO6Zn1bvzCtGE=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=NWdH8IM+m1k8nIltflNo0Oa2fyM+sJMhKopNjdM4nyKL+V2u/MfAZPV/2oNgOJjJP
         wuL5gJlGPRE73pvo/YfbxLUnlpxD7zAfyE3aKTkh73gIi0yUyc4DOK04jfiGec/gRc
         Qufds+7aoldYI/fVL9g+QRhVd9zMI1BAO2EKBQsU=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 08O8CKL5082890
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 24 Sep 2020 03:12:20 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 24
 Sep 2020 03:12:20 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 24 Sep 2020 03:12:20 -0500
Received: from ula0132425.ent.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08O8CFFI002000;
        Thu, 24 Sep 2020 03:12:18 -0500
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     Vignesh Raghavendra <vigneshr@ti.com>
CC:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2 1/4] mtd: hyperbus: Provide per device private pointer
Date:   Thu, 24 Sep 2020 13:42:11 +0530
Message-ID: <20200924081214.16934-2-vigneshr@ti.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200924081214.16934-1-vigneshr@ti.com>
References: <20200924081214.16934-1-vigneshr@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide per device private pointer that can be used by controller
drivers to store device specific private data.

Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
---
 include/linux/mtd/hyperbus.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/mtd/hyperbus.h b/include/linux/mtd/hyperbus.h
index 2129f7d3b6eb..d8cb1aec826d 100644
--- a/include/linux/mtd/hyperbus.h
+++ b/include/linux/mtd/hyperbus.h
@@ -20,6 +20,7 @@ enum hyperbus_memtype {
  * @mtd: pointer to MTD struct
  * @ctlr: pointer to HyperBus controller struct
  * @memtype: type of memory device: HyperFlash or HyperRAM
+ * @priv: pointer to controller specific per device private data
  */
 
 struct hyperbus_device {
@@ -28,6 +29,7 @@ struct hyperbus_device {
 	struct mtd_info *mtd;
 	struct hyperbus_ctlr *ctlr;
 	enum hyperbus_memtype memtype;
+	void *priv;
 };
 
 /**
-- 
2.28.0

