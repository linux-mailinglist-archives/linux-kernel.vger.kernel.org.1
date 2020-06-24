Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DF6D206C4F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jun 2020 08:24:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389125AbgFXGYe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Jun 2020 02:24:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388090AbgFXGYc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 02:24:32 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42EFFC061573
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 23:24:32 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id g13so846136qtv.8
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 23:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yajEeGcHJxjBvTZAS0s0BFpw3ZLBt1KNWcONoPvtsFM=;
        b=A45oNA6HpyY4G2DdBilcqBNQL2XvX3Ui2sA8ppuJJEySagRDSUHW6ZpCMMkiQJcRcW
         MDH9cnyY9wgKQq9VetABfQQl9NdkYuq2Hy3HblrFHjO+6VFDubIALGyUsR1do96OM+EE
         UID9rULAJnPFG6DiSICN9FAAxUot7+9tsPGJH6rlh0hh1U0KllSgj/e1N6pMwdzv4Dbs
         DRLm7pLVyRfBI9AcGNJFG+NrI3IYMO+bDEQBL0SY5fyFzmQ4DNo+SCUNBOI3JcixhSgv
         PPYpbH8XKNEg4Ty1bIETAXHeZr4U1AkBrKdntYTWTXFdwzwATmqOVgXRsnE66giwkknY
         bOeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yajEeGcHJxjBvTZAS0s0BFpw3ZLBt1KNWcONoPvtsFM=;
        b=mvFN5M+8dGJEWvNgIILnTYykHOXuaZHff8Qk/sJFP70oJFYMd0QwK1AI6s7I2ELOmF
         eiD81jWejFHieKH3an7n0TWSDAXDNLM4RFVk2zwAP3b4Bj1GGS75o4wHFMaSUrr4tjB1
         ahJPrD/NvYHR9dr0SDjA+F0QdCtV/S3JoVtDtPQd9AmmcuG4psRlAujk0AxCX7MkVLj8
         C/gNvuvDdxmRIFBXo8GYqQCbutaYhpResjjqK56LXKM1kQZUc1Vgz4umc9OaVOvZdcXj
         9t2AnnFpASQwspg8MOjxTE2YWs4ASngj2zlB3Xehxar/7nM1yF2VfuDsZ9xmdzvqbywt
         UXng==
X-Gm-Message-State: AOAM533sp8NwoXFhItfOEQvYZJn8JwsPtXDBYRqVmZ/xib0im7Bsaxzk
        LQLhZgaQqwYuhpMrmXAyYPI=
X-Google-Smtp-Source: ABdhPJxDWGlcgntYYwswsfDbkWRKpZI+Okk4pWLiUtupPZQ0RL9DTjzuDlpxqUt6bydwyt71uN4teA==
X-Received: by 2002:ac8:19d3:: with SMTP id s19mr14386962qtk.274.1592979871542;
        Tue, 23 Jun 2020 23:24:31 -0700 (PDT)
Received: from LeoBras.ibmuc.com (179-125-148-1.dynamic.desktop.com.br. [179.125.148.1])
        by smtp.gmail.com with ESMTPSA id n2sm2489727qtp.45.2020.06.23.23.24.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2020 23:24:30 -0700 (PDT)
From:   Leonardo Bras <leobras.c@gmail.com>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Leonardo Bras <leobras.c@gmail.com>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Ram Pai <linuxram@us.ibm.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/6] powerpc/pseries/iommu: Update call to ibm,query-pe-dma-windows
Date:   Wed, 24 Jun 2020 03:24:07 -0300
Message-Id: <20200624062411.367796-3-leobras.c@gmail.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200624062411.367796-1-leobras.c@gmail.com>
References: <20200624062411.367796-1-leobras.c@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From LoPAR level 2.8, "ibm,ddw-extensions" index 3 can make the number of
outputs from "ibm,query-pe-dma-windows" go from 5 to 6.

This change of output size is meant to expand the address size of
largest_available_block PE TCE from 32-bit to 64-bit, which ends up
shifting page_size and migration_capable.

This ends up requiring the update of
ddw_query_response->largest_available_block from u32 to u64, and manually
assigning the values from the buffer into this struct, according to
output size.

Signed-off-by: Leonardo Bras <leobras.c@gmail.com>
---
 arch/powerpc/platforms/pseries/iommu.c | 57 +++++++++++++++++++++-----
 1 file changed, 47 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
index 68d2aa9c71a8..558e5441c355 100644
--- a/arch/powerpc/platforms/pseries/iommu.c
+++ b/arch/powerpc/platforms/pseries/iommu.c
@@ -44,6 +44,10 @@
 #define DDW_REMOVE_PE_DMA_WIN	2
 #define DDW_APPLICABLE_SIZE	3
 
