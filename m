Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57D9A2827F6
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Oct 2020 03:42:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726597AbgJDBmi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Oct 2020 21:42:38 -0400
Received: from mail-dm6nam10on2053.outbound.protection.outlook.com ([40.107.93.53]:62785
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726398AbgJDBmb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Oct 2020 21:42:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QydiPkyS53WjPkLriKDTmDLUM3hh6o9CbJE2QhW7iidJnQoPlHKzLiYGaigGNhvEPaEh7HC2RSUg+QQ4NDSITM4LzTg+VRHxQbJR2QsAsQzi9S9lM+BZv3qOXs/w+BFVFS48wZy+QIOYCgGapa3pjCAsnh6A9gOnMI60cIbywI4YqcIRYmXzP+GIScTgiha+m8BDLNf0QtRM78bxXpSbSTJUStkV0HiN9FWES6TIW+3vqz11sU1jojTCu3EKURBluIRz8WmqVWYuJORbARvWA9Us5dmF8ZhRFn7GSm8CsrOR8SU6PU5hmX3DnwBkyf2OyXAfaiPL8E7tiZL1ld1BZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JDHQocOfdCg8WMYDLMcWQP2XfX55lGm7CivZTRDKu54=;
 b=jaKkQocLOi18pSOoe4ZDd2tbTwK2PpRlQVd9oURLeQvirE7nRPB3SA+9RYEEFg/6RvYLqjbBd30zmZ3IqGce40BkjAwbeTzMCKJdKonJ4F1/vXlW6f/Ge4smkehuYIUQjd9JhB5xVZra7BXDYcr3oQ6yuYFaM20YHDOenBx1gQ/5HFMFkhPk6X7zwhqlFNPkExJ6G9CDCSvxclgn7avnlHPfMTznGVdC5Bkjo+x3qlA09SRx44r9sVIVEamyPy0wxb7B8jOUGuXuAuGQrHcLl6BAoEJ7TuRwayXo6wwp4myJCVEHEr7Ct+7yIRz2H9C7Br9zyE/Kj2Ley6k6zCFLkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JDHQocOfdCg8WMYDLMcWQP2XfX55lGm7CivZTRDKu54=;
 b=eZDE6xFixJVa5kFNug8gni8S6Awmx+RcQTd2L4rSC0sgoUpCe5EgUq00aJVfnGlrGH0gDPSxkvtq/4Y4Xy7dy0pvF1YEeCEgZItpG77D3y2kuBt1bEJfiEa2rZKcagOf3Wgn6k9KCS7/1dc+Ho6oYR2fjjMRYDVDFdCQl1dnwI8=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1163.namprd12.prod.outlook.com (2603:10b6:3:7a::18) by
 DM5PR12MB1451.namprd12.prod.outlook.com (2603:10b6:4:d::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3433.39; Sun, 4 Oct 2020 01:42:04 +0000
Received: from DM5PR12MB1163.namprd12.prod.outlook.com
 ([fe80::48cf:d69:d457:1b1e]) by DM5PR12MB1163.namprd12.prod.outlook.com
 ([fe80::48cf:d69:d457:1b1e%5]) with mapi id 15.20.3433.042; Sun, 4 Oct 2020
 01:42:04 +0000
From:   Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Cc:     joro@8bytes.org, robin.murphy@arm.com,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH v3 11/14] iommu/amd: Introduce iommu_v1_iova_to_phys
Date:   Sun,  4 Oct 2020 01:45:46 +0000
Message-Id: <20201004014549.16065-12-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201004014549.16065-1-suravee.suthikulpanit@amd.com>
References: <20201004014549.16065-1-suravee.suthikulpanit@amd.com>
Content-Type: text/plain
X-Originating-IP: [165.204.78.2]
X-ClientProxiedBy: SN4PR0701CA0004.namprd07.prod.outlook.com
 (2603:10b6:803:28::14) To DM5PR12MB1163.namprd12.prod.outlook.com
 (2603:10b6:3:7a::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ethanolx5673host.amd.com (165.204.78.2) by SN4PR0701CA0004.namprd07.prod.outlook.com (2603:10b6:803:28::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.34 via Frontend Transport; Sun, 4 Oct 2020 01:42:03 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a9b027f6-1cd9-43f8-9dbd-08d86806b22e
X-MS-TrafficTypeDiagnostic: DM5PR12MB1451:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB14518DD8FCA6C9DA2597F972F30F0@DM5PR12MB1451.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c8093ofEhzIthbQEDdintbk2FbB/Ga97+BH1J7oXSGbmRG+CSpc15h4yzgW3XNuXWax16Ri4sFm3yYihOOur8j98W8JJ7JBgj0F5eChHIGPTY1CG3dJAvz9GkKDas7uFWb/TD5sKOqhGKyGwmhilN67LpoihP226+gDUvhKd59cuf7uo5Dm8xlwN5xAkww9fAmoPkFhMVv5Lv7RqvR2NK3KqQrV1QIj2Kerb6v+twjFFgPgWNsTrzNtjAR9Z9j7CW3FnkMR5wNz/x+RHPhcBr1RI21DqewfYogG9O5Xj/9YfZh+CzmtIDrB/eYLEd6eifpnQ29p2BL9HPTb9jXoX6g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB1163.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(376002)(136003)(366004)(39850400004)(2616005)(956004)(6486002)(316002)(66946007)(66476007)(66556008)(6666004)(478600001)(44832011)(1076003)(5660300002)(86362001)(8936002)(7696005)(52116002)(2906002)(36756003)(16526019)(26005)(186003)(4326008)(83380400001)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: z9FKjAnd8IYVhP2k7UyIUyFIFKw3GOm2BLJJTSkGQCYAdaIHRDeBXFkopwwM4OwOt354An17ImBd1zO7e5WyU/yIgefa0cvxYnWboCFp7hKuv7a7Lla+BG1pNsXNKe/3mEgklVJkrNLNM+3XoPjC2TjlxzosZmIrnoRSWZJrSOTUXcDYtugfX+sWhmnDmKcTmYim+DiK2fU8Gv+HT778EQLQLTKmaYzGn9O9pSfpLKoZpamElys47j66TJwMuVR1OzI+ZLYWLqZ5DaforUQRWVzp8JBK7g5sNbXxGGA+YqLokrtXiNqKbD+22+WtlyaoP37MvFusYo1yky1yfoS1ZD64YXXoaT8u/f6Tm6NgzpEMIuYODTBeaY60Fzq+jvbWg1JcKwl3Lt1+3j9Mcy6xYvR64l+GbaBTIsRmEyWcD+s6Jm/12bm8wG8LI1Bo8UgM03hV4SVvLwvqIFZHQH1edhUtWKu+3aCOLbhM4n8Q+z5Uqfk1PtwhYQUS/thwbwOI+3KAEXIlEJzHRATITSYxrQUgwTfFhWeRQ7al6iIEgJJF1rwVIIDNZo2c6JECrtrDOvzxU61zx4ORu6fvYEnA+gr4hc1TiwzGU6q3rIyYotLti/DO3CPo1XKYdM7+g0V952vT598H7CML1lapy9NDJQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9b027f6-1cd9-43f8-9dbd-08d86806b22e
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1163.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2020 01:42:04.4185
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wV2rSSJ9mxnBRilGb2JroEJhU0tbv9EJX3Gayg2LMcMg3i3RzoO6u63gRfCHxzw91454RUGt8qsVqcew3B62vg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1451
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This implements iova_to_phys for AMD IOMMU v1 pagetable,
which will be used by the IO page table framework.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/io_pgtable.c | 22 ++++++++++++++++++++++
 drivers/iommu/amd/iommu.c      | 16 +---------------
 2 files changed, 23 insertions(+), 15 deletions(-)

diff --git a/drivers/iommu/amd/io_pgtable.c b/drivers/iommu/amd/io_pgtable.c
index 93ff8cb452ed..7841e5e1e563 100644
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
@@ -505,6 +525,8 @@ static struct io_pgtable *v1_alloc_pgtable(struct io_pgtable_cfg *cfg, void *coo
 {
 	struct amd_io_pgtable *pgtable = io_pgtable_cfg_to_data(cfg);
 
+	pgtable->iop.ops.iova_to_phys = iommu_v1_iova_to_phys;
+
 	return &pgtable->iop;
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

