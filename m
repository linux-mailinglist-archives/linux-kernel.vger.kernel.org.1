Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DA2326CD0E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 22:53:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbgIPUxD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 16:53:03 -0400
Received: from mail-bn8nam12on2043.outbound.protection.outlook.com ([40.107.237.43]:4960
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726608AbgIPQyN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 12:54:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R5uXD5gloheWGvZ7mIrq9hZi/un9U/UekFRPn5JgEV/MZHLObCHTHcm7kieuNDvlikSHZ+47WUH1VwETtziKEyoiGxTVYP8joxLEQTC9LMi9kis72YSuX3a4y+6mB8pWLxEjf+8Lc24E/x0O2NZIKOoHfzm+mktw86iAWP+a//TLXw1KEZeFYP010npeV3NSSPOhCu7otkeObewMwmpduWxFV1pxAYHY3M6ub/n6vDIRCVOH1v42T/mW/1/EkohCNwClctt5EItUARWN9JLhuHfgiP72Pje54j34Pgkqgn+H8h6J9IWOupkU9EMuJDzS2UASOpBmrroJhLYnYqjEBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h6i4M3Y98dT/bIFGmBVsAJ2ZCrfwrHbqEANpbxHP12M=;
 b=arvRfW9Uo8LsInmV6ZHeenuoDednJMmp7A+joZ5zTNSUnfyar9QVSpYPwgC3AsKC9A7+IUx2OuZAcjOTJtdXTMsQUkZIk0XSnkVqNiaP4Jt6YMuL/Ql8tCdXANvVGu0BliGwPJzSsLS/MSme45vLmfMoO1348VuktxIdffSwRd05FuS/Ut5/2jg9zoUENV5CAx1j2XWDU0sPBgN+M0jaMx+f/3LZUYQlj+QB1M89PcT6XnWQEjLXfFZNH1TAIIGwPtehnUSIzk8Cz8ZT3w1MKhO4E2XGQ0+SByZ4ccP2AM4s2IaBOPRc064gmLtVPTYbvfSmSdGZrWay6Qcub32rJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h6i4M3Y98dT/bIFGmBVsAJ2ZCrfwrHbqEANpbxHP12M=;
 b=lQNKsq04zLjF8omVe9UPXJ5HaLA6L+4hx5zWpbSeoANX+TuSCkpDBqGQ+dUqY1bdekoCNXF5eBZuqe9AvypNRkWXvY31Cbqt6rTWklhKbQWsnZlEcH05SVrVd3LXARIm9iVDFpLQbqYOAARNrrxiJgMrXVIXEuRYNT6JNmzBjZw=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4333.namprd12.prod.outlook.com (2603:10b6:208:1d3::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Wed, 16 Sep
 2020 14:02:25 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::f8f7:7403:1c92:3a60]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::f8f7:7403:1c92:3a60%6]) with mapi id 15.20.3391.014; Wed, 16 Sep 2020
 14:02:25 +0000
Subject: Re: [PATCH -next 0/8] drm/amd/amdgpu: fix comparison pointer to bool
 warning
To:     Alex Deucher <alexdeucher@gmail.com>,
        =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        yi.zhang@huawei.com, Dave Airlie <airlied@linux.ie>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Zheng Bin <zhengbin13@huawei.com>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        "Deucher, Alexander" <alexander.deucher@amd.com>
References: <20200909130720.105234-1-zhengbin13@huawei.com>
 <1fce0f2a-3777-e6d8-5a09-30261f843cfd@amd.com>
 <CADnq5_NoeFbBAMT6s_ictVXsUc2tx1U48MLxnMbAr2Sd58jyYA@mail.gmail.com>
 <20200915193549.GP6112@intel.com>
 <6658f89f-6957-e6ea-af41-7625f1fd3cb1@gmail.com>
 <20200916075156.GU438822@phenom.ffwll.local>
 <CADnq5_OS814FxmadZ9yBkrY6ije8h7FxswWstsxNr3rw=Bum=Q@mail.gmail.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <372d7001-22cc-79b6-83b8-2fd75a1804d5@amd.com>
