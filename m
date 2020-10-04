Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6985E2827F0
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Oct 2020 03:42:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726443AbgJDBmP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Oct 2020 21:42:15 -0400
Received: from mail-dm6nam10on2053.outbound.protection.outlook.com ([40.107.93.53]:62785
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726230AbgJDBmK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Oct 2020 21:42:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GC6T64CbspmzPm7o4CPDyKNrtDTbnvVr2chMUhVjesOy2gbIHGs/5NGhT9Jv+6us7HzBPsyiiXBA4XPGVWYUNTQCnPw755m9hX5JUNV2+TVTslOzte5gLSMfLfWtm++B5wut/3LUYVTDt/D26CgAy9lfIMOHgBR9dU9eegZPdOITzhKrVPlUrMBfKVqo6/yUDf9v4CoNDt8f5GcTcrHu/+A4Ez5A8TIYhvBPOs0jD4lIeF6Js/A7cZ+uSnatM3dHwK3SQixr84ajDYl5JA5fAYta2Rf8BFHQVwmsl4wfUA9iKmk9qgn2OkR1MoI5G/OSCK4M0oMqnvGvouRO7lIC7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rNX/JM2v2SQH2Wl3rW9HtjPDYQH/+fxGNy79UqPhfFk=;
 b=k49iRz/5CJ6c9as/A3g33mhBTD+3V6lCcdkOjhqsUQVUe4Q4VqxBZxePqBaX0Bf5O1VK48o2zPffN6rP33ReHEs6iK3+XCXbmwybXpYFeugiP3AGVb1rPGaCqQhzfH3Ip9kJhUsoVzua4Qo4oa5fssAuxVNx6ye4aln0p7dHKl0nqzYV967V2RiC8phTakcbh2eQ7JPDXBWulXUL0vnH66ZQ8lLng1gaGhjtQGTDX/fSDh2zwYhdZP9BE2b4HYnbQbVTx7dZcKlcWm0UtEPruX4Ldw8ha2JwMpRIm9yDMuN6c8WIaC/hXxZdDSAZ/DLjWSaW8CqeO1uwy3a2mSXxkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rNX/JM2v2SQH2Wl3rW9HtjPDYQH/+fxGNy79UqPhfFk=;
 b=0VpMfidUviCzWdprfqULJxzAshB3spFvFRBU0WL/7B0DNJRHrQ2zD8HT6R2OMF0nZqtqdBLqapNnUq0+TXSxPUat+wYSZvN4rVhjE1NZXgSXNBSTly2oebyeYmttfaPaEgAboDU3NLSDuyFqL1z//+8SM/Bxuas0yybOS8cedhA=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1163.namprd12.prod.outlook.com (2603:10b6:3:7a::18) by
 DM5PR12MB1451.namprd12.prod.outlook.com (2603:10b6:4:d::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3433.39; Sun, 4 Oct 2020 01:41:58 +0000
Received: from DM5PR12MB1163.namprd12.prod.outlook.com
 ([fe80::48cf:d69:d457:1b1e]) by DM5PR12MB1163.namprd12.prod.outlook.com
 ([fe80::48cf:d69:d457:1b1e%5]) with mapi id 15.20.3433.042; Sun, 4 Oct 2020
 01:41:58 +0000
From:   Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Cc:     joro@8bytes.org, robin.murphy@arm.com,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH v3 05/14] iommu/amd: Declare functions as extern
Date:   Sun,  4 Oct 2020 01:45:40 +0000
Message-Id: <20201004014549.16065-6-suravee.suthikulpanit@amd.com>
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
Received: from ethanolx5673host.amd.com (165.204.78.2) by SN4PR0701CA0004.namprd07.prod.outlook.com (2603:10b6:803:28::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.34 via Frontend Transport; Sun, 4 Oct 2020 01:41:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d83f1d53-b91b-4a91-abbf-08d86806ae51
X-MS-TrafficTypeDiagnostic: DM5PR12MB1451:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1451C5E217BDB592F1EE05BDF30F0@DM5PR12MB1451.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C+aPVlYZU5uHrPOjbp5UVDkgU18e6U8DHTCTGRIzJRuyFFBP8NQsBvZigOlw3N5twLk29tgR0z54MnQ7uFAr6K0lndON/H6A3pD1ezPs+lMpb7udDI4GDhxrtJ8xucgh2j+5/MZZFhkF/hB9XACUc4V7iGYTKQf551fKEv3dRW3WS5It2d3albSRWpbYXzXcKjQvNxtH/MPZrzzlNB3GlKB8ZcZZhQfG7eVTq/2Kln8JwPaRtJZ6E8PWK6GYxoys7icCs7d1xlfTXQqXnkezpYrqGmHFYoKJlN5YUm5B1yX2WEf00LizXJ0fpEGFzIUT1ZbdmRdLLQq5GiaxPxmxXg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB1163.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(376002)(136003)(366004)(39850400004)(2616005)(956004)(6486002)(316002)(66946007)(66476007)(66556008)(6666004)(478600001)(44832011)(1076003)(5660300002)(86362001)(8936002)(7696005)(52116002)(2906002)(36756003)(16526019)(26005)(186003)(4326008)(83380400001)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: HCAqXD36FuyUI7VDl+BEXKCPneZCG7b1w6lsE4rnXDMTjSMYsUf1kfyoRep29NDXLqADUCq1wyC6YE/KEgut+2AuUGBj0tL6xzdtJnIEj7PZWVK9x7M8zGH7E37Ddf8HRmBoc5whlBKIVJldmD21PmxAGbORfp4YNMut3mpssepLp0/U3+UmNjFfpodgbtPwSz/lT//OOZChGvzT+XFrmXImZ1iJtsYpjxPVc/5sKOMsWmiqy/MjvvtRFcC5xQvQAYxMT30CSDTuqYIAFjtCxIVU2RMnIrLiXCqYP/stlvuFhBx9x3z8zgCgebxB25d8x8eKwXyGd37ov1s3j9tQHtfuM+bKXivyE60RQwiSOsgNz3DM28RSPWNFsmCBjRpecEg6FOlCnWAOZOpnjrhqn7Xd3S+FUuArQM0wBM8ErPUxbuvLzbHRhA2uei3ISWAi98WnM+KjVa1tn0J7/bCMExEJ5nQejp74ryusKzwyUGkPpJTQ5I9REaV6m5c4FHaF8yt23DIMyrcRHrvFQq5bW4rB7TbwmyD68r90deGfMnhDvxCubRuohi2LAwkjwjvFyI8uDKy87HAGnSXHkhYxp7USJcR83nkL80ZtQtwbCo39vokU+5tuFuRV8YYoVFW8kIJfZLCfIvltKUfX0aN+Tg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d83f1d53-b91b-4a91-abbf-08d86806ae51
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1163.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2020 01:41:57.8164
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZTngvBHgxqX5X7Qfp7m/8FoyRAmY5GP7jvXPLUefB7bbZdfff3KbY45tCvnVwlJXOdpU/PXtK4v4iZQA9WvMLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1451
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

And move declaration to header file so that they can be included across
multiple files. There is no functional change.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu.h |  3 +++
 drivers/iommu/amd/iommu.c     | 39 +++++++++++++++++------------------
 2 files changed, 22 insertions(+), 20 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index 22ecacb71675..8b7be9171030 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -48,6 +48,9 @@ extern int amd_iommu_domain_enable_v2(struct iommu_domain *dom, int pasids);
 extern int amd_iommu_flush_page(struct iommu_domain *dom, int pasid,
 				u64 address);
 extern void amd_iommu_update_and_flush_device_table(struct protection_domain *domain);
+extern void amd_iommu_domain_update(struct protection_domain *domain);
+extern void amd_iommu_domain_flush_complete(struct protection_domain *domain);
+extern void amd_iommu_domain_flush_tlb_pde(struct protection_domain *domain);
 extern int amd_iommu_flush_tlb(struct iommu_domain *dom, int pasid);
 extern int amd_iommu_domain_set_gcr3(struct iommu_domain *dom, int pasid,
 				     unsigned long cr3);
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 09da37c4c9c4..f91f35edb7ba 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -88,7 +88,6 @@ struct iommu_cmd {
 
 struct kmem_cache *amd_iommu_irq_cache;
 
-static void update_domain(struct protection_domain *domain);
 static void detach_device(struct device *dev);
 
 /****************************************************************************
@@ -1294,12 +1293,12 @@ static void domain_flush_pages(struct protection_domain *domain,
 }
 
 /* Flush the whole IO/TLB for a given protection domain - including PDE */
-static void domain_flush_tlb_pde(struct protection_domain *domain)
+void amd_iommu_domain_flush_tlb_pde(struct protection_domain *domain)
 {
 	__domain_flush_pages(domain, 0, CMD_INV_IOMMU_ALL_PAGES_ADDRESS, 1);
 }
 
-static void domain_flush_complete(struct protection_domain *domain)
+void amd_iommu_domain_flush_complete(struct protection_domain *domain)
 {
 	int i;
 
@@ -1324,7 +1323,7 @@ static void domain_flush_np_cache(struct protection_domain *domain,
 
 		spin_lock_irqsave(&domain->lock, flags);
 		domain_flush_pages(domain, iova, size);
-		domain_flush_complete(domain);
+		amd_iommu_domain_flush_complete(domain);
 		spin_unlock_irqrestore(&domain->lock, flags);
 	}
 }
@@ -1481,7 +1480,7 @@ static bool increase_address_space(struct protection_domain *domain,
 	pgtable.root  = pte;
 	pgtable.mode += 1;
 	amd_iommu_update_and_flush_device_table(domain);
-	domain_flush_complete(domain);
+	amd_iommu_domain_flush_complete(domain);
 
 	/*
 	 * Device Table needs to be updated and flushed before the new root can
@@ -1734,8 +1733,8 @@ static int iommu_map_page(struct protection_domain *dom,
 		 * Updates and flushing already happened in
 		 * increase_address_space().
 		 */
-		domain_flush_tlb_pde(dom);
-		domain_flush_complete(dom);
+		amd_iommu_domain_flush_tlb_pde(dom);
+		amd_iommu_domain_flush_complete(dom);
 		spin_unlock_irqrestore(&dom->lock, flags);
 	}
 
@@ -1978,10 +1977,10 @@ static void do_detach(struct iommu_dev_data *dev_data)
 	device_flush_dte(dev_data);
 
 	/* Flush IOTLB */
-	domain_flush_tlb_pde(domain);
+	amd_iommu_domain_flush_tlb_pde(domain);
 
 	/* Wait for the flushes to finish */
-	domain_flush_complete(domain);
+	amd_iommu_domain_flush_complete(domain);
 
 	/* decrease reference counters - needs to happen after the flushes */
 	domain->dev_iommu[iommu->index] -= 1;
@@ -2114,9 +2113,9 @@ static int attach_device(struct device *dev,
 	 * left the caches in the IOMMU dirty. So we have to flush
 	 * here to evict all dirty stuff.
 	 */
-	domain_flush_tlb_pde(domain);
+	amd_iommu_domain_flush_tlb_pde(domain);
 
-	domain_flush_complete(domain);
+	amd_iommu_domain_flush_complete(domain);
 
 out:
 	spin_unlock(&dev_data->lock);
@@ -2277,7 +2276,7 @@ void amd_iommu_update_and_flush_device_table(struct protection_domain *domain)
 	domain_flush_devices(domain);
 }
 
-static void update_domain(struct protection_domain *domain)
+void amd_iommu_domain_update(struct protection_domain *domain)
 {
 	struct domain_pgtable pgtable;
 
@@ -2286,8 +2285,8 @@ static void update_domain(struct protection_domain *domain)
 	amd_iommu_update_and_flush_device_table(domain);
 
 	/* Flush domain TLB(s) and wait for completion */
-	domain_flush_tlb_pde(domain);
-	domain_flush_complete(domain);
+	amd_iommu_domain_flush_tlb_pde(domain);
+	amd_iommu_domain_flush_complete(domain);
 }
 
 int __init amd_iommu_init_api(void)
@@ -2675,8 +2674,8 @@ static void amd_iommu_flush_iotlb_all(struct iommu_domain *domain)
 	unsigned long flags;
 
 	spin_lock_irqsave(&dom->lock, flags);
-	domain_flush_tlb_pde(dom);
-	domain_flush_complete(dom);
+	amd_iommu_domain_flush_tlb_pde(dom);
+	amd_iommu_domain_flush_complete(dom);
 	spin_unlock_irqrestore(&dom->lock, flags);
 }
 
@@ -2766,7 +2765,7 @@ void amd_iommu_domain_direct_map(struct iommu_domain *dom)
 	amd_iommu_domain_clr_pt_root(domain);
 
 	/* Make changes visible to IOMMUs */
-	update_domain(domain);
+	amd_iommu_domain_update(domain);
 
 	/* Page-table is not visible to IOMMU anymore, so free it */
 	free_pagetable(&pgtable);
@@ -2810,7 +2809,7 @@ int amd_iommu_domain_enable_v2(struct iommu_domain *dom, int pasids)
 	domain->glx      = levels;
 	domain->flags   |= PD_IOMMUV2_MASK;
 
-	update_domain(domain);
+	amd_iommu_domain_update(domain);
 
 	ret = 0;
 
@@ -2847,7 +2846,7 @@ static int __flush_pasid(struct protection_domain *domain, int pasid,
 	}
 
 	/* Wait until IOMMU TLB flushes are complete */
-	domain_flush_complete(domain);
+	amd_iommu_domain_flush_complete(domain);
 
 	/* Now flush device TLBs */
 	list_for_each_entry(dev_data, &domain->dev_list, list) {
@@ -2873,7 +2872,7 @@ static int __flush_pasid(struct protection_domain *domain, int pasid,
 	}
 
 	/* Wait until all device TLBs are flushed */
-	domain_flush_complete(domain);
+	amd_iommu_domain_flush_complete(domain);
 
 	ret = 0;
 
-- 
2.17.1

