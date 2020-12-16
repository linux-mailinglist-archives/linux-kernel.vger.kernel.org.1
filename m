Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40A082DC351
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 16:42:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbgLPPmA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 10:42:00 -0500
Received: from mail-dm6nam12on2053.outbound.protection.outlook.com ([40.107.243.53]:60353
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725812AbgLPPl7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 10:41:59 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LJfHHUZ7GdiFFa0c4HfeH2fFIypZYONSO4ZNAL5WM8fxRpP+pAv5pnrp4dJMXu1UNz1MxGyWPybDpieQbqroXESvbiNCJwGoEdyRcms2ulnKNs1LMZyLug3NuDlF+flQPkKwspCndUfOIs/8xGnaho2ja5waq9lre/ylg2YqS9G2TJLl3gP7lDJeiWgZbpSJjhnyA5vqVMcNHSag20gA1A2jNDh/VEPMQRt7LrMQpXP2RpFIkrYv8m5uznTmaJvc8wKE4MyGMH1f3D6vLkrCWWOImBMSHRuwzjRprdOeNxHE1M7znzKPTihCZ4PXJvjJNW0CstK+XLmzt/GJ6Q2k6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ExEk96TVdnEUqocOQr4dSugmbGRcB/wl9j5GXomRnnM=;
 b=QgunISjJDOBY+l2YLH0NHVaT6JEWYZxJJaEKV+amj3DUbGPR5xUDqJDqHpCDGj7ZvhjIfQYqtPdqVvOCqRTSwfWytfsyd1GM2lFISNLcqY3VqKOnxbdZrP2b4JogW81GrKCMRrvBrXeSUu/FI0eD3AA/TgJl7sNr+eNA4Xxm/qjHqLtd+uhP48nHwc/z0IoJjwr61wogxaLqCV9MRzq/Eegb2xjjOrJLcjg6t4aiZCpD9ILKS0osnGx7kgsjc1eatQ+CKOSEWUsrbRso/zEJJrrI/IVKFDT9mrgP4CVHbjNx2kKOVf02n6hUUk0rr53L/O+zHy++FTxDM8B8Poq60w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ExEk96TVdnEUqocOQr4dSugmbGRcB/wl9j5GXomRnnM=;
 b=pu/cRu2Voc3ZlA8r5D1lwEI3U80n6rQiY96U+04IwG8C1bi0nILqDwM6zKAm24VpM9StcnK/EiqwwQ8GfNU+5745iinAUzk230K8/XBUkVhgLvIBRjBrhesn4eG1WqSh5YDT8ob47/bJlq7gcD2aecRaodoQp1f4gwyfnW8hmrw=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by BL0PR12MB4913.namprd12.prod.outlook.com (2603:10b6:208:1c7::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.25; Wed, 16 Dec
 2020 15:41:04 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::44f:9f01:ece7:f0e5]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::44f:9f01:ece7:f0e5%3]) with mapi id 15.20.3654.025; Wed, 16 Dec 2020
 15:41:04 +0000
Subject: Re: [PATCH] drm/ttm: fix unused function warning
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
To:     Martin Peres <martin.peres@mupuf.org>,
        Arnd Bergmann <arnd@kernel.org>, Huang Rui <ray.huang@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dave Airlie <airlied@redhat.com>,
        Madhav Chauhan <madhav.chauhan@amd.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Alex Deucher <alexander.deucher@amd.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20201204165158.3748141-1-arnd@kernel.org>
 <3a55c203-57dd-79f3-99ec-6bdeafaba157@mupuf.org>
 <1589a0e4-a337-a24a-720f-09587939e94a@amd.com>
