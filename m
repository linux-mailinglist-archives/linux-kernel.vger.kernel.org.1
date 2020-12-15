Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74F572DA8A3
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 08:38:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbgLOHg1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 02:36:27 -0500
Received: from mail-eopbgr680050.outbound.protection.outlook.com ([40.107.68.50]:40678
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726206AbgLOHfq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 02:35:46 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YALSaQXLmMrs3B0gdA5nysqTp600CkQxopaJMNgx7TxD9dIiYBlcduby06dvtKyTrdayBG4tVtmDbcb0rGxAWwi1L16n+VfE3ah+bbyVtpUL2Wf/FgBAsYx3BlRuEXjWc5lxvzPMq8mEwBR/qkUGZvxDGkJtDOkKJVtUctH75UMdxiiHo9ge8aHn0Se32ZlVoootlwQTtbdsaJtMXyBrRv/yfZtNLR5IV6PYGIhE0uIWvmxymunrVCtQC8aW3/OElt5DpnQhvOyjMk0bv4JXQ+684fb0phfE9IPA1qakCfTKUpBZFrqkEhcmDG01vBQC7Rh4sZdWQn6ikD8TGaL67w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9OSDVS4aibL5BRuHy0kYyXyjUbBADJuiY2tcB0jCvTs=;
 b=m+yxpvk3b0SR/CvvF9AHpJJmC2l2NUGr13/3Npu3hv0bm/F36gc+QuFohYK6sDtqN9/79HWVFYf4wYWM3CikZ6xIDKggz+rWvo5K8xWDbWV99Q2lYqDsuZr/4RnVd99Bxtbf8joCDtMqRKPxidX+VAJQHbaNO4PmtCAKkSh8SSxxfpRyJkg1VIY1U1jbI401LNJFfBoxoP02s1meSN05Y2W9MHbVO7Kd8fh1AWzmHXx+CyoQI+0c1E47Z3xc2C3fvkWQNQf+1JTlil308CRB7ST5Cej8D5jF+s45ZxkikROuG6kYx81cX1qYmVwcq1LGB5GrQ97B76a3rDApPj7d0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9OSDVS4aibL5BRuHy0kYyXyjUbBADJuiY2tcB0jCvTs=;
 b=PE+YYsv7djmT+5LHmE9nDvRp4l2G5TkedtfaKdpuJTEhUYTepE/eKKC7y/gkcskKF6iv4mGOmZnkR3N55sMY4GSUAL9kpHgdqSsgHGgap6HdngGZCNyADKNxah4Td4meDpoiwql4Ltb5+mgPE7Qk+FletGlFQdwuIEk9PWqxc0I=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4597.namprd12.prod.outlook.com (2603:10b6:a03:10b::14)
 by BYAPR12MB3127.namprd12.prod.outlook.com (2603:10b6:a03:d8::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.15; Tue, 15 Dec
 2020 07:34:48 +0000
Received: from BYAPR12MB4597.namprd12.prod.outlook.com
 ([fe80::dd10:efd2:e325:53c7]) by BYAPR12MB4597.namprd12.prod.outlook.com
 ([fe80::dd10:efd2:e325:53c7%3]) with mapi id 15.20.3654.021; Tue, 15 Dec 2020
 07:34:48 +0000
From:   Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Cc:     joro@8bytes.org, will@kernel.org,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH v4 09/13] iommu/amd: Rename variables to be consistent with struct io_pgtable_ops
Date:   Tue, 15 Dec 2020 01:37:01 -0600
Message-Id: <20201215073705.123786-10-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201215073705.123786-1-suravee.suthikulpanit@amd.com>
References: <20201215073705.123786-1-suravee.suthikulpanit@amd.com>
Content-Type: text/plain
X-Originating-IP: [165.204.78.2]
X-ClientProxiedBy: SN2PR01CA0060.prod.exchangelabs.com (2603:10b6:800::28) To
 BYAPR12MB4597.namprd12.prod.outlook.com (2603:10b6:a03:10b::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ethanolx5673host.amd.com (165.204.78.2) by SN2PR01CA0060.prod.exchangelabs.com (2603:10b6:800::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12 via Frontend Transport; Tue, 15 Dec 2020 07:34:47 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3bb4f9ff-9b1f-40a7-e462-08d8a0cbe700
X-MS-TrafficTypeDiagnostic: BYAPR12MB3127:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB31270630B6D5CF5D4D40FD60F3C60@BYAPR12MB3127.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:120;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NsVlldp9ITiUKvmq7/7O4OU2HnByauBwlEdc/sRK8+xchHz7+BvEEHjoSFwzOVIvYRB/1x/v/YsOib8D/QhsGPnvp+d4Ld4JXot/7YBUx50ATR6RXNgTp8QQVQTafjbJp030RD/mCsxGHTN9XV/vD1gXC1ICDx0KclILQ/0uG0yFBOi1e5oD2aySW4R5NEhkkPXrKVfouzlv6yyYpc9i1+tey2AdOLREO6xFqORcdwO3gQzBNZduL+/28vyquD/sP2AcPXRt6VN0L34TtJfJ/KSGzFOQ9I0gXFYdErXUh7/lIJnn0sElPxqcijAKaLmh36xtKQsh+SubTyvjMUXK+cRuTsRK6epRIb71kl+XavYCx/rD5asnJaUCAPwGRNbN
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4597.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(346002)(376002)(66556008)(66476007)(66946007)(6486002)(34490700003)(2906002)(186003)(4326008)(508600001)(8676002)(956004)(6666004)(86362001)(2616005)(52116002)(7696005)(44832011)(36756003)(1076003)(5660300002)(16526019)(26005)(8936002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?YK1fevTxjoeC9FjHu9bn2feAOOnhYP9BjcKbzY0WcQ7wTRLEgs7/GHt7ccG2?=
 =?us-ascii?Q?oBisGZWFWCWgHUztHBz+KtZWul1aiiewRYgQuQ6BDesIYPnPEhHC+roBYXn/?=
 =?us-ascii?Q?RZD3V86dhIgczibWYvHdYqlo2cMbVyYDZbHQNZLFMhFUOXDpznyxjEbSX8X4?=
 =?us-ascii?Q?d/iKT16HHes70pgm8f+Vpj1gBfumgSL1elU3M7Ae/Rw1UM92KMtZMn8DJwQV?=
 =?us-ascii?Q?2KVKe1zTf0RpWEp5rs7IPJfC7VpcAF+cVCPvxFuQbRQDrOEm1Wq5rtyNYb+3?=
 =?us-ascii?Q?zf0vFar7jNMU3QZebfmIOD3yLckCsnaxeR8GvmiMV5VZltez35dyRuJb35dv?=
 =?us-ascii?Q?Y3fwsALzlBDceg0FDfCIkNK4PyJ8TbpscpxpdWNqDReUsD7vRbjb3oOc7H+r?=
 =?us-ascii?Q?YAPJSSZ9wCixPmo+DuIvWdXoTDKhWGiKFqa6n5yGDJ5z0wOVZc0xA/c0J6Rs?=
 =?us-ascii?Q?ci10JYLi/0PO99sWLuYoLpz3dEiZuT3Z3BxFz93cKzXjeUkg48BnUTOU9FsN?=
 =?us-ascii?Q?82+gg2bBms5OdEsGGIc77effb75lZO7wsbwEXoaH7VrUVp62dKn6+GfCjm0l?=
 =?us-ascii?Q?yjINKmigo+R0V17H6L2eSiPf1xWuU0PcTG6/osu2nuN5eC46QfJs8fUSXLjv?=
 =?us-ascii?Q?KqEw9oGTgI+VzXOh5k/HrBCYxoVbLnQRJH5L8nBBoL128N3MN1um86QtNFCv?=
 =?us-ascii?Q?jAxSSX81ruFQTgUZwx/DKYgAC+NEhoq3CGeX4M8qSITykNwLMNTK/qheRQAS?=
 =?us-ascii?Q?LWFi+20SEMVkPPY/FcXqzLU/SUlD8leuAmEj+RyaT30Hs0a9pw5KXm7Ed+fP?=
 =?us-ascii?Q?okoVP4gvgKLw2vHhzPUzPeQAuPZrx0/tJdRvvV604dZd/evlt//4Cs2yb6Z0?=
 =?us-ascii?Q?F/xhjib3AyhHpxjbKSWKE6I0CFzS8oFQDzuv8iCiWdsDmkpK4bSggP18Q9Ov?=
 =?us-ascii?Q?XoCXEJHMhNPgYQ5pXwyEzZZh5RlE4s2iojSpeDaM/3r5d/YDNub6kFsWRnFn?=
 =?us-ascii?Q?GrGm?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4597.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2020 07:34:48.5306
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bb4f9ff-9b1f-40a7-e462-08d8a0cbe700
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FHNm97pDUpbqYVVIA1ZM6wQcSFvuMCL7q7AgcOIR8s1bXkiT1zBAyMksOG+gHbcNlkE80cxoAwJMRelhlVmXFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3127
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no functional change.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/io_pgtable.c | 31 +++++++++++++++----------------
 1 file changed, 15 insertions(+), 16 deletions(-)

diff --git a/drivers/iommu/amd/io_pgtable.c b/drivers/iommu/amd/io_pgtable.c
index d4d131e43dcd..35dd9153e6b7 100644
--- a/drivers/iommu/amd/io_pgtable.c
+++ b/drivers/iommu/amd/io_pgtable.c
@@ -393,9 +393,9 @@ static struct page *free_clear_pte(u64 *pte, u64 pteval, struct page *freelist)
  * and full 64 bit address spaces.
  */
 int iommu_map_page(struct protection_domain *dom,
-		   unsigned long bus_addr,
-		   unsigned long phys_addr,
-		   unsigned long page_size,
+		   unsigned long iova,
+		   unsigned long paddr,
+		   unsigned long size,
 		   int prot,
 		   gfp_t gfp)
 {
@@ -404,15 +404,15 @@ int iommu_map_page(struct protection_domain *dom,
 	u64 __pte, *pte;
 	int ret, i, count;
 
-	BUG_ON(!IS_ALIGNED(bus_addr, page_size));
-	BUG_ON(!IS_ALIGNED(phys_addr, page_size));
+	BUG_ON(!IS_ALIGNED(iova, size));
+	BUG_ON(!IS_ALIGNED(paddr, size));
 
 	ret = -EINVAL;
 	if (!(prot & IOMMU_PROT_MASK))
 		goto out;
 
-	count = PAGE_SIZE_PTE_COUNT(page_size);
-	pte   = alloc_pte(dom, bus_addr, page_size, NULL, gfp, &updated);
+	count = PAGE_SIZE_PTE_COUNT(size);
+	pte   = alloc_pte(dom, iova, size, NULL, gfp, &updated);
 
 	ret = -ENOMEM;
 	if (!pte)
@@ -425,10 +425,10 @@ int iommu_map_page(struct protection_domain *dom,
 		updated = true;
 
 	if (count > 1) {
-		__pte = PAGE_SIZE_PTE(__sme_set(phys_addr), page_size);
+		__pte = PAGE_SIZE_PTE(__sme_set(paddr), size);
 		__pte |= PM_LEVEL_ENC(7) | IOMMU_PTE_PR | IOMMU_PTE_FC;
 	} else
-		__pte = __sme_set(phys_addr) | IOMMU_PTE_PR | IOMMU_PTE_FC;
+		__pte = __sme_set(paddr) | IOMMU_PTE_PR | IOMMU_PTE_FC;
 
 	if (prot & IOMMU_PROT_IR)
 		__pte |= IOMMU_PTE_IR;
@@ -462,20 +462,19 @@ int iommu_map_page(struct protection_domain *dom,
 }
 
 unsigned long iommu_unmap_page(struct protection_domain *dom,
-			       unsigned long bus_addr,
-			       unsigned long page_size)
+			       unsigned long iova,
+			       unsigned long size)
 {
 	unsigned long long unmapped;
 	unsigned long unmap_size;
 	u64 *pte;
 
-	BUG_ON(!is_power_of_2(page_size));
+	BUG_ON(!is_power_of_2(size));
 
 	unmapped = 0;
 
-	while (unmapped < page_size) {
-
-		pte = fetch_pte(dom, bus_addr, &unmap_size);
+	while (unmapped < size) {
+		pte = fetch_pte(dom, iova, &unmap_size);
 
 		if (pte) {
 			int i, count;
@@ -485,7 +484,7 @@ unsigned long iommu_unmap_page(struct protection_domain *dom,
 				pte[i] = 0ULL;
 		}
 
-		bus_addr  = (bus_addr & ~(unmap_size - 1)) + unmap_size;
+		iova = (iova & ~(unmap_size - 1)) + unmap_size;
 		unmapped += unmap_size;
 	}
 
-- 
2.17.1

