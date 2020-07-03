Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4132D21340B
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jul 2020 08:20:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726396AbgGCGUI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jul 2020 02:20:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725648AbgGCGUG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 02:20:06 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0A1CC08C5C1
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jul 2020 23:20:05 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id e13so27931006qkg.5
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jul 2020 23:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NiahKVIdWPQXGXy3kUGI/Mgp2P3mAg5Jh2peVHJFllE=;
        b=B+3yn7dyzOlYgSV4jlXaB7KXwesCETar3XzVhAWonQZv9MEdDA/OP8Ae+bLka7jP99
         0zmIgV4K5PKtFZ5goS4Qc28Ds0xZFgl7LwhiiRAkIfOHdoEDEXZn3P91A4UxSWHgbu6x
         ShRDY3q5XvPIWcgbdgv89/WGSCPFrXOi+JlxOhnaVwhO16kw1RNZ5IlqGbt2csBnMXmR
         EsgTC1dPYa2qVnwQbLm0ErpNb9v9Opi4YVoMSITHMkWg7G0Z3YcBNf7zKiwCHbJLK8EF
         rS0V+FCjMhxWN8Kbd/STwortwfTeSh6Vm+LarkbtenKx6VOTSYA9OLjYyEdJpIJ8T+pT
         2veA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NiahKVIdWPQXGXy3kUGI/Mgp2P3mAg5Jh2peVHJFllE=;
        b=eF0cRZOkbpsp7qij8hMC16D9/w8Y+oWd4aoVnRchk4w26Z2NwhsF6p73KthMAvvalJ
         aRHHp09b2HCbOr0QDS4TwZG/K18JIuqHjCVtidW5m/hFQGI2uKHUKqaP+X62ytVKrycM
         eOQ6CWIMvgamUAK6UfSA+etGT1c+cc8mgC+ObmYYk9FbKrTdraWJTBkjhcyWgUAtHZES
         ODLdB4nwZ5XCs7PuwC15LUZdW8ahmyMpO1MZfWOl0EJ71BKoETNjrCODGKmK70BVHn+e
         xGxD9V0Gec8ex/VLUbck9wxJcUJh8Umhrv1SqIA2zqZ5FIxfk7uESz4GD6WsVuwD5kxu
         61Jw==
X-Gm-Message-State: AOAM5315qSFsaIovNMmU0gXiNtvwMkRiCOzB3TK/T6ybAH5hAvSdWWmd
        Nyv7RDAG3qG/ebyariZRJZU=
X-Google-Smtp-Source: ABdhPJw/XLxDR5E9h8hV3QZRgvQjU/lzBMu1tygj0zoLpmKMFl7qdBBXvK4luydMQqUqD9wMlEMBAA==
X-Received: by 2002:a37:9a96:: with SMTP id c144mr33537992qke.207.1593757204942;
        Thu, 02 Jul 2020 23:20:04 -0700 (PDT)
Received: from LeoBras.ibmuc.com (200-236-245-17.dynamic.desktop.com.br. [200.236.245.17])
        by smtp.gmail.com with ESMTPSA id n28sm11165288qtf.8.2020.07.02.23.20.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2020 23:20:04 -0700 (PDT)
From:   Leonardo Bras <leobras.c@gmail.com>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Leonardo Bras <leobras.c@gmail.com>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Ram Pai <linuxram@us.ibm.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/6] powerpc/pseries/iommu: Update call to ibm,query-pe-dma-windows
Date:   Fri,  3 Jul 2020 03:18:40 -0300
Message-Id: <20200703061844.111865-3-leobras.c@gmail.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200703061844.111865-1-leobras.c@gmail.com>
References: <20200703061844.111865-1-leobras.c@gmail.com>
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

Also, a routine was created for helping reading the ddw extensions as
suggested by LoPAR: First reading the size of the extension array from
index 0, checking if the property exists, and then returning it's value.

Signed-off-by: Leonardo Bras <leobras.c@gmail.com>
---
 arch/powerpc/platforms/pseries/iommu.c | 91 +++++++++++++++++++++++---
 1 file changed, 81 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