Message-ID: <c9f9b966-6894-dd70-373d-04378e76ae36@amd.com>
Date:   Wed, 16 Dec 2020 16:40:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <1589a0e4-a337-a24a-720f-09587939e94a@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-ClientProxiedBy: AM0PR10CA0130.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:e6::47) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7] (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by AM0PR10CA0130.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:e6::47) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12 via Frontend Transport; Wed, 16 Dec 2020 15:41:02 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: cb3aa6cf-1e53-47af-cfcd-08d8a1d8ffad
X-MS-TrafficTypeDiagnostic: BL0PR12MB4913:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB4913704EEE569B31C94215FB83C50@BL0PR12MB4913.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mORYAkcm1l5k5S850M882IZCv466iujxbAvLsU1OVbB87/o+55eM5LcPqMJgCZO5z7XX7v5PhCAhor0SNbMeQ4sKY/ACP8Uz02OHN+UE9eYEPnwjTf4+Gwe8cdTKYgV8GRp6P4V+WLlODs4vvoLaoBo5s7l5517PkU8re5sid6xHsuvuBxZWs+VVaOhp51Wy23jUv0IHB992ltm/ZPHIEa7APuL7e/ahho5PBnztYLZSEq3KL4OwHPgmnbBQqUTiBy37qNLns2XYXjHxr6GGi/6xn1UKDnQUSvp2dMRfun11ewYu2ej3BTv4FgpuOB6RMn+xc/LjFmq5g8UZm993SS4wMfS3rwS4BTEUPMUxZN3cnixfrPC5hDwEnoIIcGkAMhugVOCYHOt0EsJhpg9Bsouc/UPXUHV5FVHWsXHxqJ8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3775.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(39860400002)(366004)(376002)(396003)(186003)(16526019)(316002)(54906003)(66556008)(2906002)(53546011)(83380400001)(66574015)(2616005)(5660300002)(6636002)(66476007)(6486002)(66946007)(8676002)(4326008)(8936002)(31686004)(478600001)(36756003)(110136005)(86362001)(52116002)(31696002)(6666004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?aEdpNGJVaXlpY014UUMwVkxXV0V2Y1U3eWpFWFBJQ1R4R3V2S0hGcFA0SUdD?=
 =?utf-8?B?UEJZRkVpZXp2WEZqYkVWRzBSWjlCOG1RSXRVb0NHd1hwTUlFdjg5bUpGSmhN?=
 =?utf-8?B?NWJ3MHZQS0xUamhqSjlQZDNPNnhtQ3pFYjdTY0tPbWtoVkcydUtFNnhQV2lm?=
 =?utf-8?B?UTFqUGlwOFlwWi9EWTFwQnB0MzBQMXdGMEU4TDNub1h4RnNUajF0M1o3b0ZN?=
 =?utf-8?B?b2M4VHZZVEJaUVlwQ3A2SFA4WkVJbWxya3VwOFVHa1BhVXIwRmZSU1JCbXk4?=
 =?utf-8?B?cEtMa0p1QzltSUhYeVB4dWFWaGZwK21vblF3bEcycnQwOG1yUHRwc3I2TFAv?=
 =?utf-8?B?SVJ6OWtWVTZTY1Y3RGVuaHpIb2J4QkY5NzlpblZXcXlmd011RVVGM2xVVUZM?=
 =?utf-8?B?N1ZjVXJnZzZ2ZVlMTW9aS1VDZjlLQTFzRkJ4ZS9LYWFEUFc0M1NWeXlDZ0lU?=
 =?utf-8?B?SkJudE1XSHhmVVJJS3o3TzV5TkN1ckFTcjI0Smd0aloyM2tUSEJvSjhoU0R5?=
 =?utf-8?B?eGpwcE1LaGRQMlVnd2ZINEVOZXpGRmdoejB3NnRxaERUK04xSzZDcGpCSGRN?=
 =?utf-8?B?ak9rbDNvaWd5UmNDMFU3NGdXSWtmUXNXMGJKMk9KUlBTNXI2Nk1OMkFkaHdr?=
 =?utf-8?B?M0ZMQlB5cGVBZUJrR1FqUjVEOGkySmNwQWl4ejBHQlAxWmQ1WFhFS1IyM0RE?=
 =?utf-8?B?V1o5YUVDRXRyWE03bEkvNjdkQ05jM3ppc25wTVhMdkxyb0wvYmg2SGZiUmhK?=
 =?utf-8?B?SjRSODBIMHhUYlRSazZ6aDJDbFVTY0E4ckVQYXBuTk5uNitRejZCMm5ubjRh?=
 =?utf-8?B?VVY1NFJ4elM1Z21SWGFSLzR6dlJ1YXRxYmhhSElyTkphNEFwVHlYaHZmOVd3?=
 =?utf-8?B?Y3QrQ3VXQ2xqUzFEd2FBZHJCREFXTVRRbFRuS1lmQ2ZHS2VXQVZoTUZiRlNk?=
 =?utf-8?B?bktYcU1IVldUbzVydFY2Q05UdlB3a0wwTk5kMjBpK1V6SERmZnU1SVFXWEhP?=
 =?utf-8?B?T24rNU9zdkRjKy9CbVJjQlF0OWluM0RYeDgybkhCZXVMT1ZVaU1odGtjaUJ0?=
 =?utf-8?B?N24xYWwyOGVXdFpjL29XbWNRY1ZWZ0JmM1AvTmorNkdNejhjTXQvOU5pR3F2?=
 =?utf-8?B?WXVpbWUyT2JRM2RvZ2hCSFZBbzNOdnBKb0ExZzJiYVd0ZkFXMjZSTTZ6ODlG?=
 =?utf-8?B?NkhqTEdqbjE0ZDZiL0gwaUgwYjlmTkJzWEtRSDFya3VCQzBHSXBqZkc2WVkv?=
 =?utf-8?B?eTRBSjJtTFpiTStKTUplekl1bGtiYXFPYWJQcnpVWklRUGJOUFN3TVd5Z3hr?=
 =?utf-8?B?dUpqYXlwajJ4b3Nxb0tNRGdrYWVaWUVBMWYyZDl5L3FKZGFTcHdyZUh1ZGM4?=
 =?utf-8?B?QURJSFpwT1BFT3VUNUU3NWg3eWtSbks1M2hmK0xPRmZPTUdZaTBqQ0ZhZExF?=
 =?utf-8?Q?cYtbAjOU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2020 15:41:04.6474
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: cb3aa6cf-1e53-47af-cfcd-08d8a1d8ffad
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Lu+SZFT8mXzPEOiQknk6uqeicPDSruJICzTabdOwByFQMKtGDDfk8QDMAoeb1KWc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4913
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 08.12.20 um 10:43 schrieb Christian König:
> Am 08.12.20 um 09:18 schrieb Martin Peres:
>> On 04/12/2020 18:51, Arnd Bergmann wrote:
>>> From: Arnd Bergmann <arnd@arndb.de>
>>>
>>> ttm_pool_type_count() is not used when debugfs is disabled:
>>>
>>> drivers/gpu/drm/ttm/ttm_pool.c:243:21: error: unused function 
>>> 'ttm_pool_type_count' [-Werror,-Wunused-function]
>>> static unsigned int ttm_pool_type_count(struct ttm_pool_type *pt)
>>>
>>> Move the definition into the #ifdef block.
>>>
>>> Fixes: d099fc8f540a ("drm/ttm: new TT backend allocation pool v3")
>>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>>
>> Thanks Arnd! The patch looks good to me:
>>
>> Reviewed-by: Martin Peres <martin.peres@mupuf.org>
>
> Reviewed-by: Christian König <christian.koenig@amd.com>

I've just pushed that to drm-misc-next-fixes.

Christian.

>
>>
>>> ---
>>>   drivers/gpu/drm/ttm/ttm_pool.c | 29 ++++++++++++++---------------
>>>   1 file changed, 14 insertions(+), 15 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/ttm/ttm_pool.c 
>>> b/drivers/gpu/drm/ttm/ttm_pool.c
>>> index 5455b2044759..7b2f60616750 100644
>>> --- a/drivers/gpu/drm/ttm/ttm_pool.c
>>> +++ b/drivers/gpu/drm/ttm/ttm_pool.c
>>> @@ -239,21 +239,6 @@ static struct page *ttm_pool_type_take(struct 
>>> ttm_pool_type *pt)
>>>       return p;
>>>   }
>>>   -/* Count the number of pages available in a pool_type */
>>> -static unsigned int ttm_pool_type_count(struct ttm_pool_type *pt)
>>> -{
>>> -    unsigned int count = 0;
>>> -    struct page *p;
>>> -
>>> -    spin_lock(&pt->lock);
>>> -    /* Only used for debugfs, the overhead doesn't matter */
>>> -    list_for_each_entry(p, &pt->pages, lru)
>>> -        ++count;
>>> -    spin_unlock(&pt->lock);
>>> -
>>> -    return count;
>>> -}
>>> -
>>>   /* Initialize and add a pool type to the global shrinker list */
>>>   static void ttm_pool_type_init(struct ttm_pool_type *pt, struct 
>>> ttm_pool *pool,
>>>                      enum ttm_caching caching, unsigned int order)
>>> @@ -543,6 +528,20 @@ void ttm_pool_fini(struct ttm_pool *pool)
>>>   EXPORT_SYMBOL(ttm_pool_fini);
>>>     #ifdef CONFIG_DEBUG_FS
>>> +/* Count the number of pages available in a pool_type */
>>> +static unsigned int ttm_pool_type_count(struct ttm_pool_type *pt)
>>> +{
>>> +    unsigned int count = 0;
>>> +    struct page *p;
>>> +
>>> +    spin_lock(&pt->lock);
>>> +    /* Only used for debugfs, the overhead doesn't matter */
>>> +    list_for_each_entry(p, &pt->pages, lru)
>>> +        ++count;
>>> +    spin_unlock(&pt->lock);
>>> +
>>> +    return count;
>>> +}
>>>     /* Dump information about the different pool types */
>>>   static void ttm_pool_debugfs_orders(struct ttm_pool_type *pt,
>>>
>

