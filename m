Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB01428739A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 13:52:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729346AbgJHLwZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 07:52:25 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:59736 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728919AbgJHLwT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 07:52:19 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 098BqFw9025509;
        Thu, 8 Oct 2020 06:52:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1602157935;
        bh=JOorC5F8hzcYVcpHhobJkf0YVM1DB38ExWrHjz/Qmvw=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=ZJ2Clyg1P+lgxFBEqugXDXNXyeZzpVlCvslTyK90prqAlvfvh2kALCB6uGHxFZ8ji
         lEKv01GMTUiaTXX02q/xV4+1mFs9NUv9nBxMQphlsBqr8gSlclZq42I6M7EDTrsNfr
         oUu49uDHGrtHcHJz5sCZaiN13Na5DF76efpa5BVY=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 098BqEpE034340
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 8 Oct 2020 06:52:14 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 8 Oct
 2020 06:52:14 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 8 Oct 2020 06:52:14 -0500
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 098Bq3s6083508;
        Thu, 8 Oct 2020 06:52:12 -0500
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <nm@ti.com>, <t-kristo@ti.com>, <ssantosh@kernel.org>,
        <lokeshvutla@ti.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <grygorii.strashko@ti.com>
Subject: [PATCH v2 04/11] soc: ti: ti_sci_inta_msi: Add support for second range in resource ranges
Date:   Thu, 8 Oct 2020 14:52:17 +0300
Message-ID: <20201008115224.1591-5-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201008115224.1591-1-peter.ujfalusi@ti.com>
References: <20201008115224.1591-1-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allocate MSI entries for both first and second range if they are valid

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/soc/ti/ti_sci_inta_msi.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/soc/ti/ti_sci_inta_msi.c b/drivers/soc/ti/ti_sci_inta_msi.c
index 0eb9462f609e..a1d9c027022a 100644
--- a/drivers/soc/ti/ti_sci_inta_msi.c
+++ b/drivers/soc/ti/ti_sci_inta_msi.c
@@ -89,6 +89,18 @@ static int ti_sci_inta_msi_alloc_descs(struct device *dev,
 			list_add_tail(&msi_desc->list, dev_to_msi_list(dev));
 			count++;
 		}
+		for (i = 0; i < res->desc[set].num_sec; i++) {
+			msi_desc = alloc_msi_entry(dev, 1, NULL);
+			if (!msi_desc) {
+				ti_sci_inta_msi_free_descs(dev);
+				return -ENOMEM;
+			}
+
+			msi_desc->inta.dev_index = res->desc[set].start_sec + i;
+			INIT_LIST_HEAD(&msi_desc->list);
+			list_add_tail(&msi_desc->list, dev_to_msi_list(dev));
+			count++;
+		}
 	}
 
 	return count;
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

