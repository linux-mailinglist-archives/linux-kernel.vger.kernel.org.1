Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EBCE275559
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 12:13:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726904AbgIWKMh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 06:12:37 -0400
Received: from mail-dm6nam10on2050.outbound.protection.outlook.com ([40.107.93.50]:27069
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726636AbgIWKMd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 06:12:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YCMdDnwwI0tlgRsUjMEtchY8EJj9Y6ti/nPTTmMX2g127Ghnmvde65jt0appiFueW1iZFPPUYSQD5Nq0flmao1DU3Ck99gIUSboM4rsD4hPnWJFvRgdsX79DrKZOfS0EHIdLlwIKFFfiFpJjNS5z6wqhWlO+Jw2wPAFNy+j4WSVZNTBB/2OOEywBsT/MkjD5fjMpYKN1yDiNntJICHM8/LAtWF/JHrVxcdypd8mO4tneAnHNhfjpcgMcn723c1L1WKPghnzZ2m0X53qifx+GibA9CBU3coin402lvz2/pS+HYTk+BpMKQst43oBTFd5VZv/cPQBsqmitJKCDiy6juQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MECkVWn6sY/hYDmiTk0g9Bo4mR6Yd+DEJx0B50zsPN0=;
 b=SiWasdTFh/CS+ODMKlPBYd87uEIZDqBgGsifKw4n0Sl8R7UvTSkDqqnYe7a3Wm4TZDzO6n6cmPwH+vnRVTLQk0SzQSxgvGKNt6GGBYoYc1VNEKmIC9FRIXcXZAUMmJ+NtPYG14ndy20mB9Ym1Zk+f2pAl+TlCAJGMVZQA6NMdogal9ZacnjZe6DBCZARwOM1ikAbsxoQSyeglkalQM/jzjgJlAl26WVzPiDHQ4uYAOh1O4ByfooyJ83k9fkKjeL8JZIeJxz/zODW9KmTCG/P+QhGjGFkCYACwhahYGxsiAq6tvWUhgu5Oe5WYdoYSQDU8snjVHqbJyPyghThMUHmmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MECkVWn6sY/hYDmiTk0g9Bo4mR6Yd+DEJx0B50zsPN0=;
 b=emsivUi6gQzuQwMaZGT1LmOs16quc0920KzpxJ29ItTUaCE1yxHM5lgUYBmiXVkAn3M6wgawGG5PhZ7O/Bh8IHHeJ7m5rLQEIvhwxIvr+3wkreAbYgW08OMdBxozBSj7iF3pHd2QicXD1O/GAuN7hJRg7j8yHokThNJfjMPLThI=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1163.namprd12.prod.outlook.com (2603:10b6:3:7a::18) by
 DM6PR12MB3466.namprd12.prod.outlook.com (2603:10b6:5:3b::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3391.11; Wed, 23 Sep 2020 10:11:52 +0000
Received: from DM5PR12MB1163.namprd12.prod.outlook.com
 ([fe80::48cf:d69:d457:1b1e]) by DM5PR12MB1163.namprd12.prod.outlook.com
 ([fe80::48cf:d69:d457:1b1e%5]) with mapi id 15.20.3412.022; Wed, 23 Sep 2020
 10:11:51 +0000
From:   Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Cc:     joro@8bytes.org,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH 11/13] iommu: amd: Introduce iommu_v1_iova_to_phys
Date:   Wed, 23 Sep 2020 10:14:40 +0000
Message-Id: <20200923101442.73157-12-suravee.suthikulpanit@amd.com>
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
Received: from ethanolx5673host.amd.com (165.204.78.2) by SN4PR0601CA0003.namprd06.prod.outlook.com (2603:10b6:803:2f::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20 via Frontend Transport; Wed, 23 Sep 2020 10:11:50 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c6aa5d34-0ba7-458a-aa04-08d85fa916ef
X-MS-TrafficTypeDiagnostic: DM6PR12MB3466:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3466DBA73AC0613619D073B6F3380@DM6PR12MB3466.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lnGSxdW/eL6xyAkC55gpEm/85MzJeLGOPbxf7CzCj0GN/Epzt/i47mTE3h7ccow9Vqzvaiea/HbQ68gwPDtze+4YRPBDhrZ9uB1sfl5cNbTE7z3sqXgtG4KnRJY2l1zDJJFdJLrD+vfkAD45zhAbk1YvPXT/i1/oNJG1G7cndnb0N0TXiPPnVKmwy52yxtLtU52dIy22b9iEMmCXcGxODr7sSOyefiGH0cdP+B4c1NR6rpzvgI4m3TwTs/ka2DD8RrfIc5AftvsRkhQIp7j5bTk1HtpdyLJadi43UmQE4Vv4BNyGaem+5snwH/relPwWDn8Zg7ivYrW5ZUkaZUEswA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB1163.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(366004)(376002)(346002)(396003)(44832011)(5660300002)(66946007)(66476007)(66556008)(83380400001)(6486002)(86362001)(36756003)(2906002)(8936002)(4326008)(26005)(316002)(1076003)(956004)(478600001)(6666004)(186003)(16526019)(52116002)(8676002)(2616005)(7696005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: HwkJb2i/AsK0pfhlzxu3232tYbHA2cM6r0EnOxIZRWUXvUGVpAM0RsDwfSgYTOH/a33kutoYX3vGHGA07U6P8sNa48mtnsi4ddo6LrQKRACogJ3xibfrl4WlT6JXuI3dB5FHms/CsGcthYqY38eWanxObO0CJC9QM34Xe1XeZHcuPD85ACCPlp6MqknPieMYh2X0v5NVVA1pQFD1G2Hm7aoX2JDuoU+q+2mOljEKNjW3uPWFJijEu4ISFjPot3eP3rUnSQUIRTWdsuGLEfEu+B1EPs9n0kTJ7AdZRzMlENwZeGIhY/nyHEeWSqhe+7qymHerTtPHLKaFRFArinS6aeRG4edZc7xvkB9pTDyVBmX3LNdh3Qt/15MiQ2jz6SItk7McjEJ7DnXgvhNlr/Um7rTlTfR97mPCcIsgFvHWWuYkdCoO3OIuekaCA8au/vnNoagbEEtJ7Q7lHN8uzkt0zj2dby/cP9UvvIwWPu45+W2hFIzop00QZsQ/oz/2sYMGP22XORwOmczNWVPYx52CyWe8zhtMg6LOcXVyGz3w/tw7/R+ZegMtIlWg6lh6beAXKPogo/cxpwS5ooq1fX5goEOJaFYMZajVru8zo5lJXfCYySy8bqQk6h/IR1Eti9ZoHgKSGIZz+Q4rEzvtZyygYQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6aa5d34-0ba7-458a-aa04-08d85fa916ef
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1163.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2020 10:11:51.6010
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JegNdx5FujtYVp0RKoVMQY4a7uQwyKIEY8NFjYJ159E0QOe7dVRx8s6EAsO0VNWY2tMFlByYD9UsE1vhJEBHbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3466
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
index f913fc7b1e58..2f36bab23516 100644
--- a/drivers/iommu/amd/io_pgtable.c
+++ b/drivers/iommu/amd/io_pgtable.c
@@ -525,6 +525,26 @@ unsigned long iommu_unmap_page(struct protection_domain *dom,
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
 struct io_pgtable_ops *amd_iommu_setup_io_pgtable_ops(struct iommu_dev_data *dev_data,
 					     struct protection_domain *domain)
 {
@@ -551,6 +571,7 @@ static struct io_pgtable *v1_alloc_pgtable(struct io_pgtable_cfg *cfg, void *coo
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

