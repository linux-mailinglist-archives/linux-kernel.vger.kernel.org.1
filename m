Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43F4D2F8143
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 17:53:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727582AbhAOQxY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 11:53:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:42266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726970AbhAOQxX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 11:53:23 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9D245222B3;
        Fri, 15 Jan 2021 16:52:41 +0000 (UTC)
Date:   Fri, 15 Jan 2021 11:52:39 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Alexander Potapenko <glider@google.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Dmitriy Vyukov <dvyukov@google.com>,
        Ingo Molnar <mingo@redhat.com>, Marco Elver <elver@google.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: [PATCH v2 3/5] docs: ABI: add /sys/kernel/error_report/
 documentation
Message-ID: <20210115115239.1f3693ac@gandalf.local.home>
In-Reply-To: <CAG_fn=Xen6Nd9qJnW6F4r5vgj7WAUo40BHeN_FXKpJ2jrpT6-g@mail.gmail.com>
References: <20210115130336.2520663-1-glider@google.com>
        <20210115130336.2520663-4-glider@google.com>
        <YAGckOeJxqCcHKa+@kroah.com>
        <CAG_fn=Xen6Nd9qJnW6F4r5vgj7WAUo40BHeN_FXKpJ2jrpT6-g@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Jan 2021 16:26:21 +0100
Alexander Potapenko <glider@google.com> wrote:

> > please put something like this in
> > tracefs, as there is no such rules there.  Or debugfs, but please, not
> > sysfs.  
> Does tracefs have anything similar to sysfs_notify() or any other way
> to implement a poll() handler?
> Our main goal is to let users wait on poll(), so that they don't have
> to check the file for new contents every now and then. Is it possible
> with tracefs or debugfs?

Polling should work on tracefs. I hope it does, as I depend on it ;-)

And if there's an issue, we can always add more features.

> 
> Also, for our goal debugfs isn't a particularly good fit, as Android
> kernels do not enable debugfs.
> Not sure about tracefs, they seem to have it, need to check.

I believe tracefs is used extensively on Android.

> 
> Do you think it is viable to keep
> /sys/kernel/error_report/report_count in sysfs and use it for
> notifications, but move last_report somewhere else?
> (I'd probably prefer procfs, but it could be tracefs as well, if you
> find that better).

If you do use tracefs, add it to the top level tracing directory (no need
to have instances of it), and rename it to "kernel_warnings", as
"error_report" is too close to the existing "error_log" which holds error
messages of syntactic errors done by users entering in commands to some of
the special files.

That is, /sys/kernel/tracing/kernel_warnings/ would be your error_report/
directory you have now.

Use the function in kernel/trace/trace.c: tracer_init_tracefs() to add that
directory. That's for files in the tracefs directory that will not be
duplicated by instances.

-- Steve
