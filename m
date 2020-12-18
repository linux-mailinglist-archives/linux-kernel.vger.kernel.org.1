Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA5282DE81F
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 18:35:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732684AbgLRReF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Dec 2020 12:34:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732652AbgLRReD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Dec 2020 12:34:03 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DA78C0619D7
        for <linux-kernel@vger.kernel.org>; Fri, 18 Dec 2020 09:32:37 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id e2so1748856pgi.5
        for <linux-kernel@vger.kernel.org>; Fri, 18 Dec 2020 09:32:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=g1R9Bq/TkbA5ZJxMb+U3jIOApLTRzPyrB4NxcI5os7I=;
        b=t5wRCamddvBbP1gidIz9qVvy3YaRueHBIcG8WR00lGkn2knegTeSlgbq5QlaM7VMJl
         LoOcQJ9rLi7XcIKluTKzOBWvB1hklOY/sFX/Q3J/uw7FWs5W8/Pl0pQ1IW9/fTcqCEln
         shYK9ZwSWbc64d1k1i9JO20A3s6BI2f7vUguLJFLhOr5PphEUXj/CQTssw7iJenbu4+R
         kfo1qvB8GiDiswP8UJ++4LiEJN57I/QnT+PG+ymdOYwyIn/vegZrq8Awq2EeSvzj56qB
         JzirrUAxmQeRZyMUEIUxyfVmfkj7Wu6SkJ0vRdTStTB44T70QDag4kqfbJjc8wyPA+b+
         XkbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=g1R9Bq/TkbA5ZJxMb+U3jIOApLTRzPyrB4NxcI5os7I=;
        b=tTLE4WuyOQAly6qnwmUGpgv8J3fxwx/s+MUpcsz99yPw3TZrZKZQz21XzESrZ1KapR
         BhtDxAj3DqBYF7oUvAmUt52CG6fG6wpwSf+zjxeuTg9KR9WV2pR6o8Z4QBXSfRRlTp0o
         eLnkArAZgwf7D8+rAnVmdaJ8ey4tl4hY8D0cZKMrTIP7jbwTTKiEtjN3ehW0J7HlWtSY
         T4+MjFwtr5uEJklupbZE9cdAOvDjpFegaWbeA1LG9xkhI10rg19GwQ174a2qrNkr4XZo
         wxMiD/6uYi19vMlRzmazrW/ZhojP29C3TTDF3j67fyccriZQI8aEST2TzJH945aeI800
         IkjA==
X-Gm-Message-State: AOAM532J20ZLxCqka6T69laka++wxCo1oxTulLTVB2oIENauTmyH9hcn
        lqW1EQPNLw/0CartrzIykCYUPA==
X-Google-Smtp-Source: ABdhPJz/vSSYTsXvkEMySgNmQol+y5TXIqrof7YPeVugtRHub1q2+gQsIrgAJK4N7v/aB6KE/YvhlA==
X-Received: by 2002:a63:5843:: with SMTP id i3mr849381pgm.209.1608312757099;
        Fri, 18 Dec 2020 09:32:37 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id l11sm9892957pgt.79.2020.12.18.09.32.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Dec 2020 09:32:36 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     ohad@wizery.com, bjorn.andersson@linaro.org, robh+dt@kernel.org
Cc:     arnaud.pouliquen@st.com, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 06/17] remoteproc: stm32: Move resource table setup to rproc_ops
Date:   Fri, 18 Dec 2020 10:32:17 -0700
Message-Id: <20201218173228.2277032-7-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201218173228.2277032-1-mathieu.poirier@linaro.org>
References: <20201218173228.2277032-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the setting of the resource table installed by an external
entity to rproc_ops::get_loaded_rsc_table().  This is to support
scenarios where a remote processor has been started by the core
but is detached at a later stage.  To re-attach the remote
processor, the address of the resource table needs to be available
at a later time than the platform driver's probe() function.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/remoteproc/stm32_rproc.c | 147 ++++++++++++++++---------------
 1 file changed, 74 insertions(+), 73 deletions(-)

diff --git a/drivers/remoteproc/stm32_rproc.c b/drivers/remoteproc/stm32_rproc.c
index d2414cc1d90d..c635f746e44a 100644
--- a/drivers/remoteproc/stm32_rproc.c
+++ b/drivers/remoteproc/stm32_rproc.c
@@ -541,6 +541,79 @@ static void stm32_rproc_kick(struct rproc *rproc, int vqid)
 	}
 }
 
