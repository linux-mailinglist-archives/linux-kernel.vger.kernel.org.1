Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43F68287399
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 13:52:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728990AbgJHLwU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 07:52:20 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:36692 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728536AbgJHLwR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 07:52:17 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 098BqA8Y072973;
        Thu, 8 Oct 2020 06:52:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1602157930;
        bh=hEpI9BOlL/6hRHdawgkAaZESrEiT4XahjCyAND4NstY=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=WFiu0n4t3Jcb6gMwgyfBGcMWUdxikl2Ajh6ZfFtsvsx1duBn5/lx0Q/ln3B8ukZXl
         xoNHWvsg0102t0QmVA71XvWWsaEZvZLzrqrRvr3iuKZa3cJl9TABYqOXmuE3b9fuLj
         z+d6hv1Y8p4NhgV7LAlf1cQEO6EKEqLrji+IkbwE=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 098BqAj2085456
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 8 Oct 2020 06:52:10 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 8 Oct
 2020 06:52:10 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 8 Oct 2020 06:52:10 -0500
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 098Bq3s4083508;
        Thu, 8 Oct 2020 06:52:08 -0500
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <nm@ti.com>, <t-kristo@ti.com>, <ssantosh@kernel.org>,
        <lokeshvutla@ti.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <grygorii.strashko@ti.com>
Subject: [PATCH v2 02/11] firmware: ti_sci: Use struct ti_sci_resource_desc in get_range ops
Date:   Thu, 8 Oct 2020 14:52:15 +0300
Message-ID: <20201008115224.1591-3-peter.ujfalusi@ti.com>
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

Use the ti_sci_resource_desc directly and update it's start and num members
directly instead of requiring individual parameters for them.

This will allow easy extension of the RM parameters without changing API.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/firmware/ti_sci.c              | 32 ++++++++++++--------------
 include/linux/soc/ti/ti_sci_protocol.h | 32 +++++++++++++-------------
 2 files changed, 31 insertions(+), 33 deletions(-)

diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
index 65a8c2e82093..7a777e91ce3e 100644
--- a/drivers/firmware/ti_sci.c
+++ b/drivers/firmware/ti_sci.c
@@ -1703,14 +1703,14 @@ static int ti_sci_cmd_core_reboot(const struct ti_sci_handle *handle)
  * @subtype:		Resource assignment subtype that is being requested
  *			from the given device.
  * @s_host:		Host processor ID to which the resources are allocated
