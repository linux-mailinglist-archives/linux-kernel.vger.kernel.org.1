Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4917C2F56B9
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 02:58:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727418AbhANBwT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 20:52:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:56508 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729761AbhANAHF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 19:07:05 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 826A522A83;
        Thu, 14 Jan 2021 00:06:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1610582773;
        bh=Aiw3hocSNpc8d9OKmlwQqHpnJKjeH4oS+tO9UNk2TzU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=EgnOpW22kfWBxWqD1DOqx1hCoc4GMerWJ5chcd4kxykizcxOJXYYII0BnKZyBiKWn
         21cZnuCqb9QCDJ6rffWdwpnOcKLKmJYIvk8Z/KOtn4oIhuZFJcWT1cMsdgWhbYKHth
         tJtJyCKyIyURYJ3e1+uuoMJ/cMAiQnI4En2jLpic=
Date:   Wed, 13 Jan 2021 16:06:12 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Alexander Potapenko <glider@google.com>
Cc:     linux-kernel@vger.kernel.org, Marco Elver <elver@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Ingo Molnar <mingo@redhat.com>, Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-mm@kvack.org
Subject: Re: [PATCH 2/4] lib: add error_report_notify to collect debugging
 tools' reports
Message-Id: <20210113160612.32f8b67494521ce23cc9cba5@linux-foundation.org>
In-Reply-To: <20210113091657.1456216-3-glider@google.com>
References: <20210113091657.1456216-1-glider@google.com>
        <20210113091657.1456216-3-glider@google.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Jan 2021 10:16:55 +0100 Alexander Potapenko <glider@google.com> wrote:

> With the introduction of various production error-detection tools, such as
> MTE-based KASAN and KFENCE, the need arises to efficiently notify the
> userspace OS components about kernel errors. Currently, no facility exists
> to notify userspace about a kernel error from such bug-detection tools.
> The problem is obviously not restricted to the above bug detection tools,
> and applies to any error reporting mechanism that does not panic the
> kernel; this series, however, will only add support for KASAN and KFENCE
> reporting.
> 
> All such error reports appear in the kernel log. But, when such errors
> occur, userspace would normally need to read the entire kernel log and
> parse the relevant errors. This is error prone and inefficient, as
> userspace needs to continuously monitor the kernel log for error messages.
> On certain devices, this is unfortunately not acceptable. Therefore, we
> need to revisit how reports are propagated to userspace.
> 
> The library added, error_report_notify (CONFIG_ERROR_REPORT_NOTIFY),
> solves the above by using the error_report_start/error_report_end tracing
> events and exposing the last report and the total report count to the
> userspace via /sys/kernel/error_report/last_report and
> /sys/kernel/error_report/report_count.
> 
> Userspace apps can call poll(POLLPRI) on those files to get notified about
> the new reports without having to watch dmesg in a loop.

It would be nice to see some user-facing documentation for this, under
Documentation/.  How to use it, what the shortcomings are, etc.

For instance...  what happens when userspace is slow reading
/sys/kernel/error_report/last_report?  Does that file buffer multiple
reports?  Does the previous one get overwritten?  etc.  Words on how
this obvious issue is handled...

> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -209,6 +209,20 @@ config DEBUG_BUGVERBOSE
>  	  of the BUG call as well as the EIP and oops trace.  This aids
>  	  debugging but costs about 70-100K of memory.
>  
> +config ERROR_REPORT_NOTIFY
> +	bool "Expose memory error reports to the userspace"

There's really nothing "memory" specific about this?  Any kernel
subsystem could use it?

> +	depends on TRACING
> +	help
> +	  When enabled, captures error reports from debugging tools (such as
> +	  KFENCE or KASAN) using console tracing, and exposes reports in
> +	  /sys/kernel/error_report/: the file last_report contains the last
> +	  report (with maximum report length of PAGE_SIZE), and report_count,
> +	  the total report count.
> +
> +	  Userspace programs can call poll(POLLPRI) on those files to get
> +	  notified about the new reports without having to watch dmesg in a
> +	  loop.

So we have a whole new way of getting debug info out of the kernel.  I
fear this will become a monster.  And anticipating that, we should make
darn sure that the interface is right, and is extensible.


