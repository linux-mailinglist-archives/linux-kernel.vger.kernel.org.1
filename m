Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C03ED2FA69F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 17:47:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406334AbhARQpT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 11:45:19 -0500
Received: from mx2.suse.de ([195.135.220.15]:52614 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406021AbhARQoh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 11:44:37 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1610988226; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=b7YYm0HiVDlLGgnN3dwtAcpBLKyUBgT7sMzepWp0Z2Q=;
        b=mIcx5GnluExAbKdMFZq9A7k+1qoUSUO4C8bMsLDHaKFAIkpnL2iBvlhul3FSPaHiiU3paf
        V9X0c/NKcUT7ERl+P826h9ZfniG/UQ1RzX5UTFkzte1he2bVBtdD91fai1SCJ3HvfO3WlM
        mHYRZv75oGj6r0TLIghO9NTf40DNJDc=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id AD8EAB272;
        Mon, 18 Jan 2021 16:43:46 +0000 (UTC)
Date:   Mon, 18 Jan 2021 17:43:46 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Alexander Potapenko <glider@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Dmitriy Vyukov <dvyukov@google.com>,
        Ingo Molnar <mingo@redhat.com>, Marco Elver <elver@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: [PATCH v2 2/5] lib: add error_report_notify to collect debugging
 tools' reports
Message-ID: <YAW6wsuEYe9/Zjxv@alley>
References: <20210115130336.2520663-1-glider@google.com>
 <20210115130336.2520663-3-glider@google.com>
 <YAVzNrBIlp0UJKfs@alley>
 <CAG_fn=UmjC2LOCXRpp+vTZ6nr0M7=dCKjFYgVFVvmqftTkjGYw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG_fn=UmjC2LOCXRpp+vTZ6nr0M7=dCKjFYgVFVvmqftTkjGYw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2021-01-18 14:08:19, Alexander Potapenko wrote:
> On Mon, Jan 18, 2021 at 12:38 PM Petr Mladek <pmladek@suse.com> wrote:
> Thanks for your input! Some responses below.
> 
> >
> > On Fri 2021-01-15 14:03:33, Alexander Potapenko wrote:
> > > With the introduction of various production error-detection tools, such as
> > > MTE-based KASAN and KFENCE, the need arises to efficiently notify the
> > > userspace OS components about kernel errors. Currently, no facility exists
> > > to notify userspace about a kernel error from such bug-detection tools.
> > > The problem is obviously not restricted to the above bug detection tools,
> > > and applies to any error reporting mechanism that does not panic the
> > > kernel; this series, however, will only add support for KASAN and KFENCE
> > > reporting.
> > >
> > > +++ b/lib/error_report_notify.c
> > > +/*
> > > + * Trace hook for the error_report_start event. In an unlikely case of another
> > > + * task already printing a report bail out, otherwise save the current pid
> > > + * together with in_task() return value.
> >
> > This is not reliable. Some events might get lost.
> 
> 
> > > +
> > > +     /* Pairs with acquire in last_report_show(). */
> > > +     atomic_inc_return_release(&num_reports);
> > > +     schedule_delayed_work(&reporting_done, 0);
> >
> > Why delayed work when it gets queued immediately?
> 
> Because error reports may be sent from a place where waiting is
> forbidden (in the case of KFENCE that is the page fault handler).
> A delayed work ensures the notification occurs in a wait-safe context.
> 
> 
> > > +static void skip_extra_info(const char **buf, size_t *len)
> > > +{
> > > +     int num_brackets = IS_ENABLED(CONFIG_PRINTK_TIME) +
> > > +                        IS_ENABLED(CONFIG_PRINTK_CALLER);
> >
> > The timestamp can be disabled also at runtime by
> > /sys/module/printk/parameters/time
> 
> Guess that would result in disabling it for the whole kernel, which is
> too aggressive.

I wanted to say that it was not enough to check
IS_ENABLED(CONFIG_PRINTK_TIME). Anyway, I think that you will not use
this code in the end.


> > IMHO, removing the timestamp is a bad idea. It will complicate
> > matching the message with other events.
> 
> Given that we are moving away from sysfs, the report size limit can be
> increased, therefore we don't have to remove the timestamp to save
> space anymore.
> 
> > I am afraid that some reports would get shrunken anyway.
> Do you have any particular subsystem in mind? We could probably

printk() is storing recursive messages and also messages in NMI
context into temporary per-CPU buffers. They include just a plain
text (no timestamps).

The original size was 4kB but it caused shrinking some backtraces.
They are 8kB by default now. But they still shrink, for example,
lockdep report.

I am not sure about the KASAN or KFENCE reports. But the
experience is that amount of debug messages is just growing year
over year.

JFYI, these temporary buffers should get removed once the new lockless
ringbuffer is fully integrated.


> increase the report buffer to, say, 16K, to avoid this.
> 
> > I suggest to use some lockless ringbuffer to store these
> > messages. Either ftrace or printk one.
> >
> > But the biggest problem would be that console might be called
> > asynchronously from another process. The messages might get
> > lost in the meantime.
> 
> Do you mean that one process may call printk(), but the console probe
> for that message will be executed in the context of another process?

Yes, this might happen. And it is going to be the default behavior.
The current solution might cause softlockups. John Ogness is working
on offloading the console handling into separate kthreads. It means
that call_console_drivers() will always get called by a separate
process.

> If so, that would be a problem. Could it be possible to extend the
> console trace event to pass an extra caller id?

We should pass the messages some other way. The good news is
that the caller id is always stored in the new lockless
ring buffer that has been integreated into 4.10. It is
used intarnally for handling continuous lines.

The caller id is printed on the console only when the configure
option is enabled. But we should create another interface for
these debugging dumps anyway.

I would implement one more dumper, like kmsg_dump(),
syslog_print_all(), console_unlock(). They cycle over all/recently
stored messages and print them.

console_unlock() filter the messages according to console_loglevel.
The new funtion might fitler them by the flag specific for
the interested tools, like KASAN.

> > Or add a hook into /dev/kmsg interface. It allows to read any
> > stored message immediately and quickly. Well, you would need
> > to have your own reader of this interface.
> 
> This probably could be done, but isn't the console tracepoint designed
> exactly for this?

Hmm, the tracepoint has been added in 2011 by the commit
95100358491abaa2 ("printk/tracing: Add console output tracing").

It was a time when the messages were added into the main logbuffer
one-by-one character. I guess that it was easier to add the
tracing here because the console code already found the beginning
and end of each message.

/dev/kmsg interface has been added later. Also the messages were
later stored as records (one message with its metadata) into
the log buffer. So, it might be done an easier way now.


> Initially our intent was to refactor KFENCE error reporting so that
> the whole report is stored in a buffer and can be exposed to userspace
> via a VFS entry.
> Then it turned out we'd need something similar for KASAN, which
> would've also resulted in a major rewrite.
> So we thought a much more generic solution would be to let the tools
> "tee" their output to a specific file on demand.

Thanks for the background.

> Yes, sounds like duplicating the kernel log :)
> On the other hand, we never really planned to extend printk or
> duplicate parts of it, so unless trace_console() is a good fit we'd
> probably refrain from storing the logs for now.

IMHO, using the tracepoint for your purpose looks too complicated
and less reliable. It might be interesting for 3rd-party code because
the tracepoint is rather stable. But we might do it better in upstream.


> Having the special flag for the error reports is handy, but given the
> existence of CONFIG_PRINTK_CALLER may not be worth the effort, at
> least for now.

Of course, the less we need to complicate the printk() code the
better. So if you could find the right messages using a normal
interface, it would be great.

That said, there are currently the following ways to read the messages:

   + consoles
   + syslog syscall (man 2 syslog)
   + /dev/kmsg
   + kmsg dumpers

Three of them use record_print_text() to format the message. It means
that they could show the caller_id in the brackets.

The only exception is /dev/kmsg. It uses info_print_ext_header()
and msg_print_ext_body() to format the output. It currently does
not show caller_id. Nobody wanted it yet. We could update it.
We just need to be careful because systemd journald uses this
interface and relies on the format.

Best Regards,
Petr
