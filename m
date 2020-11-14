Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEC432B2DDC
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Nov 2020 16:21:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbgKNPVL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Nov 2020 10:21:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726885AbgKNPVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Nov 2020 10:21:10 -0500
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74F2CC0613D1
        for <linux-kernel@vger.kernel.org>; Sat, 14 Nov 2020 07:21:08 -0800 (PST)
Received: by mail-qk1-x743.google.com with SMTP id u4so12438744qkk.10
        for <linux-kernel@vger.kernel.org>; Sat, 14 Nov 2020 07:21:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hyihr231RMubay4CbLM0CzqsU3IYdDyAVzI9nCSyEmQ=;
        b=b7SR3HvX3UB6CNFmVT1MRh/T3AbOW0rx0EaBSC6J0raX7wx7URuwvoXNL03RrNiIfA
         GdtxCFmiigylNWInfqOD1MEcs9K6nTYuEPrVCXeIfl0YXHiinU0QTGfDtg33HobVUtk2
         YMTUdLBp0Q++2LtPhu8OguQ6WxjSlF5XAtAGRdr5vk6TpZD+6TbqPeKtgI4V27RwzanU
         dqZ3dtoO1E8ZtvbzP+l/TATxTJbqVY15hOY/Z8byQheAgoJF5qDxNfaHnKbe7bY0pmHD
         EtKxqGKYknBH/SEbJITgMzc4oVE2Yw4m0Eam9pgW9FUz9YSL6b9xkzBnHa4QC0dV2/bs
         NFog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hyihr231RMubay4CbLM0CzqsU3IYdDyAVzI9nCSyEmQ=;
        b=WhFVnRfTufrqkiKf1nuragEk/FRX/+a9vtj7k8MrhWg69WCb1d/3o/ekeWosrEFOYn
         I0se+6dPiZRjovmUfSyphrhm73KFri1UtjD6AP2Iik8JzIPSA+6SOepRWwV5h7VqIZ97
         mqyqj6+kC6713U3iHBxasYiaMHGA1uWUWYHkT5ZU8H3aAe8kmDPlfMQKCscNswd/W0nY
         9N+V6CMIUnXQn6CIIZAJX8iK9dNoQnhkLwMSeHRlbINzn0BjV/TBvjvSSTROIZ+k/4nL
         jWHACK+Fm0cV9J7NJ8rBXmvDCnmvby+AOPDVEaeQxtrjwu3ubQ1OLP2ge1bFa8lwKJoi
         4E7Q==
X-Gm-Message-State: AOAM530iSWoAXmQWHv7VF1NJRlLP/WCArBI9TpKUPohn5AHLmanNEGXA
        lTTZdfUMkObX8cG/FaZLc2NvoA==
X-Google-Smtp-Source: ABdhPJzVgK6CWOkIV4kq6V0/HrLYtOKZUR5SOFvW/AyGaPBokJsqJ+1bD6K/JnISu5gV/3s+3gOJEA==
X-Received: by 2002:a05:620a:1521:: with SMTP id n1mr6768979qkk.187.1605367267658;
        Sat, 14 Nov 2020 07:21:07 -0800 (PST)
Received: from localhost.localdomain (modemcable068.184-131-66.mc.videotron.ca. [66.131.184.68])
        by smtp.gmail.com with ESMTPSA id h125sm8888368qkc.36.2020.11.14.07.21.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2020 07:21:07 -0800 (PST)
From:   Jonathan Marek <jonathan@marek.ca>
To:     freedreno@lists.freedesktop.org, hch@lst.de
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org (open list:DMA MAPPING HELPERS),
        linux-kernel@vger.kernel.org (open list)
Subject: [RESEND PATCH v2 2/5] dma-direct: add dma_direct_bypass() to force direct ops
Date:   Sat, 14 Nov 2020 10:17:10 -0500
Message-Id: <20201114151717.5369-3-jonathan@marek.ca>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20201114151717.5369-1-jonathan@marek.ca>
References: <20201114151717.5369-1-jonathan@marek.ca>
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

