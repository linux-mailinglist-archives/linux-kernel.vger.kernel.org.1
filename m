Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A86792A2D14
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 15:38:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726104AbgKBOiM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 09:38:12 -0500
Received: from smtpcmd0986.aruba.it ([62.149.156.86]:42902 "EHLO
        smtpcmd0986.aruba.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725927AbgKBOiL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 09:38:11 -0500
X-Greylist: delayed 424 seconds by postgrey-1.27 at vger.kernel.org; Mon, 02 Nov 2020 09:38:10 EST
Received: from [192.168.1.132] ([93.146.66.165])
        by Aruba Outgoing Smtp  with ESMTPSA
        id ZarNkKa7aboZEZarNkb3Y0; Mon, 02 Nov 2020 15:31:05 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
        t=1604327465; bh=3lAxSQ5YNmharAPVFah3JlpZIkAdwJG902U33iTrXYE=;
        h=Subject:To:From:Date:MIME-Version:Content-Type;
        b=fG0N2YPNj74VmgbI7FwElNQ6sAJs4jYtKfdZbhH1FYOSUmdhUCVQLN/AxdETnQgW2
         ufSKv75Dn/fcDRkBzt/wtnULNYAh5uoiNfQdzDJlGgoLzKk3QJT1nE4cqr3i8p/VOe
         7tYmYWn/tFGTxsPz13RJSfuUMA29UAJ9mITug6J0xFf/suY3IVCai02quDS1yjBemq
         FtFDe09GikWTs9wZ5mzTk/l0YY1dFx3ip/DLBSX5lS/3a1tPQc53GZqbnwSijUzowE
         Wp06jmdmLadfh/4UbxazFAKZ/jun0bwDMiTwS8mU1cWC8RtVMqM00BD6zGPiO84wzP
         +4ODwiQUZBKFg==
Subject: Re: [PATCH 1/2] misc: c2port: core: Make copying name from userspace
 more secure
To:     Lee Jones <lee.jones@linaro.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Cc:     David Laight <David.Laight@aculab.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Eurotech S.p.A" <info@eurotech.it>,
        Geert Uytterhoeven <geert+renesas@glider.be>
References: <20201102111211.1047972-1-lee.jones@linaro.org>
 <d7b2a5d8d46e4f7885315ea4aa032b8c@AcuMS.aculab.com>
 <20201102114903.GN4127@dell> <20201102121150.GA663356@kroah.com>
 <20201102124301.GC4488@dell> <20201102125910.GA1008111@kroah.com>
 <20201102134729.GD4488@dell>
From:   Rodolfo Giometti <giometti@enneenne.com>
Message-ID: <9f10500a-cfd7-bcbe-7b8e-edd49ab4d43c@enneenne.com>
Date:   Mon, 2 Nov 2020 15:31:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201102134729.GD4488@dell>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfMyb0xvHTQ86GLJYTjOFgBmnOUERpsg7xM2enmdqqyHSyksUOLIgDDLgJC40Te3nw2wb+BR5Kzy2ZrLkbqVdUZs+RTgS83jBZT9zuYmt77tJuWTz3EZP
 3sziKfkC7EmBWqjN4ZPN3Txjkj9HYcj3t/QhTlLZ06j/JSociUw9Wq8dc5Q3Qpy9W72JhFeTp1eT/ZOTZ2K7Vy6EpAHLLggeAMZjBFhnzUjG3SYsZ/qalBql
 dDPlhF0SLU5PhSbIkK4nlCJMtraTgkgg5rYvikYwpU0RkjZ08fNzDcXjmgxj0Gp5OYIIt53D0aNMrYmsZmVlDAg+h4hE93kRVTrMcw8I1IFL3Q6d+q8iQenU
 3mlea6eMyaOswEzqdQduFl841X5yIA==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/11/2020 14:47, Lee Jones wrote:
> On Mon, 02 Nov 2020, gregkh@linuxfoundation.org wrote:
> 
>> On Mon, Nov 02, 2020 at 12:43:01PM +0000, Lee Jones wrote:
>>> On Mon, 02 Nov 2020, gregkh@linuxfoundation.org wrote:
>>>
>>>> On Mon, Nov 02, 2020 at 11:49:03AM +0000, Lee Jones wrote:
>>>>> On Mon, 02 Nov 2020, David Laight wrote:
>>>>>
>>>>>> From: Lee Jones
>>>>>>> Sent: 02 November 2020 11:12
>>>>>>>
>>>>>>> strncpy() may not provide a NUL terminator, which means that a 1-byte
>>>>>>> leak would be possible *if* this was ever copied to userspace.  Ensure
>>>>>>> the buffer will always be NUL terminated by using the kernel's
>>>>>>> strscpy() which a) uses the destination (instead of the source) size
>>>>>>> as the bytes to copy and b) is *always* NUL terminated.
>>>>>>>
>>>>>>> Cc: Rodolfo Giometti <giometti@enneenne.com>
>>>>>>> Cc: "Eurotech S.p.A" <info@eurotech.it>
>>>>>>> Reported-by: Geert Uytterhoeven <geert+renesas@glider.be>
>>>>>>> Acked-by: Arnd Bergmann <arnd@arndb.de>
>>>>>>> Signed-off-by: Lee Jones <lee.jones@linaro.org>
>>>>>>> ---
>>>>>>>  drivers/misc/c2port/core.c | 2 +-
>>>>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>>>
>>>>>>> diff --git a/drivers/misc/c2port/core.c b/drivers/misc/c2port/core.c
>>>>>>> index 80d87e8a0bea9..b96444ec94c7e 100644
>>>>>>> --- a/drivers/misc/c2port/core.c
>>>>>>> +++ b/drivers/misc/c2port/core.c
>>>>>>> @@ -923,7 +923,7 @@ struct c2port_device *c2port_device_register(char *name,
>>>>>>>  	}
>>>>>>>  	dev_set_drvdata(c2dev->dev, c2dev);
>>>>>>>
>>>>>>> -	strncpy(c2dev->name, name, C2PORT_NAME_LEN - 1);
>>>>>>> +	strscpy(c2dev->name, name, sizeof(c2dev->name));
>>>>>>
>>>>>> strscpy() doesn't zero fill so if the memory isn't zeroed
>>>>>> and a 'blind' copy to user of the structure is done
>>>>>> then more data is leaked.
>>>>>>
>>>>>> strscpy() may be better, but rational isn't right.
>>>>>
>>>>> The original patch zeroed the data too, but I was asked to remove that
>>>>> part [0].  In your opinion, should it be reinstated?
>>>>>
>>>>> [0] https://lore.kernel.org/patchwork/patch/1272290/
>>>>
>>>> Just keep the kzalloc() part of the patch, this portion makes no sense
>>>> to me.
>>>
>>> Can do.
>>>
>>>> But if you REALLY want to get it correct, call dev_set_name()
>>>> instead please, as that is what it is there for.
>>>
>>> The line above isn't setting the 'struct device' name.  It looks as
>>> though 'struct c2port' has it's own member, also called 'name'.  As to
>>> how they differ, I'm not currently aware.  Nor do I wish to mess
>>> around with the semantics all that much.
>>>
>>> Going with suggestion #1.
>>
>> As the "device" already has a name, I suggest just getting rid of this
>> name field anyway, no need for duplicates.
> 
> That definitely goes against the point I made above:
> 
>  "Nor do I wish to mess around with the semantics all that much."
> 
> It looks as though the device name 'c2port%d' varies greatly to the
> requested name 'uc'.  I don't have enough knowledge of how user-
> space expects to use the provided sysfs entries to be able to
> competently merge/decide which of these should be kept and which to
> discard.
> 
> Hopefully one of the authors/maintainers are reading this and can come
> up with an acceptable solution.

User-space usage can change its behavior so, please, consider the best solution
from the kernel space point-of-view. :)

Ciao,

Rodolfo

-- 
GNU/Linux Solutions                  e-mail: giometti@enneenne.com
Linux Device Driver                          giometti@linux.it
Embedded Systems                     phone:  +39 349 2432127
UNIX programming                     skype:  rodolfo.giometti
