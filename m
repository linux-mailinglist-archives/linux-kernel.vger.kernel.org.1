Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A975E221D27
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jul 2020 09:18:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728358AbgGPHRx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jul 2020 03:17:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728347AbgGPHRw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 03:17:52 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9588AC061755
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 00:17:52 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id i3so4116699qtq.13
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 00:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CxIEhwPDuXo7CrTRespdnXqLwI0LZ0KuUrIP2pNY/ic=;
        b=lvFTKz1VKyFWeJJOfKpsQh538A2ECeYgBPLkealQq2QmKBKj50QQtCgKBpq7F2ECqG
         vV/j5Q+f14e2f0ZmwA7eM7elZhqsb1cBUfiEFrb6pgB8vZSqm7EiI/2gJfCr494Pwjyh
         OWRz9EY7NBVy8MZNqwael2L+crWI3osfdQgVl/CTMC3NsbXJZ0rGuGbKVOmLm+cC+K45
         oQUpphAfMc98NVNdCvPu5vKWW1aMIOW44Q/lm+ZOt6zIGdnZf4rUa2iv0UnkXKmcJLUx
         662P6qN+bCODAjIVLltBW28ORHWgRXn05zjT6khxoZuyMcIKwMeRVNV3M1Wd/FEXTAGB
         rFTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CxIEhwPDuXo7CrTRespdnXqLwI0LZ0KuUrIP2pNY/ic=;
        b=XkkSYXH2h/78eln+XAMQL0Ofr1pCQmb8Qsu1ys5Fr/DJmPMpMdgNZi0w1Lr5igQv6R
         Hn9LniMFgrdnIJrZFYVlM/ZiORjhgHgQFvRtOV8SkdmpwXVfYihebFubsaRVwCZAXZLH
         h0l9nJsncghBuHZS2eu/MArF6WmlwM+H5tL88+H76HtXcgzBpe66qX2Rq47mlZNh7Xvw
         73pX4tybhoVWU3h/je9LNkw5lUgKWucJMWPGk9mqLOE02RV9FlgwTax7CA4zSkBEJn0e
         40DWEDPQ5pMRG8pm+KkzRPYm2dGJZP6BbHMnLielisSBisH2Zwe03wEhiQT/7sh/9PoY
         lxlQ==
X-Gm-Message-State: AOAM530SCvsGXqM5qNCOppPGJ3quUlheNrbXL74PPCwQ3paoeRduN7bK
        jc00akypn5KZEl5g3YAvspE=
X-Google-Smtp-Source: ABdhPJzhA8TktDN3RhmMXQXXnFF9M1nNpn8TDlqJHhHAcSwfSSrzb28n+KH3tSE+24pivHi81HFLMQ==
X-Received: by 2002:ac8:3777:: with SMTP id p52mr3681134qtb.31.1594883871832;
        Thu, 16 Jul 2020 00:17:51 -0700 (PDT)
Received: from LeoBras.ibmuc.com (200-236-239-31.dynamic.desktop.com.br. [200.236.239.31])
        by smtp.gmail.com with ESMTPSA id a5sm6637989qtd.84.2020.07.16.00.17.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 00:17:51 -0700 (PDT)
From:   Leonardo Bras <leobras.c@gmail.com>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Joel Stanley <joel@jms.id.au>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Leonardo Bras <leobras.c@gmail.com>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Ram Pai <linuxram@us.ibm.com>,
        Brian King <brking@linux.vnet.ibm.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 6/7] powerpc/pseries/iommu: Make use of DDW even if it does not map the partition
Date:   Thu, 16 Jul 2020 04:16:58 -0300
Message-Id: <20200716071658.467820-7-leobras.c@gmail.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200716071658.467820-1-leobras.c@gmail.com>
References: <20200716071658.467820-1-leobras.c@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As of today, if the biggest DDW that can be created can't map the whole
partition, it's creation is skipped and the default DMA window
"ibm,dma-window" is used instead.

Usually this DDW is bigger than the default DMA window, and it performs
better, so it would be nice to use it instead.

