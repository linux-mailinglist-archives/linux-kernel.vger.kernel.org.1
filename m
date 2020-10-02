Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F011281293
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 14:27:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388055AbgJBMZc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 08:25:32 -0400
Received: from mail-bn8nam12on2077.outbound.protection.outlook.com ([40.107.237.77]:46080
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387777AbgJBMZ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 08:25:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IcCn1MKWiyxEIftC2FyahflENu6Ju+e94FX8B3aNue+46l4KrsYxNLS/gqmHiNegO0vP64cLi83vF6FH+U6A8ohRExOTDCtvo4pq4bYq5C/UA4pCp4hdLxnMAfFmvvEb607jY5DV7taHtxZmzGkT49Gg3GOa8bvuKGrRivtS2EjCXSJNVAJtu6iEjIqfYYiDfpF5DhThBeM34UzwA0qR9Muv6QuIItwHwlMitW84NIpbC2N1o/8DVNlPM4A9DVTtkxjp163oI/e7Eol/J7ji/QaFqpN9vaYFRBXkorEnOIwbB+4KTsp2xcKZ75mPsAjKt8LMlaRWc8X01R+RLH3e+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gHhDFN9brVQ3k4ho5u/ZubofNuNNKo9aBVJPEekpxGE=;
 b=AOO2fIpKKRAvZ8Dm1p6q5j4Se89oPERFta2JRNx+uLAUfFhVlkIWmGmX2uV3qh/r+MHPNP4crQAwY/bi/sDIxOre6iwPL7u+Hgzsy8NDFf5h893c8n//tcxHDa+opr01aL6cOeuVgrwEiK29cQgniag95Om3RGwONEvgheBgALtZpF8UkgNsDCHhCwfNzNgfC6Vd7Yx3YiIA6UtJ0paiSjwTYB4379Y5FL+Sbspd3hqYXxFsFtRhzAHf8YHsyUh9JvVpnlnELmsvecg9uJbqStOCM3lr4AQ0o9taI2hDDrFMXG375yBDCs9EAXBlvNSdBP8C4sjRFNM9VGHnaLkQDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gHhDFN9brVQ3k4ho5u/ZubofNuNNKo9aBVJPEekpxGE=;
 b=tJQZ7RDSBBFr5fkkPPtOzuX7v61JctST02Bpbw7cYG0xqRhAVj1dyop9rj6LGcz3ZThZ7N7i3Zkxru3qZi/B8L8aR2lcRQIVX3+J3Ta+W4OFE/w7VFiq1em7CeDLgZZPtAT6lCTcFNV/AbM3ih8zTJFBiJKK+Z05qKXWjG0SX4Q=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1163.namprd12.prod.outlook.com (2603:10b6:3:7a::18) by
 DM5PR12MB1163.namprd12.prod.outlook.com (2603:10b6:3:7a::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3433.32; Fri, 2 Oct 2020 12:24:59 +0000
Received: from DM5PR12MB1163.namprd12.prod.outlook.com
 ([fe80::48cf:d69:d457:1b1e]) by DM5PR12MB1163.namprd12.prod.outlook.com
 ([fe80::48cf:d69:d457:1b1e%5]) with mapi id 15.20.3433.039; Fri, 2 Oct 2020
 12:24:59 +0000
From:   Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Cc:     joro@8bytes.org, robin.murphy@arm.com,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH v2 11/13] iommu/amd: Introduce iommu_v1_iova_to_phys
Date:   Fri,  2 Oct 2020 12:28:28 +0000
Message-Id: <20201002122830.4051-12-suravee.suthikulpanit@amd.com>
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
Received: from ethanolx5673host.amd.com (165.204.78.2) by SN6PR05CA0010.namprd05.prod.outlook.com (2603:10b6:805:de::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.13 via Frontend Transport; Fri, 2 Oct 2020 12:24:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0a32ae37-3321-44a0-ceeb-08d866ce2d7c
X-MS-TrafficTypeDiagnostic: DM5PR12MB1163:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB11639B9307F9C04B621CA47DF3310@DM5PR12MB1163.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J0+N2yy5uxTdylZW0XQkKdn9vqKlZfw91frqAiZcNHlvczYvGoUZyJc3Mk3nTxkhlMEwKoHP0xZ36yJ2F75hst122fJQWV1m8sA+IgBTC2sQ7er2+SbS6+rsRU5eH93PPEel6BseFmXojYONrORpiULtW1XQ+Arl8V5CzhfL66nKZf89dhrABtADzLHK06xilUFLDUs7WERf+4koXdaOrDuiN0T9Ly8QMXOIDxMKx32UOIGeJeyq5Qd/M4vW74B547tDo6EbcdLj9QnwSFtOhVNliqaDj+nUA2coMfFaJ9atG9Se99m7AVTAC5MT+Lb3talE1Kr65kJnhA5+w7VMRA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB1163.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(39860400002)(396003)(346002)(376002)(66556008)(52116002)(66946007)(66476007)(7696005)(5660300002)(8936002)(4326008)(6666004)(1076003)(26005)(6486002)(16526019)(186003)(44832011)(316002)(2616005)(36756003)(956004)(478600001)(83380400001)(8676002)(2906002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: rPgyrqORYbR1KkuFSV9nUsZNuE6pZhvGH2DYDPbEVloHdjF0e5dBJTHfNT0WhOSdl3mREpijS9QhQG5LDZHtt28D2RubtJ+mm7+KBdtJtBjVUiOY3gcfWiF9X99EiHU0TspdymckZ+F/uaDjw1zmYgOwMZuv9FcGNhnikGHAo+kS1yEwgOC1CQdUHbLGpOwDMzkivlBDyx8HiGzyBVolHIZuWjGXwjTszvgQIDb2Yo7Ibpp0u2kRVw5MY3S30U0YPr+Ycks0CITemoil3m3UP9ESkTN8LA9tohsJgJ1dTsmuCNHjhYgkVEwetaSL8MwaabaAGXOlckuKfJv0IfFAumMk4cJIlkYZc/jLhdEzv2JES8edfhrg+12Gdeu/toCZD4HKwfCO5kncjISrNH+iKLJt8+QTaqVHcBH0y8iJ+5NMt/MQIOWyKm5KXW518VP3vdhX4XHhilYy8W9qbqBeMac93KNSnWjCpbyWPGt2zfGy/FNPCyt0DAseLaYxO5XY/0wzfirnXGwwOzX+WUyRwR3tYWEsBHxS+D7V95YaKo1zzwfAdTaGY+U7OGnICsKdbjklc8jLIkaQc/UDYSQ6s6BgkTt4fUQikXEbiWXTZvoqb79nSeCekY12jijp5lvXoxndcxgKBc4cngq2iF6SqQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a32ae37-3321-44a0-ceeb-08d866ce2d7c
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1163.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2020 12:24:59.0653
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jFaU8KQJDt2/GhrkcWFjhv0uWssjotaHFhIBkT7nMZGbT2skCF50lykbhwK+gK7JMCSkEzg1/3+DlYZzjiKESA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1163
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This implements iova_to_phys for AMD IOMMU v1 pagetable,
which will be used by the IO page table framework.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/io_pgtable.c | 21 +++++++++++++++++++++
 drivers/iommu/amd/iommu.c      | 16 +---------------
 2 files changed, 22 insertions(+), 15 deletions(-)

diff --git a/drivers/iommu/amd/io_pgtable.c b/drivers/iommu/amd/io_pgtable.c
index 1729c303bae5..bbbf18d2514a 100644
--- a/drivers/iommu/amd/io_pgtable.c
+++ b/drivers/iommu/amd/io_pgtable.c
@@ -494,6 +494,26 @@ unsigned long iommu_unmap_page(struct protection_domain *dom,
 	return unmapped;
 }
 
+static phys_addr_t iommu_v1_iova_to_phys(struct io_pgtable_ops *ops, unsigned long iova)
+{
+	struct amd_io_pgtable *pgtable = io_pgtable_ops_to_data(ops);
+	unsigned long offset_mask, pte_pgsize;
+	u64 *pte, __pte;
+
+	if (pgtable->mode == PAGE_MODE_NONE)
+		return iova;
+
+	pte = fetch_pte(pgtable, iova, &pte_pgsize);
+
+	if (!pte || !IOMMU_PTE_PRESENT(*pte))
+		return 0;
+
+	offset_mask = pte_pgsize - 1;
+	__pte	    = __sme_clr(*pte & PM_ADDR_MASK);
+
+	return (__pte & ~offset_mask) | (iova & offset_mask);
+}
+
 /*
  * ----------------------------------------------------
  */
@@ -505,6 +525,7 @@ static struct io_pgtable *v1_alloc_pgtable(struct io_pgtable_cfg *cfg, void *coo
 {
 	struct protection_domain *pdom = (struct protection_domain *)cookie;
 
+	pdom->iop.iop.ops.iova_to_phys = iommu_v1_iova_to_phys;
 	return &pdom->iop.iop;
 }
 
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 87cea1cde414..9a1a16031e00 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2079,22 +2079,8 @@ static phys_addr_t amd_iommu_iova_to_phys(struct iommu_domain *dom,
 {
 	struct protection_domain *domain = to_pdomain(dom);
 	struct io_pgtable_ops *ops = &domain->iop.iop.ops;
-	struct amd_io_pgtable *pgtable = io_pgtable_ops_to_data(ops);
-	unsigned long offset_mask, pte_pgsize;
-	u64 *pte, __pte;
 
-	if (domain->iop.mode == PAGE_MODE_NONE)
-		return iova;
-
-	pte = fetch_pte(pgtable, iova, &pte_pgsize);
-
-	if (!pte || !IOMMU_PTE_PRESENT(*pte))
-		return 0;
-
-	offset_mask = pte_pgsize - 1;
-	__pte	    = __sme_clr(*pte & PM_ADDR_MASK);
-
-	return (__pte & ~offset_mask) | (iova & offset_mask);
+	return ops->iova_to_phys(ops, iova);
 }
 
 static bool amd_iommu_capable(enum iommu_cap cap)
-- 
2.17.1

