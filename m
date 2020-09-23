Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E0222757B3
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 14:10:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726540AbgIWMKn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 08:10:43 -0400
Received: from mail-dm6nam12on2056.outbound.protection.outlook.com ([40.107.243.56]:27233
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726476AbgIWMKn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 08:10:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j9TJxT2TgBE26sPbVqE23meTdTsuRWd79Eq0OcElYE/uCEmuYsNyp1+QYqlKn5ZNejESUUnmQWIipir9PLMRbXyh3eej6nODAqBzaEp6vMl7em9+zeP9oqG1MEErzJp6qjkUQvt1tzOywJpYIH7xntyEcW0a6oA3wdsmDuOSYt00Km16G6f5MuafyOOGQe7sQd7tgZZkfQleGrtxaixlQgNfqumG+mT+gbb/eRbCDI6kMWOz905IYTQoAW9aSgHv6sLX+CU5N9YhN8SsAM1/MkYkN2AM9H0DUZUv2VVuRmIVZJhAuI0vLH/C6Kf4rHchuGYegJ6iywJ6nDjLQq6lcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OuZJ/SeQue2sWnQMjr4pbWHrox3HIp6ksQDCU56FP7A=;
 b=GdMBjJU8dedO+74oYs+poxm6bESac9PWNJZYDrswteFQKQh7T6Estmrx7JGkal0Cu5iiB0fEeqltWcHEs3MQi/IV5SoDqL+WcxIRVi/kSGkMBUdjAypWh5TA5iM1h8P2dJmSMkKPTiIan3+myo4t0Lkpi6NHtu+umnT40xjS6/IHqAmn9+guwrYVR1xpuJbauaCoRFzqJBAWXeoaNwP55Z4Es6cmbJsDPsn41ODyGBTR8ncGlLI4+OXDUJypTZ8fqEbpf1VkBz+7m3gQdjT+a972s8EQeNxmIRm64ji2nYIMwCLKB4J7fgw87JGF92ZSnat4trbH1AOOnctzJOMBEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OuZJ/SeQue2sWnQMjr4pbWHrox3HIp6ksQDCU56FP7A=;
 b=YY44kcQW1cthzuvnfUN8x63GKfcHqWka2rbK27PSCLrGQCtGAogST9RFknl5w7a9cEB/5Xh2b8paY9z7ulw/3r9xVRW2KVX/4CnTasA+tA/GoyZLFDe5YwHcbMDf6QyJ5FLSUnYJNJ6EfAGGU+X54ReqkNIOzAsk2ZbPmwFk428=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1163.namprd12.prod.outlook.com (2603:10b6:3:7a::18) by
 DM6PR12MB4436.namprd12.prod.outlook.com (2603:10b6:5:2a3::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3412.20; Wed, 23 Sep 2020 12:10:39 +0000
Received: from DM5PR12MB1163.namprd12.prod.outlook.com
 ([fe80::48cf:d69:d457:1b1e]) by DM5PR12MB1163.namprd12.prod.outlook.com
 ([fe80::48cf:d69:d457:1b1e%5]) with mapi id 15.20.3412.022; Wed, 23 Sep 2020
 12:10:39 +0000
From:   Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Cc:     joro@8bytes.org, Jon.Grimm@amd.com, brijesh.singh@amd.com,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH v2 0/3] amd : iommu : Initial IOMMU support for SNP
Date:   Wed, 23 Sep 2020 12:13:44 +0000
Message-Id: <20200923121347.25365-1-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-Originating-IP: [165.204.78.2]
X-ClientProxiedBy: SA0PR11CA0064.namprd11.prod.outlook.com
 (2603:10b6:806:d2::9) To DM5PR12MB1163.namprd12.prod.outlook.com
 (2603:10b6:3:7a::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ethanolx5673host.amd.com (165.204.78.2) by SA0PR11CA0064.namprd11.prod.outlook.com (2603:10b6:806:d2::9) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20 via Frontend Transport; Wed, 23 Sep 2020 12:10:38 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9914aa5e-0884-4ee9-1892-08d85fb9af8d
X-MS-TrafficTypeDiagnostic: DM6PR12MB4436:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4436E07063719C5F2E8986D3F3380@DM6PR12MB4436.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TfyTHPnbVB1lsZ2ErVYzENcq7jXCCub2h/K5hvtsCXxQvWJ8vNPEA9+g1JbwvqtMvCHayH9yyAqq4n0pG8RPCLu0wxZcRvAYqtUO2g/ZpZl36P1hEhG1BFOHRAZSdcF8KWL34jQ3r6JEIkUHU/r+W6RE/EUtp3bKvm+CSUFQIAIkzzLlgeSM/xEtlfgnV12ObFgvxsblkgHVwFhSCrPhQtJVH3pqxSMv7uVJISH8BoJYrTSRV2PH5uCggEZvu5uTAy73XKEm5FNvyGVaFcRUq3iTm8V1NT/d0YnTQvbIEISkqmxz94l2dA994EAGYqOltWIV2Qr/V4vq4b8bZseAzpnKTd/9UPA12NtdcfN6PsGYTTB7YBS09kt7mhRWb4HkghCZ5EtHqkjwu4G4oY7sWA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB1163.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(346002)(39860400002)(376002)(136003)(186003)(16526019)(83380400001)(86362001)(956004)(2616005)(26005)(52116002)(7696005)(478600001)(8936002)(5660300002)(44832011)(6666004)(8676002)(966005)(66946007)(6486002)(66556008)(4326008)(66476007)(316002)(1076003)(2906002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: YCrJFQydeCH9waeNC3YBmKU2u/yA0cAN1gNxvIAoQbwoUYjuWRJBp1Ict8EAT7dXF4LrHcEaObQiesvUI6xxVwk3e9f6PYyraZ7RaTTWYyH77svwKXRWxLNVcrt3XyoOaqw/zhMXQaKJY17rE4Jx6LaYvuS2TLqV7QU5AiWfnfpIEU6lh8GEwvK+d/lpSqm2jPRpo3kI/mx/PStVgPUygjCE6W+x4wnVpSgkq2ltMwhUSqEx3HkSHCsgnb7YSc3qdCPedxAo2ckTSwgNTwa8CNFAO+vnR79t4h7/JMd6BGcgAWYLJUCo9B0YUjwbAiEFPaQlf8mCrNxnv/4b+whvN7uhcT+4VYy97uGCx4Vvw1GkpYLv3ExonCY3WiHFPVNRQZF1aTk1HL+oRt02+YSs9pIvUdTnwf0PjFIRXLWyygmhp50yGy6sDd+g9vr2tUjkkzcz9qX8ZRbQZKNFKNuUN0Bz9eU/7MZzO+z/DBJ8Z0PYsnn8uJqdJmLmJTRvhewxkGNdltLyDM/8LfwtUjxksWYmV6/RD8qiMcoQAeS0MnFPeagaxR0txBeIDWF6V689lyCy4AhATgvlWkFVO/pJooA6qXgWbenwlEM1GoY51wf/WdlY1iuG1JJb9y+LAYwzkgzNiW9NyDfjmcktPOSiaA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9914aa5e-0884-4ee9-1892-08d85fb9af8d
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1163.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2020 12:10:39.4482
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YJ1IdXCWOxcbRP2Z3Jh0NVYTEaU5spT9gj115JQZpID0iMyqKO0XgX9Biy12OS6jS0kplfEAguHCXDUbBQVmsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4436
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introducing support for AMD Secure Nested Paging (SNP) with IOMMU,
which mainly affects the use of IOMMU Exclusion Base and Range Limit
registers. Note that these registers are no longer used by Linux IOMMU
driver. Patch 2 and 3 are SNP-specific, and discuss detail of
the implementation.

In order to support SNP, the current Completion Wait Write-back logic
is modified (patch 1/4). This change is independent from SNP.

Please see the following white paper for more info on SNP:
  https://www.amd.com/system/files/TechDocs/SEV-SNP-strengthening-vm-isolation-with-integrity-protection-and-more.pdf 

Changes from V1: (https://lkml.org/lkml/2020/9/16/455)
- Patch 2/3: Fix up per Joerg's comments

Thank you,
Suravee

Suravee Suthikulpanit (3):
  iommu: amd: Use 4K page for completion wait write-back semaphore
  iommu: amd: Add support for RMP_PAGE_FAULT and RMP_HW_ERR
  iommu: amd: Re-purpose Exclusion range registers to support SNP CWWB

 drivers/iommu/amd/amd_iommu_types.h |  6 +-
 drivers/iommu/amd/init.c            | 44 ++++++++++++++
 drivers/iommu/amd/iommu.c           | 90 +++++++++++++++++++++++++----
 3 files changed, 127 insertions(+), 13 deletions(-)

-- 
2.17.1

