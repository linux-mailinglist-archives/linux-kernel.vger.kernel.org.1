Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8A842AEA34
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 08:33:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726157AbgKKHdR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 02:33:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:48708 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726108AbgKKHdP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 02:33:15 -0500
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C633E207BB;
        Wed, 11 Nov 2020 07:33:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605079994;
        bh=3K/I673+EPqac4CEYORRgoHy3VD/tYYoYtKH32Ksb88=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CCQT+Th70rZajLYAHvkEwBuAAYef03LBx2Ai23jnsp7dEJ01o0slABIg4SqKbi2Qg
         vlXrKeWRPZvdWdlKHF+Pec4Ucrk0QGI8PbdQHoh+bwyTbvqTvtELRT8vkE6uWSbE47
         6ZNIkYd01n3mQyV72AbKj7CqoyTT+/HDbJZ57kXc=
Date:   Wed, 11 Nov 2020 08:34:15 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Frankie Chang <Frankie.Chang@mediatek.com>
Cc:     Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Martijn Coenen <maco@android.com>,
        Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Christian Brauner <christian@brauner.io>,
        linux-kernel@vger.kernel.org, wsd_upstream@mediatek.com,
        Jian-Min Liu <Jian-Min.Liu@mediatek.com>
Subject: Re: [PATCH v13 3/3] binder: add transaction latency tracer
Message-ID: <X6uT941IJ3uf/7aE@kroah.com>
References: <X6quBb28IVvyRhox@kroah.com>
 <1605063764-12930-1-git-send-email-Frankie.Chang@mediatek.com>
 <1605063764-12930-4-git-send-email-Frankie.Chang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1605063764-12930-4-git-send-email-Frankie.Chang@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 11, 2020 at 11:02:44AM +0800, Frankie Chang wrote:
> From: "Frankie.Chang" <Frankie.Chang@mediatek.com>
> 
> Record start/end timestamp for binder transaction.
> When transaction is completed or transaction is free,
> it would be checked if transaction latency over threshold
> (default 2 sec), if yes, printing related information for tracing.

I've applied the first 2 patches (finally!), but in looking at this some
more, I have some questions:

> /* Implement details */
> - Add latency tracer module to monitor transaction
>   by attaching to new tracepoints introduced
>   when transactions are allocated and freed.
>   The trace_binder_txn_latency_free would not be enabled
>   by default. Monitoring which transaction is too slow to
>   cause some of exceptions is important. So we hook the
>   tracepoint to call the monitor function.

This feels odd, but ok...

> - Since some of modules would trigger timeout NE
>   if their binder transaction don't finish in time,
>   such as audio timeout (5 sec), even BT command
>   timeout (2 sec), etc.
>   Therefore, setting the timeout threshold as default
>   2 seconds could be helpful to debug.
>   But this timeout threshold is configurable, to let
>   all users determine the more suitable threshold.

You made this a module parameter, which while it works, is very
unfriendly as it requires people to modify the boot command line or
their module parameter configuration file.  Also, you are doing this on
as a "global binder" operation, for all instances, not on a per-instance
basis.

Which is my larger question, you seem to want this tracer either on or
off for ALL of the binder instances, which feels like overkill.  Why not
make this a per-instance thing, and allow it to be configured properly
in the binder filesystem interface, to allow individual instances to
enable/disable this.

This also prevents binder instances from seeing data outside of their
instances, and leaking that to the kernel log, which brings me to:

> - The reason why printing the related information to
>   kernel information log but not trace buffer is that
>   some abnormal transactions may be pending for a long
>   time ago, they could not be recorded due to buffer
>   limited.

Don't abuse the kernel information log for stuff that is just normal
operations.  What is wrong with using the trace buffers here?  That's
what they are designed for from what I can tell.

You don't want to "leak" this information to the world in the kernel log
for stuff that should only go to a user/process that has the correct
permissions to see it as specified by the tracing permissions, right?

Some implementation questions below:

