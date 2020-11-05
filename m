Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 201852A88F3
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 22:28:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732375AbgKEV2R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 16:28:17 -0500
Received: from plasma4.jpberlin.de ([80.241.57.33]:34347 "EHLO
        plasma4.jpberlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729783AbgKEV2N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 16:28:13 -0500
X-Greylist: delayed 385 seconds by postgrey-1.27 at vger.kernel.org; Thu, 05 Nov 2020 16:28:12 EST
Received: from spamfilter04.heinlein-hosting.de (spamfilter04.heinlein-hosting.de [80.241.56.122])
        by plasma.jpberlin.de (Postfix) with ESMTP id 98E0BAB79F;
        Thu,  5 Nov 2020 22:21:50 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from plasma.jpberlin.de ([80.241.56.68])
        by spamfilter04.heinlein-hosting.de (spamfilter04.heinlein-hosting.de [80.241.56.122]) (amavisd-new, port 10030)
        with ESMTP id A_FVSXef25dI; Thu,  5 Nov 2020 22:21:49 +0100 (CET)
Received: from webmail.opensynergy.com (unknown [217.66.60.5])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (Client CN "*.opensynergy.com", Issuer "Starfield Secure Certificate Authority - G2" (not verified))
        (Authenticated sender: opensynergy@jpberlin.de)
        by plasma.jpberlin.de (Postfix) with ESMTPSA id 7B9BEAB8ED;
        Thu,  5 Nov 2020 22:21:49 +0100 (CET)
From:   Peter Hilber <peter.hilber@opensynergy.com>
To:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>
CC:     Peter Hilber <peter.hilber@opensynergy.com>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-kernel@vger.kernel.org>, <sudeep.holla@arm.com>,
        <souvik.chakravarty@arm.com>, <alex.bennee@linaro.org>,
        <jean-philippe@linaro.org>, <igor.skalkin@opensynergy.com>,
        <mikhail.golubev@opensynergy.com>, <anton.yakovlev@opensynergy.com>
Subject: [RFC PATCH v2 07/10] firmware: arm_scmi: Add per-device transport private info
Date:   Thu, 5 Nov 2020 22:21:13 +0100
Message-ID: <20201105212116.411422-8-peter.hilber@opensynergy.com>
In-Reply-To: <20201105212116.411422-1-peter.hilber@opensynergy.com>
References: <20201105212116.411422-1-peter.hilber@opensynergy.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: SR-MAIL-01.open-synergy.com (10.26.10.21) To
 SR-MAIL-01.open-synergy.com (10.26.10.21)
X-MBO-SPAM-Probability: 
X-Rspamd-Score: -3.39 / 15.00 / 15.00
X-Rspamd-Queue-Id: 98E0BAB79F
X-Rspamd-UID: dd361e
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The scmi-virtio transport will link a supplier device to the arm-scmi
device in the link_supplier() op. The transport should then save a
pointer to the linked device.

To enable this, add a transport private info to the scmi_info. (The
scmi_info is already reachable through the arm-scmi device driver_data.)

Signed-off-by: Peter Hilber <peter.hilber@opensynergy.com>
---
 drivers/firmware/arm_scmi/common.h |  2 ++
 drivers/firmware/arm_scmi/driver.c | 35 ++++++++++++++++++++++++++++++
 2 files changed, 37 insertions(+)

diff --git a/drivers/firmware/arm_scmi/common.h b/drivers/firmware/arm_scmi/common.h
index 2f55ac71555a..ec9fd7fce3c7 100644
--- a/drivers/firmware/arm_scmi/common.h
+++ b/drivers/firmware/arm_scmi/common.h
@@ -262,6 +262,8 @@ extern const struct scmi_desc scmi_mailbox_desc;
 extern const struct scmi_desc scmi_smc_desc;
 #endif
 
+int scmi_set_transport_info(struct device *dev, void *transport_info);
+void *scmi_get_transport_info(struct device *dev);
 void scmi_rx_callback(struct scmi_chan_info *cinfo, u32 msg_hdr);
 void scmi_free_channel(struct scmi_chan_info *cinfo, struct idr *idr, int id);
 
diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index dedc9b3f3e97..244141e45e88 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -84,6 +84,7 @@ struct scmi_xfers_info {
  * @rx_idr: IDR object to map protocol id to Rx channel info pointer
  * @protocols_imp: List of protocols implemented, currently maximum of
  *	MAX_PROTOCOLS_IMP elements allocated by the base protocol
+ * @transport_info: Transport private info
  * @node: List head
  * @users: Number of users of this instance
  */
@@ -97,6 +98,7 @@ struct scmi_info {
 	struct idr tx_idr;
 	struct idr rx_idr;
 	u8 *protocols_imp;
+	void *transport_info;
 	struct list_head node;
 	int users;
 };
@@ -315,6 +317,39 @@ void scmi_rx_callback(struct scmi_chan_info *cinfo, u32 msg_hdr)
 	}
 }
 
+/**
+ * scmi_set_transport_info() - Set transport private info
+ *
+ * @dev: SCMI instance device
+ * @transport_info: transport private info
+ *
+ * Return: 0 on success, otherwise error.
+ */
+int scmi_set_transport_info(struct device *dev, void *transport_info)
+{
+	struct scmi_info *info = dev_get_drvdata(dev);
+
+	if (!info)
+		return -EBADR;
+
+	info->transport_info = transport_info;
+	return 0;
+}
+
+/**
+ * scmi_get_transport_info() - Get transport private info
+ *
+ * @dev: SCMI instance device
+ *
+ * Return: transport private info on success, otherwise NULL.
+ */
+void *scmi_get_transport_info(struct device *dev)
+{
+	struct scmi_info *info = dev_get_drvdata(dev);
+
+	return info ? info->transport_info : NULL;
+}
+
 /**
  * scmi_xfer_put() - Release a transmit message
  *
-- 
2.25.1

