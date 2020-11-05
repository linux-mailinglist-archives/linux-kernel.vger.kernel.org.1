Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2004A2A7A23
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 10:10:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730740AbgKEJKs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 04:10:48 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:33902 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730340AbgKEJKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 04:10:47 -0500
Received: by mail-ed1-f68.google.com with SMTP id a15so751045edy.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 01:10:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=U3P/LH5Pt4KWyrbq4dAOJCrZy7eh9YgzflCM7hEMp1Y=;
        b=AsXwAuHxratbkHWkvrNDVIsKffyIWukx79AReET8zjCd5YLiVPSLtugc+U3wEFMjoh
         0M5lBPFWqMNvoeTGYfTl10nd+P055boaCJbc3Mvj02UZXx2+9OYBy9YESxXAkbp2u6mC
         e2W8zSMh5sJXRCcCk47qEqVQri3FyK7gukfcGAaCNIqx/L1x/tdGD1wwILD0g8GMOI07
         QiNG3E8aPe/9WdC/YwQjpxbr1Cp5Cr+VDO58ONFnsDD/glQMkmfN4QlnoIaHuqSSLjW1
         OEbJRxabHNV54JHwkq7rjn3cTUtskA3xEaszXs+djRAPx6nNdRpHbAT9sWyY2JopFRhI
         +GGQ==
X-Gm-Message-State: AOAM533MiqfyH0E5U8rlvqQbpABkPXuR5FuJse2bhkBIXXdLKhwldBNI
        EDE1s2nTwy5wi6IYcZrV9Bw=
X-Google-Smtp-Source: ABdhPJwjZT4W0TEjVrzhTjCAn1npzR8t1G4P58ytv4jyal6ioC+ldVWnC/hfWTYZCmEURIisVQleNw==
X-Received: by 2002:aa7:c792:: with SMTP id n18mr1520597eds.209.1604567445267;
        Thu, 05 Nov 2020 01:10:45 -0800 (PST)
Received: from ?IPv6:2a0b:e7c0:0:107::49? ([2a0b:e7c0:0:107::49])
        by smtp.gmail.com with ESMTPSA id rl1sm560714ejb.36.2020.11.05.01.10.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2020 01:10:44 -0800 (PST)
Subject: Re: [PATCH 27/36] tty: synclinkmp: Mark never checked 'readval' as
 __always_unused
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        paulkf@microgate.com
References: <20201104193549.4026187-1-lee.jones@linaro.org>
 <20201104193549.4026187-28-lee.jones@linaro.org>
 <0a4043ee-dad5-7691-8c67-db73d3c12f52@kernel.org>
 <20201105084341.GZ4488@dell>
From:   Jiri Slaby <jirislaby@kernel.org>
Message-ID: <a95f8d0d-28ef-7351-cdbb-7da5ad8aa9ad@kernel.org>
Date:   Thu, 5 Nov 2020 10:10:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.3
MIME-Version: 1.0
In-Reply-To: <20201105084341.GZ4488@dell>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05. 11. 20, 9:43, Lee Jones wrote:
> On Thu, 05 Nov 2020, Jiri Slaby wrote:
> 
>> On 04. 11. 20, 20:35, Lee Jones wrote:
>>> Fixes the following W=1 kernel build warning(s):
>>>
>>>    drivers/tty/synclinkmp.c: In function ‘init_adapter’:
>>>    drivers/tty/synclinkmp.c:5167:6: warning: variable ‘readval’ set but not used [-Wunused-but-set-variable]
>>>
>>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>> Cc: Jiri Slaby <jirislaby@kernel.org>
>>> Cc: paulkf@microgate.com
>>> Signed-off-by: Lee Jones <lee.jones@linaro.org>
>>> ---
>>>    drivers/tty/synclinkmp.c | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/tty/synclinkmp.c b/drivers/tty/synclinkmp.c
>>> index 0ca738f61a35b..75f494bfdcbed 100644
>>> --- a/drivers/tty/synclinkmp.c
>>> +++ b/drivers/tty/synclinkmp.c
>>> @@ -5165,7 +5165,7 @@ static bool init_adapter(SLMP_INFO *info)
>>>    	/* Set BIT30 of Local Control Reg 0x50 to reset SCA */
>>>    	volatile u32 *MiscCtrl = (u32 *)(info->lcr_base + 0x50);
>>> -	u32 readval;
>>> +	u32 __always_unused readval;
>>
>> Why not just remove readval completely as in other cases?
> 
> Because I don't know what the result would be.
> 
> Will the read still happen, or will the compiler optimise it away?

The compiler will eliminate this dead store anyway. However given the 
MiscCtrl pointer is volatile, the read proper must remain.

> My changes should not affect any of the instructions i.e. the register
> read must still take place

I understand. But the C specification helps here.

>> And the loop can be turned into ndelay:
>>
>>          /*
>>           * Force at least 170ns delay before clearing
>>           * reset bit. Each read from LCR takes at least
>>           * 30ns so 10 times for 300ns to be safe.
>>           */
>>          for(i=0;i<10;i++)
>>                  readval = *MiscCtrl;
> 
> Again, since I can't test this, I do not want this patch to contain
> any functional changes.  AFAIC, the 10 register reads must still
> happen after this patch is applied.

OK, let the loop alone. I would bet a half a pig that noone is able to 
test this driver. But one has to write this for someone to raise and 
admit they are still using it. In fact, there are _4_ google replies to 
"Microgate Corporation" "SyncLink Multiport Adapter" "lspci".

thanks,
-- 
js
suse labs
