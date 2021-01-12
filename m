Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E2182F3A09
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 20:24:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436632AbhALTWk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 14:22:40 -0500
Received: from foss.arm.com ([217.140.110.172]:52056 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2436613AbhALTWi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 14:22:38 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6F339143B;
        Tue, 12 Jan 2021 11:21:18 -0800 (PST)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9D0DA3F66E;
        Tue, 12 Jan 2021 11:21:16 -0800 (PST)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, lukasz.luba@arm.com,
        james.quinlan@broadcom.com, Jonathan.Cameron@Huawei.com,
        f.fainelli@gmail.com, etienne.carriere@linaro.org,
        thara.gopinath@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com, cristian.marussi@arm.com
Subject: [PATCH v5 09/36] firmware: arm_scmi: add helper to access revision area memory
Date:   Tue, 12 Jan 2021 19:19:51 +0000
Message-Id: <20210112192018.34994-10-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210112192018.34994-1-cristian.marussi@arm.com>
References: <20210112192018.34994-1-cristian.marussi@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an helper to grab, from a protocol handle, the handle common memory
area allocated to store SCMI version data which is exposed on sysfs.
Such helper will be needed by SCMI Base protocol initialization once it
will be moved to new protocol handles scheme.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/firmware/arm_scmi/common.h |  2 ++
 drivers/firmware/arm_scmi/driver.c | 19 +++++++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/drivers/firmware/arm_scmi/common.h b/drivers/firmware/arm_scmi/common.h
index 10ac5a6daf10..428bfba40dfd 100644
--- a/drivers/firmware/arm_scmi/common.h
+++ b/drivers/firmware/arm_scmi/common.h
@@ -215,6 +215,8 @@ struct scmi_xfer_ops {
 			 struct scmi_xfer *xfer);
 };
 
+struct scmi_revision_info *
+scmi_get_revision_area(const struct scmi_protocol_handle *ph);
 int scmi_handle_put(const struct scmi_handle *handle);
 struct scmi_handle *scmi_handle_get(struct device *dev);
 void scmi_set_handle(struct scmi_device *scmi_dev);
diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index 112cbc8e9b52..ea3d7493b1a4 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -698,6 +698,25 @@ static const struct scmi_xfer_ops xfer_ops = {
 	.xfer_put = xfer_put,
 };
 
+/**
+ * scmi_get_revision_area  - Retrieve version memory area.
+ *
+ * @ph: A reference to the protocol handle.
+ *
+ * A helper to grab the version memory area reference during SCMI Base protocol
+ * initialization.
+ *
+ * Return: A reference to the version memory area associated to the SCMI
+ *	   instance underlying this protocol handle.
+ */
+struct scmi_revision_info *
+scmi_get_revision_area(const struct scmi_protocol_handle *ph)
+{
+	const struct scmi_protocol_instance *pi = ph_to_pi(ph);
+
+	return pi->handle->version;
+}
+
 /**
  * scmi_get_protocol_instance  - Protocol initialization helper.
  * @handle: A reference to the SCMI platform instance.
-- 
2.17.1

