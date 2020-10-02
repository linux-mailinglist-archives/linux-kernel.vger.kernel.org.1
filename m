Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6FA0281292
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 14:27:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387888AbgJBMZ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 08:25:29 -0400
Received: from mail-bn8nam12on2077.outbound.protection.outlook.com ([40.107.237.77]:46080
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388039AbgJBMZ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 08:25:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k5cz9ugHNJbK7LfWDxuFIzwucjC3/i3PZZOcKffEb0OLY3t9Rpm/R02tDlHXzvPPntmY1Hkb8LCZHLannENmUoo2O1z/VhONeykSlU4QyU99iQ6X6d/+GwH0iVwqzWgRF8WE21RcE226PQgwOE1B8HdR8wKei16sYyDHuDxn8MhF5sATE0hVWpOcDzYwPmn85QA9h8PGBABaGs1+eGuCEhDcXAiU0H5xv5xINJFL9avXXHZWJ5mcqHHFuLWavJDxgaecHyersOtB3nDV5xYoy9+bhROAv83pgZGvEQGBW+QgIx3FtrX/rE1Rf5GE3kDx4UiWJAuv2I1FuxQmSfL0QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7POSOfbx0cQG3ln8ojWaJ/gn9v5v7bNq65Hhe73CcBw=;
 b=JgXV6qL1ZWn0zywBlwjDLdSncwDh9WoPyt1OAyzm6rh95+R2Z4aWoKhFvI4z/BdfxBSb5f3sqxq1pftdUufa4UBV08A+9mMzhARVvjqZyviQxTbvVRrzrnJZSi+j3VwM+DBal7vqQfsKq8rGPsDsX40MpeVb97N/RPivO6YOoqw+Jjeq2p0n11smYx9F7lczhcdZnX7NQt/1bQEacWkyxe+LVVbWpIimzvZFF6VzpQRysiLfPjwY0Xvj/BvvyvjFjm0IoTfLEmYTa0Q8cF6TtYCwZkKSMLsAUAC8yhJ3nbqKugqoFxbV2u/nnSMqIprSBnHv4UY7WICYEcNHsjVH/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7POSOfbx0cQG3ln8ojWaJ/gn9v5v7bNq65Hhe73CcBw=;
 b=w8OD1VJg9Zew+t3Yuhn6jawHCwhCCXFLQsX0Jo9QYRzT/e7E1iOWnhq7dFUm25seppc2OThsMPIlxUCUq5yYz/8T96K0Fsy2oZkyKBfxBMdolz9kh9KV2c5sGlE3BiR0XKOPQSgKCyYLH7Pz70lJg5MXwEpqQQ7a+bx09HMT1lw=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1163.namprd12.prod.outlook.com (2603:10b6:3:7a::18) by
 DM5PR12MB1163.namprd12.prod.outlook.com (2603:10b6:3:7a::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3433.32; Fri, 2 Oct 2020 12:24:57 +0000
Received: from DM5PR12MB1163.namprd12.prod.outlook.com
 ([fe80::48cf:d69:d457:1b1e]) by DM5PR12MB1163.namprd12.prod.outlook.com
 ([fe80::48cf:d69:d457:1b1e%5]) with mapi id 15.20.3433.039; Fri, 2 Oct 2020
 12:24:57 +0000
From:   Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Cc:     joro@8bytes.org, robin.murphy@arm.com,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH v2 09/13] iommu/amd: Rename variables to be consistent with struct io_pgtable_ops
Date:   Fri,  2 Oct 2020 12:28:26 +0000
Message-Id: <20201002122830.4051-10-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201002122830.4051-1-suravee.suthikulpanit@amd.com>
References: <20201002122830.4051-1-suravee.suthikulpanit@amd.com>
Content-Type: text/plain
X-Originating-IP: [165.204.78.2]
X-ClientProxiedBy: SN6PR05CA0010.namprd05.prod.outlook.com
 (2603:10b6:805:de::23) To DM5PR12MB1163.namprd12.prod.outlook.com
 (2603:10b6:3:7a::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ethanolx5673host.amd.com (165.204.78.2) by SN6PR05CA0010.namprd05.prod.outlook.com (2603:10b6:805:de::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.13 via Frontend Transport; Fri, 2 Oct 2020 12:24:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c4daac85-2714-4111-b778-08d866ce2c51
X-MS-TrafficTypeDiagnostic: DM5PR12MB1163:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB11639B30B72E022F167AB251F3310@DM5PR12MB1163.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:120;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: slLVoQKQlALIvuCxpyjpo/FHJB8lzd8BoWkO62mtg0T5Ayvi/8ZE5JJ2vu0hz2swWFlcRvRWWPXAvttwjxU48qeps1uf7AseUjTFhiMGVsC4Tq6nPlKrruwKGo/CzDWB0Zj8CgXutwc5PzsERWRhktuOrpDNeLXjZehVg3RKjPD3JC8NX5K19LhOiA5cFI989NHAYZPUbWjSrV5BAJj3xcpWGm3M0P2yvm2jb0FOZN7Xuq/HtFRhDlkUWqv51wqHuzpPzS+pOB8x1IzBmkssYkrkMEL1pRZZ+aIqkZVsNfoaSV4SFLv/TtPr9OU+CXeQ0JD9eAlsqZpq+0o2LDFjnw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB1163.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(39860400002)(396003)(346002)(376002)(66556008)(52116002)(66946007)(66476007)(7696005)(5660300002)(8936002)(4326008)(6666004)(1076003)(26005)(6486002)(16526019)(186003)(44832011)(316002)(2616005)(36756003)(956004)(478600001)(83380400001)(8676002)(2906002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: ZnawXoi9OI3nLgHNiWm4mX5qHNgk9NVsG3aG85kVXb3zCgPakbJrE0uoIKnyiJaLYjUHcqLTNz9kwcjvsXzUjVQvG46LSzK3/QmrF9+xI+P7idE4NRmaU586vLrhheZm55UpLQ4jpBPNM8aEc873DPRC9irLQk+UFe6P3zwwqy2QgE5KGVVWXYFZpoPtvN3XXJ3+UUBSCGfy/dGMHpaPLJF/rl27ASbFqufyti76bCwRrDW0IB9P7zEHxBZLasDN3bVQsNrAm0zZGnm0idbw9pJD2OUxgXkvmL17dnk6fGvEbb+f4JDdk562puPfrKoDAwYPXoEUrzgb78+Yx+ftbXZclAeRrHZ71ZmOZetwf2Z7Ofu+Yz2sVN029aUpMZz5cVP4LCTQWAnnfpX2N2NMF2G15i/+k6zyIYFnICfHDH5qk3C4mOLiL1O2kZBaOJTsAbsU02OdqE++Gd8jM+HUXHoW7LcGoiyDcybGypHJRdKzVmXMOaTPPdk6YZKuUXRnj9Yul3dmL+VD+9sXacHQmL4ljzxSpxkhFN657CHC1Xtl1xTilBn1A5YjmPUfoP4H0ZwQV9V8xij72QY5yhLCDTlX52YXIz8nrQn8UM9WsJ31Vn8eracQrC+Rvvt8HRnBe9JKvZ8y77pRibGFIlUaGw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4daac85-2714-4111-b778-08d866ce2c51
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1163.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2020 12:24:56.8263
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bCRbBcLPwNtyMLQ3lfL4PmajgZEsAsbtsymsplOKUPYkR8N+4xM4m4sX6/ygnF7Db9jZPqy8TjMK2tjJ+SG58g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1163
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no functional change.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/io_pgtable.c | 31 +++++++++++++++----------------
 1 file changed, 15 insertions(+), 16 deletions(-)

diff --git a/drivers/iommu/amd/io_pgtable.c b/drivers/iommu/amd/io_pgtable.c
index a2acd7e85ec3..ff1294e8729d 100644
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

