Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20B3F2D073F
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Dec 2020 22:07:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728098AbgLFVHG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Dec 2020 16:07:06 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:60140 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727009AbgLFVHG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Dec 2020 16:07:06 -0500
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607288784;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0MM71/X1YSuBbs7pM5Y2HvUTqaJG+g9U4dmtDiPkquA=;
        b=YxKWBH59AUp1/bCFRxhKmeGVvr1nMMdJADm5YVcpcUL3e3gRL4HPTFp3+/3ELXGFWsJoH1
        fhk1NZkXPy8g+RG4rxDtsumRLmMtTKKpErJ1XRrYJAHyb3wva4d48Tx0UCOujVnzECDh7S
        Vooe8Jgt8lDWddopk1xv6CS/Q2v85FnM+dLA1bTCQDLglKe/2fNrhxU+78Y0pKcqfkPyT1
        T7geONhh/nkid1LE7+WRDzP2ogikoWmSaArxRbnQUn0c6Ui6F9fv3Y6Jjdwf28AbZEWbda
        KsBmOC8wVEuBvzkS/wvGi3WEPT+LvjAj93TjHroIb7lvgEWmxROnfEuJhbR81A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607288784;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0MM71/X1YSuBbs7pM5Y2HvUTqaJG+g9U4dmtDiPkquA=;
        b=DnpCf3yZ36/y8QrTYA8d3txVQ/36P64ADiJpFzYQRRmJZmVBLdJ/+mIUgrbWKeXqjRUO3V
        tsiCoIRnsGtb0qAg==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: syslog: was: [PATCH next v2 3/3] printk: remove logbuf_lock, add syslog_lock
In-Reply-To: <X8pceqpK+sAudugq@alley>
References: <20201201205341.3871-1-john.ogness@linutronix.de> <20201201205341.3871-4-john.ogness@linutronix.de> <X8pceqpK+sAudugq@alley>
Date:   Sun, 06 Dec 2020 22:12:21 +0106
Message-ID: <87v9demype.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-12-04, Petr Mladek <pmladek@suse.com> wrote:
> On Tue 2020-12-01 21:59:41, John Ogness wrote:
>> Since the ringbuffer is lockless, there is no need for it to be
>> protected by @logbuf_lock. Remove @logbuf_lock.
>> 
>> --- a/kernel/printk/printk.c
>> +++ b/kernel/printk/printk.c
>> @@ -1490,19 +1444,30 @@ static int syslog_print_all(char __user *buf, int size, bool clear)
>>  		return -ENOMEM;
>>  
>>  	time = printk_time;
>> -	logbuf_lock_irq();
>>  	clr_seq = atomic64_read(&clear_seq);
>>  
>>  	/*
>>  	 * Find first record that fits, including all following records,
>>  	 * into the user-provided buffer for this dump.
>>  	 */
>> +
>>  	prb_for_each_info(clr_seq, prb, seq, &info, &line_count)
>>  		len += get_record_print_text_size(&info, line_count, true, time);
>>  
>> -	/* move first record forward until length fits into the buffer */
>> +	/*
>> +	 * Keep track of the latest in case new records are coming in fast
>> +	 * and overwriting the older records.
>> +	 */

Your suggestion to merge this and the next comment block is fine.

>> +	newest_seq = seq;
>> +
>> +	/*
>> +	 * Move first record forward until length fits into the buffer. This
>> +	 * is a best effort attempt. If @newest_seq is reached because the
>> +	 * ringbuffer is wrapping too fast, just start filling the buffer
>> +	 * from there.
>> +	 */
>
> It might be that I do not understand English well. But "start filling
> the buffer from there" sounds like we start filling the buffer from
> "newest_seq".
>
> What about the following?
>
> 	/*
> 	 * Move first record forward until length fits into the buffer.
> 	 * Ignore newest messages that were not counted in the above
> 	 * cycle. Messages might appear and get lost in the meantime.
> 	 * This is the best effort that prevents an infinite loop.
> 	 */
> 	newest_seq = seq;

OK.

>>  	prb_for_each_info(clr_seq, prb, seq, &info, &line_count) {
>> -		if (len <= size)
>> +		if (len <= size || info.seq > newest_seq)
>>  			break;
>>  		len -= get_record_print_text_size(&info, line_count, true, time);
>>  	}
>> @@ -1568,8 +1529,11 @@ int do_syslog(int type, char __user *buf, int len, int source)
>>  			return 0;
>>  		if (!access_ok(buf, len))
>>  			return -EFAULT;
>> +		spin_lock_irq(&syslog_lock);
>> +		seq = syslog_seq;
>> +		spin_unlock_irq(&syslog_lock);
>
> It would deserve a comment that the locking is needed to guarantee
> atomicity of the operation.

OK.

>>  		error = wait_event_interruptible(log_wait,
>> -				prb_read_valid(prb, syslog_seq, NULL));
>> +				prb_read_valid(prb, seq, NULL));
>>  		if (error)
>>  			return error;
>>  		error = syslog_print(buf, len);
>> @@ -2809,11 +2856,7 @@ void register_console(struct console *newcon)
>>  		nr_ext_console_drivers++;
>>  
>>  	if (newcon->flags & CON_PRINTBUFFER) {
>> -		/*
>> -		 * console_unlock(); will print out the buffered messages
>> -		 * for us.
>> -		 */
>> -		logbuf_lock_irqsave(flags);
>> +		spin_lock_irqsave(&syslog_lock, flags);
>
> We should take the lock only around assigning syslog_seq. And add a
> comment that it guarantees atomic update.

OK. So you just want "exclusive_console = newcon;" moved outside the
critical section.

>>  		/*
>>  		 * We're about to replay the log buffer.  Only do this to the
>>  		 * just-registered console to avoid excessive message spam to
>> @@ -2826,7 +2869,7 @@ void register_console(struct console *newcon)
>>  		exclusive_console = newcon;
>>  		exclusive_console_stop_seq = console_seq;
>>  		console_seq = syslog_seq;
>> -		logbuf_unlock_irqrestore(flags);
>> +		spin_unlock_irqrestore(&syslog_lock, flags);
>>  	}
>>  	console_unlock();
>>  	console_sysfs_notify();

John Ogness
