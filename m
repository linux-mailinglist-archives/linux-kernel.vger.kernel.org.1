Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62ED426D5C4
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 10:08:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726250AbgIQIIk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 04:08:40 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:57678 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726455AbgIQIH5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 04:07:57 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08H7mJhn109035;
        Thu, 17 Sep 2020 02:48:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1600328899;
        bh=GQf2mrBMP5jSalqwKWbonLXiaPuvhMhO6Zn1bvzCtGE=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=SiWSIe++RtO9/1LZxTiUV6d4hNOgna3Co3TJtBBUp5/6ygS8qhOhu0coMs6RawyAt
         DqZmAMdfw2SM9j4cWAzUOUacx2f+1euC2CJBA5oHmYF2sPusFYag9Dzd6O5AEe8OjO
         njdBnuidc91XrN8pQWl+rmN4FGH7CooYVZ9T/hUQ=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 08H7mJmW102251
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 17 Sep 2020 02:48:19 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 17
 Sep 2020 02:48:19 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 17 Sep 2020 02:48:19 -0500
Received: from ula0132425.ent.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08H7mEds100359;
        Thu, 17 Sep 2020 02:48:17 -0500
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     Vignesh Raghavendra <vigneshr@ti.com>
CC:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Sergei Shtylyov <sergei.shtylyov@gmail.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/4] mtd: hyperbus: Provide per device private pointer
Date:   Thu, 17 Sep 2020 13:17:46 +0530
Message-ID: <20200917074749.8957-2-vigneshr@ti.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200917074749.8957-1-vigneshr@ti.com>
References: <20200917074749.8957-1-vigneshr@ti.com>
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