The DDW created will be used for direct mapping by default.
If it's not available, indirect mapping will be used instead.

In this case, it's necessary to update the iommu_table so iommu_alloc()
can use the DDW created. For this, iommu_table_update() is called after a
enable_ddw() when direct DMA is not available.

As there will never have both direct and indirect mappings at the same
time, the same property name can be used for the created DDW.

So renaming
define DIRECT64_PROPNAME "linux,direct64-ddr-window-info"
to
define DMA64_PROPNAME "linux,dma64-ddr-window-info"
looks the right thing to do.

Signed-off-by: Leonardo Bras <leobras.c@gmail.com>
---
 arch/powerpc/include/asm/iommu.h       |  3 ++
 arch/powerpc/kernel/iommu.c            | 15 +++++++++
 arch/powerpc/platforms/pseries/iommu.c | 46 +++++++++++++++++++-------
 3 files changed, 52 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/include/asm/iommu.h b/arch/powerpc/include/asm/iommu.h
index 5032f1593299..dc4480a9d60d 100644
--- a/arch/powerpc/include/asm/iommu.h
+++ b/arch/powerpc/include/asm/iommu.h
@@ -154,6 +154,9 @@ extern int iommu_tce_table_put(struct iommu_table *tbl);
  */
 extern struct iommu_table *iommu_init_table(struct iommu_table *tbl,
 		int nid, unsigned long res_start, unsigned long res_end);
+void iommu_table_update(struct iommu_table *tbl, int nid, unsigned long liobn,
+			unsigned long win_addr, unsigned long page_shift,
+			unsigned long window_shift);
 
 #define IOMMU_TABLE_GROUP_MAX_TABLES	2
 
diff --git a/arch/powerpc/kernel/iommu.c b/arch/powerpc/kernel/iommu.c
index c3242253a4e7..cb0cb572eb0a 100644
--- a/arch/powerpc/kernel/iommu.c
+++ b/arch/powerpc/kernel/iommu.c
@@ -774,6 +774,21 @@ static void iommu_table_free(struct kref *kref)
 	kfree(tbl);
 }
 
