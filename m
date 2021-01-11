Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 083872F1736
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 15:03:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388325AbhAKOCk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 09:02:40 -0500
Received: from mail-dm6nam10on2067.outbound.protection.outlook.com ([40.107.93.67]:57888
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388029AbhAKOCe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 09:02:34 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tcnu/gp4Lrj+Iu1y4GeHP5mxNvV21o7DwJILuNxAtFbict2kEpN4bkZ49dpl3LlILB88kF2xprYU3xu4iB9H0Xosv2awYKkXX71Z/zVuLCrSYoLC5YJuxb/sw/0Pace7inufx6K3TOmYZVGCWHcz0BywWZWiaLr0PMVUvkG7CnrfQe9Oo6Es2pwYrWeZPnLuw9COOLDFmb5XW3zYy9pqmfkliHI9n7OEzrjno7yIJgyqGjO26WpEFwIa0l99Z5iHg0reMGKLMMuzYMi1rgA0mZpPPNs5D+PCL3mr8JjVoMMgMIGfglvgrmBNTY/+iJIuBJOsTPPwaiShk4//jQKvCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6A5vNpBGJGRAbhxpb+rrSQ75zinBIluPWSCIBw7dzLI=;
 b=Ap9s1N/MVyfbwdiCB9Pp3Zdzde/lzz3js64fIMJQSMVDV/zPJcawlfHWuNzomeZ7bkcDkajGNn+JiKK3d7GMRf/orWvIk+ecBxEGSbdkGeuknvO/Vlqe6tHyQ39U1lK4RYsNNofJOocd3Q952Sb9w6UYD6/zPPr4gcoHS6NFHts0Kk/MLs0Omk8ZkPcXsMXohFi2QTvMGoVzf0t30g8ZG58ilAFavR161naFk7RZpG9/NXLSnUbGJDZINaKl+nSXVtWTcEAj+Wsit13NnlEHHgBcVptmTtgtfSuRs/7xyUsYW7BQaQ9FwpeaasZ8LVQJs/SJGTauDF3lcuBqksy20Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6A5vNpBGJGRAbhxpb+rrSQ75zinBIluPWSCIBw7dzLI=;
 b=g6HLtJIM+660/KiBshIq15zZtzm8ileqYO7jD0hfMhpKr3lWxFKOu4whGlU02Cu74L9RIgbCSpi79GZDEUjb6xcAgHQ0E11VWVBb0gCHKuByQflhrqNYzLQ3zBWuKENUcjHORfGD4SaJA4mcSDuzrYpfbV5obKpBz/+1oSvJlV0=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB3966.namprd12.prod.outlook.com (2603:10b6:208:165::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6; Mon, 11 Jan
 2021 14:01:38 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::44f:9f01:ece7:f0e5]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::44f:9f01:ece7:f0e5%3]) with mapi id 15.20.3742.012; Mon, 11 Jan 2021
 14:01:37 +0000
Subject: Re: [drm:dm_plane_helper_prepare_fb [amdgpu]] *ERROR* Failed to pin
 framebuffer with error -12
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
To:     Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Harry Wentland <harry.wentland@amd.com>,
        "Deucher, Alexander" <alexander.deucher@amd.com>
References: <CABXGCsPSYh-Nvfig4j4N8073vA6WDdhdg13meAcUgCr_pd5mYw@mail.gmail.com>
 <816e944c-72bc-d94d-449f-bfb915382290@amd.com>
