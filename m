Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1F5E27DB4A
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 00:00:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728637AbgI2WAO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 18:00:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:59626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728161AbgI2WAO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 18:00:14 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 94DB8206D9;
        Tue, 29 Sep 2020 22:00:12 +0000 (UTC)
Date:   Tue, 29 Sep 2020 18:00:11 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Tzvetomir Stoyanov (VMware)" <tz.stoyanov@gmail.com>
Cc:     arnaldo.melo@gmail.com, linux-trace-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Subject: Re: [PATCH 2/2] tools lib traceevent: Man page libtraceevent debug
 APIs
Message-ID: <20200929180011.3a0049b7@gandalf.local.home>
In-Reply-To: <20200929173646.252163-1-tz.stoyanov@gmail.com>
References: <20200929173646.252163-1-tz.stoyanov@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Sep 2020 20:36:46 +0300
"Tzvetomir Stoyanov (VMware)" <tz.stoyanov@gmail.com> wrote:

> Add a new libtraceevent man page with documentation of these debug APIs:
>  	 tep_print_printk
>  	 tep_print_funcs
> 	 tep_set_test_filters
> 	 tep_plugin_print_options
> 
> Signed-off-by: Tzvetomir Stoyanov (VMware) <tz.stoyanov@gmail.com>
> ---
>  .../Documentation/libtraceevent-debug.txt     | 95 +++++++++++++++++++
>  1 file changed, 95 insertions(+)
>  create mode 100644 tools/lib/traceevent/Documentation/libtraceevent-debug.txt
> 
> diff --git a/tools/lib/traceevent/Documentation/libtraceevent-debug.txt b/tools/lib/traceevent/Documentation/libtraceevent-debug.txt
> new file mode 100644
> index 000000000000..9a2d1ffa2d72
> --- /dev/null
> +++ b/tools/lib/traceevent/Documentation/libtraceevent-debug.txt
> @@ -0,0 +1,95 @@
> +libtraceevent(3)
> +================
> +
> +NAME
> +----
> +tep_print_printk, tep_print_funcs, tep_set_test_filters, tep_plugin_print_options -
> +Print libtraceevent internal information.
> +
> +SYNOPSIS
> +--------
> +[verse]
> +--
> +*#include <event-parse.h>*
> +*#include <trace-seq.h>*
> +
> +void *tep_print_printk*(struct tep_handle pass:[*]tep);
> +void *tep_print_funcs*(struct tep_handle pass:[*]tep);
> +void *tep_set_test_filters*(struct tep_handle pass:[*]tep, int test_filters);
> +void *tep_plugin_print_options*(struct trace_seq pass:[*]s);
> +--
> +
> +DESCRIPTION
> +-----------
> +The _tep_print_printk()_ function prints the printk string formats that were
> +stored for this tracing session. The _tep_ argument is trace event parser context.
> +
> +The _tep_print_funcs()_ function prints the stored function name to address mapping
> +for this tracing session. The _tep_ argument is trace event parser context.
> +
> +The _tep_set_test_filters()_ function sets a flag to test a filter string. If this
> +flag is set, when _tep_filter_add_filter_str()_ API as called, it will print the filter
> +string instead of adding it. The _tep_ argument is trace event parser context.
> +The _test_filters_ argument is the test flag that will be set.
> +
> +The _tep_plugin_print_options()_ function writes a list of the registered plugin options
> +into _s_.
> +
> +EXAMPLE
> +-------
> +[source,c]
> +--
> +#include <event-parse.h>
> +#include <trace-seq.h>
> +...
> +struct tep_handle *tep = tep_alloc();
> +...
> +	tep_print_printk(tep);
> +...
> +	tep_print_funcs(tep);
> +...
> +struct tep_event_filter *filter = tep_filter_alloc(tep);
> +	tep_set_test_filters(tep, 1);
> +	tep_filter_add_filter_str(filter, "sche	d/sched_wakeup:target_cpu==1");

Did you mean to add that space in the middle of "sched"? ;-)

Other than that, it looks good to me.

Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve


> +	tep_set_test_filters(tep, 0);
> +	tep_filter_free(filter);
> +...
> +struct trace_seq seq;
> +trace_seq_init(&seq);
> +
> +	tep_plugin_print_options(&s);
> +...
> +--
> +
> +FILES
> +-----
> +[verse]
> +--
> +*event-parse.h*
> +	Header file to include in order to have access to the library APIs.
> +*-ltraceevent*
> +	Linker switch to add when building a program that uses the library.
> +--
> +
> +SEE ALSO
> +--------
> +_libtraceevent(3)_, _trace-cmd(1)_
> +
> +AUTHOR
> +------
> +[verse]
> +--
> +*Steven Rostedt* <rostedt@goodmis.org>, author of *libtraceevent*.
> +*Tzvetomir Stoyanov* <tz.stoyanov@gmail.com>, author of this man page.
> +--
> +REPORTING BUGS
> +--------------
> +Report bugs to  <linux-trace-devel@vger.kernel.org>
> +
> +LICENSE
> +-------
> +libtraceevent is Free Software licensed under the GNU LGPL 2.1
> +
> +RESOURCES
> +---------
> +https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git