> 
> Signed-off-by: Frankie.Chang <Frankie.Chang@mediatek.com>
> Acked-by: Todd Kjos <tkjos@google.com>
> Reported-by: kernel test robot <lkp@intel.com>
> ---
>  drivers/android/Kconfig                 |    8 +++
>  drivers/android/Makefile                |    1 +
>  drivers/android/binder.c                |    6 ++
>  drivers/android/binder_internal.h       |   13 ++++
>  drivers/android/binder_latency_tracer.c |  107 +++++++++++++++++++++++++++++++
>  drivers/android/binder_trace.h          |   26 +++++++-
>  6 files changed, 158 insertions(+), 3 deletions(-)
>  create mode 100644 drivers/android/binder_latency_tracer.c
> 
> diff --git a/drivers/android/Kconfig b/drivers/android/Kconfig
> index 53b22e2..8aadaf4 100644
> --- a/drivers/android/Kconfig
> +++ b/drivers/android/Kconfig
> @@ -54,6 +54,14 @@ config ANDROID_BINDER_IPC_SELFTEST
>  	  exhaustively with combinations of various buffer sizes and
>  	  alignments.
>  
> +config BINDER_TRANSACTION_LATENCY_TRACKING
> +	tristate "Android Binder transaction tracking"
> +	help
> +	  Used for track abnormal binder transaction which is over threshold,
> +	  when the transaction is done or be free, this transaction would be
> +	  checked whether it executed overtime.
> +	  If yes, printing out the detailed info.

Why is this a separate module?  Who will ever want this split out?

