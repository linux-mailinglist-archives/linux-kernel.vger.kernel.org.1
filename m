Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CDF5298CD9
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 13:26:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1775093AbgJZM0l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 08:26:41 -0400
Received: from foss.arm.com ([217.140.110.172]:37510 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2442309AbgJZMYm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 08:24:42 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BF6E91477;
        Mon, 26 Oct 2020 05:24:41 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 12F183F719;
        Mon, 26 Oct 2020 05:24:40 -0700 (PDT)
From:   Robin Murphy <robin.murphy@arm.com>
To:     hch@lst.de
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        song.bao.hua@hisilicon.com
Subject: [PATCH] dma: Per-NUMA-node CMA should depend on NUMA
Date:   Mon, 26 Oct 2020 12:24:35 +0000
Message-Id: <74b66725883f065eb7d156f866678abb5be934bd.1603714996.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.28.0.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Offering DMA_PERNUMA_CMA to non-NUMA configs is pointless.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 kernel/dma/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/dma/Kconfig b/kernel/dma/Kconfig
index c99de4a21458..964b74c9b7e3 100644
--- a/kernel/dma/Kconfig
+++ b/kernel/dma/Kconfig
@@ -125,7 +125,8 @@ if  DMA_CMA
 
 config DMA_PERNUMA_CMA
 	bool "Enable separate DMA Contiguous Memory Area for each NUMA Node"
-	default NUMA && ARM64
+	depends on NUMA
+	default ARM64
 	help
 	  Enable this option to get pernuma CMA areas so that devices like
 	  ARM64 SMMU can get local memory by DMA coherent APIs.
-- 
2.28.0.dirty

