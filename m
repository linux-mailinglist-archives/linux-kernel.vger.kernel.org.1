Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A19101D3038
	for <lists+linux-kernel@lfdr.de>; Thu, 14 May 2020 14:46:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726551AbgENMq0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 May 2020 08:46:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726087AbgENMqZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 08:46:25 -0400
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03FDCC061A0E
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 05:46:24 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id AD2E5273; Thu, 14 May 2020 14:46:22 +0200 (CEST)
From:   Joerg Roedel <joro@8bytes.org>
To:     Maxime Ripard <mripard@kernel.org>
Cc:     Chen-Yu Tsai <wens@csie.org>, iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        joro@8bytes.org, jroedel@suse.de, Maxime Ripard <maxime@cerno.tech>
Subject: [PATCH 2/2] iommu/sun50i: Use __GFP_ZERO instead of memset()
Date:   Thu, 14 May 2020 14:46:21 +0200
Message-Id: <20200514124621.25999-2-joro@8bytes.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200514124621.25999-1-joro@8bytes.org>
References: <20200514124621.25999-1-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joerg Roedel <jroedel@suse.de>

Allocate zeroed memory so there is no need to memset it to 0 in the
driver.

Cc: Maxime Ripard <maxime@cerno.tech>
Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/iommu/sun50i-iommu.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iommu/sun50i-iommu.c b/drivers/iommu/sun50i-iommu.c
index a52f52eff7c8..9c763d4a8e2a 100644
--- a/drivers/iommu/sun50i-iommu.c
+++ b/drivers/iommu/sun50i-iommu.c
@@ -616,11 +616,10 @@ static struct iommu_domain *sun50i_iommu_domain_alloc(unsigned type)
 	    iommu_get_dma_cookie(&sun50i_domain->domain))
 		goto err_free_domain;
 
-	sun50i_domain->dt = (u32 *)__get_free_pages(GFP_KERNEL,
+	sun50i_domain->dt = (u32 *)__get_free_pages(GFP_KERNEL | __GFP_ZERO,
 						    get_order(DT_SIZE));
 	if (!sun50i_domain->dt)
 		goto err_put_cookie;
-	memset(sun50i_domain->dt, 0, DT_SIZE);
 
 	refcount_set(&sun50i_domain->refcnt, 1);
 
-- 
2.17.1

