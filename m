Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 372692EA637
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 09:01:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727328AbhAEIAN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 03:00:13 -0500
Received: from mail-dm6nam10on2073.outbound.protection.outlook.com ([40.107.93.73]:58176
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726889AbhAEIAM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 03:00:12 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TbUyPlH08agLSQVHEb6HpS/73WSaTXRDgD4u19eduOHgC101i/s/S+stCgoWoq6Vtlr12cpIzbAdb1tkiz7Kxsns/7btQTnfvzLtmJua7fA3Hg09Gagjxw+9kontsCdbBrZlw7t+cnofCUmV6nL8R4/CeynldTvebvPvnk0enzUGQyMtCNeGhb6XX7LQwU9npC1QHkrILLhCq3/zgBr+nJT+BlEKXi6AkwZxWaxDuXhKX96cyApOF/f6hrMdfEKwu7f2xavke19yzktA/vpIENURe9ThYFWqpgzuaV53e0JSwSG3TFMkx11R1xDQYEKvDrA9vAsGhsFT4YfHzvTHDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J04Tq740hyw9IOWX4Y/JvoxwVx4kK250yC/Ar+A1OGw=;
 b=dw7isscjKtGeLF0y0eolKOqkMVsjBecm3nWBx75SIupUpXULbeC2HN8U+FHqvCBtuJkZJeHoti3qqXfyJKo7Tt5t4CFtRPjvpd7Y1tRcbcqIOYeE3RCFESFJdYEkA/DBVDdjVLFk8mLybKdK7AmkP+MvZvcQTpU7JiZycnpHXaxVOOXA869PlbuIcFZ9d9s6JFrBL8lcNb5MMqLU8jRiJVWaWBX9iuiDk09OIUhvQTPwDf5+QF5l0/XNI12tSWxoFmkLA8lpBqQhWrglgbUubRVCE5HJzbFt0aGUNGZV9zAq1MGT9W6NGBnJOpi+OBmGZztw1Oiem9ERIkUj3FBhoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J04Tq740hyw9IOWX4Y/JvoxwVx4kK250yC/Ar+A1OGw=;
 b=TDjga3Tv8AhHq2ms8TBYYcnenasTaglM715GlG37y/rLWUZnTgkIH/UeHH31aoB4FOKf6MkWNZs0jX7zQfe9Z+BKo9j7MaASdGs9ntvGCSQnL862CYylZtcGe5mQ1H8VyaeoxDez90HgNvJrJn2mxaYmmJkx65OYpMe4rrnBnm4=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4157.namprd12.prod.outlook.com (2603:10b6:208:1db::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3721.21; Tue, 5 Jan
 2021 07:59:19 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::44f:9f01:ece7:f0e5]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::44f:9f01:ece7:f0e5%3]) with mapi id 15.20.3721.024; Tue, 5 Jan 2021
 07:59:18 +0000
Subject: Re: [PATCH] drm/ttm: Remove pinned bos from LRU in
 ttm_bo_move_to_lru_tail()
