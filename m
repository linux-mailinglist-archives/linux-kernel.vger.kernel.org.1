Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97CA12FA3B4
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 15:55:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405318AbhAROx6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 09:53:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:49792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405280AbhAROxN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 09:53:13 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AA58B22BEA;
        Mon, 18 Jan 2021 14:52:31 +0000 (UTC)
Date:   Mon, 18 Jan 2021 09:52:29 -0500
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
Message-ID: <20210118095230.1d2e670b@gandalf.local.home>
In-Reply-To: <CAG_fn=UnMhW4y6y5Tef9xnbB2S8gKozY7SXyk9STFh53rPfW-Q@mail.gmail.com>
References: <20210115130336.2520663-1-glider@google.com>
        <20210115130336.2520663-4-glider@google.com>
        <YAGckOeJxqCcHKa+@kroah.com>
        <CAG_fn=Xen6Nd9qJnW6F4r5vgj7WAUo40BHeN_FXKpJ2jrpT6-g@mail.gmail.com>
        <20210115115239.1f3693ac@gandalf.local.home>
        <CAG_fn=UnMhW4y6y5Tef9xnbB2S8gKozY7SXyk9STFh53rPfW-Q@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Jan 2021 11:22:27 +0100
Alexander Potapenko <glider@google.com> wrote:

> > If you do use tracefs, add it to the top level tracing directory (no need
> > to have instances of it), and rename it to "kernel_warnings", as
> > "error_report" is too close to the existing "error_log" which holds error
> > messages of syntactic errors done by users entering in commands to some of
> > the special files.  
> 
> Will do. Is it conventional to add a new dentry* to struct trace_array for that?
> If not, maybe it's better to create this dir in
> error_report_notify_setup(), like this is done e.g. for
> /sys/kernel/tracing/trace_stat - just to loosen the coupling?

Yeah, keep the dentry static in your own code. No need to add it to the
trace_array. The dentry's in the trace array are for instances (as there
are more than one of instance of them).

> 
> > That is, /sys/kernel/tracing/kernel_warnings/ would be your error_report/
> > directory you have now.  
> 
> WDYT about "kernel_errors" or "kernel_error_reports"?
> "warnings" suggest we'll be notifying about any occurrence of WARN(),
> which is not what we are planning to do.
> Also, shall I rename the library/config/etc. accordingly (to e.g.
> CONFIG_KERNEL_WARN_NOTIFY)?

I'm fine with "kernel_errors" as that helps to differentiate what they are.
Also, you may want to add a field about this in the documentation under
Documentation/trace/ftrace.rst (just a reference) and add a separate file
called, kernel_errors.rst.

-- Steve
