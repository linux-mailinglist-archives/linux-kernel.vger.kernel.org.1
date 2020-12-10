Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0DFC2D5936
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 12:31:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389124AbgLJL36 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 06:29:58 -0500
Received: from imap3.hz.codethink.co.uk ([176.9.8.87]:60774 "EHLO
        imap3.hz.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731999AbgLJL36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 06:29:58 -0500
Received: from 05446273.skybroadband.com ([5.68.98.115] helo=[192.168.0.21])
        by imap3.hz.codethink.co.uk with esmtpsa  (Exim 4.92 #3 (Debian))
        id 1knK8I-0000bj-8C; Thu, 10 Dec 2020 11:29:14 +0000
Subject: Re: [linux-safety] [PATCH] kernel: trace: Remove deadstore in
 trace_uprobe.c
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-safety@lists.elisa.tech
References: <1607519814-86271-1-git-send-email-milan.lakhani@codethink.co.uk>
 <CAKXUXMzTpOT3MJLkmjR_Hpak8K5a7GQ-vTtNp0GbNarD6NG1FA@mail.gmail.com>
From:   Milan Lakhani <milan.lakhani@codethink.co.uk>
Message-ID: <ee9d9a8c-53de-01d2-7489-6f650857013b@codethink.co.uk>
Date:   Thu, 10 Dec 2020 11:29:13 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAKXUXMzTpOT3MJLkmjR_Hpak8K5a7GQ-vTtNp0GbNarD6NG1FA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/12/2020 05:47, Lukas Bulwahn wrote:
> On Wed, Dec 9, 2020 at 2:17 PM Milan Lakhani
> <milan.lakhani@codethink.co.uk> wrote:
>> In trace_uprobe.c, trace_uprobe_create assigns ret to 0 but then never
>> uses this value.
>>
> Milan, the patch makes sense, but I fear you did not run
> ./scripts/get_maintainers.pl because you did not include any specific
> maintainer as recipient.

So I did actually run get_maintainers.pl but somehow in my text editor 
where I had pasted the e-mail addresses they had got onto two separate 
lines, and git send-email must have only taken the first line. I'll have 
to get the e-mails right first time next time, to move onto checking 
documentation!

> The patch subject could be: remove unneeded initialization (instead of
> the very generic "dead store" term).
Updated this, thanks
>
> It is also interesting to see who added this initialization; was it
> unneeded since the existence of this function, did it become obsolete
> at some point in time due to refactoring?

The line was unneeded since the function was created in 2012 by Srikar 
Dronamraju in f3f096cfe, there have actually somehow been six commits to 
the lines between the initial assignment and reassignment of ret but 
they have all left the unnecessary initialization there!

>
> Run ./scripts/get_maintainers.pl  and please CC: me; then you will get
> your Reviewed-by: tag.
>
> Lukas
>
>> Signed-off-by: Milan Lakhani <milan.lakhani@codethink.co.uk>
>> ---
>>   kernel/trace/trace_uprobe.c | 1 -
>>   1 file changed, 1 deletion(-)
>>
>> diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
>> index 3cf7128..c7c7070 100644
>> --- a/kernel/trace/trace_uprobe.c
>> +++ b/kernel/trace/trace_uprobe.c
>> @@ -541,7 +541,6 @@ static int trace_uprobe_create(int argc, const char **argv)
>>          bool is_return = false;
>>          int i, ret;
>>
>> -       ret = 0;
>>          ref_ctr_offset = 0;
>>
>>          switch (argv[0][0]) {
>> --
>> 2.7.4
>>
