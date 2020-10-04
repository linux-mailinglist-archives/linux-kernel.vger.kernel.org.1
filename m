Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 841102827FA
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Oct 2020 03:43:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbgJDBmz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Oct 2020 21:42:55 -0400
Received: from mail-co1nam11on2088.outbound.protection.outlook.com ([40.107.220.88]:30688
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726274AbgJDBmv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Oct 2020 21:42:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bwXtTc29/2soIjU7WaNCV9nVIkzzDfb1S34tJDwhA7snowt2BGO6lGFCNcWjTLc508ZQ50F5wIxXWynDDF6hdE59vz31B1OCHM3dRh73MbgPVfVGyrFT+YJTiBrJ1p1fP+c5rs/vOizJZE4GhCnyoP3ReOS0bfSs6MzWSjqBcBozXfsRihC1tc5Q3Q/X+xsGOQKq3rO4h9W/FRzjW6as1YPHhVV3n3oE4u277wbSg5NRcRuqud6o9OtzT/GJlrdeXL6UscPzlQA4vlj3lz/KNAtz/Z8ZI7lcV2wdr5c44sCJrlqFwXUMXxjr38QxDfc6elg2KaFnP2j+0UGT11wN1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VwaXxZjoMCs+km1ZSSCYq/eqbsBpS3lS9jrdpUJSWJg=;
 b=FIar9O+QospNZTxPUXb28m1J5puBcZ31Mirga2kv8YfpS6TAd+O+cFO32mVmKB/QxMU5U+BNrT4yZ5ec6nGF7Gvc/jKw1iFNMPHn037RfZCGBrvpFa7SQDUaghG7PerI7hdTgZPYekRZqb8cr5q8Icmu8z+RO7HQyEridGren67oqdWhV3hNMiUbDXsrzbHezJZVtmcJ6G4oxh1JTb3dIX/po+OyjRYlXr3Vzhnljkfh0ysSZvm+doX9hGxL1apchs28R4LhONnjxpV4CqD0xsV1BfVWTwNEK3mfsLEIZhpHQlAZW838yoKT8ZTdUGUQ9sSq0X9WhIKVpCSTTgv+ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VwaXxZjoMCs+km1ZSSCYq/eqbsBpS3lS9jrdpUJSWJg=;
 b=ft5EAzF7ncfiRs7Fz4j8BCiV6zoViixOb+ExWXMFqvt6shA+Vai54CCyJYwS9gyERd2Ixg4Gdrff6CoXJIWuNQdOrR66NOBoNZeTNXdx5qFAD2NbGj7kXYOsrLAaahXTFSvhGfwQIJkb+VKOpZoPXd5EMB32lvfMPcmq6xujSEg=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1163.namprd12.prod.outlook.com (2603:10b6:3:7a::18) by
 DM5PR12MB1451.namprd12.prod.outlook.com (2603:10b6:4:d::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3433.39; Sun, 4 Oct 2020 01:42:07 +0000
Received: from DM5PR12MB1163.namprd12.prod.outlook.com
 ([fe80::48cf:d69:d457:1b1e]) by DM5PR12MB1163.namprd12.prod.outlook.com
 ([fe80::48cf:d69:d457:1b1e%5]) with mapi id 15.20.3433.042; Sun, 4 Oct 2020
 01:42:07 +0000
From:   Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Cc:     joro@8bytes.org, robin.murphy@arm.com,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH v3 14/14] iommu/amd: Adopt IO page table framework
Date:   Sun,  4 Oct 2020 01:45:49 +0000
Message-Id: <20201004014549.16065-15-suravee.suthikulpanit@amd.com>
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
Received: from ethanolx5673host.amd.com (165.204.78.2) by SN4PR0701CA0004.namprd07.prod.outlook.com (2603:10b6:803:28::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.34 via Frontend Transport; Sun, 4 Oct 2020 01:42:06 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8ca58a61-bada-4fd4-b574-08d86806b3d5
X-MS-TrafficTypeDiagnostic: DM5PR12MB1451:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB145178410C4DA5D652E5B8A3F30F0@DM5PR12MB1451.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /xdo+jtWuSrUk+fPn6Q2jeY38ioNYlYky1WqeeODnAYuYxzNNkdQQ/1CrhSUucrIAIr2CCt4WQEpV9fWa6mspYN9kQ+m5vr01RtwW+AbRTNTdWKhpSkrsniDgeZHTzKIDXSk5I+yf9KTDQOWS/tEeWb4TMqW2nTvBbXHeZOWdW+cfPNn/vtdpP98tjJwUzNlNrFN9xWhybAK+lcgFlrs/dAciqrPqTlLf3KR1S7WIpB56x07uJ5GqP4f66lPfDL1rx4Qrek+2927LGgO8rw2GMuayHT4F+RfKXICHiGgxvolalC13/ar5XeAPZuZs75ratR5BgpW/VkfcC2n8jQ5Ew==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB1163.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(376002)(136003)(366004)(39850400004)(2616005)(956004)(6486002)(316002)(66946007)(66476007)(66556008)(6666004)(478600001)(44832011)(1076003)(5660300002)(86362001)(8936002)(7696005)(52116002)(2906002)(36756003)(16526019)(26005)(186003)(4326008)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: cH3dOujC/laRVc3A1VWTP6j2wpP7EP+QuJ4ryhgQ/q526YFy6BNgDff/n3gYLrfGaaXkqLhqJkFk4OSVaB2EZL2VO2udzcJCcXRwU8yUVxmY0ne9zwAIsM3Gf1WNHz4SpXpmd5CpYF70thcmCNPu2ZpqURudNxKg7Y4tq2ZisY2GDKt6owA2finccSbS3yu6uSU4ncfO9ySPtN7IRpWoQBax9L9QZutFZhmq29/sc1qEdrfax1oBND5jFNiJcBxS46hazfbBxO+CJTR9yp+OUzHeQpnuSq1RRdI5zu9ZQ7vOLWSu8EtF99Nj7lhYbi8po2OwxZaG5ymrGM2Atm4c4VnENlMuQgpphll5xjiwRfMVshl9mIZCMGE8tjGFKxV93ZrcoM2KyxjG+jtCoYJ9gfcAd9DCBvLHBtKnuxHNo0yUeBp+ObEwnuTJvhmC+lyVTSQNqdVnrC6q4kLMX0nMeDq/vsFNLrt5xHoFt2tE+m+ikui0+8giGiC6Kos/hRbRnsFGuD7ePuBQD+jdwsr8gQB3bss2jyRAtrW1Xoy+Nz8kE+od7niCLYXWj69YKRJ13iO8jtIHM1yYRBn6OBDPBZA0vwqMuW0hmcO4adFsmg8SLyNgtshaCl2eARtypHN5ESIDiTYBdMwrfKzUJM8MgQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ca58a61-bada-4fd4-b574-08d86806b3d5
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1163.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2020 01:42:07.0754
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2qabKNKNE+iE4QCBG03KziizZeduHiooPfEU8p/Osm9FsIbtyS4jy90cHe27FS8XNb60N6wM99lEF7NH3sKFzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1451
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch to using IO page table framework for AMD IOMMU v1 page table.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/iommu.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 77f44b927ae7..6f8316206fb8 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -32,6 +32,7 @@
 #include <linux/irqdomain.h>
 #include <linux/percpu.h>
 #include <linux/iova.h>
+#include <linux/io-pgtable.h>
 #include <asm/irq_remapping.h>
 #include <asm/io_apic.h>
 #include <asm/apic.h>
@@ -1573,6 +1574,22 @@ static int pdev_iommuv2_enable(struct pci_dev *pdev)
 	return ret;
 }
 
+struct io_pgtable_ops *
+amd_iommu_setup_io_pgtable_ops(struct iommu_dev_data *dev_data,
+			       struct protection_domain *domain)
+{
+	struct amd_iommu *iommu = amd_iommu_rlookup_table[dev_data->devid];
+
+	domain->iop.pgtbl_cfg = (struct io_pgtable_cfg) {
+		.pgsize_bitmap	= AMD_IOMMU_PGSIZES,
+		.ias		= IOMMU_IN_ADDR_BIT_SIZE,
+		.oas		= IOMMU_OUT_ADDR_BIT_SIZE,
+		.iommu_dev	= &iommu->dev->dev,
+	};
+
+	return alloc_io_pgtable_ops(AMD_IOMMU_V1, &domain->iop.pgtbl_cfg, domain);
+}
+
 /*
  * If a device is not yet associated with a domain, this function makes the
  * device visible in the domain
@@ -1580,6 +1597,7 @@ static int pdev_iommuv2_enable(struct pci_dev *pdev)
 static int attach_device(struct device *dev,
 			 struct protection_domain *domain)
 {
+	struct io_pgtable_ops *pgtbl_ops;
 	struct iommu_dev_data *dev_data;
 	struct pci_dev *pdev;
 	unsigned long flags;
@@ -1623,6 +1641,12 @@ static int attach_device(struct device *dev,
 skip_ats_check:
 	ret = 0;
 
+	pgtbl_ops = amd_iommu_setup_io_pgtable_ops(dev_data, domain);
+	if (!pgtbl_ops) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
 	do_attach(dev_data, domain);
 
 	/*
@@ -1958,6 +1982,8 @@ static void amd_iommu_domain_free(struct iommu_domain *dom)
 	if (domain->dev_cnt > 0)
 		cleanup_domain(domain);
 
+	free_io_pgtable_ops(&domain->iop.iop.ops);
+
 	BUG_ON(domain->dev_cnt != 0);
 
 	if (!dom)
-- 
2.17.1