Message-ID: <6e55d84c-7b9a-167c-34cf-9e980f8e2354@amd.com>
Date:   Mon, 11 Jan 2021 15:01:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <816e944c-72bc-d94d-449f-bfb915382290@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-ClientProxiedBy: AM9P193CA0021.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:20b:21e::26) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7] (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by AM9P193CA0021.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:21e::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6 via Frontend Transport; Mon, 11 Jan 2021 14:01:36 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2a78bfb6-e0b1-49a3-fe47-08d8b63969ce
X-MS-TrafficTypeDiagnostic: MN2PR12MB3966:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB3966182F87ADD4B7E44840FB83AB0@MN2PR12MB3966.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AE1qJsTMdgiMDvUZiwCd8xAsM9ArTtF/gw8AsIQr2DS2XADAUvD2UiUN6wEj8tM7QLsmz0X2nNnAE/98Xq7GZvvt4Gh2R4GIEdv6EI2hnzI/nDYDMheylr6bebpTJv6IxowVDn/IoGw7+UUhhG0oqbZ/spbdQcqTKLBskf2kkangEXgy4aPimeOl1ZfqSmMGGUFPICHuztbRh21NJKKIUwez6CdqleXfZxF8t+JKWTJQ/ZPeRoWy+AN85IMRz767i52offCgU6XWb8sjdbLUNNXzXEoCtdwQFBZO64vHcH+aA8QaaE79J29Cb8rmviPHySPwRK1/hd92Yyv1k07NvlyOfZ9VXcOExdFFMCEa/jjoS+ZCGFXkqX/ehU0LfiVtq8LitxgZxUbIIL9W6Xn394MbaH3x6xMfFVdL/Oy1y0dPk5fgWQ4G4ElX+XbOSsqUyel7AnWg3QhiFJd89jrCpglFdkBdLA5WbAmfQabQjlnEZkO3Wj91WDNOcelfXuX1oxB6soRTpSDzfiP2syKjAJFXFQ0uJvcskB7bQhqxQjoYtOIgzUGpD90wQkCpohDg
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3775.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(136003)(39860400002)(366004)(396003)(8676002)(316002)(66476007)(52116002)(86362001)(83380400001)(186003)(2616005)(110136005)(31696002)(66574015)(36756003)(45080400002)(478600001)(6636002)(6666004)(31686004)(2906002)(6486002)(66556008)(5660300002)(16526019)(8936002)(966005)(4001150100001)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?Y0tFeFhOdGNMdUFUOGpPNmN4aW9aM2tuMm5uNGM0azFaeVFtVFdnMURZc2ZI?=
 =?utf-8?B?SVFFK29SWWZzZ0VkLzI3eng5NUhrRnllZWVRVWppTHVWR3Flb245QVJqMFFi?=
 =?utf-8?B?MkpqOW8zTG92MUxxTGdjdWhwSG5CbTVVdkY5YnVSTEFtUEkrUTBiMkd0cEEy?=
 =?utf-8?B?dHZDRW5FUTUvVUY2MGpvcEJsZC90YVlrL0U5djJPU2tidVN1TEF1bVZBblBn?=
 =?utf-8?B?L092UDZXRmFENGdML3JqT1BRL080Wml6dGNsWFp0aEpxbGpWdXVaV1N4Q0NH?=
 =?utf-8?B?QndJSE5vaGNQaitPUE5TSFF6U1BQR0NKRi9GMWI5emRpbXpmK3ZkdzRFcGpM?=
 =?utf-8?B?RG9MdUxBRGtBdHRwV2V6M3d0TEJ0L2d3M29hWW1uUU5CNktsZ1EwRURYeTAr?=
 =?utf-8?B?YldYYzB5d0gvTmZpb0tMWWxITlh5bnU0VkhnL3J0UTZvZHhvZnBrb3pMYloz?=
 =?utf-8?B?dnNGbGJPTzlvMXNIK1YzNHNmcXY4eElRaU40TlNxTUpyKzZhRU9xWWhtTzBC?=
 =?utf-8?B?R0hxeWtZbzErUDQ1T21acC9tdHR2U1BnUXcrOW5tTS9Xbyt4VTNoQ3ZuNmZE?=
 =?utf-8?B?SkZCaC9jOEQ3ZmxxOTJPaVlMeGNvUkIza2h5SjU0eklSTzhnMWJ6a0ViNFMv?=
 =?utf-8?B?VGVjd2xWOE1sWERRalVJSTJvTFlrMDBLcXZ3UGZWMS85Y2NwdEhiSWJxMVp5?=
 =?utf-8?B?ejVKS1ZKaTJLT0VnL2o2V1JJTUJzUXFkS1U1TVhaR1lhV1lPc0h0VnJxQ0pP?=
 =?utf-8?B?eC9BVWh2eStnUU5EN0t4WkZqK1ZFUEJvMlFiUTBaenRKTWNjZU1wVkRadHpW?=
 =?utf-8?B?S0c1N1hPa1BrUU5kb1daUldHZWRkdVlaR2I4NjhBWkFmVmdhY2NyM0dmVDFZ?=
 =?utf-8?B?L2VzQ2ttenUrKzJ6bkZ6dDVOTzcyYytYSE5jSU5DUGd3SFl2QWZPdjFUTWxI?=
 =?utf-8?B?N2h5M3B2UU5BK0E5S3RjcHRyNTFVSXZYdVhwUG9Bdk02M2d1YzNIOEpjSVl5?=
 =?utf-8?B?UFR1VEl5R01nbllKWlVsWEtuNGlCZkVxQ1VVT3NMNWtDWUd2UG5rV2RFa1J5?=
 =?utf-8?B?Z1B3T0ZFWStNM0R1UUo3UXpTUnU1ZHdpNExXS3MrL0pveFRoazRLM3QvRHhP?=
 =?utf-8?B?ZXM0TkJrRStDS05PWTlZRTlHb09KMzdzeGUvZW13ME5lNVk4R3hGTWNhNFJJ?=
 =?utf-8?B?WmlTMWZkMTgvLyt6Y2dhQlRNeVM1OWd1azcwMDdVdzlEc242aXRjQXZUUGp5?=
 =?utf-8?B?ZzFyUWpJVEhHeEk0c3puWkgzcEVWQTYxZWZ6d0RrOFlMK05MMjZ6Yk1rLzI5?=
 =?utf-8?B?NFVNcG4zcTJTVFdtbUl6RFphd0NnMW5hWWNFTUN2VEszRUpKUkp0c2hOU3pB?=
 =?utf-8?B?RWJUdGphOGdtanFvVFBIVk1ZTUdueUE4MWVEVVRiT1BrUkpyTkxzMldodmF1?=
 =?utf-8?Q?YgkDE3RZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2021 14:01:37.6260
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a78bfb6-e0b1-49a3-fe47-08d8b63969ce
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cb/zm6oClO3XnzHkj7hRiZNcNIp3YzSgK95zAE6Q/dS/WO5CT+2WrMND/pZZgrR9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3966
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 11.01.21 um 10:03 schrieb Christian König:
> Hi Mikhail
>
> Am 10.01.21 um 23:26 schrieb Mikhail Gavrilov:
>> Hi folks,
>> today I joined to testing Kernel 5.11 and saw that the kernel log was
>> flooded with BUG messages:
>> BUG: sleeping function called from invalid context at mm/vmalloc.c:1756
>> in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 266, name: 
>> kswapd0
>> INFO: lockdep is turned off.
>> CPU: 15 PID: 266 Comm: kswapd0 Tainted: G        W ---------
>> ---  5.11.0-0.rc2.20210108gitf5e6c330254a.119.fc34.x86_64 #1
>> Hardware name: System manufacturer System Product Name/ROG STRIX
>> X570-I GAMING, BIOS 2802 10/21/2020
>> Call Trace:
>>   dump_stack+0x8b/0xb0
>>   ___might_sleep.cold+0xb6/0xc6
>>   vm_unmap_aliases+0x21/0x40
>>   change_page_attr_set_clr+0x9e/0x190
>>   set_memory_wb+0x2f/0x80
>>   ttm_pool_free_page+0x28/0x90 [ttm]
>>   ttm_pool_shrink+0x45/0xb0 [ttm]
>>   ttm_pool_shrinker_scan+0xa/0x20 [ttm]
>>   do_shrink_slab+0x177/0x3a0
>>   shrink_slab+0x9c/0x290
>>   shrink_node+0x2e6/0x700
>>   balance_pgdat+0x2f5/0x650
>>   kswapd+0x21d/0x4d0
>>   ? do_wait_intr_irq+0xd0/0xd0
>>   ? balance_pgdat+0x650/0x650
>>   kthread+0x13a/0x150
>>   ? __kthread_bind_mask+0x60/0x60
>>   ret_from_fork+0x22/0x30
>
> I'm probably responsible for this. Need to double check why we try to 
> allocate memory while freeing some.

Changing the page table attributes while releasing memory might sleep. 
So we can't use a spinlock here.

Thanks for the report, a patch to fix this is on the mailing list now.

>> But the most unpleasant thing is that after a while the monitor turns
>> off and does not go on again until the restart.
>> This is accompanied by an entry in the kernel log:
>>
>> amdgpu 0000:0b:00.0: amdgpu: 00000000ff7d8b94 pin failed
>> [drm:dm_plane_helper_prepare_fb [amdgpu]] *ERROR* Failed to pin
>> framebuffer with error -12
>
> -12 is just -ENOMEM. Looks like a memory leak to me, maybe caused by 
> the problem above, maybe something completely unrelated.
>
> I will take a look.

The looks like a completely unrelated memory leak to me.

Probably best if you open up a bug report for this.

Thanks,
Christian.

>
> Thanks,
> Christian.
>
>>
>> $ grep "Failed to pin framebuffer with error" -Rn .
>> ./drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c:5816:
>> DRM_ERROR("Failed to pin framebuffer with error %d\n", r);
>>
>> $ git blame -L 5811,5821 
>> drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> Blaming lines:   0% (11/9167), done.
>> 5d43be0ccbc2f (Christian König 2017-10-26 18:06:23 +0200 5811)
>>   domain = AMDGPU_GEM_DOMAIN_VRAM;
>> e7b07ceef2a65 (Harry Wentland  2017-08-10 13:29:07 -0400 5812)
>> 7b7c6c81b3a37 (Junwei Zhang    2018-06-25 12:51:14 +0800 5813) r =
>> amdgpu_bo_pin(rbo, domain);
>> e7b07ceef2a65 (Harry Wentland  2017-08-10 13:29:07 -0400 5814) if
>> (unlikely(r != 0)) {
>> 30b7c6147d18d (Harry Wentland  2017-10-26 15:35:14 -0400 5815)
>>   if (r != -ERESTARTSYS)
>> 30b7c6147d18d (Harry Wentland  2017-10-26 15:35:14 -0400 5816)
>>           DRM_ERROR("Failed to pin framebuffer with error %d\n", r);
>> 0f257b09531b4 (Chunming Zhou   2019-05-07 19:45:31 +0800 5817)
>>   ttm_eu_backoff_reservation(&ticket, &list);
>> e7b07ceef2a65 (Harry Wentland  2017-08-10 13:29:07 -0400 5818)
>>   return r;
>> e7b07ceef2a65 (Harry Wentland  2017-08-10 13:29:07 -0400 5819) }
>> e7b07ceef2a65 (Harry Wentland  2017-08-10 13:29:07 -0400 5820)
>> bb812f1ea87dd (Junwei Zhang    2018-06-25 13:32:24 +0800 5821) r =
>> amdgpu_ttm_alloc_gart(&rbo->tbo);
>>
>> Who knows how to fix it?
>>
>> Full kernel logs is here:
>> [1] 
>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fpastebin.com%2FfLasjDHX&amp;data=04%7C01%7Cchristian.koenig%40amd.com%7C15ef83e462e049429be208d8b5b6c6bb%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637459143942981908%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=Uj9Ob3lUCAsH8NrxC715zSfl5Yqc44ySVo%2FZkdyTpCM%3D&amp;reserved=0
>> [2] 
>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fpastebin.com%2Fg3wR2r9e&amp;data=04%7C01%7Cchristian.koenig%40amd.com%7C15ef83e462e049429be208d8b5b6c6bb%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637459143942981908%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=u8irMU3i8c37W5SkyiaAi%2FtwMoPorezm3NI1EYI3csE%3D&amp;reserved=0
>>
>> -- 
>> Best Regards,
>> Mike Gavrilov.
>

