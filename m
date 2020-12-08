Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E0712D2806
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 10:45:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728813AbgLHJoi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 04:44:38 -0500
Received: from mail-bn8nam08on2073.outbound.protection.outlook.com ([40.107.100.73]:25057
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727844AbgLHJoh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 04:44:37 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dDn8EMm8PPp+Zxr1ZQ1CDbh6Y8XxypO0NTtGSilDF839EtPLRX2H2YBjZ00ZLPrsbp8e4J6yPuQm1hLKxY7ZK9L31pTMTEZtdyVBTAdQ+ly9yQUTNVr/YNEHry+E0w9YI3xsQpCnoxdIs5Bsm2sEL9gTnCmHhqhVS8+/5eFK5nv5B2tOojapMxZY3RTGXp655ihHIF2qPcj60Igpi4k+TQmHxIKQYYY95Q5YnJGhFRZk16JeH9fQt4kPmbEGXo6M7aTake4k1zcsWbrDc5GERobm0tVk2MYUPrbtBuvMztyR2SHtIAkOqtg38NMphduPSWrYZ5JBm267Cvyij/F3Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U5rxCTQGkWm0hOkein5NVmtTBjBRFXF+bQ1yMLeUH2c=;
 b=eH06knzcmqTS1EV5XStOUCgZgRzFhMwdLj9/5ypbI5b09l8BtyxfYGob5KypFE5cCFMC3MljD+qvdCNaNJ6gzV2t+EIS4uRdSEyUwGEozgBL+s9KOJscC7j8p88q/N2zunYfLTuDB6jAjiNu42MrOInbJpAS2HjbZJdUhoF2iDPRksGXBOKHEWTeOwhg+Q2RNfJCtXto2UPw3PGu6SKQ+eAMTfeccQgbVIJ0/DfeFj9i9APUDstSJGGacDLdvUbj6q1KbhgfllrpRb5QGz6Xty+tF+a+BY4jxcxknr34ZokEsHd7wImzi/dZ3X0HWB44c6TK1BhhqS1ubeuFfTpXKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U5rxCTQGkWm0hOkein5NVmtTBjBRFXF+bQ1yMLeUH2c=;
 b=cjjKrWcSGh6Q2SvMUL3Sed48snYYFhussABEgaa54WZZdEc/XjqUbbj1FfnMfdqPc76VyBnPxnSXSiLef6L3fuRppnP8PfZM2FbGwAKqLCuM7Yy2+f9F0JZ2DpY1yavlvY55zK2tdKt4yKW/P+lT+7uIz1NCfIipDyf9ObpkqHI=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4048.namprd12.prod.outlook.com (2603:10b6:208:1d5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17; Tue, 8 Dec
 2020 09:43:44 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::44f:9f01:ece7:f0e5]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::44f:9f01:ece7:f0e5%3]) with mapi id 15.20.3654.012; Tue, 8 Dec 2020
 09:43:44 +0000
