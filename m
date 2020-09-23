Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82E56275551
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 12:13:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726839AbgIWKL7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 06:11:59 -0400
Received: from mail-dm6nam10on2058.outbound.protection.outlook.com ([40.107.93.58]:44128
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726444AbgIWKLv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 06:11:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D+I7e0vCDG5NLeBfcPKhb9LAW1tOIhX4rXGcALPZ0QjQsaSfyvY+iZiIeBxQdWAAvF7Fw66il47z2TnojcoFG33iZ92tphLhBPJRTNemA25MfxJ4jnUpDoOuoizN4dW+apGedmlva3mk4BHFBOSMfOeJCPL3z9KelUzMPX7EqPAH7GV4RDLAnfHR0d5m18iK2s/QCTn7kG+dIhKp0Xa5TUvIV4/Q/9FSJfiGAClwsqOLk79w+C5INKGJBdEDuZnD1vt1H73sUR918mGEi/wwGR2l3Ayx8njoyZCyKq4bw6jyMMuruJS5usicQwfdyZHb6OFA4SPwH+Ta73phBDmphg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=44DTs3hijvjAJ9A9IEYp+l1fIh1HFGHoIjCHAsn/YT4=;
 b=gx2onKJUgWBJhKwO5Ma0rpsOWwDNNMA91/Zs0wXOvuz9UZcf6PS4JtewjF7eq9ibHJMcCeDvlZcafmQKtsBfwtlbGVbNuvn51rW2YD2CczBGCTMOr6kcJmx5OKfTaRJYz+8GfE4LvD0HhcDeSPfTm6/H1qnJLtlLr6BHvcnaqNpjMt51B6/doAkmq7R5AOPxeEWBH5S8F8kSvuR7CZaFHPJK8BXdqfTOcmfo4byIyron7Tqnh0tBl/ot1mfTFRSpXIr9Qf7abUK2FAgDu/fMS9Qv5VsFJDYNt+ezmBUiwytaJTimdQeV8BWqX0CA/b4grnHEHPb6VpfY5zw9rgLN6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=44DTs3hijvjAJ9A9IEYp+l1fIh1HFGHoIjCHAsn/YT4=;
 b=Ltgm2QLY+raG+YGErhVNIKtltGjDXBkIkN7dWKQq49pSxFAcn1t7b4XLZO6Y1wgQCHY4EY4+VPQCkf/saxQObLb/Wg9xFazIHSR4M/oXRP8JcGXojx268S/aX5HusD7dhPUaeQ1Or09J84zeiZQarSGosidLW4BUd7Qn9vb4Ukc=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1163.namprd12.prod.outlook.com (2603:10b6:3:7a::18) by
 DM6PR12MB3466.namprd12.prod.outlook.com (2603:10b6:5:3b::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3391.11; Wed, 23 Sep 2020 10:11:44 +0000
Received: from DM5PR12MB1163.namprd12.prod.outlook.com
 ([fe80::48cf:d69:d457:1b1e]) by DM5PR12MB1163.namprd12.prod.outlook.com
 ([fe80::48cf:d69:d457:1b1e%5]) with mapi id 15.20.3412.022; Wed, 23 Sep 2020
 10:11:44 +0000
From:   Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Cc:     joro@8bytes.org,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH 03/13] iommu: amd: Move pt_root to to struct amd_io_pgtable
Date:   Wed, 23 Sep 2020 10:14:32 +0000
Message-Id: <20200923101442.73157-4-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200923101442.73157-1-suravee.suthikulpanit@amd.com>
References: <20200923101442.73157-1-suravee.suthikulpanit@amd.com>
Content-Type: text/plain
X-Originating-IP: [165.204.78.2]
X-ClientProxiedBy: SN4PR0601CA0003.namprd06.prod.outlook.com
 (2603:10b6:803:2f::13) To DM5PR12MB1163.namprd12.prod.outlook.com
 (2603:10b6:3:7a::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ethanolx5673host.amd.com (165.204.78.2) by SN4PR0601CA0003.namprd06.prod.outlook.com (2603:10b6:803:2f::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20 via Frontend Transport; Wed, 23 Sep 2020 10:11:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e5140eda-5329-46cc-9184-08d85fa9127d
X-MS-TrafficTypeDiagnostic: DM6PR12MB3466:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB34662BCE150142D0907E0DB5F3380@DM6PR12MB3466.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FRi6Vs8cXpTGl57EIUSHVe8pU2m+Ke5um5KOkFPJy/acNy/MPH7R//82McXB8wllcEpHYb47Ac9hu9sB2mzvA5yrfaZiIHZKy7puzQ0YH+ECZh4cCVKJZfgXNtH+HeLq9KXBua80km74FeWaF9/vcFNH2LGl6PrCKRCXjbqQbKVZyuNBuHQJrNKX/owhLBlIe5K1ExXT76FKwUt7LEisUfre+NCdIHt5Ji50xDfeqP03tGiBcn4FAYdp/VD//6tWgTENwaIDOgpXaZjwESzi4X0jPCW4+5HtRmrTLi5t2/uT2hTWexPOCCuInHY6Xg+lJHXOScM8JDlm1BB5hB55zA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB1163.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(366004)(376002)(346002)(396003)(44832011)(5660300002)(66946007)(66476007)(66556008)(83380400001)(6486002)(86362001)(36756003)(2906002)(8936002)(4326008)(26005)(316002)(1076003)(956004)(478600001)(6666004)(186003)(16526019)(52116002)(8676002)(2616005)(7696005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: tQNuSbWg+W9iLpmisVI8MZPFCTLhshD52rFVh8fut4+4gLvauaHWnjoP5/CppOA9aN8oOmOgdGUV83boo1ptI3rJRQitQy8F3HOQRd7sF0ozRdthQ+M15Z3hR8RSVxuLUHuJrvoIJtxx8Sy+0gh2dUxV0p+c/KC5zIEo8zrJufagjh8c6YqxtJID1DwssAl/bP4HA7FxchSEKQ2xfBuz1Xc5l9Q1q3dnKaE/fDw7CsDcVm/ebvMaHIAUNmZ29VQpeM0TA9aysRvCV33D/4KfNwcMPtPoLTnBUgIQFC9zA34cRbv6QpfW6MohZnzrQFPkPkWrWlnX9bX9VzJi+ZnUOn+f9KU2FF5sBw9lWE4HMz/Fe79Ujs5pTD/vu5rI73ZrVRm7VyWI5RGxY2bkmEnNrbZInNldSplG5ZnDG3p735IJN2fPgddJuqMoR3sN/Ol5+KB5M90ogIhtZ0a2ARWUSAgsLYUr1PjCrBCPmFLejWRpRZaYs/8iOIGfFRatTSyiFouZDOLtRwPS/3e5zliy0ytb+fo06tHjDx3TpgxwEmQU3rCNTup4iTi6A3BBP0asTLMSHyofVXPgrLGKAdKSmfjJ8W/7ieyCBnmZBAOmHj0sa2BpPQL9acKqDr4g5N0GfbnrhSLcGthqwgb4EDJPhQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5140eda-5329-46cc-9184-08d85fa9127d
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1163.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2020 10:11:43.9924
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zne+yN57yLK2ZyKb1bUIj68IH/RFbXqiKSp1GhDApqxywxBbZAJ6Yj+s758wYDab5RpPXS0/4nlThfAgQsWvxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3466
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
index 77cd8d966fbc..5d53b7bec256 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -490,6 +490,7 @@ struct amd_io_pgtable {
 	struct io_pgtable	iop;
 	int			mode;
 	u64			*root;
+	atomic64_t pt_root;	/* pgtable root and pgtable mode */
 };
 
 /*
@@ -503,7 +504,6 @@ struct protection_domain {
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

