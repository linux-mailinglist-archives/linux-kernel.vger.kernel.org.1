Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 921262D7EBE
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 19:52:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437039AbgLKSu0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 13:50:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389813AbgLKStE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 13:49:04 -0500
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D74CC0617B0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Dec 2020 10:48:34 -0800 (PST)
Received: by mail-lj1-x244.google.com with SMTP id s11so12067944ljp.4
        for <linux-kernel@vger.kernel.org>; Fri, 11 Dec 2020 10:48:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OeQblmEHmyU6ck7RbL05kxW1lADVlZG0oOc0x1IzMi8=;
        b=VnMB+AKlZB60TxwFqAfhWZM36t9koknPXjgiZAlqim5uZDFdayVyxM/n8jJgSCEcMK
         UCe5WR7aDt8Tmezde9EzGrbI2CIWD/uNVmZ7+TVoQWq8OMNuwscPQpJkPrVHlC8naDsv
         8ppjsxEP7AkbFt8SdGPbL1Xo/oIQCw2eyCjrsMyWQ3gDxGqlzn2P3NHDdFBWazk6wnWp
         00G4FfNRt1R8uq+dSAKocGIkWgg45vKN9h72sq4oG28pd4kw6hFar4owBmLxxImuCOmD
         NgbPRdXF2Y4h2Ppia8FgnmJ/xU0rtC1xP7u+mJIoJvC+Sw0YMAUzhfrOQxzZV47Ab1Oi
         J9Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OeQblmEHmyU6ck7RbL05kxW1lADVlZG0oOc0x1IzMi8=;
        b=odF0I9EMslPRImkEvgCtOTAcf6yYh1W5awNx/4nbazd6/0q4k164uNvobpC+9jE0aZ
         bvlCNWm8csb92Ok+rNvcw/45aFGDnpyPpSbvZpcyBvs2vSfz6yMuHyjSNMigN66S+Vl4
         NWH1FRF9F5Rcr4nEcd6/ngUAlL/V4J75KEs4zllZ3fxYTtZTKjTjnP199Z+7g/A5Zw/F
         UQP/DzYP4PK4dQlZXgdFrGW1MqFzSrHULlF2N2h8/KXhp+1eSy0ghST2d7rM17xQl6Qg
         eDLhC4nebJROsID3tiyAvIfdYpBJYDasFtDOV7BErIq5+jlv1FNsqmRuBEgcuLFpz3nm
         4RPQ==
X-Gm-Message-State: AOAM533JiJIUN+IDUbVQVZtai7Y+g0n3PGt0zuVN80GOnknNRlm34DQ4
        U+lxTLRvb7DFJc068/MAQbTN5w==
X-Google-Smtp-Source: ABdhPJyUlAP20ov/n9Zw1QH84wSmzsvKhgW4+J7VMAAydn5ABB+Q5iJHJRce3uuwiXxJ3Y/gxV3ZJg==
X-Received: by 2002:a2e:3312:: with SMTP id d18mr4645763ljc.284.1607712512029;
        Fri, 11 Dec 2020 10:48:32 -0800 (PST)
Received: from gilgamesh.semihalf.com (193-106-246-138.noc.fibertech.net.pl. [193.106.246.138])
        by smtp.gmail.com with ESMTPSA id b12sm903316lfb.139.2020.12.11.10.48.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Dec 2020 10:48:31 -0800 (PST)
From:   Grzegorz Jaszczyk <grzegorz.jaszczyk@linaro.org>
To:     ssantosh@kernel.org, s-anna@ti.com
Cc:     grzegorz.jaszczyk@linaro.org, santosh.shilimkar@oracle.com,
        lee.jones@linaro.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        praneeth@ti.com, tony@atomide.com,
        linux-remoteproc@vger.kernel.org, mathieu.poirier@linaro.org
Subject: [PATCH 2/6] soc: ti: pruss: Add pruss_{request,release}_mem_region() API
Date:   Fri, 11 Dec 2020 19:48:07 +0100
Message-Id: <20201211184811.6490-3-grzegorz.jaszczyk@linaro.org>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20201211184811.6490-1-grzegorz.jaszczyk@linaro.org>
References: <20201211184811.6490-1-grzegorz.jaszczyk@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Andrew F. Davis" <afd@ti.com>