Subject: Re: [PATCH] drm/ttm: fix unused function warning
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
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <1589a0e4-a337-a24a-720f-09587939e94a@amd.com>
Date:   Tue, 8 Dec 2020 10:43:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <3a55c203-57dd-79f3-99ec-6bdeafaba157@mupuf.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-ClientProxiedBy: AM8P192CA0004.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:21b::9) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7] (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by AM8P192CA0004.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:21b::9) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17 via Frontend Transport; Tue, 8 Dec 2020 09:43:42 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: df35aea0-6404-43bc-657f-08d89b5dc122
X-MS-TrafficTypeDiagnostic: MN2PR12MB4048:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB40487FD398CC85BA9AD1D29083CD0@MN2PR12MB4048.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aNIrLqlszG2DmRTP+Qmp+4Tx+7CcG6Yj2E8MGJo70YGnWWCpGc0JisvX4DEcVBATsvx350pVwbQZSfHMePQg2iLe1jOrm5su+ygO+jvUN007cIZd/IA2h0p9d91r4ahiv7DiuQfkdsWoIZWOue4MO2cZiBMVYQj3HzUvBfqql7MnbGjFDLB7ZXlVqIupEkNWCTS6yt+h+fyYph4DeIUNQ2zsIYRFybdX/Eq2yQiB5MGptoAgbuqMq6dp/4hHPmMp+fzrOr2jm2SBMd9AHHZRc890q5tECr0MPQiqSfLtcDjbiAa+WMWU/fRVHj6vXulyZpAmDtmDB/82qPwsHb8v3uBnWB7Ss4anouJ8xl8IZaUiF3s8WtGZ9vSTuNkHwk5GRn+kMg8z37G5Qf5wT9O0/01/T2mrXnV3oiZbHzSEet0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3775.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(346002)(396003)(376002)(366004)(86362001)(478600001)(2616005)(66476007)(66946007)(53546011)(8676002)(16526019)(52116002)(6636002)(66556008)(83380400001)(6666004)(31696002)(6486002)(316002)(8936002)(36756003)(186003)(4326008)(54906003)(110136005)(31686004)(66574015)(2906002)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?aFFZOGpYaTQ0TkZwMDA1cmFDVG5jQ285cThmREpRejRIUi9iN2puQWVMUzFk?=
 =?utf-8?B?M3NMNGxEdmdrZ1J5OW1rVTYwdDArTjdNNi8vS0FHZHM3a3d4WkcrU0Qvc2hB?=
 =?utf-8?B?bEpoM05CSlY2ZjREV1VXMGZkZzN3Vm1NaWlNR00yVGl2TDh3OFRtRFZnbE84?=
 =?utf-8?B?SW9yVlVUTjRSbUc3M1lTNW1xZS9kbjNvK1FoMTl4L1RrcDFaQWNGUWZaNk5z?=
 =?utf-8?B?eG11enV5NFEyeHBSTFh0ZnlaYXFUUTlyYU5qSFJ5dWxyOG1CazRiLzBpeW0x?=
 =?utf-8?B?Uzk0MDI5R1VnS0htcDlIY2ovWDA2cUlONWw3ai9jMmVGMkp2VGhrVEcvS3p0?=
 =?utf-8?B?aGZmemxaQ2lVYUl1S1QzZEY1RmNhWFlKSlB4VEU3MkZnTWJsNEUzb0dxeXMw?=
 =?utf-8?B?bDZTSnNkVVZrTDlrVi9MWk5YWmc1NGRZMU1TcktSWFdkbzEzU2IvTzRrVHFh?=
 =?utf-8?B?MEhXQW9nd1ovQWdadjAzK1BOQTBoL1hjQ3piQVF5NDhvNzRUTzIzM2ZJU05h?=
 =?utf-8?B?Z0FCYldUc3hFc1JhR1FWaVVpcFN6RVh1Ynpla2NtakRQR1h5NnIxQktXSTYv?=
 =?utf-8?B?R3V5ckZjeXpndXRLSUFzS3BaejVSaG5JUkNLamVoMmp3Z2pmWEJUVmxMM0Er?=
 =?utf-8?B?Y21wZUJrNkJCMlRzUFNSSmVHVmdmcTdTU1Jqazd3MmMwUnlrTkdKRTRlY1VE?=
 =?utf-8?B?YlJrZUllWHZjR25NVG43MHg1L01TY0tQcm1ONU8xbEd0YS9nZGZHV05acTdn?=
 =?utf-8?B?ZWtLSG05TC9SNkhTZk1lcFZXbnB2Z3hiRTlMbUU0L21GR0tHaVUwQ0dYK3kx?=
 =?utf-8?B?MzVTdklWSndXUFhPUEgwVDhYWFk4WHQrZlB5ZnpuNENkTWZxdzJjdDQ1SWRF?=
 =?utf-8?B?QzROYklGRFZpSEI2ZHdZb0FabkxUWVpYZW1LcFdpZ0tyYm56TUd2VHFGRG5m?=
 =?utf-8?B?bWtjdkk5NkdHdWpEdi8ySC9aMkcwdU10WDFDNnFCbGU3ajVqL0I5MTJsNGdq?=
 =?utf-8?B?RGVnYjVveHVSRVc0bmliYjh5RVk3dUJPeVQ5dGNoKy80UGFCNnNHMUhQN0VK?=
 =?utf-8?B?K2FMVTBNUG9QN3pCaG9FRHFBZ1lUcWZNWFJxTXZKcUlUb1IwTmhEUm51VW0w?=
 =?utf-8?B?aExoSnAzVlJtdFZ5MFlHQUlLb3RhaHBsVGd3dDlNRTNlWjU1dHBmbFRRQ1Ju?=
 =?utf-8?B?U0pGNHo3WlVxdUdyaFhCT0hobElwS0tCU2VUdGRYallCK3MvbGlkcnd5VHlt?=
 =?utf-8?B?amEvT2daM2tCbEFwdDQrV0lXb01abDg1OG1LazVJZUJmb0tzaGFFS3pvTDdh?=
 =?utf-8?B?dTk5MTNEdi8zTHMvOFpBUVVyMXFVZnpyS1BoWURnY0hNVkVHUmd5LzBicWhS?=
 =?utf-8?B?cndCbGZwNkpGbjJUUDFIQUNDKzc3K1lST0xZZ1ZhakxJbGRVbUg3ZXdFdXJ6?=
 =?utf-8?Q?EtZXDD0J?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2020 09:43:44.6016
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: df35aea0-6404-43bc-657f-08d89b5dc122
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 54mftc8zvKl6j0m2ucjkxDznz1Aoo4IiaKUJltg0At9a+VpO2MEezmW8EHEA5KdP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4048
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 08.12.20 um 09:18 schrieb Martin Peres:
> On 04/12/2020 18:51, Arnd Bergmann wrote:
>> From: Arnd Bergmann <arnd@arndb.de>
>>
>> ttm_pool_type_count() is not used when debugfs is disabled:
>>
>> drivers/gpu/drm/ttm/ttm_pool.c:243:21: error: unused function 
>> 'ttm_pool_type_count' [-Werror,-Wunused-function]
>> static unsigned int ttm_pool_type_count(struct ttm_pool_type *pt)
>>
>> Move the definition into the #ifdef block.
>>
>> Fixes: d099fc8f540a ("drm/ttm: new TT backend allocation pool v3")
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> Thanks Arnd! The patch looks good to me:
>
> Reviewed-by: Martin Peres <martin.peres@mupuf.org>