Date:   Wed, 16 Sep 2020 16:02:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <CADnq5_OS814FxmadZ9yBkrY6ije8h7FxswWstsxNr3rw=Bum=Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: AM0PR02CA0096.eurprd02.prod.outlook.com
 (2603:10a6:208:154::37) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7] (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by AM0PR02CA0096.eurprd02.prod.outlook.com (2603:10a6:208:154::37) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.14 via Frontend Transport; Wed, 16 Sep 2020 14:02:23 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9835b93b-f5a3-4763-1501-08d85a49238e
X-MS-TrafficTypeDiagnostic: MN2PR12MB4333:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB433375C47EE718796C17C55D83210@MN2PR12MB4333.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:220;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qgan8c80YOdAw+aoSXeEhtTYvTsnzMbVDe4bheFpkh1m0l5qOJW3Lq50nPmEZ8FlSVYIPbMEPSBsujo7/8B8Ehi8XiX97Lb5wIhfVh8o20hhPeivr2j7C6387w4gRYPBK/6u9ugaWb8P2KL//nplp4mNzzjt5A1+16iftz6ytnnMjaBWCnObBMSKjNZaODiLdV1XQmCgGnAv+KHRHFOfy+898hMNlKaFYaQdvuZi2KUPkH+GEb/5KlFNL2PcpUn7zDzENNdXM+3uMrJr8DZgWgQremvxbLMyr1M8cgVnRon2QsFdhozPuPRbwC97gy0gQS+OLXOsnC+c9Ndm3cyJdLj8EXsyH6Zod/uDAZy4J0lAfkJ0Zi/4mcdhqDVBVIseXsOqmdTdbtM7UycwJKO9udTRHi4C2hGVvaMo2C5O0qu1+r1RvgZR2Moym4oPUbnYLd2J21QYPlHecAuGD+KV2LIkbAt5g9JTJKi6yD9v/qQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3775.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39860400002)(366004)(396003)(346002)(136003)(66574015)(8676002)(8936002)(316002)(36756003)(66946007)(52116002)(16526019)(2906002)(66476007)(110136005)(31686004)(53546011)(186003)(66556008)(83380400001)(86362001)(31696002)(2616005)(966005)(6636002)(5660300002)(6666004)(6486002)(45080400002)(478600001)(83080400001)(921003)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 3zo8Ss5KdFRZu0nzOf3tUeJ2fSFsBLQkvqKgzOy6Jmrj7VHegO1ZN/tPoSsSPZCFSm+HHKuS5YZMwHIYmrF66bWOx68Sukg8GRwl2d9FryDra/WHESbMiPhoVauarbQYZTC20HR7o5LoT38fzbbI+KbhwXAJYnD3GBbq9x9aAaYDsMUGBGz5QsPWuI+udXT8c4o6Lq0n0F/SQtNhpj8cJqw8pzZBJoQR17Jmj00fhtT5mbX2xBfZoWrly5gdbV30c97APy/5M0iwk9PU05rNuEY7BSOpbqpn3nDA3SA6A+cNMllHeYxDONUv/NRedK+hFjxmfxJ152PUbqaJBMZEq5u4y1qKa8mgkZkZZ16yQKUxR85SE3pRetQYg5lTvpupzV2aAl5bi4LOx3E21R05QTsdoUPhcT60aEZso24UBDJ1XV0h6eePJR48Ek6Lhuqscph+caAxrEOmAepcWBMgjEWrmiJ3jj7Po1KSWaCsvMBLOcKK/7W/06e42b+T6Wi2wxZs7rLgOxR390ievMyx731r3eZdjJJOx/b7XZ5T4jqyLebWEGvfJjivHfcWwRikiHnOe5j7YS8wJG3P+L4IVXvjByu9cyZh4rlyShkraV3re2Vo7fJXpNBpspijoiVdYkbcCgpActIIoBd9Xarphc847qhdqvVolXp3K2CMOKbGk6zw9fpzoRYd5T/mLc+DBjHw1hNhKL2lILapcIHh4A==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9835b93b-f5a3-4763-1501-08d85a49238e
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2020 14:02:25.0910
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: we3glLyzfZGwwUYFKRyV7RI7OLnYlPgAdNPdeJ1dS9Yw6kW9yxqsprBWpFem2Wfm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4333
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 16.09.20 um 15:36 schrieb Alex Deucher:
> On Wed, Sep 16, 2020 at 3:51 AM Daniel Vetter <daniel@ffwll.ch> wrote:
>> On Wed, Sep 16, 2020 at 09:38:34AM +0200, Christian König wrote:
>>> Am 15.09.20 um 21:35 schrieb Ville Syrjälä:
>>>> On Tue, Sep 15, 2020 at 03:16:32PM -0400, Alex Deucher wrote:
>>>>> I question the value of these warnings.  Why even have a boolean type
>>>>> if you are going to get warnings when you use them...
>>>>> That said, applied to avoid getting these patches again and again
>>>>> every time someone sees this.
>>>> if (this_is_sparta)
>>>> if (this_is_sparta == true)
>>>> if (this_is_sparta != false)
>>>>
>>>> I think the first one reads the best, and avoids having to
>>>> decide between truth and falsehood :)
>>> +1
>> +1, especially because we also have the inversion when using negative
>> errno codes for failures and 0 as success, which results in
>>
>>          if (errno == 0) /* success case */
>>
>> but
>>          if (bool == 0) /* failure case */
>>
>> now creative people do sometimes
>>
>>          if (!errno) /* success case */
>>
>> which I think is horribly confusing. So imo for more easier telling apart
>> of these too I think consistently using the short form for booleans, and
>> consistently using the more explicit long form for errno checks is a Very
>> Good Pattern :-)
> I don't disagree with your logic, but we regularly get patches to
> convert errno checks to drop the direct comparison because that is the
> "preferred kernel style".  Arguably, we should be explicit in all
> cases as that avoids all confusion.  With that in mind, my original
> point stands.  Why have a type when comparisons against valid settings
> for that type produce errors?

