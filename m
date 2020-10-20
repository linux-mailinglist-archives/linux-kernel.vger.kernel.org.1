Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E8C22827DE
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Oct 2020 03:42:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726267AbgJDBmA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Oct 2020 21:42:00 -0400
Received: from mail-dm6nam10on2053.outbound.protection.outlook.com ([40.107.93.53]:62785
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726114AbgJDBl7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Oct 2020 21:41:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PPg7zMV77Ln+Px2AI1TVvukYBx9DKpNEjMit7AKpLPrSs+HxyueJGuYZJhWtJAhiEsi+aKFLp/uuLVEB9W3dyzhNx7gmPuhRHJrZ4+wsF9ALG/4B20ZhYQKi2nG9RjaqWw/d/iv3cxtRRf2Pe8GHUshNWup6adukKFtaUitaPOMv8vcwoXg76khNGslk1AHl0NfAF7CsI7ZsbP+3GCrQTxSqXBjPWoR8YCUA172amKOPuAR7ElgKSH5PsXaTpR/SuqYwLE97mY2KXlTO/5nMsvUYiaY7GlAIHlW2eOLoAND9MOaVx+JQrfgpG1X3etAV1M8kWCnTaSPaLeAMf8lhTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wNYfRxFr2lHj+6XUrW+YPfxDuN3vHBirnqdMyTJLQCE=;
 b=mmGfwgq65tzRqioCzXMlzQWzwTeMEZLOmzIuT1L0jajJjDf9KG3+QX8SY+0nC/4nAWnZFV5qux10DlA8+5IM2OfhrOFRoWTxsmMjdPUw/nCqPtjQ/ySzeWJPeV6/50bOdMol53ybGo1S2S5ffM6y5HCPu9f6iwZGiU2FDhYCd50lrjhe5pPk0aKuPIDhZWnzOfiU6d9Q8WvYBBRx2g8+f0QlmuP8ovc2VCB8sdyoeXeBLY5n7ys7PaqtGHy2jmx5/iEqJtS2LqxwJMrny4PPgKpSkAnqwVJ9iVnkZlqNecPDRs04BRdDqF1YgNFC2dMqJU5d6ECMUzrSw9FrzcPfzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wNYfRxFr2lHj+6XUrW+YPfxDuN3vHBirnqdMyTJLQCE=;
 b=UhexpOCUmpo11eJ5+3NvB8Y9CBEFxWKfHGth4l5dExvMKKcb6U7HBRYZ/gVjHg+1shBmpBpWCuAPRNy4DlWcFWfpF8NGvdWRY1u4FZkqbfefRvkCC6Ruq4XF0jhbBLNg1QDMLzej0ext1Yn5rWR95Oxw+U5jIPsH326j4PPgkOM=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1163.namprd12.prod.outlook.com (2603:10b6:3:7a::18) by
 DM5PR12MB1451.namprd12.prod.outlook.com (2603:10b6:4:d::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3433.39; Sun, 4 Oct 2020 01:41:54 +0000
Received: from DM5PR12MB1163.namprd12.prod.outlook.com
 ([fe80::48cf:d69:d457:1b1e]) by DM5PR12MB1163.namprd12.prod.outlook.com
 ([fe80::48cf:d69:d457:1b1e%5]) with mapi id 15.20.3433.042; Sun, 4 Oct 2020
 01:41:54 +0000
From:   Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Cc:     joro@8bytes.org, robin.murphy@arm.com,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH v3 01/14] iommu/amd: Re-define amd_iommu_domain_encode_pgtable as inline
Date:   Sun,  4 Oct 2020 01:45:36 +0000
Message-Id: <20201004014549.16065-2-suravee.suthikulpanit@amd.com>
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
Received: from ethanolx5673host.amd.com (165.204.78.2) by SN4PR0701CA0004.namprd07.prod.outlook.com (2603:10b6:803:28::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.34 via Frontend Transport; Sun, 4 Oct 2020 01:41:54 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 118e0f36-fb85-46ee-3faa-08d86806ac66
X-MS-TrafficTypeDiagnostic: DM5PR12MB1451:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB14514A6C8261A53541D976D4F30F0@DM5PR12MB1451.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CyTYGAbar9drTM6PugCJfDwKQvDyAWJs1nJmm6IG7G8JcX/5Z/MHBewVRt9ExXzJM9hes8ejo141l8sTb9PPcReSfkQMCeze0RLd5k8G82q7nF574ox9+NRtH1dXvXkfA1lMJWIvwGjRSupuSUHWeYDatMSnKiQm3JDaj/d4YojtDl+Rzbb+igwhO5/GypfAR1VKF9NwrMFqXf9CdPh7cWEEe8wBSlyTYu97U98cVf3RF8vOeenN0+4Fs+MEx9Gd8bFlzNa50b4igtO+F6rT1SLrKS5VGfQAliWl2CLsLxzI82zqDg8appsp6YtsaG4l
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB1163.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(376002)(136003)(366004)(39850400004)(2616005)(956004)(6486002)(316002)(66946007)(66476007)(66556008)(6666004)(478600001)(44832011)(1076003)(5660300002)(86362001)(8936002)(7696005)(52116002)(2906002)(36756003)(16526019)(26005)(186003)(4326008)(83380400001)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 5cYvrELu/lBXVsDexT6/4BcdOWFNCAccIRD9JhxnzK1W53TayJd46rLGmXlZYCcQXfwEuyg+ny5xGhgscmCdh0OsH/KAzMKLMCh2UHzIa0X/+cuK/QydqpZI1MWuC5C5LvHF1jRVNQdsa1fRh0oYvVzxXRQiyTBdXLc0j46b87DkxGN5/GDdIbB0TvPVV7sbLJdy94xN7A/h88WZ9iu+XA6LfVIsQhD9BMyXSWBEh8NgKwDL6oEkSxXm5oAyuYGDm2EEOKfdYwOUSHVs85RNvpxrMpockOS2w2XdYVP6R/GE9I99rWTVP6kQAYELDo35PD2DccaeKYGYkCSVBTXpWPzh2Znum5Aj3tv/6Oq0Agwnxlz/1UcL/piySnYZQ5qUAd1GCYnP0vIQcD8ZZuTjQSDT9jVg3PbZux3sG16NKnMyy8u/1UjlsvD6wFJJlNevuayDS2Uxb4HL1k/44ZzKG+rAFoln/eXa6+Zyzsll7U6Pl43pkg6pSQZG+qLITvesQG2BOGz4BOfarbHiiWZwhiwD57YL4NxCommAEgr+5fgHQ6KwlcxqZO1/DMC7KLt5PTIgXrz9NukZ5IE2Pi6eiN+MNsU6DZcGvOzK2dhUcfQdkAttulhGy8pag2fP1kr+qr0vb5tuWqeIfRFHX4eMzg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 118e0f36-fb85-46ee-3faa-08d86806ac66
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1163.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2020 01:41:54.6408
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OWGLTgw7aFpy0MV5uum1jpH3mbyTouryJrg8FjXd1ZBplZ3HMCX8mgwtLGFXRf7ij7EyYGUJxTrTqhmmbSISFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1451
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the function to header file to allow inclusion in other files.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu.h | 13 +++++++++++++
 drivers/iommu/amd/iommu.c     | 10 ----------
 2 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index 57309716fd18..97cdb235ce69 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -93,6 +93,19 @@ static inline void *iommu_phys_to_virt(unsigned long paddr)
 	return phys_to_virt(__sme_clr(paddr));
 }
 
+static inline
+void amd_iommu_domain_set_pt_root(struct protection_domain *domain, u64 root)
+{
+	atomic64_set(&domain->pt_root, root);
+}
+
+static inline
+void amd_iommu_domain_clr_pt_root(struct protection_domain *domain)
+{
+	amd_iommu_domain_set_pt_root(domain, 0);
+}
+
+
 extern bool translation_pre_enabled(struct amd_iommu *iommu);
 extern bool amd_iommu_is_attach_deferred(struct iommu_domain *domain,
 					 struct device *dev);
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index db4fb840c59c..e92b3f744292 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -162,16 +162,6 @@ static void amd_iommu_domain_get_pgtable(struct protection_domain *domain,
 	pgtable->mode = pt_root & 7; /* lowest 3 bits encode pgtable mode */
 }
 
-static void amd_iommu_domain_set_pt_root(struct protection_domain *domain, u64 root)
-{
-	atomic64_set(&domain->pt_root, root);
-}
-
-static void amd_iommu_domain_clr_pt_root(struct protection_domain *domain)
-{
-	amd_iommu_domain_set_pt_root(domain, 0);
-}
-
 static void amd_iommu_domain_set_pgtable(struct protection_domain *domain,
 					 u64 *root, int mode)
 {
-- 
2.17.1

