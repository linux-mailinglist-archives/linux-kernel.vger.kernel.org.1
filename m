Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2171020A1E0
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jun 2020 17:25:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405845AbgFYPZZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Jun 2020 11:25:25 -0400
Received: from mx2.suse.de ([195.135.220.15]:42772 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404580AbgFYPZY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 11:25:24 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 98981AC9F;
        Thu, 25 Jun 2020 15:25:23 +0000 (UTC)
Date:   Thu, 25 Jun 2020 17:25:23 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrea Parri <parri.andrea@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul McKenney <paulmck@kernel.org>, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: record_printk_text tricks: was: [PATCH v3 3/3] printk: use the
 lockless ringbuffer
Message-ID: <20200625152523.GJ8444@alley>
References: <20200618144919.9806-1-john.ogness@linutronix.de>
 <20200618144919.9806-4-john.ogness@linutronix.de>
 <20200625120946.GG6156@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200625120946.GG6156@alley>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2020-06-25 14:09:46, Petr Mladek wrote:
> On Thu 2020-06-18 16:55:19, John Ogness wrote:
> > Replace the existing ringbuffer usage and implementation with
> > lockless ringbuffer usage. Even though the new ringbuffer does not
> > require locking, all existing locking is left in place. Therefore,
> > this change is purely replacing the underlining ringbuffer.
> 
> > --- a/kernel/printk/printk.c
> > +++ b/kernel/printk/printk.c
> > +static size_t record_print_text(struct printk_record *r, bool syslog,
> > +				bool time)

[...]

> > +static size_t get_record_text_size(struct printk_info *info,
> > +				   unsigned int line_count,
> > +				   bool syslog, bool time)
> > +{

Nit: This should get called get_record_print_text_size(). It will make
it more clear that it counts the prefixes added for printing.

Best Regards,
Petr

PS: I have finished review of this 3rd patch. I am going to look at
the 2nd patch the following week if I find the courage ;-)