> +
>  endif # if ANDROID
>  
>  endmenu
> diff --git a/drivers/android/Makefile b/drivers/android/Makefile
> index c9d3d0c9..c2ffdb6 100644
> --- a/drivers/android/Makefile
> +++ b/drivers/android/Makefile
> @@ -4,3 +4,4 @@ ccflags-y += -I$(src)			# needed for trace events
>  obj-$(CONFIG_ANDROID_BINDERFS)		+= binderfs.o
>  obj-$(CONFIG_ANDROID_BINDER_IPC)	+= binder.o binder_alloc.o
>  obj-$(CONFIG_ANDROID_BINDER_IPC_SELFTEST) += binder_alloc_selftest.o
> +obj-$(CONFIG_BINDER_TRANSACTION_LATENCY_TRACKING)	+= binder_latency_tracer.o
> diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> index 20b08f52..6384a37 100644
> --- a/drivers/android/binder.c
> +++ b/drivers/android/binder.c
> @@ -2651,6 +2651,7 @@ static void binder_transaction(struct binder_proc *proc,
>  		return_error_line = __LINE__;
>  		goto err_alloc_t_failed;
>  	}
> +	trace_binder_txn_latency_alloc(t);
>  	INIT_LIST_HEAD(&t->fd_fixups);
>  	binder_stats_created(BINDER_STAT_TRANSACTION);
>  	spin_lock_init(&t->lock);
> @@ -5151,6 +5152,7 @@ static void print_binder_transaction_ilocked(struct seq_file *m,
>  		   to_proc ? to_proc->pid : 0,
>  		   t->to_thread ? t->to_thread->pid : 0,
>  		   t->code, t->flags, t->priority, t->need_reply);
> +	trace_binder_txn_latency_info(m, t);
>  	spin_unlock(&t->lock);
>  
>  	if (proc != to_proc) {
> @@ -5792,4 +5794,8 @@ static int __init binder_init(void)
>  #define CREATE_TRACE_POINTS
>  #include "binder_trace.h"
>  
> +EXPORT_TRACEPOINT_SYMBOL(binder_txn_latency_alloc);
> +EXPORT_TRACEPOINT_SYMBOL(binder_txn_latency_info);
> +EXPORT_TRACEPOINT_SYMBOL(binder_txn_latency_free);

EXPORT_TRACEPOINT_SYMBOL_GPL()?


> +
>  MODULE_LICENSE("GPL v2");
> diff --git a/drivers/android/binder_internal.h b/drivers/android/binder_internal.h
> index 6cd7901..f86911d 100644
> --- a/drivers/android/binder_internal.h
> +++ b/drivers/android/binder_internal.h
> @@ -15,6 +15,11 @@
>  #include <uapi/linux/android/binderfs.h>
>  #include "binder_alloc.h"
>  
> +#if IS_ENABLED(CONFIG_BINDER_TRANSACTION_LATENCY_TRACKING)
> +#include <linux/rtc.h>
> +#include <linux/time.h>
> +#endif

Why the #if check in a .h file?  Just include them always, right?

> +
>  struct binder_context {
>  	struct binder_node *binder_context_mgr_node;
>  	struct mutex context_mgr_node_lock;
> @@ -525,6 +530,14 @@ struct binder_transaction {
>  	 * during thread teardown
>  	 */
>  	spinlock_t lock;
> +	/**
> +	 * @kt and @real_kt are used to record the time
> +	 * that the binder transaction startup
> +	 */
> +#if IS_ENABLED(CONFIG_BINDER_TRANSACTION_LATENCY_TRACKING)
> +	ktime_t kt;
> +	ktime_t real_kt;

What does "kt" stand for here?  You document that is it used to record
time, but what is the difference between them?

> +#endif
>  };
>  
>  /**
> diff --git a/drivers/android/binder_latency_tracer.c b/drivers/android/binder_latency_tracer.c
> new file mode 100644
> index 0000000..07c53a0
> --- /dev/null
> +++ b/drivers/android/binder_latency_tracer.c
> @@ -0,0 +1,107 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2019 MediaTek Inc.
> + */
> +
> +#include <linux/module.h>
> +#include <uapi/linux/android/binder.h>
> +#include "binder_internal.h"
> +#include "binder_trace.h"
> +
> +/*
> + * The reason setting the binder_txn_latency_threshold to 2 sec
> + * is that most of timeout abort is greater or equal to 2 sec.
> + * Making it configurable to let all users determine which
> + * threshold is more suitable.
> + */
> +static uint32_t binder_txn_latency_threshold = 2;
> +module_param_named(threshold, binder_txn_latency_threshold,
> +			uint, 0644);

Again, this isn't the 1990's, please do not add module parameters if at
all possible.

> +
> +/*
> + * probe_binder_txn_latency_free - Output info of a delay transaction
> + * @t:          pointer to the over-time transaction
> + */
> +static void probe_binder_txn_latency_free(void *ignore, struct binder_transaction *t,
> +					int from_proc, int from_thread,
> +					int to_proc, int to_thread)
> +{
> +	struct rtc_time tm;
> +	ktime_t cur, startime, sub_t;
> +
> +	cur = ktime_get();
> +	startime = t->kt;

"starttime"?

> +	sub_t = ktime_sub(cur, startime);
> +
> +	/* if transaction time is over than binder_txn_latency_threshold (sec),
> +	 * show timeout warning log.
> +	 */
> +	if (ktime_divns(sub_t, NSEC_PER_SEC) < binder_txn_latency_threshold)
> +		return;
> +
> +	tm = rtc_ktime_to_tm(t->real_kt);
> +
> +	pr_info_ratelimited("%d: from %d:%d to %d:%d",
> +			t->debug_id, from_proc, from_thread,
> +			to_proc, to_thread);
> +
> +	pr_info_ratelimited(" total %u.%03lu s code %u start %lu.%03lu android %d-%02d-%02d %02d:%02d:%02d.%03lu\n",
> +			(unsigned int)ktime_divns(sub_t, NSEC_PER_SEC),
> +			(unsigned long)(ktime_to_ms(sub_t) % MSEC_PER_SEC),
> +			t->code,
> +			(unsigned long)ktime_divns(startime, NSEC_PER_SEC),
> +			(unsigned long)(ktime_to_ms(startime) % MSEC_PER_SEC),
> +			(tm.tm_year + 1900), (tm.tm_mon + 1), tm.tm_mday,
> +			tm.tm_hour, tm.tm_min, tm.tm_sec,
> +			(unsigned long)(ktime_to_ms(t->real_kt) % MSEC_PER_SEC));

Again, this is a LOT of kernel log spam.  Please just put this in the
tracebuffer instead.

And why do this date math in the kernel?  Isn't there some other
standard way of expressing time to userspace that is easier to
understand?

And do you really need the year?  :)

> +}
> +
> +static void probe_binder_txn_latency_alloc(void *ignore,
> +					struct binder_transaction *t)
> +{
> +	t->kt = ktime_get();
> +	t->real_kt = ktime_get_real();
> +	t->real_kt -= (sys_tz.tz_minuteswest * 60 * NSEC_PER_SEC);
> +}
> +
> +static void probe_binder_txn_latency_info(void *ignore, struct seq_file *m,
> +					struct binder_transaction *t)
> +{
> +	struct rtc_time tm;
> +
> +	tm = rtc_ktime_to_tm(t->real_kt);
> +	seq_printf(m,
> +		" start %lu.%06lu android %d-%02d-%02d %02d:%02d:%02d.%03lu",
> +		(unsigned long)ktime_divns(t->kt, NSEC_PER_SEC),
> +		(unsigned long)(ktime_to_us(t->kt) % USEC_PER_SEC),
> +		(tm.tm_year + 1900), (tm.tm_mon + 1), tm.tm_mday,
> +		 tm.tm_hour, tm.tm_min, tm.tm_sec,
> +		(unsigned long)(ktime_to_ms(t->real_kt) % MSEC_PER_SEC));

Again, isn't there a better way to export time information to userspace
where the kernel isn't doing the processing of the data itself?


> +}
> +
> +static int __init init_binder_latency_tracer(void)
> +{
> +	register_trace_binder_txn_latency_free(
> +			probe_binder_txn_latency_free, NULL);
> +	register_trace_binder_txn_latency_alloc(
> +			probe_binder_txn_latency_alloc, NULL);
> +	register_trace_binder_txn_latency_info(
> +			probe_binder_txn_latency_info, NULL);
> +
> +	return 0;
> +}
> +
> +static void exit_binder_latency_tracer(void)
> +{
> +	unregister_trace_binder_txn_latency_free(
> +			probe_binder_txn_latency_free, NULL);
> +	unregister_trace_binder_txn_latency_alloc(
> +			probe_binder_txn_latency_alloc, NULL);
> +	unregister_trace_binder_txn_latency_info(
> +			probe_binder_txn_latency_info, NULL);
> +}
> +
> +module_init(init_binder_latency_tracer);
> +module_exit(exit_binder_latency_tracer);
> +
> +MODULE_LICENSE("GPL v2");
> diff --git a/drivers/android/binder_trace.h b/drivers/android/binder_trace.h
> index 8eeccdc..5494f36 100644
> --- a/drivers/android/binder_trace.h
> +++ b/drivers/android/binder_trace.h
> @@ -95,6 +95,17 @@
>  		  __entry->thread_todo)
>  );
>  
> +DECLARE_TRACE(binder_txn_latency_alloc,
> +	TP_PROTO(struct binder_transaction *t),
> +	TP_ARGS(t)
> +);
> +
> +DECLARE_TRACE(binder_txn_latency_info,
> +	TP_PROTO(struct seq_file *m,
> +		 struct binder_transaction *t),
> +	TP_ARGS(m, t)
> +);
> +
>  TRACE_EVENT(binder_txn_latency_free,
>  	TP_PROTO(struct binder_transaction *t,
>  		 int from_proc, int from_thread,
> @@ -108,6 +119,8 @@
>  		__field(int, to_thread)
>  		__field(unsigned int, code)
>  		__field(unsigned int, flags)
> +		__field(unsigned long, start_sec)
> +		__field(unsigned long, start_msec)

Why track seconds and mseconds separately?  Can't you just track one
time value?

thanks,

greg k-h
