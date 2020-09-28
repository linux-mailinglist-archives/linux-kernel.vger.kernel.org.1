Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D17A927A99C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 10:35:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbgI1Ie4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 04:34:56 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:41346 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726711AbgI1Ieg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 04:34:36 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08S8YVZL079796;
        Mon, 28 Sep 2020 03:34:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1601282071;
        bh=QJeXJSqxR+aNF61B4iKfC/af4ZZd3H/jLPKXTIJ+Si4=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=YdQ36YuchrIkLMB9gRPxn/D7wOqfJFXkyEJtJcOiik1XkKPJmEUb79lUXkTW9KXsX
         gw74w0guQP1/WoORnSlSPtk1FLPJc7ipN2fPrIln2F/RMS7N1cwSfr/z8IIpJs0y9j
         oOOCqVdaHzMJ8l1qBDvdjpHnzHEyr4tGjH5wKBUk=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 08S8YVPv124435
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 28 Sep 2020 03:34:31 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 28
 Sep 2020 03:34:31 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 28 Sep 2020 03:34:31 -0500
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08S8YEaY065485;
        Mon, 28 Sep 2020 03:34:29 -0500
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <nm@ti.com>, <t-kristo@ti.com>, <ssantosh@kernel.org>,
        <lokeshvutla@ti.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <grygorii.strashko@ti.com>
Subject: [PATCH 07/11] firmware: ti_sci: rm: Add new ops for ring configuration
Date:   Mon, 28 Sep 2020 11:34:25 +0300
Message-ID: <20200928083429.17390-8-peter.ujfalusi@ti.com>
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

The sysfw ring configuration message has been extended to include virtid
and asel value for the ring.
Add the ASEL_VALID to TI_SCI_MSG_VALUE_RM_ALL_NO_ORDER as it is required
for DMA rings.

Instead of extending the current .config() ops - which would need same
patch change in the ringacc driver - add ti_sci_msg_rm_ring_cfg struct and
a new ops using it to configure the ring.

This will allow easy update path in case new members are added for the ring
configuration.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/firmware/ti_sci.c              | 63 ++++++++++++++++++++++++++
 drivers/firmware/ti_sci.h              |  7 +++
 include/linux/soc/ti/ti_sci_protocol.h | 31 ++++++++++++-
 3 files changed, 100 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
index 0b801e67e672..a4d2b318795c 100644
--- a/drivers/firmware/ti_sci.c
+++ b/drivers/firmware/ti_sci.c
@@ -2119,6 +2119,68 @@ static int ti_sci_cmd_ring_config(const struct ti_sci_handle *handle,
 	return ret;
 }
 
