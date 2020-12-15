Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 621BF2DA89D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 08:37:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726217AbgLOHh2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 02:37:28 -0500
Received: from mail-mw2nam10on2064.outbound.protection.outlook.com ([40.107.94.64]:8419
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726808AbgLOHgk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 02:36:40 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SOlGArJz4MMn1wTDA2St+pYpCAOpuuubtpi8ySNTxPgtOV3StINz4Di0wyhBkisvUVRf0ugtep3umOmaYrhOAgMMOIFDMerxRIYlv0XPprVR7odUkqHei92jtfNjElL2GSwJPbmSqvfckW6yvQgt5ITT9PZdvNv9QtxMVyqh1gzPUwN8sb9WkikmGNiay86i4QDO9Y9ztQlAVmiZc64Lto0VqcoXWOBHoroPyThfewCf3KZ1vdXlpwu00kQD5uWDcJvm7up5RW5y+E6EC2tMruQXp8cnchBKyw3orojiMAkTEbImcxTiuyGm1JbSHSKx5WQRlk4uEBgTchIAjabkjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1giUsa8uusMFoA9pKyG9rlFqSt1rBPhbqKritxCmkMQ=;
 b=Y6Qh+fVMtasVa8hlIEaiN08ZQAq8gLkijZFUNwDaNi90ZFh+zVjqsAkfViPzs0XIZnWd/OnkdEEy44zvfWm+BTvyv2+ixCjrlztt2Ug19kMWtJXTVnlcVkdl6GV8PR+z6WcezD9VtHayaGudGkf4IcRWBtLhjl0i5wvgwTH39YmuAaZ+Rny3ewJEMoRA6i0uu+WRjmtMDI/2RJQi3OmTQpO8maqMvUf+FkmaGyQYPQJDgz1Lum9/J4gmk3tu0iV9JlC9qCjRuPB6XiAEEa3bM1P4VwwV4utZREAs4Ty+kE9LmsGURud0JWQ2jdlikzsETqsNwFxiw8/mUv+ZPQdxIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1giUsa8uusMFoA9pKyG9rlFqSt1rBPhbqKritxCmkMQ=;
 b=tVWQTzbPwnB3kgZxsiBbxCSt7sZ8/IsMFH8PVtW83YhyhGAuH9IGkM8hfFB+mTM2CBr+lpaS5p9SY/S6ljue9NgT2efP8GsK2ATifccUJ4kp9mCKwl1e3RXiTBv6fkpo7AyR2ht6d/GoTRvcwIuTWqBfeJmosVWb7gdENCXLPWE=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4597.namprd12.prod.outlook.com (2603:10b6:a03:10b::14)
 by BY5PR12MB3794.namprd12.prod.outlook.com (2603:10b6:a03:1aa::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12; Tue, 15 Dec
 2020 07:34:46 +0000
Received: from BYAPR12MB4597.namprd12.prod.outlook.com
 ([fe80::dd10:efd2:e325:53c7]) by BYAPR12MB4597.namprd12.prod.outlook.com
 ([fe80::dd10:efd2:e325:53c7%3]) with mapi id 15.20.3654.021; Tue, 15 Dec 2020
 07:34:46 +0000
From:   Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Cc:     joro@8bytes.org, will@kernel.org,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH v4 07/13] iommu/amd: Restructure code for freeing page table
Date:   Tue, 15 Dec 2020 01:36:59 -0600
Message-Id: <20201215073705.123786-8-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201215073705.123786-1-suravee.suthikulpanit@amd.com>
References: <20201215073705.123786-1-suravee.suthikulpanit@amd.com>
Content-Type: text/plain
X-Originating-IP: [165.204.78.2]
X-ClientProxiedBy: SN2PR01CA0060.prod.exchangelabs.com (2603:10b6:800::28) To
 BYAPR12MB4597.namprd12.prod.outlook.com (2603:10b6:a03:10b::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ethanolx5673host.amd.com (165.204.78.2) by SN2PR01CA0060.prod.exchangelabs.com (2603:10b6:800::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12 via Frontend Transport; Tue, 15 Dec 2020 07:34:45 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c6e00ddd-d9c1-4f03-f30e-08d8a0cbe5eb
X-MS-TrafficTypeDiagnostic: BY5PR12MB3794:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR12MB3794B964A31A8C5FDFB979FCF3C60@BY5PR12MB3794.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ekj93gikyAxPKFBaDVR7arowasnT1tRVnS7Pfzrc8FHs0RhCZudU0mv/nPZJLeBTg5wvgRAvrSpi5joDrSn//9C34t2FFjQk3t628vkur1t6EAW14S7CALH+PHc3SpKSfc3SfgR/tVetK4ttgkeNFMRbEMbFVSbWRfDpctPFbZFMlNng6vp1IbS+mc3uVfpe0TsBbmTjaxl1J+av8piG/O1+T2Fwa0CXviBcQr0CDWuFwJoiZ0ZL3f91/RnBFB7VTnXDEYZBJo51WZ6MRLoE54VB5dZffV0biUL4eX4Ez9Dy/BvwHj2/BZUhjnrPHfGc3DKg/S7SEKiKbnMQtqxqG7oVWvomTZi8S+iEaBmjv0e8oD65b9IVXDjUOq3Qh0EH
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4597.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(346002)(376002)(6666004)(2616005)(66556008)(16526019)(86362001)(956004)(66946007)(6486002)(34490700003)(26005)(52116002)(186003)(66476007)(1076003)(7696005)(36756003)(83380400001)(5660300002)(44832011)(2906002)(8676002)(508600001)(8936002)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?TH/l+qTO3wB825zrxF8xDmGj8XBBp5GshyMo+8HybqHoXU0NcNInQzW1F1f9?=
 =?us-ascii?Q?6ExlDOcnqmcTpeaKW2KbbXkQuHI1DJ02/iK5PHQ9IB9AjZtB4ZDWBx14trXw?=
 =?us-ascii?Q?hQKGt1ontonOd0d5ghe5AsJ8QlLxTECRNUAA4CY0CtbfKQd8QhbzXPxiaQSd?=
 =?us-ascii?Q?siEb+3gQ0ZG0q3QrKxDdTzrmhwkrNpTINTBjA2bsUmft8Bv/NGEEdMwCEFJb?=
 =?us-ascii?Q?RzCKj/rMnnuCXTlaMpGNex7YwT9wrs1WtBW2rzug8tZgiBO2QV2xk7z8AtB0?=
 =?us-ascii?Q?FgDkb6rq7qscno3mZXVJLLeu1zW6FtLYLkVf3mvyxMcsD+F+Ji9ITKQ53Km/?=
 =?us-ascii?Q?LjBw27SxDdCRV3jem/yoaHU4rOq4IQDjrwmtaSCMNl/1HhpjFri8UbKpkzUp?=
 =?us-ascii?Q?Ovnc6LPRyUxgsi3if7F0n5qAkDVpd3eSeKqFNbFMyowzEH5jlS7IsaiiFYQ1?=
 =?us-ascii?Q?S6AFTQAjj+c4jFa5gNwRCACrJ9r0DqJv86+ioPm4IcY4ziB78xtR54Mv4pRr?=
 =?us-ascii?Q?rWau0UmnzjUtOqMpIoj3soLosRw7xrmVoRI8Xc5AbDjn+GKVJ7yLVh3O3jSQ?=
 =?us-ascii?Q?T3dUpFI0FvdhpHx0XnQAgJbuecSJnY3FPposlRlcYfAmjOb/lAXGGhpqDT8N?=
 =?us-ascii?Q?qDsp6osxOt+skkUpQHeHJQLK7smMnD3FPr/m5yS/fhrZTXpExSExVPvFNbVz?=
 =?us-ascii?Q?Gy/jPUopD/1icUogY+tzP9/XokdyZEafITOI4WqUTGzF7aF103MaATCzu+lG?=
 =?us-ascii?Q?RwI3Ntr8a8fBXZVWFG8UjhEewKLGoJWg1AUbM4AXa9huN1wMtS1cvjmTsAzF?=
 =?us-ascii?Q?bi206jWcZcnhgSdlAu+HhyUZJas3wjlP8mwEDI7ANGzg6T5Dc5Da4dEvnsY5?=
 =?us-ascii?Q?hZbySzm9+/GER/q9Wk63fjxuWiz+N5O+kF14bzN+AadnttWkc25Z0IO0lRHo?=
 =?us-ascii?Q?YMtQuOIpGjDj9lHxXogX05Mdc/oGAuk9P1lwLzb8jHPAVQ4PT8LRb4DpeggM?=
 =?us-ascii?Q?ef8x?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4597.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2020 07:34:46.7407
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: c6e00ddd-d9c1-4f03-f30e-08d8a0cbe5eb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ewa+jg9Ih7DL950pUSo3618D4V5BmH/UT5Bgh6TIY197V/KtV9uWiFdnqdlb1uUd2fkZL9gckubBjgtzCPv2GQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3794
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By consolidate logic into v1_free_pgtable helper function,
which is called from IO page table framework.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu.h  |  1 -
 drivers/iommu/amd/io_pgtable.c | 41 ++++++++++++++++++++--------------
 drivers/iommu/amd/iommu.c      | 21 ++++-------------
 3 files changed, 28 insertions(+), 35 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index 1bad42a3c73c..91d098003f12 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -132,7 +132,6 @@ static inline void amd_iommu_apply_ivrs_quirks(void) { }
 #endif
 
 /* TODO: These are temporary and will be removed once fully transition */
-extern void free_pagetable(struct domain_pgtable *pgtable);
 extern int iommu_map_page(struct protection_domain *dom,
 			  unsigned long bus_addr,
 			  unsigned long phys_addr,
diff --git a/drivers/iommu/amd/io_pgtable.c b/drivers/iommu/amd/io_pgtable.c
index 345e9bc81fde..dc674e79ddf0 100644
--- a/drivers/iommu/amd/io_pgtable.c
+++ b/drivers/iommu/amd/io_pgtable.c
@@ -163,23 +163,6 @@ static struct page *free_sub_pt(unsigned long root, int mode,
 	return freelist;
 }
 
-void free_pagetable(struct domain_pgtable *pgtable)
-{
-	struct page *freelist = NULL;
-	unsigned long root;
-
-	if (pgtable->mode == PAGE_MODE_NONE)
-		return;
-
-	BUG_ON(pgtable->mode < PAGE_MODE_NONE ||
-	       pgtable->mode > PAGE_MODE_6_LEVEL);
-
-	root = (unsigned long)pgtable->root;
-	freelist = free_sub_pt(root, pgtable->mode, freelist);
-
-	free_page_list(freelist);
-}
-
 void amd_iommu_domain_set_pgtable(struct protection_domain *domain,
 				  u64 *root, int mode)
 {
@@ -528,6 +511,30 @@ unsigned long iommu_unmap_page(struct protection_domain *dom,
  */
 static void v1_free_pgtable(struct io_pgtable *iop)
 {
+	struct amd_io_pgtable *pgtable = container_of(iop, struct amd_io_pgtable, iop);
+	struct protection_domain *dom;
+	struct page *freelist = NULL;
+	unsigned long root;
+
+	if (pgtable->mode == PAGE_MODE_NONE)
+		return;
+
+	dom = container_of(pgtable, struct protection_domain, iop);
+
+	/* Update data structure */
+	amd_iommu_domain_clr_pt_root(dom);
+
+	/* Make changes visible to IOMMUs */
+	amd_iommu_domain_update(dom);
+
+	/* Page-table is not visible to IOMMU anymore, so free it */
+	BUG_ON(pgtable->mode < PAGE_MODE_NONE ||
+	       pgtable->mode > PAGE_MODE_6_LEVEL);
+
+	root = (unsigned long)pgtable->root;
+	freelist = free_sub_pt(root, pgtable->mode, freelist);
+
+	free_page_list(freelist);
 }
 
 static struct io_pgtable *v1_alloc_pgtable(struct io_pgtable_cfg *cfg, void *cookie)
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index e823acccc457..37ecedce2c14 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1903,17 +1903,14 @@ static void cleanup_domain(struct protection_domain *domain)
 
 static void protection_domain_free(struct protection_domain *domain)
 {
-	struct domain_pgtable pgtable;
-
 	if (!domain)
 		return;
 
 	if (domain->id)
 		domain_id_free(domain->id);
 
-	amd_iommu_domain_get_pgtable(domain, &pgtable);
-	amd_iommu_domain_clr_pt_root(domain);
-	free_pagetable(&pgtable);
+	if (domain->iop.pgtbl_cfg.tlb)
+		free_io_pgtable_ops(&domain->iop.iop.ops);
 
 	kfree(domain);
 }
@@ -2302,22 +2299,12 @@ EXPORT_SYMBOL(amd_iommu_unregister_ppr_notifier);
 void amd_iommu_domain_direct_map(struct iommu_domain *dom)
 {
 	struct protection_domain *domain = to_pdomain(dom);
-	struct domain_pgtable pgtable;
 	unsigned long flags;
 
 	spin_lock_irqsave(&domain->lock, flags);
 
-	/* First save pgtable configuration*/
-	amd_iommu_domain_get_pgtable(domain, &pgtable);
-
-	/* Remove page-table from domain */
-	amd_iommu_domain_clr_pt_root(domain);
-
-	/* Make changes visible to IOMMUs */
-	amd_iommu_domain_update(domain);
-
-	/* Page-table is not visible to IOMMU anymore, so free it */
-	free_pagetable(&pgtable);
+	if (domain->iop.pgtbl_cfg.tlb)
+		free_io_pgtable_ops(&domain->iop.iop.ops);
 
 	spin_unlock_irqrestore(&domain->lock, flags);
 }
-- 
2.17.1

