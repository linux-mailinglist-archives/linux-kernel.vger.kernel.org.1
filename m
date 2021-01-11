Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D52972F2118
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 21:47:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391317AbhAKUqw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 15:46:52 -0500
Received: from mail-mw2nam12on2079.outbound.protection.outlook.com ([40.107.244.79]:22753
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730035AbhAKUqq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 15:46:46 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DylGmCi4evCfZWBvZdBkFFZcxiQTuL39m+liB0rYgJxcQXtHx8yk2ZLcCGJxV2NZ5FsGPD4H7V1HOGNZDVEUyoU70Gxp5CXbr29XGpyl8fd0EHJ0+7vponkH2H9OLudMOfBDx3HYo9pse/W/jLU26O/nw/pGlyM8G74REgw4OmWKzURsvyH8+/kU393bEsWWMdF4K8h4KDIVXSvT2d3jT1JtjCi1QTM0Idq+J9hw/vqMtxpC9GcFf5EwBcLBYopiIT5hnohSL9AKE+IGJhBR6iXIKdB40LvB6f3+9fjhX9pAaOr1cY+Ji/HjmJhzyhBPBorq9aSgN75JupSI9X8WpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hFg1JbvIqdj4rWAeFuKeVe9a7EYqRti2NclALypBuOo=;
 b=Tt+mHqHq+QbkPbdsqkbUmXLIg7sI9B0RTCGyMsz/FGCAigID9gheggxQvS3iTg4LA5Cdx/hclnttqZcM3GMQDFWti5+PaeD5TyHHeVOjBi7MVgoSR68BtP6+c+suHnJHYS/7PfZ6SWaIhI8zXpGq58uNm6HDmJks0QZKNMEiuGiYMtsRe20u4vPJXD7wZtEvJTo+R4rvKOIilr10Ek0QeQRFBBeWNGGz5lJYB7q9F5ynEXHuaUwpvRCAJRG/cL450M7/CaKQ4P21laLxW6aLqhLp0c3LPt5DU4VriKKikcE7LFO4H+xqBGkE/L2ZLJ87xf+fHhDbUhbjmE908t9o2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hFg1JbvIqdj4rWAeFuKeVe9a7EYqRti2NclALypBuOo=;
 b=EUzgSPQDE+Wt1E74V5ILL/7853GKhHwj672Z+if77BN80j+aAa2Z9TXU11eLJHH7ppC/iVPiH50mW7CEAiYefY/NEGrl+4cjmNdAYqhOqaS3Mfu9xAZ5fefPlgTTSt6O/EFW3CjYqGys2mpjftI1jPuwPopg1tC3vtjYNh7YUmI=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4438.namprd12.prod.outlook.com (2603:10b6:208:267::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6; Mon, 11 Jan
 2021 20:45:53 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::44f:9f01:ece7:f0e5]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::44f:9f01:ece7:f0e5%3]) with mapi id 15.20.3742.012; Mon, 11 Jan 2021
 20:45:53 +0000
Subject: Re: [drm:dm_plane_helper_prepare_fb [amdgpu]] *ERROR* Failed to pin
 framebuffer with error -12
To:     Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Cc:     amd-gfx list <amd-gfx@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Harry Wentland <harry.wentland@amd.com>,
        "Deucher, Alexander" <alexander.deucher@amd.com>
References: <CABXGCsPSYh-Nvfig4j4N8073vA6WDdhdg13meAcUgCr_pd5mYw@mail.gmail.com>
 <816e944c-72bc-d94d-449f-bfb915382290@amd.com>
 <6e55d84c-7b9a-167c-34cf-9e980f8e2354@amd.com>
 <CABXGCsM8yYNz7gQW26a4hHwBR+MunXoopHEiyDJdC-muNrRxkQ@mail.gmail.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <77b696b9-3248-d329-4f7d-5e27a21eabff@amd.com>
