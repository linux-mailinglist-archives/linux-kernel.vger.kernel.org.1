Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C8032757BB
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 14:11:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbgIWML3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 08:11:29 -0400
Received: from mail-dm6nam12on2066.outbound.protection.outlook.com ([40.107.243.66]:21792
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726545AbgIWML2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 08:11:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HXJWSTDicXzSmoqZzKcBgnGAvxZmkJoi6c+yc/tzsRbszVqCnHNI/kBbtzJzBme6IHykBAiUqpQPq8MAsTbRRieB9oRv7fmlETEZCLgAfDdASN9Mfx/pWcYqLrd2Ewg9IR1ZfC1TYR3V566dpX5FtBHi2Hc8V6Z3UDa74eq+A1NrgVm1E4ijh42T8M3k0evVfnxTx74yDrFX6od5TR7SicdaDCseC6eFRaTg5/QdreOV5DK2JUzVhFY4iGCffzn1d1p2m5By9T+pLifJRg/JgI4xrHRAOxfzhIuwG26bkXZ0VSR+mugEGq6ktuPZruAu/7ww9NacWw+MUxiL/Z6K8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=smE8+AIfqauQ4YA7bahAZF1oKXyQW6Pvf5YxuIURUbA=;
 b=MPM/PClTpxk0+Y6txMsnfNBW7qB9GN7n+MsArv3rWtZc6A3KYltjVDDlcBQjKbvYdlN4h+Dane8il/hBR6Y1A75lbzmnhi5Hi1F0xqGmnB4YpRt5bMV40pjIkA/OMoDQWv1NVUZT5WSXJHFzyh79mupwmq3UG+PKa+5PUOrXf45FT0VXuVNXHliUa53XyRD9Mly0g2siSSkix1n8NldUgJVEM8IHYDARCO4XfqK9nK9SMv3YFbr3W2Gcq1HEGq86QXAscG3cf7OOvWmyd2oijiQHaFce5ONJDxfFF8b/Q1pAHtcs9irXpPc3jAgvbIZZ68vmtaXucMZvgX522gRqWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=smE8+AIfqauQ4YA7bahAZF1oKXyQW6Pvf5YxuIURUbA=;
 b=Rqk+qC/jm8shE2nq07uyLKVpTSusBF4g6x4u5ItrdtqlwjHY0X7NUVz66WmtP8Natkrg6qwUHnqY5k5bDGL8eVbC9Pvihyq3jCi26YQKPc0Kab9+7pZhb6AdJ5RtFLcuH1r0FG4HpmW33KDBoJICTz9yO6mKw07MPro0ftrzXl4=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1163.namprd12.prod.outlook.com (2603:10b6:3:7a::18) by
 DM6PR12MB4436.namprd12.prod.outlook.com (2603:10b6:5:2a3::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3412.20; Wed, 23 Sep 2020 12:10:42 +0000
Received: from DM5PR12MB1163.namprd12.prod.outlook.com
 ([fe80::48cf:d69:d457:1b1e]) by DM5PR12MB1163.namprd12.prod.outlook.com
 ([fe80::48cf:d69:d457:1b1e%5]) with mapi id 15.20.3412.022; Wed, 23 Sep 2020
 12:10:42 +0000
From:   Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Cc:     joro@8bytes.org, Jon.Grimm@amd.com, brijesh.singh@amd.com,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH v2 3/3] iommu: amd: Re-purpose Exclusion range registers to support SNP CWWB
Date:   Wed, 23 Sep 2020 12:13:47 +0000
Message-Id: <20200923121347.25365-4-suravee.suthikulpanit@amd.com>
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
Received: from ethanolx5673host.amd.com (165.204.78.2) by SA0PR11CA0064.namprd11.prod.outlook.com (2603:10b6:806:d2::9) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20 via Frontend Transport; Wed, 23 Sep 2020 12:10:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6d418369-6f30-437c-7fcf-08d85fb9b15f
X-MS-TrafficTypeDiagnostic: DM6PR12MB4436:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB443671DFB51EDD21593AD4BEF3380@DM6PR12MB4436.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cFCX06GCRrC5LMXXVUUq/BsfJ2KheHiFpAXEU36iPfGQIfmmd6Zvs7jwT8U8vOy1JuTpkOjLJxfTarkMgzvHl4lp8/D4NC5Uaqr59ZfJUGoVvKA5r0SJanysgibHVyw0J0B8QMahvxfCxYMNyS6/GjegAl6gnbY+O5H914T6bGMtq4AELkltTmk88CrdTpvOQuky7boW6YEFXKxdianoUOgzckioPwO8pvIvVjQobj50rjX5YUxhDKCFcFYan+EuWKHdZKhaRibDhn9qkVRgEB1Ek0eGmyyE3owOTmy4AsYXtCicfXa2p90xj6QY/FXwSrhEPZta+N5PL4iR8XbFFg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB1163.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(346002)(39860400002)(376002)(136003)(186003)(16526019)(83380400001)(86362001)(956004)(2616005)(26005)(52116002)(7696005)(478600001)(8936002)(5660300002)(44832011)(8676002)(66946007)(6486002)(66556008)(4326008)(66476007)(316002)(1076003)(2906002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: gm5arEtv22T1f1SJXvjLOj4AK8K4pt55AMnmJvg4iqQUE2A7hj1F7VHr6vjgAAy70ngNRzFzcUlFES+MEP8H3dY9FCNdUvM5aUGmqNhm6OqcZl+lh+mHPHPjrFMzPeBUHKuaNWqj2fCdANzQ4/psfGVzE1WYyIx0nofwlA4R/zR/2dM4EL3XLOQQQwDgsxZAOESxLu+lL/bGRVKlvZpiw4d8/LG18aPYnsXQy5k+iB/qwXpnODRCclXvO2ruMbThalg/BQ0VKienaFXQ+2AlRXCkO6RdmE6fqXu5ctBk41/ILJ68BnxXO0UUHbFbIHIwLSyLYT6fbhc9M/uudN0XRyMbfjlN+oaFuWOD0gGj8+2nz3yfFfKjKRzYLAhFY/dKbGsMHGbGp1FU45f7RQjD7Ey837AyhJXgKjkUrX1YdT6NADkYdj4Bqoh1BgP1MHICG+ElGAv4MrhDokVPBKh4sgfcrzD6MGX85gswBAJJ2IX5RKeNGcUyFbQ+Dxv7EQoj+E6RLKG7mZVDNknzvvtM0Vo2iHC1KXqlzaHPm57qW8Bd7QTyLzcj6MBU4hvxMUQEFMk94R7lEhrMn1R52In39bOkAvtQnOvgKJpIqBkkS5m0S8jZwkTNJvtQM1buFuEkVdBJnn66yw/CsdzVOgd7XQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d418369-6f30-437c-7fcf-08d85fb9b15f
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1163.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2020 12:10:42.5548
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w4ddbXLQyb4TReYLC70t0aTrg3ymznQ6uoRW8kzVymFv0JWKrD7h2pBpLtpK7Z7FCf7z4GnUVRBEHsmfnaJC6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4436
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the IOMMU SNP support bit is set in the IOMMU Extended Features
register, hardware re-purposes the following registers:

1. IOMMU Exclusion Base register (MMIO offset 0020h) to
   Completion Wait Write-Back (CWWB) Base register

2. IOMMU Exclusion Range Limit (MMIO offset 0028h) to
   Completion Wait Write-Back (CWWB) Range Limit register

and requires the IOMMU CWWB semaphore base and range to be programmed
in the register offset 0020h and 0028h accordingly.

Cc: Brijesh Singh <brijesh.singh@amd.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h |  1 +
 drivers/iommu/amd/init.c            | 26 ++++++++++++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 1e7966c73707..f696ac7c5f89 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -93,6 +93,7 @@
 #define FEATURE_PC		(1ULL<<9)
 #define FEATURE_GAM_VAPIC	(1ULL<<21)
 #define FEATURE_EPHSUP		(1ULL<<50)
+#define FEATURE_SNP		(1ULL<<63)
 
 #define FEATURE_PASID_SHIFT	32
 #define FEATURE_PASID_MASK	(0x1fULL << FEATURE_PASID_SHIFT)
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index febc072f2717..c55df4347487 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -359,6 +359,29 @@ static void iommu_set_exclusion_range(struct amd_iommu *iommu)
 			&entry, sizeof(entry));
 }
 
