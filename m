Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1838729DA40
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 00:18:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390201AbgJ1XS2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 19:18:28 -0400
Received: from mail-dm6nam12on2063.outbound.protection.outlook.com ([40.107.243.63]:42592
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728243AbgJ1XS0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 19:18:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LeB+hbc0IE++pqcDTTNHb1DLQOLc4HjswhT9EIczRJ3bhMge11R3hhyMGuZGk5NjhmKkhvau6KmWRmmZ8HAYmlUPWjrUcX1eJH3wcpNW7v031bscE5S3oxlbvi/jVGjTouzEyRTtvxvElLzV5CnrS9/GdvNHqyiBpWfaRftdrs22j1F3/u+jmdMojs3iA4Ku/pzjWNOaeV2XVfBDBeo0IQ9yhi+NScks033xk6f23WWBcICdN+BBGvdHX3RV04J14s85sTjg2rNcfXWpTsp6rhyN8SEIsn68IxFu7ks+YHHJQJb/vYjuPctrJ90Il3K+TBe6lwL9GRBL9sL/OJN7XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I/dlk6mcgqvmAMDs0Xs2HAvrC2z1sZmq00iu1TcJmpQ=;
 b=FY+CpO0pgvNJ427Z3DUmvWZJ6HDVxlay6CObl4e0uSR+gPCUin/YFFdQXpqKwz0XXhbTyOUVxnpez95TeBNgXjrkiSv+ADNASp8J5RRp3FowZ3Il9owux66ArAClputFbM98869rZTZzqUrbMm4zVQzRL1zpWtgKkqyJbRPmo3/G/uAz4f4vMXqpfKJ7HOVoYo/p0d0Ofh5j8UoqH//NGG+792KAgRGkHGk2j1YwvaZ5JpowtcI3xcKzQmyzybDQ/xjOOfOT1xHLT5jfoDfqGIdxoGephfqOLlNTl+Ys/qdHoQ1/htFYzg8PxP3XMb1Ra0QdfpZXi+r9YajJ1GYiIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I/dlk6mcgqvmAMDs0Xs2HAvrC2z1sZmq00iu1TcJmpQ=;
 b=T7U2o/08RYUnE8QgY4tBfBu1GkCngAtz1mPQeh6SWVGIRlJaH6gZ9l9i6C60QybPLZ0IOywtMsg8yRMorxQCOw0JtKPQLedP9XjVWP7mc4H45PtW3hAUzzsxNHIuKV/tgxlSv8i6vIuADVPSvyacY+AEMcWZiK7uuVufjFZllNM=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4597.namprd12.prod.outlook.com (2603:10b6:a03:10b::14)
 by BYAPR12MB3141.namprd12.prod.outlook.com (2603:10b6:a03:da::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20; Wed, 28 Oct
 2020 23:18:22 +0000
Received: from BYAPR12MB4597.namprd12.prod.outlook.com
 ([fe80::74c5:c3c5:26ae:524c]) by BYAPR12MB4597.namprd12.prod.outlook.com
 ([fe80::74c5:c3c5:26ae:524c%2]) with mapi id 15.20.3499.027; Wed, 28 Oct 2020
 23:18:22 +0000
From:   Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Cc:     joro@8bytes.org, Jon.Grimm@amd.com, brijesh.singh@amd.com,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH] iommu/amd: Enforce 4k mapping for certain IOMMU data structures
Date:   Wed, 28 Oct 2020 23:18:24 +0000
Message-Id: <20201028231824.56504-1-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-Originating-IP: [165.204.78.2]
X-ClientProxiedBy: DM5PR04CA0037.namprd04.prod.outlook.com
 (2603:10b6:3:12b::23) To BYAPR12MB4597.namprd12.prod.outlook.com
 (2603:10b6:a03:10b::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ethanolx5673host.amd.com (165.204.78.2) by DM5PR04CA0037.namprd04.prod.outlook.com (2603:10b6:3:12b::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend Transport; Wed, 28 Oct 2020 23:18:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8c548f17-0e8c-4b99-7ac6-08d87b97c2f3
X-MS-TrafficTypeDiagnostic: BYAPR12MB3141:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB31419F284E73094CC05A105EF3170@BYAPR12MB3141.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:923;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WPkWLU2rbaCTsvmxCE5IgDHmwiAFHxVoPTxzs4pD0KFybUknjs/4hxmwvUj1vmtrPIWqEd2OLfgqfxUhO2Vi8sGpIItiNmojrefBJpU+HC+MoCGLN7hL6jM+1xwMUjDtdweGzP5LtGGNMQepLHKceJwf2miwmP8ZVneGrz1BGL7O2VFpWD9EZdXgwn3P5+M+tOz+zsEdw6kd5/uWlnLXk143dsYBfCc2gDbe4mKxXSVc5/tkp6z80oN2mlGjx8urOkHYwDURujmXdOTLUHq6F5eYkIa9NFrmjobdaXRZVZcJl0jAbmJ8Q7FAxwELFR4f
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4597.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(396003)(39860400002)(366004)(376002)(8676002)(36756003)(478600001)(66946007)(5660300002)(316002)(1076003)(52116002)(83380400001)(86362001)(6486002)(16526019)(66556008)(7696005)(8936002)(66476007)(4326008)(44832011)(2906002)(2616005)(186003)(26005)(956004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: eSEIoT8GzsGCgoBvcKpNPPNLA2rZHOIm/LKt4h7sFZJwulxDsZRLeiBlVDisUwLovall1pE+Dz39NNOIzoX7TAamJH7XVwRdLMveWtB+1Np3KZN1UryRYxpGd0TSGYvIFp7ni+R4/ImvX2bxKUEx/AVPRAnKjrUKQm+8gTdDvz5S4qa6ze6KgYkmFhZ+ns8t7a3pfBBkTZ92V00miUvmxyzYYx58tDJVLGGIs4afG9jYD3NuD83Fs+XCjlhSqk8gl/FXo0RTKGKWHtFW+FAi4MPStfJANDHoC9cAm1ZMDHCyjRxw1IN778i67KrwwwaisvSXIVVDmGo82//C7/txB8iO7AMMnfhsjB0VZSYMmpbvWuqu3i6HW0htjy0yIBflbv+ANEIWJmDkjMDIQCrCKB64sbvQHF3YWkWaH8LUDF8QEM/ZHqeLJN9jdXZsmRjqod0l9wCSjS+Xmf+tQ11lI4QeAwN/xj03iQANdY/BL1Saq1jN6pPX5pklo0Fqo/NWzkPD6iV5g3iHb6qHJAyN6swTBv6y3KklVg3BKoK+35RUYcWpXI5nqKl3VVfh3rX5xeJNAiW6fFp8XCbewg4EFlIE3SAgxmiBbTQCAnju10M40wg5KwYAg8ntckkfv9yOnow8TI7MY2IZBrf3oGqhNg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c548f17-0e8c-4b99-7ac6-08d87b97c2f3
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4597.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2020 23:18:21.9996
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OzB7LEMpvY7dUFp+4XVfHT1uHgz9RDg9edL9WG132OL38Twz1X2YNhwCfHkg+6H/yfANlNLazTj9cEyEblz/0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3141
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AMD IOMMU requires 4k-aligned pages for the event log, the PPR log,
and the completion wait write-back regions. However, when allocating
the pages, they could be part of large mapping (e.g. 2M) page.
This causes #PF due to the SNP RMP hardware enforces the check based
on the page level for these data structures.

So, fix by calling set_memory_4k() on the allocated pages.

Fixes: commit c69d89aff393 ("iommu/amd: Use 4K page for completion wait write-back semaphore")
Cc: Brijesh Singh <brijesh.singh@amd.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/init.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 82e4af8f09bb..75dc30226a7c 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -29,6 +29,7 @@
 #include <asm/iommu_table.h>
 #include <asm/io_apic.h>
 #include <asm/irq_remapping.h>
+#include <asm/set_memory.h>
 
 #include <linux/crash_dump.h>
 
@@ -672,11 +673,22 @@ static void __init free_command_buffer(struct amd_iommu *iommu)
 	free_pages((unsigned long)iommu->cmd_buf, get_order(CMD_BUFFER_SIZE));
 }
 
+static void *__init iommu_alloc_4k_pages(gfp_t gfp, size_t size)
+{
+	void *buf;
+	int order = get_order(size);
+
+	buf = (void *)__get_free_pages(gfp, order);
+	if (!buf)
+		return buf;
+	return set_memory_4k((unsigned long)buf, (1 << order)) ? NULL : buf;
+}
+
 /* allocates the memory where the IOMMU will log its events to */
 static int __init alloc_event_buffer(struct amd_iommu *iommu)
 {
-	iommu->evt_buf = (void *)__get_free_pages(GFP_KERNEL | __GFP_ZERO,
-						  get_order(EVT_BUFFER_SIZE));
+	iommu->evt_buf = iommu_alloc_4k_pages(GFP_KERNEL | __GFP_ZERO,
+					      EVT_BUFFER_SIZE);
 
 	return iommu->evt_buf ? 0 : -ENOMEM;
 }
@@ -715,8 +727,8 @@ static void __init free_event_buffer(struct amd_iommu *iommu)
 /* allocates the memory where the IOMMU will log its events to */
 static int __init alloc_ppr_log(struct amd_iommu *iommu)
 {
-	iommu->ppr_log = (void *)__get_free_pages(GFP_KERNEL | __GFP_ZERO,
-						  get_order(PPR_LOG_SIZE));
+	iommu->ppr_log = iommu_alloc_4k_pages(GFP_KERNEL | __GFP_ZERO,
+					      PPR_LOG_SIZE);
 
 	return iommu->ppr_log ? 0 : -ENOMEM;
 }
@@ -838,7 +850,7 @@ static int iommu_init_ga(struct amd_iommu *iommu)
 
 static int __init alloc_cwwb_sem(struct amd_iommu *iommu)
 {
-	iommu->cmd_sem = (void *)get_zeroed_page(GFP_KERNEL);
+	iommu->cmd_sem = iommu_alloc_4k_pages(GFP_KERNEL | __GFP_ZERO, 1);
 
 	return iommu->cmd_sem ? 0 : -ENOMEM;
 }
-- 
2.17.1

