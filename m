Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5012287ABB
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 19:13:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731882AbgJHRM5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 13:12:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730950AbgJHRM4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 13:12:56 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEABAC061755
        for <linux-kernel@vger.kernel.org>; Thu,  8 Oct 2020 10:12:56 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id c13so7055664oiy.6
        for <linux-kernel@vger.kernel.org>; Thu, 08 Oct 2020 10:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jzeo4UwgP2JoTp8IqkmZWle9aSE18ydqneueF1cXTP0=;
        b=c5K9v1AmdZ9pte18fRZjboVvDyNeiGrvEddwSqko9ZX8tJXae+7I+ucAB8RFDu0RXI
         Tjp4ujwDjgG/viooYOPfJekmEmikDr1VZwX0oa/C2Kgk0t+4Jp2z4oBz8Wa7+5DRvFoa
         bjHOyxI94HOUqCd6Xp75Ui3EYTv8y0mREoeQ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jzeo4UwgP2JoTp8IqkmZWle9aSE18ydqneueF1cXTP0=;
        b=h8KZ/iHwDv8GWtFqYpOzO69US0Vem5r1OfNniVNSYmW6BWJAC0HquamlKlzJo78c95
         DvHCf0gbDKsmI25/XQG/bo4VRv1R1DxvSjDF4fHlNas4HhH3X862HNRqyqpMFvpE/aCq
         mMqzUOEf264wMFUkdT8UuY+l9otVJTGkDTpig+KfoNtW9VEqe3N1fd1LB1NYBZ8i51Vt
         8e+u7BfgWScA73fflcKL2ALXToISsUYdeo4yhpd/0HFjugIhh9C97u3OGNM3LsZ2F5c4
         CAuonH2+hxFoQwT84WOXZUZZDp6NHU8Iui7SnR5UCJCBcx+oQ92XpUm7W3z6R0OX3R7m
         pzjw==
X-Gm-Message-State: AOAM533enPpOl4IRRPBsD20Q7JByVUHDNtJIp33MURHwuagBNWlu4qDq
        d4QjT3foKaax4xGcNAQIplNfaGfCz3ChkQ==
X-Google-Smtp-Source: ABdhPJxpiY87QvftHFyScA4hcgqJ1nfeeCYv2ElbSjT2AxA1oEfssa3ZuXS8HYTq2Yf4PvdF8EH0Qg==
X-Received: by 2002:aca:7210:: with SMTP id p16mr5850850oic.77.1602177175997;
        Thu, 08 Oct 2020 10:12:55 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id f13sm5220343oij.0.2020.10.08.10.12.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Oct 2020 10:12:55 -0700 (PDT)
Subject: Re: [PATCH v2 10/11] drivers/misc/vmw_vmci: convert num guest devices
 counter to counter_atomic32
To:     Kees Cook <keescook@chromium.org>
Cc:     arnd@arndb.de, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <cover.1602011710.git.skhan@linuxfoundation.org>
 <81f5ca6f9b0a032840d6ec0fb403d4908b9ddec9.1602011710.git.skhan@linuxfoundation.org>
 <202010071123.B54E1EA20B@keescook>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <ec56ed60-b6f5-aadb-3ffc-3d96a254868d@linuxfoundation.org>
Date:   Thu, 8 Oct 2020 11:12:54 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <202010071123.B54E1EA20B@keescook>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/7/20 12:27 PM, Kees Cook wrote:
> On Tue, Oct 06, 2020 at 02:44:41PM -0600, Shuah Khan wrote:
>> counter_atomic* is introduced to be used when a variable is used as
>> a simple counter and doesn't guard object lifetimes. This clearly
>> differentiates atomic_t usages that guard object lifetimes.
>>
>> counter_atomic* variables will wrap around to 0 when it overflows and
>> should not be used to guard resource lifetimes, device usage and
>> open counts that control state changes, and pm states.
>>
>> atomic_t variable used to count number of vmci guest devices is used
>> as just as counter and it doesn't control object lifetimes or state
>> management. Overflow doesn't appear to be problem for this use.
>>
>> Convert it to use counter_atomic32.
>>
>> This conversion doesn't change the overflow wrap around behavior.
>>
>> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
> 
> I'm not convinced this isn't both managing lifetime and already buggy.
> Specifically, I'm looking at how vmci_guest_code_active() is used --
> it's being tested before making calls? Is this safe?
> 

