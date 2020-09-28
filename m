Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17A4627A63E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 06:11:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726811AbgI1ELh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 00:11:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726801AbgI1ELd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 00:11:33 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EED4FC0613CE
        for <linux-kernel@vger.kernel.org>; Sun, 27 Sep 2020 21:11:32 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id 7so7133192pgm.11
        for <linux-kernel@vger.kernel.org>; Sun, 27 Sep 2020 21:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=L3CU+DoqUHiRxVgJAceWJlznOoGillE+BlhtluWnPFM=;
        b=sCrjJAvp9cuBWp9Knm8maBWh7YqKBJfFuwLRunOz8FEIXENz/y9dpS8UQlKauHoh+R
         thVn5j9kq07sTfTyIxhPrsVE1mFDdMbj9hlFlpMOLnb1cqN+V3Ak+QNwWgVne7aQsAbz
         +d1h5l1lYsKfAo8B0j4Xf/5Ut+1haPzcrd/3tBnlqo5EsDoP0/GtEX0yJ9XKQUWWHjcS
         XPjRSQayrykVPX1XPUxNaYv1iNNUAkdMTESnrCompK7iRMRAWt0oPr54rsEtoPUQPVUf
         l5nVtLTXIOOLRae+TujUXL0BDNu7F/uUeekNLGNlPW+fcE1s6sI6abzlPLEse0tE5hG5
         Ay3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=L3CU+DoqUHiRxVgJAceWJlznOoGillE+BlhtluWnPFM=;
        b=rnJHju1kXV8AZKjai5Wnxy8ZvhjGc3wbYR1CW/3GkhVRxDAwKC+NUG8P+5cRe2mwUK
         OxhZqCG/w4vcEZY/hfcYZQk8e6t6D7n6DpFuJbs2S1MDG0fY/PYlzbHfs57twEKiJAkK
         orVW58ZlL/Wc50isSFQ2LCRfAE9SknedL9ApXVSH2LtcQQwTEmqOY1WkPYns8j1W9JHE
         KfqaF7ro8ha/Ae6MjusH4B3vajZNBaqrweS62ccCEXYWB/GURBdxPx7zb1wWdqingf90
         dzpj4hZHesT6WdyDpFl9PWSzAOHn7GOcunzsIIqD9Pesp0hfgXCgrBFrKuFxmz3AucEQ
         fmsA==
X-Gm-Message-State: AOAM533EOnnHiU8rLx/g+EF28AeEWKhdNFhZDjFnFDOghmdT75PZAQyQ
        x/t2eWF6GYgLBfIot2Eov/KR
X-Google-Smtp-Source: ABdhPJwk+6BQpg+mtpglgm7vcwRHPQ1c5HCB9Xx6Kv9UpY0C1y9RfGHALHrQyF8lO4ja1aF7U/CsAQ==
X-Received: by 2002:a17:902:b949:b029:d2:8abd:c8ed with SMTP id h9-20020a170902b949b02900d28abdc8edmr2188859pls.63.1601266292412;
        Sun, 27 Sep 2020 21:11:32 -0700 (PDT)
Received: from Mani-XPS-13-9360.localdomain ([2409:4072:6003:40df:7c40:5a87:eb86:87b0])
        by smtp.gmail.com with ESMTPSA id n21sm8306322pgl.7.2020.09.27.21.11.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2020 21:11:31 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     hemantk@codeaurora.org, bbhatt@codeaurora.org,
        linux-arm-msm@vger.kernel.org, jhugo@codeaurora.org,
        linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 15/21] bus: mhi: core: Introduce sysfs entries for MHI
Date:   Mon, 28 Sep 2020 09:39:45 +0530
Message-Id: <20200928040951.18207-16-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200928040951.18207-1-manivannan.sadhasivam@linaro.org>
References: <20200928040951.18207-1-manivannan.sadhasivam@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bhaumik Bhatt <bbhatt@codeaurora.org>

Introduce sysfs entries to enable userspace clients the ability to read
the serial number and the OEM PK Hash values obtained from BHI. OEMs
need to read these device-specific hardware information values through
userspace for factory testing purposes and cannot be exposed via degbufs
as it may remain disabled for performance reasons. Also, update the
documentation for ABI to include these entries.

Signed-off-by: Bhaumik Bhatt <bbhatt@codeaurora.org>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
[mani: used dev_groups to manage sysfs attributes]
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 Documentation/ABI/stable/sysfs-bus-mhi | 21 +++++++++++++++
 MAINTAINERS                            |  1 +
 drivers/bus/mhi/core/init.c            | 37 ++++++++++++++++++++++++++
 3 files changed, 59 insertions(+)
 create mode 100644 Documentation/ABI/stable/sysfs-bus-mhi

