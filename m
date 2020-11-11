Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A8BE2AE6D8
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 04:10:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726024AbgKKDKV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 22:10:21 -0500
Received: from mail-dm6nam10on2060.outbound.protection.outlook.com ([40.107.93.60]:65216
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725839AbgKKDKU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 22:10:20 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jvVfy/9f8dP5OJGj97lL3QlCFCRVMSlfB1k6PLY4wyv/vXO0YzRax8FwVfM5ZZ2OA+ILWcarbYo2YG/+raslqPFT1tzuwq7i5uuIW7n8FUxyYED6NbFHoxeeFiEoHIIjht04EEJyAgeMiYHpaWU/nHhuUZR7uB6lDoJS6B4gzl6vx+SmKQVJaxwiuSKG0nQDvCxrLWjFPdE/vjNT0AIcFZ4P8i+lBBljt88Lj9BfZcTVam1EEj57/WiEexxMnQF5x59CumxUjoY7lq0ypgPSHmH3x0oDeJAhh651pMGEb0r1jvHObOcXJjKuYHy0dskoF0VtyeawakDjjXhFY3PHxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xxlcvbBI2fob+ltg5VIzuEpiHYuAt2yrbzUpR/b895o=;
 b=FqJ+sNRq4iNq8qsYJZRd2kgPtuRGO/i+L+5i2Emwahxyj3spB5LJGjPMHk/5PeelJS21KLCljNXTrVH52ZthIfDklezojIJ6zBWiYwzf2iVENuvBMdyjDgiRxe7ktDjfer61jcSe34Im53f2iMbrW2PVSvH+BXwk+Wlrzca9oycChI6Zoqq1SuJIuHIyyAB2K8Dlrax8eD5uVu54QyCbqAbO9ZMhLWZaJ8n3jP+K4FDLYM4w01RcvsFC38tSkJPvC/6D1dGwGO/AFNjIhZ6ApNOlgwWlOwTqzESA34usZ9UCLwxjOe/46QNYiNbZwjt3cy8u4WnCQP/8xLgkNUK0TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xxlcvbBI2fob+ltg5VIzuEpiHYuAt2yrbzUpR/b895o=;
 b=GPToxrUTpGiQ6qxYmKTW8P6uMIntGy/33D2ff5gTBSG05MlRwwRHJ/tUXWSHQAPP0L4Psm0iquqzOX9vKjeSoIjK3eFSStFf0NiEUQZsdCu6i9L+bCgq2skVCKicZuozYF0OnJ8czxyQQ9cszwlrcpHdVbznP0LpLDLEN5FUWxM=
Authentication-Results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4597.namprd12.prod.outlook.com (2603:10b6:a03:10b::14)
 by BY5PR12MB4163.namprd12.prod.outlook.com (2603:10b6:a03:202::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Wed, 11 Nov
 2020 03:10:17 +0000
Received: from BYAPR12MB4597.namprd12.prod.outlook.com
 ([fe80::dd10:efd2:e325:53c7]) by BYAPR12MB4597.namprd12.prod.outlook.com
 ([fe80::dd10:efd2:e325:53c7%3]) with mapi id 15.20.3541.025; Wed, 11 Nov 2020
 03:10:17 +0000
Subject: Re: [PATCH v3 00/14] iommu/amd: Add Generic IO Page Table Framework
 Support
From:   Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Cc:     joro@8bytes.org, robin.murphy@arm.com
References: <20201004014549.16065-1-suravee.suthikulpanit@amd.com>
 <f28359ed-47dc-281f-7261-6320150ef906@amd.com>
Message-ID: <eb567d23-b63b-a10a-d0b1-c03281a1f602@amd.com>
Date:   Wed, 11 Nov 2020 10:10:06 +0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.4.1
In-Reply-To: <f28359ed-47dc-281f-7261-6320150ef906@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [165.204.159.242]
X-ClientProxiedBy: BM1PR01CA0091.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:1::31) To BYAPR12MB4597.namprd12.prod.outlook.com
 (2603:10b6:a03:10b::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Suravees-MacBook-Pro.local (165.204.159.242) by BM1PR01CA0091.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:1::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21 via Frontend Transport; Wed, 11 Nov 2020 03:10:14 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: deb88366-577e-48f3-1027-08d885ef508d
X-MS-TrafficTypeDiagnostic: BY5PR12MB4163:
X-Microsoft-Antispam-PRVS: <BY5PR12MB4163F1EA48864EB7D6CA4F2EF3E80@BY5PR12MB4163.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eUeQPU0RuyZhiRQF/KIfcuPXaShnWkFazdC14dEYTSezbW1kmMTtxleUhxJRjLPNhNVRMuOIZkOkbFTBAnT4+OoKZhecTI4DF9PJRkm3eckQZhjM7lGIvH0xGpYeubwyQDGmH9lGDsmznPYUaFbMLbMxba06l+3u6tgsP8i4hrct+025Yroo73UA1+11eDld5Vnlpsp9n9pAPGvh9SlhRK+riBOY2ylSnyoVP5kku1n73Rq5qFjwBIhqH8O7nycyfcqNO/+JdIXzSPQnlU+DPPsW4qL6Y1Fv74lzABJdo0iR0JygfO5JmM2dcuyn7ubrySXdAnsyi8666s8m4Wk16bb5J1FyIy++qcrJuwiiCFZ6FOH3X1qW19xUt+X1y8w6MF/Xqfd1023V5I7lcMRUVD6Xk3a2gcLtxu2dndzAWcKuMmYIo1zYlPlXhvC7kLhEUfplybx7eNytRxAponCFdaM//jywGop3v4sSWL/e1xo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4597.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(346002)(39860400002)(136003)(376002)(53546011)(6506007)(8676002)(44832011)(52116002)(66476007)(66946007)(5660300002)(2906002)(16526019)(31686004)(8936002)(186003)(66556008)(26005)(2616005)(86362001)(83380400001)(316002)(956004)(6666004)(6486002)(36756003)(4326008)(478600001)(6512007)(31696002)(41533002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: OJlpwtqQWNA/7tgilhfb91JUm3plNJoqe8XLsbu6hqy/5lr1rSNFzm900W8cpCfFEvIo9qmIpQuXNAiMkpwzVUIcPWohqGb88BsiirfdAVbWO0OYf2FjxKBCHvi8teLE2ZDL4ww3riOTshIGVBXTUw9dBbMocVzhZt3G/owjtYk0ocTfk+vM20hz+ACicuUmo37SwjCxJMdZuqCDX/7MOeMD8BM1IWSOrf0hVSkPwBzB0HYOdAOyEtvbg2IJpKczQq6bb5RtXx0i4XVI0lN3b4f+hMTdKTbQ92QWg1ApN/zsa4sZGqbzNxBeNSPtfzb55b51GtMvsEYLSW0Ql3FTqCgyK/VNbM0MetN/G9Fb8Bj2wobfOOC++2YYFpRf2Gw/HfnDTWws2G5MC77oeFDZPbntwpVDC9Hs9S/vfNkluslafeXaFCq1XuAmjgLViJ+DrgyhWELYSKY9q5VeG33hSGSZD084qbQh7vIW/1U/ERBQ2FZ4kp2ttE4HzoXeszySnv1XaxgCHc8DhliQRKTohKq4Nes78XqHUpvieoMO5q+OSHsbOBj0x4UGkYrTKy6LJPu6o5hJl9VGmZG7Ps06/9A1gaITyLZZAMTZprvzmdLD+2ED82pDDVJBnGoPz5Ujv6nmPOgrx77k7DyetkeyaQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: deb88366-577e-48f3-1027-08d885ef508d
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4597.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2020 03:10:17.2162
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w1zZwsED/uMqbW8x5U1Tci3dCcRm/VFopBRYFoZ8DInAifepnSdD/+aAQKCD40lb8Zv6vZOi2u2dRlJ/pC58VQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4163
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joerg,

Do you have any update on this series?

Thanks,
Suravee

On 11/2/20 10:16 AM, Suravee Suthikulpanit wrote:
> Joerg,
> 
> You mentioned to remind you to pull this in to linux-next.
> 
> Thanks,
> Suravee
> 
> On 10/4/20 8:45 AM, Suravee Suthikulpanit wrote:
>> The framework allows callable implementation of IO page table.
>> This allows AMD IOMMU driver to switch between different types
>> of AMD IOMMU page tables (e.g. v1 vs. v2).
>>
>> This series refactors the current implementation of AMD IOMMU v1 page table
>> to adopt the framework. There should be no functional change.
>> Subsequent series will introduce support for the AMD IOMMU v2 page table.
>>
>> Thanks,
>> Suravee
>>
>> Change from V2 (https://lore.kernel.org/lkml/835c0d46-ed96-9fbe-856a-777dcffac967@amd.com/T/#t)
>>    - Patch 2/14: Introduce helper function io_pgtable_cfg_to_data.
>>    - Patch 13/14: Put back the struct iommu_flush_ops since patch v2 would run into
>>      NULL pointer bug when calling free_io_pgtable_ops if not defined.
>>
>> Change from V1 (https://lkml.org/lkml/2020/9/23/251)
>>    - Do not specify struct io_pgtable_cfg.coherent_walk, since it is
>>      not currently used. (per Robin)
>>    - Remove unused struct iommu_flush_ops.  (patch 2/13)
>>    - Move amd_iommu_setup_io_pgtable_ops to iommu.c instead of io_pgtable.c
>>      patch 13/13)
>>
>> Suravee Suthikulpanit (14):
>>    iommu/amd: Re-define amd_iommu_domain_encode_pgtable as inline
>>    iommu/amd: Prepare for generic IO page table framework
>>    iommu/amd: Move pt_root to to struct amd_io_pgtable
>>    iommu/amd: Convert to using amd_io_pgtable
>>    iommu/amd: Declare functions as extern
>>    iommu/amd: Move IO page table related functions
>>    iommu/amd: Restructure code for freeing page table
>>    iommu/amd: Remove amd_iommu_domain_get_pgtable
>>    iommu/amd: Rename variables to be consistent with struct
>>      io_pgtable_ops
>>    iommu/amd: Refactor fetch_pte to use struct amd_io_pgtable
>>    iommu/amd: Introduce iommu_v1_iova_to_phys
>>    iommu/amd: Introduce iommu_v1_map_page and iommu_v1_unmap_page
>>    iommu/amd: Introduce IOMMU flush callbacks
>>    iommu/amd: Adopt IO page table framework
>>
>>   drivers/iommu/amd/Kconfig           |   1 +
>>   drivers/iommu/amd/Makefile          |   2 +-
>>   drivers/iommu/amd/amd_iommu.h       |  22 +
>>   drivers/iommu/amd/amd_iommu_types.h |  43 +-
>>   drivers/iommu/amd/io_pgtable.c      | 564 ++++++++++++++++++++++++
>>   drivers/iommu/amd/iommu.c           | 646 +++-------------------------
>>   drivers/iommu/io-pgtable.c          |   3 +
>>   include/linux/io-pgtable.h          |   2 +
>>   8 files changed, 691 insertions(+), 592 deletions(-)
>>   create mode 100644 drivers/iommu/amd/io_pgtable.c
>>
