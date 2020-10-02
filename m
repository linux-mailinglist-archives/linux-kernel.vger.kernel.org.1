Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B013280C97
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 06:07:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725981AbgJBEHz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 00:07:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725914AbgJBEHz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 00:07:55 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEB36C0613D0;
        Thu,  1 Oct 2020 21:07:54 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id g96so177344otb.12;
        Thu, 01 Oct 2020 21:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=J5GrRVSlClah3E4nsiJ7MNCSpkwJ4plq04uXY2JVLuI=;
        b=CopYgyXeQ0AGehLN9euf0so8LitjD2PHgMC/x8bcYBu/JlMRnNZ+EqSL5qcjj/gkwd
         tXn6sc38yvI9W2RI2/Cd4S6TBtRiNCap1CF4OExxI7CsVFIz42TdrWcu6rrmG0BBSm3y
         HJqmVwUm34BTVvdl+zPd4hBlwVaY+p2Knj8i9xam/MBjh7r7CoEoX8vDQn69ZuWzMhBJ
         jgpp/4fNtHD935rN/lZfLkgkB1zUlbhCg04wK1j0iTW8dVyndLq3kc5MRtT2LqL7JwQp
         3QOg+bzoDIXJEsnsicOhz/mVyHXHEYh8zpQANBZDvA9ghKsM28GzM2YWiyDFnmwwdO/h
         Efbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=J5GrRVSlClah3E4nsiJ7MNCSpkwJ4plq04uXY2JVLuI=;
        b=Aha5MBqT45rxZRjikfCz6y2r+VOKIxF/kEvC/MpVoe1TTer1Oxu/hkErAF2vFPLolh
         gFwzPCy9ldfWlzcFUil/+18hm5Qy9mshvvzNQzJkAMeOWciz3WdjWVvcSGzwrlw5IOOm
         IIrKYVukaXXNSKXchScFQ0xLwBnCpN9q9f1B0/ANfoAkqBglNmGJEEinaAOfur/gGOWB
         IKN2liRrvynLIjJFZp6Z8SLiuYfogC39P4P411wV/WuKhEY8xrc0+NkA6kPuLFc4eiFj
         bgBgMWwc6eCTfQybUpGEz1qVWfraiLjbRwtlSTDcMvUUbNOQhQPQ+xAl9pIesXdvFCH2
         YhLA==
X-Gm-Message-State: AOAM532Nz0yotXkpx6WYTQXFkM+LtzBwkLOIUW84xsKP/AhufCWtQ0ya
        wZtf05nKU5cCW1agi2MYgn6ziEUduOQ=
X-Google-Smtp-Source: ABdhPJz3Mr8MLWe6sUMELNBKhiFjsK4leERHRrMpDdKcU9ThBQshhqqmAGEtJ5TXS1Bhm+ZG/SYy1g==
X-Received: by 2002:a9d:7a9:: with SMTP id 38mr373322oto.280.1601611674002;
        Thu, 01 Oct 2020 21:07:54 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id o9sm130372oop.1.2020.10.01.21.07.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Oct 2020 21:07:53 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [REGRESSION] hwmon: (applesmc) avoid overlong udelay()
To:     Andreas Kemnade <andreas@kemnade.info>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     rydberg@bitmath.org, Jean Delvare <jdelvare@suse.com>,
        linux-hwmon@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20200930105442.3f642f6c@aktux>
 <20200930164446.GB219887@roeck-us.net>
 <CAK8P3a2CbhJT+B-F+cnX+uiJep9oiLM28n045-ATaVaU41u2hw@mail.gmail.com>
 <20201002002251.28462e64@aktux>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <7543ef85-727d-96c3-947e-5b18e9e6c44d@roeck-us.net>