+/**
+ * ti_sci_cmd_rm_ring_cfg() - Configure a NAVSS ring
+ * @handle:	Pointer to TI SCI handle.
+ * @params:	Pointer to ti_sci_msg_rm_ring_cfg ring config structure
+ *
+ * Return: 0 if all went well, else returns appropriate error value.
+ *
+ * See @ti_sci_msg_rm_ring_cfg and @ti_sci_msg_rm_ring_cfg_req for
+ * more info.
+ */
+static int ti_sci_cmd_rm_ring_cfg(const struct ti_sci_handle *handle,
+				  const struct ti_sci_msg_rm_ring_cfg *params)
+{
+	struct ti_sci_msg_rm_ring_cfg_req *req;
+	struct ti_sci_msg_hdr *resp;
+	struct ti_sci_xfer *xfer;
+	struct ti_sci_info *info;
+	struct device *dev;
+	int ret = 0;
+
+	if (IS_ERR_OR_NULL(handle))
+		return -EINVAL;
+
+	info = handle_to_ti_sci_info(handle);
+	dev = info->dev;
+
+	xfer = ti_sci_get_one_xfer(info, TI_SCI_MSG_RM_RING_CFG,
+				   TI_SCI_FLAG_REQ_ACK_ON_PROCESSED,
+				   sizeof(*req), sizeof(*resp));
+	if (IS_ERR(xfer)) {
+		ret = PTR_ERR(xfer);
+		dev_err(dev, "RM_RA:Message config failed(%d)\n", ret);
+		return ret;
+	}
+	req = (struct ti_sci_msg_rm_ring_cfg_req *)xfer->xfer_buf;
+	req->valid_params = params->valid_params;
+	req->nav_id = params->nav_id;
+	req->index = params->index;
+	req->addr_lo = params->addr_lo;
+	req->addr_hi = params->addr_hi;
+	req->count = params->count;
+	req->mode = params->mode;
+	req->size = params->size;
+	req->order_id = params->order_id;
+	req->virtid = params->virtid;
+	req->asel = params->asel;
+
+	ret = ti_sci_do_xfer(info, xfer);
+	if (ret) {
+		dev_err(dev, "RM_RA:Mbox config send fail %d\n", ret);
+		goto fail;
+	}
+
+	resp = (struct ti_sci_msg_hdr *)xfer->xfer_buf;
+	ret = ti_sci_is_response_ack(resp) ? 0 : -EINVAL;
+
+fail:
+	ti_sci_put_one_xfer(&info->minfo, xfer);
+	dev_dbg(dev, "RM_RA:config ring %u ret:%d\n", params->index, ret);
+	return ret;
+}
+
 /**
  * ti_sci_cmd_rm_psil_pair() - Pair PSI-L source to destination thread
  * @handle:	Pointer to TI SCI handle.
@@ -2847,6 +2909,7 @@ static void ti_sci_setup_ops(struct ti_sci_info *info)
 	iops->free_event_map = ti_sci_cmd_free_event_map;
 
 	rops->config = ti_sci_cmd_ring_config;
+	rops->set_cfg = ti_sci_cmd_rm_ring_cfg;
 
 	psilops->pair = ti_sci_cmd_rm_psil_pair;
 	psilops->unpair = ti_sci_cmd_rm_psil_unpair;
diff --git a/drivers/firmware/ti_sci.h b/drivers/firmware/ti_sci.h
index 1cdf918be861..ef3a8214d002 100644
--- a/drivers/firmware/ti_sci.h
+++ b/drivers/firmware/ti_sci.h
@@ -659,6 +659,8 @@ struct ti_sci_msg_req_manage_irq {
  *	3 - Valid bit for @tisci_msg_rm_ring_cfg_req mode
  *	4 - Valid bit for @tisci_msg_rm_ring_cfg_req size
  *	5 - Valid bit for @tisci_msg_rm_ring_cfg_req order_id
+ *	6 - Valid bit for @tisci_msg_rm_ring_cfg_req virtid
+ *	7 - Valid bit for @tisci_msg_rm_ring_cfg_req ASEL
  * @nav_id: Device ID of Navigator Subsystem from which the ring is allocated
  * @index: ring index to be configured.
  * @addr_lo: 32 LSBs of ring base address to be programmed into the ring's
@@ -672,6 +674,9 @@ struct ti_sci_msg_req_manage_irq {
  *	the formula (log2(size_bytes) - 2), where size_bytes cannot be
  *	greater than 256.
  * @order_id: Specifies the ring's bus order ID.
+ * @virtid: Ring virt ID value
+ * @asel: Ring ASEL (address select) value to be set into the ASEL field of the
+ *	ring's RING_BA_HI register.
  */
 struct ti_sci_msg_rm_ring_cfg_req {
 	struct ti_sci_msg_hdr hdr;
@@ -684,6 +689,8 @@ struct ti_sci_msg_rm_ring_cfg_req {
 	u8 mode;
 	u8 size;
 	u8 order_id;
+	u16 virtid;
+	u8 asel;
 } __packed;
 
 /**
diff --git a/include/linux/soc/ti/ti_sci_protocol.h b/include/linux/soc/ti/ti_sci_protocol.h
index 6710d7ac7a72..d1711050cd9d 100644
--- a/include/linux/soc/ti/ti_sci_protocol.h
+++ b/include/linux/soc/ti/ti_sci_protocol.h
@@ -275,17 +275,44 @@ struct ti_sci_rm_irq_ops {
 #define TI_SCI_MSG_VALUE_RM_RING_SIZE_VALID	BIT(4)
 /* RA config.order_id parameter is valid for RM ring configure TISCI message */
 #define TI_SCI_MSG_VALUE_RM_RING_ORDER_ID_VALID	BIT(5)
+/* RA config.virtid parameter is valid for RM ring configure TISCI message */
+#define TI_SCI_MSG_VALUE_RM_RING_VIRTID_VALID	BIT(6)
+/* RA config.asel parameter is valid for RM ring configure TISCI message */
+#define TI_SCI_MSG_VALUE_RM_RING_ASEL_VALID	BIT(7)
 
 #define TI_SCI_MSG_VALUE_RM_ALL_NO_ORDER \
 	(TI_SCI_MSG_VALUE_RM_RING_ADDR_LO_VALID | \
 	TI_SCI_MSG_VALUE_RM_RING_ADDR_HI_VALID | \
 	TI_SCI_MSG_VALUE_RM_RING_COUNT_VALID | \
 	TI_SCI_MSG_VALUE_RM_RING_MODE_VALID | \
-	TI_SCI_MSG_VALUE_RM_RING_SIZE_VALID)
+	TI_SCI_MSG_VALUE_RM_RING_SIZE_VALID | \
+	TI_SCI_MSG_VALUE_RM_RING_ASEL_VALID)
+
+/**
+ * struct ti_sci_msg_rm_ring_cfg - Ring configuration
+ *
+ * Parameters for Navigator Subsystem ring configuration
+ * See @ti_sci_msg_rm_ring_cfg_req
+ */
+struct ti_sci_msg_rm_ring_cfg {
+	u32 valid_params;
+	u16 nav_id;
+	u16 index;
+	u32 addr_lo;
+	u32 addr_hi;
+	u32 count;
+	u8 mode;
+	u8 size;
+	u8 order_id;
+	u16 virtid;
+	u8 asel;
+};
 
 /**
  * struct ti_sci_rm_ringacc_ops - Ring Accelerator Management operations
  * @config: configure the SoC Navigator Subsystem Ring Accelerator ring
+ *	    Deprecated
+ * @set_cfg: configure the SoC Navigator Subsystem Ring Accelerator ring
  */
 struct ti_sci_rm_ringacc_ops {
 	int (*config)(const struct ti_sci_handle *handle,
@@ -293,6 +320,8 @@ struct ti_sci_rm_ringacc_ops {
 		      u32 addr_lo, u32 addr_hi, u32 count, u8 mode,
 		      u8 size, u8 order_id
 	);
+	int (*set_cfg)(const struct ti_sci_handle *handle,
+		       const struct ti_sci_msg_rm_ring_cfg *params);
 };
 
 /**
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

