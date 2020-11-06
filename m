Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D60E2A9997
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 17:39:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727249AbgKFQiq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 11:38:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727142AbgKFQin (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 11:38:43 -0500
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 527ABC0613CF
        for <linux-kernel@vger.kernel.org>; Fri,  6 Nov 2020 08:38:43 -0800 (PST)
Received: by mail-qt1-x842.google.com with SMTP id t5so1175145qtp.2
        for <linux-kernel@vger.kernel.org>; Fri, 06 Nov 2020 08:38:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hyihr231RMubay4CbLM0CzqsU3IYdDyAVzI9nCSyEmQ=;
        b=vHCavlMIMWmTuEUT0yxIsRbmc3sMvKm2aBri2RwZ6oE/GDXkz7hTUjiLHbXrcsfoMd
         RlHO0frzFd2LFmbdtXV3vfgG4LAEZFxnGIskOG9V9XKiGx4lk7swqpr/ccY/NPFANj7u
         JSIs8GMc0zlvGmhSDOEqX0S25vyOyNKB4taMWMxoWHBAtNARa4OtflgaoKAkBnwvtz2D
         APQisBElBumw5H7yXPRlMNv27+9cEQAgiejTnkgS8xylNFUsg1OyWiSdw2TY2t/cGCvY
         tS7DpLFSr/zAyY6GljpfZJsVNzI7v0ak7ctsb9fF4tmCKEGam1/Pf6igvEgzEVGqGU3Z
         pQ3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hyihr231RMubay4CbLM0CzqsU3IYdDyAVzI9nCSyEmQ=;
        b=l/rkN/xooOOCRzRet8rlcapFxT6xOnt/dKXe+txMmQKYUzEIELWnPCoyYSkgHBiELg
         Hat7bscwmxh5f5E13vBlJybHtWyaaCkm5eO9I6bC4JYM1n6WR7a3Q8JLbK8qmbrkDziM
         KhIJ6kBgosqorV+6pym0cR6ewe0zdtZNhgWvp3M/U/xwRe5B9VmVCnpau61C5NlK5Upk
         AcAUXYPPSJLGgPdV4StGXUqxE2vSJ9j7vX+OPhYPP0o5jGB0G2mh7jctAv5fOW6GGW/9
         1/tLzoECSdAuPbXyyZ2Xq0tUdmb0M3fX8bFD3cnGXfbcCpQHymsUWfkAqRdjO8mRc1pk
         SYFg==
X-Gm-Message-State: AOAM532eMqENF0rBnqQUpjnUOI9oy4c6i75fMMS8VWrlA+D/lrxHmEJZ
        mmIJza7PPtAZjcYQJI26AG9AXcACrXCBBBl14ZY=
X-Google-Smtp-Source: ABdhPJwgCQaAOheDbfxhjKZU9u5PewuDo9BCJMn8VuvpPdms0lhHgg1qpm4Bf2NcUZeh3os13+vPKQ==
X-Received: by 2002:ac8:5ccc:: with SMTP id s12mr2339675qta.179.1604680722605;
        Fri, 06 Nov 2020 08:38:42 -0800 (PST)
Received: from localhost.localdomain (modemcable068.184-131-66.mc.videotron.ca. [66.131.184.68])
        by smtp.gmail.com with ESMTPSA id s3sm860000qkj.27.2020.11.06.08.38.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2020 08:38:41 -0800 (PST)
From:   Jonathan Marek <jonathan@marek.ca>
To:     freedreno@lists.freedesktop.org
Cc:     Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org (open list:DMA MAPPING HELPERS),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 2/5] dma-direct: add dma_direct_bypass() to force direct ops
Date:   Fri,  6 Nov 2020 11:34:31 -0500
Message-Id: <20201106163437.30836-3-jonathan@marek.ca>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20201106163437.30836-1-jonathan@marek.ca>
References: <20201106163437.30836-1-jonathan@marek.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a function to force direct ops and disable swiotlb for a deivce.

Signed-off-by: Jonathan Marek <jonathan@marek.ca>
---
 include/linux/dma-direct.h |  9 +++++++++
 kernel/dma/direct.c        | 23 +++++++++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/include/linux/dma-direct.h b/include/linux/dma-direct.h
index 18aade195884..41f57e1b7aa5 100644
--- a/include/linux/dma-direct.h
+++ b/include/linux/dma-direct.h
@@ -124,4 +124,13 @@ int dma_direct_supported(struct device *dev, u64 mask);
 dma_addr_t dma_direct_map_resource(struct device *dev, phys_addr_t paddr,
 		size_t size, enum dma_data_direction dir, unsigned long attrs);
 
+#if IS_ENABLED(CONFIG_DMA_OPS_BYPASS) && !IS_ENABLED(CONFIG_ARCH_HAS_FORCE_DMA_UNENCRYPTED)
+int dma_direct_bypass(struct device *dev);
+#else
+static inline int dma_direct_bypass(struct device *dev)
+{
+	return -EIO;
+}
+#endif
+
 #endif /* _LINUX_DMA_DIRECT_H */
diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 06c111544f61..304a5a77cccb 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -548,3 +548,26 @@ int dma_direct_set_offset(struct device *dev, phys_addr_t cpu_start,
 	return 0;
 }
 EXPORT_SYMBOL_GPL(dma_direct_set_offset);
+
+/**
+ * dma_direct_bypass - always use direct mapping path for device
+ * @dev:	device pointer
+ *
+ * Note: this also bypasses swiotlb. Not available for arch with
+ * force_dma_unencrypted(), since this doesn't deal with that.
+ */
+#if IS_ENABLED(CONFIG_DMA_OPS_BYPASS) && !IS_ENABLED(CONFIG_ARCH_HAS_FORCE_DMA_UNENCRYPTED)
+int dma_direct_bypass(struct device *dev)
+{
+	int ret;
+
+	ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64));
+	if (ret)
+		return ret;
+
+	dev->bus_dma_limit = DMA_BIT_MASK(64);
+	dev->dma_ops_bypass = true;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(dma_direct_bypass);
+#endif
-- 
2.26.1

