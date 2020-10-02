Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2370B281295
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 14:27:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388066AbgJBMZj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 08:25:39 -0400
Received: from mail-eopbgr770078.outbound.protection.outlook.com ([40.107.77.78]:65191
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1733260AbgJBMZ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 08:25:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iBvxw2MDxU2MYmKeG79Y1pO2LIDNJzrmirjLAml0irgVOG+5dykH6gCb0/rUeyEVfxhMTA+Pt6q5sqtx/0droawXSwc+Fvs5Kvwb3kp8n6ueePeJzuY8khVemhwFQVA35xMQrXQw1X4BQE0v8UNllRwYX8RgsqNbe9e3ej2ut7hhdEgR/N5XX00rBkHD9uQFBYP3nqXBnQ1b/iUkQ27kCbK8Jc5/NpNm6vGmaK8/6L+6IyR/R7Gu9qmM50wsD/mMS1wUoNBBSuaIPnnwXrR/yQD+RqjS0lPFvLwNQRh9zDC6kUdIL6IPrZniQRFrr+33pGR2KyMnh2WoIBdAKdLsQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dKEPjoBT2O7PtocR4fAllrWsX5hxkrPFOl8G8/ThNoU=;
 b=kTzTWEgpkzL9ZWdEFTYWHVr4bLG52K3+Z5zMb4roc449lJF0V8wsf+YvcOwn2Rkq7yCazaP3iNq8hEZfWcX9wJ7T3cWtUEmTynuMGvqjATJGMxBIN/mjdm6g3d5f39pG4T2N9mpRnkJG1XA0H0xGf8SeXmr6/54nUE3zug8FIaLEVX5D+ZwxQtu0CZGhavJt7WckE+9pAbyl7zilzI8/jDwK4O3krHQoOYZBPL/rP08iUKYFcokp5oP+F6F6gVE+u6VGsbUBpQhWxov/+CmVZaI1M91kGj0SWRdrRsmZcq0wG+Bwh5fam4eL5ktVPzTvX0kwDDPCOrhJSvEFWPAKmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dKEPjoBT2O7PtocR4fAllrWsX5hxkrPFOl8G8/ThNoU=;
 b=I5LlsNlRdUTTc7vZWLWWCu00q0S2czP8mEud57awsJLqWHyGGZT+NyzuUOG3ZN2Q4zM2rHUiU6KxaPoMvBm2nhppu6oJE0OUiKrEMZU+9PErTEPRU/MfclJGGy2bw84MP4837yNKH7QzvCRLCfW77Ekm+m5nUJrxnro+5EnGbeo=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1163.namprd12.prod.outlook.com (2603:10b6:3:7a::18) by
 DM5PR12MB1163.namprd12.prod.outlook.com (2603:10b6:3:7a::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3433.32; Fri, 2 Oct 2020 12:24:58 +0000
Received: from DM5PR12MB1163.namprd12.prod.outlook.com
 ([fe80::48cf:d69:d457:1b1e]) by DM5PR12MB1163.namprd12.prod.outlook.com
 ([fe80::48cf:d69:d457:1b1e%5]) with mapi id 15.20.3433.039; Fri, 2 Oct 2020
 12:24:58 +0000
From:   Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Cc:     joro@8bytes.org, robin.murphy@arm.com,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH v2 10/13] iommu/amd: Refactor fetch_pte to use struct amd_io_pgtable
Date:   Fri,  2 Oct 2020 12:28:27 +0000
Message-Id: <20201002122830.4051-11-suravee.suthikulpanit@amd.com>
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
Received: from ethanolx5673host.amd.com (165.204.78.2) by SN6PR05CA0010.namprd05.prod.outlook.com (2603:10b6:805:de::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.13 via Frontend Transport; Fri, 2 Oct 2020 12:24:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a8255da8-87f0-4bc1-67ab-08d866ce2cf1
X-MS-TrafficTypeDiagnostic: DM5PR12MB1163:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1163C58FB46097B64303CCFCF3310@DM5PR12MB1163.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ucT1qS9cPbRbhARlWxR8EchPmSI3KXFyojB8657AmZgjJDJ/dTPXAi3H7LLDnrfqEQQm7AM9ApdK5X3Us/YeRAVyqJu/TvxIbhepb9aW3ZuIxliIr7vZiJvnslC/qnG8zf37KLo84PZS2zDeR9ny85YoA6Dm6uns9kcsfaR16YAmUqlmJgwp/oUWfcG1c2rdK4MarrHrBC2wiwzGITgOlSIF9Cknl/QV2mzN133GnNmz7guu2AduEMwU6SkTYrI7sNX1jE32hTd3cjPPelVYtfm8bAyM64miB+pliqss+BVUwrQDrJ5kUNkV8JfL0YttjwFdiWo3ZzFxfN343TQhbg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB1163.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(39860400002)(396003)(346002)(376002)(66556008)(52116002)(66946007)(66476007)(7696005)(5660300002)(8936002)(4326008)(6666004)(1076003)(26005)(6486002)(16526019)(186003)(44832011)(316002)(2616005)(36756003)(956004)(478600001)(83380400001)(8676002)(2906002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: S6vm8tn8YXSHlsre6grl768aXtgoPwO9GtdFHBlD4vk2r8crR51BGtMcfzkEVBV5nTxEh+So/+dED2r6gl8kCEbjwOVMV6O+ZuKhhzLZjGbG3d0uRammRECKFWxVqkWerFxiuAdqanq+q83HaJr8ATTXokFLivhA4G/CzUOTKV37Wlkor+cZp0KpLNu+0T6a/mdj+wIthEeTwxKkwZIyvSEXHmbdXtdU2Ad4zDd6/40HnyIbLsO6JKwzM4ECopJAGYyX9g5Y3IY+tfTo4lQYym8gaWlGnrUNpZbXuJyabYSMMULNhoMoXQM5JQytKAT5cjQKK0Q4pfBfYas4d8CUA59h22e9TAkQhGSVOKqPUId0kkkySq4TfJytdB1z/hMCkfZBEgyONBY1CMsmjz7oWDNDuNl7XflK8FMig7rtuNsdQEf0uHdS2T/aPKP1TYsuj8hZlf/WlYcb8E5bqaf07GlZ6Wt9qZSBudmVWyJAukEbm93PhpCgxA3pJjyQXIJUc9JywybsT2FBb0xOfyw5yuZCeUS2nTYl7L71s4I2sz7ilHSAu3C1NCRSG4GYmempmgLOUEr6oGguf8DA0W4QJ0dZdB+DLlbGymGLCq3B9QywGBh9pog3pTiwwAi62Sqfw40EQ4Hts0h8hGEJi90C4A==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8255da8-87f0-4bc1-67ab-08d866ce2cf1
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1163.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2020 12:24:57.9378
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rmmNJEyFjdjNM7xO3rIRHCgYPPDVreEzq6HC7CkdP8J8JHZ5QX7BYGUrJ9n/+6RBMGN4iP8MsHvXdq3cPHv3fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1163
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
index ff1294e8729d..1729c303bae5 100644
--- a/drivers/iommu/amd/io_pgtable.c
+++ b/drivers/iommu/amd/io_pgtable.c
@@ -317,7 +317,7 @@ static u64 *alloc_pte(struct protection_domain *domain,
  * This function checks if there is a PTE for a given dma address. If
  * there is one, it returns the pointer to it.
  */
-u64 *fetch_pte(struct protection_domain *domain,
+u64 *fetch_pte(struct amd_io_pgtable *pgtable,
 	       unsigned long address,
 	       unsigned long *page_size)
 {
@@ -326,11 +326,11 @@ u64 *fetch_pte(struct protection_domain *domain,
 
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
@@ -465,6 +465,8 @@ unsigned long iommu_unmap_page(struct protection_domain *dom,
 			       unsigned long iova,
 			       unsigned long size)
 {
+	struct io_pgtable_ops *ops = &dom->iop.iop.ops;
+	struct amd_io_pgtable *pgtable = io_pgtable_ops_to_data(ops);
 	unsigned long long unmapped;
 	unsigned long unmap_size;
 	u64 *pte;
@@ -474,8 +476,7 @@ unsigned long iommu_unmap_page(struct protection_domain *dom,
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

