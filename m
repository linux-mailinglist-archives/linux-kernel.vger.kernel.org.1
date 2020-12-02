Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F12BB2CC817
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 21:46:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731267AbgLBUmd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 15:42:33 -0500
Received: from foss.arm.com ([217.140.110.172]:50474 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388293AbgLBUm0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 15:42:26 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F013115AD;
        Wed,  2 Dec 2020 12:41:32 -0800 (PST)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4902D3F575;
        Wed,  2 Dec 2020 12:41:31 -0800 (PST)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, lukasz.luba@arm.com,
        james.quinlan@broadcom.com, Jonathan.Cameron@Huawei.com,
        f.fainelli@gmail.com, etienne.carriere@linaro.org,
        thara.gopinath@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com,
        Cristian Marussi <cristian.marussi@arm.com>
Subject: [PATCH v3 32/37] firmware: arm_scmi: cleanup legacy protocol init code
Date:   Wed,  2 Dec 2020 20:40:04 +0000
Message-Id: <20201202204009.32073-33-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201202204009.32073-1-cristian.marussi@arm.com>
References: <20201202204009.32073-1-cristian.marussi@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that all protocols and drivers have been ported to the new interface
based on protocol handles and get/put operations, remove all the legacy
transient initialization code.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/firmware/arm_scmi/bus.c    | 26 +-------------------------
 drivers/firmware/arm_scmi/common.h |  5 +----
 2 files changed, 2 insertions(+), 29 deletions(-)

diff --git a/drivers/firmware/arm_scmi/bus.c b/drivers/firmware/arm_scmi/bus.c
index 044aa9e3ebb0..9fbf618b9c4b 100644
--- a/drivers/firmware/arm_scmi/bus.c
+++ b/drivers/firmware/arm_scmi/bus.c
@@ -66,27 +66,11 @@ const struct scmi_protocol *scmi_get_protocol(int protocol_id)
 	return proto;
 }
 
-static int scmi_protocol_init(int protocol_id, struct scmi_handle *handle)
-{
-	const struct scmi_protocol *proto;
-
-	proto = scmi_get_protocol(protocol_id);
-	if (!proto)
-		return -EINVAL;
-	return proto->init(handle);
-}
-
-static int scmi_protocol_dummy_init(struct scmi_handle *handle)
-{
-	return 0;
-}
-
 static int scmi_dev_probe(struct device *dev)
 {
 	struct scmi_driver *scmi_drv = to_scmi_driver(dev->driver);
 	struct scmi_device *scmi_dev = to_scmi_dev(dev);
 	const struct scmi_device_id *id;
-	int ret;
 
 	id = scmi_dev_match_id(scmi_dev, scmi_drv);
 	if (!id)
@@ -95,14 +79,6 @@ static int scmi_dev_probe(struct device *dev)
 	if (!scmi_dev->handle)
 		return -EPROBE_DEFER;
 
-	ret = scmi_protocol_init(scmi_dev->protocol_id, scmi_dev->handle);
-	if (ret)
-		return ret;
-
-	/* Skip protocol initialisation for additional devices */
-	idr_replace(&scmi_available_protocols, &scmi_protocol_dummy_init,
-		    scmi_dev->protocol_id);
-
 	return scmi_drv->probe(scmi_dev);
 }
 
@@ -219,7 +195,7 @@ int scmi_protocol_register(const struct scmi_protocol *proto)
 		return -EINVAL;
 	}
 
-	if (!proto->init && !proto->init_instance) {
+	if (!proto->init_instance) {
 		pr_err("missing .init() for protocol 0x%x\n", proto->id);
 		return -EINVAL;
 	}
diff --git a/drivers/firmware/arm_scmi/common.h b/drivers/firmware/arm_scmi/common.h
index 45387a32d79e..86f4fb707145 100644
--- a/drivers/firmware/arm_scmi/common.h
+++ b/drivers/firmware/arm_scmi/common.h
@@ -224,14 +224,12 @@ int scmi_version_get(const struct scmi_handle *h, u8 protocol, u32 *version);
 void scmi_setup_protocol_implemented(const struct scmi_protocol_handle *ph,
 				     u8 *prot_imp);
 
-typedef int (*scmi_prot_init_fn_t)(struct scmi_handle *);
 typedef int (*scmi_prot_init_ph_fn_t)(const struct scmi_protocol_handle *);
 
 /**
  * struct scmi_protocol  - Protocol descriptor
  * @id: Protocol ID.
- * @init: Mandatory protocol initialization function.
- * @init_instance: Optional protocol instance initialization function.
+ * @init_instance: Mandatory protocol initialization function.
  * @deinit_instance: Optional protocol de-initialization function.
  * @ops: Optional reference to the operations provided by the protocol and
  *	 exposed in scmi_protocol.h.
@@ -239,7 +237,6 @@ typedef int (*scmi_prot_init_ph_fn_t)(const struct scmi_protocol_handle *);
  */
 struct scmi_protocol {
 	const u8				id;
-	const scmi_prot_init_fn_t		init;
 	const scmi_prot_init_ph_fn_t		init_instance;
 	const scmi_prot_init_ph_fn_t		deinit_instance;
 	const void				*ops;
-- 
2.17.1

