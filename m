Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 324552EAA2D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 12:50:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729830AbhAELuJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 06:50:09 -0500
Received: from mail-dm6nam12on2082.outbound.protection.outlook.com ([40.107.243.82]:18145
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726074AbhAELuI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 06:50:08 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mwbRlfPLPOhO/a1fxg1isB4T3K2ohn6jZe0QZyMV3N+Imga96wDdga5e2mFBBZt19y9Fnvnl6yxSPrjkyeLCm9lFBeg+AiUr+pV/+1PDDoloT58cx1AJBPWIZj9Onq5uOOGf7nmjfhY31jSqk5ky0gFBWyh3szo2LloT1Ib4Pte6oS+tbI8I9+SFg9XPHsYidBNtNFB2qCScZNAWsK4pmbnlBU8FwVuAnUakzseVWyHVzANnKrPqUNcMvSkXoMS+8XupMThjmv9wp0AeUVjTm2+SF7ubcO/Lvr+/wXkr8P4gW9xoqt/OwUzMUKoWIk4DvoRGXehJUgxbWgQT12PbXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rIJal2AhFjCTaqm1IKapEXDkueplJC4RIzkZj55pxCM=;
 b=YtlMpGm0lo2YC5s4wgOILeRL5dAo6NimfV9SXJ/rd5K/HnPPbqESghZLfnMJtB5nqribS60inax79FzG+FCxcEQxP/98PQ+ZUl00P2tv2Wr+s+LBgdJGfu94wBbCyPkI+Jj118vL9M3QI+KSnOvG5yzOS7vKtTt7bCOQfDXPdld+XOV/1Y+Sjc7RtbnnXhFTYG3lFhQ3IZSv1jrsKfk9A3zyngpnlqcDSMQmXNrYv7El6Jgt2npW1Wymh9JtAG35x5ahW4p448LVYkTnVJTvz+YCkGHqIzxzDwAk2zQ6opUegm7yUWq6eK4WkV70RD91wR+L6BanHd1+BhTIYmDL+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rIJal2AhFjCTaqm1IKapEXDkueplJC4RIzkZj55pxCM=;
 b=HL8pR9E4nzOejW2pp+CZjPDydHq6hfzT4VSTF1nejzpZCmMh+sAf796jQkQaufJsDGi1n1JJhLlmD9Tx+uaUFWaD2HHydpJM/BHFJekDDtwxPQMiD9NFD6MyZ26ojHuEEu8OvSY+IdjzEdNmhRUJ78fq1PoN0cg9HTPTUG8GHZ8=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4551.namprd12.prod.outlook.com (2603:10b6:208:263::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3721.21; Tue, 5 Jan
 2021 11:49:16 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::44f:9f01:ece7:f0e5]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::44f:9f01:ece7:f0e5%3]) with mapi id 15.20.3742.006; Tue, 5 Jan 2021
 11:49:16 +0000
Subject: Re: [PATCH] drm/ttm: Remove pinned bos from LRU in
 ttm_bo_move_to_lru_tail()
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
To:     Lyude Paul <lyude@redhat.com>, dri-devel@lists.freedesktop.org
Cc:     Dave Airlie <airlied@redhat.com>, Huang Rui <ray.huang@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20210104231358.154521-1-lyude@redhat.com>
 <cc501d40-fdae-93a8-394a-4db840b9b0ef@amd.com>
