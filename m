Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EFBA2827EE
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Oct 2020 03:42:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726345AbgJDBmH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Oct 2020 21:42:07 -0400
Received: from mail-dm6nam10on2053.outbound.protection.outlook.com ([40.107.93.53]:62785
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726230AbgJDBmE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Oct 2020 21:42:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jkba6jfY6rh6EiOHxM+HPXOUfDiMefYAoOM1+cZiE7iqxY4z8Ds+g89fxrInbYIe0a2wZtOO1B4vptvOEXZeV96qhoOXNCSbLQt6oFVyih+vjxk7nA/41lpOOhtn5Mu37XDrB3DHYCGYO50UwDMOArvzlX4+2J61KC6B2Gmy7pgioJDj/IqgH7jStiHeklDMVzrT7kxceei7Yx/3crV9TuHJthUP8hvsdJ3ETLk6coyj5uFhZrn6IUM4UsbG8LAfG+Jlhc6r0Y4ELhk2/2KeyhUDuQTdc13jj4qXhi7STC1QtWjO/RuPOqOZerWZSjRPumO/6/zuD5LF3qtLcCvJ+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ojud3cvMpYpw4UTG2AwheJzp04pXv0LDOqmfptPVFyY=;
 b=YzIZXEVg1z+bFASenzs2vsz78DRC1oquNxXBhRKq2c+qW8oAIwTR2ZMF2g8mPPt7iOGw8kubvTGfWOGs8rK/aptOO55VYbWMITRGBydgp5UYRTpg0KV29Xi2T6Q7OwIiLLFacTPD/5xtwDfxrPCIfYnxKnSgf6KbD9bYJ+CEslrGv6XnGfnEXaoiT5CHxcFJ+1UhGlvzqgpbM2LtvDVII5LKwGqiXZY9Q/UD8fpY0MPPHfQJVcDAyrIRJLTM1x176NtG6uuoYqnDDngqx0G+iIoFkEXs/LLp2BwBINHG0byjgie9Fq0BBJ2abR74l3I+WRIfvER7K2rO31HSncG8pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ojud3cvMpYpw4UTG2AwheJzp04pXv0LDOqmfptPVFyY=;
 b=OuRDK2hwBXCSVhCUFSzGiHB98cdZ91zxWdsk2y82upIZenEe/u1I1tsFr/bfBjfFA0amKYpQcg8ew4IK1kivclNK5eECAGt20eV7+aOKV7PTxkp914p6E6EVq5DIm/AFD6mEG695Flk3aK5QTMrcUlfSXv5pPzqaEcW86pocWoU=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1163.namprd12.prod.outlook.com (2603:10b6:3:7a::18) by
 DM5PR12MB1451.namprd12.prod.outlook.com (2603:10b6:4:d::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3433.39; Sun, 4 Oct 2020 01:41:56 +0000
Received: from DM5PR12MB1163.namprd12.prod.outlook.com
 ([fe80::48cf:d69:d457:1b1e]) by DM5PR12MB1163.namprd12.prod.outlook.com
 ([fe80::48cf:d69:d457:1b1e%5]) with mapi id 15.20.3433.042; Sun, 4 Oct 2020
 01:41:56 +0000
From:   Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Cc:     joro@8bytes.org, robin.murphy@arm.com,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH v3 03/14] iommu/amd: Move pt_root to to struct amd_io_pgtable
Date:   Sun,  4 Oct 2020 01:45:38 +0000
Message-Id: <20201004014549.16065-4-suravee.suthikulpanit@amd.com>
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
Received: from ethanolx5673host.amd.com (165.204.78.2) by SN4PR0701CA0004.namprd07.prod.outlook.com (2603:10b6:803:28::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.34 via Frontend Transport; Sun, 4 Oct 2020 01:41:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 79eca430-d2e8-41e2-61b5-08d86806ad69
X-MS-TrafficTypeDiagnostic: DM5PR12MB1451:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1451B997EA12F57CDC303FABF30F0@DM5PR12MB1451.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JmLmH57PspJKu6MFDHbvE/cPvwKdYvsLgMD3SoehveJZ+CJuu8jWo75fuyw5f63AIVtZ8fCGxBGBM04ZfUaAZf63HAy2U+RGN9+o5KRcjcBEkwzKtA8vZjbtzfACVSVdfMkqQ4/FmYk1U8bQHYwNzGEQOKeZVd+acga89RQh58JbkrAM6OX6k88p+YGJeJsnuIFm3+5+3OEa//PVdFlofeydCoJE2qt2jnbmku40lacEeqo7AeHeD2s4u+Lav53c/mF4pubBO8MiiqW4lc0/JTCXjSMlQj9fZAoVbbKFZ/1FtbYhavPLLzx4JwMYB+hBCUG0mSMrONCL2ZE7GuVZJg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB1163.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(376002)(136003)(366004)(39850400004)(2616005)(956004)(6486002)(316002)(66946007)(66476007)(66556008)(6666004)(478600001)(44832011)(1076003)(5660300002)(86362001)(8936002)(7696005)(52116002)(2906002)(36756003)(16526019)(26005)(186003)(4326008)(83380400001)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: G2QGSBWSdxfB8mNezL2pqnL35nNR9R2x2rw4i3zMRhAiTtnW3PdUNnMm/iUw7fi7SvfIVXmGeVdTZqGwxdK7/KoS63EiPEDJzzqlUSovLpzc1bAEKD+6UiO9R2jxWYSGkBmyf5DG2ZkIvYBMXWGXkNs6pfWAivAoBCunRX0/vucUlQBNh+PX8F2/qRf3ehA1BHbhtFzFVzGpT5tq0NjsdHZVhE8DKCz3u/ZscXVjjS+39e20DjFaAhnbGi2aRg+/2fm7xt+gdIuh/gjDnRXR86j6sUq2pKNmQejhdga/bhXUBRUmmv2fm7J+9SY340AYq2H4dd1+wnQhSIdxvuEvNs8zKBeVCeyYEvhXz6Brw5ZAJHvKbTg7AxySAKiqqx1V2vr0CM24P6/OobtGF/PpS/+9vtpYwNc3T8AIC74jHNjAT2MP3+lbBnvMou8GWlT96NxBLdN8FxI+IhLFWBa2kJQr77aAnw8MDphSkePxyJ6Jr/kV43buP4PESPjyRozQnAl6y3cagzhnhaPrCKDlNxDCxTmDrGnc2n7tehimMBYqBVDmNQb/+xGsdNZ+oLiT403fokae/06uwfpGDGaHoFThYhneQNkqe8ub7qQBpFlMZlD+QR/a1SzVe4NhWZm3CKbKs7b5p6bKb/DCAxClNA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79eca430-d2e8-41e2-61b5-08d86806ad69
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1163.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2020 01:41:56.3251
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eLrqAe5mvYb62gsEVfMRUwe2P8Fy5l7a1rzR7mlJuD3AmKFHErbzL1X6OKdg+JHMEAGXJIu4is1hkFSE4tihOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1451
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To better organize the data structure since it contains IO page table
related information.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu.h       | 2 +-
 drivers/iommu/amd/amd_iommu_types.h | 2 +-
 drivers/iommu/amd/iommu.c           | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index 97cdb235ce69..da6e09657e00 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -96,7 +96,7 @@ static inline void *iommu_phys_to_virt(unsigned long paddr)
 static inline
 void amd_iommu_domain_set_pt_root(struct protection_domain *domain, u64 root)
 {
-	atomic64_set(&domain->pt_root, root);
+	atomic64_set(&domain->iop.pt_root, root);
 }
 
 static inline
diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index e3ac3e57e507..80b5c34357ed 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -493,6 +493,7 @@ struct amd_io_pgtable {
 	struct io_pgtable	iop;
 	int			mode;
 	u64			*root;
+	atomic64_t pt_root;	/* pgtable root and pgtable mode */
 };
 
 /*
@@ -506,7 +507,6 @@ struct protection_domain {
 	struct amd_io_pgtable iop;
 	spinlock_t lock;	/* mostly used to lock the page table*/
 	u16 id;			/* the domain id written to the device table */
-	atomic64_t pt_root;	/* pgtable root and pgtable mode */
 	int glx;		/* Number of levels for GCR3 table */
 	u64 *gcr3_tbl;		/* Guest CR3 table */
 	unsigned long flags;	/* flags to find out type of domain */
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 2b7eb51dcbb8..c8b8619cc744 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -146,7 +146,7 @@ static struct protection_domain *to_pdomain(struct iommu_domain *dom)
 static void amd_iommu_domain_get_pgtable(struct protection_domain *domain,
 					 struct domain_pgtable *pgtable)
 {
-	u64 pt_root = atomic64_read(&domain->pt_root);
+	u64 pt_root = atomic64_read(&domain->iop.pt_root);
 
 	pgtable->root = (u64 *)(pt_root & PAGE_MASK);
 	pgtable->mode = pt_root & 7; /* lowest 3 bits encode pgtable mode */
-- 
2.17.1

