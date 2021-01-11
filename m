Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 488062F20A8
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 21:23:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404177AbhAKUWv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 15:22:51 -0500
Received: from mail-dm6nam11on2041.outbound.protection.outlook.com ([40.107.223.41]:41729
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730389AbhAKUWu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 15:22:50 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XFXu7dbzcsv24cD7foaaTIKJojTsuTnnfElw6B8lxG7xRHj/NPYRq9nUfRve2tqlxbWSiRTNV9W390O/8VoQPbNTFgqxF6A5MPBB/Jw/rOy3IgSEtZJKRkep3XxAt8hPcwAbnTlG59/r5g+Tv/b02UbnRkKlxMakMW3wro6yKsSOBZZlT8URN/K7ZgZVi4XgszM/IPA56pgLStxh5AOBpAWqUAnwjgYH0oQ9IZMPjgyXMJuSSPuP9UVZoLrnPdW4X0F1xLpBLPfVT9F2E3mULh4eRcO8SJBiWsMDPB03vQohni0b/gEgoRad5GW7v/4sLhlRh9PpWVhe4TESWC3MYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uLzLrId7+zXYbTei2oKGmvYpn9Z0oKMUUx0xUzEqLS8=;
 b=RIPA0ABVMmwRMMWYx+WcdW2RDUMTYKwymyNhU/whisF4nTGoP+/2REelwztbVFX0uxZfd7GNk4IWXH0Fw7Xrkt94MDG1YvPLUJ12Ocw8bqjjjXkYCSXGOb+umj+Gn+pYaI1oJPM7SwghbAsyeUrRv4xsqhAn2Xljo1W70Qf2vhYk/aMol6tmPvPFwIcDaS5ZQ1NZyerMwFabugfFpAsrqV8vlEfxegSjzAMi9UXs5S4Wwetzu0tkakZFQ6li9wJrL4JBVdU4bNElyUbAS7UdGSTGOQdKQM/7SpMwRZH4ImYd7LkpBTteibXP+fFiZ+qGCG+tqWB7Sa02oXaRT8+y/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uLzLrId7+zXYbTei2oKGmvYpn9Z0oKMUUx0xUzEqLS8=;
 b=LeIwunWdfTBwMKtt9WedTH0ymtiwfC860LeTcfqCbWNtoQXgeFT6k9BD6i/cAIV7AOQewQEr3zt9sLgXwzp4FbfRXZ31KAUvaiSRapy7IvEq1OcLnIbhV1N1OnkkUiRemBerd3+RVE85UzuQVs4HiS/TviMHqSN0PadkJYjhMOk=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB3903.namprd12.prod.outlook.com (2603:10b6:208:15a::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.9; Mon, 11 Jan
 2021 20:21:56 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::44f:9f01:ece7:f0e5]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::44f:9f01:ece7:f0e5%3]) with mapi id 15.20.3742.012; Mon, 11 Jan 2021
 20:21:56 +0000
Subject: Re: [PATCH] drm/ttm: Fix address passed to dma_mapping_error() in
 ttm_pool_map()