Message-ID: <b32bcd58-cd3e-5545-83c1-acb9f5973d48@amd.com>
Date:   Tue, 5 Jan 2021 12:49:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <cc501d40-fdae-93a8-394a-4db840b9b0ef@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-ClientProxiedBy: AM4PR07CA0016.eurprd07.prod.outlook.com
 (2603:10a6:205:1::29) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7] (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by AM4PR07CA0016.eurprd07.prod.outlook.com (2603:10a6:205:1::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.4 via Frontend Transport; Tue, 5 Jan 2021 11:49:14 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: fe8c17fd-f1d1-4daa-01d5-08d8b16fedd5
X-MS-TrafficTypeDiagnostic: MN2PR12MB4551:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4551C70A4A957ED56F53CB0B83D10@MN2PR12MB4551.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sn6v5V3010YgqyYT7t4huzpTERsVs4y7HSzW598P/CtcC8SCtX742ApjE2iQXQd06Op3Pu3D4G9jCHuQR19qlmPHZ3FGELinG55DBJfA4Wt1xjs8GUl6ieqwnvVa/WHSsZeziM0o5yQsFi8DI2jf1jNidL/+86m5ZZPBeQoB7h5wck8rPJsKq+Do/F/QOYwLA72+mTGch5e/CxOhSLclpIs1WojGpZQ7//Ya/hR119kVO52HncREfosNHYvqbXfi0n9ZmrYhTCPgg2KPmJGte8Ldq/kztLzDzE0PAYe6a5JD9IRU5/P3XmMoDEbaMQ+6LG5axyGV5CqbSwdMVm3x9V/xtZrjelqzJ8UV3g9DLWQ8hsAmmHTIGI2pUHgQlZaCiVA3kHMSGtVVMXmJlrzufQ/3/oxoL6djr9r+Yc9YK/O3CYjeTUpF521r3KL68kIdV1cNirxk7g+llWr9rStF8qOUc5wKocwjYOq8RC0K8zk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3775.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(346002)(136003)(39860400002)(366004)(5660300002)(6666004)(8936002)(52116002)(31686004)(316002)(8676002)(16526019)(66946007)(36756003)(2616005)(2906002)(186003)(478600001)(66476007)(66556008)(6486002)(54906003)(4326008)(66574015)(86362001)(31696002)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?QUhjNDM1NkVVR2cxRmVDT1VRNnFySGNYSUZpMHRwVmNXQmd1YTh0eXNnTFlD?=
 =?utf-8?B?U0VpdXNnd2JjN2hoVnhiK3kxcndWMkkvVDd4Y3BqT2hZeWhWSTg4UWZLdjlq?=
 =?utf-8?B?YThnU0NNNS9NMUROc1JHSk1qcmhLYjdjYmVKRXRoUlZDeEcxTTVMZmY4RDdR?=
 =?utf-8?B?eDBhTk9BdU1HRmxCQ3RQWkI2U1g1aFlVdnhIRmVjZlR1SEJtdy9mK3dySkhQ?=
 =?utf-8?B?dWQvYmUxWkNWZXhyenF2NEFPNVBoNFJXbDdmekVwRnNlS3lzNXh4My9DK0tz?=
 =?utf-8?B?UUVtU0Rhdyt6UVZVU28vRUZ3N2pMdXgwdlJnQ2lLUThLZGhXY24vdEJOUk5k?=
 =?utf-8?B?NXdwT2xRbEVQSGI0OGtuaU15ZHpSc3psSmlPZmg0R0Q3VjQ2ODZGZEdkaXgr?=
 =?utf-8?B?aXFsVVB6ZmJIa2Uwakg5bjFrS3FhQ0RFQVVyWmRidll1d2hvUDYyaU9nZUI4?=
 =?utf-8?B?dXFvSEFmQnNET0NpOThUd3crN09kRGJkaVI0WE1nTEd4Uys3eXllRlZUdDdK?=
 =?utf-8?B?UVB6Qk1mWTJBM3o4Q1phb2Vmc0hzYlZ2RndMMlM4R1FEZkNSdHg4ejV1b0tz?=
 =?utf-8?B?S3NicllpZi8ySkxRMXVtSElpRkZNNXBSRzMyS1RLZ0NRVEV3L1N6bERRU20r?=
 =?utf-8?B?ZjRhUkJsdTg0d2ZPem1QTTZBSEFYR2NIdVF3OVNRaTZtelp5SnhFZ3ltNERK?=
 =?utf-8?B?eFR2TEpvKzFlTUdJMnIwRkNUNHplYkxJZHRDVkpTREY1V01UeDJ2ZUhaT25F?=
 =?utf-8?B?MDE1ZHVscXJUZkIrVGlHTm5QRDFQY0tYU1BTODBSSGgwK044U01COHBtVUZU?=
 =?utf-8?B?aHdMaHRzaEZnRm5GUXdwRFBjWk5PbEtOOS8vNStiaWJpeGVvcm1VNWkzN3g3?=
 =?utf-8?B?TVZBanl1ZVN1UGhVNm44b21pWlB4UmxuSVoyWThBM2NIVU5aQklSc0JNMVNW?=
 =?utf-8?B?VGoxQTdkdHJmL0lIQ01SdzFDL3dXWXdrMXg4eFNjbWp1aGpsZ1N3R3JlQk9Y?=
 =?utf-8?B?Nk9BRG40bjVlZzZyNmV6QUp0UTJBbjNwdHFiVlZRa1lWNmNDc1ZNTlpNL3hS?=
 =?utf-8?B?VmhMa3ozUVVwYWFNVk05dU1GUlE4WGxQQkRkaTBMUjRXanBlRzBMQnFydVhx?=
 =?utf-8?B?SG81ZXVWY0VWNjMzY25TZk9MM2ZxT3lGWU5senk0S21YdjRlUUc3Z2dpTXd2?=
 =?utf-8?B?OTlsSGlIemhzTkE3OUt1cVg2bkwwZU8vMHNLWXlCMXhEeGpScVRXdmNrVCsz?=
 =?utf-8?B?T0xkeGNuTHU3UXd6VFJGUGhLMThySkc0WWZxbkJvSmJFOEFGOFE1bVpzM09t?=
 =?utf-8?B?VnhpMWFXci9qR05sWFYzNnZRSENmbWNOdURuMVVpcVBqNStSYm1hMXEwWHRJ?=
 =?utf-8?B?RW9LNlRqd2hlbjlDbFpjN0M1K2tFeXFFSklCa1hsM09LYVBrQk0ybkNSRlhr?=
 =?utf-8?Q?2/HDhrpN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2021 11:49:16.1681
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: fe8c17fd-f1d1-4daa-01d5-08d8b16fedd5
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I7brQZptETP8L9dr4QNxoOFjyNi91YWwQDAxHg62npBXkf+URkTuVfkDGimNXT8P
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4551
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 04.01.21 um 22:06 schrieb Christian König:
> Am 05.01.21 um 00:13 schrieb Lyude Paul:
>> Recently a regression was introduced which caused TTM's buffer 
>> eviction to
>> attempt to evict already-pinned BOs, causing issues with buffer eviction
>> under memory pressure along with suspend/resume:
>>
>>    nouveau 0000:1f:00.0: DRM: evicting buffers...
>>    nouveau 0000:1f:00.0: DRM: Moving pinned object 00000000c428c3ff!
>>    nouveau 0000:1f:00.0: fifo: fault 00 [READ] at 0000000000200000 
>> engine 04
>>    [BAR1] client 07 [HUB/HOST_CPU] reason 02 [PTE] on channel -1 
>> [00ffeaa000
>>    unknown]
>>    nouveau 0000:1f:00.0: fifo: DROPPED_MMU_FAULT 00001000
>>    nouveau 0000:1f:00.0: fifo: fault 01 [WRITE] at 0000000000020000 
>> engine
>>    0c [HOST6] client 07 [HUB/HOST_CPU] reason 02 [PTE] on channel 1
>>    [00ffb28000 DRM]
>>    nouveau 0000:1f:00.0: fifo: channel 1: killed
>>    nouveau 0000:1f:00.0: fifo: runlist 0: scheduled for recovery
>>    [TTM] Buffer eviction failed
>>    nouveau 0000:1f:00.0: DRM: waiting for kernel channels to go idle...
>>    nouveau 0000:1f:00.0: DRM: failed to idle channel 1 [DRM]
>>    nouveau 0000:1f:00.0: DRM: resuming display...
>>
>> After some bisection and investigation, it appears this resulted from 
>> the
>> recent changes to ttm_bo_move_to_lru_tail(). Previously when a buffer 
>> was
>> pinned, the buffer would be removed from the LRU once ttm_bo_unreserve
>> to maintain the LRU list when pinning or unpinning BOs. However, since:
>>
>> commit 3d1a88e1051f ("drm/ttm: cleanup LRU handling further")
>>
>> We've been exiting from ttm_bo_move_to_lru_tail() at the very 
>> beginning of
>> the function if the bo we're looking at is pinned, resulting in the 
>> pinned
>> BO never getting removed from the lru and as a result - causing 
>> issues when
>> it eventually becomes time for eviction.
>>
>> So, let's fix this by calling ttm_bo_del_from_lru() from
>> ttm_bo_move_to_lru_tail() in the event that we're dealing with a pinned
>> buffer.

>> As well, add back the hunks in ttm_bo_del_from_lru() that were
>> removed which checked whether we want to call
>> bdev->driver->del_from_lru_notify() or not. We do this last part to 
>> avoid
>> calling the hook when the bo in question was already removed from the 
>> LRU.

It turned out that this is not correct, we always want to call the 
callback whenever we would move the BO on the LRU.

I've modified the patch and send it out once more, please review.

Thanks,
Christian.

>>
>> Signed-off-by: Lyude Paul <lyude@redhat.com>
>> Fixes: 3d1a88e1051f ("drm/ttm: cleanup LRU handling further")
>> Cc: Christian König <christian.koenig@amd.com>
>> Cc: Dave Airlie <airlied@redhat.com>
>
> I was already working on a fix as well, but you have been faster than 
> me :)
>
> Reviewed-by: Christian König <christian.koenig@amd.com>
>
> Going to pick this up for drm-misc-next or drm-misc-fixes in a few 
> minutes.
>
> Thanks,
> Christian.
>
>> ---
>>   drivers/gpu/drm/ttm/ttm_bo.c | 20 ++++++++++++++++----
>>   1 file changed, 16 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
>> index 31e8b3da5563..0f373b78e7fa 100644
>> --- a/drivers/gpu/drm/ttm/ttm_bo.c
>> +++ b/drivers/gpu/drm/ttm/ttm_bo.c
>> @@ -113,11 +113,18 @@ static struct kobj_type ttm_bo_glob_kobj_type  = {
>>   static void ttm_bo_del_from_lru(struct ttm_buffer_object *bo)
>>   {
>>       struct ttm_bo_device *bdev = bo->bdev;
>> +    bool notify = false;
>>   -    list_del_init(&bo->swap);
>> -    list_del_init(&bo->lru);
>> +    if (!list_empty(&bo->swap)) {
>> +        notify = true;
>> +        list_del_init(&bo->swap);
>> +    }
>> +    if (!list_empty(&bo->lru)) {
>> +        notify = true;
>> +        list_del_init(&bo->lru);
>> +    }
>>   -    if (bdev->driver->del_from_lru_notify)
>> +    if (notify && bdev->driver->del_from_lru_notify)
>>           bdev->driver->del_from_lru_notify(bo);
>>   }
>>   @@ -138,8 +145,13 @@ void ttm_bo_move_to_lru_tail(struct 
>> ttm_buffer_object *bo,
>>         dma_resv_assert_held(bo->base.resv);
>>   -    if (bo->pin_count)
>> +    /* Pinned bos will have been added to the LRU before they were 
>> pinned, so make sure we
>> +     * always remove them here
>> +     */
>> +    if (bo->pin_count) {
>> +        ttm_bo_del_from_lru(bo);
>>           return;
>> +    }
>>         man = ttm_manager_type(bdev, mem->mem_type);
>>       list_move_tail(&bo->lru, &man->lru[bo->priority]);
>

