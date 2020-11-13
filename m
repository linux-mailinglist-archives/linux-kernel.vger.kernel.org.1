Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B6752B15AC
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 06:57:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726142AbgKMF5d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 00:57:33 -0500
Received: from mail-bn7nam10on2056.outbound.protection.outlook.com ([40.107.92.56]:26608
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725971AbgKMF5d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 00:57:33 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fjtsk7lebcUzVDB9WwAGZnPMpm/jfuKoflcXNDwgBty4fWNGTTLGIjvIFEReiYhT+WKxNSnZmOqyExwSpSYmlQ1OfqcRqj/eMHQBcXSOaEf+jOKU36YecB7Dp624uWP3MQmGtV1etYkrUwRo/jgEvFRMpCczwijM+0/ShQfbuaZBzIWVbfmAG6/zt0h1BkJJ1pDeoqNZkxs1GuGCaYHIv3W2RcNcQx+ifj62n6HEKDHJMQS90LOsUT+9tSUNOB98VLlu1LHtmuSGGdqdvywI7l+Yh7l0xe87LD9siAKwhT3llUFKZAMxla9QnBffE4tpnoCR2zuaOYrY/POQntfCnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/xwf7sPOuSMEIO4yUZCKr3VKhR8AXaKIKUEr/RMAzAY=;
 b=ljv3aVJVxHGQYE//8gte8CbcP71sFqpB4Z8zVdrHy8oJmyiaEp1U1yz93leAGpK+A/z60y41QFadFl5VShLbYDAhbX/i9cMraFGJwoQoBHTp8ZYt1v1oDZnmb36bRwv1rBTcRQRs3RmzzEpudg+rJaHqezwAJ38cKWraNOb8jsF1zAguuJjxUY2e7bOxDmmB4lkPbbu9QLuewDkWry9SYNK0zCHVoNKdjchD60Ijej0SfWpeWoVi/pRIwZTStdVY+zuDZq1BsoFQly/tTNOY9XPs5wgLAeq8wJIJHJJyPgbxtTlDwQiGd1C0U6tOyYUlM16Gnk9Ie21DjD9DYqxdLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/xwf7sPOuSMEIO4yUZCKr3VKhR8AXaKIKUEr/RMAzAY=;
 b=T3oqWwxonB6adzW+86co+0JWRDP+//iHXnm36/rZr4LDyb9X9kqGA3YotPwDUUjUCcpBxzWJU2rV3ZSg5FqMAKpytBLAAlOeKhGWvqXhI7tRPzM1MPjX+EOAWrbHLe2jwiycw41ZvhibIYw2QKXa04QmcgdmM/Z5To1R5LGdD9c=
Authentication-Results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4597.namprd12.prod.outlook.com (2603:10b6:a03:10b::14)
 by BY5PR12MB4818.namprd12.prod.outlook.com (2603:10b6:a03:1b4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.24; Fri, 13 Nov
 2020 05:57:30 +0000
Received: from BYAPR12MB4597.namprd12.prod.outlook.com
 ([fe80::dd10:efd2:e325:53c7]) by BYAPR12MB4597.namprd12.prod.outlook.com
 ([fe80::dd10:efd2:e325:53c7%3]) with mapi id 15.20.3541.025; Fri, 13 Nov 2020
 05:57:30 +0000
Subject: Re: [PATCH v3 00/14] iommu/amd: Add Generic IO Page Table Framework
 Support
From:   Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Cc:     joro@8bytes.org, robin.murphy@arm.com
References: <20201004014549.16065-1-suravee.suthikulpanit@amd.com>
 <f28359ed-47dc-281f-7261-6320150ef906@amd.com>
 <eb567d23-b63b-a10a-d0b1-c03281a1f602@amd.com>
Message-ID: <4dce5bdb-1a08-75ad-fd41-a1686521fef1@amd.com>
Date:   Fri, 13 Nov 2020 12:57:18 +0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.4.1
In-Reply-To: <eb567d23-b63b-a10a-d0b1-c03281a1f602@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [165.204.80.7]
X-ClientProxiedBy: KL1PR02CA0027.apcprd02.prod.outlook.com
 (2603:1096:820:d::14) To BYAPR12MB4597.namprd12.prod.outlook.com
 (2603:10b6:a03:10b::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Suravees-MacBook-Pro.local (165.204.80.7) by KL1PR02CA0027.apcprd02.prod.outlook.com (2603:1096:820:d::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.25 via Frontend Transport; Fri, 13 Nov 2020 05:57:27 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e863f8dc-c632-44a2-b620-08d88799010b
X-MS-TrafficTypeDiagnostic: BY5PR12MB4818:
X-Microsoft-Antispam-PRVS: <BY5PR12MB4818A9B206F0C392F71E142CF3E60@BY5PR12MB4818.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oKyAwohJolNPLAaqeXlEsDBKxFkR4E58EKmUs7OwUwVioXwOTxih5ctV0lfBpVZzpLbq5mMeNOCgJSj7me8XU9TonOHwC35kYepKcvlfu/J+rA3Ky4K0sPkQxeV0MwYcsnX+MFviZ+/RMHU0Wa29SZJgvL1FCFYClSolChEXvB+BPdehiDACKp81INaee0vFezXmpizSa0AieSvyokYmXzb7Ei66UcQWviMufHolAtlGZkI1kAoYlhXiOLoSGqWRSQkiqaco1fJw4DrQCN0ygSUT8CIsJxS20DiSA7YKI+8J7aA14+VChB5FrCYgy0PxZjXC2vyWNQTdSz83zrgBnKYldy6qRgsKY2+IXCar/z2KtsAf5RG8giG9BSWcnrbrA6ZOl82/d/rYY8oVeoHQPJzT0EnQfRZrpkPg52nd9GtukRMJAC6utQsHOt187N+j8fgZx+RyhSNCqL3K3SYDT9xuS4Kq9aQPxxfzWpAcX3Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4597.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(376002)(39860400002)(346002)(366004)(956004)(2616005)(478600001)(8676002)(6666004)(6506007)(26005)(53546011)(186003)(83380400001)(52116002)(2906002)(66556008)(6486002)(8936002)(66476007)(16526019)(36756003)(6512007)(86362001)(66946007)(5660300002)(44832011)(31696002)(31686004)(4326008)(316002)(41533002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: elFTTc67wxV3/bRkZWkyXj2JmqXcrAnx7Ix2Nr9XNewALXxh+pLiYt2Wy1UrJDRjiSp2ewZvKNAG5UGFDKG6abmfEmzePuxWaq+0BpKPirxoBVjwIbhicHQPdA5D1q7KrXNkI3T21vCDHydEd2spMVH4zQlInUaad5jKZOvrJxCkIgf48wewlhrzp4Bu2Bw6mRzHLDxQuQDvAlHH9dzQpfowg15HrUHMyYlI2gxW1ql3watnImoAVJfNf5tACX7kERP7fh9olX0mp9e+4fcDPGMKw1ErWQShppiIFrgbRwJQZGaqrRzSqAe2ZeMEpuGjx+BgGVuKh7R+jfha6BPVa0xQqv2ymFdu4X0KsVthyoOEls8jKK+cBvCPno4UNGn7r1OaTLrMUEQjpYi2hmnuQyBVYT1hvUp3h58NCqId04f1DvF1rhbsv0cWNfkxKTPeMXgtrferdgBoR55Z1pUJEQmK1uJimhMq1Usjdw/dRQvAVZekrgQxhqQriMLoMkv+ulbKl+2vaBbGtAv4oW1pq9eghMYnyL0DSFEFIa1wTWeBX60VL8CaiKJTe7Ny9vdf31wceb8yaGX0IR/MtLH3RGzHVzU9YfVGNde/wiqPOoADnNJsOypthrUpo+9MUtyeBEIkJ6S5hZYv5TFxJVOgfw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e863f8dc-c632-44a2-b620-08d88799010b
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4597.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2020 05:57:29.9520
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3mIxihMj0bsTt4FNhZaX7KqsmS+TXg9dNL0GP0YmiqPXhT9D0DWWdOVxV8cw0+5Bf+ZQjAHETeTQHJ3rxkCq4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4818
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Joerg,

Please ignore to include the V3. I am working on V4 to resubmit.

Thank you,
Suravee

On 11/11/20 10:10 AM, Suravee Suthikulpanit wrote:
> Hi Joerg,
> 
> Do you have any update on this series?
> 
> Thanks,
> Suravee
> 
> On 11/2/20 10:16 AM, Suravee Suthikulpanit wrote:
>> Joerg,
>>
>> You mentioned to remind you to pull this in to linux-next.
>>
>> Thanks,
>> Suravee
>>
>> On 10/4/20 8:45 AM, Suravee Suthikulpanit wrote:
>>> The framework allows callable implementation of IO page table.
>>> This allows AMD IOMMU driver to switch between different types
>>> of AMD IOMMU page tables (e.g. v1 vs. v2).
>>>
>>> This series refactors the current implementation of AMD IOMMU v1 page table
>>> to adopt the framework. There should be no functional change.
>>> Subsequent series will introduce support for the AMD IOMMU v2 page table.
>>>
>>> Thanks,
>>> Suravee
>>>
>>> Change from V2 (https://lore.kernel.org/lkml/835c0d46-ed96-9fbe-856a-777dcffac967@amd.com/T/#t)
>>>    - Patch 2/14: Introduce helper function io_pgtable_cfg_to_data.
>>>    - Patch 13/14: Put back the struct iommu_flush_ops since patch v2 would run into
>>>      NULL pointer bug when calling free_io_pgtable_ops if not defined.
>>>
>>> Change from V1 (https://lkml.org/lkml/2020/9/23/251)
>>>    - Do not specify struct io_pgtable_cfg.coherent_walk, since it is
>>>      not currently used. (per Robin)
>>>    - Remove unused struct iommu_flush_ops.  (patch 2/13)
>>>    - Move amd_iommu_setup_io_pgtable_ops to iommu.c instead of io_pgtable.c
>>>      patch 13/13)
>>>
>>> Suravee Suthikulpanit (14):
>>>    iommu/amd: Re-define amd_iommu_domain_encode_pgtable as inline
>>>    iommu/amd: Prepare for generic IO page table framework
>>>    iommu/amd: Move pt_root to to struct amd_io_pgtable
>>>    iommu/amd: Convert to using amd_io_pgtable
>>>    iommu/amd: Declare functions as extern
>>>    iommu/amd: Move IO page table related functions
>>>    iommu/amd: Restructure code for freeing page table
>>>    iommu/amd: Remove amd_iommu_domain_get_pgtable
>>>    iommu/amd: Rename variables to be consistent with struct
>>>      io_pgtable_ops
>>>    iommu/amd: Refactor fetch_pte to use struct amd_io_pgtable
>>>    iommu/amd: Introduce iommu_v1_iova_to_phys
>>>    iommu/amd: Introduce iommu_v1_map_page and iommu_v1_unmap_page
>>>    iommu/amd: Introduce IOMMU flush callbacks
>>>    iommu/amd: Adopt IO page table framework
>>>
>>>   drivers/iommu/amd/Kconfig           |   1 +
>>>   drivers/iommu/amd/Makefile          |   2 +-
>>>   drivers/iommu/amd/amd_iommu.h       |  22 +
>>>   drivers/iommu/amd/amd_iommu_types.h |  43 +-
>>>   drivers/iommu/amd/io_pgtable.c      | 564 ++++++++++++++++++++++++
>>>   drivers/iommu/amd/iommu.c           | 646 +++-------------------------
>>>   drivers/iommu/io-pgtable.c          |   3 +
>>>   include/linux/io-pgtable.h          |   2 +
>>>   8 files changed, 691 insertions(+), 592 deletions(-)
>>>   create mode 100644 drivers/iommu/amd/io_pgtable.c
>>>
