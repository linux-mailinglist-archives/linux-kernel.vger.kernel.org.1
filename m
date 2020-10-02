Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84402281A97
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 20:09:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388375AbgJBSJd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 14:09:33 -0400
Received: from z5.mailgun.us ([104.130.96.5]:58724 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726813AbgJBSJc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 14:09:32 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1601662171; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=wOU3KRfuJdAjV10EUMTzMmHkchPDGV4cm34qR2QS/Jg=; b=Ner4IU/nEP4e1e6KRBxFEWPU+Znir7lH9eVk18PP7lXt+CLhW6xmK8CD+UVQFwhmkOcR006T
 wAtGIh4Gfir9ggS5vYTaqqoFexFzOq1jAkghmpD5DcRZh5BaVSpLS4WPzyMbEVuhASJXG7Ug
 bBgyQcvFj/ULDQjIQpT8GeWDsZg=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-west-2.postgun.com with SMTP id
 5f776cdad6d00c7a9ebb32ca (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 02 Oct 2020 18:09:30
 GMT
Sender: rishabhb=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id ACBC2C43385; Fri,  2 Oct 2020 18:09:30 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from rishabhb-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rishabhb)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 98A15C433F1;
        Fri,  2 Oct 2020 18:09:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 98A15C433F1
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=rishabhb@codeaurora.org
From:   Rishabh Bhatnagar <rishabhb@codeaurora.org>
To:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        bjorn.andersson@linaro.org
Cc:     tsoni@codeaurora.org, psodagud@codeaurora.org,
        sidgup@codeaurora.org, Rishabh Bhatnagar <rishabhb@codeaurora.org>
Subject: [PATCH v7 2/3] remoteproc: Add coredump as part of sysfs interface
Date:   Fri,  2 Oct 2020 11:09:03 -0700
Message-Id: <1601662144-5964-3-git-send-email-rishabhb@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1601662144-5964-1-git-send-email-rishabhb@codeaurora.org>
References: <1601662144-5964-1-git-send-email-rishabhb@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add coredump as part of the sysfs interface. This will
allow usage of this configuration feature in production
devices where access to debugfs might be limited.

Signed-off-by: Rishabh Bhatnagar <rishabhb@codeaurora.org>
---
 Documentation/ABI/testing/sysfs-class-remoteproc | 24 +++++++++
 drivers/remoteproc/remoteproc_sysfs.c            | 63 ++++++++++++++++++++++++
 2 files changed, 87 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-class-remoteproc b/Documentation/ABI/testing/sysfs-class-remoteproc
index 36094fb..050bd25 100644
--- a/Documentation/ABI/testing/sysfs-class-remoteproc
+++ b/Documentation/ABI/testing/sysfs-class-remoteproc
@@ -58,3 +58,27 @@ Description:	Remote processor name
 		Reports the name of the remote processor. This can be used by
 		userspace in exactly identifying a remote processor and ease
 		up the usage in modifying the 'firmware' or 'state' files.
+
+What:		/sys/class/remoteproc/.../coredump
+Date:		July 2020
+Contact:	Bjorn Andersson <bjorn.andersson@linaro.org>, Ohad Ben-Cohen <ohad@wizery.com>
+Description:	Remote processor coredump configuration
+
+		Reports the coredump configuration of the remote processor,
+		which will be one of:
+
+		"disabled"
+		"enabled"
+		"inline"
+
+		"disabled" means no dump will be collected.
+
+		"enabled" means when the remote processor's coredump is
+		collected it will be copied to a separate buffer and that
+		buffer is exposed to userspace.
+
+		"inline" means when the remote processor's coredump is
+		collected userspace will directly read from the remote
+		processor's device memory. Extra buffer will not be used to
+		copy the dump. Also recovery process will not proceed until
+		all data is read by usersapce.
diff --git a/drivers/remoteproc/remoteproc_sysfs.c b/drivers/remoteproc/remoteproc_sysfs.c
index eea514c..8500271 100644
--- a/drivers/remoteproc/remoteproc_sysfs.c
+++ b/drivers/remoteproc/remoteproc_sysfs.c
@@ -10,6 +10,68 @@
 
 #define to_rproc(d) container_of(d, struct rproc, dev)
 
+/*
+ * A coredump-configuration-to-string lookup table, for exposing a
+ * human readable configuration via sysfs. Always keep in sync with
+ * enum rproc_coredump_mechanism
+ */
+static const char * const rproc_coredump_str[] = {
+	[RPROC_COREDUMP_DISABLED]	= "disabled",
+	[RPROC_COREDUMP_ENABLED]	= "enabled",
+	[RPROC_COREDUMP_INLINE]		= "inline",
+};
+
+/* Expose the current coredump configuration via debugfs */
+static ssize_t coredump_show(struct device *dev,
+			     struct device_attribute *attr, char *buf)
+{
+	struct rproc *rproc = to_rproc(dev);
+
+	return sprintf(buf, "%s\n", rproc_coredump_str[rproc->dump_conf]);
+}
+
+/*
+ * By writing to the 'coredump' sysfs entry, we control the behavior of the
+ * coredump mechanism dynamically. The default value of this entry is "default".
+ *
+ * The 'coredump' sysfs entry supports these commands:
+ *
+ * disabled:	This is the default coredump mechanism. Recovery will proceed
+ *		without collecting any dump.
+ *
+ * default:	When the remoteproc crashes the entire coredump will be
+ *		copied to a separate buffer and exposed to userspace.
+ *
+ * inline:	The coredump will not be copied to a separate buffer and the
+ *		recovery process will have to wait until data is read by
+ *		userspace. But this avoid usage of extra memory.
+ */
+static ssize_t coredump_store(struct device *dev,
+			      struct device_attribute *attr,
+			      const char *buf, size_t count)
+{
+	struct rproc *rproc = to_rproc(dev);
+
+	if (rproc->state == RPROC_CRASHED) {
+		dev_err(&rproc->dev, "can't change coredump configuration\n");
+		return -EBUSY;
+	}
+
+	if (sysfs_streq(buf, "disabled")) {
+		rproc->dump_conf = RPROC_COREDUMP_DISABLED;
+	} else if (sysfs_streq(buf, "enabled")) {
+		rproc->dump_conf = RPROC_COREDUMP_ENABLED;
+	} else if (sysfs_streq(buf, "inline")) {
+		rproc->dump_conf = RPROC_COREDUMP_INLINE;
+	} else {
+		dev_err(&rproc->dev, "Invalid coredump configuration\n");
+		return -EINVAL;
+	}
+
+	return count;
+}
+static DEVICE_ATTR_RW(coredump);
+
 /* Expose the loaded / running firmware name via sysfs */
 static ssize_t firmware_show(struct device *dev, struct device_attribute *attr,
 			  char *buf)
@@ -138,6 +200,7 @@ static ssize_t name_show(struct device *dev, struct device_attribute *attr,
 static DEVICE_ATTR_RO(name);
 
 static struct attribute *rproc_attrs[] = {
+	&dev_attr_coredump.attr,
 	&dev_attr_firmware.attr,
 	&dev_attr_state.attr,
 	&dev_attr_name.attr,
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

