Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CC2227A996
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 10:35:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbgI1Iei (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 04:34:38 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:41254 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726640AbgI1Ied (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 04:34:33 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08S8YTMv079724;
        Mon, 28 Sep 2020 03:34:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1601282069;
        bh=JkWbt3U//J6ZHFKr80tAWtTm7r7VI/0UZGmj58qGTbc=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=SnpSCw8AfEn/zlL/Og107u/IqdxzcakMPSegtByGF3AINQ0Qppd7kBD/LdDqXUQ1H
         Nh5GTjQ5PH39sDXYFMeyUf+Em2jfZlBkBaPZHCu49i8Bl/Nr0f7ktqLY/jUVyXJPVk
         BzAHtPiHHRhCOr1ubVSpx/QLiT49rMzBwEWbvJaU=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 08S8YTPZ102045
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 28 Sep 2020 03:34:29 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 28
 Sep 2020 03:34:29 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 28 Sep 2020 03:34:29 -0500
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08S8YEaX065485;
        Mon, 28 Sep 2020 03:34:27 -0500
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <nm@ti.com>, <t-kristo@ti.com>, <ssantosh@kernel.org>,
        <lokeshvutla@ti.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <grygorii.strashko@ti.com>
Subject: [PATCH 06/11] firmware: ti_sci: rm: Remove ring_get_config support
Date:   Mon, 28 Sep 2020 11:34:24 +0300
Message-ID: <20200928083429.17390-7-peter.ujfalusi@ti.com>
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

The ring_get_cfg (0x1111 message) is not used and it is not supported by
sysfw for a long time.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/firmware/ti_sci.c              | 80 --------------------------
 drivers/firmware/ti_sci.h              | 44 --------------
 include/linux/soc/ti/ti_sci_protocol.h |  6 --
 3 files changed, 130 deletions(-)

diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
index 0dd3fbb4f964..0b801e67e672 100644
--- a/drivers/firmware/ti_sci.c
+++ b/drivers/firmware/ti_sci.c
@@ -2119,85 +2119,6 @@ static int ti_sci_cmd_ring_config(const struct ti_sci_handle *handle,
 	return ret;
 }
 
-/**
- * ti_sci_cmd_ring_get_config() - get RA ring configuration
- * @handle:	Pointer to TI SCI handle.
- * @nav_id:	Device ID of Navigator Subsystem from which the ring is
- *		allocated
- * @index:	Ring index
- * @addr_lo:	Returns ring's base address lo 32 bits
- * @addr_hi:	Returns ring's base address hi 32 bits
- * @count:	Returns number of ring elements
- * @mode:	Returns mode of the ring
- * @size:	Returns ring element size
- * @order_id:	Returns ring's bus order ID
- *
- * Return: 0 if all went well, else returns appropriate error value.
- *
- * See @ti_sci_msg_rm_ring_get_cfg_req for more info.
- */
-static int ti_sci_cmd_ring_get_config(const struct ti_sci_handle *handle,
-				      u32 nav_id, u32 index, u8 *mode,
-				      u32 *addr_lo, u32 *addr_hi,
-				      u32 *count, u8 *size, u8 *order_id)
-{
-	struct ti_sci_msg_rm_ring_get_cfg_resp *resp;
-	struct ti_sci_msg_rm_ring_get_cfg_req *req;
-	struct ti_sci_xfer *xfer;
-	struct ti_sci_info *info;
-	struct device *dev;
-	int ret = 0;
-
-	if (IS_ERR_OR_NULL(handle))
-		return -EINVAL;
-
-	info = handle_to_ti_sci_info(handle);
-	dev = info->dev;
-
-	xfer = ti_sci_get_one_xfer(info, TI_SCI_MSG_RM_RING_GET_CFG,
-				   TI_SCI_FLAG_REQ_ACK_ON_PROCESSED,
-				   sizeof(*req), sizeof(*resp));
-	if (IS_ERR(xfer)) {
-		ret = PTR_ERR(xfer);
-		dev_err(dev,
-			"RM_RA:Message get config failed(%d)\n", ret);
-		return ret;
-	}
-	req = (struct ti_sci_msg_rm_ring_get_cfg_req *)xfer->xfer_buf;
-	req->nav_id = nav_id;
-	req->index = index;
-
-	ret = ti_sci_do_xfer(info, xfer);
-	if (ret) {
-		dev_err(dev, "RM_RA:Mbox get config send fail %d\n", ret);
-		goto fail;
-	}
-
-	resp = (struct ti_sci_msg_rm_ring_get_cfg_resp *)xfer->xfer_buf;
-
-	if (!ti_sci_is_response_ack(resp)) {
-		ret = -ENODEV;
-	} else {
-		if (mode)
-			*mode = resp->mode;
-		if (addr_lo)
-			*addr_lo = resp->addr_lo;
-		if (addr_hi)
-			*addr_hi = resp->addr_hi;
-		if (count)
-			*count = resp->count;
-		if (size)
-			*size = resp->size;
-		if (order_id)
-			*order_id = resp->order_id;
-	};
-
-fail:
-	ti_sci_put_one_xfer(&info->minfo, xfer);
-	dev_dbg(dev, "RM_RA:get config ring %u ret:%d\n", index, ret);
-	return ret;
-}
-
 /**
  * ti_sci_cmd_rm_psil_pair() - Pair PSI-L source to destination thread
  * @handle:	Pointer to TI SCI handle.
@@ -2926,7 +2847,6 @@ static void ti_sci_setup_ops(struct ti_sci_info *info)
 	iops->free_event_map = ti_sci_cmd_free_event_map;
 
 	rops->config = ti_sci_cmd_ring_config;
-	rops->get_config = ti_sci_cmd_ring_get_config;
 
 	psilops->pair = ti_sci_cmd_rm_psil_pair;
 	psilops->unpair = ti_sci_cmd_rm_psil_unpair;
diff --git a/drivers/firmware/ti_sci.h b/drivers/firmware/ti_sci.h
index ca15d8f1f8de..1cdf918be861 100644
--- a/drivers/firmware/ti_sci.h
+++ b/drivers/firmware/ti_sci.h
@@ -49,7 +49,6 @@
 #define TI_SCI_MSG_RM_RING_RECONFIG		0x1102
 #define TI_SCI_MSG_RM_RING_RESET		0x1103
 #define TI_SCI_MSG_RM_RING_CFG			0x1110
-#define TI_SCI_MSG_RM_RING_GET_CFG		0x1111
 
 /* PSI-L requests */
 #define TI_SCI_MSG_RM_PSIL_PAIR			0x1280
@@ -687,49 +686,6 @@ struct ti_sci_msg_rm_ring_cfg_req {
 	u8 order_id;
 } __packed;
 
-/**
- * struct ti_sci_msg_rm_ring_get_cfg_req - Get RA ring's configuration
- *
- * Gets the configuration of the non-real-time register fields of a ring.  The
- * host, or a supervisor of the host, who owns the ring must be the requesting
- * host.  The values of the non-real-time registers are returned in
- * @ti_sci_msg_rm_ring_get_cfg_resp.
- *
- * @hdr: Generic Header
- * @nav_id: Device ID of Navigator Subsystem from which the ring is allocated
- * @index: ring index.
- */
-struct ti_sci_msg_rm_ring_get_cfg_req {
-	struct ti_sci_msg_hdr hdr;
-	u16 nav_id;
-	u16 index;
-} __packed;
-
-/**
- * struct ti_sci_msg_rm_ring_get_cfg_resp -  Ring get configuration response
- *
- * Response received by host processor after RM has handled
- * @ti_sci_msg_rm_ring_get_cfg_req. The response contains the ring's
- * non-real-time register values.
- *
- * @hdr: Generic Header
- * @addr_lo: Ring 32 LSBs of base address
- * @addr_hi: Ring 16 MSBs of base address.
- * @count: Ring number of elements.
- * @mode: Ring mode.
- * @size: encoded Ring element size
- * @order_id: ing order ID.
- */
-struct ti_sci_msg_rm_ring_get_cfg_resp {
-	struct ti_sci_msg_hdr hdr;
-	u32 addr_lo;
-	u32 addr_hi;
-	u32 count;
-	u8 mode;
-	u8 size;
-	u8 order_id;
-} __packed;
-
 /**
  * struct ti_sci_msg_psil_pair - Pairs a PSI-L source thread to a destination
  *				 thread
diff --git a/include/linux/soc/ti/ti_sci_protocol.h b/include/linux/soc/ti/ti_sci_protocol.h
index 6978afc00823..6710d7ac7a72 100644
--- a/include/linux/soc/ti/ti_sci_protocol.h
+++ b/include/linux/soc/ti/ti_sci_protocol.h
@@ -286,8 +286,6 @@ struct ti_sci_rm_irq_ops {
 /**
  * struct ti_sci_rm_ringacc_ops - Ring Accelerator Management operations
  * @config: configure the SoC Navigator Subsystem Ring Accelerator ring
- * @get_config: get the SoC Navigator Subsystem Ring Accelerator ring
- *		configuration
  */
 struct ti_sci_rm_ringacc_ops {
 	int (*config)(const struct ti_sci_handle *handle,
@@ -295,10 +293,6 @@ struct ti_sci_rm_ringacc_ops {
 		      u32 addr_lo, u32 addr_hi, u32 count, u8 mode,
 		      u8 size, u8 order_id
 	);
-	int (*get_config)(const struct ti_sci_handle *handle,
-			  u32 nav_id, u32 index, u8 *mode,
-			  u32 *addr_lo, u32 *addr_hi, u32 *count,
-			  u8 *size, u8 *order_id);
 };
 
 /**
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

