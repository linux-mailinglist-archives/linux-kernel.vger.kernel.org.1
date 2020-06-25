Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF61220A142
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jun 2020 16:52:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405540AbgFYOwh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Jun 2020 10:52:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405463AbgFYOwb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 10:52:31 -0400
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43315C08C5DC
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 07:52:31 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 68DE8366; Thu, 25 Jun 2020 16:52:28 +0200 (CEST)
From:   Joerg Roedel <joro@8bytes.org>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Qian Cai <cai@lca.pw>, Joerg Roedel <jroedel@suse.de>
Subject: [PATCH 1/2] iommu/amd: Add helper functions to update domain->pt_root
Date:   Thu, 25 Jun 2020 16:52:26 +0200
Message-Id: <20200625145227.4159-2-joro@8bytes.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200625145227.4159-1-joro@8bytes.org>
References: <20200625145227.4159-1-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joerg Roedel <jroedel@suse.de>

Do not call atomic64_set() directly to update the domain page-table
root and use two new helper functions.

This makes it easier to implement additional work necessary when
the page-table is updated.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/iommu/amd/iommu.c | 31 ++++++++++++++++++++-----------
 1 file changed, 20 insertions(+), 11 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 74cca1757172..5286ddcfc2f9 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -162,7 +162,18 @@ static void amd_iommu_domain_get_pgtable(struct protection_domain *domain,
 	pgtable->mode = pt_root & 7; /* lowest 3 bits encode pgtable mode */
 }
 
-static u64 amd_iommu_domain_encode_pgtable(u64 *root, int mode)
+static void amd_iommu_domain_set_pt_root(struct protection_domain *domain, u64 root)
+{
+	atomic64_set(&domain->pt_root, root);
+}
+
+static void amd_iommu_domain_clr_pt_root(struct protection_domain *domain)
+{
+	amd_iommu_domain_set_pt_root(domain, 0);
+}
+
+static void amd_iommu_domain_set_pgtable(struct protection_domain *domain,
+					 u64 *root, int mode)
 {
 	u64 pt_root;
 
@@ -170,7 +181,7 @@ static u64 amd_iommu_domain_encode_pgtable(u64 *root, int mode)
 	pt_root = mode & 7;
 	pt_root |= (u64)root;
 
-	return pt_root;
+	amd_iommu_domain_set_pt_root(domain, pt_root);
 }
 
 static struct iommu_dev_data *alloc_dev_data(u16 devid)
@@ -1410,7 +1421,7 @@ static bool increase_address_space(struct protection_domain *domain,
 	struct domain_pgtable pgtable;
 	unsigned long flags;
 	bool ret = true;
-	u64 *pte, root;
+	u64 *pte;
 
 	spin_lock_irqsave(&domain->lock, flags);
 
@@ -1438,8 +1449,7 @@ static bool increase_address_space(struct protection_domain *domain,
 	 * Device Table needs to be updated and flushed before the new root can
 	 * be published.
 	 */
-	root = amd_iommu_domain_encode_pgtable(pte, pgtable.mode);
-	atomic64_set(&domain->pt_root, root);
+	amd_iommu_domain_set_pgtable(domain, pte, pgtable.mode);
 
 	ret = true;
 
@@ -2319,7 +2329,7 @@ static void protection_domain_free(struct protection_domain *domain)
 		domain_id_free(domain->id);
 
 	amd_iommu_domain_get_pgtable(domain, &pgtable);
-	atomic64_set(&domain->pt_root, 0);
+	amd_iommu_domain_clr_pt_root(domain);
 	free_pagetable(&pgtable);
 
 	kfree(domain);
@@ -2327,7 +2337,7 @@ static void protection_domain_free(struct protection_domain *domain)
 
 static int protection_domain_init(struct protection_domain *domain, int mode)
 {
-	u64 *pt_root = NULL, root;
+	u64 *pt_root = NULL;
 
 	BUG_ON(mode < PAGE_MODE_NONE || mode > PAGE_MODE_6_LEVEL);
 
@@ -2343,8 +2353,7 @@ static int protection_domain_init(struct protection_domain *domain, int mode)
 			return -ENOMEM;
 	}
 
-	root = amd_iommu_domain_encode_pgtable(pt_root, mode);
-	atomic64_set(&domain->pt_root, root);
+	amd_iommu_domain_set_pgtable(domain, pt_root, mode);
 
 	return 0;
 }
@@ -2713,8 +2722,8 @@ void amd_iommu_domain_direct_map(struct iommu_domain *dom)
 	/* First save pgtable configuration*/
 	amd_iommu_domain_get_pgtable(domain, &pgtable);
 
-	/* Update data structure */
-	atomic64_set(&domain->pt_root, 0);
+	/* Remove page-table from domain */
+	amd_iommu_domain_clr_pt_root(domain);
 
 	/* Make changes visible to IOMMUs */
 	update_domain(domain);
-- 
2.27.0