To:     Lyude Paul <lyude@redhat.com>, dri-devel@lists.freedesktop.org
Cc:     Dave Airlie <airlied@redhat.com>, Huang Rui <ray.huang@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20210104231358.154521-1-lyude@redhat.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <cc501d40-fdae-93a8-394a-4db840b9b0ef@amd.com>
Date:   Mon, 4 Jan 2021 22:06:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20210104231358.154521-1-lyude@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-ClientProxiedBy: AM0PR01CA0085.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:10e::26) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7] (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by AM0PR01CA0085.eurprd01.prod.exchangelabs.com (2603:10a6:208:10e::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3721.19 via Frontend Transport; Tue, 5 Jan 2021 07:59:17 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 50b4e6c2-c262-42aa-b531-08d8b14fce00
X-MS-TrafficTypeDiagnostic: MN2PR12MB4157:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB41574411E82622F912A8A6B883D10@MN2PR12MB4157.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rbwl6SykyX9P0sbsJ9T5dwk0pTy3Ly7D86kwkN0RH2IcPksbJ+f1G1EqWHbg4MgTXNF1BfGe/yFP++cWVQrSfjOdOtTWkO8D/56mZL6CPZlMsYQ08pUhCvJKcE1QRAb0HErX/KLW8wfBBV2modxrwCb0lf9lcdkoybcYhmINCviUFNLlIg6BOnZho5VzZBj6dJ5P3PYCVuaUE7hSbXqA3KDlwgdjdlzb64XWvnB3jctsF8D9F8eYsKZgwgLj00VAXihfF8CmwrfYsHpMSMBovp/uxUPPeha9T6bkWelqGtsJrcJWQWORmXB44peVQ8WPMDGQJ9rrhR1Awfbk62QkSrIHvPiShjS6m5KfeEH7VPiwGAGFjJ2aifMiarlYqfAR8be9kt1nXPWr0wXM0auZ4E5n6E/HRPvHNg5XnuzWPoo3pDyi1Cw0lYAk7z/VDr2b
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3775.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(39860400002)(396003)(366004)(376002)(6666004)(66946007)(478600001)(5660300002)(66574015)(52116002)(66476007)(8936002)(66556008)(8676002)(31686004)(2906002)(83380400001)(86362001)(2616005)(36756003)(6486002)(16526019)(186003)(316002)(4326008)(54906003)(31696002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?Nmt0U091ZGE0dXpvVHhVNjJHcjlSV1hqR2Ntc0JnV2owV0lqS2g4MHQ5V2tI?=
 =?utf-8?B?WXlIMmY0ZzMwejBnTm4wcUVXN0NzS2tnWjltTlRqZFNlQXdjb3FsKzlLL1U5?=
 =?utf-8?B?LzVUWnhMcUF6S2RvSld6MUpJckpxRHVhR3c5OWRDeWtQc0c3Zk41S1grUWtM?=
 =?utf-8?B?SUM1MlZ3QVRhZVdPUnVRbzVJcVhNSzdCOW5GU3UvYWtMVDlWbEkvWERqL056?=
 =?utf-8?B?eS9hRTBWbENTejJ0V1Q0TDNwYmNkVzR3NnhqQ1ZHZzFhM0hZcTdzWXlhY0dV?=
 =?utf-8?B?UzdFS0VncGZvbldUVFUrc3VkclRxeVlHRy84NE40UXFTS3RJbVpidlNjaVNh?=
 =?utf-8?B?UzloNGo4MG5wcmV6NGphSG0ydHVXNGxmZjlkejM2UjJDaHR3bHRlZXNlazYy?=
 =?utf-8?B?d215a2d0QUs5M0daYmtqRVJES1VlRUl2VGVZUDhzWnZKZ2FYMit2YzhRKzNY?=
 =?utf-8?B?VElMRzRRRW42Z1VnR25OMU9VVklhYU9kZFd1WTlnRWJSNFMwL0IxV2wzOWIr?=
 =?utf-8?B?U2NTTTJldXNsSHRyNFc2WXFrSWUwMWVISlhwa3FVZDNVVGVwdEF1c29TVWV1?=
 =?utf-8?B?SHlwTTkvZHlCeHBRRFJKSkxCekJoUWd3NnFRbFdnTHc5dXlsdStqUEY4U0da?=
 =?utf-8?B?Y3llNlBwUVIyKzB6bVRtN0F6KzVLUDJlaWM1Mm1hZzQzV3dDSEJyQWtlNVBi?=
 =?utf-8?B?bzR3U3YrUXkzQy9TMHEwbHpsZjhvSGszUnlLVHJRdFI4dUxSbUoxZXUzTExu?=
 =?utf-8?B?OWVqVlZqTXpvakNXK1krYzNyTmNXWWdIc21ZVm9qYWhIem4zQnRFSWF5MkNa?=
 =?utf-8?B?VGRPaktvZm9wdUh2ZmNxZTZ4N2pnZWptOFRlQitJSWxDYWNtRURiN01DT2Z4?=
 =?utf-8?B?ZEh0dkt4V0ppUzFBTSttS2tTc3pDbWhacWdSOHNZc3k4U3lZSEpVWjllWURM?=
 =?utf-8?B?U3RnK1EwYmVYTmVCQmppWlJhQ0lJL1krekh2VVZDSkZYK0tsTXp5VE9qY3I1?=
 =?utf-8?B?bVNUSTdMdFdSQUd0SllGL3JHL1Vtbitzay9ManBVbWQxOHVRN1pjaVN5WDFa?=
 =?utf-8?B?bXlGQktQNGlWajRSelRHNVN5THk0d2d4VjRDTEpETS92MlRLWVk3eVJOdGdv?=
 =?utf-8?B?UGlES0d1QTNHWE9iWGFTSE9pNHRFSC9LV3RRUkd5bzBTb09rU3JGclV0Ry9H?=
 =?utf-8?B?UGluVERvbi9qaWxFNUpra3dWdU5ZUkRLMENmNkVjQ0RDd0JSMWszaWNuNGJz?=
 =?utf-8?B?cmc3VTROVTdHOVlTQVpzU1Q2bER3Z2xWdTZ6bUhCblQzemk4WG5YOXM4V3B5?=
 =?utf-8?B?WkFLdm94Wk9jWUtibzBmc2kybDlhWE1YZ0VSaUFkd0RodkxXWXdzWkVSeENM?=
 =?utf-8?B?YjZhN2Z5eHdpNTc0byt4Mit1Zk1YYVcrMWJtV0wvV0pxQ3NqdkRETXYwZDlM?=
 =?utf-8?Q?twvC75Mt?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2021 07:59:18.7352
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: 50b4e6c2-c262-42aa-b531-08d8b14fce00
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1ycbrDim5LQEG+Jb2N+dYGXPfCTdnPgzEgcf1BLNrxlnQQL5u2YQqygA4TkJGUjc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4157
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 05.01.21 um 00:13 schrieb Lyude Paul:
> Recently a regression was introduced which caused TTM's buffer eviction to
> attempt to evict already-pinned BOs, causing issues with buffer eviction
> under memory pressure along with suspend/resume:
>
>    nouveau 0000:1f:00.0: DRM: evicting buffers...
>    nouveau 0000:1f:00.0: DRM: Moving pinned object 00000000c428c3ff!
>    nouveau 0000:1f:00.0: fifo: fault 00 [READ] at 0000000000200000 engine 04
>    [BAR1] client 07 [HUB/HOST_CPU] reason 02 [PTE] on channel -1 [00ffeaa000
>    unknown]
>    nouveau 0000:1f:00.0: fifo: DROPPED_MMU_FAULT 00001000
>    nouveau 0000:1f:00.0: fifo: fault 01 [WRITE] at 0000000000020000 engine
>    0c [HOST6] client 07 [HUB/HOST_CPU] reason 02 [PTE] on channel 1
>    [00ffb28000 DRM]
>    nouveau 0000:1f:00.0: fifo: channel 1: killed
>    nouveau 0000:1f:00.0: fifo: runlist 0: scheduled for recovery
>    [TTM] Buffer eviction failed
>    nouveau 0000:1f:00.0: DRM: waiting for kernel channels to go idle...
>    nouveau 0000:1f:00.0: DRM: failed to idle channel 1 [DRM]
>    nouveau 0000:1f:00.0: DRM: resuming display...
>
> After some bisection and investigation, it appears this resulted from the
> recent changes to ttm_bo_move_to_lru_tail(). Previously when a buffer was
> pinned, the buffer would be removed from the LRU once ttm_bo_unreserve
> to maintain the LRU list when pinning or unpinning BOs. However, since:
>
> commit 3d1a88e1051f ("drm/ttm: cleanup LRU handling further")
>
> We've been exiting from ttm_bo_move_to_lru_tail() at the very beginning of
> the function if the bo we're looking at is pinned, resulting in the pinned
> BO never getting removed from the lru and as a result - causing issues when
> it eventually becomes time for eviction.
>
> So, let's fix this by calling ttm_bo_del_from_lru() from
> ttm_bo_move_to_lru_tail() in the event that we're dealing with a pinned
> buffer. As well, add back the hunks in ttm_bo_del_from_lru() that were
> removed which checked whether we want to call
> bdev->driver->del_from_lru_notify() or not. We do this last part to avoid
> calling the hook when the bo in question was already removed from the LRU.
>
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> Fixes: 3d1a88e1051f ("drm/ttm: cleanup LRU handling further")
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Dave Airlie <airlied@redhat.com>

I was already working on a fix as well, but you have been faster than me :)

Reviewed-by: Christian König <christian.koenig@amd.com>

Going to pick this up for drm-misc-next or drm-misc-fixes in a few minutes.

Thanks,
Christian.

> ---
>   drivers/gpu/drm/ttm/ttm_bo.c | 20 ++++++++++++++++----
>   1 file changed, 16 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
> index 31e8b3da5563..0f373b78e7fa 100644
> --- a/drivers/gpu/drm/ttm/ttm_bo.c
> +++ b/drivers/gpu/drm/ttm/ttm_bo.c
> @@ -113,11 +113,18 @@ static struct kobj_type ttm_bo_glob_kobj_type  = {
>   static void ttm_bo_del_from_lru(struct ttm_buffer_object *bo)
>   {
>   	struct ttm_bo_device *bdev = bo->bdev;
> +	bool notify = false;
>   
> -	list_del_init(&bo->swap);
> -	list_del_init(&bo->lru);
> +	if (!list_empty(&bo->swap)) {
> +		notify = true;
> +		list_del_init(&bo->swap);
> +	}
> +	if (!list_empty(&bo->lru)) {
> +		notify = true;
> +		list_del_init(&bo->lru);
> +	}
>   
> -	if (bdev->driver->del_from_lru_notify)
> +	if (notify && bdev->driver->del_from_lru_notify)
>   		bdev->driver->del_from_lru_notify(bo);
>   }
>   
> @@ -138,8 +145,13 @@ void ttm_bo_move_to_lru_tail(struct ttm_buffer_object *bo,
>   
>   	dma_resv_assert_held(bo->base.resv);
>   
> -	if (bo->pin_count)
> +	/* Pinned bos will have been added to the LRU before they were pinned, so make sure we
> +	 * always remove them here
> +	 */
> +	if (bo->pin_count) {
> +		ttm_bo_del_from_lru(bo);
>   		return;
> +	}
>   
>   	man = ttm_manager_type(bdev, mem->mem_type);
>   	list_move_tail(&bo->lru, &man->lru[bo->priority]);

