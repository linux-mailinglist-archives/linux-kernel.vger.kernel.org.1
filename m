Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB9CD27A99A
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 10:35:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbgI1Ieq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 04:34:46 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:41414 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726735AbgI1Iej (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 04:34:39 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08S8YaLI080015;
        Mon, 28 Sep 2020 03:34:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1601282076;
        bh=lUB0hkFPyxoodXQyeQdsAhjsvEPxMUAuBu0US4xjm8U=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=kGuIBF/0QPGAnUfEjWekGzSs3K9ATXMhZan7kW0HlpDR7upZqfS+jU2ftj7mjSAuI
         XubRSINwT9BWfNM9XlaQKot6oGLaeUU2E8OJPm0Tjbk19h0+A+/MbDZ9PErTMtGBXk
         Jwpit3LW86IgKNBUo70uoZ4Uf9hgOEBU6I4yk5rg=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 08S8YZ2p070776
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 28 Sep 2020 03:34:36 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 28
 Sep 2020 03:34:35 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 28 Sep 2020 03:34:35 -0500
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08S8YEaa065485;
        Mon, 28 Sep 2020 03:34:33 -0500
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <nm@ti.com>, <t-kristo@ti.com>, <ssantosh@kernel.org>,
        <lokeshvutla@ti.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <grygorii.strashko@ti.com>
Subject: [PATCH 09/11] firmware: ti_sci: rm: Remove unused config() from ti_sci_rm_ringacc_ops
Date:   Mon, 28 Sep 2020 11:34:27 +0300
Message-ID: <20200928083429.17390-10-peter.ujfalusi@ti.com>
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

The ringacc driver has been converted to use the new set_cfg function to
configure the ring, the old config ops can be removed.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/firmware/ti_sci.c              | 72 --------------------------
 include/linux/soc/ti/ti_sci_protocol.h |  7 ---
 2 files changed, 79 deletions(-)

diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
index a4d2b318795c..235c7e7869aa 100644
--- a/drivers/firmware/ti_sci.c
+++ b/drivers/firmware/ti_sci.c
@@ -2048,77 +2048,6 @@ static int ti_sci_cmd_free_event_map(const struct ti_sci_handle *handle,
 			       ia_id, vint, global_event, vint_status_bit, 0);
 }
 
-/**
- * ti_sci_cmd_ring_config() - configure RA ring
- * @handle:		Pointer to TI SCI handle.
- * @valid_params:	Bitfield defining validity of ring configuration
- *			parameters
- * @nav_id:		Device ID of Navigator Subsystem from which the ring is
- *			allocated
- * @index:		Ring index
- * @addr_lo:		The ring base address lo 32 bits
- * @addr_hi:		The ring base address hi 32 bits
- * @count:		Number of ring elements
- * @mode:		The mode of the ring
- * @size:		The ring element size.
- * @order_id:		Specifies the ring's bus order ID
- *
- * Return: 0 if all went well, else returns appropriate error value.
- *
- * See @ti_sci_msg_rm_ring_cfg_req for more info.
- */
-static int ti_sci_cmd_ring_config(const struct ti_sci_handle *handle,
-				  u32 valid_params, u16 nav_id, u16 index,
-				  u32 addr_lo, u32 addr_hi, u32 count,
-				  u8 mode, u8 size, u8 order_id)
-{
-	struct ti_sci_msg_rm_ring_cfg_req *req;
-	struct ti_sci_msg_hdr *resp;
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
-	xfer = ti_sci_get_one_xfer(info, TI_SCI_MSG_RM_RING_CFG,
-				   TI_SCI_FLAG_REQ_ACK_ON_PROCESSED,
-				   sizeof(*req), sizeof(*resp));
-	if (IS_ERR(xfer)) {
-		ret = PTR_ERR(xfer);
-		dev_err(dev, "RM_RA:Message config failed(%d)\n", ret);
-		return ret;
-	}
-	req = (struct ti_sci_msg_rm_ring_cfg_req *)xfer->xfer_buf;
-	req->valid_params = valid_params;
-	req->nav_id = nav_id;
-	req->index = index;
-	req->addr_lo = addr_lo;
-	req->addr_hi = addr_hi;
-	req->count = count;
-	req->mode = mode;
-	req->size = size;
-	req->order_id = order_id;
-
-	ret = ti_sci_do_xfer(info, xfer);
-	if (ret) {
-		dev_err(dev, "RM_RA:Mbox config send fail %d\n", ret);
-		goto fail;
-	}
-
-	resp = (struct ti_sci_msg_hdr *)xfer->xfer_buf;
-	ret = ti_sci_is_response_ack(resp) ? 0 : -ENODEV;
-
-fail:
-	ti_sci_put_one_xfer(&info->minfo, xfer);
-	dev_dbg(dev, "RM_RA:config ring %u ret:%d\n", index, ret);
-	return ret;
-}
-
 /**
  * ti_sci_cmd_rm_ring_cfg() - Configure a NAVSS ring
  * @handle:	Pointer to TI SCI handle.
@@ -2908,7 +2837,6 @@ static void ti_sci_setup_ops(struct ti_sci_info *info)
 	iops->free_irq = ti_sci_cmd_free_irq;
 	iops->free_event_map = ti_sci_cmd_free_event_map;
 
-	rops->config = ti_sci_cmd_ring_config;
 	rops->set_cfg = ti_sci_cmd_rm_ring_cfg;
 
 	psilops->pair = ti_sci_cmd_rm_psil_pair;
diff --git a/include/linux/soc/ti/ti_sci_protocol.h b/include/linux/soc/ti/ti_sci_protocol.h
index d1711050cd9d..0aad7009b50e 100644
--- a/include/linux/soc/ti/ti_sci_protocol.h
+++ b/include/linux/soc/ti/ti_sci_protocol.h
@@ -310,16 +310,9 @@ struct ti_sci_msg_rm_ring_cfg {
 
 /**
  * struct ti_sci_rm_ringacc_ops - Ring Accelerator Management operations
- * @config: configure the SoC Navigator Subsystem Ring Accelerator ring
- *	    Deprecated
  * @set_cfg: configure the SoC Navigator Subsystem Ring Accelerator ring
  */
 struct ti_sci_rm_ringacc_ops {
-	int (*config)(const struct ti_sci_handle *handle,
-		      u32 valid_params, u16 nav_id, u16 index,
-		      u32 addr_lo, u32 addr_hi, u32 count, u8 mode,
-		      u8 size, u8 order_id
-	);
 	int (*set_cfg)(const struct ti_sci_handle *handle,
 		       const struct ti_sci_msg_rm_ring_cfg *params);
 };
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

