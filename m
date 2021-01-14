Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 183052F5C40
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 09:15:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727454AbhANINp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 03:13:45 -0500
Received: from smtpcmd0756.aruba.it ([62.149.156.56]:39611 "EHLO
        smtpcmd15176.aruba.it" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726055AbhANINp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 03:13:45 -0500
Received: from [192.168.126.129] ([146.241.213.249])
        by Aruba Outgoing Smtp  with ESMTPSA
        id zxk5kE8AuiSGyzxk7k4gZY; Thu, 14 Jan 2021 09:12:37 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
        t=1610611957; bh=U3GkaEYQcDRkyPk+HcfNK9RyDtd4+RTtCrf/zwfX4o0=;
        h=Subject:To:From:Date:MIME-Version:Content-Type;
        b=eJxD4rBlVi0UYRgQS40oI8dtubhwFYOy4fzNIoO7o2W4c56KWcjAvLJSTb0vrtG4L
         Lj8lK1da8sO7K0Q6JPNgXTs5TYWluxhpcIBNuxB5LmqeHSL1yNOCdNV2mVsploFVxb
         5vEn4jGAnN2qNmbMqzA2Wl88WQF0qXsj9gfDErwL4bnXn59vzdPGzocStBv8uWtWMS
         I0o/Kwf1+N3nrg8ic82gw0ZCnYEmPpw8yUnFIxL+j3XdApQVIFtIEhO49w80y3hFEo
         mG6fgVmabvIb5FbhIq++dO4xDXqI78ZRLfQJKUeJyIuKDfvU0pC9J5/RYJOADva04k
         2RlbOaD2+0azw==
Subject: Re: [PATCH v5] drm/sun4i: tcon: fix inverted DCLK polarity
To:     Marjan Pascolo <marjan.pascolo@trexom.it>,
        Maxime Ripard <maxime@cerno.tech>
Cc:     wens@csie.org, daniel@ffwll.ch, airlied@linux.ie,
        treding@nvidia.com, Jernej Skrabec <jernej.skrabec@siol.net>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Giulio Benetti <giulio.benetti@micronovasrl.com>
References: <20210113104725.770459-1-giulio.benetti@benettiengineering.com>
 <20210113160526.928766-1-giulio.benetti@benettiengineering.com>
 <d244aa6b-00b7-d768-83cb-e5a228b7ee08@trexom.it>
From:   Giulio Benetti <giulio.benetti@benettiengineering.com>
Message-ID: <07172fe4-5704-cce3-084c-459f3cf61b9e@benettiengineering.com>
Date:   Thu, 14 Jan 2021 09:12:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <d244aa6b-00b7-d768-83cb-e5a228b7ee08@trexom.it>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfBx+4IjI12ArIg36QpTLvQnobDfvxYZPuTnwNbsqSOovu8HIFxwQ4qFRg4TnZlGO8YjWWLKoFf8xJkl+K2LQIAd2G8o/VgAGm+ipRF6GixdVhse7EH49
 nVID1yluT+gNKPlTpqNKdC8Bm+c3Va9c5VaZFnIP4OEOBTWCRSD0CRszHGcMMF1SsYa/Tju+nAimydj/7SncXdtTg4s7UzKqCYp9IL/Nembqc6FzszVZp8VG
 Nv1NuNAEWoXqsg7nodOQcP4xJFcwSGbHnKhuefo2SRXb9pkethc2HA3UkSaWqfD/RKr8Kvi2XrdlcxpUH2I0VKBeKt3Zu4B1AadvaXz1K9xBQcvod9bBapRa
 TYxSf6E+lrTv9U+M9uRXfE0K0AoAEdhyQtPmSWxKcDaYTawNRV1de5ZUyVeuyh43hJgzQp6hsTuMFbsk8YRHFtFT2pocJtEj8mDruQfyFNE2Lh8aMih2kaiL
 NBB2xcFRTtfnQCAbJiYWOL8ivRTecRHDL58oIXuvzcE8Cfx1TDRoQpVAr0WAVjtvGugIe7F7pbfk835jVOs1f0hRtiUTw9oyV2m8tw==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marjan,

On 1/14/21 8:58 AM, Marjan Pascolo wrote:
> Hi Giulio,
> 
> You did a typo
> 
> Il 13/01/2021 17:05, Giulio Benetti ha scritto:
>> From: Giulio Benetti <giulio.benetti@micronovasrl.com>
>>
>> During commit 88bc4178568b ("drm: Use new
>> DRM_BUS_FLAG_*_(DRIVE|SAMPLE)_(POS|NEG)EDGE flags") DRM_BUS_FLAG_*
>> macros have been changed to avoid ambiguity but just because of this
>> ambiguity previous DRM_BUS_FLAG_PIXDATA_(POS/NEG)EDGE were used meaning
>> _SAMPLE_ not _DRIVE_. This leads to DLCK inversion and need to fix but
>> instead of swapping phase values, let's adopt an easier approach Maxime
>> suggested:
>> It turned out that bit 26 of SUN4I_TCON0_IO_POL_REG is dedicated to
>> invert DCLK polarity and this makes things really easier than before. So
>> let's handle DCLK polarity by adding SUN4I_TCON0_IO_POL_DCLK_DRIVE_NEGEDGE
>> as bit 26 and activating according to bus_flags the same way it is done
>> for all the other signals polarity.
>>
>> Fixes: 88bc4178568b ("drm: Use new DRM_BUS_FLAG_*_(DRIVE|SAMPLE)_(POS|NEG)EDGE flags")
>> Suggested-by: Maxime Ripard <maxime@cerno.tech>
>> Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>
>> ---
>> V2->V3:
>> - squash 2 patches into 1
>> V3->V4:
>> - add SUN4I_TCON0_IO_POL_DCLK_POSITIVE to regmap_update_bits()
>> V4->V5:
>> polarity is still wrong so:
>> - let's use SUN4I_TCON0_IO_POL_DCLK_DRIVE_NEGEDGE macro
>>     instead of _DCLK_POSITIVE(that would make sense only in realtion with DCLK)
>> - invert condition using _NEGEDGE instead of _POSEDGE and then matching with
>>     register bit SUN4I_TCON0_IO_POL_DCLK_DRIVE_NEGEDGE
>> - correct commit log according to V4->V5 changes
>> ---
>>    drivers/gpu/drm/sun4i/sun4i_tcon.c | 21 ++-------------------
>>    drivers/gpu/drm/sun4i/sun4i_tcon.h |  1 +
>>    2 files changed, 3 insertions(+), 19 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/sun4i_tcon.c
>> index eaaf5d70e352..c172ccfff7e5 100644
>> --- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
>> +++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
>> @@ -569,30 +569,13 @@ static void sun4i_tcon0_mode_set_rgb(struct sun4i_tcon *tcon,
>>    	if (info->bus_flags & DRM_BUS_FLAG_DE_LOW)
>>    		val |= SUN4I_TCON0_IO_POL_DE_NEGATIVE;
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
>> -	if (info->bus_flags & DRM_BUS_FLAG_PIXDATA_DRIVE_POSEDGE)
>> -		clk_set_phase(tcon->dclk, 240);
>> -
>>    	if (info->bus_flags & DRM_BUS_FLAG_PIXDATA_DRIVE_NEGEDGE)
>> -		clk_set_phase(tcon->dclk, 0);
>> +		val |= SUN4I_TCON0_IO_POL_DCLK_DRIVE_NEGEDGE;
>>    
>>    	regmap_update_bits(tcon->regs, SUN4I_TCON0_IO_POL_REG,
>>    			   SUN4I_TCON0_IO_POL_HSYNC_POSITIVE |
>>    			   SUN4I_TCON0_IO_POL_VSYNC_POSITIVE |
> Here Below you missed an 'E'

yes, thank you, going to send v6.

Best regards
-- 
Giulio Benetti
Benetti Engineering sas

>> +			   SUN4I_TCON0_IO_POL_DCLK_DRIVE_NEGDGE |
>>    			   SUN4I_TCON0_IO_POL_DE_NEGATIVE,
>>    			   val);
>>    
>> diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.h b/drivers/gpu/drm/sun4i/sun4i_tcon.h
>> index cfbf4e6c1679..c5ac1b02482c 100644
>> --- a/drivers/gpu/drm/sun4i/sun4i_tcon.h
>> +++ b/drivers/gpu/drm/sun4i/sun4i_tcon.h
>> @@ -113,6 +113,7 @@
>>    #define SUN4I_TCON0_IO_POL_REG			0x88
>>    #define SUN4I_TCON0_IO_POL_DCLK_PHASE(phase)		((phase & 3) << 28)
>>    #define SUN4I_TCON0_IO_POL_DE_NEGATIVE			BIT(27)
>> +#define SUN4I_TCON0_IO_POL_DCLK_DRIVE_NEGEDGE		BIT(26)
>>    #define SUN4I_TCON0_IO_POL_HSYNC_POSITIVE		BIT(25)
>>    #define SUN4I_TCON0_IO_POL_VSYNC_POSITIVE		BIT(24)
>>    

