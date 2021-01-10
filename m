Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9095F2F0A17
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jan 2021 23:51:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727256AbhAJWul (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jan 2021 17:50:41 -0500
Received: from foss.arm.com ([217.140.110.172]:39084 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727230AbhAJWuk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jan 2021 17:50:40 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3438B1477;
        Sun, 10 Jan 2021 14:49:21 -0800 (PST)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.1.197.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D9ABD3F719;
        Sun, 10 Jan 2021 14:49:19 -0800 (PST)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     coresight@lists.linaro.org, mathieu.poirier@linaro.org,
        anshuman.khandual@arm.com, mike.leach@linaro.org,
        leo.yan@linaro.org, linux-kernel@vger.kernel.org,
        jonathan.zhouwen@huawei.com, catalin.marinas@arm.com,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH v7 12/28] coresight: etm4x: Hide sysfs attributes for unavailable registers
Date:   Sun, 10 Jan 2021 22:48:34 +0000
Message-Id: <20210110224850.1880240-13-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20210110224850.1880240-1-suzuki.poulose@arm.com>
References: <20210110224850.1880240-1-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some of the management registers in ETMv4.x are not accessible
via system register instructions. Thus we must hide the sysfs
files exposing them to the userspace, to prevent system crashes.

This patch adds an is_visible() routine to control the visibility
at runtime for the registers that may not be accessed.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Mike Leach <mike.leach@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
New patch in v7
---
 .../coresight/coresight-etm4x-sysfs.c         | 51 +++++++++++++++++++
 drivers/hwtracing/coresight/coresight-etm4x.h |  6 +++
 2 files changed, 57 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
index ddbfeb24fc3f..e8fdda45ffca 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
@@ -2370,6 +2370,56 @@ static ssize_t coresight_etm4x_reg_show(struct device *dev,
 	return scnprintf(buf, PAGE_SIZE, "0x%x\n", val);
 }
 
+static inline bool
+etm4x_register_implemented(struct etmv4_drvdata *drvdata, u32 offset)
+{
+	switch (offset) {
+	ETM4x_SYSREG_LIST_CASES
+		/*
+		 * Registers accessible via system instructions are always
+		 * implemented.
+		 */
+		return true;
+	ETM4x_MMAP_LIST_CASES
+		/*
+		 * Registers accessible only via memory-mapped registers
+		 * must not be accessed via system instructions.
+		 * We cannot access the drvdata->csdev here, as this
+		 * function is called during the device creation, via
+		 * coresight_register() and the csdev is not initialized
+		 * until that is done. So rely on the drvdata->base to
+		 * detect if we have a memory mapped access.
+		 */
+		return !!drvdata->base;
+	}
+
+	return false;
+}
+
+/*
+ * Hide the ETM4x registers that may not be available on the
+ * hardware.
+ * There are certain management registers unavailable via system
+ * instructions. Make those sysfs attributes hidden on such
+ * systems.
+ */
+static umode_t
+coresight_etm4x_attr_reg_implemented(struct kobject *kobj,
+				     struct attribute *attr, int unused)
+{
+	struct device *dev = kobj_to_dev(kobj);
+	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	struct device_attribute *d_attr;
+	u32 offset;
+
+	d_attr = container_of(attr, struct device_attribute, attr);
+	offset = coresight_etm4x_attr_to_offset(d_attr);
+
+	if (etm4x_register_implemented(drvdata, offset))
+		return attr->mode;
+	return 0;
+}
+
 #define coresight_etm4x_reg(name, offset)				\
 	&((struct dev_ext_attribute[]) {				\
 	   {								\
@@ -2417,6 +2467,7 @@ static const struct attribute_group coresight_etmv4_group = {
 };
 
 static const struct attribute_group coresight_etmv4_mgmt_group = {
+	.is_visible = coresight_etm4x_attr_reg_implemented,
 	.attrs = coresight_etmv4_mgmt_attrs,
 	.name = "mgmt",
 };
diff --git a/drivers/hwtracing/coresight/coresight-etm4x.h b/drivers/hwtracing/coresight/coresight-etm4x.h
index 24ba0da5b096..193d2819afa7 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x.h
+++ b/drivers/hwtracing/coresight/coresight-etm4x.h
@@ -157,6 +157,9 @@
 #define CASE_WRITE(val, x)					\
 	case (x): { write_etm4x_sysreg_const_offset((val), (x)); break; }
 
+#define CASE_NOP(__unused, x)					\
+	case (x):	/* fall through */
+
 /* List of registers accessible via System instructions */
 #define ETM_SYSREG_LIST(op, val)		\
 	CASE_##op((val), TRCPRGCTLR)		\
@@ -369,6 +372,9 @@
 #define ETM4x_READ_SYSREG_CASES(res)	ETM_SYSREG_LIST(READ, (res))
 #define ETM4x_WRITE_SYSREG_CASES(val)	ETM_SYSREG_LIST(WRITE, (val))
 
+#define ETM4x_SYSREG_LIST_CASES		ETM_SYSREG_LIST(NOP, __unused)
+#define ETM4x_MMAP_LIST_CASES		ETM_MMAP_LIST(NOP, __unused)
+
 #define read_etm4x_sysreg_offset(offset, _64bit)				\
 	({									\
 		u64 __val;							\
-- 
2.24.1

