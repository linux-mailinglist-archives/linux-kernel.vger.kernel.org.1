Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D22262B7848
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 09:18:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726791AbgKRIRR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 03:17:17 -0500
Received: from mail-mw2nam10on2070.outbound.protection.outlook.com ([40.107.94.70]:1123
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726156AbgKRIRQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 03:17:16 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LsERxefI0TN6G4Bg88Cgq8HTtbRMxYkLFZd16w0CnNnpBYIKD/X6FVZjTwyRZrQO4n4Mr9xpMOJQNOstjs/XMZqhf99hLxaPEJfMyBWv/ayrkJ2awZq0qQ0XMbjSHWVpOp/zl8HGVw945AoUzZbYLot5uneg4GjN+TnT6ktJfYQ8DMysLLlPA1ZRyesF1i5cHHpKNMlYvEqtHduqe0uiZFqf6j9Szjd0weTUE+eXV/wuekbG+9nXM6/g1jb2lLqt4GCkbUidoxe2CeJlfSnsorJ9c9gR32YqRAq385nRgi9oljXiBvAmunPZDP9/FKf2Fvs2nd0rMuaYwhm8fcTM2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fYAnppOTf8h3mZMvzij2fFsfypVyDTFBud4A/rqwhtU=;
 b=lYUzFgoBJZbRudy3Tl4bc7zFADgpWKq14K60adNZIq2P/2mGqmdRl3W5XGRQ8CvK+5yq5SI05QzKnXsghKdvHZXf2fdUZ2PZgSkNVfRwKowJppiD3kZn2WI1NUGg+h4vr3bEibhoHP+KP0kqYI9E7gvg6QVylLdzYR1ekR7ZLhHWFe/Xv2m0znZ6mdOt40C0n1R5McDKo8pC8qlbSB2Uw5QtkYY2xQnoOb9QKp6e06QSEQFazLkJfQC6J/EIsZzbje68uIuWefIfEFBWT9XSzhJdJ9i7meZT7vuBmGY2WWDlo6tmKb8NBqriKPCsEgumMAsGetuRKoGHowgTGqooiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fYAnppOTf8h3mZMvzij2fFsfypVyDTFBud4A/rqwhtU=;
 b=uSBKlZ+nXbxq3Bt7EaD3N8OIEe1P99myvMH774WOp95KsPqnhpacIg9EjhjRI7j428gSzZeQAsbisGH70mRKbH5zxWshzFl3kNsQmopIWLTKN0PfE6s4d4+IvIxHBA5u/RCw8UJ+jn+FS8TnS1NjuRmbG5rRVjkSkke+C270E80=
Authentication-Results: vivo.com; dkim=none (message not signed)
 header.d=none;vivo.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB3966.namprd12.prod.outlook.com (2603:10b6:208:165::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.28; Wed, 18 Nov
 2020 08:17:13 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::1ccc:8a9a:45d3:dd31]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::1ccc:8a9a:45d3:dd31%7]) with mapi id 15.20.3564.028; Wed, 18 Nov 2020
 08:17:13 +0000
Subject: Re: [PATCH] amdgpu/amdgpu_ids: fix kmalloc_array not uses number as
 first arg
To:     Bernard Zhao <bernard@vivo.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Joerg Roedel <jroedel@suse.de>, Borislav Petkov <bp@suse.de>,
        Fenghua Yu <fenghua.yu@intel.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com
