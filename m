Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55C922F0EBB
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 10:05:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728282AbhAKJEe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 04:04:34 -0500
Received: from mail-mw2nam10on2047.outbound.protection.outlook.com ([40.107.94.47]:13601
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728157AbhAKJEd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 04:04:33 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eUgpfCiYxFnDs8Ow6gyCuMbSgPdg+l+Vl8a99i1156+qnq8zCo4LHBgZfD0tfzNBngTjDxuhXx1ZCAcrg3rGK8eAMWij3x8WkzhzRfGoZaIrM12ew1/AeTklEXzZ2yolQLlSVlFh79gz5y+wYZinkF7LKFp+E8C5U2UdOoExXRNeZuFMJdUV+MIRGEYkRufWvhG+CmCPyYnUNFC5kFPZ9c3T13L1HrgfuxaS+HIw0ZpMtxr6BL/XRFeQ1R3VEhXdm7+DwXNJyo2IoCbFGseGor8go8eEDyPQ6w2iu1gDC4F2WGlHhDHcLZOfNa51Yc0EO3LuihUKMz7TjAWnviOnQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5XCu3es52Y/7YSHRCZbmkUw0n2AMubqrozmIRuKjJm4=;
 b=dx4Cp8V0q/d6g6gSqw9fXvocH2q2fXqDjVfXfwHEDysqyy3SmTQgbZ0j/9/CG6WTsjzPx/gfJVWZSyoaM6VskCzJJpaIfYMbJckq8oPJPdbwAc2iPbvaWSs202laWKtpDwc3xLbUlaPjaXS0LM9DWnqnJP1WR8VPZkTlOiAeCYGsZG1XbIjPMozyt9NtWl3+dAZtjb4FLLyycuc8LXJh1Bn6NgiC8MRfNCZlM/OVb3pwBiukKRMWO6EmISB4oZSOPrfAHCaJEXXXcS0KP483VGQVIfQl6g5+JIP5RgX69eRD3hQufCKMnwpLhQ9vQSYxPq8G/jm8I8EF4VwXyUAlww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5XCu3es52Y/7YSHRCZbmkUw0n2AMubqrozmIRuKjJm4=;
 b=PvTGMmu5DQmXi7V6zh19FULgADxYw2/DBHifuTmM4X7WQ7khmpOB2ksPQOkjtGgrgQvCmtfXyO2C3IF6faFu1nbLs992Z8QFx3/cU+R9FsdZQjoryjEp/JG+nROozE2nje6n3CyioLRA8LVK4gpHBqNDYkfqk4aqYDXIhJO1bpA=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4847.namprd12.prod.outlook.com (2603:10b6:208:1ba::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.12; Mon, 11 Jan
 2021 09:03:39 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::44f:9f01:ece7:f0e5]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::44f:9f01:ece7:f0e5%3]) with mapi id 15.20.3742.012; Mon, 11 Jan 2021
 09:03:39 +0000
Subject: Re: [drm:dm_plane_helper_prepare_fb [amdgpu]] *ERROR* Failed to pin
 framebuffer with error -12
To:     Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Harry Wentland <harry.wentland@amd.com>,
        "Deucher, Alexander" <alexander.deucher@amd.com>
