Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14A8B27A992
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 10:35:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726655AbgI1Ie2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 04:34:28 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:41150 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726465AbgI1Ie1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 04:34:27 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08S8YNFM079679;
        Mon, 28 Sep 2020 03:34:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1601282063;
        bh=lAoyifoJt5Zlvh5uDnyEQfmzp70glWFb5P9ohB6bI/Y=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=hVCrmoQTrkXWM78yt5o15QbDOv530FHuIy6Lfb1Te8E3CVx/pLfPG1vUCEkGJzSmy
         6gpKc/tav3Lc1vtWU7vPhdGeSQJMfa8NYcwxq5UEhZ6X/hpoVJUqgUkJGuMeUE1O8o
         kWPyLvH15HuCxxyOJtm1HqcTayBr4jIfPKu9Tvpw=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08S8YNTE101441;
        Mon, 28 Sep 2020 03:34:23 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 28
 Sep 2020 03:34:22 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 28 Sep 2020 03:34:22 -0500
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08S8YEaU065485;
        Mon, 28 Sep 2020 03:34:21 -0500
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <nm@ti.com>, <t-kristo@ti.com>, <ssantosh@kernel.org>,
        <lokeshvutla@ti.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <grygorii.strashko@ti.com>
Subject: [PATCH 03/11] firmware: ti_sci: rm: Add support for second resource range
Date:   Mon, 28 Sep 2020 11:34:21 +0300
Message-ID: <20200928083429.17390-4-peter.ujfalusi@ti.com>
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

Sysfw added support for a second range in the resource range API to be able
to describe complex allocations mainly for DMA channels.

Update the ti_sci part to consider the second range as well.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/firmware/ti_sci.c              | 48 +++++++++++++++++---------
 drivers/firmware/ti_sci.h              |  8 +++--
 include/linux/soc/ti/ti_sci_protocol.h |  8 +++--
 3 files changed, 43 insertions(+), 21 deletions(-)

diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
index 7a777e91ce3e..2793bb923881 100644
--- a/drivers/firmware/ti_sci.c
+++ b/drivers/firmware/ti_sci.c
@@ -1751,11 +1751,14 @@ static int ti_sci_get_resource_range(const struct ti_sci_handle *handle,
 
 	if (!ti_sci_is_response_ack(resp)) {
 		ret = -ENODEV;
-	} else if (!resp->range_start && !resp->range_num) {
+	} else if (!resp->range_num && !resp->range_num_sec) {
+		/* Neither of the two resource range is valid */
 		ret = -ENODEV;
 	} else {
 		desc->start = resp->range_start;
 		desc->num = resp->range_num;
+		desc->start_sec = resp->range_start_sec;
+		desc->num_sec = resp->range_num_sec;
 	};
 
 fail:
@@ -3157,12 +3160,18 @@ u16 ti_sci_get_free_resource(struct ti_sci_resource *res)
 
 	raw_spin_lock_irqsave(&res->lock, flags);
 	for (set = 0; set < res->sets; set++) {
-		free_bit = find_first_zero_bit(res->desc[set].res_map,
-					       res->desc[set].num);
-		if (free_bit != res->desc[set].num) {
-			set_bit(free_bit, res->desc[set].res_map);
+		struct ti_sci_resource_desc *desc = &res->desc[set];
+		int res_count = desc->num + desc->num_sec;
+
+		free_bit = find_first_zero_bit(desc->res_map, res_count);
+		if (free_bit != res_count) {
+			set_bit(free_bit, desc->res_map);
 			raw_spin_unlock_irqrestore(&res->lock, flags);
-			return res->desc[set].start + free_bit;
+
+			if (desc->num && free_bit < desc->num)
+				return desc->start + free_bit;
+			else
+				return desc->start_sec + free_bit;
 		}
 	}
 	raw_spin_unlock_irqrestore(&res->lock, flags);
@@ -3183,10 +3192,14 @@ void ti_sci_release_resource(struct ti_sci_resource *res, u16 id)
 
 	raw_spin_lock_irqsave(&res->lock, flags);
 	for (set = 0; set < res->sets; set++) {
-		if (res->desc[set].start <= id &&
-		    (res->desc[set].num + res->desc[set].start) > id)
-			clear_bit(id - res->desc[set].start,
-				  res->desc[set].res_map);
+		struct ti_sci_resource_desc *desc = &res->desc[set];
+
+		if (desc->num && desc->start <= id &&
+		    (desc->start + desc->num) > id)
+			clear_bit(id - desc->start, desc->res_map);
+		else if (desc->num_sec && desc->start_sec <= id &&
+			 (desc->start_sec + desc->num_sec) > id)
+			clear_bit(id - desc->start_sec, desc->res_map);
 	}
 	raw_spin_unlock_irqrestore(&res->lock, flags);
 }
@@ -3203,7 +3216,7 @@ u32 ti_sci_get_num_resources(struct ti_sci_resource *res)
 	u32 set, count = 0;
 
 	for (set = 0; set < res->sets; set++)
-		count += res->desc[set].num;
+		count += res->desc[set].num + res->desc[set].num_sec;
 
 	return count;
 }
