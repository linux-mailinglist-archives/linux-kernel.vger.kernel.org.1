Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B0972D0D8E
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 10:57:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726862AbgLGJ44 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 04:56:56 -0500
Received: from mx2.suse.de ([195.135.220.15]:48434 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726377AbgLGJ44 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 04:56:56 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1607334970; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lQyzA5+NXpFmy9fbV5Tah+/VeSmBxhEmKcAcR9AvhBA=;
        b=PGuun+nN4TTe702tCxdhe/LZ2pBb6EyIBjspS71guWj53BmRDDiKqz7MQu+Q+g2HYu/rbh
        UppGzUQSl7KSn5hZn+3mYCO44J/CXjJ2Y/EDFVPp30xGCbWf3lor4fB2C9cNFDopaKLZWs
        DsCO+aSb0+eiq36TVyTDr3VuRYQ8UaQ=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 59D3EAD41;
        Mon,  7 Dec 2020 09:56:10 +0000 (UTC)
Date:   Mon, 7 Dec 2020 10:56:09 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: devkmsg: was [PATCH next v2 3/3] printk: remove logbuf_lock, add
 syslog_lock
Message-ID: <X838OXY46bA2ozuo@alley>
References: <20201201205341.3871-1-john.ogness@linutronix.de>
 <20201201205341.3871-4-john.ogness@linutronix.de>
 <X8pbQ94Buqxhlqsk@alley>
 <87y2iamzdp.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87y2iamzdp.fsf@jogness.linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 2020-12-06 21:57:46, John Ogness wrote:
> On 2020-12-04, Petr Mladek <pmladek@suse.com> wrote:
> >> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> >> index e9018c4e1b66..7385101210be 100644
> >> --- a/kernel/printk/printk.c
> >> +++ b/kernel/printk/printk.c
> >> @@ -785,7 +749,6 @@ static loff_t devkmsg_llseek(struct file *file, loff_t offset, int whence)
> >>  	if (offset)
> >>  		return -ESPIPE;
> >>  
> >> -	logbuf_lock_irq();
> >
> > user->seq manipulation is not longer safe from the atomicity point of
> > view.
> >
> > One solution would be to use atomic variable in struct devkmsg_user().
> > Another solution would be to synchronize it with user->lock like we do
> > in devkmsg_read().
> >
> > user->lock looks like an overhead. But it actually would make sense to
> > prevent seek in the middle of a read.
> 
> I would prefer using atomic64_t. Using user->lock could introduce some
> wacky regression.

OK, fair enough. User space might do crazy stuff.

Best Regards,
Petr