References: <CABXGCsPSYh-Nvfig4j4N8073vA6WDdhdg13meAcUgCr_pd5mYw@mail.gmail.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <816e944c-72bc-d94d-449f-bfb915382290@amd.com>
Date:   Mon, 11 Jan 2021 10:03:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <CABXGCsPSYh-Nvfig4j4N8073vA6WDdhdg13meAcUgCr_pd5mYw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-ClientProxiedBy: AM8P189CA0026.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:218::31) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7] (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by AM8P189CA0026.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:218::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6 via Frontend Transport; Mon, 11 Jan 2021 09:03:37 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 91f37ace-2e0a-4e6d-74c5-08d8b60fc941
X-MS-TrafficTypeDiagnostic: MN2PR12MB4847:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB484781EC1E63787861C22B0983AB0@MN2PR12MB4847.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TzxY+Tc2piS8dcDJ/3WowiEy7I9BAQmCzvULjQQT/WY2/gM4xnYPcSgRIOoiCAH2qJqSFW/pALOEI0vOzAwYh8abKSJzreOsBELC1Y2/S/0Zhn1PkR89X5tDqfgDcKKe36nRZRJKHaCFxOt/fxUs6qYZKhl5ZiCXlxx1aAiliol7kKskh6SxoQo1DLX0Bx5wBQ9mWcNFJfu4o/pIkZ4OAQLXi2bHJj34baYkyM3OTfH2HvQVRPSxoPuRdnRleKhNC8caAGPLm0i0luJpepWNwIqkCU/DEXG88at2Lg5r1BXaFW8TTEN+hADXMuvWDSfYY8nR+iDdvbBXhv+K2ZSzY35tZCRPi2DMQxjt07eRrFVsUPqzPtqRpfSlySRVkMtaxxj8OVyYdZOrvuh3QMgjSWxeAezMucpnkyxp8DJqrp0b61BoUouS2kXce70skEBp59H8ArWwdiMazsXGXyBX4p7kvMxJRXR4sRkTld/F4oPfiKzXB1zRf3KsKmMqYRrETkVjhB44FpDEGiP5hIXKndzlZniQLJ7r9lLoWwNKTA91z/yj4ewRSIWU2EdR/FXY
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3775.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(346002)(376002)(396003)(39860400002)(52116002)(36756003)(83380400001)(966005)(16526019)(2616005)(6666004)(186003)(66574015)(66556008)(6486002)(66476007)(4001150100001)(316002)(2906002)(5660300002)(6636002)(31696002)(31686004)(8936002)(86362001)(110136005)(8676002)(45080400002)(478600001)(66946007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?NWd3dWZOaDVuRTRXUXVtRmpjc2t2ZEVsQk1nZHZvSFl6N09DQjh3d1RlNXoy?=
 =?utf-8?B?bWhTNWtFRWxvWWxHVUFSTFljSlU0cVBtTjRkMEdlS2ZWaGdLcWNpVVB2eDZL?=
 =?utf-8?B?eGw0UkJCeVYyKytqNzRRWlVNZUdEbkJmRTRIZG1udjQvMXdqdi81czlZNFBM?=
 =?utf-8?B?OHpVTEVaZS83UXVJcUZ0VHF0WjkreklBWUxnRDcyQU40ZERvVGVIMVgwT0Uy?=
 =?utf-8?B?U1JZNkJya2ZoS1FpWkVDb1JmT2s5b1JzL1F2cGIzaDBzUzlsa0I5Z3JzbEZm?=
 =?utf-8?B?ejN0Z0QyZ0t0UjZtVWMzVmFjRWc3NDZLR25MK2pBcXFNYTV1SnZKSXJXZDN4?=
 =?utf-8?B?OHVOUmFENkNIU21GNGhzVFhHRGVrTE1KU2EwYUZQc3poQkxQejgwejJzQy9W?=
 =?utf-8?B?VCtHZ2tLcGJDZDBDSEpWaUVXRkk5dyt1RG9QdFVSTnJBOWVTOHhvY085eUow?=
 =?utf-8?B?SFVsTVV5ZTdMU2NkVmllaEkwZmVHOC9NV1FPL3oyUFJHd1FaZFRzYkdrWTUy?=
 =?utf-8?B?Umd3Q0g5QTlTSnF4RFgvU3dJMDUvaFNXeTQvaFhSTW5JUXgvNFNoODFWNW9H?=
 =?utf-8?B?KzZaMUxDUDdVQmxhOWJjUDM2LzhnUlBXTTAwZ24wL1M4KzcwdVduSHMvWi90?=
 =?utf-8?B?ZmFVVU9pMFBNOXhPUEZ5ZjhVdHVQUlU1YnZVem1lV1BEY1JJNHlDdExRUVVh?=
 =?utf-8?B?SXZMUDJub1cxOVRXNURVWStCcmNhNU9uNWF5cWpITEpsYXVjRFZNNUU2cm1R?=
 =?utf-8?B?MnJ2N2lyY3ZBZlFscmJkYytUa0ZrNE1vUC9xejBsRVBzN1hYT2NLNXNmM0x4?=
 =?utf-8?B?NU5ZUDd5dmd3NzRMTytQaDZYYytMbXh1Q3ZQc2N0dmorSkJsbWYvaUw4M3BI?=
 =?utf-8?B?dk5rTHhPZzF3NkxFTHlrMWphR3Z0cWVYWHduSGhBT1ZwUHVocmxzSFFIM1Rx?=
 =?utf-8?B?WExkcGsrdHhjWGcyaTBraE5hcHZBTVQ4OUwweWZ3V3c2TW5PVzRQZG1ZV0tH?=
 =?utf-8?B?clB4cUprN01qKzB5aTczVW5Zc01DKzhhWFdaaGhhU2hzMWRSMzdkNC8vMGFn?=
 =?utf-8?B?Wmg2a0pnblo3OVAwalh0TjBLRStCRnNOQ1NQaEloVkFtcEVoMjVCbjJicVc3?=
 =?utf-8?B?alFYM3J5TzYwMTF6cVpMaTYwNE9IQmErS3JPM1VPanJiSk5BaDRZWHlWWFFp?=
 =?utf-8?B?TWlWTWIzaHJXb0hqN1lRQlRhWU1QbEVDaU5hK2d1UVJHZEZic1FuWVFnZnA0?=
 =?utf-8?B?Qkx0OVltd3hzM0RZSnZDemk3UFV3bzRxL1psYmlOSi9WZVM1R1dqMVBjRmpJ?=
 =?utf-8?B?Q21uUW9EaXpKb1pYSGRwREdrbmJxdnBqaS9SZWFSMlR5SHZ3cHM1RW5LMTh5?=
 =?utf-8?B?Y1pPVEZSWWROVSthMXNtN2hmaFF2WWRNVVdRVVZTNUN1c05EcFptZzNtVWRE?=
 =?utf-8?Q?tLaCL7gp?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2021 09:03:38.8930
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: 91f37ace-2e0a-4e6d-74c5-08d8b60fc941
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9vBaBblwC6aAXM0Js90Fid9gQhNANHwtCbgLKNB8kycbMnPhxTb2Qb7qHzqpj867
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4847
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mikhail

Am 10.01.21 um 23:26 schrieb Mikhail Gavrilov:
> Hi folks,
> today I joined to testing Kernel 5.11 and saw that the kernel log was
> flooded with BUG messages:
> BUG: sleeping function called from invalid context at mm/vmalloc.c:1756
> in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 266, name: kswapd0
> INFO: lockdep is turned off.
> CPU: 15 PID: 266 Comm: kswapd0 Tainted: G        W        ---------
> ---  5.11.0-0.rc2.20210108gitf5e6c330254a.119.fc34.x86_64 #1
> Hardware name: System manufacturer System Product Name/ROG STRIX
> X570-I GAMING, BIOS 2802 10/21/2020
> Call Trace:
>   dump_stack+0x8b/0xb0
>   ___might_sleep.cold+0xb6/0xc6
>   vm_unmap_aliases+0x21/0x40
>   change_page_attr_set_clr+0x9e/0x190
>   set_memory_wb+0x2f/0x80
>   ttm_pool_free_page+0x28/0x90 [ttm]
>   ttm_pool_shrink+0x45/0xb0 [ttm]
>   ttm_pool_shrinker_scan+0xa/0x20 [ttm]
>   do_shrink_slab+0x177/0x3a0
>   shrink_slab+0x9c/0x290
>   shrink_node+0x2e6/0x700
>   balance_pgdat+0x2f5/0x650
>   kswapd+0x21d/0x4d0
>   ? do_wait_intr_irq+0xd0/0xd0
>   ? balance_pgdat+0x650/0x650
>   kthread+0x13a/0x150
>   ? __kthread_bind_mask+0x60/0x60
>   ret_from_fork+0x22/0x30

I'm probably responsible for this. Need to double check why we try to 
allocate memory while freeing some.

> But the most unpleasant thing is that after a while the monitor turns
> off and does not go on again until the restart.
> This is accompanied by an entry in the kernel log:
>
> amdgpu 0000:0b:00.0: amdgpu: 00000000ff7d8b94 pin failed
> [drm:dm_plane_helper_prepare_fb [amdgpu]] *ERROR* Failed to pin
> framebuffer with error -12

-12 is just -ENOMEM. Looks like a memory leak to me, maybe caused by the 
problem above, maybe something completely unrelated.

I will take a look.

Thanks,
Christian.

>
> $ grep "Failed to pin framebuffer with error" -Rn .
> ./drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c:5816:
> DRM_ERROR("Failed to pin framebuffer with error %d\n", r);
>
> $ git blame -L 5811,5821 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> Blaming lines:   0% (11/9167), done.
> 5d43be0ccbc2f (Christian König 2017-10-26 18:06:23 +0200 5811)
>   domain = AMDGPU_GEM_DOMAIN_VRAM;
> e7b07ceef2a65 (Harry Wentland  2017-08-10 13:29:07 -0400 5812)
> 7b7c6c81b3a37 (Junwei Zhang    2018-06-25 12:51:14 +0800 5813)  r =
> amdgpu_bo_pin(rbo, domain);
> e7b07ceef2a65 (Harry Wentland  2017-08-10 13:29:07 -0400 5814)  if
> (unlikely(r != 0)) {
> 30b7c6147d18d (Harry Wentland  2017-10-26 15:35:14 -0400 5815)
>   if (r != -ERESTARTSYS)
> 30b7c6147d18d (Harry Wentland  2017-10-26 15:35:14 -0400 5816)
>           DRM_ERROR("Failed to pin framebuffer with error %d\n", r);
> 0f257b09531b4 (Chunming Zhou   2019-05-07 19:45:31 +0800 5817)
>   ttm_eu_backoff_reservation(&ticket, &list);
> e7b07ceef2a65 (Harry Wentland  2017-08-10 13:29:07 -0400 5818)
>   return r;
> e7b07ceef2a65 (Harry Wentland  2017-08-10 13:29:07 -0400 5819)  }
> e7b07ceef2a65 (Harry Wentland  2017-08-10 13:29:07 -0400 5820)
> bb812f1ea87dd (Junwei Zhang    2018-06-25 13:32:24 +0800 5821)  r =
> amdgpu_ttm_alloc_gart(&rbo->tbo);
>
> Who knows how to fix it?
>
> Full kernel logs is here:
> [1] https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fpastebin.com%2FfLasjDHX&amp;data=04%7C01%7Cchristian.koenig%40amd.com%7C15ef83e462e049429be208d8b5b6c6bb%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637459143942981908%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=Uj9Ob3lUCAsH8NrxC715zSfl5Yqc44ySVo%2FZkdyTpCM%3D&amp;reserved=0
> [2] https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fpastebin.com%2Fg3wR2r9e&amp;data=04%7C01%7Cchristian.koenig%40amd.com%7C15ef83e462e049429be208d8b5b6c6bb%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637459143942981908%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=u8irMU3i8c37W5SkyiaAi%2FtwMoPorezm3NI1EYI3csE%3D&amp;reserved=0
>
> --
> Best Regards,
> Mike Gavrilov.

