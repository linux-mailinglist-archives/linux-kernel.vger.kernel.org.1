Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 859CB27B790
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 01:13:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726981AbgI1XNO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 19:13:14 -0400
Received: from m42-4.mailgun.net ([69.72.42.4]:61694 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726897AbgI1XNK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 19:13:10 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1601334789; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=afgiR/yVxmltdcCBvQWGeNdnLZiCZ8jgwmV862dUq3I=; b=O4rDv21xomPtAUzZYfFXjQoPWEZ8VADanr8VAdP+SZKzxs0bg86vzEeiEeAspmmQ0mLQspBT
 I6CXAWE/FyhUUmhvSLJRwwsp8uCxxsENn8nvjOaOcQN5mythmjMUJo3X2tZaTLCE8x7bGkpf
 EdzlnYsoCdAqk5EQDAXsi5bZ69k=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-west-2.postgun.com with SMTP id
 5f7261103a7e097c8cb32424 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 28 Sep 2020 22:17:52
 GMT
Sender: rishabhb=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id AFF9BC43385; Mon, 28 Sep 2020 22:17:52 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from rishabhb-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rishabhb)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id BB331C433F1;
        Mon, 28 Sep 2020 22:17:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BB331C433F1
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=rishabhb@codeaurora.org
From:   Rishabh Bhatnagar <rishabhb@codeaurora.org>
To:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        bjorn.andersson@linaro.org
Cc:     tsoni@codeaurora.org, psodagud@codeaurora.org,
        sidgup@codeaurora.org, Rishabh Bhatnagar <rishabhb@codeaurora.org>
Subject: [PATCH v6 1/3] remoteproc: Move coredump configuration to sysfs
Date:   Mon, 28 Sep 2020 15:17:34 -0700
Message-Id: <1601331456-20432-2-git-send-email-rishabhb@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1601331456-20432-1-git-send-email-rishabhb@codeaurora.org>
References: <1601331456-20432-1-git-send-email-rishabhb@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move coredump configuration from debugfs to sysfs.This will
allow usage of this configuration feature in production
devices where access to debugfs might be limited.

Signed-off-by: Rishabh Bhatnagar <rishabhb@codeaurora.org>
---
 Documentation/ABI/testing/sysfs-class-remoteproc | 24 +++++++
 drivers/remoteproc/remoteproc_debugfs.c          | 90 ------------------------
 drivers/remoteproc/remoteproc_sysfs.c            | 64 +++++++++++++++++
 3 files changed, 88 insertions(+), 90 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-class-remoteproc b/Documentation/ABI/testing/sysfs-class-remoteproc
