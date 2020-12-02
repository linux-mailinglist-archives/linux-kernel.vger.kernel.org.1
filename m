Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83CE12CC816
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 21:46:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731254AbgLBUm2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 15:42:28 -0500
Received: from foss.arm.com ([217.140.110.172]:50472 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388306AbgLBUm0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 15:42:26 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3B04515BF;
        Wed,  2 Dec 2020 12:41:35 -0800 (PST)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 334523F575;
        Wed,  2 Dec 2020 12:41:33 -0800 (PST)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, lukasz.luba@arm.com,
        james.quinlan@broadcom.com, Jonathan.Cameron@Huawei.com,
        f.fainelli@gmail.com, etienne.carriere@linaro.org,
        thara.gopinath@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com,
        Cristian Marussi <cristian.marussi@arm.com>
Subject: [PATCH v3 33/37] firmware: arm_scmi: cleanup unused core xfer wrappers
Date:   Wed,  2 Dec 2020 20:40:05 +0000
Message-Id: <20201202204009.32073-34-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201202204009.32073-1-cristian.marussi@arm.com>
References: <20201202204009.32073-1-cristian.marussi@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unused core scmi_xfer wrappers now that we have migrated all
protocols to the new interface based on protocol handles.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/firmware/arm_scmi/common.h | 15 -----
 drivers/firmware/arm_scmi/driver.c | 91 ------------------------------
 2 files changed, 106 deletions(-)

diff --git a/drivers/firmware/arm_scmi/common.h b/drivers/firmware/arm_scmi/common.h
index 86f4fb707145..65db0aefc489 100644
--- a/drivers/firmware/arm_scmi/common.h
+++ b/drivers/firmware/arm_scmi/common.h
@@ -143,15 +143,6 @@ struct scmi_xfer {
 	struct completion *async_done;
 };
 
-void scmi_xfer_put(const struct scmi_handle *h, struct scmi_xfer *xfer);
-int scmi_do_xfer(const struct scmi_handle *h, struct scmi_xfer *xfer);
-int scmi_do_xfer_with_response(const struct scmi_handle *h,
-			       struct scmi_xfer *xfer);
-int scmi_xfer_get_init(const struct scmi_handle *h, u8 msg_id, u8 prot_id,
-		       size_t tx_size, size_t rx_size, struct scmi_xfer **p);
-void scmi_reset_rx_to_maxsz(const struct scmi_handle *handle,
-			    struct scmi_xfer *xfer);
-
 struct scmi_xfer_ops;
 
 /**
@@ -181,11 +172,6 @@ struct scmi_protocol_handle {
 	void *(*get_priv)(const struct scmi_protocol_handle *ph);
 };
 
-const struct scmi_protocol_handle *
-scmi_map_protocol_handle(const struct scmi_handle *handle, u8 prot_id);
-
-struct scmi_handle *scmi_map_scmi_handle(const struct scmi_protocol_handle *ph);
-
 /**
  * struct scmi_xfer_ops  - References to the core SCMI xfer operations.
  * @version_get: Get this version protocol.
@@ -220,7 +206,6 @@ scmi_get_revision_area(const struct scmi_protocol_handle *ph);
 int scmi_handle_put(const struct scmi_handle *handle);
 struct scmi_handle *scmi_handle_get(struct device *dev);
 void scmi_set_handle(struct scmi_device *scmi_dev);
-int scmi_version_get(const struct scmi_handle *h, u8 protocol, u32 *version);
 void scmi_setup_protocol_implemented(const struct scmi_protocol_handle *ph,
 				     u8 *prot_imp);
 
diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index 68a40d83325c..77e108475aea 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -349,28 +349,6 @@ void scmi_rx_callback(struct scmi_chan_info *cinfo, u32 msg_hdr)
 	}
 }
 
-/* Transient code wrapper to ease API migration */
-const struct scmi_protocol_handle *
-scmi_map_protocol_handle(const struct scmi_handle *handle, u8 prot_id)
-{
-	struct scmi_info *info = handle_to_scmi_info(handle);
-	const struct scmi_protocol_instance *pi;
-
-	mutex_lock(&info->protocols_mtx);
-	pi = idr_find(&info->protocols, prot_id);
-	mutex_unlock(&info->protocols_mtx);
-
-	return pi ? &pi->ph : NULL;
-}
-
-/* Transient code wrapper to ease API migration */
-struct scmi_handle *scmi_map_scmi_handle(const struct scmi_protocol_handle *ph)
-{
-	const struct scmi_protocol_instance *pi = ph_to_pi(ph);
-
-	return (struct scmi_handle *)pi->handle;
-}
-
 /**
  * xfer_put() - Release a transmit message
  *
@@ -386,17 +364,6 @@ static void xfer_put(const struct scmi_protocol_handle *ph,
 	__scmi_xfer_put(&info->tx_minfo, xfer);
 }
 
-void scmi_xfer_put(const struct scmi_handle *h, struct scmi_xfer *xfer)
-{
-	const struct scmi_protocol_handle *ph;
-
-	ph = scmi_map_protocol_handle(h, xfer->hdr.protocol_id);
-	if (!ph)
-		return;
-
-	return xfer_put(ph, xfer);
-}
-
 #define SCMI_MAX_POLL_TO_NS	(100 * NSEC_PER_USEC)
 
 static bool scmi_xfer_done_no_timeout(struct scmi_chan_info *cinfo,
@@ -480,17 +447,6 @@ static int do_xfer(const struct scmi_protocol_handle *ph,
 	return ret;
 }
 
-int scmi_do_xfer(const struct scmi_handle *h, struct scmi_xfer *xfer)
-{
-	const struct scmi_protocol_handle *ph;
-
-	ph = scmi_map_protocol_handle(h, xfer->hdr.protocol_id);
-	if (!ph)
-		return -EINVAL;
-
-	return do_xfer(ph, xfer);
-}
-
 static void reset_rx_to_maxsz(const struct scmi_protocol_handle *ph,
 			      struct scmi_xfer *xfer)
 {
@@ -500,18 +456,6 @@ static void reset_rx_to_maxsz(const struct scmi_protocol_handle *ph,
 	xfer->rx.len = info->desc->max_msg_size;
 }
 
-void scmi_reset_rx_to_maxsz(const struct scmi_handle *handle,
-			    struct scmi_xfer *xfer)
-{
-	const struct scmi_protocol_handle *ph;
-
-	ph = scmi_map_protocol_handle(handle, xfer->hdr.protocol_id);
-	if (!ph)
-		return;
-
-	return reset_rx_to_maxsz(ph, xfer);
-}
-
 #define SCMI_MAX_RESPONSE_TIMEOUT	(2 * MSEC_PER_SEC)
 
 /**
@@ -543,18 +487,6 @@ static int do_xfer_with_response(const struct scmi_protocol_handle *ph,
 	return ret;
 }
 
-int scmi_do_xfer_with_response(const struct scmi_handle *h,
-			       struct scmi_xfer *xfer)
-{
-	const struct scmi_protocol_handle *ph;
-
-	ph = scmi_map_protocol_handle(h, xfer->hdr.protocol_id);
-	if (!ph)
-		return -EINVAL;
-
-	return do_xfer_with_response(ph, xfer);
-}
-
 /**
  * xfer_get_init() - Allocate and initialise one message for transmit
  *
@@ -604,18 +536,6 @@ static int xfer_get_init(const struct scmi_protocol_handle *ph,
 	return 0;
 }
 
-int scmi_xfer_get_init(const struct scmi_handle *h, u8 msg_id, u8 prot_id,
-		       size_t tx_size, size_t rx_size, struct scmi_xfer **p)
-{
-	const struct scmi_protocol_handle *ph;
-
-	ph = scmi_map_protocol_handle(h, prot_id);
-	if (!ph)
-		return -EINVAL;
-
-	return xfer_get_init(ph, msg_id, tx_size, rx_size, p);
-}
-
 /**
  * version_get() - command to get the revision of the SCMI entity
  *
@@ -646,17 +566,6 @@ static int version_get(const struct scmi_protocol_handle *ph, u32 *version)
 	return ret;
 }
 
-int scmi_version_get(const struct scmi_handle *h, u8 protocol, u32 *version)
-{
-	const struct scmi_protocol_handle *ph;
-
-	ph = scmi_map_protocol_handle(h, protocol);
-	if (!ph)
-		return -EINVAL;
-
-	return version_get(ph, version);
-}
-
 /**
  * scmi_set_protocol_priv  - Set protocol specific data at init time
  *
-- 
2.17.1

