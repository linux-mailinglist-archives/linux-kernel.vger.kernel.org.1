Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0C702D0945
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 04:10:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728673AbgLGDH1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Dec 2020 22:07:27 -0500
Received: from mail-bn8nam11on2061.outbound.protection.outlook.com ([40.107.236.61]:30656
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728520AbgLGDH0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Dec 2020 22:07:26 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dH+gxyR04BWDdC03G4yYD680P/X+TmYpIXSqI8dxCu9LxTmuLGbqD6ktrfDa6e97TerBdF2UWlbzIvoj1yL7sr641yr6Rh3HIaB5jCaR57Mp3cgkgvAL8i6nTTDSbg9GLUgBGOADqRLZmSFGs1SlqLfvztPKdAsgxexyHYbAw5wJRobchxkYbd6JpK1g2G7AMbaCTEwqH2Jgr0assYLYSpwe18jhiXzMtEdxFpu3XmEBuPlIrpuM/JcyhZP3vymnD3Pu9VqJ1O67E5pvnvG6vIMUAYQD0g4Y+athB4ZogqZQOl++16TMxPKnbrCqUkn4PAxv9KdQSn23VzfdapChig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7STTtvfsAMrbJTeT6y3DnnQuK3tlSmQIMOF9MvmAgOE=;
 b=NE4lY9RcI9ITlp9UYgqSqFC44SdsxV/8bE3l0pJ3KIXZ45HKcJZUDugai+8plvRA3hd7eZJxF42+6Xvy9Ppu5p5fmpMUfvtpC+S5Tp5CIKV5m5dayvNNkTApRJZuWnd0hvQqNxqww51ocoUGpPkPx1gIjI2uCUd0Eddyp85WGRnC1WsINP3a6HA4wS87HC/F4o9YfTpzZEc6bd/9OvAagQTnWICtEaQJ8Segqml7LGyUOdd/3MhvxbxjHFKK45JftEPqrdJhuuSv+lZFUOsHyZNQwy+1pigbr6/0XXQjmVS6bdTZbqFnOBfaFstZnGhZ1day96FtC9mSduAQRQB0og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7STTtvfsAMrbJTeT6y3DnnQuK3tlSmQIMOF9MvmAgOE=;
 b=fcfER/sqIoFASP0lPEtoC+TRx7e0JUhxfN3Q8jhFbpvodq7Sd0PAX6AVUX1NpFJEeXhkS/blOnPJGb5Kr1w11PPCaY+S4KjdnMlrcssz/znADPJeYYDHHxSE6Igsv0Dy7OkEYpZKoE+3fATfGpP6txluZHkMSL59wWMyo+HLg8A=
Authentication-Results: lists.linux-foundation.org; dkim=none (message not
 signed) header.d=none;lists.linux-foundation.org; dmarc=none action=none
 header.from=amd.com;
Received: from BYAPR12MB4597.namprd12.prod.outlook.com (2603:10b6:a03:10b::14)
 by BYAPR12MB3144.namprd12.prod.outlook.com (2603:10b6:a03:d6::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.18; Mon, 7 Dec
 2020 03:06:32 +0000
Received: from BYAPR12MB4597.namprd12.prod.outlook.com
 ([fe80::dd10:efd2:e325:53c7]) by BYAPR12MB4597.namprd12.prod.outlook.com
 ([fe80::dd10:efd2:e325:53c7%3]) with mapi id 15.20.3632.023; Mon, 7 Dec 2020
 03:06:32 +0000
Subject: Re: [PATCH] iommu/amd: Increase interrupt remapping table limit to
 512 entries
To:     Jerry Snitselaar <jsnitsel@redhat.com>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
References: <20201015025002.87997-1-suravee.suthikulpanit@amd.com>
 <87sg8pkrre.fsf@redhat.com>
From:   Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Message-ID: <c4c46a93-fa10-5e47-e9d0-dd16e721acbb@amd.com>
Date:   Mon, 7 Dec 2020 10:06:22 +0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.5.0
In-Reply-To: <87sg8pkrre.fsf@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.80.7]
X-ClientProxiedBy: KL1PR02CA0026.apcprd02.prod.outlook.com
 (2603:1096:820:d::13) To BYAPR12MB4597.namprd12.prod.outlook.com
 (2603:10b6:a03:10b::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Suravees-MacBook-Pro.local (165.204.80.7) by KL1PR02CA0026.apcprd02.prod.outlook.com (2603:1096:820:d::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.20 via Frontend Transport; Mon, 7 Dec 2020 03:06:31 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1bcf7546-0f41-4651-2003-08d89a5d19e2
X-MS-TrafficTypeDiagnostic: BYAPR12MB3144:
X-Microsoft-Antispam-PRVS: <BYAPR12MB3144333103F7011AB6342A70F3CE0@BYAPR12MB3144.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: biggWecuo1FDO/p0W+mI8gnEwIz5TLDpNvx1GiZbkbEnQ2/M+B1ANpjXgU8MSwQz1uhLaFdioZBUvFIZVe4p0nUOMLfeEF979w/jbIm1NFXTcsLqQW9TOZaPFxY4xzP10X8v0ppauX3fBtb+5toQsmOcQJDbvXDyd1SUgWS+J6nDkRg1Nw0YD4grqH2Uvx5kso3DWIiGzibvLVowjxbL+a7/OTqik3KL3U9yxcniyQscNXQTf8etSNEqx3V7Xh3/tC2DR6trB1zeIaa9raqxAQulqm+92KSgPIeVOYytONurGarg5QK8KqH7kja5U6dXoO0IXGSaYdSpW3bLynvuLE4uQfSaRtQhJ9X+Smsc2YPNX0oAA15U/rbrr11fnFlces+7cbsPzaMuANeTBoEOAk5Z7NJMquHxpyU1RU8R4Nc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4597.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(39860400002)(346002)(366004)(376002)(6512007)(2906002)(83380400001)(2616005)(44832011)(66476007)(5660300002)(956004)(6486002)(66556008)(16526019)(186003)(31686004)(6506007)(31696002)(86362001)(66946007)(52116002)(316002)(53546011)(478600001)(26005)(8936002)(36756003)(6916009)(4326008)(6666004)(8676002)(4001150100001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?QktJOHlJa1owLy9SYk1pRitaUnNOTC96UHE1b1VYVXBGL2QvNjdQM2lUdG9J?=
 =?utf-8?B?OHI1UmRUMTcrS1NEc0d0TnNXRUsxK0craUg4ZkRJY2hFZlFFUzdrZDlvTzZY?=
 =?utf-8?B?YkQxbHhiQXJLbUhjUng2aVBGbXZlMEMzTkRnaElwL1I2ZFViY2Y1WmJWU1U0?=
 =?utf-8?B?aDRGMGxodGFjbURkMmlCMll4UEhxU1B0dzZDVjEveG9ybHBBQzYyNTlVaU4x?=
 =?utf-8?B?Nmx3Z1prS3B2M2hSa3JFc3RlY2pUa2tESlFtT29sVXp2YkJvL0VBc2g4MVlw?=
 =?utf-8?B?aUJjUkRCelFaYmJyM0gzWDA0eFVmRXhqM1EydmFRNDFvY2xieDdWcVZjNDI3?=
 =?utf-8?B?d014djVnZmtaQlUySEZlOEM3Z2d4cHBBa1RUSW15UytncjNZcFRLenZOZXp5?=
 =?utf-8?B?aVNPb1RRcDJ3engzOU8wTkRZRzNOZXhkRVovdkdUZHRtd0luYTdJZ04yYll1?=
 =?utf-8?B?MWpDWFdPWjROYVNMWlcwQXhLdFJpMWFJZUljOHJMYkJKV2xsY1JKMU91U1JL?=
 =?utf-8?B?VUo5WXdpK0RQKzV2dm5hdDRjSXMzdjlTZnA4NXBFSy9WNCtoa1Y3TE9zY0N2?=
 =?utf-8?B?QzZxbTZEa1NaUmtqek1CbXAzemdoVEhIcWJLUnFDL1c5bnRrcDkyMDBUVk0z?=
 =?utf-8?B?WlMvakhpUkJSd2gxTW5Bc1hSQmFORUxwbzhLSDFVcTdPR0pGQmY1eDU1OERI?=
 =?utf-8?B?Q2RkSEcyVzN6ZmlMT3hYWEFEMnBHenFHNVNJZXpiMFhPZU5TQVRWdDh6L0FM?=
 =?utf-8?B?Yk9tb001REpCWlA1dmtOdTRJMFQxMWwxNWlvamJhOHI3NkdDaERRVFB6UWd0?=
 =?utf-8?B?YlUzemF6WTRla3lkeVJzUXRKUGN6N3lWaE9wTVExUWFTN3pvbTVzdE9VSzdQ?=
 =?utf-8?B?R3NNQUtuQ1hlTUVqN21YeGRMUEFYZjA3aTJ1dEpIVDQyQURkOWNSc2IrYWNh?=
 =?utf-8?B?Uk9vQ0NQUGNyMFpSdXNWbDNDcEtuNnNGdkZuTTVrOUNYSkZjN2ord0NqS2pK?=
 =?utf-8?B?QURDZVdHUGp3cXYrcGl0TEoyM1Z4WTJwS1pRL05HTEFodXgrbHdnVzZJdTla?=
 =?utf-8?B?Zm9aVndSOG8ydWVrTHB2OGp4ajB5WlNNc012Y0YrQk01OFl0aGl3cjY5Q1lm?=
 =?utf-8?B?cGRFR1FXL1RqY2xzRGRzeEhIcmF6eFptclgwaXE3R3AvMlBuWE9uOEVPNi9W?=
 =?utf-8?B?MDhWZDAvUFM4dXZEUUxoWVhQVXFSNy9sQ1BLKzBsUmVHUWVZNCtjQnl3djJY?=
 =?utf-8?B?S3RBZWRseDdIa3piYmZoTm05eWoxaXV0Y0IxWWtJajFVWUVxdnR1QjRMcjc3?=
 =?utf-8?Q?r8FOX2gHsNWgVsR+MCldlvnt2Fth+kg59s?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4597.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2020 03:06:32.8291
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bcf7546-0f41-4651-2003-08d89a5d19e2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZZk9+ByYwKyKAboHWEgQTAd8k9io6dfzKHBqcJP2KichCkStAUt8JrI+O+bMwl1LhDR7Zx1cEaPhzBE+iNItuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3144
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jerry,

On 12/2/20 6:53 AM, Jerry Snitselaar wrote:
> 
> Suravee Suthikulpanit @ 2020-10-14 19:50 MST:
> 
>> Certain device drivers allocate IO queues on a per-cpu basis.
>> On AMD EPYC platform, which can support up-to 256 cpu threads,
>> this can exceed the current MAX_IRQ_PER_TABLE limit of 256,
>> and result in the error message:
>>
>>      AMD-Vi: Failed to allocate IRTE
>>
>> This has been observed with certain NVME devices.
>>
>> AMD IOMMU hardware can actually support upto 512 interrupt
>> remapping table entries. Therefore, update the driver to
>> match the hardware limit.
>>
>> Please note that this also increases the size of interrupt remapping
>> table to 8KB per device when using the 128-bit IRTE format.
>>
>> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
>> ---
>>   drivers/iommu/amd/amd_iommu_types.h | 6 +++++-
>>   1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
>> index 30a5d412255a..427484c45589 100644
>> --- a/drivers/iommu/amd/amd_iommu_types.h
>> +++ b/drivers/iommu/amd/amd_iommu_types.h
>> @@ -406,7 +406,11 @@ extern bool amd_iommu_np_cache;
>>   /* Only true if all IOMMUs support device IOTLBs */
>>   extern bool amd_iommu_iotlb_sup;
>>   
>> -#define MAX_IRQS_PER_TABLE	256
>> +/*
>> + * AMD IOMMU hardware only support 512 IRTEs despite
>> + * the architectural limitation of 2048 entries.
>> + */
>> +#define MAX_IRQS_PER_TABLE	512
>>   #define IRQ_TABLE_ALIGNMENT	128
>>   
>>   struct irq_remap_table {
> 
> With this change should DTE_IRQ_TABLE_LEN be changed to 9? IIUC the spec
> correctly leaving it at 8 is saying the table is 256 entries long.

You are correct. Sorry I missed this part. I'll send the fix-up patch ASAP.

Thank you,
Suravee
