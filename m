Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F4ED2B7849
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 09:18:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726533AbgKRIR7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 03:17:59 -0500
Received: from mail-mw2nam10on2065.outbound.protection.outlook.com ([40.107.94.65]:61152
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725964AbgKRIR7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 03:17:59 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jruGW4QX2HECQfM2Qt7G8w9aQpsOBO/ezfVE8ChUIym2yAkc4OnSbl5M25JNurCvU5vG2AlxyeyTkDwMlZ+AVfKJ4QaXZc+j4daezxYWxK0OzZcLLkLWzTmAZyaYZm7Apfre3pG8EvOY+Mdis3V/7RBvHReQyKi5/9sCmtNmFrfy+mC4th5J33L2Lyw6qOHrdq571p1wwLxQJIFkzR5FI3pvzRLKgr1cKD32gon+dQmWl2EcU0Un1Z4Y+6YFEO8RFlBPAJAQmb8xXtzw3/QNsfoESQgo4ye2rf6JKhdnaS9hMC0X71q6IL9nHUzL2tiTF2gKGQpkiTtOxMzG4ymSGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qSs1trCyG5UT4I/jRddZiO1HMVAIVB1h7VRmK6KCJH4=;
 b=UErASAf8kxy+/4ooK+4hxSUK9WE8dU+06IgRwDKZ3qMZdyoYB4gY55gJlIeX4P3c5bQJHqt9tMoEDWwMapJimM1f74xp6Y7RZi0gzZq4KWDgK6jQYJvqghieSw7UD0Ra1SQ/jEBKqK0KS7qK5Divk/m1En6jhkOVyB3dBOI6w19BSENaGvGWt7mTIdesjwTNNZdIf5fX+Np9rWTB1e26nFApHuitKS9WCqx7EXba1HKKNdTkLht6ES9p9AwpFl09Rt34UAbGNqlWB206H3nUbk2Ljw5c7M9a9g062PuL4gDgaN9ZuBBiNVe6YwSRH32Kfg1QuKap6OzFYUU19y9vKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qSs1trCyG5UT4I/jRddZiO1HMVAIVB1h7VRmK6KCJH4=;
 b=VYjYuALAp7mQ/txJsTak7vsQeMR93UNxfjA4Wil2U8wlWrj/g52fNsUc7wrRKcgLWgir4ZKoKXcflWvY5tZUkAcCqzBuqvKXETgTnVo/RMey3qKGupQaakU6BzEDSgZqQSBo2MrVrQMYrVcAj6VuNVSyOZDkqA9ibmtPoff8vCE=
Authentication-Results: vivo.com; dkim=none (message not signed)
 header.d=none;vivo.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB3966.namprd12.prod.outlook.com (2603:10b6:208:165::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.28; Wed, 18 Nov
 2020 08:17:56 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::1ccc:8a9a:45d3:dd31]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::1ccc:8a9a:45d3:dd31%7]) with mapi id 15.20.3564.028; Wed, 18 Nov 2020
 08:17:56 +0000
Subject: Re: [PATCH] amd/amdgpu: use kmalloc_array to replace kmalloc with
 multiply
To:     Bernard Zhao <bernard@vivo.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Monk Liu <Monk.Liu@amd.com>,
        Hawking Zhang <Hawking.Zhang@amd.com>,
        Yintian Tao <yttao@amd.com>, Dennis Li <Dennis.Li@amd.com>,
        Wenhui Sheng <Wenhui.Sheng@amd.com>,
        chen gong <curry.gong@amd.com>,
        Bokun Zhang <Bokun.Zhang@amd.com>,
        "Stanley.Yang" <Stanley.Yang@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com
