Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7B59296131
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 16:53:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S368282AbgJVOxT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 10:53:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S368275AbgJVOxR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 10:53:17 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54964C0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 07:53:17 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1603378395;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=O0H/03sI53oZZCAYw4B2lRGz8cXK5h4OEQ0DMNG/lhA=;
        b=GKkfNcEVprEweNcn+AN6OjYO0EpUqi59ggnM9SIPh+1CdeWZMo/556tPnun6HECXqzVXz4
        RHtJgVCBFDMtCSz0+8gXTOldB8cQOrclDLA6grM3jh3Dt1gimzN3OTXQmpz56ViW9URqpe
        gcq9yLZgYvOFsN/5T9NZtlXX42Q7ILp87j85E3lCd+hJqeY5AJdIkb4b0DDaElY1xIeAGc
        u0evnKjYAzBwETrahlRUDTgF/2Y/B7rlRBx9gvYXSFQ1sjyXIUc+ew5WABbRaSqHfM+mjO
        2TmmjRnM8u/wwkN8Dl8Ib4L+ywxdP9AAbvKS5/VE38rC09pga4f9pufX49joVQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1603378395;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=O0H/03sI53oZZCAYw4B2lRGz8cXK5h4OEQ0DMNG/lhA=;
        b=KZ8nxtGRqM+Qxs4tbXK2nONuM6YJ0B3NjFR2Ss1/Oe/k1CrOCik3UETmKSMrQJ0AZeroeT
        eJypfzFDcP9tJcAA==
To:     Guenter Roeck <linux@roeck-us.net>, Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Shreyas Joshi <shreyas.joshi@biamp.com>,
        shreyasjoshi15@gmail.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC 1/2] printk: Add kernel parameter: mute_console
In-Reply-To: <5a30b3e8-c2c3-ceae-517e-c93fb2c3118f@roeck-us.net>
References: <20201022114228.9098-1-pmladek@suse.com> <20201022114228.9098-2-pmladek@suse.com> <87a6wez9s4.fsf@jogness.linutronix.de> <5a30b3e8-c2c3-ceae-517e-c93fb2c3118f@roeck-us.net>
Date:   Thu, 22 Oct 2020 16:59:15 +0206
Message-ID: <877driz50k.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-10-22, Guenter Roeck <linux@roeck-us.net> wrote:
>>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
>>> index 02d4adbf98d2..52b9e7f5468d 100644
>>> --- a/Documentation/admin-guide/kernel-parameters.txt
>>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>>> @@ -2974,6 +2974,12 @@
>>>  			Used for mtrr cleanup. It is spare mtrr entries number.
>>>  			Set to 2 or more if your graphical card needs more.
>>>  
>>> +	mute_console	[KNL]
>>> +			Completely disable printing of kernel messages to
>>> +			the console. It can still be used as stdin, stdout,
>
> "to all consoles"
>
>>> +			and stderr for the init process. Also it can be used
>>> +			for login.
>> 
>> IMHO it would make more sense for this to be a console option:
>> 
>>     console=ttyS0,115200,mute
>> 
>> Then other consoles could still exist that are not muted.
>> 
> Then why specify this console in the first place ?

Because you may still want to use it for stdin/stdout/stderr of PID 1
and/or logins. I understood "mute" as meaning the user does not want to
see kernel logging. But everything else should still work as usual.

>> On a side note, I am considering proposing something similar for my
>> printk-rework efforts. Once console printers are moved to kthreads, some
>> users may not care about latencies and instead prefer synchronous
>> printing. My idea for this is to provide a "sync" option for the
>> console:
>> 
>>     console=ttyS0,115200,sync
>
> The whole point of the exercise is to disable all consoles, including
> default ones which are not explicitly specified on the command line.

In that case I think specifying something like:

    console=null

makes that most sense. I think implementing a "null console" driver
would be quite simple. Then there would be no need for special handling
in the printk subsystem.

John Ogness
