Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 663222A3FDB
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 10:21:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726211AbgKCJUh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 04:20:37 -0500
Received: from smtpcmd0987.aruba.it ([62.149.156.87]:42265 "EHLO
        smtpcmd0987.aruba.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbgKCJUg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 04:20:36 -0500
Received: from [192.168.1.132] ([93.146.66.165])
        by Aruba Outgoing Smtp  with ESMTPSA
        id ZsUMk9eeRiwdrZsUMkir2k; Tue, 03 Nov 2020 10:20:31 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
        t=1604395231; bh=p3NYnEsBV1+gOzvEA4H7wP3MD4VfueeB7ja3XqlV1qA=;
        h=Subject:To:From:Date:MIME-Version:Content-Type;
        b=DPtPYg8actwqXljbQjOBvwnwnM1Ff7/dTyd6BqH2rOuyZLQOI0o1JCBm6hs5A/9hg
         TUGN0ch5GA8/HEV9tv4jSh17/KQNqwFT7eNi0LEEZGtDv73qU3rLhfcyvv7jWt6imi
         DADrbZTiR3POX0P1dgwAtpn3xayjEEyLUICqWv1RlepWxJEy51iz+ISlPTxeexzINa
         scH6jBS2rChASFNulGmgFVUpr8wZxV2jy1qq4jcKxp6znq6tVuHHL2slDtL/adHRJf
         eDp/GPPNySupe5KaqZ4wprdD4aqOoEngQY5rDoKIXydZHuW8ecVt9gnVvW+5piAdRA
         81r1ARQ+8SgRQ==
Subject: Re: [PATCH 1/2] misc: c2port: core: Make copying name from userspace
 more secure
To:     Lee Jones <lee.jones@linaro.org>
Cc:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        David Laight <David.Laight@aculab.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Eurotech S.p.A" <info@eurotech.it>,
        Geert Uytterhoeven <geert+renesas@glider.be>
References: <20201102111211.1047972-1-lee.jones@linaro.org>
 <d7b2a5d8d46e4f7885315ea4aa032b8c@AcuMS.aculab.com>
 <20201102114903.GN4127@dell> <20201102121150.GA663356@kroah.com>
 <20201102124301.GC4488@dell> <20201102125910.GA1008111@kroah.com>
 <20201102134729.GD4488@dell>
 <9f10500a-cfd7-bcbe-7b8e-edd49ab4d43c@enneenne.com>
 <20201103085726.GN4488@dell>
From:   Rodolfo Giometti <giometti@enneenne.com>
Message-ID: <82957cb2-0ad0-8b26-cfdc-2482efb3f7b5@enneenne.com>
Date:   Tue, 3 Nov 2020 10:20:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201103085726.GN4488@dell>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfO4mtq8keX3eKwLVlULaMK/t6hE2iJWGNFpCR/+9VEEoOJvwzgnIGNgkigcAf3Lj0gOrxKMVQLx/PGt8aZEYkn7LyzeCv7RWqHecIuKY3bYPUvHDHiBK
 dd4NPvf3Tg5oQf60A+4lNRJ3l7+oi/3L6N6d6MDjdrlSGgGlH5q8hZVwsQS8w15i8QJGhqa68ih5IOqpqwxrzZtsz7p2xqQYPizOj54jWrGs9nTXNHpYrUtM
 wiV1QViy/63O0fSXApBZUYy9L5zNosTTvffetNl7kX18ptL/6qLXlULYvRtp2SErZ81LBo923kMgQLGY36S6rQzdcu/SJljDn4a9Cui8wpC/VcnmGsNRENVO
 LPOP3hVlg0OZEuSkIiOWuRXnEglf4Q==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/11/2020 09:57, Lee Jones wrote:
> On Mon, 02 Nov 2020, Rodolfo Giometti wrote:
> 
>> On 02/11/2020 14:47, Lee Jones wrote:
>>> On Mon, 02 Nov 2020, gregkh@linuxfoundation.org wrote:
>>>
>>>> On Mon, Nov 02, 2020 at 12:43:01PM +0000, Lee Jones wrote:
>>>>> On Mon, 02 Nov 2020, gregkh@linuxfoundation.org wrote:
>>>>>
>>>>>> On Mon, Nov 02, 2020 at 11:49:03AM +0000, Lee Jones wrote:
>>>>>>> On Mon, 02 Nov 2020, David Laight wrote:
>>>>>>>
>>>>>>>> From: Lee Jones
>>>>>>>>> Sent: 02 November 2020 11:12
>>>>>>>>>
>>>>>>>>> strncpy() may not provide a NUL terminator, which means that a 1-byte
>>>>>>>>> leak would be possible *if* this was ever copied to userspace.  Ensure
>>>>>>>>> the buffer will always be NUL terminated by using the kernel's
>>>>>>>>> strscpy() which a) uses the destination (instead of the source) size
>>>>>>>>> as the bytes to copy and b) is *always* NUL terminated.
>>>>>>>>>
>>>>>>>>> Cc: Rodolfo Giometti <giometti@enneenne.com>
>>>>>>>>> Cc: "Eurotech S.p.A" <info@eurotech.it>
>>>>>>>>> Reported-by: Geert Uytterhoeven <geert+renesas@glider.be>
>>>>>>>>> Acked-by: Arnd Bergmann <arnd@arndb.de>
>>>>>>>>> Signed-off-by: Lee Jones <lee.jones@linaro.org>
>>>>>>>>> ---
>>>>>>>>>  drivers/misc/c2port/core.c | 2 +-
>>>>>>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>>>>>
>>>>>>>>> diff --git a/drivers/misc/c2port/core.c b/drivers/misc/c2port/core.c
>>>>>>>>> index 80d87e8a0bea9..b96444ec94c7e 100644
>>>>>>>>> --- a/drivers/misc/c2port/core.c
>>>>>>>>> +++ b/drivers/misc/c2port/core.c
>>>>>>>>> @@ -923,7 +923,7 @@ struct c2port_device *c2port_device_register(char *name,
>>>>>>>>>  	}
>>>>>>>>>  	dev_set_drvdata(c2dev->dev, c2dev);
>>>>>>>>>
>>>>>>>>> -	strncpy(c2dev->name, name, C2PORT_NAME_LEN - 1);
>>>>>>>>> +	strscpy(c2dev->name, name, sizeof(c2dev->name));
>>>>>>>>
>>>>>>>> strscpy() doesn't zero fill so if the memory isn't zeroed
>>>>>>>> and a 'blind' copy to user of the structure is done
>>>>>>>> then more data is leaked.
>>>>>>>>
>>>>>>>> strscpy() may be better, but rational isn't right.
>>>>>>>
>>>>>>> The original patch zeroed the data too, but I was asked to remove that
>>>>>>> part [0].  In your opinion, should it be reinstated?
>>>>>>>
>>>>>>> [0] https://lore.kernel.org/patchwork/patch/1272290/
>>>>>>
>>>>>> Just keep the kzalloc() part of the patch, this portion makes no sense
>>>>>> to me.
>>>>>
>>>>> Can do.
>>>>>
>>>>>> But if you REALLY want to get it correct, call dev_set_name()
>>>>>> instead please, as that is what it is there for.
>>>>>
>>>>> The line above isn't setting the 'struct device' name.  It looks as
>>>>> though 'struct c2port' has it's own member, also called 'name'.  As to
>>>>> how they differ, I'm not currently aware.  Nor do I wish to mess
>>>>> around with the semantics all that much.
>>>>>
>>>>> Going with suggestion #1.
>>>>
>>>> As the "device" already has a name, I suggest just getting rid of this
>>>> name field anyway, no need for duplicates.
>>>
>>> That definitely goes against the point I made above:
>>>
>>>  "Nor do I wish to mess around with the semantics all that much."
>>>
>>> It looks as though the device name 'c2port%d' varies greatly to the
>>> requested name 'uc'.  I don't have enough knowledge of how user-
>>> space expects to use the provided sysfs entries to be able to
>>> competently merge/decide which of these should be kept and which to
>>> discard.
>>>
>>> Hopefully one of the authors/maintainers are reading this and can come
>>> up with an acceptable solution.
>>
>> User-space usage can change its behavior so, please, consider the best solution
>> from the kernel space point-of-view. :)
> 
> If you're sure, I can add it to my TODO.

Yes, no problem!

Ciao,

Rodolfo

-- 
GNU/Linux Solutions                  e-mail: giometti@enneenne.com
Linux Device Driver                          giometti@linux.it
Embedded Systems                     phone:  +39 349 2432127
UNIX programming                     skype:  rodolfo.giometti
