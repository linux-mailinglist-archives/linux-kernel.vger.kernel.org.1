Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 030DF278499
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 11:59:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728012AbgIYJ7S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 05:59:18 -0400
Received: from mail-eopbgr750074.outbound.protection.outlook.com ([40.107.75.74]:20166
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727132AbgIYJ7R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 05:59:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A7jwqbovKAVCVp9a4BbtQ3k2U6860YlHJEha7EsSj52QAwI0d/dgNCiWjpHKND/WEfNOAHp526AnYBJz3+hUpimQo5DV3LiuWy6XfZ4cMgED2TnT6dOmTRsqka+++idho+IkmbH6WMkVJYgmAbT4Z3xF8euY9t8BdSmtQ1YHqBTUP/QpHG3Ka7a6ovt35F2LhRm9b6/sWgNvIUg2kvcHcOO71iUQKKD1Jim7CQ0RNONRwUeVV3PbbrWfyxlCSUXjmq3uu2rX1aB1Wf/OxCnZCvaqfBZ7lCaLRqH245GIB73U8EayTaSKRsIHNN7mN+pJqvG5UkR0f+9LJrpj17ZJ1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vCRHQVW0zDwQ+WT+4LCafY+uSCXYvjBkOIiCiAUSFB4=;
 b=TOzQEZ1OmyzEGCOIUL4nhQdTMx5MZJFa96708V2qqDW1TJvFJ0vtd/skBkSkaSVUPS6pk3gOSKXN4K1SaljceFTxkEx/v5mDhMy4nNkl7oNUGljioJAIoiX5iJSq5r4TbZckmD40+bAlmMCTDC4WJJxBEQ5uIipQXUerRImuwVDFKRkiVTSu3kzoQxVoR9gHFmu6mu/DIme0lC+OjNuv3GChFI/EW8bYcbTHNkPcnJn7ynTICqjShIpn8F2A/J+tq+jNvgvv3lSFFnJ3j34igyuArTTeN3WXol1pARATiOFa0plfmPbYV02w+84LdnFtpC0s8nH5TGh5aMEYcofqvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vCRHQVW0zDwQ+WT+4LCafY+uSCXYvjBkOIiCiAUSFB4=;
 b=se0Y8Lp+DxUsqUEb9VdeJDkt7/Illo3ExRB7KUNL6eA5aE6CO6uTuO6fHO0Gqi0fpFsNsQzUUVlCGcbVgKNRBLViFdTvja49zIZtYqJropRSKgMxTm0PVlgjEqnvyYB0KhzC5fQzx3aJZFA4PXzJi1vXzIN+VmvaSdPAX23GIBM=
Authentication-Results: lists.linux-foundation.org; dkim=none (message not
 signed) header.d=none;lists.linux-foundation.org; dmarc=none action=none
 header.from=amd.com;
Received: from DM5PR12MB1163.namprd12.prod.outlook.com (2603:10b6:3:7a::18) by
 DM5PR1201MB0220.namprd12.prod.outlook.com (2603:10b6:4:4e::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3391.14; Fri, 25 Sep 2020 09:59:14 +0000
Received: from DM5PR12MB1163.namprd12.prod.outlook.com
 ([fe80::48cf:d69:d457:1b1e]) by DM5PR12MB1163.namprd12.prod.outlook.com
 ([fe80::48cf:d69:d457:1b1e%5]) with mapi id 15.20.3412.024; Fri, 25 Sep 2020
 09:59:14 +0000
Subject: Re: [PATCH 02/13] iommu: amd: Prepare for generic IO page table
 framework
To:     Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org
References: <20200923101442.73157-1-suravee.suthikulpanit@amd.com>
 <20200923101442.73157-3-suravee.suthikulpanit@amd.com>
 <a2e28845-d162-281a-c762-698d1750bbea@arm.com>
From:   Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Message-ID: <af467992-8b37-0900-a0cf-cbfbfc948d0d@amd.com>
Date:   Fri, 25 Sep 2020 16:58:53 +0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.12.0
In-Reply-To: <a2e28845-d162-281a-c762-698d1750bbea@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [165.204.80.7]
X-ClientProxiedBy: KL1PR01CA0127.apcprd01.prod.exchangelabs.com
 (2603:1096:820:4::19) To DM5PR12MB1163.namprd12.prod.outlook.com
 (2603:10b6:3:7a::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Suravees-MacBook-Pro.local (165.204.80.7) by KL1PR01CA0127.apcprd01.prod.exchangelabs.com (2603:1096:820:4::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20 via Frontend Transport; Fri, 25 Sep 2020 09:59:13 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b292f264-6e62-4dc9-b4cc-08d86139a88e
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0220:
X-Microsoft-Antispam-PRVS: <DM5PR1201MB0220EEA7AF30A65093186CD6F3360@DM5PR1201MB0220.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9jwL9wRR46mwBoZY3tt1zS/Ilqq8ix1+gA2x8efZ6uzzYo7PLOAVEuE1/FnN7aAusRlYFUgr6IB9RfM2NE4g+p7OU8A1WyVm6I45xvdxFga3zOhVUGZ8kLapdecE4wq8fx05QUf5KNhq4AzPjcqFWUHYJ5j0kRdNNx7rVGcaJIFiNB4spSsIHyEXajAISZZbZE2ft8sEd5DbWu1yfY5tPIaXHlGf0Kvc7mchnU4ZvWGrH8GXmWykNGKltDg8TNAsaFZLy1jdY25arNX4gZ246pymMAxYalfx54dzmybXbwnDDA4rEKXDaG23WPs+vN+8a3SS03N5V+7V/HdEJf1/ErTmQ9Y33Jv9t8rsikHqTD9L8W9KVwbWyWDMUSvwjiUrr0XQEB7lHBZGflgYR2+CeYAP7+BXnEBDolt5xsm2kGbs/8daK9TtXyoo7gh/vVjdyDDCB3PSKGEvkKPyMLM1QQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB1163.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(396003)(136003)(366004)(346002)(376002)(86362001)(8936002)(66946007)(6666004)(2906002)(6512007)(26005)(31696002)(66476007)(31686004)(186003)(8676002)(66556008)(5660300002)(53546011)(956004)(6486002)(478600001)(16526019)(44832011)(316002)(2616005)(36756003)(52116002)(6506007)(41533002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: weNmVd7+tgoO/3e15SRcTVSCmy2OtQw8j81L6dIhYheHMSnsxOkaBnKar/0VGWrKHRBxjgsF45tvM3OGcMmSq+fFZzg0ZpZYWpO2lgwPDNvAIo2PmS4OKV9d1jkJAeXsCWkMKUbpeVLLgTrLR3KnQa61y6CcfXIYto8AsweDXHK8kuQS/7dIx5RoTTKyiWVCSy43BblBfyH78fDq+H+d4cm8jmFZKBH2gpQ/nkksfBBC9vRpGkpv2Srf3nrk3okcUStxlVbkmu8AdhpLqnhVKIs2A/c609/1cNWcWSOlwF5BBlHZLK5VTnMnvDZ1/Xv2qW17eyMu3E0SSd4QO0MvqkdMfA3j2hyMFs1F0W7nOi6pEdP2WNJS6sySwG3O7JYpFOLLwB15N7P2V7/tHNvOzrQLThDfrFVbUt+jB526hUh8Az4zxQmsyxn9wKPWmy2fAj+HfRr+dRv8SvXVFi11EQ+FBpTu/AV6QMOg8vHyAdf7OgkqaMhg2iYkdKhzReiJ/G2h1rwBntq1PHtEZhJYMMwHpqvaa1AgdFIhMHkVH7lw4FuK9sNgbwxpfSu1Bg62wYCsTtXz4XUBZJzRbfreRfdgtMoQ32fw9BEORcaBT2HGeKxceW+oUzGUsumIoopr3jNd+eBJrFHCj3DhbOOv3g==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b292f264-6e62-4dc9-b4cc-08d86139a88e
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1163.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2020 09:59:14.3479
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h2zJFh3YN7EeBMEBE31dfwKGyo9GCwoFvkhXFMm29CE4UveqzQPFCni3qSvCoVqJNBmRC6Ly3bnlAL1+5arpHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0220
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Robin,

On 9/24/20 7:25 PM, Robin Murphy wrote:
>> +struct io_pgtable_ops *amd_iommu_setup_io_pgtable_ops(struct iommu_dev_data *dev_data,
>> +                         struct protection_domain *domain)
>> +{
>> +        domain->iop.pgtbl_cfg = (struct io_pgtable_cfg) {
>> +        .pgsize_bitmap    = AMD_IOMMU_PGSIZES,
>> +        .ias        = IOMMU_IN_ADDR_BIT_SIZE,
>> +        .oas        = IOMMU_OUT_ADDR_BIT_SIZE,
>> +        .coherent_walk    = false,
> 
> Is that right? Given that you seem to use regular kernel addresses for pagetable pages and don't have any obvious cache 
> maintenance around PTE manipulation, I suspect not ;)
> > It's fair enough if your implementation doesn't use this and simply assumes coherency, but in that case it would be less
> confusing to have the driver set it to true for the sake of honesty, or just leave it out 
> entirely - explicitly setting false gives the illusion of being meaningful.

AMD IOMMU can be configured to disable snoop for page table walk of a particular device (DTE[SD]=1). However, the 
current Linux driver does not set this bit, which should assume coherency. We can just leaving this out for now. I can 
remove this when I send out V2 along w/ other changes.

> Otherwise, the io-pgtable parts all look OK to me - it's nice to finally 
> fulfil the original intent of not being an Arm-specific thing :D
> 
> Robin.

Thanks,
Suravee
