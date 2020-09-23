Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B21FC2757BA
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 14:11:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726593AbgIWMLU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 08:11:20 -0400
Received: from mail-dm6nam12on2056.outbound.protection.outlook.com ([40.107.243.56]:27233
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726487AbgIWMLU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 08:11:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lhnsarZ/0swVneZe5ZL2sJFQR4+VLbKo54wNqlY+EyZoWiuIkBUYCwgPtGlXPmsXZBR2GnHNhX8Cp7ptwu+GfvZ1NLP01nqa+lbgczWjdbI3Y7xlWF88nV9XhaFag43b0RkhcPydyWpJrimw56oiS1Zft+43wTQTpahQ+i5UnxM6C37+alWE8CEv4VlzIULmgSW9AUMrk9NdStn0gc1cDaKQnidK8/TTZDpF6HhVVB4g1Q+fMPsfXCUcJtehd7xt2KJLwBe7PjpUQM3+jjaSoIXKn+bLjoGB4LZu2x39ycaq97IMHVah66EfhF5z0lrqSSc6JIwEXpec8aGIxfaqnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=umFjYbxEyTaa42GA7i79rGIPyy83NGM4qxMSdnOE0GI=;
 b=ZpGfQluaT/UliuZ9LP40fCH1FXpgT6cGMbEdeLtsbnPlz2bl7S/LbIri2TiP/LgjLh3B7HOgDw46NE0e4Mn1QnsCgmIRhivQXWeMliKyfpoORVZ+HJnRxp2C0S9eP6xKs0yFBeqvMoEEqpgjv8tgvsTwUslp2C8ey0mQdtCv/whLNfrkSZCIcfawtHdTyWcuRKl7s7punuHvp4UBECG/iSUVlBy762ojl2zfgH18MnyipjVNWfjvsLgjvgaSSNfGEScfRHaobmhGgpQXrzo/t41pfgpxauNHJZRV8pZgEJRR4JAnPN9rAm/5GmAwgI+Xc9ok5ZY1tV2Tfu4t8j3kgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=umFjYbxEyTaa42GA7i79rGIPyy83NGM4qxMSdnOE0GI=;
 b=uU7AplVOGb4rntzanP2DrR9OeIAbx1K0DizxjnJ4QpkSmnvIreMQ+e9SQjwxPYupBobWiEAKp0oHetmYoLRg3ukZVhMxqdYhGm/LLMnZJVfocR2jpkhvQHNrmlCyfnl8L5RbF8P0zpdfo3C1yz7LEmNLp01+gnSEwcw7VJZHTiE=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1163.namprd12.prod.outlook.com (2603:10b6:3:7a::18) by
 DM6PR12MB4436.namprd12.prod.outlook.com (2603:10b6:5:2a3::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3412.20; Wed, 23 Sep 2020 12:10:40 +0000
Received: from DM5PR12MB1163.namprd12.prod.outlook.com
 ([fe80::48cf:d69:d457:1b1e]) by DM5PR12MB1163.namprd12.prod.outlook.com
 ([fe80::48cf:d69:d457:1b1e%5]) with mapi id 15.20.3412.022; Wed, 23 Sep 2020
 12:10:40 +0000
From:   Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Cc:     joro@8bytes.org, Jon.Grimm@amd.com, brijesh.singh@amd.com,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH v2 1/3] iommu: amd: Use 4K page for completion wait write-back semaphore
Date:   Wed, 23 Sep 2020 12:13:45 +0000
Message-Id: <20200923121347.25365-2-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200923121347.25365-1-suravee.suthikulpanit@amd.com>
References: <20200923121347.25365-1-suravee.suthikulpanit@amd.com>
Content-Type: text/plain
X-Originating-IP: [165.204.78.2]
X-ClientProxiedBy: SA0PR11CA0064.namprd11.prod.outlook.com
 (2603:10b6:806:d2::9) To DM5PR12MB1163.namprd12.prod.outlook.com
 (2603:10b6:3:7a::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ethanolx5673host.amd.com (165.204.78.2) by SA0PR11CA0064.namprd11.prod.outlook.com (2603:10b6:806:d2::9) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20 via Frontend Transport; Wed, 23 Sep 2020 12:10:39 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3828b096-238f-4d02-aab6-08d85fb9b01f
X-MS-TrafficTypeDiagnostic: DM6PR12MB4436:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB44360BDE5C6E9D05F2B31782F3380@DM6PR12MB4436.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 69cgDpr2Gp4ZArQDV5no9S9lUTw2RndLZ7yHW4B55oOK9EIrZNYZgz5f/vBUe4mCY1rX8JXuLerujpa9yP95ZW3D+JKMchFipALx5FO4Ua5SqQP7L07RSY5Wl4X/4M2twcl+jPGONy9y3WKm1o2RLy2w3PwpbHMMBMTaveHKQDEREFBTaoBtZe60rF2DUcjPc01WpZE2e9M/4/EqqscxyNfn7/bVX78z4+aa/XsK86xrX7rfmB7GkJhyxFR4d0msr3pVPZpB0LbAOp67iwV8yVodaArIhMInYn+n5BfzmZ235o2mqwN4P7jJY2XLGORlNj9hEJmfTMGVa2mH8MM4cg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB1163.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(346002)(39860400002)(376002)(136003)(186003)(16526019)(83380400001)(86362001)(956004)(2616005)(26005)(52116002)(7696005)(478600001)(8936002)(5660300002)(44832011)(6666004)(8676002)(66946007)(6486002)(66556008)(4326008)(66476007)(316002)(1076003)(2906002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: Vpy/izHrP2OPy4g1p3O5jEzdGXtPxsuiFXvhpT+DZpO41MyTPvhxqShOP829OC+qLOqRpNJ/z7hkt61SRb60aYWI95vGkaSHZPMUSY1ZLR0PtyDkJAXwGcLZZ7P5bfhb45Bvp2WiAHSKNnwywa/rTiGYtmtzP1tSnsRGSJ/mfwoLBOTOVqD8E1nbmpj2R+LnB6Y5fgmdhsWSNHtDAsIuGS5bd1lU+7H5sEr093lu/NWnBVuDW8oZmBtB6mwVKFxfMxhut89rpIqFquo9OvynJ2wraPPTqox59vChNmNx7uvgBOH4VLuNczcNJ1SLvjv6q5AOK/gZuf3aT8lY0p65o8/i3hWiTTitqRITvcxrTOmeWy5cpHCaN4/eotdfV5Ib9n/KwXEIXB2z07xQiO/z5DRwHKTVY1ajwbPi8N8fNLSK+9Sm0jOV3xCeZvdVsxbUVtc6JN4sLL5RN4D4AR0GeSODGum53561NHkA+8M7MIjjz9ytGjRbXISZwV45Hp9PUCcZ+321HB8tlSHYtw6IawTRfZCegaruoUe6kHct8XiWOGxWF9qV9P7zRMRBNdcAH2AARv8GgX+Fc9EYXcZGptEJToysjx+sgF/u4DrtN98L/oTQ5IfaKMBBumTmZbhThtqN4p74eRHbnBvR1L1U/A==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3828b096-238f-4d02-aab6-08d85fb9b01f
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1163.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2020 12:10:40.3398
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iL9O1SbAAOS5ox40F3pUxbI/qsbzLHC00GhyZKvYU/gNDZthke1ypSXMrRKygapYyK7lN6lWQY1k5Ib3roAdgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4436
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
index 10e4200d3552..9e9898683537 100644
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