+static void iommu_set_cwwb_range(struct amd_iommu *iommu)
+{
+	u64 start = iommu_virt_to_phys((void *)iommu->cmd_sem);
+	u64 entry = start & PM_ADDR_MASK;
+
+	if (!iommu_feature(iommu, FEATURE_SNP))
+		return;
+
+	/* Note:
+	 * Re-purpose Exclusion base/limit registers for Completion wait
+	 * write-back base/limit.
+	 */
+	memcpy_toio(iommu->mmio_base + MMIO_EXCL_BASE_OFFSET,
+		    &entry, sizeof(entry));
+
+	/* Note:
+	 * Default to 4 Kbytes, which can be specified by setting base
+	 * address equal to the limit address.
+	 */
+	memcpy_toio(iommu->mmio_base + MMIO_EXCL_LIMIT_OFFSET,
+		    &entry, sizeof(entry));
+}
+
 /* Programs the physical address of the device table into the IOMMU hardware */
 static void iommu_set_device_table(struct amd_iommu *iommu)
 {
@@ -1901,6 +1924,9 @@ static int __init amd_iommu_init_pci(void)
 		ret = iommu_init_pci(iommu);
 		if (ret)
 			break;
+
+		/* Need to setup range after PCI init */
+		iommu_set_cwwb_range(iommu);
 	}
 
 	/*
-- 
2.17.1

