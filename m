Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F4232D322A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 19:29:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731079AbgLHS2D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 13:28:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730959AbgLHS2D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 13:28:03 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7A7EC0617A6
        for <linux-kernel@vger.kernel.org>; Tue,  8 Dec 2020 10:26:56 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id n7so12942764pgg.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Dec 2020 10:26:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZF79fikCUTE+54UQQVhITEh2tepwRR55L4YQyon8fEw=;
        b=uDHK+R1RLmIeyTQx0uDraM4X280/2CHZb2uZGvGcrAuIKNNuLRhDes7U1bj02oc2kT
         5I0w9bwNE8x+EjI9JTUSQ5BSsnFAS87Fw0I6tmF3lRkJzjsQDn19JLjl4q7Y92BgG0LU
         ocKpO8E3/juzlCBTrgid5wE0EIkbY4ruZXKSV0OZoedoSbu+a7b/bWrjiO8zZQdSoGoq
         jQO8IhhtPRsxgozitPqCWJDnpzAtkMA2543ExnGR9FhlGeoXPmswnEwhuYXa7EFWkP8C
         jblnCCj45Vv7ONuaMuBm3rhsFyloDRppNJb4speGTwfYRlWlXE9tvMJ1YwBbkn3qyuud
         yAkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZF79fikCUTE+54UQQVhITEh2tepwRR55L4YQyon8fEw=;
        b=QjCFlYlfA/9JJxczakZTFIb6OGdmBq+zDuOe9VigsdK9D1O3ynP+Rs9Nj0q5VIaL8E
         pY29QvtbBMHooJ3auzxgU6N7W+pZzP20MPJps8ci4zlHTc1wJdKJNIw6J7CsznBVdvA2
         kLVzWTWpcAdFw52jTpORKmHijxzTEntYQlzaCG7cdmuD9sRUvnS2++O/U658cStgO17p
         blm1pJ30htLQ29PzX2FWCmIQXoF+Oh9UCaTON+tXYsjc9yVpiOhGJvPDXhmIsWT9j4vI
         0YLyrhtK8Otrs6YYExxRTWbl2+/X+3T9KlV8AJqpn2nhaG6uvwdhTCGjoEGjK1+yqIrm
         J1nw==
X-Gm-Message-State: AOAM533EMgsi8cQvMO5pL22wwa1zTe4OkYgeIFB07dkrihiEkVFm8XlH
        RZmtJlhXT9ahLlTFaQyQPkvWYHgZEqg9mBOf
X-Google-Smtp-Source: ABdhPJw0lNVtRzAVVby23k7+IU+nhIFwiJPzM6boaYZTTbLwN/Lj81TYXycG2CHXW28+1Cz/VZA++g==
X-Received: by 2002:a62:62c7:0:b029:18b:c7ae:934a with SMTP id w190-20020a6262c70000b029018bc7ae934amr21302318pfb.18.1607452016407;
        Tue, 08 Dec 2020 10:26:56 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id nm6sm3966801pjb.25.2020.12.08.10.26.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 10:26:55 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] coresight: etm4x: Modify core-commit to avoid HiSilicon ETM overflow
Date:   Tue,  8 Dec 2020 11:26:51 -0700
Message-Id: <20201208182651.1597945-4-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201208182651.1597945-1-mathieu.poirier@linaro.org>
References: <20201208182651.1597945-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Qi Liu <liuqi115@huawei.com>

The ETM device can't keep up with the core pipeline when cpu core
is at full speed. This may cause overflow within core and its ETM.
This is a common phenomenon on ETM devices.

On HiSilicon Hip08 platform, a specific feature is added to set
core pipeline. So commit rate can be reduced manually to avoid ETM
overflow.

Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Qi Liu <liuqi115@huawei.com>
[Modified changelog title and Kconfig description]
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/Kconfig           |  8 ++
 .../coresight/coresight-etm4x-core.c          | 98 +++++++++++++++++++
 drivers/hwtracing/coresight/coresight-etm4x.h |  8 ++
 3 files changed, 114 insertions(+)

