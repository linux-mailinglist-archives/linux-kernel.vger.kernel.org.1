Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 569C0271F4E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 11:52:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726471AbgIUJwH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 05:52:07 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:13745 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726395AbgIUJwG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 05:52:06 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id CDC19F919099F431C62D;
        Mon, 21 Sep 2020 17:52:01 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.487.0; Mon, 21 Sep 2020 17:51:54 +0800
From:   Qi Liu <liuqi115@huawei.com>
To:     <mathieu.poirier@linaro.org>, <suzuki.poulose@arm.com>,
        <Al.Grant@arm.com>, <mike.leach@linaro.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>
Subject: [PATCH v2] coresight: etm4x: Modify core-commit of cpu to avoid the overflow of HiSilicon ETM
Date:   Mon, 21 Sep 2020 17:50:42 +0800
Message-ID: <1600681842-9105-1-git-send-email-liuqi115@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ETM device can't keep up with the core pipeline when cpu core
is at full speed. This may cause overflow within core and its ETM.
This is a common phenomenon on ETM devices.

On HiSilicon Hip08 platform, a specific feature is added to set
core pipeline. So commit rate can be reduced manually to avoid ETM
overflow.

Signed-off-by: Qi Liu <liuqi115@huawei.com>
---
Change since v1:
- add CONFIG_ETM4X_IMPDEF_FEATURE and CONFIG_ETM4X_IMPDEF_HISILICON
  to keep specific feature off platforms which don't use it.

 drivers/hwtracing/coresight/Kconfig           | 13 ++++++
 drivers/hwtracing/coresight/coresight-etm4x.c | 60 +++++++++++++++++++++++++++
 2 files changed, 73 insertions(+)

diff --git a/drivers/hwtracing/coresight/Kconfig b/drivers/hwtracing/coresight/Kconfig
index 02dbb5c..362dadf 100644
--- a/drivers/hwtracing/coresight/Kconfig
+++ b/drivers/hwtracing/coresight/Kconfig
@@ -85,6 +85,19 @@ config CORESIGHT_SOURCE_ETM4X
 	  for instruction level tracing. Depending on the implemented version
 	  data tracing may also be available.

+config ETM4X_IMPDEF_FEATURE
+	bool "Control overflow impdef support in CoreSight ETM 4.x driver "
+	depends on CORESIGHT_SOURCE_ETM4X
+	help
+	  This control provides overflow impdef for CoreSight ETM 4.x driver
+	  which can not reduce commit race automatically.
+
+config ETM4X_IMPDEF_HISILICON
+	bool "Control overflow impdef support in HiSilicon ETM 4.x driver "
+	depends on ETM4X_IMPDEF_FEATURE
+	help
+	  This control provides overflow impdef for HiSilicon ETM 4.x driver.
+
 config CORESIGHT_STM
 	bool "CoreSight System Trace Macrocell driver"
 	depends on (ARM && !(CPU_32v3 || CPU_32v4 || CPU_32v4T)) || ARM64
diff --git a/drivers/hwtracing/coresight/coresight-etm4x.c b/drivers/hwtracing/coresight/coresight-etm4x.c
index f5ab13a..1a7a6c9 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x.c
@@ -103,12 +103,71 @@ struct etm4_enable_arg {
 	int rc;
 };

+#ifdef CONFIG_ETM4X_IMPDEF_FEATURE
+
+#ifdef CONFIG_ETM4X_IMPDEF_HISILICON
+
+#define HISI_HIP08_CORE_COMMIT_CLEAR	0x3000
+#define HISI_HIP08_CORE_COMMIT_SHIFT	12
+static void etm4_hisi_config_core_commit(int flag)
+{
+	u64 val;
+
+	asm volatile("mrs %0,s3_1_c15_c2_5" : "=r"(val));
+	val &= ~HISI_HIP08_CORE_COMMIT_CLEAR;
+	val |= flag << HISI_HIP08_CORE_COMMIT_SHIFT;
+	asm volatile("msr s3_1_c15_c2_5,%0" : : "r"(val));
+}
+#else
+static void etm4_hisi_config_core_commit(int flag)
+{
+}
+#endif /* CONFIG_ETM4X_IMPDEF_HISILICON */
+
+static void etm4_enable_arch_specific(struct etmv4_drvdata *drvdata)
+{
+	struct device *dev = drvdata->csdev->dev.parent;
+	struct amba_device *adev;
+
+	adev = container_of(dev, struct amba_device, dev);
+
+	/*
+	 * If ETM device is HiSilicon ETM device, reduce the
+	 * core-commit to avoid ETM overflow.
+	 */
+	etm4_hisi_config_core_commit(1);
+}
+
+static void etm4_disable_arch_specific(struct etmv4_drvdata *drvdata)
+{
+	struct device *dev = drvdata->csdev->dev.parent;
+	struct amba_device *adev;
+
+	adev = container_of(dev, struct amba_device, dev);
+
+	/*
+	 * If ETM device is HiSilicon ETM device, resume the
+	 * core-commit after ETM trace is complete.
+	 */
+	etm4_hisi_config_core_commit(0);
+}
+#else
+static void etm4_enable_arch_specific(struct etmv4_drvdata *drvdata)
+{
+}
+
+static void etm4_disable_arch_specific(struct etmv4_drvdata *drvdata)
+{
+}
+#endif/* CONFIG_ETM4X_IMPDEF_FEATURE */
+
 static int etm4_enable_hw(struct etmv4_drvdata *drvdata)
 {
 	int i, rc;
 	struct etmv4_config *config = &drvdata->config;
 	struct device *etm_dev = &drvdata->csdev->dev;

+	etm4_enable_arch_specific(drvdata);
 	CS_UNLOCK(drvdata->base);

 	etm4_os_unlock(drvdata);
@@ -475,6 +534,7 @@ static void etm4_disable_hw(void *info)
 	struct device *etm_dev = &drvdata->csdev->dev;
 	int i;

+	etm4_disable_arch_specific(drvdata);
 	CS_UNLOCK(drvdata->base);

 	if (!drvdata->skip_power_up) {
--
2.8.1

