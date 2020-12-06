Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 904492D0729
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Dec 2020 21:53:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728002AbgLFUwa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Dec 2020 15:52:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726731AbgLFUwa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Dec 2020 15:52:30 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7BB4C0613D0
        for <linux-kernel@vger.kernel.org>; Sun,  6 Dec 2020 12:51:49 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607287907;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=W1Z9gfyzoxhxUpj88xjFxlnA53C9WJYH68JyhIn8TXc=;
        b=UjlJAXsOFY1FDIQvP5T+iztNqympRd/oPPnovXXepHLcG/yQPBS7gOAFRVx8NZbr6Xx2sq
        a3RJEY1WP2bQrVTNFgNSA/kSUHSgM57vQeaX+vaqTCVxWMq7/7TJGdbGLe5d51iM85FYIG
        /UygDBmZBR0KkJ/88MUvC9g8RRbSPdWbZGZjUUKApAVpCxk1Xg7ZEa4U12j0jnAGsmgxvl
        iaabtbM1PeA2QIPwZJ5Vjt3dV1RJ3ooxwjyLlsRsWwhaWBim696nJ0m46yb6EgDTnxAasm
        7TDLfMDTvzS+dxHdiTfmtE32d0R+C2iCTJfM/Dy7WGNeXRTeCqe3hDe1BWJDhg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607287907;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=W1Z9gfyzoxhxUpj88xjFxlnA53C9WJYH68JyhIn8TXc=;
        b=iVipoxaQI1X73Qh18CHXe84VddUHx1ws/NrnxKqIn3IaAZyGwpyUNUUkv/TbEqUM+LloIJ
        RNIA0Qj4AE5gIjAQ==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: devkmsg: was [PATCH next v2 3/3] printk: remove logbuf_lock, add syslog_lock
In-Reply-To: <X8pbQ94Buqxhlqsk@alley>
References: <20201201205341.3871-1-john.ogness@linutronix.de> <20201201205341.3871-4-john.ogness@linutronix.de> <X8pbQ94Buqxhlqsk@alley>
Date:   Sun, 06 Dec 2020 21:57:46 +0106
Message-ID: <87y2iamzdp.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-12-04, Petr Mladek <pmladek@suse.com> wrote:
>> Since the ringbuffer is lockless, there is no need for it to be
>> protected by @logbuf_lock. Remove @logbuf_lock.
>
> It might make sense to split also this patch into few more pieces that
> would remove the lock from a particular interface.

OK.

>> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
>> index e9018c4e1b66..7385101210be 100644
>> --- a/kernel/printk/printk.c
>> +++ b/kernel/printk/printk.c
>> @@ -785,7 +749,6 @@ static loff_t devkmsg_llseek(struct file *file, loff_t offset, int whence)
>>  	if (offset)
>>  		return -ESPIPE;
>>  
>> -	logbuf_lock_irq();
>
> user->seq manipulation is not longer safe from the atomicity point of
> view.
>
> One solution would be to use atomic variable in struct devkmsg_user().
> Another solution would be to synchronize it with user->lock like we do
> in devkmsg_read().
>
> user->lock looks like an overhead. But it actually would make sense to
> prevent seek in the middle of a read.

I would prefer using atomic64_t. Using user->lock could introduce some
wacky regression.

>>  	switch (whence) {
>>  	case SEEK_SET:
>>  		/* the first record */
>> @@ -820,7 +782,6 @@ static __poll_t devkmsg_poll(struct file *file, poll_table *wait)
>>  
>>  	poll_wait(file, &log_wait, wait);
>>  
>> -	logbuf_lock_irq();
>>  	if (prb_read_valid(prb, user->seq, NULL)) {
>
> Same here. The atomicity of user->seq read/write is not guaranteed.

Right.

John Ogness