index 36094fb..f6c44fa 100644
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
+		"default"
+		"inline"
+		"disabled"
+
+		"default" means when the remote processor's coredump is
+		collected it will be copied to a separate buffer and that
+		buffer is exposed to userspace.
+
+		"inline" means when the remote processor's coredump is
+		collected userspace will directly read from the remote
+		processor's device memory. Extra buffer will not be used to
+		copy the dump. Also recovery process will not proceed until
+		all data is read by usersapce.
+
+		"disabled" means no dump will be collected.
diff --git a/drivers/remoteproc/remoteproc_debugfs.c b/drivers/remoteproc/remoteproc_debugfs.c
index 2e3b3e2..732770e 100644
--- a/drivers/remoteproc/remoteproc_debugfs.c
+++ b/drivers/remoteproc/remoteproc_debugfs.c
@@ -28,94 +28,6 @@
 static struct dentry *rproc_dbg;
 
 /*
- * A coredump-configuration-to-string lookup table, for exposing a
- * human readable configuration via debugfs. Always keep in sync with
- * enum rproc_coredump_mechanism
- */
-static const char * const rproc_coredump_str[] = {
-	[RPROC_COREDUMP_DEFAULT]	= "default",
-	[RPROC_COREDUMP_INLINE]		= "inline",
-	[RPROC_COREDUMP_DISABLED]	= "disabled",
-};
-
-/* Expose the current coredump configuration via debugfs */
-static ssize_t rproc_coredump_read(struct file *filp, char __user *userbuf,
-				   size_t count, loff_t *ppos)
-{
-	struct rproc *rproc = filp->private_data;
-	char buf[20];
-	int len;
-
-	len = scnprintf(buf, sizeof(buf), "%s\n",
-			rproc_coredump_str[rproc->dump_conf]);
-
-	return simple_read_from_buffer(userbuf, count, ppos, buf, len);
-}
-
-/*
- * By writing to the 'coredump' debugfs entry, we control the behavior of the
- * coredump mechanism dynamically. The default value of this entry is "default".
- *
- * The 'coredump' debugfs entry supports these commands:
- *
- * default:	This is the default coredump mechanism. When the remoteproc
- *		crashes the entire coredump will be copied to a separate buffer
- *		and exposed to userspace.
- *
- * inline:	The coredump will not be copied to a separate buffer and the
- *		recovery process will have to wait until data is read by
- *		userspace. But this avoid usage of extra memory.
- *
- * disabled:	This will disable coredump. Recovery will proceed without
- *		collecting any dump.
- */
-static ssize_t rproc_coredump_write(struct file *filp,
-				    const char __user *user_buf, size_t count,
-				    loff_t *ppos)
-{
-	struct rproc *rproc = filp->private_data;
-	int ret, err = 0;
-	char buf[20];
-
-	if (count > sizeof(buf))
-		return -EINVAL;
-
-	ret = copy_from_user(buf, user_buf, count);
-	if (ret)
-		return -EFAULT;
-
-	/* remove end of line */
-	if (buf[count - 1] == '\n')
-		buf[count - 1] = '\0';
-
-	if (rproc->state == RPROC_CRASHED) {
-		dev_err(&rproc->dev, "can't change coredump configuration\n");
-		err = -EBUSY;
-		goto out;
-	}
-
-	if (!strncmp(buf, "disable", count)) {
-		rproc->dump_conf = RPROC_COREDUMP_DISABLED;
-	} else if (!strncmp(buf, "inline", count)) {
-		rproc->dump_conf = RPROC_COREDUMP_INLINE;
-	} else if (!strncmp(buf, "default", count)) {
-		rproc->dump_conf = RPROC_COREDUMP_DEFAULT;
-	} else {
-		dev_err(&rproc->dev, "Invalid coredump configuration\n");
-		err = -EINVAL;
-	}
-out:
-	return err ? err : count;
-}
-
-static const struct file_operations rproc_coredump_fops = {
-	.read = rproc_coredump_read,
-	.write = rproc_coredump_write,
-	.open = simple_open,
-	.llseek = generic_file_llseek,
-};
-
-/*
  * Some remote processors may support dumping trace logs into a shared
  * memory buffer. We expose this trace buffer using debugfs, so users
  * can easily tell what's going on remotely.
@@ -425,8 +337,6 @@ void rproc_create_debug_dir(struct rproc *rproc)
 			    rproc, &rproc_rsc_table_fops);
 	debugfs_create_file("carveout_memories", 0400, rproc->dbg_dir,
 			    rproc, &rproc_carveouts_fops);
-	debugfs_create_file("coredump", 0600, rproc->dbg_dir,
-			    rproc, &rproc_coredump_fops);
 }
 
 void __init rproc_init_debugfs(void)
diff --git a/drivers/remoteproc/remoteproc_sysfs.c b/drivers/remoteproc/remoteproc_sysfs.c
index eea514c..2a44571 100644
--- a/drivers/remoteproc/remoteproc_sysfs.c
+++ b/drivers/remoteproc/remoteproc_sysfs.c
@@ -10,6 +10,69 @@
 
 #define to_rproc(d) container_of(d, struct rproc, dev)
 
+/*
+ * A coredump-configuration-to-string lookup table, for exposing a
+ * human readable configuration via sysfs. Always keep in sync with
+ * enum rproc_coredump_mechanism
+ */
+static const char * const rproc_coredump_str[] = {
+	[RPROC_COREDUMP_DEFAULT]	= "default",
+	[RPROC_COREDUMP_INLINE]		= "inline",
+	[RPROC_COREDUMP_DISABLED]	= "disabled",
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
+ * default:	This is the default coredump mechanism. When the remoteproc
+ *		crashes the entire coredump will be copied to a separate buffer
+ *		and exposed to userspace.
+ *
+ * inline:	The coredump will not be copied to a separate buffer and the
+ *		recovery process will have to wait until data is read by
+ *		userspace. But this avoid usage of extra memory.
+ *
+ * disabled:	This will disable coredump. Recovery will proceed without
+ *		collecting any dump.
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
+	} else if (sysfs_streq(buf, "inline")) {
+		rproc->dump_conf = RPROC_COREDUMP_INLINE;
+	} else if (sysfs_streq(buf, "default")) {
+		rproc->dump_conf = RPROC_COREDUMP_DEFAULT;
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
@@ -138,6 +201,7 @@ static ssize_t name_show(struct device *dev, struct device_attribute *attr,
 static DEVICE_ATTR_RO(name);
 
 static struct attribute *rproc_attrs[] = {
+	&dev_attr_coredump.attr,
 	&dev_attr_firmware.attr,
 	&dev_attr_state.attr,
 	&dev_attr_name.attr,
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

