Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB77A296B3E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 10:29:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S460636AbgJWI3w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 04:29:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:38466 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S460475AbgJWI3v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 04:29:51 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5491AABF4;
        Fri, 23 Oct 2020 08:29:50 +0000 (UTC)
Subject: Re: [PATCH] gpu/drm/mgag200:remove break after return
To:     Bernard <bernard@vivo.com>
Cc:     Dave Airlie <airlied@redhat.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        opensource.kernel@vivo.com
References: <ADgA6wAcDbnOQfg3AhKb6KoN.3.1603439329788.Hmail.bernard@vivo.com>
From:   Thomas Zimmermann <tzimmermann@suse.de>
Message-ID: <44e91fc5-275e-0cd3-b6cd-acc14621a9fd@suse.de>
Date:   Fri, 23 Oct 2020 10:29:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.2
MIME-Version: 1.0
In-Reply-To: <ADgA6wAcDbnOQfg3AhKb6KoN.3.1603439329788.Hmail.bernard@vivo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On 23.10.20 09:48, Bernard wrote:
> 
> 
> From: Thomas Zimmermann <tzimmermann@suse.de>
> Date: 2020-10-23 15:13:30
> To:  Bernard Zhao <bernard@vivo.com>,Dave Airlie <airlied@redhat.com>,David Airlie <airlied@linux.ie>,Daniel Vetter <daniel@ffwll.ch>,dri-devel@lists.freedesktop.org,linux-kernel@vger.kernel.org
> Cc:  opensource.kernel@vivo.com
> Subject: Re: [PATCH] gpu/drm/mgag200:remove break after return>Hi
>>
>> On 23.10.20 09:00, Bernard Zhao wrote:
>>> In function mgag200_set_pci_regs, there are some switch cases
>>> returned, then break. These break will never run.
>>> This patch is to make the code a bit readable.
>>>
>>> Signed-off-by: Bernard Zhao <bernard@vivo.com>
>>> ---
>>>  drivers/gpu/drm/mgag200/mgag200_mode.c | 5 +----
>>>  1 file changed, 1 insertion(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/mgag200/mgag200_mode.c b/drivers/gpu/drm/mgag200/mgag200_mode.c
>>> index 38672f9e5c4f..de873a5d276e 100644
>>> --- a/drivers/gpu/drm/mgag200/mgag200_mode.c
>>> +++ b/drivers/gpu/drm/mgag200/mgag200_mode.c
>>> @@ -794,20 +794,17 @@ static int mgag200_crtc_set_plls(struct mga_device *mdev, long clock)
>>>  	case G200_SE_A:
>>>  	case G200_SE_B:
>>>  		return mga_g200se_set_plls(mdev, clock);
>>> -		break;
>>>  	case G200_WB:
>>>  	case G200_EW3:
>>>  		return mga_g200wb_set_plls(mdev, clock);
>>> -		break;
>>>  	case G200_EV:
>>>  		return mga_g200ev_set_plls(mdev, clock);
>>> -		break;
>>>  	case G200_EH:
>>>  	case G200_EH3:
>>>  		return mga_g200eh_set_plls(mdev, clock);
>>> -		break;
>>>  	case G200_ER:
>>>  		return mga_g200er_set_plls(mdev, clock);
>>> +	default:
>>
>> No default case here. If one of the enum values is not handled by the
>> switch, the compiler should warn about it.
> 
> Hi
> 
> For this point I was a little confused, about this switch variable "mdev->type", my understanding is that this variable`s value can be certain only when the code is running.
> How does the compiler warn this("If one of the enum values is not handled") before the code runs?

The enum mga_type {} has values (G200_ER, G200_WB, etc) that are known
to the compiler. If one of those values does not show up in the switch
statement, the compiler warns. Adding default would silence this warning.

In principle, mdev->type could contain any value that fits into an int.
But assigning anything that is not listed in enum mga_type {} is
considered an error as well.

Best regards
Thomas

> 
> BR//Bernard
> 
>> Best regards
>> Thomas
>>
>>>  		break;
>>>  	}
>>>  
>>>
>>
>> -- 
>> Thomas Zimmermann
>> Graphics Driver Developer
>> SUSE Software Solutions Germany GmbH
>> Maxfeldstr. 5, 90409 Nürnberg, Germany
>> (HRB 36809, AG Nürnberg)
>> Geschäftsführer: Felix Imendörffer
> 
> 

-- 
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 Nürnberg, Germany
(HRB 36809, AG Nürnberg)
Geschäftsführer: Felix Imendörffer