Well it isn't an error, but raising a nice warning is most likely a good 
idea.

Christian.

>
> Alex
>
>> Cheers, Daniel
>>
>>> Christian.
>>>
>>>>> Alex
>>>>>
>>>>> On Wed, Sep 9, 2020 at 9:21 AM Christian König <christian.koenig@amd.com> wrote:
>>>>>> Acked-by: Christian König <christian.koenig@amd.com> for the series.
>>>>>>
>>>>>> Am 09.09.20 um 15:07 schrieb Zheng Bin:
>>>>>>> Zheng Bin (8):
>>>>>>>      drm/amd/amdgpu: fix comparison pointer to bool warning in gfx_v9_0.c
>>>>>>>      drm/amd/amdgpu: fix comparison pointer to bool warning in gfx_v10_0.c
>>>>>>>      drm/amd/amdgpu: fix comparison pointer to bool warning in sdma_v5_0.c
>>>>>>>      drm/amd/amdgpu: fix comparison pointer to bool warning in sdma_v5_2.c
>>>>>>>      drm/amd/amdgpu: fix comparison pointer to bool warning in si.c
>>>>>>>      drm/amd/amdgpu: fix comparison pointer to bool warning in uvd_v6_0.c
>>>>>>>      drm/amd/amdgpu: fix comparison pointer to bool warning in
>>>>>>>        amdgpu_atpx_handler.c
>>>>>>>      drm/amd/amdgpu: fix comparison pointer to bool warning in sdma_v4_0.c
>>>>>>>
>>>>>>>     drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c | 4 ++--
>>>>>>>     drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c           | 2 +-
>>>>>>>     drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c            | 2 +-
>>>>>>>     drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c           | 4 ++--
>>>>>>>     drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c           | 2 +-
>>>>>>>     drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c           | 2 +-
>>>>>>>     drivers/gpu/drm/amd/amdgpu/si.c                  | 2 +-
>>>>>>>     drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c            | 4 ++--
>>>>>>>     8 files changed, 11 insertions(+), 11 deletions(-)
>>>>>>>
>>>>>>> --
>>>>>>> 2.26.0.106.g9fadedd
>>>>>>>
>>>>>> _______________________________________________
>>>>>> amd-gfx mailing list
>>>>>> amd-gfx@lists.freedesktop.org
>>>>>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cchristian.koenig%40amd.com%7Cdc7a8d7517d341e3a80c08d85a458ba8%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637358602051676053&amp;sdata=MS0vcBcU7unXjEFlbd8kLbJkJ4sKcvIdLjc8yhX4UUI%3D&amp;reserved=0
>>>>> _______________________________________________
>>>>> dri-devel mailing list
>>>>> dri-devel@lists.freedesktop.org
>>>>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Fdri-devel&amp;data=02%7C01%7Cchristian.koenig%40amd.com%7Cdc7a8d7517d341e3a80c08d85a458ba8%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637358602051686051&amp;sdata=MgfR%2BwCVY9gWfhQ9i5kWcKiiYkV1C8O2dEKlZYSqscE%3D&amp;reserved=0
>>> _______________________________________________
>>> dri-devel mailing list
>>> dri-devel@lists.freedesktop.org
>>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Fdri-devel&amp;data=02%7C01%7Cchristian.koenig%40amd.com%7Cdc7a8d7517d341e3a80c08d85a458ba8%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637358602051686051&amp;sdata=MgfR%2BwCVY9gWfhQ9i5kWcKiiYkV1C8O2dEKlZYSqscE%3D&amp;reserved=0
>> --
>> Daniel Vetter
>> Software Engineer, Intel Corporation
>> https://nam11.safelinks.protection.outlook.com/?url=http%3A%2F%2Fblog.ffwll.ch%2F&amp;data=02%7C01%7Cchristian.koenig%40amd.com%7Cdc7a8d7517d341e3a80c08d85a458ba8%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637358602051686051&amp;sdata=GvLs5OXw2Ny%2BieJxm8hjawNb0rGA966539iAwlWwPMY%3D&amp;reserved=0