Add two new API - pruss_request_mem_region() & pruss_release_mem_region(),
to the PRUSS platform driver to allow client drivers to acquire and release
the common memory resources present within a PRU-ICSS subsystem. This
allows the client drivers to directly manipulate the respective memories,
as per their design contract with the associated firmware.

Co-developed-by: Suman Anna <s-anna@ti.com>
Signed-off-by: Suman Anna <s-anna@ti.com>
Signed-off-by: Andrew F. Davis <afd@ti.com>
Co-developed-by: Grzegorz Jaszczyk <grzegorz.jaszczyk@linaro.org>
Signed-off-by: Grzegorz Jaszczyk <grzegorz.jaszczyk@linaro.org>
---
 drivers/soc/ti/pruss.c       | 77 ++++++++++++++++++++++++++++++++++++
 include/linux/pruss.h        | 39 ++++++++++++++++++
 include/linux/pruss_driver.h | 27 +++----------
 3 files changed, 121 insertions(+), 22 deletions(-)

diff --git a/drivers/soc/ti/pruss.c b/drivers/soc/ti/pruss.c
index 28eb6415cb95..7569a7fc94f6 100644
--- a/drivers/soc/ti/pruss.c
+++ b/drivers/soc/ti/pruss.c
@@ -88,6 +88,82 @@ void pruss_put(struct pruss *pruss)
 }
 EXPORT_SYMBOL_GPL(pruss_put);
 