It is being used as a flag in the sense that !=0 indicates that
there is a guest instance. This counter value isn't used in any
code paths.

>> ---
>>   drivers/misc/vmw_vmci/vmci_guest.c | 9 +++++----
>>   1 file changed, 5 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/misc/vmw_vmci/vmci_guest.c b/drivers/misc/vmw_vmci/vmci_guest.c
>> index cc8eeb361fcd..86ae27b05fc2 100644
>> --- a/drivers/misc/vmw_vmci/vmci_guest.c
>> +++ b/drivers/misc/vmw_vmci/vmci_guest.c
>> @@ -20,6 +20,7 @@
>>   #include <linux/smp.h>
>>   #include <linux/io.h>
>>   #include <linux/vmalloc.h>
>> +#include <linux/counters.h>
>>   
>>   #include "vmci_datagram.h"
>>   #include "vmci_doorbell.h"
>> @@ -68,11 +69,11 @@ struct pci_dev *vmci_pdev;
>>   static struct vmci_guest_device *vmci_dev_g;
>>   static DEFINE_SPINLOCK(vmci_dev_spinlock);
>>   
>> -static atomic_t vmci_num_guest_devices = ATOMIC_INIT(0);
>> +static struct counter_atomic32 vmci_num_guest_devices = COUNTER_ATOMIC_INIT(0);
>>   
>>   bool vmci_guest_code_active(void)
>>   {
>> -	return atomic_read(&vmci_num_guest_devices) != 0;
>> +	return counter_atomic32_read(&vmci_num_guest_devices) != 0;
> 
> Shouldn't this be "> 0" ?
> 

Correct. > 0 would be the right check here in the context this
counter is being used, however, I don't think this value will
ever get close overflow. Please see below.

>>   }
>>   
>>   u32 vmci_get_vm_context_id(void)
>> @@ -624,7 +625,7 @@ static int vmci_guest_probe_device(struct pci_dev *pdev,
>>   
>>   	dev_dbg(&pdev->dev, "Registered device\n");
>>   
>> -	atomic_inc(&vmci_num_guest_devices);
>> +	counter_atomic32_inc(&vmci_num_guest_devices);
>>   
>>   	/* Enable specific interrupt bits. */
>>   	cmd = VMCI_IMR_DATAGRAM;
>> @@ -684,7 +685,7 @@ static void vmci_guest_remove_device(struct pci_dev *pdev)
>>   
>>   	dev_dbg(&pdev->dev, "Removing device\n");
>>   
>> -	atomic_dec(&vmci_num_guest_devices);
>> +	counter_atomic32_dec(&vmci_num_guest_devices);
> 
> If there is a bug elsewhere and vmci_guest_remove_device() (or probe)
> gets called too many times, shouldn't we protect the rest of this stack
> from having vmci_num_guest_devices go negative (and therefore non-zero)?
> 

vmci_num_guest_devices overflow/underflow causing stack corruption is
a minor problems compared to what could happen if _probe gets called
many times, considering the number of pci managed devices we would end
up with. In the sequence of things, we would run out of devm resources
to begin with.

vmci_num_guest_devices is used as bool flag really to determine if a
guest instance exists.

This driver has lots of problems that need to be addressed.

> This really seems like it should be refcount_t to me, though I have no
> idea what the races between the dec() and the read() might mean in this
> code generally.
> 

I don't believe so. vmci_num_guest_devices is used as a status as one
of the factors to make decisions. The way it is being used atomic32 is
just fine.

This patch doesn't solve these problems and add any new ones.

thanks,
-- Shuah
