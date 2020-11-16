Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C00D2B4417
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 13:59:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727899AbgKPM5H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 07:57:07 -0500
Received: from mga18.intel.com ([134.134.136.126]:13484 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726455AbgKPM5H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 07:57:07 -0500
IronPort-SDR: nAwDZR44/kklrGX0cguflAahe33Tx6FSB8/RpbKmoPHFPPl4dlWjb/+KF8OR+5YUHGTo3pRVBO
 jg5vUfDg3gxg==
X-IronPort-AV: E=McAfee;i="6000,8403,9806"; a="158516489"
X-IronPort-AV: E=Sophos;i="5.77,482,1596524400"; 
   d="scan'208";a="158516489"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2020 04:57:03 -0800
IronPort-SDR: YSQp+/ACU4A9fhS4RLIo4HvHX6hLv7oHIPs6DNOiHJGTOBnpFqukb2G4BkWFTuVnEaLeC0UJPv
 WYLBPuCtUrGw==
X-IronPort-AV: E=Sophos;i="5.77,482,1596524400"; 
   d="scan'208";a="358454797"
Received: from twinkler-lnx.jer.intel.com ([10.12.91.138])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2020 04:57:01 -0800
From:   Tomas Winkler <tomas.winkler@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Alexander Usyskin <alexander.usyskin@intel.com>,
        linux-kernel@vger.kernel.org,
        Sean Z Huang <sean.z.huang@intel.com>,
        Tomas Winkler <tomas.winkler@intel.com>
Subject: [char-misc-next 1/2] mei: bus: add vtag support
Date:   Mon, 16 Nov 2020 14:56:11 +0200
Message-Id: <20201116125612.1660971-1-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Usyskin <alexander.usyskin@intel.com>

Add API to support vtag in communication on mei bus.

Add mei_cldev_send_vtag, mei_cldev_recv_vtag and
mei_cldev_recv_nonblock_vtag functions to allow sending a message
with vtag set and to receive vtag of an incoming message.

Cc: Sean Z Huang <sean.z.huang@intel.com>
Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
---
 drivers/misc/mei/bus-fixup.c |  13 +++--
 drivers/misc/mei/bus.c       | 101 +++++++++++++++++++++++++++++------
 drivers/misc/mei/client.c    |   6 ++-
 drivers/misc/mei/mei_dev.h   |   4 +-
 include/linux/mei_cl_bus.h   |   6 +++
 5 files changed, 104 insertions(+), 26 deletions(-)

diff --git a/drivers/misc/mei/bus-fixup.c b/drivers/misc/mei/bus-fixup.c
index 4e30fa98fe7d..6cc3145bb716 100644
--- a/drivers/misc/mei/bus-fixup.c
+++ b/drivers/misc/mei/bus-fixup.c
@@ -148,7 +148,7 @@ static int mei_osver(struct mei_cl_device *cldev)
 	os_ver = (struct mei_os_ver *)fwcaps->data;
 	os_ver->os_type = OSTYPE_LINUX;
 
-	return __mei_cl_send(cldev->cl, buf, size, mode);
+	return __mei_cl_send(cldev->cl, buf, size, 0, mode);
 }
 
 #define MKHI_FWVER_BUF_LEN (sizeof(struct mkhi_msg_hdr) + \
@@ -169,7 +169,7 @@ static int mei_fwver(struct mei_cl_device *cldev)
 	req.hdr.group_id = MKHI_GEN_GROUP_ID;
 	req.hdr.command = MKHI_GEN_GET_FW_VERSION_CMD;
 
