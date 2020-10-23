Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85A54296CC4
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 12:24:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S462163AbgJWKYp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 06:24:45 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:15767 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S375931AbgJWKYo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 06:24:44 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id B89FF6F81F2CAD284A06;
        Fri, 23 Oct 2020 18:24:42 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.487.0; Fri, 23 Oct 2020 18:24:36 +0800
From:   Qi Liu <liuqi115@huawei.com>
To:     <mathieu.poirier@linaro.org>, <suzuki.poulose@arm.com>,
        <Al.Grant@arm.com>, <mike.leach@linaro.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linuxarm@huawei.com>
Subject: [PATCH v3] coresight: etm4x: Modify core-commit of cpu to avoid the overflow of HiSilicon ETM
Date:   Fri, 23 Oct 2020 18:23:15 +0800
Message-ID: <1603448595-22615-1-git-send-email-liuqi115@huawei.com>
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
Change since v2:
- remove some unused variable.

 drivers/hwtracing/coresight/Kconfig                | 18 ++++++++
 drivers/hwtracing/coresight/coresight-etm4x-core.c | 50 ++++++++++++++++++++++
 2 files changed, 68 insertions(+)

diff --git a/drivers/hwtracing/coresight/Kconfig b/drivers/hwtracing/coresight/Kconfig
index c119824..9665d70 100644
--- a/drivers/hwtracing/coresight/Kconfig
+++ b/drivers/hwtracing/coresight/Kconfig
@@ -110,6 +110,24 @@ config CORESIGHT_SOURCE_ETM4X
 	  To compile this driver as a module, choose M here: the
 	  module will be called coresight-etm4x.

+config ETM4X_IMPDEF_FEATURE
+	bool "Control overflow impdef support in CoreSight ETM 4.x driver "
+	depends on CORESIGHT_SOURCE_ETM4X
+	help
+	  This control provides overflow implement define for CoreSight
+	  ETM 4.x tracer module which could not reduce commit race
+	  automatically, and could avoid overflow within ETM tracer module
+	  and its cpu core.
+
+config ETM4X_IMPDEF_HISILICON
+	bool "Control overflow impdef support in HiSilicon ETM 4.x driver "
+	depends on ETM4X_IMPDEF_FEATURE
+	help
+	  This control provides overflow implement define for HiSilicon
+	  ETM 4.x tracer module of Hip08 platform. Overflow within ETM
+	  tracer module and its cpu core can be avoided by reducing core
+	  commit manually.
+
 config CORESIGHT_STM
 	tristate "CoreSight System Trace Macrocell driver"
 	depends on (ARM && !(CPU_32v3 || CPU_32v4 || CPU_32v4T)) || ARM64
diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
index abd706b..35f4333 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
@@ -103,12 +103,61 @@ struct etm4_enable_arg {
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
+static void etm4_enable_arch_specific(void)
+{
+	/*
+	 * If ETM device is HiSilicon ETM device, reduce the
+	 * core-commit to avoid ETM overflow.
+	 */
+	etm4_hisi_config_core_commit(1);
+}
+
+static void etm4_disable_arch_specific(void)
+{
+	/*
+	 * If ETM device is HiSilicon ETM device, resume the
+	 * core-commit after ETM trace is complete.
+	 */
+	etm4_hisi_config_core_commit(0);
+}
+#else
+static void etm4_enable_arch_specific(void)
+{
+}
+
+static void etm4_disable_arch_specific(void)
+{
+}
+#endif /* CONFIG_ETM4X_IMPDEF_FEATURE */
+
 static int etm4_enable_hw(struct etmv4_drvdata *drvdata)
 {
 	int i, rc;
 	struct etmv4_config *config = &drvdata->config;
 	struct device *etm_dev = &drvdata->csdev->dev;

+	etm4_enable_arch_specific();
 	CS_UNLOCK(drvdata->base);

 	etm4_os_unlock(drvdata);
@@ -475,6 +524,7 @@ static void etm4_disable_hw(void *info)
 	struct device *etm_dev = &drvdata->csdev->dev;
 	int i;

+	etm4_disable_arch_specific();
 	CS_UNLOCK(drvdata->base);

 	if (!drvdata->skip_power_up) {
--
2.8.1