+static int stm32_rproc_da_to_pa(struct rproc *rproc,
+				u64 da, phys_addr_t *pa)
+{
+	struct stm32_rproc *ddata = rproc->priv;
+	struct device *dev = rproc->dev.parent;
+	struct stm32_rproc_mem *p_mem;
+	unsigned int i;
+
+	for (i = 0; i < ddata->nb_rmems; i++) {
+		p_mem = &ddata->rmems[i];
+
+		if (da < p_mem->dev_addr ||
+		    da >= p_mem->dev_addr + p_mem->size)
+			continue;
+
+		*pa = da - p_mem->dev_addr + p_mem->bus_addr;
+		dev_dbg(dev, "da %llx to pa %#x\n", da, *pa);
+
+		return 0;
+	}
+
+	dev_err(dev, "can't translate da %llx\n", da);
+
+	return -EINVAL;
+}
+
+static int stm32_rproc_get_loaded_rsc_table(struct rproc *rproc)
+{
+	struct stm32_rproc *ddata = rproc->priv;
+	struct device *dev = rproc->dev.parent;
+	phys_addr_t rsc_pa;
+	u32 rsc_da;
+	int err;
+
+	/* The resource table has already been mapped, nothing to do */
+	if (ddata->rsc_va)
+		goto done;
+
+	err = regmap_read(ddata->rsctbl.map, ddata->rsctbl.reg, &rsc_da);
+	if (err) {
+		dev_err(dev, "failed to read rsc tbl addr\n");
+		return err;
+	}
+
+	if (!rsc_da)
+		/* no rsc table */
+		return 0;
+
+	err = stm32_rproc_da_to_pa(rproc, rsc_da, &rsc_pa);
+	if (err)
+		return err;
+
+	ddata->rsc_va = devm_ioremap_wc(dev, rsc_pa, RSC_TBL_SIZE);
+	if (IS_ERR_OR_NULL(ddata->rsc_va)) {
+		dev_err(dev, "Unable to map memory region: %pa+%zx\n",
+			&rsc_pa, RSC_TBL_SIZE);
+		ddata->rsc_va = NULL;
+		return -ENOMEM;
+	}
+
+done:
+	/*
+	 * The resource table is already loaded in device memory, no need
+	 * to work with a cached table.
+	 */
+	rproc->cached_table = NULL;
+	/* Assuming the resource table fits in 1kB is fair */
+	rproc->table_sz = RSC_TBL_SIZE;
+	rproc->table_ptr = (struct resource_table *)ddata->rsc_va;
+
+	return 0;
+}
+
 static struct rproc_ops st_rproc_ops = {
 	.start		= stm32_rproc_start,
 	.stop		= stm32_rproc_stop,
@@ -549,6 +622,7 @@ static struct rproc_ops st_rproc_ops = {
 	.load		= rproc_elf_load_segments,
 	.parse_fw	= stm32_rproc_parse_fw,
 	.find_loaded_rsc_table = rproc_elf_find_loaded_rsc_table,
+	.get_loaded_rsc_table = stm32_rproc_get_loaded_rsc_table,
 	.sanity_check	= rproc_elf_sanity_check,
 	.get_boot_addr	= rproc_elf_get_boot_addr,
 };
@@ -692,75 +766,6 @@ static int stm32_rproc_get_m4_status(struct stm32_rproc *ddata,
 	return regmap_read(ddata->m4_state.map, ddata->m4_state.reg, state);
 }
 
-static int stm32_rproc_da_to_pa(struct platform_device *pdev,
-				struct stm32_rproc *ddata,
-				u64 da, phys_addr_t *pa)
-{
-	struct device *dev = &pdev->dev;
-	struct stm32_rproc_mem *p_mem;
-	unsigned int i;
-
-	for (i = 0; i < ddata->nb_rmems; i++) {
-		p_mem = &ddata->rmems[i];
-
-		if (da < p_mem->dev_addr ||
-		    da >= p_mem->dev_addr + p_mem->size)
-			continue;
-
-		*pa = da - p_mem->dev_addr + p_mem->bus_addr;
-		dev_dbg(dev, "da %llx to pa %#x\n", da, *pa);
-
-		return 0;
-	}
-
-	dev_err(dev, "can't translate da %llx\n", da);
-
-	return -EINVAL;
-}
-
-static int stm32_rproc_get_loaded_rsc_table(struct platform_device *pdev,
-					    struct rproc *rproc,
-					    struct stm32_rproc *ddata)
-{
-	struct device *dev = &pdev->dev;
-	phys_addr_t rsc_pa;
-	u32 rsc_da;
-	int err;
-
-	err = regmap_read(ddata->rsctbl.map, ddata->rsctbl.reg, &rsc_da);
-	if (err) {
-		dev_err(dev, "failed to read rsc tbl addr\n");
-		return err;
-	}
-
-	if (!rsc_da)
-		/* no rsc table */
-		return 0;
-
-	err = stm32_rproc_da_to_pa(pdev, ddata, rsc_da, &rsc_pa);
-	if (err)
-		return err;
-
-	ddata->rsc_va = devm_ioremap_wc(dev, rsc_pa, RSC_TBL_SIZE);
-	if (IS_ERR_OR_NULL(ddata->rsc_va)) {
-		dev_err(dev, "Unable to map memory region: %pa+%zx\n",
-			&rsc_pa, RSC_TBL_SIZE);
-		ddata->rsc_va = NULL;
-		return -ENOMEM;
-	}
-
-	/*
-	 * The resource table is already loaded in device memory, no need
-	 * to work with a cached table.
-	 */
-	rproc->cached_table = NULL;
-	/* Assuming the resource table fits in 1kB is fair */
-	rproc->table_sz = RSC_TBL_SIZE;
-	rproc->table_ptr = (struct resource_table *)ddata->rsc_va;
-
-	return 0;
-}
-
 static int stm32_rproc_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -800,10 +805,6 @@ static int stm32_rproc_probe(struct platform_device *pdev)
 		ret = stm32_rproc_parse_memory_regions(rproc);
 		if (ret)
 			goto free_resources;
-
-		ret = stm32_rproc_get_loaded_rsc_table(pdev, rproc, ddata);
-		if (ret)
-			goto free_resources;
 	}
 
 	rproc->has_iommu = false;
-- 
2.25.1

