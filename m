Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D173D2F5E14
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 10:53:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727663AbhANJwU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 04:52:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725989AbhANJwS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 04:52:18 -0500
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2445BC061573
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 01:51:48 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id b64so6671199qkc.12
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 01:51:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yxYQK6YSchj/5tz12GdK3iWKS925woovB4KSStjvLsw=;
        b=dsg6gCEha6NEUyRN9p08CkWxSkPALUSogf8aqNruAiqnDuuKmt641bkFtzqy6MjXdg
         AXK8e7MqD328P/iDK6IWSFzZTGFQKhtJjMRcWGxoeKkEUs+pCP9QE3CH/+HB1FWiZsE0
         DALdXWC5xA8eEBGE8g50iPKMPX1jhcb//M/UFHJ07LSv7rRvsHjufFuU7U4tF8EPcqjp
         19KeStMKA1XLW2IsGotHD/KavpW4hSjfxFtxDng76gk0++/cc+UBDW/jPhVMaDygmtqZ
         dPdfqgFxJkbRdS9HZfOodzcBuI4+7mViC5RQZD1si6vPb+R3eOHaNDZ00YCtDWIRsC0y
         4zWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yxYQK6YSchj/5tz12GdK3iWKS925woovB4KSStjvLsw=;
        b=mB0CSnuE8aXG6mg1Jv1FaOMvu0cX+VtKkvpn50rmqyyeKwszSavv+XcFulNFb95TO8
         DSkPU01b1a+XoYJ37Ml2M93aw4uF6AKEUv0UJg6PEBzi9xOV4OFP5enG2qr2qjTaKivU
         mFI8bHT3qEiJuRJtoiMAm6Uue15s8Z99NPf1/8eQHY6chNwNAFp9FJ6dDkxK1bCFX9DG
         LeVKDDE+nA7cHk/WruwyXcL6pW5A2bZHLdaBaNrqjVkNQRI51o5RJ84ug3KwUrYx6vAn
         3ZaCModwsExUbfcI8g/kyhq7mgy8eMQCA5a/G6UdYDw67BIngOwhQ4trMMIlbtTTcxHG
         L61Q==
X-Gm-Message-State: AOAM532yMImJ5r2l/1DTyaZnPe5xEED8isAe8mHToMXqbBo0A7KlPbgV
        Vwta+Kn7ag9Zh/M5zi96lQUsUf7xVkrIZiwqQXa1Aw==
X-Google-Smtp-Source: ABdhPJzJYr2OFcAcpM5em2Bemn9ria+MS8gS8XOJONyd1jXl3RKfI4/K+dYO4Fe1ZrIuo8o+5ozg0uMrvLEeAPQK3EA=
X-Received: by 2002:a37:a747:: with SMTP id q68mr6347636qke.352.1610617907047;
 Thu, 14 Jan 2021 01:51:47 -0800 (PST)
MIME-Version: 1.0
References: <20210113091657.1456216-1-glider@google.com> <20210113091657.1456216-3-glider@google.com>
 <20210113160612.32f8b67494521ce23cc9cba5@linux-foundation.org>
In-Reply-To: <20210113160612.32f8b67494521ce23cc9cba5@linux-foundation.org>
From:   Alexander Potapenko <glider@google.com>
Date:   Thu, 14 Jan 2021 10:51:34 +0100
Message-ID: <CAG_fn=Uazu=RTW_-TizPU89KpHUR6akeTSvfhxJVJDSGuHJHLA@mail.gmail.com>
Subject: Re: [PATCH 2/4] lib: add error_report_notify to collect debugging
 tools' reports
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Marco Elver <elver@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Ingo Molnar <mingo@redhat.com>, Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Linux Memory Management List <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 14, 2021 at 1:06 AM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Wed, 13 Jan 2021 10:16:55 +0100 Alexander Potapenko <glider@google.com> wrote:
>
> > With the introduction of various production error-detection tools, such as
> > MTE-based KASAN and KFENCE, the need arises to efficiently notify the
> > userspace OS components about kernel errors. Currently, no facility exists
> > to notify userspace about a kernel error from such bug-detection tools.
> > The problem is obviously not restricted to the above bug detection tools,
> > and applies to any error reporting mechanism that does not panic the
> > kernel; this series, however, will only add support for KASAN and KFENCE
> > reporting.
> >
> > All such error reports appear in the kernel log. But, when such errors
> > occur, userspace would normally need to read the entire kernel log and
> > parse the relevant errors. This is error prone and inefficient, as
> > userspace needs to continuously monitor the kernel log for error messages.
> > On certain devices, this is unfortunately not acceptable. Therefore, we
> > need to revisit how reports are propagated to userspace.
> >
> > The library added, error_report_notify (CONFIG_ERROR_REPORT_NOTIFY),
> > solves the above by using the error_report_start/error_report_end tracing
> > events and exposing the last report and the total report count to the
> > userspace via /sys/kernel/error_report/last_report and
> > /sys/kernel/error_report/report_count.
> >
> > Userspace apps can call poll(POLLPRI) on those files to get notified about
> > the new reports without having to watch dmesg in a loop.
>
> It would be nice to see some user-facing documentation for this, under
> Documentation/.  How to use it, what the shortcomings are, etc.