+#define DDW_EXT_SIZE		0
+#define DDW_EXT_RESET_DMA_WIN	1
+#define DDW_EXT_QUERY_OUT_SIZE	2
+
 static struct iommu_table_group *iommu_pseries_alloc_group(int node)
 {
 	struct iommu_table_group *table_group;
@@ -339,7 +343,7 @@ struct direct_window {
 /* Dynamic DMA Window support */
 struct ddw_query_response {
 	u32 windows_available;
-	u32 largest_available_block;
+	u64 largest_available_block;
 	u32 page_size;
 	u32 migration_capable;
 };
@@ -875,13 +879,29 @@ static int find_existing_ddw_windows(void)
 machine_arch_initcall(pseries, find_existing_ddw_windows);
 
 static int query_ddw(struct pci_dev *dev, const u32 *ddw_avail,
-			struct ddw_query_response *query)
+		     struct ddw_query_response *query,
+		     struct device_node *parent)
 {
 	struct device_node *dn;
 	struct pci_dn *pdn;
-	u32 cfg_addr;
+	u32 cfg_addr, query_out[5], ddw_ext[DDW_EXT_QUERY_OUT_SIZE + 1];
 	u64 buid;
-	int ret;
+	int ret, out_sz;
+
+	/*
+	 * From LoPAR level 2.8, "ibm,ddw-extensions" index 3 can rule how many
+	 * output parameters ibm,query-pe-dma-windows will have, ranging from
+	 * 5 to 6.
+	 */
+
+	ret = of_property_read_u32_array(parent, "ibm,ddw-extensions",
+					 &ddw_ext[0],
+					 DDW_EXT_QUERY_OUT_SIZE + 1);
+	if (ret && ddw_ext[DDW_EXT_SIZE] > 1 &&
+	    ddw_ext[DDW_EXT_QUERY_OUT_SIZE] == 1)
+		out_sz = 6;
+	else
+		out_sz = 5;
 
 	/*
 	 * Get the config address and phb buid of the PE window.
@@ -894,11 +914,28 @@ static int query_ddw(struct pci_dev *dev, const u32 *ddw_avail,
 	buid = pdn->phb->buid;
 	cfg_addr = ((pdn->busno << 16) | (pdn->devfn << 8));
 
-	ret = rtas_call(ddw_avail[DDW_QUERY_PE_DMA_WIN], 3, 5, (u32 *)query,
+	ret = rtas_call(ddw_avail[DDW_QUERY_PE_DMA_WIN], 3, out_sz, query_out,
 			cfg_addr, BUID_HI(buid), BUID_LO(buid));
-	dev_info(&dev->dev, "ibm,query-pe-dma-windows(%x) %x %x %x"
-		" returned %d\n", ddw_avail[DDW_QUERY_PE_DMA_WIN], cfg_addr,
-		 BUID_HI(buid), BUID_LO(buid), ret);
+	dev_info(&dev->dev, "ibm,query-pe-dma-windows(%x) %x %x %x returned %d\n",
+		 ddw_avail[DDW_QUERY_PE_DMA_WIN], cfg_addr, BUID_HI(buid),
+		 BUID_LO(buid), ret);
+
+	switch (out_sz) {
+	case 5:
+		query->windows_available = query_out[0];
+		query->largest_available_block = query_out[1];
+		query->page_size = query_out[2];
+		query->migration_capable = query_out[3];
+		break;
+	case 6:
+		query->windows_available = query_out[0];
+		query->largest_available_block = ((u64)query_out[1] << 32) |
+						 query_out[2];
+		query->page_size = query_out[3];
+		query->migration_capable = query_out[4];
+		break;
+	}
+
 	return ret;
 }
 
@@ -1046,7 +1083,7 @@ static u64 enable_ddw(struct pci_dev *dev, struct device_node *pdn)
 	 * of page sizes: supported and supported for migrate-dma.
 	 */
 	dn = pci_device_to_OF_node(dev);
-	ret = query_ddw(dev, ddw_avail, &query);
+	ret = query_ddw(dev, ddw_avail, &query, pdn);
 	if (ret != 0)
 		goto out_failed;
 
@@ -1074,7 +1111,7 @@ static u64 enable_ddw(struct pci_dev *dev, struct device_node *pdn)
 	/* check largest block * page size > max memory hotplug addr */
 	max_addr = ddw_memory_hotplug_max();
 	if (query.largest_available_block < (max_addr >> page_shift)) {
-		dev_dbg(&dev->dev, "can't map partition max 0x%llx with %u "
+		dev_dbg(&dev->dev, "can't map partition max 0x%llx with %llu "
 			  "%llu-sized pages\n", max_addr,  query.largest_available_block,
 			  1ULL << page_shift);
 		goto out_failed;
-- 
2.25.4

