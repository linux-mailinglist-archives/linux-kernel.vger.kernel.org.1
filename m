Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DE232D0DB4
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 11:02:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726769AbgLGKCS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 05:02:18 -0500
Received: from mx2.suse.de ([195.135.220.15]:53970 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726083AbgLGKCS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 05:02:18 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1607335292; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fNtQCj2fjbnzevCdger0bAZFwvYkYL3KGN2+UIjMuPM=;
        b=upTCCywKTECKFbCIO5K2h5Tfpb8EnOWZCFI+SE1BWi2g8hogBuZmwiLE/VkLo4UdFvpxeK
        no/3qYkci4abIgmzu4lh7Gbry6ilG7T3Pp1cU/GutVzzeWPL61wWyVqSookcLXd4dLFqk0
        S92UrMCzg5W+qhU7vSGJ4ij7lrVTkqE=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 2DB7EAC55;
        Mon,  7 Dec 2020 10:01:32 +0000 (UTC)
Date:   Mon, 7 Dec 2020 11:01:31 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: syslog: was: [PATCH next v2 3/3] printk: remove logbuf_lock, add
 syslog_lock
Message-ID: <X839e1NXWPTX+X4J@alley>
References: <20201201205341.3871-1-john.ogness@linutronix.de>
 <20201201205341.3871-4-john.ogness@linutronix.de>
 <X8pceqpK+sAudugq@alley>
 <87v9demype.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87v9demype.fsf@jogness.linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 2020-12-06 22:12:21, John Ogness wrote:
> On 2020-12-04, Petr Mladek <pmladek@suse.com> wrote:
> > On Tue 2020-12-01 21:59:41, John Ogness wrote:
> >> Since the ringbuffer is lockless, there is no need for it to be
> >> protected by @logbuf_lock. Remove @logbuf_lock.
> >> 
> >> --- a/kernel/printk/printk.c
> >> +++ b/kernel/printk/printk.c
> >> @@ -2809,11 +2856,7 @@ void register_console(struct console *newcon)
> >>  		nr_ext_console_drivers++;
> >>  
> >>  	if (newcon->flags & CON_PRINTBUFFER) {
> >> -		/*
> >> -		 * console_unlock(); will print out the buffered messages
> >> -		 * for us.
> >> -		 */
> >> -		logbuf_lock_irqsave(flags);
> >> +		spin_lock_irqsave(&syslog_lock, flags);
> >
> > We should take the lock only around assigning syslog_seq. And add a
> > comment that it guarantees atomic update.
> 
> OK. So you just want "exclusive_console = newcon;" moved outside the
> critical section.

Exactly, I would like to make it clear that it synchronizes only the
single assignment. Otherwise, people might get wrong assumption.

I know that there is a comment describing the scope of each lock.
But people might miss it or do not search for it at all.

Best Regards,
Petr