diff --git a/drivers/hwtracing/coresight/Kconfig b/drivers/hwtracing/coresight/Kconfig
index c1198245461d..7b44ba22cbe1 100644
--- a/drivers/hwtracing/coresight/Kconfig
+++ b/drivers/hwtracing/coresight/Kconfig
@@ -110,6 +110,14 @@ config CORESIGHT_SOURCE_ETM4X
 	  To compile this driver as a module, choose M here: the
 	  module will be called coresight-etm4x.
 
+config ETM4X_IMPDEF_FEATURE
+	bool "Control implementation defined overflow support in ETM 4.x driver"
+	depends on CORESIGHT_SOURCE_ETM4X
+	help
+	  This control provides implementation define control for CoreSight
+	  ETM 4.x tracer module that can't reduce commit rate automatically.
+	  This avoids overflow between the ETM tracer module and the cpu core.
+
 config CORESIGHT_STM
 	tristate "CoreSight System Trace Macrocell driver"
 	depends on (ARM && !(CPU_32v3 || CPU_32v4 || CPU_32v4T)) || ARM64
diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
index 3ad5c2a01033..b20b6ff17cf6 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
@@ -3,6 +3,7 @@
  * Copyright (c) 2014, The Linux Foundation. All rights reserved.
  */
 
+#include <linux/bitops.h>
 #include <linux/kernel.h>
 #include <linux/moduleparam.h>
 #include <linux/init.h>
@@ -28,7 +29,9 @@
 #include <linux/perf_event.h>
 #include <linux/pm_runtime.h>
 #include <linux/property.h>
+
 #include <asm/sections.h>
+#include <asm/sysreg.h>
 #include <asm/local.h>
 #include <asm/virt.h>
 
@@ -103,6 +106,97 @@ struct etm4_enable_arg {
 	int rc;
 };
 