References: <20201118024234.102485-1-bernard@vivo.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <d61726de-c9a9-ee9c-cb8a-c34f0625a973@amd.com>
Date:   Wed, 18 Nov 2020 09:17:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20201118024234.102485-1-bernard@vivo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-ClientProxiedBy: AM3PR07CA0142.eurprd07.prod.outlook.com
 (2603:10a6:207:8::28) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7] (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by AM3PR07CA0142.eurprd07.prod.outlook.com (2603:10a6:207:8::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.15 via Frontend Transport; Wed, 18 Nov 2020 08:17:11 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8bd831b7-f888-48cf-0e81-08d88b9a5a6a
X-MS-TrafficTypeDiagnostic: MN2PR12MB3966:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB3966BF791A634A58EC5A7C0583E10@MN2PR12MB3966.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:415;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CKEcd6ao3T0YkfuqphmbM8fU95iVLObbTOdo5gVtfUAUAX+k3HzgJ40C1gri2bQ1XrJ20fBOWgMvro6bJ3HZAwTakNbqqIBnZ0Ky3Leg5FZKwORFUnqJygmpWOv/R/qpaRQBJnNwfTYgJA0ATWE6ZvSN3EQ70hWPgQKijx8uDCPN0Gdv7Y6yT4Opd0hpDKJJi0gEF1H/rFl8Jnu5zjbbZqtpIjKmonVSrs21pxwH6sPlJrHQALuu7feq7cjryQ1HYpCDW7cacP/vL84UUxEJCczm8QrHfzUynmMyYKuff9P1aRRNQCJxMkVHyUIAKvhpXblMiqNfMEqZO0vvZFOh90kZwfvhYX/Ew5slHRU9xwNPgfSwmmrnOIWfTTsVueVcpSH2d+/WqgsbmNDJFQ/F3g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3775.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(346002)(376002)(396003)(136003)(366004)(4326008)(8676002)(31696002)(66946007)(7416002)(921005)(66574015)(186003)(316002)(2616005)(52116002)(83380400001)(478600001)(8936002)(110136005)(6666004)(86362001)(16526019)(66556008)(66476007)(2906002)(31686004)(6486002)(5660300002)(36756003)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?UTZOU1ZMd08xQWE5YkJUUmViUHVTZkl6YWFIdHVWdkF0dDNTS3B6Q0kxMjJp?=
 =?utf-8?B?TVo2R1M2NS83SWlMaE9NcVlPVzBhMDNiQWhwaFBiRGEvbkFqS1JCODVkNXQ5?=
 =?utf-8?B?Z2k3dHVwMm1DSCtUSHF0NlBsRXhkSFo1ZGxaTS9TNmlZQjJtVVBtRWFLcmFP?=
 =?utf-8?B?ejk1VFVTWjdYcDduOFFsM0phRExxVkF1QmZ3cTB2QUlhZFExckM1MUdpdjFi?=
 =?utf-8?B?OHhFTEhMQ2ZqV2FzVlpKZnJMRHVOSHVXZHkzZmx5VnZGcjIzUSswK29Ed2lX?=
 =?utf-8?B?ZmtDa1ZEaytDYmVML2dBWTZwUzVZRmtrVXhUWS8yRWxMZHUxUjZ5MkEwTWtl?=
 =?utf-8?B?UDlqTXVGZnZVWmVkUXdYdCt4QnEzRHlCdlBYVzBMOWw4M3JaUU9kSFl2STB6?=
 =?utf-8?B?cGF0VjZNUitWRzNQMVBCSkZJVjNsTS9xNVFYTkE1VUlTWkRjM2Y1MFVGRS8w?=
 =?utf-8?B?Wm9FNHhTQmFXU0JIYlRpM05XdnJRclhQWWxHZTRGd3BzNXZDckdicXJCWHM4?=
 =?utf-8?B?TjlwS3lxenlJU3BNWEV0Q3FvOVg1OElOTjlYclN3TytKUFBkNmxXeG1Icndv?=
 =?utf-8?B?cUhXMTZtYnJFWkZtYUpqUmp3MFR0MVZVMjRud3p1RGpUT0QwQThSaHhwRFBi?=
 =?utf-8?B?VytkNmpVYkFQUWhKM0JESVR5aHpwL3o3ay9WRi9XeEcyOEtTK0syRkU2aUhv?=
 =?utf-8?B?ZUhiWU5wLzZEVldMUFdCR2hDNzV2akJDTEl0WGZXVFVpSmo1QXF5TnV1VHlE?=
 =?utf-8?B?NkF5MzZha0dpKzNjdmlKd1BnTHZoTTkwVnFtZzlQbkVMeCtVdlZuS25lRTli?=
 =?utf-8?B?MW1jQitGMDA3cXBZRlJ2WnUyR05YS0pJbHZmYlhxVENRcWs0b0FLd01SK1ky?=
 =?utf-8?B?OUZBMGpmc1ZnSHNVcy9NcFcyY2pKamNobmRRUEl4T3R0YmNkZktCN1hRVGZW?=
 =?utf-8?B?cm5hWW1pY2cvczdrd2pTYUZjZDFobWM3R3hwcWx2SzBoVitncjhpL2RVM084?=
 =?utf-8?B?MHcvaXk1UDlodEkxWTN4Z0lIUFRUNnJLZ1BRL0VOcGh2Sm8zSE9zTCt4M1Fz?=
 =?utf-8?B?azhSS3JoYXUyV3k2d2YzTXVhRjBKWXRXVFFBL3Btb0wxbDdwOW9FcGhkTGND?=
 =?utf-8?B?d3lOUHYrTVlmV3RjTW9tTWJ5WDVXQmVNMy9abng3M3E3UXVHdU43cTdYTENH?=
 =?utf-8?B?NW4rSU9pRmYvdzErQUlVR2Z1M2hBaDJuQlJ1MGt1bmNZOFJoblhNc1VDdVhW?=
 =?utf-8?B?VC9TODhZU0tHL2RNL1dzOCtDZmxlb1B2SHhMb3J1STh2Y3JxUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bd831b7-f888-48cf-0e81-08d88b9a5a6a
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2020 08:17:13.4237
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hD90uyCVx0L7Qctx5oqeYLFZtuBFrSetguwJZBhFsrxDW9N5WvPoBj028NSqk6RR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3966
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 18.11.20 um 03:42 schrieb Bernard Zhao:
> Fix check_patch.pl warning:
> kmalloc_array uses number as first arg, sizeof is generally wrong.
> +fences = kmalloc_array(sizeof(void *), id_mgr->num_ids,
> GFP_KERNEL);
>
> Signed-off-by: Bernard Zhao <bernard@vivo.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> index 6e9a9e5dbea0..f2bd4b0e06f6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> @@ -208,7 +208,7 @@ static int amdgpu_vmid_grab_idle(struct amdgpu_vm *vm,
>   	if (ring->vmid_wait && !dma_fence_is_signaled(ring->vmid_wait))
>   		return amdgpu_sync_fence(sync, ring->vmid_wait);
>   
> -	fences = kmalloc_array(sizeof(void *), id_mgr->num_ids, GFP_KERNEL);
> +	fences = kmalloc_array(id_mgr->num_ids, sizeof(void *), GFP_KERNEL);
>   	if (!fences)
>   		return -ENOMEM;
>   

