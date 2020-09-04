Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 970DE25D5B0
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Sep 2020 12:08:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730017AbgIDKIj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Sep 2020 06:08:39 -0400
Received: from mail-bn8nam12on2080.outbound.protection.outlook.com ([40.107.237.80]:27409
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729797AbgIDKI3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 06:08:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vta7GGS0R99+pIauok2g0x/BqJVIb2ILXnum4R7/hoj8Ve1ytC8IeRsLzNWhR0698iCJ1HXyOH+oujObO41TmdEMC0qnJhEMQsqgLcxRlcdEI2jzvycwjkuD29tXi8EhUTY/JSAOUpcNuY+jLkQGueWVqap/IgmIIzkmLysFMVAv8X8+poYfsGNUsgdCEySNT6LqJrnh9slzJASnMy21bamNDvuBG53dZa2jTEdIA4IZlLk6G5odW2V8voljCao3iZuFuQAaBnZmgHvgiELoUkkK/r7AroOU+otrz6yH3TJbHXcm06XgtOZ2ZVc/GfzGnJC+o8J1QCVfmCTZ1xWpyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XNMwznDTLy1qK3EycnGQSqW9gqxzUPWoUJlW8C5we6g=;
 b=PXIizwnDJBSFeJ9kOcxhuCCDTEqAk4hV3OVTOKuI2/UzzFuZpYlEPCTKIaAGlsZa8OIyqhRUsTAyrxjepjNwCpWzVM1k0GJibB194iffnO23GVfICX/A0Oosyb1HXA7gMARgVs+sEwPQH/5/bgqZJ9cTxPk13ziwTzv63WN9CblNTiFINAEBU21itYQ11CSzLmj72ZQhFyxGJp1dqEA0vTagwnLSS/rbVtB9udqFgb83TNB50Cmwpj+RH90+U5jPRmY9haOq/bLdmLMs/sphIm/XT+6jKdJX1fFvEkrYUdbQQ8Wceex7YbejbKU3eEcsJqTiRuBWWykRYh4ysCWwjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=sina.com smtp.mailfrom=srdcmail.amd.com;
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XNMwznDTLy1qK3EycnGQSqW9gqxzUPWoUJlW8C5we6g=;
 b=DOsKuNXi+9pgqIdRu0hMMEmePSWdqjxerWcZpCJdoEWP5hAQiiDXnksnEVG0OZ6wLJvNwLURPNvUNyyHH8p7u9p2azI2MdAj2t205o2A2rNfqA/RojempyTjHLj+N/peE2VkOGafBPl5zfIbCqgF39BKP3hpYK2ny1/Ieo75v9w=
Received: from BN6PR03CA0066.namprd03.prod.outlook.com (2603:10b6:404:4c::28)
 by CY4PR12MB1591.namprd12.prod.outlook.com (2603:10b6:910:10::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.21; Fri, 4 Sep
 2020 10:08:26 +0000
Received: from BN8NAM11FT027.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:4c:cafe::12) by BN6PR03CA0066.outlook.office365.com
 (2603:10b6:404:4c::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.16 via Frontend
 Transport; Fri, 4 Sep 2020 10:08:25 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=srdcmail.amd.com; sina.com; dkim=none (message not signed)
 header.d=none;sina.com; dmarc=permerror action=none header.from=amd.com;
Received-SPF: None (protection.outlook.com: srdcmail.amd.com does not
 designate permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT027.mail.protection.outlook.com (10.13.177.96) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3326.19 via Frontend Transport; Fri, 4 Sep 2020 10:08:24 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 4 Sep 2020
 05:08:23 -0500
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 4 Sep 2020
 05:08:23 -0500
Received: from atlvmail01.amd.com (10.180.10.61) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3 via Frontend
 Transport; Fri, 4 Sep 2020 05:08:23 -0500
Received: from srdcmail.amd.com (srdcmail.amd.com [10.237.16.23])
        by atlvmail01.amd.com (8.14.4/8.14.4) with ESMTP id 084A8Lv8031313;
        Fri, 4 Sep 2020 06:08:22 -0400
Received: from srdcws1054.amd.com (srdcws1054.amd.com [10.66.16.34])
        by srdcmail.amd.com (8.13.8/8.13.8) with ESMTP id 084A8Kft029002;
        Fri, 4 Sep 2020 18:08:20 +0800
Received: (from weisheng@localhost)
        by srdcws1054.amd.com (8.14.7/8.14.7/Submit) id 084A8KmY016606;
        Fri, 4 Sep 2020 18:08:20 +0800
From:   Wesley Sheng <wesley.sheng@amd.com>
To:     <joro@8bytes.org>, <iommu@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>
CC:     <wesleyshenggit@sina.com>, <wesley.sheng@amd.com>
Subject: [PATCH 2/2] iommu/amd: Revise ga_tag member in struct of fields_remap
Date:   Fri, 4 Sep 2020 18:07:47 +0800
Message-ID: <20200904100747.16463-2-wesley.sheng@amd.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20200904100747.16463-1-wesley.sheng@amd.com>
References: <20200904100747.16463-1-wesley.sheng@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e942553b-dcab-43e4-9eea-08d850ba7634
X-MS-TrafficTypeDiagnostic: CY4PR12MB1591:
X-Microsoft-Antispam-PRVS: <CY4PR12MB1591980B2D41851A1472CF5EF02D0@CY4PR12MB1591.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y0Uh0UZqvQAJ32QlwoUwgp4eMAh0LDRYkVgJfXFqbIWVcqwC3tzMjnRTrVZ94iOw3CfcwXim+vN9OBBfbQtDVC1b9w3GHLm2k2fZxd0YhzvwpN8iU+jGZpKQP7iZz8t/GNTc3b8INMeozi7BJjWR6UW5BaBECEYf6QF0Ssw6cGyM3ZYsU0m4fiZj0FA/irZRViKDGBJ1JgxDDApY1UBCygTS6SkIo4CT7Z+WclNfR8ZV1QEsrtNkBbH+7ktC7oKCOBhaQkwYGC+y1zzcq0oOPnj7hVB4u/YiJUBDNbd1++ziD4C4MRR+iQ0csYP2NPNU36dxYU3B5hHwqyDMxfA0v6GKg1VB30UmfqY9Iq9ZeFAqW4s1WTfKzi8HUR/dZSAh8NxIUHJ2rId3TYlEB1wpAQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SATLEXMB01.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(136003)(376002)(346002)(396003)(39860400002)(46966005)(110136005)(54906003)(1076003)(316002)(2906002)(81166007)(82740400003)(6666004)(4326008)(82310400003)(336012)(4744005)(8936002)(26005)(44832011)(83380400001)(42186006)(83170400001)(356005)(70586007)(36756003)(70206006)(498600001)(5660300002)(8676002)(47076004)(426003)(2616005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2020 10:08:24.9794
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e942553b-dcab-43e4-9eea-08d850ba7634
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT027.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1591
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Per <<AMD I/0 Virtualization Technology (IOMMU) specification>>
ga_tag member is only available when IRTE[GuestMode]=1, this field
should be reserved when IRTE[GuestMode]=0. So change the ga_tag
to rsvd_1 in struct of fields_remap.

Signed-off-by: Wesley Sheng <wesley.sheng@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index e5b05a97eb46..baa31cd2411c 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -832,7 +832,7 @@ union irte_ga_lo {
 		    /* ------ */
 		    guest_mode	: 1,
 		    destination	: 24,
-		    ga_tag	: 32;
+		    rsvd_1	: 32;
 	} fields_remap;
 
 	/* For guest vAPIC */
-- 
2.16.2