- * @range_start:	Start index of the resource range
- * @range_num:		Number of resources in the range
+ * @desc:		Pointer to ti_sci_resource_desc to be updated with the
+ *			resource range start index and number of resources
  *
  * Return: 0 if all went fine, else return appropriate error.
  */
 static int ti_sci_get_resource_range(const struct ti_sci_handle *handle,
 				     u32 dev_id, u8 subtype, u8 s_host,
-				     u16 *range_start, u16 *range_num)
+				     struct ti_sci_resource_desc *desc)
 {
 	struct ti_sci_msg_resp_get_resource_range *resp;
 	struct ti_sci_msg_req_get_resource_range *req;
@@ -1721,7 +1721,7 @@ static int ti_sci_get_resource_range(const struct ti_sci_handle *handle,
 
 	if (IS_ERR(handle))
 		return PTR_ERR(handle);
-	if (!handle)
+	if (!handle || !desc)
 		return -EINVAL;
 
 	info = handle_to_ti_sci_info(handle);
@@ -1754,8 +1754,8 @@ static int ti_sci_get_resource_range(const struct ti_sci_handle *handle,
 	} else if (!resp->range_start && !resp->range_num) {
 		ret = -ENODEV;
 	} else {
-		*range_start = resp->range_start;
-		*range_num = resp->range_num;
+		desc->start = resp->range_start;
+		desc->num = resp->range_num;
 	};
 
 fail:
@@ -1771,18 +1771,18 @@ static int ti_sci_get_resource_range(const struct ti_sci_handle *handle,
  * @dev_id:		TISCI device ID.
  * @subtype:		Resource assignment subtype that is being requested
  *			from the given device.
- * @range_start:	Start index of the resource range
- * @range_num:		Number of resources in the range
+ * @desc:		Pointer to ti_sci_resource_desc to be updated with the
+ *			resource range start index and number of resources
  *
  * Return: 0 if all went fine, else return appropriate error.
  */
 static int ti_sci_cmd_get_resource_range(const struct ti_sci_handle *handle,
 					 u32 dev_id, u8 subtype,
-					 u16 *range_start, u16 *range_num)
+					 struct ti_sci_resource_desc *desc)
 {
 	return ti_sci_get_resource_range(handle, dev_id, subtype,
 					 TI_SCI_IRQ_SECONDARY_HOST_INVALID,
-					 range_start, range_num);
+					 desc);
 }
 
 /**
@@ -1793,18 +1793,17 @@ static int ti_sci_cmd_get_resource_range(const struct ti_sci_handle *handle,
  * @subtype:		Resource assignment subtype that is being requested
  *			from the given device.
  * @s_host:		Host processor ID to which the resources are allocated
- * @range_start:	Start index of the resource range
- * @range_num:		Number of resources in the range
+ * @desc:		Pointer to ti_sci_resource_desc to be updated with the
+ *			resource range start index and number of resources
  *
  * Return: 0 if all went fine, else return appropriate error.
  */
 static
 int ti_sci_cmd_get_resource_range_from_shost(const struct ti_sci_handle *handle,
 					     u32 dev_id, u8 subtype, u8 s_host,
-					     u16 *range_start, u16 *range_num)
+					     struct ti_sci_resource_desc *desc)
 {
-	return ti_sci_get_resource_range(handle, dev_id, subtype, s_host,
-					 range_start, range_num);
+	return ti_sci_get_resource_range(handle, dev_id, subtype, s_host, desc);
 }
 
 /**
@@ -3243,8 +3242,7 @@ devm_ti_sci_get_resource_sets(const struct ti_sci_handle *handle,
 	for (i = 0; i < res->sets; i++) {
 		ret = handle->ops.rm_core_ops.get_range(handle, dev_id,
 							sub_types[i],
-							&res->desc[i].start,
-							&res->desc[i].num);
+							&res->desc[i]);
 		if (ret) {
 			dev_dbg(dev, "dev = %d subtype %d not allocated for this host\n",
 				dev_id, sub_types[i]);
diff --git a/include/linux/soc/ti/ti_sci_protocol.h b/include/linux/soc/ti/ti_sci_protocol.h
index d254d99fd45b..6cd537db4d33 100644
--- a/include/linux/soc/ti/ti_sci_protocol.h
+++ b/include/linux/soc/ti/ti_sci_protocol.h
@@ -195,6 +195,18 @@ struct ti_sci_clk_ops {
 			u64 *current_freq);
 };
 
+/**
+ * struct ti_sci_resource_desc - Description of TI SCI resource instance range.
+ * @start:	Start index of the resource.
+ * @num:	Number of resources.
+ * @res_map:	Bitmap to manage the allocation of these resources.
+ */
+struct ti_sci_resource_desc {
+	u16 start;
+	u16 num;
+	unsigned long *res_map;
+};
+
 /**
  * struct ti_sci_rm_core_ops - Resource management core operations
  * @get_range:		Get a range of resources belonging to ti sci host.
@@ -209,15 +221,15 @@ struct ti_sci_clk_ops {
  * - dev_id:	TISCI device ID.
  * - subtype:	Resource assignment subtype that is being requested
  *		from the given device.
- * - range_start:	Start index of the resource range
- * - range_end:		Number of resources in the range
+ * - desc:	Pointer to ti_sci_resource_desc to be updated with the resource
+ *		range start index and number of resources
  */
 struct ti_sci_rm_core_ops {
 	int (*get_range)(const struct ti_sci_handle *handle, u32 dev_id,
-			 u8 subtype, u16 *range_start, u16 *range_num);
+			 u8 subtype, struct ti_sci_resource_desc *desc);
 	int (*get_range_from_shost)(const struct ti_sci_handle *handle,
 				    u32 dev_id, u8 subtype, u8 s_host,
-				    u16 *range_start, u16 *range_num);
+				    struct ti_sci_resource_desc *desc);
 };
 
 #define TI_SCI_RESASG_SUBTYPE_IR_OUTPUT		0
@@ -522,18 +534,6 @@ struct ti_sci_handle {
 
 #define TI_SCI_RESOURCE_NULL	0xffff
 
-/**
- * struct ti_sci_resource_desc - Description of TI SCI resource instance range.
- * @start:	Start index of the resource.
- * @num:	Number of resources.
- * @res_map:	Bitmap to manage the allocation of these resources.
- */
-struct ti_sci_resource_desc {
-	u16 start;
-	u16 num;
-	unsigned long *res_map;
-};
-
 /**
  * struct ti_sci_resource - Structure representing a resource assigned
  *			    to a device.
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

