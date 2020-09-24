Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86098276CF4
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 11:21:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727329AbgIXJVy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 05:21:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726710AbgIXJVx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 05:21:53 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDE96C0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 02:21:53 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1600939312;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fMAvwwFV30HK4hEY4FeabCBTMHVTzPS6tY9DUMcJlTM=;
        b=qlx733Zr8+YqmCkWvzeX3ZdiQudovl7ZSFdTEMjGtEr4OXU7CvxQmmZ+cRNoO9Q8o30YmQ
        IfJ35w6W4xBqS2Fyhq0XtU2drHWkRdrC85eOl5OuwIShY/33mmt4eKZNvmUhsuJs/cVrX+
        jsbRPyeQsEdpR0AQRnvCvrflwVUKvIYf9HfySilYnD0rXY9rVZKCXb4TzaB6nWv5gxhxvm
        PRxWL67G/B8/qYzGFxnbemX+ViJnXIgv8hdH/n4APBcOiBzk5xgJZQuK4Va9sUr0tzKZGL
        yxKrwHkvYDqb66QcyfG3YpLXhKxhVneeuizu9i0Ssu7hFOvBuNgge7ITNJa6Pw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1600939312;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fMAvwwFV30HK4hEY4FeabCBTMHVTzPS6tY9DUMcJlTM=;
        b=Hw8BadpY62hy9A5xiGbX1YcvD/LmaDrFsBshXnmEh83j4JbSIcZAH4/5/+N+6DJYALAkQ5
        g3bym75Y5gX4FeDQ==
To:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk 4/5] printk: remove logbuf_lock, add syslog_lock
In-Reply-To: <20200924084541.GA541@jagdpanzerIV.localdomain>
References: <20200922153816.5883-1-john.ogness@linutronix.de> <20200922153816.5883-5-john.ogness@linutronix.de> <20200924084541.GA541@jagdpanzerIV.localdomain>
Date:   Thu, 24 Sep 2020 11:27:51 +0206
Message-ID: <87d02b7cnk.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-09-24, Sergey Senozhatsky <sergey.senozhatsky@gmail.com> wrote:
> [..]
>>  void printk_safe_flush_on_panic(void)
>>  {
>> -	/*
>> -	 * Make sure that we could access the main ring buffer.
>> -	 * Do not risk a double release when more CPUs are up.
>> -	 */
>> -	if (raw_spin_is_locked(&logbuf_lock)) {
>> -		if (num_online_cpus() > 1)
>> -			return;
>> -
>> -		debug_locks_off();
>> -		raw_spin_lock_init(&logbuf_lock);
>
> If we panic() with syslog_lock locked then we need to zap syslog_lock
> and disable debug_locks for kmsg_dump() to succeed. Otherwise panic()
> may deadlock:
>
> 	syslog_lock_irq()
> 	-> NMI
> 		panic()
> 		...
> 			printk_safe_flush_on_panic();
> 			kmsg_dump(KMSG_DUMP_PANIC);	// syslog_lock_irqsave(flags)
> 		...
>
> Did I miss the point where we make sure that kmsg_dump() will not
> deadlock?

You are correct. Thanks.

@clear_seq should either become atomic64 or kmsg_dump() should start
from the oldest available message (seq=0).

John Ogness
