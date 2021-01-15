Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0E742F7FF1
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 16:47:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733107AbhAOPpw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 10:45:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:53752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726918AbhAOPpw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 10:45:52 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id F3BC52339D;
        Fri, 15 Jan 2021 15:45:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1610725511;
        bh=/q9KAlBin1gqZTSdMUIA7qxFm2PjMq25wybGsrTkMB0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=APPaZ7LIHi5QUZ9YwtphXof7uDD2cqvejSfGRxRKBL5k78VTV/5UZiPHW1YoFTAjw
         XgQxkewJkE25oG5m7EcShLeLSk5hvMq68w3/lKOuM4gMa6M8tvvinTXG6NBCANVdTj
         g6VRSNDE8Yt0CI22qb4XN1TJnJPUO+BLTvnfkEOk=
Date:   Fri, 15 Jan 2021 16:45:09 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Alexander Potapenko <glider@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Dmitriy Vyukov <dvyukov@google.com>,
        Ingo Molnar <mingo@redhat.com>, Marco Elver <elver@google.com>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: [PATCH v2 3/5] docs: ABI: add /sys/kernel/error_report/
 documentation
Message-ID: <YAG4hf4THWFbn2op@kroah.com>
References: <20210115130336.2520663-1-glider@google.com>
 <20210115130336.2520663-4-glider@google.com>
 <YAGckOeJxqCcHKa+@kroah.com>
 <CAG_fn=Xen6Nd9qJnW6F4r5vgj7WAUo40BHeN_FXKpJ2jrpT6-g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG_fn=Xen6Nd9qJnW6F4r5vgj7WAUo40BHeN_FXKpJ2jrpT6-g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 15, 2021 at 04:26:21PM +0100, Alexander Potapenko wrote:
> > sysfs is "one value per file"
> What about existing interfaces that even export binary blobs through
> sysfs (e.g. /sys/firmware, /sys/boot_params)?
> What qualifies as a "value" in that case?

binary files are fine as the kernel is just a "pipe" through to the
hardware / firmware.  No translation or parsing happens in the kernel.
And that's NOT trace events :)

> > please put something like this in
> > tracefs, as there is no such rules there.  Or debugfs, but please, not
> > sysfs.
> Does tracefs have anything similar to sysfs_notify() or any other way
> to implement a poll() handler?

Don't know, look and see!

> Our main goal is to let users wait on poll(), so that they don't have
> to check the file for new contents every now and then. Is it possible
> with tracefs or debugfs?

debugfs, yes, you can do whatever you want.  tracefs probably has this,
otherwise how would trace tools work?  :)

> Also, for our goal debugfs isn't a particularly good fit, as Android
> kernels do not enable debugfs.

Do you care about Android kernels?  If so, yes, debugfs is not good.
And have you asked the Android kernel team about this?

> Not sure about tracefs, they seem to have it, need to check.

It should be there.

> Do you think it is viable to keep
> /sys/kernel/error_report/report_count in sysfs and use it for
> notifications, but move last_report somewhere else?

No, not at all, please keep it out of sysfs.

> (I'd probably prefer procfs, but it could be tracefs as well, if you
> find that better).

If it does not have to do with processes, it does not belong in procfs.

Again, this seems to fit in with tracing, so please use tracefs.

> This way it will still be possible to easily notify userspace about
> new reports, but the report itself won't have any atomicity
> guarantees. Users will have to check the report count to ensure it
> didn't change under their feet.

Again, use a file in tracefs.

thanks,

greg k-h