References: <20201118025503.102699-1-bernard@vivo.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <f55ec782-9eff-c30b-2a0e-01a9898c9387@amd.com>
Date:   Wed, 18 Nov 2020 09:17:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20201118025503.102699-1-bernard@vivo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-ClientProxiedBy: AM3PR07CA0125.eurprd07.prod.outlook.com
 (2603:10a6:207:8::11) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7] (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by AM3PR07CA0125.eurprd07.prod.outlook.com (2603:10a6:207:8::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.15 via Frontend Transport; Wed, 18 Nov 2020 08:17:54 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b70033bf-cadd-41b2-3dd6-08d88b9a740f
X-MS-TrafficTypeDiagnostic: MN2PR12MB3966:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB3966B469DD43F46E87E5E26683E10@MN2PR12MB3966.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:635;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z8Omptn27fYckps9sXsR4NS8byNpiysTRlKhahDHmqaEKX6ISltzrCeMFH7Sfo7UA05N+zgYxBYoUtlctvHACjzwgkWTc/NftRgX6CcamF3HaIwIda4IniXg3nTcAnNMj2yQCA9FC7PAeUzjnkjRVVmiv2v8mfwpZLB1szgs9EeRJEF/dA5+hRWagHterCQ8JQw2USReNR4UoA4QbICdmIQeah6gLZO5dz4dpVCjjSIQwp5lOSQjq61lBqamfI8EcN73wZlvnRpWmWgSVa1uAj5jIW3DV9PvEguRyGeW/+p5VRQ0pg8R7+lJLqBzXHN6051Q2k7uvWfKuElixx1ktisTDIga7xgHZEsPF3BbWH/M58P2APAUMQ2aNfSieVUHkTfB5ai1KQ8ib8+rkiaj4Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3775.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(396003)(346002)(376002)(39860400002)(66556008)(66476007)(6666004)(16526019)(86362001)(36756003)(6486002)(31686004)(2906002)(5660300002)(66946007)(4326008)(31696002)(8676002)(316002)(2616005)(186003)(478600001)(110136005)(8936002)(83380400001)(52116002)(921005)(66574015)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?UFlGTTZqNml4OThHOVZLQkc4VllXNFZiU0RFTURLZnROcXFuYUtZd1cvUGpz?=
 =?utf-8?B?VjAyOW5EQkthbFB5RWtHQmFLeVVWVmFzM2RDZGZTY1IyRUZNWUU3YmlpQSs2?=
 =?utf-8?B?UVlDNTFlMGdCb1BCMnBRcWZZS2JTUmJqMXFoL2ErUEVDR3ZhTnpYYm5kV2NT?=
 =?utf-8?B?a0hpWlUwOEJlb3IrakNnaGZnaDB5WDUraVd1b2ltMlFlMS85VmUzZTFZcEcx?=
 =?utf-8?B?MHhHRVJDd2FjWDJsWXY0TjNQN1plZFV0OTZTeVBBS3piZ3F6NjVsQVhpRVRU?=
 =?utf-8?B?SUlDcTNxM2ZTUGJtOG5QTmY1czZBWVU1S0xtakJQelN1RFJINVR5L3lhM1Vv?=
 =?utf-8?B?TFBVTHdkVXFWcmxTTGliVHI2VVFiK3MycU9raFByaGUyZkMxeC9WV0dGWGxU?=
 =?utf-8?B?cWo1Smg0K25lenozcU9pRmpucVRSV2pQcXBSYi81L0ZlaXpqL3Z0WVFYem94?=
 =?utf-8?B?R21jR3d0dFFkb1kzU01tZUdZbURoVW9OemNBNHRSU1lZbUxVd3gvc2VNVVNx?=
 =?utf-8?B?T0VWTWVBU3QrY29peHBzay9ZQk5pTlFLM2VxNmxwd2xVNi9sRTBtSG1XTTFQ?=
 =?utf-8?B?RFpqbXdOYWphcU0rbkltTndISzdkb1lvMWNxNGl0a1pDOW1IanBjeXI2dTRC?=
 =?utf-8?B?RkY5SzNiWGpodStaQms1RWdtRWdsdm5OaWhFclljaVBBcnB5SVpSbWVGOVNv?=
 =?utf-8?B?c2paVXRkaFJxTDF0UFdYY3ZVZ1o4V29zZzFGMXlZZ3ZuZzlZTkxoRW00bFhm?=
 =?utf-8?B?RmVhVXZLdk44WWxOOTFPYTJiNU9LbE1ERlh5Ry9UQlhZZTAwZktsMzVPbElz?=
 =?utf-8?B?WkdUaWRuYmljdlVCUlFEUE5TVWJZS2lQT0lJcy9XQzRYYzBGOGJFWC9GNGtG?=
 =?utf-8?B?d0VYUGJrNXpraXpIU1VIbGRpQXRINVA0NUdKWndOaDdWUWYyL2lQM1UzNHRr?=
 =?utf-8?B?WnZVTnlOdmtNMStpSVFDUy8rTnBDbnA1REM5YnJsOXlNaUlhS2ttZHRycEhQ?=
 =?utf-8?B?OFNTWmZOZ2VxVGdaMnprVWcyYnBsd3ZlR0lJcnhMVjFRRENPczltdVlLeENY?=
 =?utf-8?B?T1MwWERpZVRLSG9kcDhnNHArT2N1Q3BEQTZIYTVXOXA1elJCS2hTcDJpcjdy?=
 =?utf-8?B?bmVGVTJHWVNMY0lwMjRScGRibURGWFVrY2hEQ0I4RWNsSDFzWHRLK2hTcXo2?=
 =?utf-8?B?U2NUQmVKS0ZFZlBjQnFmRlR3aEw1UXZrc2NUSVYvRzVWcC9PMjZWRkNXVjB3?=
 =?utf-8?B?ZVpIQ0YwR1BON0tEMGViODJ1bEpsRkMvWnFFL1k4aW90MVptUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b70033bf-cadd-41b2-3dd6-08d88b9a740f
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2020 08:17:56.4323
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oJ2Qw9L69cTpTUEBZyuLUhNtCtl4mcNJIYa2PoG7NM49UgUzPjuUvVXYkwm3LFXj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3966
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 18.11.20 um 03:55 schrieb Bernard Zhao:
> Fix check_patch.pl warning:
> WARNING: Prefer kmalloc_array over kmalloc with multiply
> +bps = kmalloc(align_space * sizeof((*data)->bps), GFP_KERNEL);
> WARNING: Prefer kmalloc_array over kmalloc with multiply
> +bps_bo = kmalloc(align_space * sizeof((*data)->bps_bo),
> GFP_KERNEL);
> kmalloc_array has multiply overflow check, which will be safer.
>
> Signed-off-by: Bernard Zhao <bernard@vivo.com>

Not userspace controllable values, but looks cleaner anyway.

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> index d0aea5e39531..f2a0851c804f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> @@ -280,8 +280,8 @@ static int amdgpu_virt_init_ras_err_handler_data(struct amdgpu_device *adev)
>   	if (!*data)
>   		return -ENOMEM;
>   
> -	bps = kmalloc(align_space * sizeof((*data)->bps), GFP_KERNEL);
> -	bps_bo = kmalloc(align_space * sizeof((*data)->bps_bo), GFP_KERNEL);
> +	bps = kmalloc_array(align_space, sizeof((*data)->bps), GFP_KERNEL);
> +	bps_bo = kmalloc_array(align_space, sizeof((*data)->bps_bo), GFP_KERNEL);
>   
>   	if (!bps || !bps_bo) {
>   		kfree(bps);

