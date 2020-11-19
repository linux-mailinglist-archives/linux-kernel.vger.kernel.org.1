Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 089A02B8B8B
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 07:21:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726420AbgKSGTS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 01:19:18 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:40137 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726224AbgKSGTS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 01:19:18 -0500
X-UUID: c699f1342b924e3fb40ede5a158461b5-20201119
X-UUID: c699f1342b924e3fb40ede5a158461b5-20201119
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1858901902; Thu, 19 Nov 2020 14:19:14 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 19 Nov 2020 14:19:12 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 19 Nov 2020 14:19:11 +0800
From:   Yong Wu <yong.wu@mediatek.com>
To:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Tomasz Figa <tfiga@google.com>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>, <yong.wu@mediatek.com>,
        <youlin.pei@mediatek.com>, Nicolas Boichat <drinkcat@chromium.org>,
        <anan.sun@mediatek.com>, <chao.hao@mediatek.com>,
        <jun.wen@mediatek.com>
Subject: [PATCH v2 4/6] iommu: Add granule_ignore when tlb gather
Date:   Thu, 19 Nov 2020 14:18:34 +0800
Message-ID: <20201119061836.15238-5-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20201119061836.15238-1-yong.wu@mediatek.com>
References: <20201119061836.15238-1-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a granule_ignore option when tlb gather for some HW which don't care
about granule when it flush tlb.

Signed-off-by: Yong Wu <yong.wu@mediatek.com>
---
 include/linux/iommu.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 794d4085edd3..1aad32238510 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -171,6 +171,7 @@ enum iommu_dev_features {
  * @start: IOVA representing the start of the range to be flushed
  * @end: IOVA representing the end of the range to be flushed (exclusive)
  * @pgsize: The interval at which to perform the flush
+ * @granule_ignore: For tlb flushing that could be regardless of granule.
  *
  * This structure is intended to be updated by multiple calls to the
  * ->unmap() function in struct iommu_ops before eventually being passed
@@ -180,6 +181,7 @@ struct iommu_iotlb_gather {
 	unsigned long		start;
 	unsigned long		end;
 	size_t			pgsize;
+	bool			granule_ignore;
 };
 
 /**
@@ -544,7 +546,7 @@ static inline void iommu_iotlb_gather_add_page(struct iommu_domain *domain,
 	 * a different granularity, then sync the TLB so that the gather
 	 * structure can be rewritten.
 	 */
-	if (gather->pgsize != size ||
+	if ((!gather->granule_ignore && gather->pgsize != size) ||
 	    end < gather->start || start > gather->end) {
 		if (gather->pgsize)
 			iommu_iotlb_sync(domain, gather);
-- 
2.18.0

