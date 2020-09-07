Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA8BA25F9B3
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Sep 2020 13:42:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728956AbgIGLmP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Sep 2020 07:42:15 -0400
Received: from mail-dm6nam12on2071.outbound.protection.outlook.com ([40.107.243.71]:45217
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729015AbgIGL0W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 07:26:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QoTtfg9xAtE1rnEDShWPlE0BTnU580fGEiDziLGuGU9HVQZoF5n6y+QilUkA09M5PPREK0VCoFoctcuYDS2XYn/TkqX9FJXiuwZu5JZPJEWvbAMwBfy4EUaAu8kU/oy2wh/NMI4ujXtjbX9/6u/4vhLxd9G4h7hYo8KYIfpb37qWKb/OPAsjyEeXWWukWWo3wmsLJ8cE8qZmX/XBnD1BXXlQbIgMdTiTn0R7KtKKCEpKK5Y6bycYT8MJj/dqu+5vGMZ7yJI+iZPaDzjWtmFKTdL3z9Fkoq8sSd8ooAG3m+Ft5mmUk6O/cPR/SJ1kiL+DUN55ZwW5xVDIAur4rS5vsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G06hW8FfUbp5DI8xzd5xPt5Uu/cMM1xC+yNnu8X/TdE=;
 b=VM65JpVrj0vLTFwYQ78jd1DT+C/Vnic6IPZflfuv3FcZTr/Y4Hfv0XSi1JUZsRHj/kjmSKd5HuaiuYMa7yzFIFGJKlSPrfroBQQcoJa4vMrF2kwsBNZjzUjrx7shGoyGBczTLMy5o2PKtIapwTffaP/vL6hgUCnuZ/EWUn75qDmJI0qzWBkZfFmyB2Bx+Mo1cHVzOondqaENkJZm8GrAUxlhqqcFtmDMc+Mxo547P89gOxNovBQrAPfOHCqZUiia9NBZAkp9oPOXP5weBwVCYmP4wjSzDSqK6Zm2DyLY5gnGCXau0D4FHg6P9T4P4UDg3l5bUNTBwQU3GwGx6msBjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G06hW8FfUbp5DI8xzd5xPt5Uu/cMM1xC+yNnu8X/TdE=;
 b=j8sCN6WED5NS81KyChxU1bNawj5NRg++XwbsG+nIBA5MLydXPmTLXlxBt0W7sJLxf3sfUBYgM/i3M1T2VO9dk0pST3BAnr673pLNBn8ts2IJUc1PlZ1zqaXmXDxGRdQfi6xx1kD2VSv/uFgco+hDv5aXFeeYVogEB4c9B9Ioimk=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4208.namprd12.prod.outlook.com (2603:10b6:208:1d0::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15; Mon, 7 Sep
 2020 11:10:22 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::f8f7:7403:1c92:3a60]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::f8f7:7403:1c92:3a60%6]) with mapi id 15.20.3348.019; Mon, 7 Sep 2020
 11:10:22 +0000
Subject: Re: [PATCH 0/2] iommu/amd: Fix IOMMUv2 devices when SME is active
To:     Joerg Roedel <joro@8bytes.org>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>
Cc:     "jroedel@suse.de" <jroedel@suse.de>,
        "Kuehling, Felix" <Felix.Kuehling@amd.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "Huang, Ray" <Ray.Huang@amd.com>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <MN2PR12MB4488D6B7BBF98845DF796E0BF7540@MN2PR12MB4488.namprd12.prod.outlook.com>
 <34db343f-cd23-09af-3bc5-29b9d385f85d@amd.com>
 <MN2PR12MB4488BF7DDE700378F7B2776CF7540@MN2PR12MB4488.namprd12.prod.outlook.com>
 <20200828134639.GW3354@suse.de>
 <60067932-dbf4-d67b-cf11-4dd2b016ed63@amd.com>
 <MN2PR12MB448849D3AD019749DB64A146F7520@MN2PR12MB4488.namprd12.prod.outlook.com>
 <20200828152943.GY3354@suse.de>
 <MN2PR12MB4488BE2F12F85BDBC91E2C0CF7520@MN2PR12MB4488.namprd12.prod.outlook.com>
 <20200904100556.GU6714@8bytes.org>
 <MN2PR12MB448843EC6D3D5B71613BEAAFF72B0@MN2PR12MB4488.namprd12.prod.outlook.com>
 <20200907104431.GH16609@8bytes.org>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <63c70551-255f-2df9-af70-7965e80172af@amd.com>
