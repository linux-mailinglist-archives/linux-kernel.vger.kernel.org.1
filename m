Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7955D275D6E
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 18:30:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726684AbgIWQaV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 12:30:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:52598 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726130AbgIWQaV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 12:30:21 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1600878619;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=q+s08ZKwomqGTvtpI/bTN7Ngku3lKe8wcMiLgUuoPmI=;
        b=qEzBXxjnjFZkWo4307N2KocHP3URS9fsXyDBaPCDs5pE6gIn7eLHxMlvzqghkq15jNKwkK
        5XnRDo1eC8AK7mcXWaD9mY+gjcls67ko/4/EB14BF51AHapAbRKQHfRm8zXEgu1BhF8XT3
        KauyTHhXYmJKW7q+X3ZrRgVL6FWrM10=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id AE0F2ACA0;
        Wed, 23 Sep 2020 16:30:56 +0000 (UTC)
Date:   Wed, 23 Sep 2020 18:30:18 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk 4/5] printk: remove logbuf_lock, add syslog_lock
Message-ID: <20200923163018.GD6442@alley>
References: <20200922153816.5883-1-john.ogness@linutronix.de>
 <20200922153816.5883-5-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200922153816.5883-5-john.ogness@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2020-09-22 17:44:15, John Ogness wrote:
> Since the ringbuffer is lockless, there is no need for it to be
> protected by @logbuf_lock. Remove @logbuf_lock.
> 
> This means that printk_nmi_direct and printk_safe_flush_on_panic()
> no longer need to acquire any lock to run.
> 
> The global variables @syslog_seq, @syslog_partial, @syslog_time,
> @clear_seq were also protected by @logbuf_lock. Introduce
> @syslog_lock to protect these.
> 
> @console_seq, @exclusive_console_stop_seq, @console_dropped are
> protected by @console_lock.
> 
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index 763494d1d6b3..65e3cdbddeff 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
>  #ifdef CONFIG_PRINTK
>  DECLARE_WAIT_QUEUE_HEAD(log_wait);
> +
> +/* All 3 protected by @syslog_lock. */
>  /* the next printk record to read by syslog(READ) or /proc/kmsg */
>  static u64 syslog_seq;
>  static size_t syslog_partial;
>  static bool syslog_time;

I agree that it makes sense to synchronize these three variables
on 3 locations, see below.

> +/* All 3 protected by @console_lock. */
>  /* the next printk record to write to the console */
>  static u64 console_seq;
>  static u64 exclusive_console_stop_seq;
>  static unsigned long console_dropped;
>  
> +/* Protected by @syslog_lock. */
>  /* the next printk record to read after the last 'clear' command */
>  static u64 clear_seq;

The synchronization of this variable is strange. It is not clear
against which changes it is synchronized.


