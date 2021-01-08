Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A4062EF3FD
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 15:37:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726876AbhAHOgH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 09:36:07 -0500
Received: from smtpcmd11116.aruba.it ([62.149.156.116]:35405 "EHLO
        smtpcmd11116.aruba.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725942AbhAHOgH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 09:36:07 -0500
Received: from [192.168.126.129] ([146.241.198.163])
        by Aruba Outgoing Smtp  with ESMTPSA
        id xsqukp55MkRIKxsqukltIC; Fri, 08 Jan 2021 15:35:00 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
        t=1610116500; bh=Lo2Rsw/Bj0EQ4nPx99gjoIOjPdT6/lAKPsJoh9P9CnQ=;
        h=Subject:To:From:Date:MIME-Version:Content-Type;
        b=GECIQzJVYpskURW8zlWbywwGOk/r1FaBFh38+4zAUCJg/7VkUbXo9RrcXs43dz6Gf
         Hk6IR66si4NfMAS6VjxQ7Y+FR+skORcR4LcOu4Ftb/NL/JHo6yndH79mwzaSygIoC7
         mmvIAw3ZRVRjT7uoxDp8Y9LCGJ0rHYy5qUkF7M26Oj6DQB3SSflhDnCYiDzRVsfJLJ
         x1uZvDofNfC5+SWI1FfwrtCgaYI6XK6jocAhP9rljZiazujKmsv2JQ9Z9ClEOMs2hY
         B2B8DoYKykbE13BebTTvYqEJn7v/Zl8zr2rzO9BsxqptVguYnDYlvEQjO1IwEAWceq
         vkbUF9H4/UaOw==
Subject: Re: [PATCH v2 2/2] drm/sun4i: tcon: improve DCLK polarity handling
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Marjan Pascolo <marjan.pascolo@trexom.it>, wens@csie.org,
        daniel@ffwll.ch, airlied@linux.ie, treding@nvidia.com,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Giulio Benetti <giulio.benetti@micronovasrl.com>
References: <3685133.SLcexNTYsu@kista>
 <20210107023032.560182-1-giulio.benetti@benettiengineering.com>
 <20210107023032.560182-3-giulio.benetti@benettiengineering.com>
 <20210108092355.7p5uakxt7lpdu3bn@gilmour>
From:   Giulio Benetti <giulio.benetti@benettiengineering.com>
Message-ID: <35622307-5e88-a2ed-bdf9-fca6554efefc@benettiengineering.com>
Date:   Fri, 8 Jan 2021 15:34:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210108092355.7p5uakxt7lpdu3bn@gilmour>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfET0e/KrWMgOYO750tVJllExzFA7y1EbZAq7Vy7f1LHbU1AIS9bfFF2gRDQw7BAx6TJlFgTYFG80fY16s0XkdXezMmn8Gba93AYuD7jtpaAsr2xlCAvw
 +rGjDZHgE7uxQUsUnKfQUz3NwRSl1Z2xYvnBWxUhqmXYfu5Zg2Ju1Iq1kz9Qs3TTZzY2CnfDyWTIYYYkTl7shiEDG3jX6v051MOJIrCQsD/O1uBY4kz04+7n
 m1wYXGGDGBjUFHL2W1yRlYsw1rz9jJ3AOZBjug7Nz5kyrKW6CAziz/JsCNVxOvkQeto7EpkPsNFoTXakvcSCYKnYVBLmziE6d9B9KyQx469PrjFPBkW6KV/n
 OOiSYreIb8U/DtLf7S1X484SGG2R8EmHsYDb3L9B/bpm91p1gM71gqQrzN9BEYDc9CQ74Z0mdnOfdt7watlaOgfrtHzoTaVmjSk72KetOzRqcqIg/yOjxxSM
 YaPcLAMZjWSqGaSBDS30xmPF6Uvp91zKufDD3uQKpweL4kMxQdtkIhvh2WiYzndUPFkyfPNUHRBICuqS/wh2laMjX2SLi7M0CuK8aQ==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 1/8/21 10:23 AM, Maxime Ripard wrote:
> Hi,
> 
> Thanks for those patches
> 
> On Thu, Jan 07, 2021 at 03:30:32AM +0100, Giulio Benetti wrote:
>> From: Giulio Benetti <giulio.benetti@micronovasrl.com>
>>
>> It turned out(Maxime suggestion) that bit 26 of SUN4I_TCON0_IO_POL_REG is
>> dedicated to invert DCLK polarity and this makes thing really easier than
>> before. So let's handle DCLK polarity by adding
>> SUN4I_TCON0_IO_POL_DCLK_POSITIVE as bit 26 and activating according to
>> bus_flags the same way is done for all the other signals.
>>
>> Cc: Maxime Ripard <maxime@cerno.tech>
> 
> Suggested-by would be nice here :)

Ok, didn't know about this tag

>> Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>
>> ---
>>   drivers/gpu/drm/sun4i/sun4i_tcon.c | 20 +-------------------
>>   drivers/gpu/drm/sun4i/sun4i_tcon.h |  1 +
>>   2 files changed, 2 insertions(+), 19 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/sun4i_tcon.c
>> index 52598bb0fb0b..30171ccd87e5 100644
>> --- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
>> +++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
>> @@ -569,26 +569,8 @@ static void sun4i_tcon0_mode_set_rgb(struct sun4i_tcon *tcon,
>>   	if (info->bus_flags & DRM_BUS_FLAG_DE_LOW)
>>   		val |= SUN4I_TCON0_IO_POL_DE_NEGATIVE;
>>   
>> -	/*
>> -	 * On A20 and similar SoCs, the only way to achieve Positive Edge
>> -	 * (Rising Edge), is setting dclk clock phase to 2/3(240°).
>> -	 * By default TCON works in Negative Edge(Falling Edge),
>> -	 * this is why phase is set to 0 in that case.
>> -	 * Unfortunately there's no way to logically invert dclk through
>> -	 * IO_POL register.
>> -	 * The only acceptable way to work, triple checked with scope,
>> -	 * is using clock phase set to 0° for Negative Edge and set to 240°
>> -	 * for Positive Edge.
>> -	 * On A33 and similar SoCs there would be a 90° phase option,
>> -	 * but it divides also dclk by 2.
>> -	 * Following code is a way to avoid quirks all around TCON
>> -	 * and DOTCLOCK drivers.
>> -	 */
>>   	if (info->bus_flags & DRM_BUS_FLAG_PIXDATA_DRIVE_POSEDGE)
>> -		clk_set_phase(tcon->dclk, 0);
>> -
>> -	if (info->bus_flags & DRM_BUS_FLAG_PIXDATA_DRIVE_NEGEDGE)
>> -		clk_set_phase(tcon->dclk, 240);
>> +		val |= SUN4I_TCON0_IO_POL_DCLK_POSITIVE;
> 
> I'm not really sure why we need the first patch of this series here?

The idea was to have 2 for testing, 1st one is already applicable, while 
the other must be tested, but I can send only one with no problem.

> That patch only seem to undo what you did in patch 1

No, it doesn't, the 2nd one change the way it achieve the same thing, 
because the 1st swap DCLK phase, while the 2nd uses the IO_POL bit to 
set IO polarity according to bus_flags.

Best Regards
-- 
Giulio Benetti
Benetti Engineering sas
