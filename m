Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3BCC26C6B6
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 20:01:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727725AbgIPSAv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 14:00:51 -0400
Received: from mail-dm6nam08on2041.outbound.protection.outlook.com ([40.107.102.41]:38292
        "EHLO NAM04-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727707AbgIPR7E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 13:59:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZVrwO00QghnnT1gDOuTbQPv1HSVEBUpssVJ/nGOPTy+ZOM2nY7IlbaLUS83ym0r1vcwWQt25ny92haEsqUu0yfVWAhfn/G2U8dREG91RmXH86PTPlyHAQl2jhKLSKH7eSc50a9uJeyhakykJBSx+jB51+Ciwvnz6Al7/PA9PIkfRJ/fCHCqA7amO9LKsUCFpZ1ijPG1SgtwlWloqltD6ezmEF4mQSl5uzkPbmakjRDo93s6t2HORFf01Nvewhca4lEWG0QyQwTJioUoOOttnzdmSj+Mmna3joTVUMGSxpg2G4hvxTfOyyLjsJQecoM6UDms4X9N2RmpeSrSiulU2sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ExHi+3yx7zLviuGK7TTB7uW3ccRMCOlvs6zRng7c5G8=;
 b=PjM2ELOrI1mGAq9Iw3OIhPcPX1ednDgQXhUTyIbF7FuKLvY3QihN1BXp+J0lk3OI3hGQTRC+xPFEaZscign80nEKmJeAdxgwEeAyQTtqy7A6K7X2cAwf0bCDNDMVB/HmeEbffTQ44SjTSWeRDt+waE/O0oihx5w7yMFBH5pYlNpvnAtAQaXHM9uiQkh9VHtF9JJyjKcyQZsYpsg8wKX8TT5l6OhZxeEywF9pD9JZ3v/XWZXnG3rv2X3Dc78LjqADhLpV4tJ7ARfBRdn7g8hGWItt41Yvx1vCvRfph8Ftkn7tvIunxJt4zocWnyCGPFdm6X5r+rlp9SDhTOJ3AmMaZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ExHi+3yx7zLviuGK7TTB7uW3ccRMCOlvs6zRng7c5G8=;
 b=F/SuVaRgeanGewb5i9d1REZYfeJpi3ujtZZEF3WS9ibTJ+/v1qgsGVNlP/6KmPsgCeUmSIYI0i19imvTKZpI4KZPi2qBueT8kbydDMEGWljYK/KJC2U2ctVUkrnOBiAHdv4lAcuPcX12e/+Y+YQQ45JW41at6zmLICgzMrpD3x8=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1163.namprd12.prod.outlook.com (10.168.240.18) by
 DM5PR1201MB0123.namprd12.prod.outlook.com (10.174.104.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3391.11; Wed, 16 Sep 2020 13:53:06 +0000
Received: from DM5PR12MB1163.namprd12.prod.outlook.com
 ([fe80::48cf:d69:d457:1b1e]) by DM5PR12MB1163.namprd12.prod.outlook.com
 ([fe80::48cf:d69:d457:1b1e%5]) with mapi id 15.20.3370.019; Wed, 16 Sep 2020
 13:53:06 +0000
From:   Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Cc:     joro@8bytes.org, Jon.Grimm@amd.com, brijesh.singh@amd.com,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH 1/3] iommu: amd: Use 4K page for completion wait write-back semaphore
Date:   Wed, 16 Sep 2020 13:55:47 +0000
Message-Id: <20200916135549.146468-2-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200916135549.146468-1-suravee.suthikulpanit@amd.com>
References: <20200916135549.146468-1-suravee.suthikulpanit@amd.com>
Content-Type: text/plain
X-ClientProxiedBy: SA9PR10CA0011.namprd10.prod.outlook.com
 (2603:10b6:806:a7::16) To DM5PR12MB1163.namprd12.prod.outlook.com
 (2603:10b6:3:7a::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ethanolx5673host.amd.com (165.204.78.2) by SA9PR10CA0011.namprd10.prod.outlook.com (2603:10b6:806:a7::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16 via Frontend Transport; Wed, 16 Sep 2020 13:53:05 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.78.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 023cad4c-0525-43f4-f20e-08d85a47d6b6
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0123:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1201MB0123C7E5D027CE5C0886A31AF3210@DM5PR1201MB0123.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6FVfpNejQqexhPly3S9amHH3DgvmkixiIhZlFDnbL2x5i08y2dn5qZBVh6OQ9q2iZpEfNueKLQ9OnspEcESp6Jco/+lrfSBG/bkIHBO2d+ReDK4fU+R5V3RB+rf7T/+s79OjBjNhrX0Tx+0vnRs2sm78maDZvQ/QARLQ409C34kRrvsd/6nfrrFvhNIWHYuSl7IxCO/3GaVwuU5F6udNHR7BwHe1fhmeuTn9CA+APp4NnI5YyzowZwM7YNAiSb4Cz5s7Q0xT8tE5h7RT1UKYBTQBTQrKxDFxwF3134+Jvk3+iHpNm4eR2npqHad49M0hI4jGhNrKudrF4a7mpQ6zrg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB1163.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(376002)(136003)(346002)(39860400002)(186003)(956004)(2616005)(478600001)(44832011)(83380400001)(26005)(16526019)(6666004)(4326008)(8936002)(6486002)(316002)(86362001)(66946007)(52116002)(5660300002)(66476007)(66556008)(7696005)(36756003)(2906002)(8676002)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: po1uU+m46k/mKCVoMIq2MzL7+az7andu8q7eYT5VKtkB5+YqStlTHM3pIChuQ+/yIzHOX4bw78Bd8aJSDX0tHf0WIVVbpICVksxhhbsDRcWYwbIwKRAATN2RS8IbwNtkFyTDa3rUnwOGOGBYeLYMSlXGEb45rkc2G4SajxJgwPmqgn2Z8NUas6JPILDTLLTw/vM39UlnKD1NYfNKvZMsIZvSPiT7o89potPbraUDb0n4DPiug7qyoF8XM6Z2kbta7MUAiC1Sh8tTgQoMkUsNNxJQ38w6tvbJzqCjMl5afBVQb+lVznsSP5Vp1YW/D8npXnZwbbiw7K4PA3dnBCNfR+MoE0yyb21Oo8tNcSgzoJrkhLFF5mj7vQmJ59Gy04mpDS6Q0DLAn5PIN32VgzhrjVz8nYALwVMaTZ4qyas0IQTuAMOcWfMpy/MjbCxGVZDSo+rJET3EwLW0Kmm4SUyE2AAqdYybmSzlRBQk9B6Mn1aNrInDb2RYmbUOs8yeoZntWPPXOQHUMCdRNX29iLOHoO6wyKPKQ/C9y/8pNbdlaAOtRX2KTbgizftFKN6p6q6xrLSxkRTWtsKlHoYh6tM6ww88ifIuLjD9MFwwzhA9SKv2vHtagVSzRi64MX0fEOy3JNK5A7UXP5CqebymSj2gRA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 023cad4c-0525-43f4-f20e-08d85a47d6b6
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1163.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2020 13:53:06.6750
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z1NqJNZmtE882SVtY1znJyTa6TbE74ga+BZz7gD/tBgOenoiir1bPEpoy4At68cuv9qqMoHgvJyJTDK3zQkA7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0123
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IOMMU SNP support requires the completion wait write-back semaphore to be
implemented using a 4K-aligned page, where the page address is to be
programmed into the newly introduced MMIO base/range registers.

This new scheme uses a per-iommu atomic variable to store the current
semaphore value, which is incremented for every completion wait command.

Since this new scheme is also compatible with non-SNP mode,
generalize the driver to use 4K page for completion-wait semaphore in
both modes.

Cc: Brijesh Singh <brijesh.singh@amd.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h |  3 ++-
 drivers/iommu/amd/init.c            | 18 ++++++++++++++++++
 drivers/iommu/amd/iommu.c           | 23 +++++++++++------------
 3 files changed, 31 insertions(+), 13 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 30a5d412255a..4c80483e78ec 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -595,7 +595,8 @@ struct amd_iommu {
 #endif
 
 	u32 flags;
-	volatile u64 __aligned(8) cmd_sem;
+	volatile u64 *cmd_sem;
+	u64 cmd_sem_val;
 
 #ifdef CONFIG_AMD_IOMMU_DEBUGFS
 	/* DebugFS Info */
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 445a08d23fed..febc072f2717 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -813,6 +813,19 @@ static int iommu_init_ga(struct amd_iommu *iommu)
 	return ret;
 }
 
+static int __init alloc_cwwb_sem(struct amd_iommu *iommu)
+{
+	iommu->cmd_sem = (void *)get_zeroed_page(GFP_KERNEL);
+
+	return iommu->cmd_sem ? 0 : -ENOMEM;
+}
+
+static void __init free_cwwb_sem(struct amd_iommu *iommu)
+{
+	if (iommu->cmd_sem)
+		free_page((unsigned long)iommu->cmd_sem);
+}
+
 static void iommu_enable_xt(struct amd_iommu *iommu)
 {
 #ifdef CONFIG_IRQ_REMAP
@@ -1395,6 +1408,7 @@ static int __init init_iommu_from_acpi(struct amd_iommu *iommu,
 
 static void __init free_iommu_one(struct amd_iommu *iommu)
 {
+	free_cwwb_sem(iommu);
 	free_command_buffer(iommu);
 	free_event_buffer(iommu);
 	free_ppr_log(iommu);
@@ -1481,6 +1495,7 @@ static int __init init_iommu_one(struct amd_iommu *iommu, struct ivhd_header *h)
 	int ret;
 
 	raw_spin_lock_init(&iommu->lock);
+	iommu->cmd_sem_val = 0;
 
 	/* Add IOMMU to internal data structures */
 	list_add_tail(&iommu->list, &amd_iommu_list);
@@ -1558,6 +1573,9 @@ static int __init init_iommu_one(struct amd_iommu *iommu, struct ivhd_header *h)
 	if (!iommu->mmio_base)
 		return -ENOMEM;
 
+	if (alloc_cwwb_sem(iommu))
+		return -ENOMEM;
+
 	if (alloc_command_buffer(iommu))
 		return -ENOMEM;
 
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 07ae8b93887e..a1d2c749a21f 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -792,11 +792,11 @@ irqreturn_t amd_iommu_int_handler(int irq, void *data)
  *
  ****************************************************************************/
 
-static int wait_on_sem(volatile u64 *sem)
+static int wait_on_sem(struct amd_iommu *iommu, u64 data)
 {
 	int i = 0;
 
-	while (*sem == 0 && i < LOOP_TIMEOUT) {
+	while (*iommu->cmd_sem != data && i < LOOP_TIMEOUT) {
 		udelay(1);
 		i += 1;
 	}
@@ -827,16 +827,16 @@ static void copy_cmd_to_buffer(struct amd_iommu *iommu,
 	writel(tail, iommu->mmio_base + MMIO_CMD_TAIL_OFFSET);
 }
 
-static void build_completion_wait(struct iommu_cmd *cmd, u64 address)
+static void build_completion_wait(struct iommu_cmd *cmd,
+				  struct amd_iommu *iommu,
+				  u64 data)
 {
-	u64 paddr = iommu_virt_to_phys((void *)address);
-
-	WARN_ON(address & 0x7ULL);
+	u64 paddr = iommu_virt_to_phys((void *)iommu->cmd_sem);
 
 	memset(cmd, 0, sizeof(*cmd));
 	cmd->data[0] = lower_32_bits(paddr) | CMD_COMPL_WAIT_STORE_MASK;
 	cmd->data[1] = upper_32_bits(paddr);
-	cmd->data[2] = 1;
+	cmd->data[2] = data;
 	CMD_SET_TYPE(cmd, CMD_COMPL_WAIT);
 }
 
@@ -1045,22 +1045,21 @@ static int iommu_completion_wait(struct amd_iommu *iommu)
 	struct iommu_cmd cmd;
 	unsigned long flags;
 	int ret;
+	u64 data;
 
 	if (!iommu->need_sync)
 		return 0;
 
-
-	build_completion_wait(&cmd, (u64)&iommu->cmd_sem);
-
 	raw_spin_lock_irqsave(&iommu->lock, flags);
 
-	iommu->cmd_sem = 0;
+	data = ++iommu->cmd_sem_val;
+	build_completion_wait(&cmd, iommu, data);
 
 	ret = __iommu_queue_command_sync(iommu, &cmd, false);
 	if (ret)
 		goto out_unlock;
 
-	ret = wait_on_sem(&iommu->cmd_sem);
+	ret = wait_on_sem(iommu, data);
 
 out_unlock:
 	raw_spin_unlock_irqrestore(&iommu->lock, flags);
-- 
2.17.1