+void iommu_table_update(struct iommu_table *tbl, int nid, unsigned long liobn,
+			unsigned long win_addr, unsigned long page_shift,
+			unsigned long window_shift)
+{
+	iommu_table_clean(tbl);
+
+	/* Update tlb with values from ddw */
+	tbl->it_index = liobn;
+	tbl->it_offset = win_addr >> page_shift;
+	tbl->it_page_shift = page_shift;
+	tbl->it_size = 1 << (window_shift - page_shift);
+
+	iommu_init_table(tbl, nid, 0, 0);
+}
+
 struct iommu_table *iommu_tce_table_get(struct iommu_table *tbl)
 {
 	if (kref_get_unless_zero(&tbl->it_kref))
diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
index fc8d0555e2e9..6e1c9d1599d1 100644
--- a/arch/powerpc/platforms/pseries/iommu.c
+++ b/arch/powerpc/platforms/pseries/iommu.c
@@ -364,7 +364,7 @@ static LIST_HEAD(direct_window_list);
 static DEFINE_SPINLOCK(direct_window_list_lock);
 /* protects initializing window twice for same device */
 static DEFINE_MUTEX(direct_window_init_mutex);
-#define DIRECT64_PROPNAME "linux,direct64-ddr-window-info"
+#define DMA64_PROPNAME "linux,dma64-ddr-window-info"
 
 static int tce_clearrange_multi_pSeriesLP(unsigned long start_pfn,
 					unsigned long num_pfn, const void *arg)
@@ -823,7 +823,7 @@ static void remove_ddw(struct device_node *np, bool remove_prop)
 	if (ret)
 		return;
 
-	win = of_find_property(np, DIRECT64_PROPNAME, NULL);
+	win = of_find_property(np, DMA64_PROPNAME, NULL);
 	if (!win)
 		return;
 
@@ -869,8 +869,8 @@ static int find_existing_ddw_windows(void)
 	if (!firmware_has_feature(FW_FEATURE_LPAR))
 		return 0;
 
-	for_each_node_with_property(pdn, DIRECT64_PROPNAME) {
-		direct64 = of_get_property(pdn, DIRECT64_PROPNAME, &len);
+	for_each_node_with_property(pdn, DMA64_PROPNAME) {
+		direct64 = of_get_property(pdn, DMA64_PROPNAME, &len);
 		if (!direct64)
 			continue;
 
@@ -1210,23 +1210,26 @@ static u64 enable_ddw(struct pci_dev *dev, struct device_node *pdn)
 			  query.page_size);
 		goto out_failed;
 	}
+
 	/* verify the window * number of ptes will map the partition */
-	/* check largest block * page size > max memory hotplug addr */
 	max_addr = ddw_memory_hotplug_max();
 	if (query.largest_available_block < (max_addr >> page_shift)) {
-		dev_dbg(&dev->dev, "can't map partition max 0x%llx with %llu "
-			  "%llu-sized pages\n", max_addr,  query.largest_available_block,
-			  1ULL << page_shift);
-		goto out_failed;
+		dev_dbg(&dev->dev, "can't map partition max 0x%llx with %llu %llu-sized pages\n",
+			max_addr, query.largest_available_block,
+			1ULL << page_shift);
+
+		len = order_base_2(query.largest_available_block << page_shift);
+	} else {
+		len = order_base_2(max_addr);
 	}
-	len = order_base_2(max_addr);
+
 	win64 = kzalloc(sizeof(struct property), GFP_KERNEL);
 	if (!win64) {
 		dev_info(&dev->dev,
 			"couldn't allocate property for 64bit dma window\n");
 		goto out_failed;
 	}
-	win64->name = kstrdup(DIRECT64_PROPNAME, GFP_KERNEL);
+	win64->name = kstrdup(DMA64_PROPNAME, GFP_KERNEL);
 	win64->value = ddwprop = kmalloc(sizeof(*ddwprop), GFP_KERNEL);
 	win64->length = sizeof(*ddwprop);
 	if (!win64->name || !win64->value) {
@@ -1273,7 +1276,9 @@ static u64 enable_ddw(struct pci_dev *dev, struct device_node *pdn)
 	list_add(&window->list, &direct_window_list);
 	spin_unlock(&direct_window_list_lock);
 
-	dma_addr = be64_to_cpu(ddwprop->dma_base);
+	/* Only returns the dma_addr if DDW maps the whole partition */
+	if (len == order_base_2(max_addr))
+		dma_addr = be64_to_cpu(ddwprop->dma_base);
 	goto out_unlock;
 
 out_free_window:
@@ -1302,6 +1307,22 @@ static u64 enable_ddw(struct pci_dev *dev, struct device_node *pdn)
 	return dma_addr;
 }
 
+static void iommu_pseries_table_update(struct pci_dev *dev,
+				       struct device_node *pdn)
+{
+	const struct dynamic_dma_window_prop *ddw;
+	struct pci_dn *pci;
+	int len;
+
+	ddw = of_get_property(pdn, DMA64_PROPNAME, &len);
+	if (!ddw  || len < sizeof(struct dynamic_dma_window_prop))
+		return;
+
+	iommu_table_update(pci->table_group->tables[0], pci->phb->node,
+			   ddw->liobn, ddw->dma_base, ddw->tce_shift,
+			   ddw->window_shift);
+}
+
 static void pci_dma_dev_setup_pSeriesLP(struct pci_dev *dev)
 {
 	struct device_node *pdn, *dn;
@@ -1382,6 +1403,7 @@ static bool iommu_bypass_supported_pSeriesLP(struct pci_dev *pdev, u64 dma_mask)
 		pdev->dev.archdata.dma_offset = enable_ddw(pdev, pdn);
 		if (pdev->dev.archdata.dma_offset)
 			return true;
+		iommu_pseries_table_update(pdev, pdn);
 	}
 
 	return false;
-- 
2.25.4