+/**
+ * pruss_request_mem_region() - request a memory resource
+ * @pruss: the pruss instance
+ * @mem_id: the memory resource id
+ * @region: pointer to memory region structure to be filled in
+ *
+ * This function allows a client driver to request a memory resource,
+ * and if successful, will let the client driver own the particular
+ * memory region until released using the pruss_release_mem_region()
+ * API.
+ *
+ * Return: 0 if requested memory region is available (in such case pointer to
+ * memory region is returned via @region), an error otherwise
+ */
+int pruss_request_mem_region(struct pruss *pruss, enum pruss_mem mem_id,
+			     struct pruss_mem_region *region)
+{
+	if (!pruss || !region || mem_id >= PRUSS_MEM_MAX)
+		return -EINVAL;
+
+	mutex_lock(&pruss->lock);
+
+	if (pruss->mem_in_use[mem_id]) {
+		mutex_unlock(&pruss->lock);
+		return -EBUSY;
+	}
+
+	*region = pruss->mem_regions[mem_id];
+	pruss->mem_in_use[mem_id] = region;
+
+	mutex_unlock(&pruss->lock);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(pruss_request_mem_region);
+
+/**
+ * pruss_release_mem_region() - release a memory resource
+ * @pruss: the pruss instance
+ * @region: the memory region to release
+ *
+ * This function is the complimentary function to
+ * pruss_request_mem_region(), and allows the client drivers to
+ * release back a memory resource.
+ *
+ * Return: 0 on success, an error code otherwise
+ */
+int pruss_release_mem_region(struct pruss *pruss,
+			     struct pruss_mem_region *region)
+{
+	int id;
+
+	if (!pruss || !region)
+		return -EINVAL;
+
+	mutex_lock(&pruss->lock);
+
+	/* find out the memory region being released */
+	for (id = 0; id < PRUSS_MEM_MAX; id++) {
+		if (pruss->mem_in_use[id] == region)
+			break;
+	}
+
+	if (id == PRUSS_MEM_MAX) {
+		mutex_unlock(&pruss->lock);
+		return -EINVAL;
+	}
+
+	pruss->mem_in_use[id] = NULL;
+
+	mutex_unlock(&pruss->lock);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(pruss_release_mem_region);
+
 static void pruss_of_free_clk_provider(void *data)
 {
 	struct device_node *clk_mux_np = data;
@@ -243,6 +319,7 @@ static int pruss_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	pruss->dev = dev;
+	mutex_init(&pruss->lock);
 
 	child = of_get_child_by_name(np, "memories");
 	if (!child) {
diff --git a/include/linux/pruss.h b/include/linux/pruss.h
index 403951910515..ec5b6609b5e5 100644
--- a/include/linux/pruss.h
+++ b/include/linux/pruss.h
@@ -39,6 +39,28 @@ enum pru_ctable_idx {
 	PRU_C31,
 };
 
+/*
+ * enum pruss_mem - PRUSS memory range identifiers
+ */
+enum pruss_mem {
+	PRUSS_MEM_DRAM0 = 0,
+	PRUSS_MEM_DRAM1,
+	PRUSS_MEM_SHRD_RAM2,
+	PRUSS_MEM_MAX,
+};
+
+/**
+ * struct pruss_mem_region - PRUSS memory region structure
+ * @va: kernel virtual address of the PRUSS memory region
+ * @pa: physical (bus) address of the PRUSS memory region
+ * @size: size of the PRUSS memory region
+ */
+struct pruss_mem_region {
+	void __iomem *va;
+	phys_addr_t pa;
+	size_t size;
+};
+
 struct device_node;
 struct rproc;
 struct pruss;
@@ -47,6 +69,10 @@ struct pruss;
 
 struct pruss *pruss_get(struct rproc *rproc);
 void pruss_put(struct pruss *pruss);
+int pruss_request_mem_region(struct pruss *pruss, enum pruss_mem mem_id,
+			     struct pruss_mem_region *region);
+int pruss_release_mem_region(struct pruss *pruss,
+			     struct pruss_mem_region *region);
 
 #else
 
@@ -57,6 +83,19 @@ static inline struct pruss *pruss_get(struct rproc *rproc)
 
 static inline void pruss_put(struct pruss *pruss) { }
 
+static inline int pruss_request_mem_region(struct pruss *pruss,
+					   enum pruss_mem mem_id,
+					   struct pruss_mem_region *region)
+{
+	return -ENOTSUPP;
+}
+
+static inline int pruss_release_mem_region(struct pruss *pruss,
+					   struct pruss_mem_region *region)
+{
+	return -ENOTSUPP;
+}
+
 #endif /* CONFIG_TI_PRUSS */
 
 #if IS_ENABLED(CONFIG_PRU_REMOTEPROC)
diff --git a/include/linux/pruss_driver.h b/include/linux/pruss_driver.h
index d054d2179d82..e2d5477225c6 100644
--- a/include/linux/pruss_driver.h
+++ b/include/linux/pruss_driver.h
@@ -9,37 +9,18 @@
 #ifndef _PRUSS_DRIVER_H_
 #define _PRUSS_DRIVER_H_
 
+#include <linux/mutex.h>
 #include <linux/pruss.h>
 #include <linux/types.h>
 
-/*
- * enum pruss_mem - PRUSS memory range identifiers
- */
-enum pruss_mem {
-	PRUSS_MEM_DRAM0 = 0,
-	PRUSS_MEM_DRAM1,
-	PRUSS_MEM_SHRD_RAM2,
-	PRUSS_MEM_MAX,
-};
-
-/**
- * struct pruss_mem_region - PRUSS memory region structure
- * @va: kernel virtual address of the PRUSS memory region
- * @pa: physical (bus) address of the PRUSS memory region
- * @size: size of the PRUSS memory region
- */
-struct pruss_mem_region {
-	void __iomem *va;
-	phys_addr_t pa;
-	size_t size;
-};
-
 /**
  * struct pruss - PRUSS parent structure
  * @dev: pruss device pointer
  * @cfg_base: base iomap for CFG region
  * @cfg_regmap: regmap for config region
  * @mem_regions: data for each of the PRUSS memory regions
+ * @mem_in_use: to indicate if memory resource is in use
+ * @lock: mutex to serialize access to resources
  * @core_clk_mux: clk handle for PRUSS CORE_CLK_MUX
  * @iep_clk_mux: clk handle for PRUSS IEP_CLK_MUX
  */
@@ -48,6 +29,8 @@ struct pruss {
 	void __iomem *cfg_base;
 	struct regmap *cfg_regmap;
 	struct pruss_mem_region mem_regions[PRUSS_MEM_MAX];
+	struct pruss_mem_region *mem_in_use[PRUSS_MEM_MAX];
+	struct mutex lock; /* PRU resource lock */
 	struct clk *core_clk_mux;
 	struct clk *iep_clk_mux;
 };
-- 
2.29.0

