Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21FE0298582
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 03:14:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1421362AbgJZCOg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Oct 2020 22:14:36 -0400
Received: from mail-bn8nam11on2042.outbound.protection.outlook.com ([40.107.236.42]:15969
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2394010AbgJZCOg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Oct 2020 22:14:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cn8FF1VNO26VpPnaVVEnXyURuZX9SIZcT2V27eUfB79O2I9emV6Edx9OlLAwAh1GMbR5/NQegXWkL+5pJqVLaqpU8Km088gjhZXyhQ2+8aEEl/R5Idsoujogky7MCLA5Xlo+zvKZaXiLkCahYkWVdUmaMiLhmR1jxfGxUsoz8gNhSGLVaZoqfFszDOCm6jKEoQrFndwMSA2TtknrtHmImip1kWYbVC+0NnMo3yeeHX0R6qoOx9pYK5RaM0bFkoKcO0nGeeuSdt62k+IuxQaZuqFhBSm9YvDlHz+DDHtIH7uad81xxehZnQMb/MSIXYipIWuoRV4C449PxoDNt+qAsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lu7c0qhmBseAY0PeKMKfb8sncVqBaulG1FcJADh5mSg=;
 b=ji4icAYG1D045nzkKuKzc1fpoShO5NCaa/GxoDfvIvmYwwRcnHYGVvukgx3BV/N4klnEgjQNNz1btUFIvRS0dxWuE+d4q00EvRjFN2jzw93NJCzv+plga+7qdF8We1aQ+GGiKhfvbVJm+HumLj9LBEwNp9fBD9CVZ/URU0WYEYvcqsPRPOXtY1aDwt0LPjsX4v+XX9vStA0sx2HgXNFc/8hSzkTj3tVp+GC6p97ldMiZGN2V7f0zsMF4Qx1moSJx3tELqzDLENOEi5PASAk0P4SXINUQeMGsG7TcS9bCNBW8yVtZXSQxhzdCGKuCjNpGvWkFvPkpQijfwLc8Zsr80g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lu7c0qhmBseAY0PeKMKfb8sncVqBaulG1FcJADh5mSg=;
 b=gPRTQXAlNqZF3aq+ExdCS48eba/j+0MyB5S2+F4olyetPvUs4bxsZGl3V8PLCxB5wBlSIgCTXT9+1OTrutZbg60f35n7Cq1ZEUnQnYYCfMdkxdGWWtvWCwDoXxHnk+pxIAnXRqqpYafScMPj5h+kKCI6pVMZaoNKqoS2BYC2w6s=
Authentication-Results: 8bytes.org; dkim=none (message not signed)
 header.d=none;8bytes.org; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4597.namprd12.prod.outlook.com (2603:10b6:a03:10b::14)
 by BY5PR12MB4856.namprd12.prod.outlook.com (2603:10b6:a03:1d5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Mon, 26 Oct
 2020 02:14:33 +0000
Received: from BYAPR12MB4597.namprd12.prod.outlook.com
 ([fe80::74c5:c3c5:26ae:524c]) by BYAPR12MB4597.namprd12.prod.outlook.com
 ([fe80::74c5:c3c5:26ae:524c%2]) with mapi id 15.20.3499.018; Mon, 26 Oct 2020
 02:14:32 +0000
Subject: Re: [PATCH] iommu/amd: Increase interrupt remapping table limit to
 512 entries
To:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Cc:     joro@8bytes.org
References: <20201015025002.87997-1-suravee.suthikulpanit@amd.com>
From:   Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Message-ID: <ccbe0d64-39b5-4c09-5aae-6351fd1f6db4@amd.com>
Date:   Mon, 26 Oct 2020 09:14:21 +0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.12.1
In-Reply-To: <20201015025002.87997-1-suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [61.90.26.32]
X-ClientProxiedBy: SGXP274CA0004.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::16)
 To BYAPR12MB4597.namprd12.prod.outlook.com (2603:10b6:a03:10b::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Suravees-MacBook-Pro.local (61.90.26.32) by SGXP274CA0004.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend Transport; Mon, 26 Oct 2020 02:14:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9553df90-2d04-482c-0e71-08d87954e055
X-MS-TrafficTypeDiagnostic: BY5PR12MB4856:
X-Microsoft-Antispam-PRVS: <BY5PR12MB485667F29713C800A6F7B003F3190@BY5PR12MB4856.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gEm+bxzJnx+bRcl43j6tfjzwPKlBxy578jiEHbGzQMNPrVfNsIxQ6LCa/48Vb4OXoVYnKaVs8zHePGfg5M9AQ8IDAIhE2nlaydz3XWioLmTP/NNmXCdX0WMwXn0miHr32cIYNxUStZvFki8Wm8ATOnfIda4FC2K7BNImAY7o+legk/brC0jesqfLk4LxlnUexUUVDjWzxs6fpA75d+CfreUs3jnDcjG8J1WWaYO0bfQOxPYCw5IvciPoEvFfB0Kud8W772gWFVGVY/+BggAu8yQFaOjDubNwoO4jFuWunzYkizLo5cPGtOWi2dfI3GtWI+iwzrYbiXiJiXCJx9fVVpYTUxHpEW6FX9hC+zEFGM24OrIZnZm7pcCYoKidmQ3H
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4597.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(366004)(396003)(346002)(376002)(136003)(16526019)(44832011)(316002)(83380400001)(6666004)(36756003)(2906002)(2616005)(86362001)(52116002)(4326008)(956004)(478600001)(26005)(53546011)(31696002)(8676002)(5660300002)(6506007)(66946007)(66556008)(66476007)(186003)(6486002)(31686004)(6512007)(8936002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: cVfw+WF4ZJqHE2s6rxPJk3C3V7lzHZioMEhbfcyGOIv4CmYulknHto+TQXQU7+vG4mbrYSV7lkAG2MPHEqW2u2Lzo/nIJT4GsHl3kKst4A1pKwP2K/xW4c2OtiE4Ep9H47pY/Y7RfCjihlXm1dVqLcXt0x1zdxZE4Ok8Wqt7a/CNga0uPjtszDy7laMbQMKktsMPNOtg6G2k/FJHvQsluPpayaS8JGaL5/8VMKjInwkYy+tR3mbJG2297aRK2D+4qwCa0Z/s47v95wE2mZcP5PjNirz9gh2mL8uSuCL3ez78yyKDDMpfS6pPvxGmKYb4730YHlBD11WhC9nSUY5BrHLQ1Tx9uHZF/IrMGMVkPVs6qQVafZOn2R3m4fc7wSRC/dxE3ixOPLFyO1EmKz4JWzPk8RpsZVQhAKnlTiKssbmd1EINZshajLLdKtH88wh5nfPnSwHEjL3NEwwhZBaruD54pnhPI6NiS8DEKglPxCf6cpOOaj2Uy1zzSUSjDZXn0OQos4+L9Os2kuLhA3M2vt28PMQWRP5NoONRWAb0GikyHZzSTSb5QW5RcdCpfsLlheobXQSzkMEnSNsXmBv4rcXY6GmY1bscMyJgyoTuRvVU1cp/vRth+7mUHPs/YjYHTKm3ulaXa22XwHbzTLE0Fg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9553df90-2d04-482c-0e71-08d87954e055
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4597.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2020 02:14:32.6826
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B3/XROSP9BJC/lpFYCHAKBk3qAEBWx5UYLtWf7ScM6RPhS2mIK3gSo8hpysyL6jl3jgeYkmsO5QsFaYYtLXnVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4856
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joerg,

Do you have any concerns regarding this patch?

Thanks,
Suravee

On 10/15/20 9:50 AM, Suravee Suthikulpanit wrote:
> Certain device drivers allocate IO queues on a per-cpu basis.
> On AMD EPYC platform, which can support up-to 256 cpu threads,
> this can exceed the current MAX_IRQ_PER_TABLE limit of 256,
> and result in the error message:
> 
>      AMD-Vi: Failed to allocate IRTE
> 
> This has been observed with certain NVME devices.
> 
> AMD IOMMU hardware can actually support upto 512 interrupt
> remapping table entries. Therefore, update the driver to
> match the hardware limit.
> 
> Please note that this also increases the size of interrupt remapping
> table to 8KB per device when using the 128-bit IRTE format.
> 
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> ---
>   drivers/iommu/amd/amd_iommu_types.h | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
> index 30a5d412255a..427484c45589 100644
> --- a/drivers/iommu/amd/amd_iommu_types.h
> +++ b/drivers/iommu/amd/amd_iommu_types.h
> @@ -406,7 +406,11 @@ extern bool amd_iommu_np_cache;
>   /* Only true if all IOMMUs support device IOTLBs */
>   extern bool amd_iommu_iotlb_sup;
>   
> -#define MAX_IRQS_PER_TABLE	256
> +/*
> + * AMD IOMMU hardware only support 512 IRTEs despite
> + * the architectural limitation of 2048 entries.
> + */
> +#define MAX_IRQS_PER_TABLE	512
>   #define IRQ_TABLE_ALIGNMENT	128
>   
>   struct irq_remap_table {
> 
