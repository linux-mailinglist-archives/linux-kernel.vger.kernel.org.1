Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E65962B9727
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 17:02:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729032AbgKSPzg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 10:55:36 -0500
Received: from mga02.intel.com ([134.134.136.20]:65086 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728277AbgKSPza (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 10:55:30 -0500
IronPort-SDR: DTtcTA/eTIO01M1jZh4eDIChBFOc2RA0Bh5pKbB5WDkBfWZCZ54s1Ojtcl8cykGFQJpFQ8elY2
 +FCf57zzdTkA==
X-IronPort-AV: E=McAfee;i="6000,8403,9809"; a="158342918"
X-IronPort-AV: E=Sophos;i="5.78,490,1599548400"; 
   d="scan'208";a="158342918"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2020 07:55:29 -0800
IronPort-SDR: FduOqqXpAhgI0a09I0/B4NRSMSclym2+vk3PB08b3RHp+aH0aEMFrsdfzso5w0uLKlN3Cu+7pS
 2fFSVte0AuVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,490,1599548400"; 
   d="scan'208";a="533220956"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 19 Nov 2020 07:55:27 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 36D55841; Thu, 19 Nov 2020 17:55:24 +0200 (EET)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     Yehezkel Bernat <YehezkelShB@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        Lukas Wunner <lukas@wunner.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH 11/12] thunderbolt: Add USB4 router operation proxy for firmware connection manager
Date:   Thu, 19 Nov 2020 18:55:22 +0300
Message-Id: <20201119155523.41332-12-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201119155523.41332-1-mika.westerberg@linux.intel.com>
References: <20201119155523.41332-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Intel Maple Ridge and Tiger Lake connection manager firmware implements
a USB4 router operation proxy that should be used instead of direct
register access to avoid races with the firmware. This is supported in
all firmwares where the protocol version field returned in the driver
ready response is 3 (or higher).

This adds the USB4 router proxy operations support to the driver so that
we first check the protocol version and if it is 3 (or higher) the USB4
router operation is run through the firmware provided proxy. Otherwise
the native version is used.

Most USB4 router proxy operations are pretty straightforward except
NVM_AUTH where the firmware only responds once the router is restarted
but before it sends device connected notification. To support this we
split the operation so that the reply is received asynchronously and
stored to struct icm. This last reply is then returned in
icm_usb4_switch_nvm_authenticate_status() if available.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/thunderbolt/icm.c     | 214 ++++++++++++++++++++++++++++++++--
 drivers/thunderbolt/tb_msgs.h |  28 +++++
 2 files changed, 232 insertions(+), 10 deletions(-)

diff --git a/drivers/thunderbolt/icm.c b/drivers/thunderbolt/icm.c
index 635b949fb1d6..35935c106e3d 100644
--- a/drivers/thunderbolt/icm.c
+++ b/drivers/thunderbolt/icm.c
@@ -48,6 +48,18 @@ static bool start_icm;
 module_param(start_icm, bool, 0444);
 MODULE_PARM_DESC(start_icm, "start ICM firmware if it is not running (default: false)");
 
+/**
+ * struct usb4_switch_nvm_auth - Holds USB4 NVM_AUTH status
+ * @reply: Reply from ICM firmware is placed here
+ * @request: Request that is sent to ICM firmware
+ * @icm: Pointer to ICM private data
+ */
+struct usb4_switch_nvm_auth {
+	struct icm_usb4_switch_op_response reply;
+	struct icm_usb4_switch_op request;
+	struct icm *icm;
+};
+
 /**
  * struct icm - Internal connection manager private data
  * @request_lock: Makes sure only one message is send to ICM at time
@@ -61,6 +73,8 @@ MODULE_PARM_DESC(start_icm, "start ICM firmware if it is not running (default: f
  * @max_boot_acl: Maximum number of preboot ACL entries (%0 if not supported)
  * @rpm: Does the controller support runtime PM (RTD3)
  * @can_upgrade_nvm: Can the NVM firmware be upgrade on this controller
+ * @proto_version: Firmware protocol version
+ * @last_nvm_auth: Last USB4 router NVM_AUTH result (or %NULL if not set)
  * @veto: Is RTD3 veto in effect
  * @is_supported: Checks if we can support ICM on this controller
  * @cio_reset: Trigger CIO reset
@@ -84,6 +98,8 @@ struct icm {
 	size_t max_boot_acl;
 	bool rpm;
 	bool can_upgrade_nvm;
+	u8 proto_version;
+	struct usb4_switch_nvm_auth *last_nvm_auth;
 	bool veto;
 	bool (*is_supported)(struct tb *tb);
 	int (*cio_reset)(struct tb *tb);
@@ -92,7 +108,7 @@ struct icm {
 	void (*save_devices)(struct tb *tb);
 	int (*driver_ready)(struct tb *tb,
 			    enum tb_security_level *security_level,
-			    size_t *nboot_acl, bool *rpm);
+			    u8 *proto_version, size_t *nboot_acl, bool *rpm);
 	void (*set_uuid)(struct tb *tb);
 	void (*device_connected)(struct tb *tb,
 				 const struct icm_pkg_header *hdr);
@@ -437,7 +453,7 @@ static void icm_fr_save_devices(struct tb *tb)
 
 static int
 icm_fr_driver_ready(struct tb *tb, enum tb_security_level *security_level,
-		    size_t *nboot_acl, bool *rpm)
+		    u8 *proto_version, size_t *nboot_acl, bool *rpm)
 {
 	struct icm_fr_pkg_driver_ready_response reply;
 	struct icm_pkg_driver_ready request = {
@@ -992,7 +1008,7 @@ static int icm_tr_cio_reset(struct tb *tb)
 
 static int
 icm_tr_driver_ready(struct tb *tb, enum tb_security_level *security_level,
-		    size_t *nboot_acl, bool *rpm)
+		    u8 *proto_version, size_t *nboot_acl, bool *rpm)
 {
 	struct icm_tr_pkg_driver_ready_response reply;
 	struct icm_pkg_driver_ready request = {
@@ -1008,6 +1024,9 @@ icm_tr_driver_ready(struct tb *tb, enum tb_security_level *security_level,
 
 	if (security_level)
 		*security_level = reply.info & ICM_TR_INFO_SLEVEL_MASK;
+	if (proto_version)
+		*proto_version = (reply.info & ICM_TR_INFO_PROTO_VERSION_MASK) >>
+				ICM_TR_INFO_PROTO_VERSION_SHIFT;
 	if (nboot_acl)
 		*nboot_acl = (reply.info & ICM_TR_INFO_BOOT_ACL_MASK) >>
 				ICM_TR_INFO_BOOT_ACL_SHIFT;
@@ -1461,7 +1480,7 @@ static int icm_ar_get_mode(struct tb *tb)
 
 static int
 icm_ar_driver_ready(struct tb *tb, enum tb_security_level *security_level,
-		    size_t *nboot_acl, bool *rpm)
+		    u8 *proto_version, size_t *nboot_acl, bool *rpm)
 {
 	struct icm_ar_pkg_driver_ready_response reply;
 	struct icm_pkg_driver_ready request = {
@@ -1591,7 +1610,7 @@ static int icm_ar_set_boot_acl(struct tb *tb, const uuid_t *uuids,
 
 static int
 icm_icl_driver_ready(struct tb *tb, enum tb_security_level *security_level,
-		    size_t *nboot_acl, bool *rpm)
+		     u8 *proto_version, size_t *nboot_acl, bool *rpm)
 {
 	struct icm_tr_pkg_driver_ready_response reply;
 	struct icm_pkg_driver_ready request = {
@@ -1605,6 +1624,10 @@ icm_icl_driver_ready(struct tb *tb, enum tb_security_level *security_level,
 	if (ret)
 		return ret;
 
+	if (proto_version)
+		*proto_version = (reply.info & ICM_TR_INFO_PROTO_VERSION_MASK) >>
+				ICM_TR_INFO_PROTO_VERSION_SHIFT;
+
 	/* Ice Lake always supports RTD3 */
 	if (rpm)
 		*rpm = true;
@@ -1713,13 +1736,14 @@ static void icm_handle_event(struct tb *tb, enum tb_cfg_pkg_type type,
 
 static int
 __icm_driver_ready(struct tb *tb, enum tb_security_level *security_level,
-		   size_t *nboot_acl, bool *rpm)
+		   u8 *proto_version, size_t *nboot_acl, bool *rpm)
 {
 	struct icm *icm = tb_priv(tb);
 	unsigned int retries = 50;
 	int ret;
 
-	ret = icm->driver_ready(tb, security_level, nboot_acl, rpm);
+	ret = icm->driver_ready(tb, security_level, proto_version, nboot_acl,
+				rpm);
 	if (ret) {
 		tb_err(tb, "failed to send driver ready to ICM\n");
 		return ret;
@@ -1929,8 +1953,8 @@ static int icm_driver_ready(struct tb *tb)
 		return 0;
 	}
 
-	ret = __icm_driver_ready(tb, &tb->security_level, &tb->nboot_acl,
-				 &icm->rpm);
+	ret = __icm_driver_ready(tb, &tb->security_level, &icm->proto_version,
+				 &tb->nboot_acl, &icm->rpm);
 	if (ret)
 		return ret;
 
@@ -1941,6 +1965,9 @@ static int icm_driver_ready(struct tb *tb)
 	if (tb->nboot_acl > icm->max_boot_acl)
 		tb->nboot_acl = 0;
 
+	if (icm->proto_version >= 3)
+		tb_dbg(tb, "USB4 proxy operations supported\n");
+
 	return 0;
 }
 
@@ -2052,7 +2079,7 @@ static void icm_complete(struct tb *tb)
 	 * Now all existing children should be resumed, start events
 	 * from ICM to get updated status.
 	 */
-	__icm_driver_ready(tb, NULL, NULL, NULL);
+	__icm_driver_ready(tb, NULL, NULL, NULL, NULL);
 
 	/*
 	 * We do not get notifications of devices that have been
@@ -2131,6 +2158,8 @@ static void icm_stop(struct tb *tb)
 	tb_switch_remove(tb->root_switch);
 	tb->root_switch = NULL;
 	nhi_mailbox_cmd(tb->nhi, NHI_MAILBOX_DRV_UNLOADS, 0);
+	kfree(icm->last_nvm_auth);
+	icm->last_nvm_auth = NULL;
 }
 
 static int icm_disconnect_pcie_paths(struct tb *tb)
@@ -2138,6 +2167,165 @@ static int icm_disconnect_pcie_paths(struct tb *tb)
 	return nhi_mailbox_cmd(tb->nhi, NHI_MAILBOX_DISCONNECT_PCIE_PATHS, 0);
 }
 
+static void icm_usb4_switch_nvm_auth_complete(void *data)
+{
+	struct usb4_switch_nvm_auth *auth = data;
+	struct icm *icm = auth->icm;
+	struct tb *tb = icm_to_tb(icm);
+
+	tb_dbg(tb, "NVM_AUTH response for %llx flags %#x status %#x\n",
+	       get_route(auth->reply.route_hi, auth->reply.route_lo),
+	       auth->reply.hdr.flags, auth->reply.status);
+
+	mutex_lock(&tb->lock);
+	if (WARN_ON(icm->last_nvm_auth))
+		kfree(icm->last_nvm_auth);
+	icm->last_nvm_auth = auth;
+	mutex_unlock(&tb->lock);
+}
+
+static int icm_usb4_switch_nvm_authenticate(struct tb *tb, u64 route)
+{
+	struct usb4_switch_nvm_auth *auth;
+	struct icm *icm = tb_priv(tb);
+	struct tb_cfg_request *req;
+	int ret;
+
+	auth = kzalloc(sizeof(*auth), GFP_KERNEL);
+	if (!auth)
+		return -ENOMEM;
+
+	auth->icm = icm;
+	auth->request.hdr.code = ICM_USB4_SWITCH_OP;
+	auth->request.route_hi = upper_32_bits(route);
+	auth->request.route_lo = lower_32_bits(route);
+	auth->request.opcode = USB4_SWITCH_OP_NVM_AUTH;
+
+	req = tb_cfg_request_alloc();
+	if (!req) {
+		ret = -ENOMEM;
+		goto err_free_auth;
+	}
+
+	req->match = icm_match;
+	req->copy = icm_copy;
+	req->request = &auth->request;
+	req->request_size = sizeof(auth->request);
+	req->request_type = TB_CFG_PKG_ICM_CMD;
+	req->response = &auth->reply;
+	req->npackets = 1;
+	req->response_size = sizeof(auth->reply);
+	req->response_type = TB_CFG_PKG_ICM_RESP;
+
+	tb_dbg(tb, "NVM_AUTH request for %llx\n", route);
+
+	mutex_lock(&icm->request_lock);
+	ret = tb_cfg_request(tb->ctl, req, icm_usb4_switch_nvm_auth_complete,
+			     auth);
+	mutex_unlock(&icm->request_lock);
+
+	tb_cfg_request_put(req);
+	if (ret)
+		goto err_free_auth;
+	return 0;
+
+err_free_auth:
+	kfree(auth);
+	return ret;
+}
+
+static int icm_usb4_switch_op(struct tb_switch *sw, u16 opcode, u32 *metadata,
+			      u8 *status, const void *tx_data, size_t tx_data_len,
+			      void *rx_data, size_t rx_data_len)
+{
+	struct icm_usb4_switch_op_response reply;
+	struct icm_usb4_switch_op request;
+	struct tb *tb = sw->tb;
+	struct icm *icm = tb_priv(tb);
+	u64 route = tb_route(sw);
+	int ret;
+
+	/*
+	 * USB4 router operation proxy is supported in firmware if the
+	 * protocol version is 3 or higher.
+	 */
+	if (icm->proto_version < 3)
+		return -EOPNOTSUPP;
+
+	/*
+	 * NVM_AUTH is a special USB4 proxy operation that does not
+	 * return immediately so handle it separately.
+	 */
+	if (opcode == USB4_SWITCH_OP_NVM_AUTH)
+		return icm_usb4_switch_nvm_authenticate(tb, route);
+
+	memset(&request, 0, sizeof(request));
+	request.hdr.code = ICM_USB4_SWITCH_OP;
+	request.route_hi = upper_32_bits(route);
+	request.route_lo = lower_32_bits(route);
+	request.opcode = opcode;
+	if (metadata)
+		request.metadata = *metadata;
+
+	if (tx_data_len) {
+		request.data_len_valid |= ICM_USB4_SWITCH_DATA_VALID;
+		if (tx_data_len < ARRAY_SIZE(request.data))
+			request.data_len_valid =
+				tx_data_len & ICM_USB4_SWITCH_DATA_LEN_MASK;
+		memcpy(request.data, tx_data, tx_data_len * sizeof(u32));
+	}
+
+	memset(&reply, 0, sizeof(reply));
+	ret = icm_request(tb, &request, sizeof(request), &reply, sizeof(reply),
+			  1, ICM_TIMEOUT);
+	if (ret)
+		return ret;
+
+	if (reply.hdr.flags & ICM_FLAGS_ERROR)
+		return -EIO;
+
+	if (status)
+		*status = reply.status;
+
+	if (metadata)
+		*metadata = reply.metadata;
+
+	if (rx_data_len)
+		memcpy(rx_data, reply.data, rx_data_len * sizeof(u32));
+
+	return 0;
+}
+
+static int icm_usb4_switch_nvm_authenticate_status(struct tb_switch *sw,
+						   u32 *status)
+{
+	struct usb4_switch_nvm_auth *auth;
+	struct tb *tb = sw->tb;
+	struct icm *icm = tb_priv(tb);
+	int ret = 0;
+
+	if (icm->proto_version < 3)
+		return -EOPNOTSUPP;
+
+	auth = icm->last_nvm_auth;
+	icm->last_nvm_auth = NULL;
+
+	if (auth && auth->reply.route_hi == sw->config.route_hi &&
+	    auth->reply.route_lo == sw->config.route_lo) {
+		tb_dbg(tb, "NVM_AUTH found for %llx flags 0x%#x status %#x\n",
+		       tb_route(sw), auth->reply.hdr.flags, auth->reply.status);
+		if (auth->reply.hdr.flags & ICM_FLAGS_ERROR)
+			ret = -EIO;
+		else
+			*status = auth->reply.status;
+	} else {
+		*status = 0;
+	}
+
+	kfree(auth);
+	return ret;
+}
+
 /* Falcon Ridge */
 static const struct tb_cm_ops icm_fr_ops = {
 	.driver_ready = icm_driver_ready,
@@ -2196,6 +2384,9 @@ static const struct tb_cm_ops icm_tr_ops = {
 	.disconnect_pcie_paths = icm_disconnect_pcie_paths,
 	.approve_xdomain_paths = icm_tr_approve_xdomain_paths,
 	.disconnect_xdomain_paths = icm_tr_disconnect_xdomain_paths,
+	.usb4_switch_op = icm_usb4_switch_op,
+	.usb4_switch_nvm_authenticate_status =
+		icm_usb4_switch_nvm_authenticate_status,
 };
 
 /* Ice Lake */
@@ -2209,6 +2400,9 @@ static const struct tb_cm_ops icm_icl_ops = {
 	.handle_event = icm_handle_event,
 	.approve_xdomain_paths = icm_tr_approve_xdomain_paths,
 	.disconnect_xdomain_paths = icm_tr_disconnect_xdomain_paths,
+	.usb4_switch_op = icm_usb4_switch_op,
+	.usb4_switch_nvm_authenticate_status =
+		icm_usb4_switch_nvm_authenticate_status,
 };
 
 struct tb *icm_probe(struct tb_nhi *nhi)
diff --git a/drivers/thunderbolt/tb_msgs.h b/drivers/thunderbolt/tb_msgs.h
index 0e01dbc63e72..bcabfcb2fd03 100644
--- a/drivers/thunderbolt/tb_msgs.h
+++ b/drivers/thunderbolt/tb_msgs.h
@@ -106,6 +106,7 @@ enum icm_pkg_code {
 	ICM_APPROVE_XDOMAIN = 0x10,
 	ICM_DISCONNECT_XDOMAIN = 0x11,
 	ICM_PREBOOT_ACL = 0x18,
+	ICM_USB4_SWITCH_OP = 0x20,
 };
 
 enum icm_event_code {
@@ -343,6 +344,8 @@ struct icm_tr_pkg_driver_ready_response {
 #define ICM_TR_FLAGS_RTD3		BIT(6)
 
 #define ICM_TR_INFO_SLEVEL_MASK		GENMASK(2, 0)
+#define ICM_TR_INFO_PROTO_VERSION_MASK	GENMASK(6, 4)
+#define ICM_TR_INFO_PROTO_VERSION_SHIFT	4
 #define ICM_TR_INFO_BOOT_ACL_SHIFT	7
 #define ICM_TR_INFO_BOOT_ACL_MASK	GENMASK(12, 7)
 
@@ -478,6 +481,31 @@ struct icm_icl_event_rtd3_veto {
 	u32 veto_reason;
 };
 
+/* USB4 ICM messages */
+
+struct icm_usb4_switch_op {
+	struct icm_pkg_header hdr;
+	u32 route_hi;
+	u32 route_lo;
+	u32 metadata;
+	u16 opcode;
+	u16 data_len_valid;
+	u32 data[16];
+};
+
+#define ICM_USB4_SWITCH_DATA_LEN_MASK	GENMASK(3, 0)
+#define ICM_USB4_SWITCH_DATA_VALID	BIT(4)
+
+struct icm_usb4_switch_op_response {
+	struct icm_pkg_header hdr;
+	u32 route_hi;
+	u32 route_lo;
+	u32 metadata;
+	u16 opcode;
+	u16 status;
+	u32 data[16];
+};
+
 /* XDomain messages */
 
 struct tb_xdomain_header {
-- 
2.29.2