+#ifdef CONFIG_ETM4X_IMPDEF_FEATURE
+
+#define HISI_HIP08_AMBA_ID		0x000b6d01
+#define ETM4_AMBA_MASK			0xfffff
+#define HISI_HIP08_CORE_COMMIT_MASK	0x3000
+#define HISI_HIP08_CORE_COMMIT_SHIFT	12
+#define HISI_HIP08_CORE_COMMIT_FULL	0b00
+#define HISI_HIP08_CORE_COMMIT_LVL_1	0b01
+#define HISI_HIP08_CORE_COMMIT_REG	sys_reg(3, 1, 15, 2, 5)
+
+struct etm4_arch_features {
+	void (*arch_callback)(bool enable);
+};
+
+static bool etm4_hisi_match_pid(unsigned int id)
+{
+	return (id & ETM4_AMBA_MASK) == HISI_HIP08_AMBA_ID;
+}
+
+static void etm4_hisi_config_core_commit(bool enable)
+{
+	u8 commit = enable ? HISI_HIP08_CORE_COMMIT_LVL_1 :
+		    HISI_HIP08_CORE_COMMIT_FULL;
+	u64 val;
+
+	/*
+	 * bit 12 and 13 of HISI_HIP08_CORE_COMMIT_REG are used together
+	 * to set core-commit, 2'b00 means cpu is at full speed, 2'b01,
+	 * 2'b10, 2'b11 mean reduce pipeline speed, and 2'b01 means level-1
+	 * speed(minimun value). So bit 12 and 13 should be cleared together.
+	 */
+	val = read_sysreg_s(HISI_HIP08_CORE_COMMIT_REG);
+	val &= ~HISI_HIP08_CORE_COMMIT_MASK;
+	val |= commit << HISI_HIP08_CORE_COMMIT_SHIFT;
+	write_sysreg_s(val, HISI_HIP08_CORE_COMMIT_REG);
+}
+
+static struct etm4_arch_features etm4_features[] = {
+	[ETM4_IMPDEF_HISI_CORE_COMMIT] = {
+		.arch_callback = etm4_hisi_config_core_commit,
+	},
+	{},
+};
+
+static void etm4_enable_arch_specific(struct etmv4_drvdata *drvdata)
+{
+	struct etm4_arch_features *ftr;
+	int bit;
+
+	for_each_set_bit(bit, drvdata->arch_features, ETM4_IMPDEF_FEATURE_MAX) {
+		ftr = &etm4_features[bit];
+
+		if (ftr->arch_callback)
+			ftr->arch_callback(true);
+	}
+}
+
+static void etm4_disable_arch_specific(struct etmv4_drvdata *drvdata)
+{
+	struct etm4_arch_features *ftr;
+	int bit;
+
+	for_each_set_bit(bit, drvdata->arch_features, ETM4_IMPDEF_FEATURE_MAX) {
+		ftr = &etm4_features[bit];
+
+		if (ftr->arch_callback)
+			ftr->arch_callback(false);
+	}
+}
+
+static void etm4_check_arch_features(struct etmv4_drvdata *drvdata,
+				      unsigned int id)
+{
+	if (etm4_hisi_match_pid(id))
+		set_bit(ETM4_IMPDEF_HISI_CORE_COMMIT, drvdata->arch_features);
+}
+#else
+static void etm4_enable_arch_specific(struct etmv4_drvdata *drvdata)
+{
+}
+
+static void etm4_disable_arch_specific(struct etmv4_drvdata *drvdata)
+{
+}
+
+static void etm4_check_arch_features(struct etmv4_drvdata *drvdata,
+				     unsigned int id)
+{
+}
+#endif /* CONFIG_ETM4X_IMPDEF_FEATURE */
+
 static int etm4_enable_hw(struct etmv4_drvdata *drvdata)
 {
 	int i, rc;
@@ -110,6 +204,7 @@ static int etm4_enable_hw(struct etmv4_drvdata *drvdata)
 	struct device *etm_dev = &drvdata->csdev->dev;
 
 	CS_UNLOCK(drvdata->base);
+	etm4_enable_arch_specific(drvdata);
 
 	etm4_os_unlock(drvdata);
 
@@ -479,6 +574,7 @@ static void etm4_disable_hw(void *info)
 	int i;
 
 	CS_UNLOCK(drvdata->base);
+	etm4_disable_arch_specific(drvdata);
 
 	if (!drvdata->skip_power_up) {
 		/* power can be removed from the trace unit now */
@@ -1563,6 +1659,8 @@ static int etm4_probe(struct amba_device *adev, const struct amba_id *id)
 		drvdata->boot_enable = true;
 	}
 
+	etm4_check_arch_features(drvdata, id->id);
+
 	return 0;
 }
 
diff --git a/drivers/hwtracing/coresight/coresight-etm4x.h b/drivers/hwtracing/coresight/coresight-etm4x.h
index eefc7371c6c4..3dd3e0633328 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x.h
+++ b/drivers/hwtracing/coresight/coresight-etm4x.h
@@ -8,6 +8,7 @@
 
 #include <asm/local.h>
 #include <linux/spinlock.h>
+#include <linux/types.h>
 #include "coresight-priv.h"
 
 /*
@@ -203,6 +204,11 @@
 /* Interpretation of resource numbers change at ETM v4.3 architecture */
 #define ETM4X_ARCH_4V3	0x43
 
+enum etm_impdef_type {
+	ETM4_IMPDEF_HISI_CORE_COMMIT,
+	ETM4_IMPDEF_FEATURE_MAX,
+};
+
 /**
  * struct etmv4_config - configuration information related to an ETMv4
  * @mode:	Controls various modes supported by this ETM.
@@ -415,6 +421,7 @@ struct etmv4_save_state {
  * @state_needs_restore: True when there is context to restore after PM exit
  * @skip_power_up: Indicates if an implementation can skip powering up
  *		   the trace unit.
+ * @arch_features: Bitmap of arch features of etmv4 devices.
  */
 struct etmv4_drvdata {
 	void __iomem			*base;
@@ -463,6 +470,7 @@ struct etmv4_drvdata {
 	struct etmv4_save_state		*save_state;
 	bool				state_needs_restore;
 	bool				skip_power_up;
+	DECLARE_BITMAP(arch_features, ETM4_IMPDEF_FEATURE_MAX);
 };
 
 /* Address comparator access types */
-- 
2.25.1

