Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3B9C268698
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 09:55:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726127AbgINHzs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 03:55:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbgINHzd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 03:55:33 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25D74C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 00:55:33 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id l9so10199365wme.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 00:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2aGgp8xDMxBRR1zeopFRyy7aow8Xj5s/eI8dy4PTQig=;
        b=dPosRwEc4KzFTMXrP+nF1xxgY0MRQNLM/ugUfXBsf+PzUUP/gT3+y581iIoKcRMNho
         Hu0rXitUYSt/we6D9YHygC/1wofX0TzhQu9Mj50hVy4KZcN2MajpRQj/kqsB86ydmH3H
         aLHDZTDYyI450+9DmIzJg7cjx+Bs1sm+zLqtfXNbSmaWo2lxQEhPqcFQUXaGlImaJ3sV
         LPIwci6tyG4gfPKgR0WSqwmvGulXjXJawn1UpmYpc0LvCnOcef/hloWaeMP8rcCoGuuL
         yApCZn1eeb8+787INAhM7sD7He7lBKqAcUOVw8Ks8b2fuR9xMjjAXZ3tubWd8mE6LKWF
         ABUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2aGgp8xDMxBRR1zeopFRyy7aow8Xj5s/eI8dy4PTQig=;
        b=NyBe4mBSccy/aCDqQ4Xy9NB28OunBD3lXD4tMxZBOyufWtfWut6JCjkRnwoPyePdJ7
         wOEZvVYTGFSxgCY/7tRKcmgzeZP9wJyts3KEIEnNgMpJJldmwLYg4zSUkSvJArPe7EbS
         k712ZgJ5I/sXQXi6232wLtnV8I6jfNLhIeeZpz6LiZTb5nbCmBFua/VFeB/USKuNpDGs
         iSvCc5AfET/wYyT7JI6O677sbjywPgaUxbx9uaqwAAOo1md57Fe+zI2tU3GYPNILoHjl
         rqVrVimTC679Iu/SFrN3mnYh+naRoexMykyyd2U/Edm5fdkrDEavVy2RhlQnmfenZn+s
         kgvA==
X-Gm-Message-State: AOAM533wXcFORbxinB+2N1PnoKU7bMu/weDJInVY1KI9EF04fPKFcfoH
        2Z7Fbp99kyR9tqQwGA8reV6r2hk83Epjvg==
X-Google-Smtp-Source: ABdhPJy7f+ArsPElukWugWnknE5mGs2at2tZ+XJ/gsKu/Ful3jMOj3Q048KfvUSpAbchumpyqZPzJg==
X-Received: by 2002:a1c:ed19:: with SMTP id l25mr6035591wmh.49.1600070131500;
        Mon, 14 Sep 2020 00:55:31 -0700 (PDT)
Received: from [192.168.1.20] (host109-156-254-181.range109-156.btcentralplus.com. [109.156.254.181])
        by smtp.googlemail.com with ESMTPSA id h5sm18823846wrt.31.2020.09.14.00.55.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Sep 2020 00:55:30 -0700 (PDT)
Subject: Re: [PATCH] misc: rtsx: do not setting OC_POWER_DOWN reg in
 rtsx_pci_init_ocp()
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     ricky_wu@realtek.com, arnd@arndb.de, gregkh@linuxfoundation.org,
        bhelgaas@google.com, vaibhavgupta40@gmail.com,
        rui_feng@realsil.com.cn, kdlnx@doth.eu,
        linux-kernel@vger.kernel.org
References: <20200913164957.GA1190742@bjorn-Precision-5520>
From:   Chris Clayton <chris2553@googlemail.com>
Message-ID: <6bfbb0ae-fc7e-0aec-4dab-24a3f3ba1168@googlemail.com>
Date:   Mon, 14 Sep 2020 08:55:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200913164957.GA1190742@bjorn-Precision-5520>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Bjorn.

On 13/09/2020 17:49, Bjorn Helgaas wrote:
> On Sun, Sep 13, 2020 at 09:40:56AM +0100, Chris Clayton wrote:
>> Hi Greg and Arnd,
>>
>> On 24/08/2020 04:00, ricky_wu@realtek.com wrote:
>>> From: Ricky Wu <ricky_wu@realtek.com>
>>>
>>> this power saving action in rtsx_pci_init_ocp() cause INTEL-NUC6 platform
>>> missing card reader
>>
>> In his changelog above, Ricky didn't mention that this patch fixes a
>> regression that was introduced (in 5.1) by commit bede03a579b3.
>>
>> The patch that I posted to LKML contained the appropriate Fixes, etc
>> tags. After discussion, the patch was changed to remove the code
>> that effectively disables the RTS5229 cardreader on (at least some)
>> Intel NUC boxes. I prepared the patch that Ricky submitted but he
>> didn't include my Signed-off-by or the Fixes tag. I think the
>> following needs to be added to the changelog.
>>
>> Fixes: bede03a579b3 ("misc: rtsx: Enable OCP for rts522a rts524a rts525a rts5260")
>> Link: https://marc.info/?l=linux-kernel&m=159105912832257
> 
> Better lore link:
> 
>   Link: https://lore.kernel.org/r/CACYmiSer8FA+qjh8NHZJ2maxSd-=RwDdZ2F7_-E4uM1NXuZ8gQ@mail.gmail.com/
> 
> But I'm not sure the above is the most relevant.  Seems like the one
> below is more to the point since it has the exact patch below and is
> part of a thread developing it:
> 
>   Link: https://lore.kernel.org/r/20da8b4b-8426-9568-c0f1-4d1c2006c53f@googlemail.com/
> 

Yes, I meant to change the quote to that thread but ... more haste less speed.

>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=204003
>> Signed-off-by: Chris Clayton <chris2553@googlemail.com>
>>
>> bede03a579b3 introduced a bug which leaves the rts5229 PCI Express
>> card reader on the Intel NUC6CAYH box.
>>
>> My main point, however, is that the patch is also needed in the 5.4
>> (longterm) and 5.8 (stable) series kernels.
> 
> This would be accomplished by:
> 
> Cc: stable@vger.kernel.org	# v5.1+
> 

Thanks for the tip.

I'm about to set off on a 4-day journey, so I'll send an updated patch when I return on Friday,


>>> Signed-off-by: Ricky Wu <ricky_wu@realtek.com>
>>> ---
>>>  drivers/misc/cardreader/rtsx_pcr.c | 4 ----
>>>  1 file changed, 4 deletions(-)
>>>
>>> diff --git a/drivers/misc/cardreader/rtsx_pcr.c b/drivers/misc/cardreader/rtsx_pcr.c
>>> index 37ccc67f4914..3a4a7b0cc098 100644
>>> --- a/drivers/misc/cardreader/rtsx_pcr.c
>>> +++ b/drivers/misc/cardreader/rtsx_pcr.c
>>> @@ -1155,10 +1155,6 @@ void rtsx_pci_init_ocp(struct rtsx_pcr *pcr)
>>>  			rtsx_pci_write_register(pcr, REG_OCPGLITCH,
>>>  				SD_OCP_GLITCH_MASK, pcr->hw_param.ocp_glitch);
>>>  			rtsx_pci_enable_ocp(pcr);
>>> -		} else {
>>> -			/* OC power down */
>>> -			rtsx_pci_write_register(pcr, FPDCTL, OC_POWER_DOWN,
>>> -				OC_POWER_DOWN);
>>>  		}
>>>  	}
>>>  }
>>>