diff --git a/Documentation/ABI/stable/sysfs-bus-mhi b/Documentation/ABI/stable/sysfs-bus-mhi
new file mode 100644
index 000000000000..ecfe7662f8d0
--- /dev/null
+++ b/Documentation/ABI/stable/sysfs-bus-mhi
@@ -0,0 +1,21 @@
+What:		/sys/bus/mhi/devices/.../serialnumber
+Date:		Sept 2020
+KernelVersion:	5.10
+Contact:	Bhaumik Bhatt <bbhatt@codeaurora.org>
+Description:	The file holds the serial number of the client device obtained
+		using a BHI (Boot Host Interface) register read after at least
+		one attempt to power up the device has been done. If read
+		without having the device power on at least once, the file will
+		read all 0's.
+Users:		Any userspace application or clients interested in device info.
+
+What:		/sys/bus/mhi/devices/.../oem_pk_hash
+Date:		Sept 2020
+KernelVersion:	5.10
+Contact:	Bhaumik Bhatt <bbhatt@codeaurora.org>
+Description:	The file holds the OEM PK Hash value of the endpoint device
+		obtained using a BHI (Boot Host Interface) register read after
+		at least one attempt to power up the device has been done. If
+		read without having the device power on at least once, the file
+		will read all 0's.
+Users:		Any userspace application or clients interested in device info.
diff --git a/MAINTAINERS b/MAINTAINERS
index deaafb617361..11e7be9b9163 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11323,6 +11323,7 @@ M:	Hemant Kumar <hemantk@codeaurora.org>
 L:	linux-arm-msm@vger.kernel.org
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/mani/mhi.git
+F:	Documentation/ABI/stable/sysfs-bus-mhi
 F:	Documentation/mhi/
 F:	drivers/bus/mhi/
 F:	include/linux/mhi.h
diff --git a/drivers/bus/mhi/core/init.c b/drivers/bus/mhi/core/init.c
index 61e5885a331a..a33665b7ee54 100644
--- a/drivers/bus/mhi/core/init.c
+++ b/drivers/bus/mhi/core/init.c
@@ -76,6 +76,42 @@ const char *to_mhi_pm_state_str(enum mhi_pm_state state)
 	return mhi_pm_state_str[index];
 }
 
+static ssize_t serial_number_show(struct device *dev,
+				  struct device_attribute *attr,
+				  char *buf)
+{
+	struct mhi_device *mhi_dev = to_mhi_device(dev);
+	struct mhi_controller *mhi_cntrl = mhi_dev->mhi_cntrl;
+
+	return snprintf(buf, PAGE_SIZE, "Serial Number: %u\n",
+			mhi_cntrl->serial_number);
+}
+static DEVICE_ATTR_RO(serial_number);
+
+static ssize_t oem_pk_hash_show(struct device *dev,
+				struct device_attribute *attr,
+				char *buf)
+{
+	struct mhi_device *mhi_dev = to_mhi_device(dev);
+	struct mhi_controller *mhi_cntrl = mhi_dev->mhi_cntrl;
+	int i, cnt = 0;
+
+	for (i = 0; i < ARRAY_SIZE(mhi_cntrl->oem_pk_hash); i++)
+		cnt += snprintf(buf + cnt, PAGE_SIZE - cnt,
+				"OEMPKHASH[%d]: 0x%x\n", i,
+				mhi_cntrl->oem_pk_hash[i]);
+
+	return cnt;
+}
+static DEVICE_ATTR_RO(oem_pk_hash);
+
+static struct attribute *mhi_dev_attrs[] = {
+	&dev_attr_serial_number.attr,
+	&dev_attr_oem_pk_hash.attr,
+	NULL,
+};
+ATTRIBUTE_GROUPS(mhi_dev);
+
 /* MHI protocol requires the transfer ring to be aligned with ring length */
 static int mhi_alloc_aligned_ring(struct mhi_controller *mhi_cntrl,
 				  struct mhi_ring *ring,
@@ -1301,6 +1337,7 @@ struct bus_type mhi_bus_type = {
 	.dev_name = "mhi",
 	.match = mhi_match,
 	.uevent = mhi_uevent,
+	.dev_groups = mhi_dev_groups,
 };
 
 static int __init mhi_init(void)
-- 
2.17.1