Good point, will do.

> For instance...  what happens when userspace is slow reading
> /sys/kernel/error_report/last_report?  Does that file buffer multiple
> reports?  Does the previous one get overwritten?  etc.  Words on how
> this obvious issue is handled...

Yes, there can be issues with overwriting, and the recommended way to
handle them would be to check the value in
/sys/kernel/error_report/report_count before and after reading the
report.

> > --- a/lib/Kconfig.debug
> > +++ b/lib/Kconfig.debug
> > @@ -209,6 +209,20 @@ config DEBUG_BUGVERBOSE
> >         of the BUG call as well as the EIP and oops trace.  This aids
> >         debugging but costs about 70-100K of memory.
> >
> > +config ERROR_REPORT_NOTIFY
> > +     bool "Expose memory error reports to the userspace"
>
> There's really nothing "memory" specific about this?  Any kernel
> subsystem could use it?

Indeed. Perhaps it's better to emphasize "production" here, because
users of debugging tools are more or less happy with dmesg output.

>
> > +     depends on TRACING
> > +     help
> > +       When enabled, captures error reports from debugging tools (such as
> > +       KFENCE or KASAN) using console tracing, and exposes reports in
> > +       /sys/kernel/error_report/: the file last_report contains the last
> > +       report (with maximum report length of PAGE_SIZE), and report_count,
> > +       the total report count.
> > +
> > +       Userspace programs can call poll(POLLPRI) on those files to get
> > +       notified about the new reports without having to watch dmesg in a
> > +       loop.
>
> So we have a whole new way of getting debug info out of the kernel.  I
> fear this will become a monster.  And anticipating that, we should make
> darn sure that the interface is right, and is extensible.

Let me elaborate a bit on the problem we are trying to solve here.
It is specific to Android, but other Linux-based systems may require
something similar.
There's a userspace daemon that collects kernel/userspace crashes from
the device if its owner has opted into that, and we want that daemon
to also collect non-fatal error reports.

There are several issues with that:
 - there is currently no way to synchronously notify the userspace
about an error, and without that the daemon will have to actively
monitor the kernel log (or some other file, e.g. /proc/kernel/tainted
for certain strings;
- once we figure out there is an error report available, the daemon
will have to find its beginning and end, and also filter out the lines
that do not belong to that report;
 - this all requires letting that daemon see the whole dmesg output,
which may contain sensitive data accidentally printed by the kernel.

So, first of all, our solution had to provide some poll()-based
interface to avoid reading files in a loop, and that interface should
trigger every time an error report is printed.
Adding ftrace tracepoints to every tool at the points where reports
start/end is perhaps least invasive, and also allows multiple
subscribers (plus free tracing!).
Then, since the notification library was already in the business of
trace probes, we thought it makes sense to capture the whole report,
assuming that every dmesg line from the same task/cpu between the
report probes belongs to the report.
That drastically reduces the amount of data the userspace daemon has
access to (only the report instead of the whole dmesg), and removes
the need of active polling.

A potential pinch-point is the report size, which cannot exceed 4K if
we want it to live in sysfs.
It turned out certain reports didn't fit under that limit when taken
as-is, but stripping away the timestamps and task IDs printed by
CONFIG_PRINTK_CALLER saved us 1.5-2K in those cases.

Given that the information we expose is a subset of what dmesg
provides, I wouldn't call it a "whole new way" though.
Existing users will probably still stick to dmesg unless they want to
be notified of errors.
