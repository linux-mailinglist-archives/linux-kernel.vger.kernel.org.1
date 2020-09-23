Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F02A7275556
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 12:13:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbgIWKMb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 06:12:31 -0400
Received: from mail-dm6nam10on2050.outbound.protection.outlook.com ([40.107.93.50]:27069
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726682AbgIWKM1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 06:12:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gmhOo97mBWRiJHRlcxQ1kdoWgOtQ8SJFw8xBZP2zz6BoCMeTLSKLu1gwXOGqQxoFbu+4GfmEvJmbeWEB5pb40aW+90oC70X0pwQKI4OM1VkyP2YdJ3Fajhg8Ohl7Vwvzf/LlrB9KYiC+BwhBg6EZCkGkc6bDweI4kCuq1w8gwWBTMuyJRkUeVG9OOcGzdmP7NDph0t3jc4d/+ZM3Ubr3sn/sqDSBOT/IE0NxIA3QfIFOpq969+HdGirZm4Vzt/spukxKeRWndIm61VvtI2m6bgzhYCk6zM51RX7nYFUWi/qxylDqoKxsn9P4/xyZ9vzqyFWijDKxTNnfYucQ/lizSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eu40u6JTXGXFHQDfiNvqMY6WvQZSae2k1GEPtNajR6s=;
 b=AA4wA5XB/XuwzKnO9tcqiqkXlSlKI3lvbExpbFcNCXYLi9sDEWcF5VtsKnAK9zOuhRPSAL1jAyAxV8lW+xG1IYlptWA3lVAzTW+LyBloc1n5cvekMyq90YOrUSiOUjJMsLyDbe+Du17GTqCyNfMxLipUurOjbFkuhrV2pBhkQ812kuFLvIDZnE4jzRkkjpuH7mKi3I9J4H5ZXE0KQNHceiRQrAkfZXYLKHmEXYalXjO53OOSHEMJRU/FnsxPlEy1p1mHuUOkc/DxxkdCqOCapDBj2nsvL7P5lAph6/tJK375X3PcDmrC97vdNSbl/oCEC2wF1/epAZ9Dege14GGNcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eu40u6JTXGXFHQDfiNvqMY6WvQZSae2k1GEPtNajR6s=;
 b=RPy8MhaA/uRz2hppG2FcuKO2wUjYwMhyYNqEur4z/f9E7FtkwI465WLUIHDNFJ8kwl+EeW+GWLA2J3xqxJ7KGH/iZ+hx70RsV6AyLB4ERPJaVhMaY2sz1eUlGdBmPUcRbtRjR+bfAoJntzvw1x0KHg8xxkUpfKtzq4+N9WloiQY=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1163.namprd12.prod.outlook.com (2603:10b6:3:7a::18) by
 DM6PR12MB3466.namprd12.prod.outlook.com (2603:10b6:5:3b::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3391.11; Wed, 23 Sep 2020 10:11:51 +0000
Received: from DM5PR12MB1163.namprd12.prod.outlook.com
 ([fe80::48cf:d69:d457:1b1e]) by DM5PR12MB1163.namprd12.prod.outlook.com
 ([fe80::48cf:d69:d457:1b1e%5]) with mapi id 15.20.3412.022; Wed, 23 Sep 2020
 10:11:50 +0000
From:   Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Cc:     joro@8bytes.org,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH 10/13] iommu: amd: Refactor fetch_pte to use struct amd_io_pgtable
Date:   Wed, 23 Sep 2020 10:14:39 +0000
Message-Id: <20200923101442.73157-11-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200923101442.73157-1-suravee.suthikulpanit@amd.com>
References: <20200923101442.73157-1-suravee.suthikulpanit@amd.com>
Content-Type: text/plain
X-Originating-IP: [165.204.78.2]
X-ClientProxiedBy: SN4PR0601CA0003.namprd06.prod.outlook.com
 (2603:10b6:803:2f::13) To DM5PR12MB1163.namprd12.prod.outlook.com
 (2603:10b6:3:7a::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ethanolx5673host.amd.com (165.204.78.2) by SN4PR0601CA0003.namprd06.prod.outlook.com (2603:10b6:803:2f::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20 via Frontend Transport; Wed, 23 Sep 2020 10:11:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f16f1e38-b093-48a6-477b-08d85fa91662
X-MS-TrafficTypeDiagnostic: DM6PR12MB3466:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3466D0AF093979435698200CF3380@DM6PR12MB3466.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E1OgO0hi40rFDAVFbOHfQGyIIR0N9PMs0ITUtILxaNyKgvS7TsOIkqFJq2DxwanyjWpLFG2ZOkl6FelHe4yr1NgFCTEsbpUrbQXHfIV3g2+VtfSGpFyVBCv6l+ebSgmDQGdSbODgULu6IkZtB7OR/P6dJZ8N1/PQnvOSNNLEjyN94yBSZlG4cx0aTtNOePWktWz4HekxxhfwPPNC/L7Pb1bbuNli92cucZp61jx/bqUUq5uOEZpJeFmPleWaetPhwH2fmwJYPks1aGtaL7Nwi/LoFsAGikeSw7YoToI1V8kcyeqsskSldBGfCQM+9SwBVo8/W5r4TCdG29RGOy0J6A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB1163.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(366004)(376002)(346002)(396003)(44832011)(5660300002)(66946007)(66476007)(66556008)(83380400001)(6486002)(86362001)(36756003)(2906002)(8936002)(4326008)(26005)(316002)(1076003)(956004)(478600001)(6666004)(186003)(16526019)(52116002)(8676002)(2616005)(7696005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: PnUsEvTS2jhLOvaNLBVKz5duYqrHGgmPwXdhHj5u7IWH/xpBUpn/OgvdOrAw9yg0GFakeZBnBy2rqFx7hOEbOtTHIj/7Yv7PhbfEC3JnyPVTAk/8Rif8SiHCm7aHYFo9KzWUleDYo5UQwWZmXlGyw/WKIffShvZh2C30mlaAjgRgYDQ+Howno/NR2mO1SW24NTi9Ds8A/nlHlJ3yqSx5GccUWmGp9gO781l+KXOcdaOdWcB4pH94D3YpxNrje7L/Q3Q4LZcLBL0x28T+dg6dF0TN3xmQlwsYmCsbP4CHNILAoy5Ug3nPFqIkoReuY1Q67emhxix2FN63nkfli3Gz8xIanLfXyKxFEmTWPR2vCao/453Q7AN8481L80QWGDE9IJiaV3UYrvSrUkXvJwcHp/rtVwwzXB6Vid+frvf5TQ/2OlOFK8iFrBSKCQbx0asScYviCVqMdt3tqEIZiLFoTmaET0OfOd0sSkPMVxXeKrlFaJMJ3eMtgzu/1psNZ1ynBRh2vdcCpc1C4wKl0uexAXKRGdP33hCYnN5yrrIU5ZdIPik5mSXd0iwkCDKHZtwySzt077L8R5fiw84QpnbRx5CtTQKyuQjq5SxO2tSk6SnExiTXT6uYeQknkx1SK8GjH+qgDhp5X9fos2A8insqqA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f16f1e38-b093-48a6-477b-08d85fa91662
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1163.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2020 10:11:50.5665
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N2MqMrYNHZlh5GPbCWoQ9b1Xvg9zxL9L1SbvA1aQ3PJqN7SYGPJ4NW1CJJBC/i22ji8lrcYoGeJy+Vd5kiY9oQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3466
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To simplify the fetch_pte function. There is no functional change.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu.h  |  2 +-
 drivers/iommu/amd/io_pgtable.c | 13 +++++++------
 drivers/iommu/amd/iommu.c      |  4 +++-
 3 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index 2059e64fdc53..69996e57fae2 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -134,7 +134,7 @@ extern int iommu_map_page(struct protection_domain *dom,
 extern unsigned long iommu_unmap_page(struct protection_domain *dom,
 				      unsigned long bus_addr,
 				      unsigned long page_size);
-extern u64 *fetch_pte(struct protection_domain *domain,
+extern u64 *fetch_pte(struct amd_io_pgtable *pgtable,
 		      unsigned long address,
 		      unsigned long *page_size);
 extern void amd_iommu_domain_set_pgtable(struct protection_domain *domain,
diff --git a/drivers/iommu/amd/io_pgtable.c b/drivers/iommu/amd/io_pgtable.c
index 5da5ce98b7b3..f913fc7b1e58 100644
--- a/drivers/iommu/amd/io_pgtable.c
+++ b/drivers/iommu/amd/io_pgtable.c
@@ -348,7 +348,7 @@ static u64 *alloc_pte(struct protection_domain *domain,
  * This function checks if there is a PTE for a given dma address. If
  * there is one, it returns the pointer to it.
  */
-u64 *fetch_pte(struct protection_domain *domain,
+u64 *fetch_pte(struct amd_io_pgtable *pgtable,
 	       unsigned long address,
 	       unsigned long *page_size)
 {
@@ -357,11 +357,11 @@ u64 *fetch_pte(struct protection_domain *domain,
 
 	*page_size = 0;
 
-	if (address > PM_LEVEL_SIZE(domain->iop.mode))
+	if (address > PM_LEVEL_SIZE(pgtable->mode))
 		return NULL;
 
-	level	   =  domain->iop.mode - 1;
-	pte	   = &domain->iop.root[PM_LEVEL_INDEX(level, address)];
+	level	   =  pgtable->mode - 1;
+	pte	   = &pgtable->root[PM_LEVEL_INDEX(level, address)];
 	*page_size =  PTE_LEVEL_PAGE_SIZE(level);
 
 	while (level > 0) {
@@ -496,6 +496,8 @@ unsigned long iommu_unmap_page(struct protection_domain *dom,
 			       unsigned long iova,
 			       unsigned long size)
 {
+	struct io_pgtable_ops *ops = &dom->iop.iop.ops;
+	struct amd_io_pgtable *pgtable = io_pgtable_ops_to_data(ops);
 	unsigned long long unmapped;
 	unsigned long unmap_size;
 	u64 *pte;
@@ -505,8 +507,7 @@ unsigned long iommu_unmap_page(struct protection_domain *dom,
 	unmapped = 0;
 
 	while (unmapped < size) {
-		pte = fetch_pte(dom, iova, &unmap_size);
-
+		pte = fetch_pte(pgtable, iova, &unmap_size);
 		if (pte) {
 			int i, count;
 
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 3f6ede1e572c..87cea1cde414 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2078,13 +2078,15 @@ static phys_addr_t amd_iommu_iova_to_phys(struct iommu_domain *dom,
 					  dma_addr_t iova)
 {
 	struct protection_domain *domain = to_pdomain(dom);
+	struct io_pgtable_ops *ops = &domain->iop.iop.ops;
+	struct amd_io_pgtable *pgtable = io_pgtable_ops_to_data(ops);
 	unsigned long offset_mask, pte_pgsize;
 	u64 *pte, __pte;
 
 	if (domain->iop.mode == PAGE_MODE_NONE)
 		return iova;
 
-	pte = fetch_pte(domain, iova, &pte_pgsize);
+	pte = fetch_pte(pgtable, iova, &pte_pgsize);
 
 	if (!pte || !IOMMU_PTE_PRESENT(*pte))
 		return 0;
-- 
2.17.1