-	ret = __mei_cl_send(cldev->cl, (u8 *)&req, sizeof(req),
+	ret = __mei_cl_send(cldev->cl, (u8 *)&req, sizeof(req), 0,
 			    MEI_CL_IO_TX_BLOCKING);
 	if (ret < 0) {
 		dev_err(&cldev->dev, "Could not send ReqFWVersion cmd\n");
@@ -177,7 +177,7 @@ static int mei_fwver(struct mei_cl_device *cldev)
 	}
 
 	ret = 0;
-	bytes_recv = __mei_cl_recv(cldev->cl, buf, sizeof(buf), 0,
+	bytes_recv = __mei_cl_recv(cldev->cl, buf, sizeof(buf), NULL, 0,
 				   MKHI_RCV_TIMEOUT);
 	if (bytes_recv < 0 || (size_t)bytes_recv < MKHI_FWVER_LEN(1)) {
 		/*
@@ -324,13 +324,15 @@ static int mei_nfc_if_version(struct mei_cl *cl,
 	};
 	struct mei_nfc_reply *reply = NULL;
 	size_t if_version_length;
+	u8 vtag;
 	int bytes_recv, ret;
 
 	bus = cl->dev;
 
 	WARN_ON(mutex_is_locked(&bus->device_lock));
 
-	ret = __mei_cl_send(cl, (u8 *)&cmd, sizeof(cmd), MEI_CL_IO_TX_BLOCKING);
+	ret = __mei_cl_send(cl, (u8 *)&cmd, sizeof(cmd), 0,
+			    MEI_CL_IO_TX_BLOCKING);
 	if (ret < 0) {
 		dev_err(bus->dev, "Could not send IF version cmd\n");
 		return ret;
@@ -344,7 +346,8 @@ static int mei_nfc_if_version(struct mei_cl *cl,
 		return -ENOMEM;
 
 	ret = 0;
-	bytes_recv = __mei_cl_recv(cl, (u8 *)reply, if_version_length, 0, 0);
+	bytes_recv = __mei_cl_recv(cl, (u8 *)reply, if_version_length, &vtag,
+				   0, 0);
 	if (bytes_recv < 0 || (size_t)bytes_recv < if_version_length) {
 		dev_err(bus->dev, "Could not read IF version\n");
 		ret = -EIO;
diff --git a/drivers/misc/mei/bus.c b/drivers/misc/mei/bus.c
index 7fe48baa103a..2907db260fba 100644
--- a/drivers/misc/mei/bus.c
+++ b/drivers/misc/mei/bus.c
@@ -26,11 +26,12 @@
  * @cl: host client
  * @buf: buffer to send
  * @length: buffer length
+ * @vtag: virtual tag
  * @mode: sending mode
  *
  * Return: written size bytes or < 0 on error
  */
-ssize_t __mei_cl_send(struct mei_cl *cl, u8 *buf, size_t length,
+ssize_t __mei_cl_send(struct mei_cl *cl, u8 *buf, size_t length, u8 vtag,
 		      unsigned int mode)
 {
 	struct mei_device *bus;
@@ -86,6 +87,7 @@ ssize_t __mei_cl_send(struct mei_cl *cl, u8 *buf, size_t length,
 		rets = -ENOMEM;
 		goto out;
 	}
+	cb->vtag = vtag;
 
 	cb->internal = !!(mode & MEI_CL_IO_TX_INTERNAL);
 	cb->blocking = !!(mode & MEI_CL_IO_TX_BLOCKING);
@@ -106,11 +108,12 @@ ssize_t __mei_cl_send(struct mei_cl *cl, u8 *buf, size_t length,
  * @buf: buffer to receive
  * @length: buffer length
  * @mode: io mode
+ * @vtag: virtual tag
  * @timeout: recv timeout, 0 for infinite timeout
  *
  * Return: read size in bytes of < 0 on error
  */
-ssize_t __mei_cl_recv(struct mei_cl *cl, u8 *buf, size_t length,
+ssize_t __mei_cl_recv(struct mei_cl *cl, u8 *buf, size_t length, u8 *vtag,
 		      unsigned int mode, unsigned long timeout)
 {
 	struct mei_device *bus;
@@ -196,6 +199,8 @@ ssize_t __mei_cl_recv(struct mei_cl *cl, u8 *buf, size_t length,
 	r_length = min_t(size_t, length, cb->buf_idx);
 	memcpy(buf, cb->buf.data, r_length);
 	rets = r_length;
+	if (vtag)
+		*vtag = cb->vtag;
 
 free:
 	mei_cl_del_rd_completed(cl, cb);
@@ -206,40 +211,87 @@ ssize_t __mei_cl_recv(struct mei_cl *cl, u8 *buf, size_t length,
 }
 
 /**
- * mei_cldev_send - me device send  (write)
+ * mei_cldev_send_vtag - me device send with vtag  (write)
  *
  * @cldev: me client device
  * @buf: buffer to send
  * @length: buffer length
+ * @vtag: virtual tag
  *
- * Return: written size in bytes or < 0 on error
+ * Return:
+ *  * written size in bytes
+ *  * < 0 on error
  */
-ssize_t mei_cldev_send(struct mei_cl_device *cldev, u8 *buf, size_t length)
+
+ssize_t mei_cldev_send_vtag(struct mei_cl_device *cldev, u8 *buf, size_t length,
+			    u8 vtag)
 {
 	struct mei_cl *cl = cldev->cl;
 
-	return __mei_cl_send(cl, buf, length, MEI_CL_IO_TX_BLOCKING);
+	return __mei_cl_send(cl, buf, length, vtag, MEI_CL_IO_TX_BLOCKING);
 }
-EXPORT_SYMBOL_GPL(mei_cldev_send);
+EXPORT_SYMBOL_GPL(mei_cldev_send_vtag);
 
 /**
- * mei_cldev_recv_nonblock - non block client receive (read)
+ * mei_cldev_recv_vtag - client receive with vtag (read)
  *
  * @cldev: me client device
  * @buf: buffer to receive
  * @length: buffer length
+ * @vtag: virtual tag
  *
- * Return: read size in bytes of < 0 on error
- *         -EAGAIN if function will block.
+ * Return:
+ * * read size in bytes
+ * *  < 0 on error
  */
-ssize_t mei_cldev_recv_nonblock(struct mei_cl_device *cldev, u8 *buf,
-				size_t length)
+
+ssize_t mei_cldev_recv_vtag(struct mei_cl_device *cldev, u8 *buf, size_t length,
+			    u8 *vtag)
 {
 	struct mei_cl *cl = cldev->cl;
 
-	return __mei_cl_recv(cl, buf, length, MEI_CL_IO_RX_NONBLOCK, 0);
+	return __mei_cl_recv(cl, buf, length, vtag, 0, 0);
 }
-EXPORT_SYMBOL_GPL(mei_cldev_recv_nonblock);
+EXPORT_SYMBOL_GPL(mei_cldev_recv_vtag);
+
+/**
+ * mei_cldev_recv_nonblock_vtag - non block client receive with vtag (read)
+ *
+ * @cldev: me client device
+ * @buf: buffer to receive
+ * @length: buffer length
+ * @vtag: virtual tag
+ *
+ * Return:
+ * * read size in bytes
+ * * -EAGAIN if function will block.
+ * * < 0 on other error
+ */
+ssize_t mei_cldev_recv_nonblock_vtag(struct mei_cl_device *cldev, u8 *buf,
+				     size_t length, u8 *vtag)
+{
+	struct mei_cl *cl = cldev->cl;
+
+	return __mei_cl_recv(cl, buf, length, vtag, MEI_CL_IO_RX_NONBLOCK, 0);
+}
+EXPORT_SYMBOL_GPL(mei_cldev_recv_nonblock_vtag);
+
+/**
+ * mei_cldev_send - me device send  (write)
+ *
+ * @cldev: me client device
+ * @buf: buffer to send
+ * @length: buffer length
+ *
+ * Return:
+ *  * written size in bytes
+ *  * < 0 on error
+ */
+ssize_t mei_cldev_send(struct mei_cl_device *cldev, u8 *buf, size_t length)
+{
+	return mei_cldev_send_vtag(cldev, buf, length, 0);
+}
+EXPORT_SYMBOL_GPL(mei_cldev_send);
 
 /**
  * mei_cldev_recv - client receive (read)
@@ -252,12 +304,27 @@ EXPORT_SYMBOL_GPL(mei_cldev_recv_nonblock);
  */
 ssize_t mei_cldev_recv(struct mei_cl_device *cldev, u8 *buf, size_t length)
 {
-	struct mei_cl *cl = cldev->cl;
-
-	return __mei_cl_recv(cl, buf, length, 0, 0);
+	return mei_cldev_recv_vtag(cldev, buf, length, NULL);
 }
 EXPORT_SYMBOL_GPL(mei_cldev_recv);
 
+/**
+ * mei_cldev_recv_nonblock - non block client receive (read)
+ *
+ * @cldev: me client device
+ * @buf: buffer to receive
+ * @length: buffer length
+ *
+ * Return: read size in bytes of < 0 on error
+ *         -EAGAIN if function will block.
+ */
+ssize_t mei_cldev_recv_nonblock(struct mei_cl_device *cldev, u8 *buf,
+				size_t length)
+{
+	return mei_cldev_recv_nonblock_vtag(cldev, buf, length, NULL);
+}
+EXPORT_SYMBOL_GPL(mei_cldev_recv_nonblock);
+
 /**
  * mei_cl_bus_rx_work - dispatch rx event for a bus device
  *
diff --git a/drivers/misc/mei/client.c b/drivers/misc/mei/client.c
index d5c3f7d54634..a56d41321f32 100644
--- a/drivers/misc/mei/client.c
+++ b/drivers/misc/mei/client.c
@@ -1306,7 +1306,7 @@ struct mei_cl_vtag *mei_cl_vtag_alloc(struct file *fp, u8 vtag)
  * mei_cl_fp_by_vtag - obtain the file pointer by vtag
  *
  * @cl: host client
- * @vtag: vm tag
+ * @vtag: virtual tag
  *
  * Return:
  * * A file pointer - on success
@@ -1317,7 +1317,9 @@ const struct file *mei_cl_fp_by_vtag(const struct mei_cl *cl, u8 vtag)
 	struct mei_cl_vtag *vtag_l;
 
 	list_for_each_entry(vtag_l, &cl->vtag_map, list)
-		if (vtag_l->vtag == vtag)
+		/* The client on bus has one fixed fp */
+		if ((cl->cldev && mei_cldev_enabled(cl->cldev)) ||
+		    vtag_l->vtag == vtag)
 			return vtag_l->fp;
 
 	return ERR_PTR(-ENOENT);
diff --git a/drivers/misc/mei/mei_dev.h b/drivers/misc/mei/mei_dev.h
index 2f4cc1a8aae8..8c395bfdf6f3 100644
--- a/drivers/misc/mei/mei_dev.h
+++ b/drivers/misc/mei/mei_dev.h
@@ -340,9 +340,9 @@ struct mei_hw_ops {
 /* MEI bus API*/
 void mei_cl_bus_rescan_work(struct work_struct *work);
 void mei_cl_bus_dev_fixup(struct mei_cl_device *dev);
-ssize_t __mei_cl_send(struct mei_cl *cl, u8 *buf, size_t length,
+ssize_t __mei_cl_send(struct mei_cl *cl, u8 *buf, size_t length, u8 vtag,
 		      unsigned int mode);
-ssize_t __mei_cl_recv(struct mei_cl *cl, u8 *buf, size_t length,
+ssize_t __mei_cl_recv(struct mei_cl *cl, u8 *buf, size_t length, u8 *vtag,
 		      unsigned int mode, unsigned long timeout);
 bool mei_cl_bus_rx_event(struct mei_cl *cl);
 bool mei_cl_bus_notify_event(struct mei_cl *cl);
diff --git a/include/linux/mei_cl_bus.h b/include/linux/mei_cl_bus.h
index 52aa4821093a..959ad7d850b4 100644
--- a/include/linux/mei_cl_bus.h
+++ b/include/linux/mei_cl_bus.h
@@ -95,6 +95,12 @@ ssize_t mei_cldev_send(struct mei_cl_device *cldev, u8 *buf, size_t length);
 ssize_t mei_cldev_recv(struct mei_cl_device *cldev, u8 *buf, size_t length);
 ssize_t mei_cldev_recv_nonblock(struct mei_cl_device *cldev, u8 *buf,
 				size_t length);
+ssize_t mei_cldev_send_vtag(struct mei_cl_device *cldev, u8 *buf, size_t length,
+			    u8 vtag);
+ssize_t mei_cldev_recv_vtag(struct mei_cl_device *cldev, u8 *buf, size_t length,
+			    u8 *vtag);
+ssize_t mei_cldev_recv_nonblock_vtag(struct mei_cl_device *cldev, u8 *buf,
+				     size_t length, u8 *vtag);
 
 int mei_cldev_register_rx_cb(struct mei_cl_device *cldev, mei_cldev_cb_t rx_cb);
 int mei_cldev_register_notif_cb(struct mei_cl_device *cldev,
-- 
2.26.2