Date:   Mon, 11 Jan 2021 21:45:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <CABXGCsM8yYNz7gQW26a4hHwBR+MunXoopHEiyDJdC-muNrRxkQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-ClientProxiedBy: AM3PR04CA0135.eurprd04.prod.outlook.com (2603:10a6:207::19)
 To MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7] (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by AM3PR04CA0135.eurprd04.prod.outlook.com (2603:10a6:207::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6 via Frontend Transport; Mon, 11 Jan 2021 20:45:50 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 26cb8de0-3974-42fb-554d-08d8b671e357
X-MS-TrafficTypeDiagnostic: MN2PR12MB4438:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB44381A6DA6D4A1EBE83C969583AB0@MN2PR12MB4438.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3jZ3TzIHfzjlSGrDm/tyFyMqYOqZLU/jzc01zG8/SAS0ClBvDPVeY0OZmzxltHvxLvMt4fKaTOEzKyu5ORfS4NbvmJJm0MoP9qwdG2xHATmj7uyIyA6DLhAQunNDTe4xjtdAJ++wCXAJ7geqP2xKXLxda2GgH7JA0MPnZamoyzf6NfpjMz6TeV2YwM08mNPUY7dATAluY1gg8ulKf/98qDik0sCtK2EMkX8x+Nkq7z1qGbM3Vqc64lxH8HTZWv3ZKVwgua01S0I/x7RMc99t+RQF1EutlylVXSv50c+LxRkQdhWpA5rtmiwwnzDyNH2zC6fE43DBsiLjI0i4ZQke1eyWYHsYR++t7te68KBRTCFtCu3wSOeEaeEEPIMnmXNnVJryN8oF9KXzt+3LazWkSm4+YHNRO+TDjOgqF2ibSO6GZxHrU12xUqgGkxkoMbKpH68+a2twiskZjDUXGBjPFSh6uCDAIui4WuHGKmvB/zHKZKjayhH/zNyUCgIs2GZO/He2SKhY+rKo54kE7DBPF/O3nzsR8fqhVjMEKrKRAaxgRuZeif4dKZqj25zeB9zj
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3775.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(39860400002)(136003)(376002)(396003)(5660300002)(66476007)(6486002)(31696002)(83380400001)(45080400002)(2616005)(66946007)(966005)(186003)(66556008)(86362001)(8936002)(6916009)(36756003)(31686004)(52116002)(54906003)(4326008)(6666004)(316002)(2906002)(478600001)(16526019)(66574015)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?Ni9uczJrcWJxYTYyMVpPeGJ0RTd6TFQ3R2JiRjg0Z2dua0ROSWk1U1ZSNENP?=
 =?utf-8?B?TmlWcmxMMFBmYkJ1bHhDYjZWMWxFZ0xBTU9FSmU5TkRldDlJYTE4dzREN1Nz?=
 =?utf-8?B?enVINndRYm5NaU9CandNcjBqdVByY21JKzkyaVNnMSs3UHF3YkU0SWhvRUQr?=
 =?utf-8?B?M2RXNnltdEhWOVZ3WENvV2tndDBmeEVzWnpXWkJ0ZXZmd29rZjM2WG5QKzcx?=
 =?utf-8?B?ZVBYSjVvUnUwWFZxaUxBb3lHdzNIVzZ1VjU3NXI5dWpjeE9jYW03b0hwS0JU?=
 =?utf-8?B?cGRDdVFHemtpQzV4UERacjk5YnQrWjFTZkNIWjlVd0x3eWsrZHFZNXBMMGtK?=
 =?utf-8?B?WHpJSlEwa1diRHphbi9aQUEvdlJLQzhKYkI5cU9hUGhEZm5Rc2VhVWhQK05Q?=
 =?utf-8?B?eHpvTTBCYys4OW1aclprQTE5WGRYTmRmb3YvQVBYRG5IL0U1MzZXcnRQL0xK?=
 =?utf-8?B?MHBSdGYzM2dpaHRWcjVzYXl6MHo1RTk4STlYMXgwU21RSjhoOG16QjkxV1Ur?=
 =?utf-8?B?OUZBWkVIcmtpR3RzQlRDOVJCaU4rWlZaQWxsMTRURmV4dUZwS0h2a01oVXVT?=
 =?utf-8?B?QWpyb1JnbGtyb1o0TVFsSWRBaDQ5K3NyK0IyUEx4eFI4UDFsTjVoSGpqcGU0?=
 =?utf-8?B?cWtNc2QvNlNPNW1yeDRURlNDeUJveWNmcmRhdGdVM0JqWGwrWmliMmYydjYz?=
 =?utf-8?B?RU1SSmlIZ2ZuaXA4Wm94a1N5ZE1rV3hNR1VYS2pLc1dEQ0RDTC90eDlFMnhm?=
 =?utf-8?B?ZHVBcFpYM2hLclc5RGdsdVBDMHJqYzI0NWo3RURvRE5JeVZqZ29lYnNlZEFP?=
 =?utf-8?B?KzMzVHE0ZWREa2Zob3VxWjJSVVVteWpwaXl3bDlVL2ZMM1lBUkRac0lUc0hn?=
 =?utf-8?B?WU9LSWIwQS9YSUlvZFUyRSs4MS81cGVjdWNXTTFJdkU1a1ZDTjd3S2d0L2FP?=
 =?utf-8?B?blEvWjdBVXZnUVVkbk5JYTU3WXVENGJYKzNrdnllOTRtUFkxbmJFOTREK1Aw?=
 =?utf-8?B?L3NLa1pIT0lOMDhVaGRXbUdJb2lFWlo4NkhKd2xVZEpkR0c4am8vY1RycXhk?=
 =?utf-8?B?bEVoT3BkemNJWFJ3WEF3YmFQQ2tjeXlWck1HOXVsMDhPNnZQUmoyU0lMTTdP?=
 =?utf-8?B?M3U4b0t3aU1EV3VVSzlvSW9scklmMThDZDFHK1pYc1V2aVhsWW9zTmh1MEt4?=
 =?utf-8?B?UC9Fc29GZFUyWEw4WHBmYUZCQTBPZkt5NUJLYkZ4b1R6MzFtdHlnN2s0QzVG?=
 =?utf-8?B?VVAzbko2bFZhRGRwa1htNWtXQXR6d1hndnd0K2V3Y0JCTXNodnFGMm02Z0Ns?=
 =?utf-8?B?VGlIR1hhRzhqMTZhMWVmTHNZalp3SEpncUNSV005bmNYMHB0MlRXL1ZqZVJQ?=
 =?utf-8?B?dk8yRDZDcVZqNC9UTk01Q05BSTh5dng2ZjBMYzVGR0xiaklCZ3dBbGhsQ09z?=
 =?utf-8?Q?zpejP8jB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2021 20:45:53.3616
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: 26cb8de0-3974-42fb-554d-08d8b671e357
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bwIQfjv8AGSF8cbf0Xx5i4sbo77OEWJeOGtZqqjPsbHRubYE2F2ARcx9WPwhqvMb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4438
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mike,

Am 11.01.21 um 20:23 schrieb Mikhail Gavrilov:
> On Mon, 11 Jan 2021 at 19:01, Christian König <christian.koenig@amd.com> wrote:
>
>> Changing the page table attributes while releasing memory might sleep.
>> So we can't use a spinlock here.
>>
>> Thanks for the report, a patch to fix this is on the mailing list now.
> Can you look also the first trace?

Unfortunately not, that's DC stuff. Easiest is to assign this as a bug 
tracker to our DC team.

> Here a same error message "sleeping function called from invalid
> context" and a lot of [amdgpu] code.

[SNIP]

>>> -12 is just -ENOMEM. Looks like a memory leak to me, maybe caused by
>>> the problem above, maybe something completely unrelated.
>>>
>>> I will take a look.
>> The looks like a completely unrelated memory leak to me.
>>
>> Probably best if you open up a bug report for this.
> Yes, the monitor still turns off after applying patch "make the pool
> shrinker lock a mutex".
> Anyway patch fixed the issue with flood of message "BUG: sleeping
> function called from invalid context at mm/vmalloc.c:1756" so kernel
> log became cleaner.

At least some progress. Any objections that I add your e-mail address as 
tested-by tag?

> Now the issue with turns off monitor looks in logs so:
>
> DMA-API: cacheline tracking ENOMEM, dma-debug disabled
> amdgpu 0000:0b:00.0: amdgpu: 000000006b791523 pin failed
> [drm:dm_plane_helper_prepare_fb [amdgpu]] *ERROR* Failed to pin
> framebuffer with error -12
> BUG: kernel NULL pointer dereference, address: 0000000000000060
> #PF: supervisor read access in kernel mode
> #PF: error_code(0x0000) - not-present page
> PGD 0 P4D 0
> Oops: 0000 [#1] SMP NOPTI
> CPU: 20 PID: 3780 Comm: brave:cs0 Tainted: G        W        ---------
> ---  5.11.0-0.rc2.20210108gitf5e6c330254a.120.fc34.x86_64 #1
> Hardware name: System manufacturer System Product Name/ROG STRIX
> X570-I GAMING, BIOS 2802 10/21/2020
> RIP: 0010:ttm_tt_swapin+0x34/0x1b0 [ttm]
> Code: 55 41 54 55 53 48 83 ec 10 48 8b 47 20 48 89 44 24 08 48 85 c0
> 0f 84 86 01 00 00 48 8b 44 24 08 49 89 fc 4c 8b a8 e0 01 00 00 <41> 8b
> 45 60 89 44 24 04 8b 47 0c 85 c0 0f 84 df 00 00 00 31 db 65
> RSP: 0018:ffffa7400532b9c0 EFLAGS: 00010286
> RAX: ffff978e2ae25800 RBX: ffff97910ec12058 RCX: ffff978e12caac70
> RDX: 0000000080000010 RSI: 0000000000000000 RDI: ffff97912c3d99c0
> RBP: ffff97912c3d99c0 R08: 0000000000000000 R09: 0000000070b3a000
> R10: 0000000000000002 R11: 0000000000000000 R12: ffff97912c3d99c0
> R13: 0000000000000000 R14: ffffa7400532ba90 R15: ffff978e182c6350
> FS:  00007f070bb1b640(0000) GS:ffff979509200000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000000000060 CR3: 00000001f0cd2000 CR4: 0000000000350ee0
> Call Trace:
>   ttm_tt_populate+0xa9/0xe0 [ttm]
>   ttm_bo_handle_move_mem+0x142/0x180 [ttm]
>   ttm_bo_validate+0x12e/0x1c0 [ttm]

I can take a look at this one here. Looks like some missing error 
handling when allocating memory.

Can you decode to which line number ttm_tt_swapin+0x34 points to?

[SNIP]

> You said that I need open up a bug report you means site
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fbugzilla.kernel.org%2F&amp;data=04%7C01%7Cchristian.koenig%40amd.com%7C75040f5053404b0f302b08d8b666769b%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637459898491581880%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=IbkSfHK%2BD13OCcYMg%2BlNsZixi9gDEQEfS7Mxyf7vGdM%3D&amp;reserved=0 ?
> I thought mailing lists is better because bug report on
> bugzilla.kernel.org usually leave opened for several years without
> attention.

Please use this one here: 
https://gitlab.freedesktop.org/drm/amd/-/issues/new

If you can't find the DC guys of hand in the assignee list just assign 
to me and I will forward.

But what you have in your logs so far are only unrelated symptoms, the 
root of the problem is that somebody is leaking memory.

What you could do as well is to try to enable kmemleak and maybe try 
some bleeding edge branch like drm-misc-fixes or Alex 
amd-staging-drm-next branch.

Thanks for the help,
Christian.