Date:   Thu, 1 Oct 2020 21:07:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201002002251.28462e64@aktux>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/1/20 3:22 PM, Andreas Kemnade wrote:
> On Wed, 30 Sep 2020 22:00:09 +0200
> Arnd Bergmann <arnd@arndb.de> wrote:
> 
>> On Wed, Sep 30, 2020 at 6:44 PM Guenter Roeck <linux@roeck-us.net> wrote:
>>>
>>> On Wed, Sep 30, 2020 at 10:54:42AM +0200, Andreas Kemnade wrote:  
>>>> Hi,
>>>>
>>>> after the $subject patch I get lots of errors like this:  
>>>
>>> For reference, this refers to commit fff2d0f701e6 ("hwmon: (applesmc)
>>> avoid overlong udelay()").
>>>  
>>>> [  120.378614] applesmc: send_byte(0x00, 0x0300) fail: 0x40
>>>> [  120.378621] applesmc: LKSB: write data fail
>>>> [  120.512782] applesmc: send_byte(0x00, 0x0300) fail: 0x40
>>>> [  120.512787] applesmc: LKSB: write data fail
>>>>
>>>> CPU sticks at low speed and no fan is turning on.
>>>> Reverting this patch on top of 5.9-rc6 solves this problem.
>>>>
>>>> Some information from dmidecode:
>>>>
>>>> Base Board Information
>>>>         Manufacturer: Apple Inc.
>>>>         Product Name: Mac-7DF21CB3ED6977E5
>>>>         Version: MacBookAir6,2
>>>>
>>>> Handle 0x0020, DMI type 11, 5 bytes OEM Strings         String 1: Apple ROM Version.  Model:       …,
>>>> Handle 0x0020, DMI type 11, 5 bytes
>>>> OEM Strings
>>>>         String 1: Apple ROM Version.  Model:        MBA61.  EFI Version:  122.0.0
>>>>         String 2: .0.0.  Built by:     root@saumon.  Date:         Wed Jun 10 18:
>>>>         String 3: 10:36 PDT 2020.  Revision:     122 (B&I).  ROM Version:  F000_B
>>>>         String 4: 00.  Build Type:   Official Build, Release.  Compiler:     Appl
>>>>         String 5: e clang version 3.0 (tags/Apple/clang-211.10.1) (based on LLVM
>>>>         String 6: 3.0svn).
>>>>
>>>> Writing to things in /sys/devices/platform/applesmc.768 gives also the
>>>> said errors.
>>>> But writing 1 to fan1_maunal and 5000 to fan1_output turns the fan on
>>>> despite error messages.
>>>>  
>>> Not really sure what to do here. I could revert the patch, but then we'd gain
>>> clang compile failures. Arnd, any idea ?  
>>
>> It seems that either I made a mistake in the conversion and it sleeps for
>> less time than before, or my assumption was wrong that converting a delay to
>> a sleep is safe here.
>>
>> The error message indicates that the write fails, not the read, so that
>> is what I'd look at first. Right away I can see that the maximum time to
>> retry is only half of what it used to be, as we used to wait for
>> 0x10, 0x20, 0x40, 0x80, ..., 0x20000 microseconds for a total of
>> 0x3fff0 microseconds (262ms), while my patch went with the 131ms
>> total delay based on the comment saying "/* wait up to 128 ms for a
>> status change. */".
>>
> Yes, that is also what I read from the code. I just thought there must
> be something simple, which just needs a short look from another pair of
> eyes.
> 
>> Since there is sleeping wait, I see no reason the timeout couldn't
>> be extended a lot, e.g. to a second, as in
>>
>> #define APPLESMC_MAX_WAIT 0x100000
>>
>> If that doesn't work, I'd try using mdelay() in place of
>> usleep_range(), such as
>>
>>            mdelay(DIV_ROUND_UP(us, USEC_PER_MSEC)));
>>
>> This adds back a really nasty latency, but it should avoid the
>> compile-time problem.
>>
>> Andreas, can you try those two things? (one at a time,
>> not both)
> 
> Ok, I tried. None of them works. I rechecked my work and created real
> git commits out of them and CONFIG_LOCALVERSION_AUTO is also set so
> the usual stupid things are rules out.
> In detail:
> On top of 5.9-rc6 + *reverted* patch:
> diff --git a/drivers/hwmon/applesmc.c b/drivers/hwmon/applesmc.c
> index fd99c9df8a00..2a9bd7f2b71b 100644
> --- a/drivers/hwmon/applesmc.c
> +++ b/drivers/hwmon/applesmc.c
> @@ -45,7 +45,7 @@
>  /* wait up to 128 ms for a status change. */
>  #define APPLESMC_MIN_WAIT	0x0010
>  #define APPLESMC_RETRY_WAIT	0x0100
> -#define APPLESMC_MAX_WAIT	0x20000
> +#define APPLESMC_MAX_WAIT	0x8000
>  
>  #define APPLESMC_READ_CMD	0x10
>  #define APPLESMC_WRITE_CMD	0x11
> 

Oh man, that code is so badlys broken.

send_byte() repeats sending the data if it was not immediately successful.
That is done for both data and commands. Effectively that happens if
the command is not immediately accepted. However, send_argument()
clearly assumes that each data byte is sent exactly once. Sending
it more than once will mess up the key that is supposed to be sent.
The Apple SMC emulation code in qemu confirms that data bytes can not
be written more than once.

Of course, theoretically it may be that the first data byte was not
accepted (after all, the ACK bit is not set), but the ACK bit is
not checked again after udelay(APPLESMC_RETRY_WAIT), so it may
well have been set in the 256 uS between its check and re-writing
the data.

In other words, this entire code only works accidentally to start with.

If you like, you could play around with the code and find out if and
when exactly bit 1 (busy) is set, if and when bit 2 (ack) is set, and
if and when any other bit is set. We could also try to read port 0x31e
(the error port). Maybe the we can figure out what the error actually
is. But then I don't really know what we could do with that information.

Other than that, the only useful idea I have is something crazy like
	if (us < 10000)
		udelay(us);
	else
		mdelay(DIV_ROUND_CLOSEST(udelay, 1000));
in the hope that clang doesn't convert that back into a
compile-time constant and udelay().

Overall it seems like the apple protocol may expect to receive data
bytes faster than 1ms apart, because that is the only real difference
between the original code and the new code using mdelay().

Guenter