Date:   Mon, 7 Sep 2020 13:10:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200907104431.GH16609@8bytes.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: AM0PR02CA0024.eurprd02.prod.outlook.com
 (2603:10a6:208:3e::37) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7] (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by AM0PR02CA0024.eurprd02.prod.outlook.com (2603:10a6:208:3e::37) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.16 via Frontend Transport; Mon, 7 Sep 2020 11:10:20 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9814f62f-f875-477c-4120-08d8531e9cfb
X-MS-TrafficTypeDiagnostic: MN2PR12MB4208:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4208F5CE6E901C7A860FF6F983280@MN2PR12MB4208.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:127;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: opPKFq9EbNwXNkXfLtGupiSrbVo4BLx6kD2wACBTtJxMXw7rPfHLqCfIVZ1216+y+b0b+JJDjMwPS85xR/XgrMUc1Q5lHBFqI2pu+1zs+n4+NFh8/I4y297pFWPWjL14c++wSzbGWSBYQ0lSZ8ZpcCsxQ6tK/lEqVDn8UrLiefmFYRrMBCefLmti0SaeZznzBt4Iv5x9GzGVBSkQMzdZBFosFT4Dg37wkn8lDaS8Bp+oGXojXce8FKL1tbfpzv+BOwQPCZ/0/15lJRgdT/XHH6QgibK7L4v00/tUBHa2ATpPbmjn9Z3MC8oea/fbqEgdnbXCTOpT1Qkk+Fx5hdnk+uWqdLMCmwiG6fONahLOmDWLMwgKFJa4nKLhlygISEIX
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3775.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(346002)(39860400002)(366004)(396003)(8676002)(31696002)(2616005)(8936002)(316002)(52116002)(4326008)(2906002)(6666004)(86362001)(6636002)(54906003)(110136005)(478600001)(66946007)(66476007)(66556008)(6486002)(16526019)(53546011)(5660300002)(66574015)(186003)(31686004)(36756003)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: /Yje+yEWniw+YhiIsy2pV78fxTFvAxzm0mwasd9acTpGzsDuKjRLEaNypPAjmZ856md5LFXc8FTH2jazwZfOpjCtsiG4JqAkG19x2TcpklNjHmCETJOUY+ai5AnsqOhBHB+FPyFAYM6jRdZUK0SB9JFKvP+udIRpR5lvUr4yAzhf9BytHotcT1FS3KUhLfVbtGV3aeMGAEGkVe98e5W7ZHzYX6DSkCBjYE5VKWWLqTQdNWIFgVJCbFMt9R3zl9cPqAjaGg8B1f9Cwi7DWEZIfPa4cIpnjhh6qB9NrDb0Aje+IQt6D0v1mw/ktEDqJqZiZ/zG2vwlj3kmykkbf1MFjrVfGXIkAgyf7gfi+8HgBX6tOc/wfKhEjh8UoAC2Lk256yYzxoPFPBH6w9Q0uvwbpas3u5XVM9QqEbPtoqjLRBwXv+vKMRE3Eu7wPBcVsHpwCimJIjwSb/iY7ABUg+6pPfxOgv74UlLFMHvgf9ux/6d+OSfhIxXMd0Afk1c3nV2Usg9wyWK31Bq+sRawk4R5tq9ckmVVmqVYAvkJN8FQGXAr/R1AqcYxpyI1w8g/wOBA1KjXcUEgjR5gGu9VHV3p4KR9TtAkYjMTMECn1QDfjfBof0MEQEb/eutKisAJfJpw2oNIGLghqJoGa3Foiu1vP7Aq5mdyocVlhFPZ8mi+Aeiu9oxR4bNtV+YRuQ0KOVWXWwS9C+N30MNlSqf2qoYRkg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9814f62f-f875-477c-4120-08d8531e9cfb
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2020 11:10:22.3959
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1jETjDDFtVjDjv2EcRoemDVU8HyeDGctz3+V1RztqtT6u+8rGU5H1IXD15R3EFTb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4208
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 07.09.20 um 12:44 schrieb Joerg Roedel:
> On Sun, Sep 06, 2020 at 04:08:58PM +0000, Deucher, Alexander wrote:
>>  From f479b9da353c2547c26ebac8930a5dcd9a134eb7 Mon Sep 17 00:00:00 2001
>> From: Alex Deucher <alexander.deucher@amd.com>
>> Date: Sun, 6 Sep 2020 12:05:12 -0400
>> Subject: [PATCH] drm/amdgpu: Fail to load on RAVEN if SME is active
>>
>> Due to hardware bugs, scatter/gather display on raven requires
>> a 1:1 IOMMU mapping, however, SME (System Memory Encryption)
>> requires an indirect IOMMU mapping because the encryption bit
>> is beyond the DMA mask of the chip.  As such, the two are
>> incompatible.
>>
>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 10 ++++++++++
>>   1 file changed, 10 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> index 12e16445df7c..d87d37c25329 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> @@ -1102,6 +1102,16 @@ static int amdgpu_pci_probe(struct pci_dev *pdev,
>>   		return -ENODEV;
>>   	}
>>   
>> +	/* Due to hardware bugs, S/G Display on raven requires a 1:1 IOMMU mapping,
>> +	 * however, SME requires an indirect IOMMU mapping because the encryption
>> +	 * bit is beyond the DMA mask of the chip.
>> +	 */
>> +	if (mem_encrypt_active() && ((flags & AMD_ASIC_MASK) == CHIP_RAVEN)) {
>> +		dev_info(&pdev->dev,
>> +			 "SME is not compatible with RAVEN\n");
>> +		return -ENOTSUPP;
>> +	}
>> +
>>   #ifdef CONFIG_DRM_AMDGPU_SI
>>   	if (!amdgpu_si_support) {
>>   		switch (flags & AMD_ASIC_MASK) {
>> -- 
>> 2.25.4
>>
> Looks good to me, thanks.
>
> Acked-by: Joerg Roedel <jroedel@suse.de>

This is really unfortunate, but I don't see any other solution either.

Reviewed-by: Christian König <christian.koenig@amd.com>
