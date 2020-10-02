Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69FE828128F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 14:27:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388045AbgJBMZT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 08:25:19 -0400
Received: from mail-bn8nam12on2077.outbound.protection.outlook.com ([40.107.237.77]:46080
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1733260AbgJBMZO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 08:25:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PM8II8IOiLocdUDqK6j8qfGCdYlZoSzdtRW/Qm8VftfP5hgfyhpQKQAvyU1ohAE77Ix8hF5LrjNC31CzkuQpynpTkdrHiNmYO5Fy5irI1OL7Aw+NxbBTXLqbwdvux4hx0up1phwEk1D2FfqRhbf0m7NNX+/CwW76aAcA8dAt4YgJSl1GA84K+cUnRIgsSTMT8wkxDV+b3yGfb5LF2AMTebIhOWfWyULAvsLvopBiBaELs8ldy7Bf/+uMDhbycJhrMIzcUEXHxFXrs9Hq4Kv+Fi5YXkuDaR0XncFFqio5hzVkMDeURN1IERvClZ2+aEnC/2jJ68ogEH2BAzwd4/4bfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wjPvxJJuBQmHgJYK1Xlp9RUCcsbbjzyOIjrngDuthH8=;
 b=Hd8QQoQ+rJAe9Rn37RyOIvZkqO2/ieOMFpxQd1QoZX2IGHn8yueOdJyj2nhsLIt/N1hNLOF4BgN8MynPwBiK4HocAD2UEyRz4qlpTtoX+TZWANfKMG801AhFp8OL+VQpDjZT++cRbctUFnfYZtq6LXK6Rf3tCBF2HhStUliQJVgEihiEMdZhmFnht64RtJtuRmwIVjIHTLyA2M91EMjY1HJrzY1BrXRu3mKt803vod/DwI+jZTuS6w3cTX4zWozUlIEBhblBqSbOoorY0Yjo9nXAxJIG1vscPtrLjJ2dQNanMG2giWb7JVHSG7utK/JiC7f1cwAotQrHHjiolZBuiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wjPvxJJuBQmHgJYK1Xlp9RUCcsbbjzyOIjrngDuthH8=;
 b=msqJ74nLQWOvxsasIxdRNKN3Yyog1+zk1VFOIBtReUULBlNgvxijaNAKKZIR7PorivUkSfICAKLwTeJDsPhgwa+mVgXIBAtkHnXRUD3015ShvlShI9yDgVsGmHmldpy2syghF5+x6qlKuooSqHmYxp20kubJfQGaJE21YYIfAo8=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1163.namprd12.prod.outlook.com (2603:10b6:3:7a::18) by
 DM5PR12MB1163.namprd12.prod.outlook.com (2603:10b6:3:7a::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3433.32; Fri, 2 Oct 2020 12:24:54 +0000
Received: from DM5PR12MB1163.namprd12.prod.outlook.com
 ([fe80::48cf:d69:d457:1b1e]) by DM5PR12MB1163.namprd12.prod.outlook.com
 ([fe80::48cf:d69:d457:1b1e%5]) with mapi id 15.20.3433.039; Fri, 2 Oct 2020
 12:24:54 +0000
From:   Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Cc:     joro@8bytes.org, robin.murphy@arm.com,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH v2 07/13] iommu/amd: Restructure code for freeing page table
Date:   Fri,  2 Oct 2020 12:28:24 +0000
Message-Id: <20201002122830.4051-8-suravee.suthikulpanit@amd.com>
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
Received: from ethanolx5673host.amd.com (165.204.78.2) by SN6PR05CA0010.namprd05.prod.outlook.com (2603:10b6:805:de::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.13 via Frontend Transport; Fri, 2 Oct 2020 12:24:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c5bfa630-6929-4afb-ce8d-08d866ce2ad3
X-MS-TrafficTypeDiagnostic: DM5PR12MB1163:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1163EA2FE158CC40814FE6A5F3310@DM5PR12MB1163.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p8NjrV+JEL2qZtp3xL8qTSl9/kscdSeNIE7AGWnsnrlnQLnJVrsPGx0dSrFu48V5sKHl3nUB+XMKAWDgfywPioTkZ0z9hCUw2vMn5BBInAgzDRYhCf/bSb184uYwM1GqFvh2d8w3MZwzDvVaf56MRThWwIRwlmYiukVa86gP4ds8NN+f4ZeeIZQk7v8sI4x7kfuTvKfRO6t3Qe8xHrobaTYsOp2hdjqUx/yV8CH/KzFXdocoQpEfvDn2kFCYoZcTHQeKTElVFn829eMkLY9MxSo/CobBam83w8nOrNBwyycRADDbUeyLkqpf++FsJId52Xik3rPOAA0oJVMmmpy73w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB1163.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(39860400002)(396003)(346002)(376002)(66556008)(52116002)(66946007)(66476007)(7696005)(5660300002)(8936002)(4326008)(6666004)(1076003)(26005)(6486002)(16526019)(186003)(44832011)(316002)(2616005)(36756003)(956004)(478600001)(83380400001)(8676002)(2906002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: pB+hZYgrAvZkn3lIY0YxJlnJcszg5cubzeiPx1X6gRm7BIRRYAkEOU9fDdpIa1mcVzgG0+ZDeh0ZD9wVw0BvQri0R+A3OIGdTkY+l46p/GGuVSvaJs1twa53DgrXhFeITG3h60LHOjJQyPMDuE177B5HG8d0y11jJcIWnSe/LNcoYG2SSlBJkbNWXqoNH+cCsa1NEfOXq8IZ7SIrgFjEnqBBR91uRAlxr/Pg4maLT2I1PcwfHPBRZQENaDb8V4F1Ju1GehDFbAARCQ+neBpOZYxjVK3r4w8smlQVEiJP5BYWviN7OKi2FsSkuD/4LW/tPpLJcAjnBIdSH0sb+TPfyxXqIC/e4a8BtkMc6AhRufh4349SjTDpNCWcqH8SEjCPhySzEH82CY/X3Lsln2YTAHcAh+v9Eksg0DvRf8lqmUYeHDfKIgiVEtVhuMva4mh70LVJn1pUfIZZ7ZfcRNfCeFsj+NdxDHZ9qGh2gJnEM/sG6fUO26TEhs6TaEjLFPBU5n9OVdAyZi/5y/jV1mRpUmd8nqRFROqFgvux/8ujdv+7HpWDmRZ02BsuuMRlN/TmeqvPRfW3xQ0PuTUR0nRcLUe+/tWTdpU6oyP0tISmB43iCDqrAXQqIu08UnvlyDE6eNIwQNrUz+zfV7Xv1uvPcQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5bfa630-6929-4afb-ce8d-08d866ce2ad3
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1163.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2020 12:24:54.3813
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j34TH763RYT5IAiduxgapQkpawAwqSUzmJFQJHsp/x2UwVHR/evGexEf6dR3gTyEeg74Z6t2p3QNgymxg18MAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1163
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce amd_iommu_free_pgtable helper function, which consolidates
logic for freeing page table.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu.h  |  2 +-
 drivers/iommu/amd/io_pgtable.c | 12 +++++++++++-
 drivers/iommu/amd/iommu.c      | 19 ++-----------------
 3 files changed, 14 insertions(+), 19 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index ee7ff4d827e1..8dff7d85be79 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -123,7 +123,6 @@ static inline void amd_iommu_apply_ivrs_quirks(void) { }
 #endif
 
 /* TODO: These are temporary and will be removed once fully transition */
-extern void free_pagetable(struct domain_pgtable *pgtable);
 extern int iommu_map_page(struct protection_domain *dom,
 			  unsigned long bus_addr,
 			  unsigned long phys_addr,
@@ -140,4 +139,5 @@ extern void amd_iommu_domain_get_pgtable(struct protection_domain *domain,
 					 struct domain_pgtable *pgtable);
 extern void amd_iommu_domain_set_pgtable(struct protection_domain *domain,
 					 u64 *root, int mode);
+extern void amd_iommu_free_pgtable(struct amd_io_pgtable *pgtable);
 #endif
diff --git a/drivers/iommu/amd/io_pgtable.c b/drivers/iommu/amd/io_pgtable.c
index 7fd3dd9db197..0c886419166b 100644
--- a/drivers/iommu/amd/io_pgtable.c
+++ b/drivers/iommu/amd/io_pgtable.c
@@ -136,14 +136,24 @@ static struct page *free_sub_pt(unsigned long root, int mode,
 	return freelist;
 }
 
-void free_pagetable(struct domain_pgtable *pgtable)
+void amd_iommu_free_pgtable(struct amd_io_pgtable *pgtable)
 {
+	struct protection_domain *dom;
 	struct page *freelist = NULL;
 	unsigned long root;
 
 	if (pgtable->mode == PAGE_MODE_NONE)
 		return;
 
+	dom = container_of(pgtable, struct protection_domain, iop);
+
+	/* Update data structure */
+	amd_iommu_domain_clr_pt_root(dom);
+
+	/* Make changes visible to IOMMUs */
+	amd_iommu_domain_update(dom);
+
+	/* Page-table is not visible to IOMMU anymore, so free it */
 	BUG_ON(pgtable->mode < PAGE_MODE_NONE ||
 	       pgtable->mode > PAGE_MODE_6_LEVEL);
 
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 4d65f64236b6..cbbea7b952fb 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1882,17 +1882,13 @@ static void cleanup_domain(struct protection_domain *domain)
 
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
+	amd_iommu_free_pgtable(&domain->iop);
 
 	kfree(domain);
 }
@@ -2281,22 +2277,11 @@ EXPORT_SYMBOL(amd_iommu_unregister_ppr_notifier);
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
+	amd_iommu_free_pgtable(&domain->iop);
 
 	spin_unlock_irqrestore(&domain->lock, flags);
 }
-- 
2.17.1

