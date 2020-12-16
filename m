Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 483212DC27C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 15:53:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726447AbgLPOwp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 09:52:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726112AbgLPOwo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 09:52:44 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58A98C061794;
        Wed, 16 Dec 2020 06:52:04 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id n26so33074595eju.6;
        Wed, 16 Dec 2020 06:52:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+bZLPcC/+/yVLAX9CrkkEUmF6SpG0gkkuXDp/8qSE2k=;
        b=iD4zzssmEg5Hdge3AM67/Xy/PAa0VDDMWrwV1XEiRgd2M9DDVnFjL+B9cSKSifuKZk
         WxH5CLjc3G8lx1nAjmaNIOmx7R4J4Z4P2rwccUHEwjFShKKHIcXh/CV3AYEo3/fz3EEJ
         s+F50NMhAq4iTzWJf8rfYeFPXnAuSLGB0JxMNCIUlDX7rhU8ZRQiqbUEfSQpTzDQOzc+
         72pHuZ5pBJk+tfuFy9eNjj9zBLsRg4JSEiZD2aksR8anSS2MYs6aBpohhlKKLGdJr2Qj
         B01JT+v8UQkHVV7rBA4k7YV13WXaxFKC490FYikv4PcpFfjqPVn4InMTaLgK9tJ5Hsv5
         FApg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+bZLPcC/+/yVLAX9CrkkEUmF6SpG0gkkuXDp/8qSE2k=;
        b=pUg37PzotZKxGxQNnWZG3hik/1CIHRXZeHfH+qWGDpK0KcAxr2UXLHlM/YFE7VWdLL
         WbsiIdbV5WsZXgcsnCD2QheYR33/wMEIpJf9s+BVFliqIiGQe2DP/oJQ7G1seqYLPAjt
         EEXy2HqxyPDwhg4zFYvN9ePb7o3rmBvf+XIWU9nF+aYJyfh7m02crSZccusbYuWdWWwJ
         BwzTSG2kHz07qBG3UFkd2gC1EUmzVBjAmMVAY2MVXyA0Jqp+E1srbV7FZmAzH7fC7IA2
         6e0L2nIbsvXHSCCzO3ePWo93v0Qx+UZy9pBZKY4t0o4iDmMHyW3omAHsk0r5gBVRTlJQ
         peGw==
X-Gm-Message-State: AOAM532c1aKgcWyl63lZuWC9XGGT6VZCD+jIm66XUfhqNErmwkg829Ip
        L+7GfjQfnZL12i8C8WzUMzFDPjSUGFQ=
X-Google-Smtp-Source: ABdhPJwK2kGNMYa7oeyZwNH0NFHRqvWc7HhyOt7ue9XND4vUQlSOSwirWVxgHTLasd8bV7G3YqtMnw==
X-Received: by 2002:a17:906:30c4:: with SMTP id b4mr21981500ejb.456.1608130322686;
        Wed, 16 Dec 2020 06:52:02 -0800 (PST)
Received: from [192.168.2.202] (pd9e5a412.dip0.t-ipconnect.de. [217.229.164.18])
        by smtp.gmail.com with ESMTPSA id s24sm1552565ejb.20.2020.12.16.06.52.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Dec 2020 06:52:01 -0800 (PST)
Subject: Re: [PATCH] platform/surface: SURFACE_PLATFORMS should depend on ACPI
To:     Hans de Goede <hdegoede@redhat.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Mark Gross <mgross@linux.intel.com>
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20201216133752.1321978-1-geert@linux-m68k.org>
 <aa101c72-2d15-efa8-5b44-479315e24a93@redhat.com>
From:   Maximilian Luz <luzmaximilian@gmail.com>
Message-ID: <f36b67a2-71a2-6f00-1515-c8ce3e59d027@gmail.com>
Date:   Wed, 16 Dec 2020 15:52:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <aa101c72-2d15-efa8-5b44-479315e24a93@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/16/20 3:01 PM, Hans de Goede wrote:
> Hi,
> 
> On 12/16/20 2:37 PM, Geert Uytterhoeven wrote:
>> All Microsoft Surface platform-specific device drivers depend on ACPI,
>> but the gatekeeper symbol SURFACE_PLATFORMS does not.  Hence when the
>> user is configuring a kernel without ACPI support, he is still asked
>> about Microsoft Surface drivers, even though this question is
>> irrelevant.
>>
>> Fix this by moving the dependency on ACPI from the individual driver
>> symbols to SURFACE_PLATFORMS.
>>
>> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> 
> Thanks, patch looks good to me:
> 
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> 
> Maximilian, can I have your ack or reviewed-by for this
> (assuming you agree with this change) ?

Sure, looks good to me.

Reviewed-by: Maximilian Luz <luzmaximilian@gmail.com>

Regards,
Max

> 
> Regards,
> 
> Hans
> 
>> ---
> 
> 
>>   drivers/platform/surface/Kconfig | 8 ++++----
>>   1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/platform/surface/Kconfig b/drivers/platform/surface/Kconfig
>> index 33040b0b3b799c2d..2c941cdac9eedc6f 100644
>> --- a/drivers/platform/surface/Kconfig
>> +++ b/drivers/platform/surface/Kconfig
>> @@ -5,6 +5,7 @@
>>   
>>   menuconfig SURFACE_PLATFORMS
>>   	bool "Microsoft Surface Platform-Specific Device Drivers"
>> +	depends on ACPI
>>   	default y
>>   	help
>>   	  Say Y here to get to see options for platform-specific device drivers
>> @@ -29,20 +30,19 @@ config SURFACE3_WMI
>>   
>>   config SURFACE_3_BUTTON
>>   	tristate "Power/home/volume buttons driver for Microsoft Surface 3 tablet"
>> -	depends on ACPI && KEYBOARD_GPIO && I2C
>> +	depends on KEYBOARD_GPIO && I2C
>>   	help
>>   	  This driver handles the power/home/volume buttons on the Microsoft Surface 3 tablet.
>>   
>>   config SURFACE_3_POWER_OPREGION
>>   	tristate "Surface 3 battery platform operation region support"
>> -	depends on ACPI && I2C
>> +	depends on I2C
>>   	help
>>   	  This driver provides support for ACPI operation
>>   	  region of the Surface 3 battery platform driver.
>>   
>>   config SURFACE_GPE
>>   	tristate "Surface GPE/Lid Support Driver"
>> -	depends on ACPI
>>   	depends on DMI
>>   	help
>>   	  This driver marks the GPEs related to the ACPI lid device found on
>> @@ -52,7 +52,7 @@ config SURFACE_GPE
>>   
>>   config SURFACE_PRO3_BUTTON
>>   	tristate "Power/home/volume buttons driver for Microsoft Surface Pro 3/4 tablet"
>> -	depends on ACPI && INPUT
>> +	depends on INPUT
>>   	help
>>   	  This driver handles the power/home/volume buttons on the Microsoft Surface Pro 3/4 tablet.
>>   
>>
> 
