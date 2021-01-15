Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 015DC2F7679
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 11:19:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727696AbhAOKSc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 05:18:32 -0500
Received: from smtp02.smtpout.orange.fr ([80.12.242.124]:57720 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbhAOKSb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 05:18:31 -0500
Received: from [192.168.1.41] ([92.131.99.25])
        by mwinf5d49 with ME
        id GyGn240180Ys01Y03yGoD2; Fri, 15 Jan 2021 11:16:49 +0100
X-ME-Helo: [192.168.1.41]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Fri, 15 Jan 2021 11:16:49 +0100
X-ME-IP: 92.131.99.25
Subject: Re: [PATCH][next] drm/amdgpu: Add missing BOOTUP_DEFAULT to
 profile_name[]
To:     Colin Ian King <colin.king@canonical.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Xiaojian Du <Xiaojian.Du@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210111114638.16530-1-colin.king@canonical.com>
 <20210112100706.GF5083@kadam>
 <51efd2a7-f2cf-dc28-4b86-5e89d13564ca@canonical.com>
 <f57062ac-499d-95bb-cf4f-bb7b5b1dea5b@wanadoo.fr>
 <01121c1c-5e7c-9d47-2400-c7644f6b8254@canonical.com>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Message-ID: <2e688654-cbac-ea86-b248-c863a2dc6747@wanadoo.fr>
Date:   Fri, 15 Jan 2021 11:16:49 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <01121c1c-5e7c-9d47-2400-c7644f6b8254@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 15/01/2021 à 11:10, Colin Ian King a écrit :
> On 15/01/2021 10:07, Christophe JAILLET wrote:
>> Le 15/01/2021 à 10:37, Colin Ian King a écrit :
>>> On 12/01/2021 10:07, Dan Carpenter wrote:
>>>> On Mon, Jan 11, 2021 at 11:46:38AM +0000, Colin King wrote:
>>>>> From: Colin Ian King <colin.king@canonical.com>
>>>>>
>>>>> A recent change added a new BOOTUP_DEFAULT power profile mode
>>>>> to the PP_SMC_POWER_PROFILE enum but omitted updating the
>>>>> corresponding profile_name array.  Fix this by adding in the
>>>>> missing BOOTUP_DEFAULT to profile_name[].
>>>>>
>>>>
>>>> Still not enough to prevent the array overflow.  It needs POWERSAVE as
>>>> well.
>>>
>>> Thanks for checking, but there is a 1-to-1 relation ship now:
>>>
>>> enum PP_SMC_POWER_PROFILE {
>>>           PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT = 0x0,
>>>           PP_SMC_POWER_PROFILE_FULLSCREEN3D = 0x1,
>>>           PP_SMC_POWER_PROFILE_POWERSAVING  = 0x2,
>>>           PP_SMC_POWER_PROFILE_VIDEO        = 0x3,
>>>           PP_SMC_POWER_PROFILE_VR           = 0x4,
>>>           PP_SMC_POWER_PROFILE_COMPUTE      = 0x5,
>>>           PP_SMC_POWER_PROFILE_CUSTOM       = 0x6,
>>>           PP_SMC_POWER_PROFILE_COUNT,
>>> };
>>>
>>> vs
>>>
>>>           static const char *profile_name[] = {
>>>                                           "BOOTUP_DEFAULT",
>>>                                           "3D_FULL_SCREEN",
>>>                                           "POWER_SAVING",
>>
>> This line has been added yesterday in commit f727ebeb589d.
>> So Dan was right when he sent his patch, but some else fixed it.
> 
> Ah, my bad for not seeing that. :-/

However, I wonder if this commit is complete.
The description of the commit is about 5 modes, but 6 are listed in 
PP_SMC_POWER_PROFILE.

In the hunk:
+static struct cmn2asic_mapping 
vangogh_workload_map[PP_SMC_POWER_PROFILE_COUNT] = {
+	WORKLOAD_MAP(PP_SMC_POWER_PROFILE_FULLSCREEN3D,	 
WORKLOAD_PPLIB_FULL_SCREEN_3D_BIT),
+	WORKLOAD_MAP(PP_SMC_POWER_PROFILE_VIDEO,		WORKLOAD_PPLIB_VIDEO_BIT),
+	WORKLOAD_MAP(PP_SMC_POWER_PROFILE_VR,			WORKLOAD_PPLIB_VR_BIT),
+	WORKLOAD_MAP(PP_SMC_POWER_PROFILE_COMPUTE,		WORKLOAD_PPLIB_COMPUTE_BIT),
+	WORKLOAD_MAP(PP_SMC_POWER_PROFILE_CUSTOM,		WORKLOAD_PPLIB_CUSTOM_BIT),
+};

It would look logical to have something like:
+	WORKLOAD_MAP(PP_SMC_POWER_PROFILE_POWERSAVING,	 
WORKLOAD_PPLIB_POWER_SAVING_BIT),

Not sure at all if correct.

Just my 2c,

CJ

> 
>>
>> CJ
>>
>>>                                           "VIDEO",
>>>                                           "VR",
>>>                                           "COMPUTE",
>>>                                           "CUSTOM"};
>>>
>>>
>>> unless I'm missing something because I've not had enough coffee.
>>>
>>> Colin
>>>
>>>>
>>>> regards,
>>>> dan carpenter
>>>>
>>>
>>>
>>
> 
> 