index ac0d6376bdad..1a933c4e8bba 100644
--- a/arch/powerpc/platforms/pseries/iommu.c
+++ b/arch/powerpc/platforms/pseries/iommu.c
@@ -47,6 +47,12 @@ enum {
 	DDW_APPLICABLE_SIZE
 };
 
+enum {
+	DDW_EXT_SIZE = 0,
+	DDW_EXT_RESET_DMA_WIN = 1,
+	DDW_EXT_QUERY_OUT_SIZE = 2
+};
+
 static struct iommu_table_group *iommu_pseries_alloc_group(int node)
 {
 	struct iommu_table_group *table_group;
@@ -342,7 +348,7 @@ struct direct_window {
 /* Dynamic DMA Window support */
 struct ddw_query_response {
 	u32 windows_available;
-	u32 largest_available_block;
+	u64 largest_available_block;
 	u32 page_size;
 	u32 migration_capable;
 };
@@ -877,14 +883,62 @@ static int find_existing_ddw_windows(void)
 }
 machine_arch_initcall(pseries, find_existing_ddw_windows);
 
+/**
+ * ddw_read_ext - Get the value of an DDW extension
+ * @np:		device node from which the extension value is to be read.
+ * @extnum:	index number of the extension.
+ * @value:	pointer to return value, modified when extension is available.
+ *
+ * Checks if "ibm,ddw-extensions" exists for this node, and get the value
+ * on index 'extnum'.
+ * It can be used only to check if a property exists, passing value == NULL.
+ *
+ * Returns:
+ *	0 if extension successfully read
+ *	-EINVAL if the "ibm,ddw-extensions" does not exist,
+ *	-ENODATA if "ibm,ddw-extensions" does not have a value, and
+ *	-EOVERFLOW if "ibm,ddw-extensions" does not contain this extension.
+ */
+static inline int ddw_read_ext(const struct device_node *np, int extnum,
+			       u32 *value)
+{
+	static const char propname[] = "ibm,ddw-extensions";
+	u32 count;
+	int ret;
+
+	ret = of_property_read_u32_index(np, propname, DDW_EXT_SIZE, &count);
+	if (ret)
+		return ret;
+
+	if (count < extnum)
+		return -EOVERFLOW;
+
+	if (!value)
+		value = &count;
+
+	return of_property_read_u32_index(np, propname, extnum, value);
+}
+
 static int query_ddw(struct pci_dev *dev, const u32 *ddw_avail,
-			struct ddw_query_response *query)
+		     struct ddw_query_response *query,
+		     struct device_node *parent)
 {
 	struct device_node *dn;
 	struct pci_dn *pdn;
-	u32 cfg_addr;
+	u32 cfg_addr, ext_query, query_out[5];
 	u64 buid;
-	int ret;
+	int ret, out_sz;
+
+	/*
+	 * From LoPAR level 2.8, "ibm,ddw-extensions" index 3 can rule how many
+	 * output parameters ibm,query-pe-dma-windows will have, ranging from
+	 * 5 to 6.
+	 */
+	ret = ddw_read_ext(parent, DDW_EXT_QUERY_OUT_SIZE, &ext_query);
+	if (!ret && ext_query == 1)
+		out_sz = 6;
+	else
+		out_sz = 5;
 
 	/*
 	 * Get the config address and phb buid of the PE window.
@@ -897,11 +951,28 @@ static int query_ddw(struct pci_dev *dev, const u32 *ddw_avail,
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
 
@@ -1049,7 +1120,7 @@ static u64 enable_ddw(struct pci_dev *dev, struct device_node *pdn)
 	 * of page sizes: supported and supported for migrate-dma.
 	 */
 	dn = pci_device_to_OF_node(dev);
-	ret = query_ddw(dev, ddw_avail, &query);
+	ret = query_ddw(dev, ddw_avail, &query, pdn);
 	if (ret != 0)
 		goto out_failed;
 
@@ -1077,7 +1148,7 @@ static u64 enable_ddw(struct pci_dev *dev, struct device_node *pdn)
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