> @@ -823,7 +793,6 @@ static loff_t devkmsg_llseek(struct file *file, loff_t offset, int whence)
>  	if (offset)
>  		return -ESPIPE;
>  
> -	logbuf_lock_irq();
>  	switch (whence) {
>  	case SEEK_SET:
>  		/* the first record */

SEEK_SET does:

		user->seq = prb_first_valid_seq(prb);

I wonder if we actually need to protect user->seq by user->lock mutex
as it is done in devkmsg_read(). The logbuf_lock somehow prevented
a possible race. Well, any race is not much realistic.

> @@ -858,7 +828,6 @@ static __poll_t devkmsg_poll(struct file *file, poll_table *wait)
>  
>  	poll_wait(file, &log_wait, wait);
>  
> -	logbuf_lock_irq();

Also this should probably get replaced by user->lock mutex.

>  	if (prb_read_valid(prb, user->seq, NULL)) {
>  		/* return error when data has vanished underneath us */
>  		if (user->seq < prb_first_valid_seq(prb))


> @@ -1593,8 +1576,11 @@ int do_syslog(int type, char __user *buf, int len, int source)
>  			return 0;
>  		if (!access_ok(buf, len))
>  			return -EFAULT;
> +		syslog_lock_irq();
> +		seq = syslog_seq;
> +		syslog_unlock_irq();

It is not clear why a lock is suddenly needed here.

All the locks around a single variable read/write are suspicious. They
help only against inconsistent value (compile optimization or 64-bit value
manipulation on 32-bit system).

It might make sense but it has been clearly ignored before.

>  		error = wait_event_interruptible(log_wait,
> -				prb_read_valid(prb, syslog_seq, NULL));
> +				prb_read_valid(prb, seq, NULL));
>  		if (error)
>  			return error;
>  		error = syslog_print(buf, len);
> @@ -1642,7 +1628,7 @@ int do_syslog(int type, char __user *buf, int len, int source)
>  		break;
>  	/* Number of chars in the log buffer */
>  	case SYSLOG_ACTION_SIZE_UNREAD:
> -		logbuf_lock_irq();
> +		syslog_lock_irq();

I agree that some locking is needed here to keep @syslog_seq,
@syslog_partial, and @syslog_time consistent.


>  		if (syslog_seq < prb_first_valid_seq(prb)) {
>  			/* messages are gone, move to first one */
>  			syslog_seq = prb_first_valid_seq(prb);
> @@ -1669,7 +1655,7 @@ int do_syslog(int type, char __user *buf, int len, int source)
>  			}
>  			error -= syslog_partial;
>  		}
> -		logbuf_unlock_irq();
> +		syslog_unlock_irq();
>  		break;
>  	/* Size of the log buffer */
>  	case SYSLOG_ACTION_SIZE_BUFFER:
> @@ -2106,10 +2092,9 @@ asmlinkage int vprintk_emit(int facility, int level,
>  	boot_delay_msec(level);
>  	printk_delay();
>  
> -	/* This stops the holder of console_sem just where we want him */
> -	logbuf_lock_irqsave(flags);
> +	printk_safe_enter_irqsave(flags);
>  	printed_len = vprintk_store(facility, level, dev_info, fmt, args);
> -	logbuf_unlock_irqrestore(flags);

Why exactly need this be called in printk_safe context, please?

Infinite recursion might be prevented by per-CPU counter.
Lack of line buffers could hopefully be prevented by vscnprintf(NULL,
...) or extending the pool in 2nd patch.

Is there any other reason, please?

> +	printk_safe_exit_irqrestore(flags);
>  
>  	/* If called from the scheduler, we can not call up(). */
>  	if (!in_sched) {


> @@ -2691,9 +2670,9 @@ void console_flush_on_panic(enum con_flush_mode mode)
>  	if (mode == CONSOLE_REPLAY_ALL) {
>  		unsigned long flags;
>  
> -		logbuf_lock_irqsave(flags);
> +		local_irq_save(flags);
>  		console_seq = prb_first_valid_seq(prb);
> -		logbuf_unlock_irqrestore(flags);
> +		local_irq_restore(flags);

What is the reason for disabled irq here, please?

>  	}
>  	console_unlock();
>  }
> @@ -3476,17 +3449,14 @@ bool kmsg_dump_get_buffer(struct kmsg_dumper *dumper, bool syslog,
>  	if (!dumper->active || !buf || !size)
>  		goto out;
>  
> -	logbuf_lock_irqsave(flags);

I wonder if the logbuf_lock actually synchronized also some variables
in struct kmsg_dumper (cur_seq and next_seq).

We might need to add a lock into struct kmsg_dumper.


>  	if (dumper->cur_seq < prb_first_valid_seq(prb)) {
>  		/* messages are gone, move to first available one */
>  		dumper->cur_seq = prb_first_valid_seq(prb);
>  	}
>  
>  	/* last entry */
> -	if (dumper->cur_seq >= dumper->next_seq) {
> -		logbuf_unlock_irqrestore(flags);
> +	if (dumper->cur_seq >= dumper->next_seq)
>  		goto out;
> -	}
>  
>  	/* calculate length of entire buffer */
>  	seq = dumper->cur_seq;

Sigh, I wish the locking world was easier.

Best Regards,
Petr
