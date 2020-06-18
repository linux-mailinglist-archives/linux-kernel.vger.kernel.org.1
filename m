Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD99A1FF4E8
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jun 2020 16:39:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730872AbgFROiy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Jun 2020 10:38:54 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:55549 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726981AbgFROiy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 10:38:54 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212])
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1jlvgo-0002Gk-Uo; Thu, 18 Jun 2020 14:38:51 +0000
Subject: Re: [PATCH] drm/arm: fix unintentional integer overflow on left shift
To:     Garrit Franke <garritfranke@gmail.com>,
        Liviu Dudau <liviu.dudau@arm.com>
Cc:     David Airlie <airlied@linux.ie>, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20200618100400.11464-1-colin.king@canonical.com>
 <20200618121405.GJ159988@e110455-lin.cambridge.arm.com>
 <5d08fbec-75d8-d9a9-af61-e6ab98e77c80@canonical.com>
 <20200618142106.GK159988@e110455-lin.cambridge.arm.com>
 <CAD16O86ebsDkwbnuw2G04YZWfukqxJ=_Tex5OT07icEpfPdQNw@mail.gmail.com>
From:   Colin Ian King <colin.king@canonical.com>
Autocrypt: addr=colin.king@canonical.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <33bcb868-5202-9a59-b4c6-803097cbe620@canonical.com>
Date:   Thu, 18 Jun 2020 15:38:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <CAD16O86ebsDkwbnuw2G04YZWfukqxJ=_Tex5OT07icEpfPdQNw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/06/2020 15:36, Garrit Franke wrote:
> Hi all, newbie here.
> Can the BIT macro be safely used on other parts of the kernel as well?
> Just using git grep "1 <<" returns a ton of results where bit shifting
> is used the old fashioned way.

The BIT macro casts the 1 it a UL before shifting so it catches these
type of bugs.  use BIT_ULL when the result is assigned to a long long.

Colin

> 
> Am Do., 18. Juni 2020 um 16:23 Uhr schrieb Liviu Dudau <liviu.dudau@arm.com>:
>>
>> On Thu, Jun 18, 2020 at 01:50:34PM +0100, Colin Ian King wrote:
>>> On 18/06/2020 13:14, Liviu Dudau wrote:
>>>> On Thu, Jun 18, 2020 at 11:04:00AM +0100, Colin King wrote:
>>>>> From: Colin Ian King <colin.king@canonical.com>
>>>>
>>>> Hi Colin,
>>>>
>>>>>
>>>>> Shifting the integer value 1 is evaluated using 32-bit arithmetic
>>>>> and then used in an expression that expects a long value leads to
>>>>> a potential integer overflow.
>>>>
>>>> I'm afraid this explanation makes no sense to me. Do you care to explain better what
>>>> you think the issue is? If the shift is done as 32-bit arithmetic and then promoted
>>>> to long how does the overflow happen?
>>>
>>> The shift is performed using 32 bit signed math and then assigned to an
>>> unsigned 64 bit long. This if the shift is 31 bits then the signed int
>>> conversion of 0x80000000 to unsigned long becomes 0xffffffff80000000.
>>> If the shift is more than 32 bits then result overflows and becomes 0x0.
>>
>> You are right, I've missed the fact that it is signed math. Not very likely that
>> we are going to ever have 30 or more CRTCs in the driver, but Coverity has no
>> way of knowing that.
>>
>> Acked-by: Liviu Dudau <liviu.dudau@arm.com>
>>
>> I will pull this into drm-misc-next today.
>>
>> Best regards,
>> Liviu
>>
>>>
>>> Colin
>>>
>>>>
>>>> Best regards,
>>>> Liviu
>>>>
>>>>> Fix this by using the BIT macro to
>>>>> perform the shift to avoid the overflow.
>>>>>
>>>>> Addresses-Coverity: ("Unintentional integer overflow")
>>>>> Fixes: ad49f8602fe8 ("drm/arm: Add support for Mali Display Processors")
>>>>> Signed-off-by: Colin Ian King <colin.king@canonical.com>
>>>>> ---
>>>>>  drivers/gpu/drm/arm/malidp_planes.c | 2 +-
>>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/arm/malidp_planes.c b/drivers/gpu/drm/arm/malidp_planes.c
>>>>> index 37715cc6064e..ab45ac445045 100644
>>>>> --- a/drivers/gpu/drm/arm/malidp_planes.c
>>>>> +++ b/drivers/gpu/drm/arm/malidp_planes.c
>>>>> @@ -928,7 +928,7 @@ int malidp_de_planes_init(struct drm_device *drm)
>>>>>    const struct malidp_hw_regmap *map = &malidp->dev->hw->map;
>>>>>    struct malidp_plane *plane = NULL;
>>>>>    enum drm_plane_type plane_type;
>>>>> -  unsigned long crtcs = 1 << drm->mode_config.num_crtc;
>>>>> +  unsigned long crtcs = BIT(drm->mode_config.num_crtc);
>>>>>    unsigned long flags = DRM_MODE_ROTATE_0 | DRM_MODE_ROTATE_90 | DRM_MODE_ROTATE_180 |
>>>>>                          DRM_MODE_ROTATE_270 | DRM_MODE_REFLECT_X | DRM_MODE_REFLECT_Y;
>>>>>    unsigned int blend_caps = BIT(DRM_MODE_BLEND_PIXEL_NONE) |
>>>>> --
>>>>> 2.27.0.rc0
>>>>>
>>>>
>>>
>>> _______________________________________________
>>> dri-devel mailing list
>>> dri-devel@lists.freedesktop.org
>>> https://lists.freedesktop.org/mailman/listinfo/dri-devel
>>
>> --
>> ====================
>> | I would like to |
>> | fix the world,  |
>> | but they're not |
>> | giving me the   |
>>  \ source code!  /
>>   ---------------
>>     ¯\_(ツ)_/¯