@@ -3227,7 +3240,7 @@ devm_ti_sci_get_resource_sets(const struct ti_sci_handle *handle,
 {
 	struct ti_sci_resource *res;
 	bool valid_set = false;
-	int i, ret;
+	int i, ret, res_count;
 
 	res = devm_kzalloc(dev, sizeof(*res), GFP_KERNEL);
 	if (!res)
@@ -3246,18 +3259,19 @@ devm_ti_sci_get_resource_sets(const struct ti_sci_handle *handle,
 		if (ret) {
 			dev_dbg(dev, "dev = %d subtype %d not allocated for this host\n",
 				dev_id, sub_types[i]);
-			res->desc[i].start = 0;
-			res->desc[i].num = 0;
+			memset(&res->desc[i], 0, sizeof(res->desc[i]));
 			continue;
 		}
 
-		dev_dbg(dev, "dev = %d, subtype = %d, start = %d, num = %d\n",
+		dev_dbg(dev, "dev/sub_type: %d/%d, start/num: %d/%d | %d/%d\n",
 			dev_id, sub_types[i], res->desc[i].start,
-			res->desc[i].num);
+			res->desc[i].num, res->desc[i].start_sec,
+			res->desc[i].num_sec);
 
 		valid_set = true;
+		res_count = res->desc[i].num + res->desc[i].num_sec;
 		res->desc[i].res_map =
-			devm_kzalloc(dev, BITS_TO_LONGS(res->desc[i].num) *
+			devm_kzalloc(dev, BITS_TO_LONGS(res_count) *
 				     sizeof(*res->desc[i].res_map), GFP_KERNEL);
 		if (!res->desc[i].res_map)
 			return ERR_PTR(-ENOMEM);
diff --git a/drivers/firmware/ti_sci.h b/drivers/firmware/ti_sci.h
index dca19ca5fc49..4d980eb592c4 100644
--- a/drivers/firmware/ti_sci.h
+++ b/drivers/firmware/ti_sci.h
@@ -574,8 +574,10 @@ struct ti_sci_msg_req_get_resource_range {
 /**
  * struct ti_sci_msg_resp_get_resource_range - Response to resource get range.
  * @hdr:		Generic Header
- * @range_start:	Start index of the resource range.
- * @range_num:		Number of resources in the range.
+ * @range_start:	Start index of the first resource range.
+ * @range_num:		Number of resources in the first range.
+ * @range_start_sec:	Start index of the second resource range.
+ * @range_num_sec:	Number of resources in the second range.
  *
  * Response to request TI_SCI_MSG_GET_RESOURCE_RANGE.
  */
@@ -583,6 +585,8 @@ struct ti_sci_msg_resp_get_resource_range {
 	struct ti_sci_msg_hdr hdr;
 	u16 range_start;
 	u16 range_num;
+	u16 range_start_sec;
+	u16 range_num_sec;
 } __packed;
 
 /**
diff --git a/include/linux/soc/ti/ti_sci_protocol.h b/include/linux/soc/ti/ti_sci_protocol.h
index 6cd537db4d33..9699b260de59 100644
--- a/include/linux/soc/ti/ti_sci_protocol.h
+++ b/include/linux/soc/ti/ti_sci_protocol.h
@@ -197,13 +197,17 @@ struct ti_sci_clk_ops {
 
 /**
  * struct ti_sci_resource_desc - Description of TI SCI resource instance range.
- * @start:	Start index of the resource.
- * @num:	Number of resources.
+ * @start:	Start index of the first resource range.
+ * @num:	Number of resources in the first range.
+ * @start_sec:	Start index of the second resource range.
+ * @num_sec:	Number of resources in the second range.
  * @res_map:	Bitmap to manage the allocation of these resources.
  */
 struct ti_sci_resource_desc {
 	u16 start;
 	u16 num;
+	u16 start_sec;
+	u16 num_sec;
 	unsigned long *res_map;
 };
 
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

