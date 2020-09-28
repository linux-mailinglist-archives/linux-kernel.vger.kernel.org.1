Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9928A27A995
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 10:35:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbgI1Ief (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 04:34:35 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:41162 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726645AbgI1Ie2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 04:34:28 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08S8YPc1079694;
        Mon, 28 Sep 2020 03:34:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1601282065;
        bh=JOorC5F8hzcYVcpHhobJkf0YVM1DB38ExWrHjz/Qmvw=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=IKanf8I5gFVq2KXJjWRMmJISt16PvcOvD+IGlojtm/ceF7LNcOBVP7p1hny+6Coxn
         XF3RkAtWS08+4r5qkz9teGsNmmnL7KJuv3gVYbfP/5qfz/+mYBJ6hdA75EoIPCUYnx
         qBmiOvzipUm4Z1JPBkF7Ih3Jlo51DtFnddSeZUYo=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08S8YPvi101473;
        Mon, 28 Sep 2020 03:34:25 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 28
 Sep 2020 03:34:25 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 28 Sep 2020 03:34:25 -0500
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08S8YEaV065485;
        Mon, 28 Sep 2020 03:34:23 -0500
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <nm@ti.com>, <t-kristo@ti.com>, <ssantosh@kernel.org>,
        <lokeshvutla@ti.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <grygorii.strashko@ti.com>
Subject: [PATCH 04/11] soc: ti: ti_sci_inta_msi: Add support for second range in resource ranges
Date:   Mon, 28 Sep 2020 11:34:22 +0300
Message-ID: <20200928083429.17390-5-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200928083429.17390-1-peter.ujfalusi@ti.com>
References: <20200928083429.17390-1-peter.ujfalusi@ti.com>
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

