Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4A7F2827F9
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Oct 2020 03:42:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726637AbgJDBmu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Oct 2020 21:42:50 -0400
Received: from mail-co1nam11on2088.outbound.protection.outlook.com ([40.107.220.88]:30688
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726195AbgJDBmn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Oct 2020 21:42:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XzCD7SfSziL1xB9F9RHwpV7vV4jVxTxaJAx1s4/j+hgoDbhS6/iRJyoVsk4GTbrx+XxLzXGGw3GIxSdLjrvRq2i9W96bnrxG7oV4Dbhn0QXoypu7Ko3oC4hBqKJFDThkp0OU4WcOrEeoGfibfSmaJmG4HDGIN1ut7UBv3/pZwMhoL1L/Hq/A4DpfdnLrmeNC5PZwUkMZic0ong32hp+wlQe5V2lZ6tzrcE8KU5dlWRLDixGQIK+w1IfdsLNDodkXILLj0/HsCGnANAICUS44gugaZH5mfd2zT00g82MDwgmoF6lGIHQ858xwrX2t+LkOpw/kXCI6skEWju6hTz3tjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l8Vj5RrMhQ4eQ9EsaPWoiDZDCk7ErYSNcBpa55eU2D4=;
 b=cEBZL/mVHN1IVdJvisIZQWon11irjDmqarzcUUpW3Ff62TuG45Awg6gRe2GwUcJc/s2lCWszLl6DIj0KQW45unTaWbF9EcNTmmDgL2n+kjzVN8AKpz3au5RVQa9ZSuU2DviOtbCGZcONs68jzJVixGsYIQ1pb56SVLB8xM24fOtPXvDFYcgxqa6OwlYmuvQFl1Pf1ATl+m4svNt5eoMalgzQ1Y9OJTJQAlGxCg2r6KRNcG41vyhIVDvS/Wau8jq67B14KzbVr7lAP21Rq38oo16w+6uj0iW9QpaVOyXAC19cSqc3kfnf02TFgZo+BbVq0rRDWuo2skRF1hVOgb0vCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l8Vj5RrMhQ4eQ9EsaPWoiDZDCk7ErYSNcBpa55eU2D4=;
 b=A/ab5qc14yqv2sAIJ/wpl84NYJSKLjmkOCfucL909OTdU0YDkKp7IzHZZwycmdpxu+Rn3V3irZV72lbrC5xZptQDVJsKoAu5daIZwoWW4H2qOuKwQR6S7ERC6D8OiCIPJUSVU81o5C7x3YWVR7eqnAaSYexKk7O1OHe7jbUw9r4=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1163.namprd12.prod.outlook.com (2603:10b6:3:7a::18) by
 DM5PR12MB1451.namprd12.prod.outlook.com (2603:10b6:4:d::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3433.39; Sun, 4 Oct 2020 01:42:06 +0000
Received: from DM5PR12MB1163.namprd12.prod.outlook.com
 ([fe80::48cf:d69:d457:1b1e]) by DM5PR12MB1163.namprd12.prod.outlook.com
 ([fe80::48cf:d69:d457:1b1e%5]) with mapi id 15.20.3433.042; Sun, 4 Oct 2020
 01:42:06 +0000
From:   Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Cc:     joro@8bytes.org, robin.murphy@arm.com,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH v3 13/14] iommu/amd: Introduce IOMMU flush callbacks
Date:   Sun,  4 Oct 2020 01:45:48 +0000
Message-Id: <20201004014549.16065-14-suravee.suthikulpanit@amd.com>
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
Received: from ethanolx5673host.amd.com (165.204.78.2) by SN4PR0701CA0004.namprd07.prod.outlook.com (2603:10b6:803:28::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.34 via Frontend Transport; Sun, 4 Oct 2020 01:42:05 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 732d38d4-f6e8-42e1-4e57-08d86806b341
X-MS-TrafficTypeDiagnostic: DM5PR12MB1451:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1451B31DEA638DF9CE3747A6F30F0@DM5PR12MB1451.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:655;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f5vfgYqnvb6CAW4IbRR0j3UOp1hboLdifZtr4vnas9Ta2eK/lXEj2wg0YdtH3dehPz/TImeca6sUdnz8bs584yPc4cy3yoGv/dVi04T60AUAP48ouNAzPSzQmLfOpOdlHguRJy4+U2sfrhJO9RyB7uH/k4C+uCu/eqT2EnRMVl0KuiAz2xydIrR7qtyLtZAk1CRiKwZ6tsGhJcQJgtD4Q0Lnx1ctKNv0jcjb3TLYgVb1tNAUcZyklY6Of5U3XGm0sI20YENKbhp/HEfTOTolT7e90Xi/amd1zTSoYm3/4dqLyNk0yTFSz79UeA0tjQ38JeVyrqs3ORm3dnCwbOsbgQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB1163.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(376002)(136003)(366004)(39850400004)(2616005)(956004)(6486002)(316002)(66946007)(66476007)(66556008)(6666004)(478600001)(44832011)(1076003)(5660300002)(86362001)(8936002)(7696005)(52116002)(2906002)(36756003)(16526019)(26005)(186003)(4326008)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: xK1EZ06Sqt4JrJ3LTw5n50KoYjcOosqYngvGK6hnRXSkyc/6yXRl0malJVf+VO8glWvgSmQe8qYG1yk/SOQ/bKPX5M/Gb4aUyR2CIYz5bOnmXuX3SWMLQWsr4UcrpJbXfC3wQS5f13T3dO1xdMdoH67VcAPFQMfNqluRRsuViRheCCPQZraVeCW4zSjNrRDP/HvJczZDi707tzQ9pOXkKWXCMHbPPc8NyqrbwwouCFpP7LDJvJHOxojQ4+UOrWHKKTRnLzKKspzs0hkF1RM6hDQLx83XJdycE1xAW4Y7nEa/JUi2xCCvIDewfHHfZu6vrWokBhgmO9E7lXCAjrhhM4N+R9JMv6Bs45hu2Yl0ljc6PeNkwCSSVvthKZahiFsd1ujZvyALUAQNjNdE/a2f9XTrpXi84m06Ku4klYEFdnkOJaQYXvMtiNQVxx3PXxtzEBQKzFQqlyLKkZau8ZG8W06LO83sTASjz+zJrUtd3bH9KcmNfrTwrMbnjrtzJG+WDipK8YK5Un6IsVo8zNdknSPBX13FdocGSOjXwwVa7IFuPRTdz11rYOlaolw9srkrg230Q7wl/v9TKqoJOO3zQQiLTLj8nlHD9LiGAafZyiek3Vnhp6nPJ09MXBGaWtDSPL3eOsWoYBZmSa0dE54UQw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 732d38d4-f6e8-42e1-4e57-08d86806b341
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1163.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2020 01:42:06.2407
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZZroTXfUQKC7zuBSof0zyjUKyoP0CeDC4x7g/evEyVTQn+P6I00nomenO+r23VNJ6y/jEILVTV8NpCHJ6s1Klg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1451
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add TLB flush callback functions, which are used by the IO
page table framework.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/io_pgtable.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/iommu/amd/io_pgtable.c b/drivers/iommu/amd/io_pgtable.c
index d8b329aa0bb2..3c2faa47ea5d 100644
--- a/drivers/iommu/amd/io_pgtable.c
+++ b/drivers/iommu/amd/io_pgtable.c
@@ -514,6 +514,33 @@ static phys_addr_t iommu_v1_iova_to_phys(struct io_pgtable_ops *ops, unsigned lo
 /*
  * ----------------------------------------------------
  */
+static void v1_tlb_flush_all(void *cookie)
+{
+}
+
+static void v1_tlb_flush_walk(unsigned long iova, size_t size,
+				  size_t granule, void *cookie)
+{
+}
+
+static void v1_tlb_flush_leaf(unsigned long iova, size_t size,
+				  size_t granule, void *cookie)
+{
+}
+
+static void v1_tlb_add_page(struct iommu_iotlb_gather *gather,
+					 unsigned long iova, size_t granule,
+					 void *cookie)
+{
+}
+
+const struct iommu_flush_ops v1_flush_ops = {
+	.tlb_flush_all	= v1_tlb_flush_all,
+	.tlb_flush_walk = v1_tlb_flush_walk,
+	.tlb_flush_leaf = v1_tlb_flush_leaf,
+	.tlb_add_page	= v1_tlb_add_page,
+};
+
 static void v1_free_pgtable(struct io_pgtable *iop)
 {
 }
@@ -526,6 +553,8 @@ static struct io_pgtable *v1_alloc_pgtable(struct io_pgtable_cfg *cfg, void *coo
 	pgtable->iop.ops.unmap        = iommu_v1_unmap_page;
 	pgtable->iop.ops.iova_to_phys = iommu_v1_iova_to_phys;
 
+	cfg->tlb = &v1_flush_ops;
+
 	return &pgtable->iop;
 }
 
-- 
2.17.1

