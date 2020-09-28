Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9636E27A997
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 10:35:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbgI1Iek (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 04:34:40 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:41180 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726691AbgI1Ieb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 04:34:31 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08S8YR1E079708;
        Mon, 28 Sep 2020 03:34:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1601282067;
        bh=Q268xbAANVai1wbe6oY4hx1HWU4FUJh2iu0Vh8hEct4=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=o9egmpn6rwb7Z8wQFXoj5XvcZ2v24kJ7yFnRqjRENX9MPGyJNYcPvw++5TOGXPUYc
         YKoOc1+Ze4sWLJpJuJfejJGDJPtX1EbEnBWDVp4T4UWZuHBVA+Lgple1DrkAspBg2B
         5DerC08C3n4Km8IocDL2QktcyGx2mWHMP1Q9UAUw=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08S8YRTm101516;
        Mon, 28 Sep 2020 03:34:27 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 28
 Sep 2020 03:34:27 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 28 Sep 2020 03:34:27 -0500
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08S8YEaW065485;
        Mon, 28 Sep 2020 03:34:25 -0500
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <nm@ti.com>, <t-kristo@ti.com>, <ssantosh@kernel.org>,
        <lokeshvutla@ti.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <grygorii.strashko@ti.com>
Subject: [PATCH 05/11] firmware: ti_sci: rm: Add support for extended_ch_type for tx channel
Date:   Mon, 28 Sep 2020 11:34:23 +0300
Message-ID: <20200928083429.17390-6-peter.ujfalusi@ti.com>
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

Sysfw added 'extended_ch_type' to the tx_ch_cfg_req message which should be
used when BCDMA block copy channels are configured:
extended_ch_type = 0 : the channel is split tx channel (tchan)
extended_ch_type = 1 : the channel is block copy channel (bchan)

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/firmware/ti_sci.c              | 1 +
 drivers/firmware/ti_sci.h              | 6 ++++++
 include/linux/soc/ti/ti_sci_protocol.h | 5 +++++
 3 files changed, 12 insertions(+)

diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
index 2793bb923881..0dd3fbb4f964 100644
--- a/drivers/firmware/ti_sci.c
+++ b/drivers/firmware/ti_sci.c
@@ -2365,6 +2365,7 @@ static int ti_sci_cmd_rm_udmap_tx_ch_cfg(const struct ti_sci_handle *handle,
 	req->tx_sched_priority = params->tx_sched_priority;
 	req->tx_burst_size = params->tx_burst_size;
 	req->tx_tdtype = params->tx_tdtype;
+	req->extended_ch_type = params->extended_ch_type;
 
 	ret = ti_sci_do_xfer(info, xfer);
 	if (ret) {
diff --git a/drivers/firmware/ti_sci.h b/drivers/firmware/ti_sci.h
index 4d980eb592c4..ca15d8f1f8de 100644
--- a/drivers/firmware/ti_sci.h
+++ b/drivers/firmware/ti_sci.h
@@ -915,6 +915,7 @@ struct rm_ti_sci_msg_udmap_rx_flow_opt_cfg {
  *   13 - Valid bit for @ref ti_sci_msg_rm_udmap_tx_ch_cfg::fdepth
  *   14 - Valid bit for @ref ti_sci_msg_rm_udmap_tx_ch_cfg::tx_burst_size
  *   15 - Valid bit for @ref ti_sci_msg_rm_udmap_tx_ch_cfg::tx_tdtype
+ *   16 - Valid bit for @ref ti_sci_msg_rm_udmap_tx_ch_cfg::extended_ch_type
  *
  * @nav_id: SoC device ID of Navigator Subsystem where tx channel is located
  *
@@ -983,6 +984,10 @@ struct rm_ti_sci_msg_udmap_rx_flow_opt_cfg {
  * programmed into the tdtype field of the TCHAN_TCFG register:
  * 0 - Return immediately
  * 1 - Wait for completion message from remote peer
+ *
+ * @extended_ch_type: Valid for BCDMA.
+ * 0 - the channel is split tx channel (tchan)
+ * 1 - the channel is block copy channel (bchan)
  */
 struct ti_sci_msg_rm_udmap_tx_ch_cfg_req {
 	struct ti_sci_msg_hdr hdr;
@@ -1005,6 +1010,7 @@ struct ti_sci_msg_rm_udmap_tx_ch_cfg_req {
 	u8 tx_sched_priority;
 	u8 tx_burst_size;
 	u8 tx_tdtype;
+	u8 extended_ch_type;
 } __packed;
 
 /**
diff --git a/include/linux/soc/ti/ti_sci_protocol.h b/include/linux/soc/ti/ti_sci_protocol.h
index 9699b260de59..6978afc00823 100644
--- a/include/linux/soc/ti/ti_sci_protocol.h
+++ b/include/linux/soc/ti/ti_sci_protocol.h
@@ -336,6 +336,9 @@ struct ti_sci_rm_psil_ops {
 #define TI_SCI_RM_UDMAP_CHAN_BURST_SIZE_128_BYTES	2
 #define TI_SCI_RM_UDMAP_CHAN_BURST_SIZE_256_BYTES	3
 
+#define TI_SCI_RM_BCDMA_EXTENDED_CH_TYPE_TCHAN		0
+#define TI_SCI_RM_BCDMA_EXTENDED_CH_TYPE_BCHAN		1
+
 /* UDMAP TX/RX channel valid_params common declarations */
 #define TI_SCI_MSG_VALUE_RM_UDMAP_CH_PAUSE_ON_ERR_VALID		BIT(0)
 #define TI_SCI_MSG_VALUE_RM_UDMAP_CH_ATYPE_VALID                BIT(1)
@@ -362,6 +365,7 @@ struct ti_sci_msg_rm_udmap_tx_ch_cfg {
 #define TI_SCI_MSG_VALUE_RM_UDMAP_CH_TX_CREDIT_COUNT_VALID      BIT(12)
 #define TI_SCI_MSG_VALUE_RM_UDMAP_CH_TX_FDEPTH_VALID            BIT(13)
 #define TI_SCI_MSG_VALUE_RM_UDMAP_CH_TX_TDTYPE_VALID            BIT(15)
+#define TI_SCI_MSG_VALUE_RM_UDMAP_CH_EXTENDED_CH_TYPE_VALID	BIT(16)
 	u16 nav_id;
 	u16 index;
 	u8 tx_pause_on_err;
@@ -380,6 +384,7 @@ struct ti_sci_msg_rm_udmap_tx_ch_cfg {
 	u8 tx_sched_priority;
 	u8 tx_burst_size;
 	u8 tx_tdtype;
+	u8 extended_ch_type;
 };
 
 /**
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

