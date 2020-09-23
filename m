Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C171C275C1C
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 17:39:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726808AbgIWPj0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 11:39:26 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38706 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726504AbgIWPj0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 11:39:26 -0400
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1600875564;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8P5nh1hHFJMcXSIFglTL/dkQO46cDnS5dRP0Pby4DDU=;
        b=cILKIfjdX4VZRqjlygmnlMUPZ8ZCV4Y5zWGH+qGPKVGMJlwuFrRMH6JMfwAkvs0eiZhBPR
        mf0U2OblZ4Y0OHb6tf+gr9RY7wtq0ejgkN9RLf6/Jq89v8kWXCMWVK+r1k+hU4j34ZGrTD
        Mg9p1pDdRSH/8Ahzq6rwiUjp3lJ8TZU9++Ui+g/Kwo9mS/sU1ycQ9PVF0d2dHA0OcxAWW+
        rMWJxV4ffSrmybd+2vA/tk675bMMMftunHOE1RWhzXmv4cNgl27bMakApggyFS72A4V4ff
        ibI25jRtovWBlib/4b7wu2P39/qgIZoGczz/bmjpJASUcMg2qsq8VhMYFVKejw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1600875564;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8P5nh1hHFJMcXSIFglTL/dkQO46cDnS5dRP0Pby4DDU=;
        b=1fIvXz/LPCrYRROHh5IdMsr6ODDrDu9eQ8HAqBvbkJZ6/qSyw5l/EcsrDy5OupTBr5f3vA
        3v45/GoEQY0o6YBw==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk 2/5] printk: kmsg_dump_rewind_nolock: start from first record
In-Reply-To: <20200923145208.GB6442@alley>
References: <20200922153816.5883-1-john.ogness@linutronix.de> <20200922153816.5883-3-john.ogness@linutronix.de> <20200923145208.GB6442@alley>
Date:   Wed, 23 Sep 2020 17:45:23 +0206
Message-ID: <87lfh0zems.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-09-23, Petr Mladek <pmladek@suse.com> wrote:
>> kmsg_dump_rewind_nolock() accesses @clear_seq without any locking.
>> However, accessing this global variable requires holding
>> @logbuf_lock. For the _nolock() variant, start from the first record
>> in the ringbuffer rather than the @clear_seq record.
>
>> Signed-off-by: John Ogness <john.ogness@linutronix.de>
>> ---
>>  kernel/printk/printk.c | 8 +++++---
>>  1 file changed, 5 insertions(+), 3 deletions(-)
>> 
>> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
>> index 00bc1fce3299..cff13b33e926 100644
>> --- a/kernel/printk/printk.c
>> +++ b/kernel/printk/printk.c
>> @@ -3410,11 +3410,12 @@ EXPORT_SYMBOL_GPL(kmsg_dump_get_buffer);
>>   * kmsg_dump_get_buffer() can be called again and used multiple
>>   * times within the same dumper.dump() callback.
>>   *
>> - * The function is similar to kmsg_dump_rewind(), but grabs no locks.
>> + * The function is similar to kmsg_dump_rewind(), but grabs no locks
>> + * and starts from the oldest record rather than from @clear_seq.
>>   */
>>  void kmsg_dump_rewind_nolock(struct kmsg_dumper *dumper)
>>  {
>> -	dumper->cur_seq = clear_seq;
>> +	dumper->cur_seq = 0;
>
> Just to understand it. Is the problem that the value might be in
> an inconsistent state?
>
> I mean that it might be modified by more instructions, for example,
> because of compiler optimizations or on 32-bit system by definition.

Correct.

> I still have to look at the later patches. But it seems that
> the new syslog_lock is taken mostly only around reading or
> writing the global @clear_seq variable. Atomic variable might
> do the same job.

Until now I have avoided using atomic64 types. Perhaps my reluctance to
use this type is unfounded. Using an atomic64 for @clear_seq would free
it from needing to be protected by @syslog_lock.

John Ogness