To:     Jeremy Cline <jcline@redhat.com>, Huang Rui <ray.huang@amd.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20210111164033.695968-1-jcline@redhat.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <cbd76108-a7c4-119b-b045-eb857a84fcab@amd.com>
Date:   Mon, 11 Jan 2021 21:21:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20210111164033.695968-1-jcline@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-ClientProxiedBy: AM0PR02CA0183.eurprd02.prod.outlook.com
 (2603:10a6:20b:28e::20) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7] (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by AM0PR02CA0183.eurprd02.prod.outlook.com (2603:10a6:20b:28e::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6 via Frontend Transport; Mon, 11 Jan 2021 20:21:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9f84e6fc-a851-4d3d-c841-08d8b66e8b08
X-MS-TrafficTypeDiagnostic: MN2PR12MB3903:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB39031417316EF9EFA75F300F83AB0@MN2PR12MB3903.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Tq46JlGRnvUJA7Lh3C8VujpIyb9Qi6Lb0LjOK2fXw1mPAD+CTR4PUeN8qnGitOrfr0FbMGUvFcIl0SMD3fwKywNxPH6GQMwfZSeYFO8mJmjaWy864dwBkwIcQG97Di9ECf2WFWL8vIlzAJ+kf44Y9EP/Ql4Y5teJSR/bCIVFdR3J4uTZLG19CrWlLqak6C7wIMaki2wm9uZ2WLMgQ3CKLSN9h+nwd1XzGUBiLtz6t/6sWYqeSesdTEZCHhjtALApXjQ00VFNl0KywLdKrzLsMqv6E7WLRqlpc2Nk+hrpCBmz4yaL++ciOuwSjVGPRgczaQ9/WxLL2xIke3753aXJZHgB6DfxwMvkx9bGg1JtO9LzTDVzFsZKZtFX4kBhp7gVs7BNrNL28f/462wDdoSqI0W34xHipMbY9E9vPlIZ82stbd30F/D3Le4SpIJxQFd9qV2Lm986WA8UZMjMXrwVUGkMd37xdb/BvLbq1LpmCRc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3775.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(376002)(136003)(39860400002)(366004)(52116002)(6666004)(31696002)(66556008)(86362001)(66476007)(6486002)(16526019)(186003)(2906002)(110136005)(8676002)(66946007)(316002)(31686004)(54906003)(5660300002)(36756003)(478600001)(6636002)(2616005)(4326008)(8936002)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?Z1pBdlJvUFo1RGQzME1tUWZEZ3V3VkRnNGJwa2ttMlpPWWtnR3hZZ0RBQisw?=
 =?utf-8?B?YzN5VTRhcC9NZXdFa0g5SW91TW0zc3Ayb3ZKMm44bjBUbk9pdEhhVGQzdmFC?=
 =?utf-8?B?ekZNNjRjbW9wcDlOL0RmREt6L3Q2QXB2d0NkL0NxaEFhaHlMRC84S3FTc0gr?=
 =?utf-8?B?bVBjam5kYmNKQVdJTDF3MVBaTjBxQ0RSKy9mOWtlNk5LOWd1WTlSaW5lQmg0?=
 =?utf-8?B?UFB3MDlXU3prTkNCSDdIY3NZaWwxQkx6OXo4TDhzVllMMHlYN2Y0M01VaHN3?=
 =?utf-8?B?TlJXSHR0UmJDWWdOeC9vbE9TQi9GOE9yUDdKcFdGdzlTZ1g2RUZLRDd4M1ZB?=
 =?utf-8?B?Y3JuZ0pWRVlLMHZER21STjd6OUJabldUcWJPc3BnUHlSeUZ1SUNyalZNSGF2?=
 =?utf-8?B?UE9hRE95eXYxL2lRc01MbXdSeGp6NkhobjQrK0ZCVWYrQ0hvcHpLOCtXZEc4?=
 =?utf-8?B?S2pnb2R2Y0NWQ0JPcEJqZm90RWxpRThWdzNlNmxFRnRxYzVTdWhaMlVlU3FX?=
 =?utf-8?B?eDFSQjhTVTFWRmZiekNHMlFuNmN6M2FpL3FtY3h1c2RUa0FRVWFsdzZKejNZ?=
 =?utf-8?B?MFd0Z3BMVzFIR3E4dnRqcTZWQU5ONWUyQzdiMFQyMk1Ua2dSdy9QUHpVTWN6?=
 =?utf-8?B?WmZPT1BJTWkyRG8vQ3gyTEVNVUFpOHpDTStlY04xV3g4RURmVDAwZzEwM2lR?=
 =?utf-8?B?ZXNiYjY0TjVVb2doMTRPMUxjai8vTmVqYkp6QXVnYTk5YUlFNTlNSU8rQWpO?=
 =?utf-8?B?d2gxOHRJcmorQ0Y5WE1PV1o4MTdKTGc0L0gvSkhiVTNTTVhWcHg4ZHpNR1lS?=
 =?utf-8?B?d0h0VDJ2Tk5aMjZRVVp4cHdjc0pia1dSbnpyZnEwdTdvNkFsVmRxVEJtUHpM?=
 =?utf-8?B?aDl4U2dJTVVZWGRRYVRRU0RpcURJK2dCRVpzKzc0cThFT1B4MkxhUHBsVERI?=
 =?utf-8?B?NEFYRGpjc3d1MUZFWHhUTzBhSXhpZ0NCdHcrb3FGSXlObi9vaWswMDV0VmlO?=
 =?utf-8?B?eXhZdzZwQis0a1puYy80dkpkTXZSZUpoWG5iY1R2YUg3OVZPS0NHektaL09D?=
 =?utf-8?B?cUNmR0huWVc4anV2bWVUcEVFcGVzNUpBekdIUlVtQVQvclorYkkyMjI5OEN4?=
 =?utf-8?B?bU1lbnpqbXpLUWo4cU9Td2tldFJHcHVieWpBT1FDRE1pazNSK1l6ZG9jWUNz?=
 =?utf-8?B?WHdMQWJ0c2xMSzJsdFR6UjB1ZE9pV2sra09ocWVrSTgzUXFEcW9WZ0FvWUMx?=
 =?utf-8?B?eHZrbVpqa2U3UkpadTNhREh1dlREckJQcFBjdEpNVVR3TFc3VmZZY1VkejVM?=
 =?utf-8?B?N2h0TlNEVWxWbUhub29RMTVjSnM3SGtvYW93TWFmaVE0SFBlcm9VakdtK2Vx?=
 =?utf-8?B?VmoxaWRlOVBSQTAwU1h0TjVBZWlnZ3ArVkJyRFFkUHFCeEp1NWtXMkp3ZUhv?=
 =?utf-8?Q?t22vRpJn?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2021 20:21:56.7242
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f84e6fc-a851-4d3d-c841-08d8b66e8b08
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oSJUW0Y/2VE4LkeQ7YomMlUZ/d6P1e++Z/2bM3brBBR2MXEcaBN5DA2Ju0lHL1wQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3903
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 11.01.21 um 17:40 schrieb Jeremy Cline:
> check_unmap() is producing a warning about a missing map error check.
> The return value from dma_map_page() should be checked for an error, not
> the caller-provided dma_addr.
>
> Fixes: d099fc8f540a ("drm/ttm: new TT backend allocation pool v3")
> Signed-off-by: Jeremy Cline <jcline@redhat.com>

Good catch. Reviewed and pushed to drm-misc-fixes, should be in the -rc 
by the weekend.

Thanks for the help,
Christian.

> ---
>   drivers/gpu/drm/ttm/ttm_pool.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/ttm/ttm_pool.c b/drivers/gpu/drm/ttm/ttm_pool.c
> index 7b2f60616750..0aa197204b08 100644
> --- a/drivers/gpu/drm/ttm/ttm_pool.c
> +++ b/drivers/gpu/drm/ttm/ttm_pool.c
> @@ -190,7 +190,7 @@ static int ttm_pool_map(struct ttm_pool *pool, unsigned int order,
>   		size_t size = (1ULL << order) * PAGE_SIZE;
>   
>   		addr = dma_map_page(pool->dev, p, 0, size, DMA_BIDIRECTIONAL);
> -		if (dma_mapping_error(pool->dev, **dma_addr))
> +		if (dma_mapping_error(pool->dev, addr))
>   			return -EFAULT;
>   	}
>   