Reviewed-by: Christian König <christian.koenig@amd.com>

>
>> ---
>>   drivers/gpu/drm/ttm/ttm_pool.c | 29 ++++++++++++++---------------
>>   1 file changed, 14 insertions(+), 15 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/ttm/ttm_pool.c 
>> b/drivers/gpu/drm/ttm/ttm_pool.c
>> index 5455b2044759..7b2f60616750 100644
>> --- a/drivers/gpu/drm/ttm/ttm_pool.c
>> +++ b/drivers/gpu/drm/ttm/ttm_pool.c
>> @@ -239,21 +239,6 @@ static struct page *ttm_pool_type_take(struct 
>> ttm_pool_type *pt)
>>       return p;
>>   }
>>   -/* Count the number of pages available in a pool_type */
>> -static unsigned int ttm_pool_type_count(struct ttm_pool_type *pt)
>> -{
>> -    unsigned int count = 0;
>> -    struct page *p;
>> -
>> -    spin_lock(&pt->lock);
>> -    /* Only used for debugfs, the overhead doesn't matter */
>> -    list_for_each_entry(p, &pt->pages, lru)
>> -        ++count;
>> -    spin_unlock(&pt->lock);
>> -
>> -    return count;
>> -}
>> -
>>   /* Initialize and add a pool type to the global shrinker list */
>>   static void ttm_pool_type_init(struct ttm_pool_type *pt, struct 
>> ttm_pool *pool,
>>                      enum ttm_caching caching, unsigned int order)
>> @@ -543,6 +528,20 @@ void ttm_pool_fini(struct ttm_pool *pool)
>>   EXPORT_SYMBOL(ttm_pool_fini);
>>     #ifdef CONFIG_DEBUG_FS
>> +/* Count the number of pages available in a pool_type */
>> +static unsigned int ttm_pool_type_count(struct ttm_pool_type *pt)
>> +{
>> +    unsigned int count = 0;
>> +    struct page *p;
>> +
>> +    spin_lock(&pt->lock);
>> +    /* Only used for debugfs, the overhead doesn't matter */
>> +    list_for_each_entry(p, &pt->pages, lru)
>> +        ++count;
>> +    spin_unlock(&pt->lock);
>> +
>> +    return count;
>> +}
>>     /* Dump information about the different pool types */
>>   static void ttm_pool_debugfs_orders(struct ttm_pool_type *pt,
>>

