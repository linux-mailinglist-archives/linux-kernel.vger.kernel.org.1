Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A24EE2F7D26
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 14:52:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732981AbhAONvT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 08:51:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:46884 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727716AbhAONvS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 08:51:18 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9971123772;
        Fri, 15 Jan 2021 13:50:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1610718637;
        bh=0WTuCNiozbaTpqWtjJBv893NlezpmNUKr4rZJmVp89M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TymnUmcr8T/oc2s16cuAOBvwTT9QcWrBY89SUcTm1TEtDbON5ZJv9ki8lSxURgKLX
         vm6IIdpYkXJGEkUHeWmDQvx7QXomG8HxdQKr9NGP24Tpo9UyOi0FwEpLO4Gcv1kv/B
         MsMr4QFdxJWkRE9DiBHbsTHqjyVmNL3g8k7BC6YE=
Date:   Fri, 15 Jan 2021 14:50:34 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Alexander Potapenko <glider@google.com>
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        andreyknvl@google.com, dvyukov@google.com, mingo@redhat.com,
        elver@google.com, pmladek@suse.com, rostedt@goodmis.org,
        sergey.senozhatsky@gmail.com, linux-mm@kvack.org
Subject: Re: [PATCH v2 2/5] lib: add error_report_notify to collect debugging
 tools' reports
Message-ID: <YAGdqgjLd2XHAjjm@kroah.com>
References: <20210115130336.2520663-1-glider@google.com>
 <20210115130336.2520663-3-glider@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210115130336.2520663-3-glider@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Minor comments, if in the future, you really do want to mess around in sysfs:

On Fri, Jan 15, 2021 at 02:03:33PM +0100, Alexander Potapenko wrote:
> diff --git a/lib/error_report_notify.c b/lib/error_report_notify.c
> new file mode 100644
> index 000000000000..66176cd94ba0
> --- /dev/null
> +++ b/lib/error_report_notify.c
> @@ -0,0 +1,278 @@
> +// SPDX-License-Identifier: GPL-2.0
> +

No copyright notice for the file?  While acceptable, odds are your
corporate lawyers will not be happy with that :(

> +/*
> + * Userspace notification interface for debugging tools.
> + *
> + * Provide two sysfs files:
> + *  - /sys/kernel/error_report/last_report
> + *  - /sys/kernel/error_report/report_count
> + * that contain the last debugging tool report (taken from dmesg, delimited by
> + * the error_report_start/error_report_end tracing events) and the total report
> + * count.
> + */
> +
> +#include <linux/atomic.h>
> +#include <linux/fs.h>
> +#include <linux/kobject.h>
> +#include <linux/string.h>
> +#include <linux/sysfs.h>
> +#include <linux/tracepoint.h>
> +#include <linux/workqueue.h>
> +#include <trace/events/error_report.h>
> +#include <trace/events/printk.h>
> +
> +static struct kobject *error_report_kobj;
> +
> +/* sysfs files are capped at PAGE_SIZE. */
> +#define BUF_SIZE PAGE_SIZE
> +/* Two buffers to store the finished report and the report being recorded. */
> +static char report_buffer[2][BUF_SIZE];
> +/*
> + * Total report count. Also serves as a latch for report_buffer:
> + * report_buffer[num_reports % 2] is the currently available report,
> + * report_buffer[(num_reports + 1) % 2] is the report being recorded.
> + */
> +static atomic_t num_reports;
> +
> +/*
> + * PID of the task currently recording the report, as returned by
> + * get_encoded_pid(), or -1. Used as a writer lock for report_buffer.
> + * A regular spinlock couldn't be used here, as probe_console() can be called
> + * from any thread, and it needs to know whether that thread is holding the
> + * lock.
> + */
> +static atomic_t current_pid = ATOMIC_INIT(-1);

how do you handle pid namespaces?

> +
> +static size_t current_pos;
> +static bool truncated;
> +static const char TRUNC_MSG[] = "<truncated>\n";
> +
> +static struct delayed_work reporting_done;
> +
> +static void error_report_notify(struct work_struct *work)
> +{
> +	sysfs_notify(error_report_kobj, NULL, "last_report");
> +	sysfs_notify(error_report_kobj, NULL, "report_count");
> +}
> +static DECLARE_DELAYED_WORK(reporting_done, error_report_notify);
> +
> +/*
> + * Return the current PID combined together with in_task(). This lets us
> + * distinguish between normal task context and IRQ context.
> + */
> +static int get_encoded_pid(void)
> +{
> +	return (current->pid << 1) | (!!in_task());
> +}
> +
> +/*
> + * Trace hook for the error_report_start event. In an unlikely case of another
> + * task already printing a report bail out, otherwise save the current pid
> + * together with in_task() return value.
> + *
> + * Because reporting code can be called from low-level routines (e.g. locking
> + * primitives or allocator guts), report recording is implemented using a
> + * seqlock lock-free algorithm.
> + */
> +static void probe_report_start(void *ignore, enum error_detector detector,
> +			       unsigned long id)
> +{
> +	/*
> +	 * Acquire the writer lock. Any racing probe_report_start will not
> +	 * record anything. Pairs with the release in probe_report_end().
> +	 */
> +	if (atomic_cmpxchg_acquire(&current_pid, -1, get_encoded_pid()) != -1)
> +		return;

pid namespaces?

> +	current_pos = 0;
> +	truncated = false;
> +}
> +
> +/*
> + * Trace hook for the error_report_end event. If an event from the mismatching
> + * error_report_start is received, it is ignored. Otherwise, null-terminate the
> + * buffer, increase the report count (effectively releasing the report to
> + * last_report_show() and schedule a notification about a new report.
> + */
> +static void probe_report_end(void *ignore, enum error_detector detector,
> +			     unsigned long id)
> +{
> +	pid_t pid = atomic_read(&current_pid);

pid namespaces?

> +	int idx;
> +
> +	if (pid != get_encoded_pid())
> +		return;
> +
> +	idx = (atomic_read(&num_reports) + 1) % 2;

You read, but it could change before:

> +	if (current_pos == BUF_SIZE)
> +		report_buffer[idx][current_pos - 1] = 0;
> +	else
> +		report_buffer[idx][current_pos] = 0;
> +
> +	/* Pairs with acquire in last_report_show(). */
> +	atomic_inc_return_release(&num_reports);

Not good?

> +	schedule_delayed_work(&reporting_done, 0);
> +	/*
> +	 * Release the writer lock. Pairs with the acquire in
> +	 * probe_report_start().
> +	 */
> +	atomic_set_release(&current_pid, -1);
> +}
> +
> +/*
> + * Skip one or two leading pair of brackets containing the log timestamp and
> + * the task/CPU ID, plus the leading space, from the report line, e.g.:
> + *   [    0.698431][    T7] BUG: KFENCE: use-after-free ...
> + * becomes:
> + *   BUG: KFENCE: use-after-free ...
> + *
> + * Report size is only 4K, and this boilerplate can easily account for half of
> + * that amount.
> + */
> +static void skip_extra_info(const char **buf, size_t *len)
> +{
> +	int num_brackets = IS_ENABLED(CONFIG_PRINTK_TIME) +
> +			   IS_ENABLED(CONFIG_PRINTK_CALLER);
> +	const char *found;
> +
> +	if (!buf || !len)
> +		return;
> +
> +	while (num_brackets--) {
> +		if (!*len || *buf[0] != '[')
> +			return;
> +		found = strnchr(*buf, *len, ']');
> +		if (!found)
> +			return;
> +		*len -= found - *buf + 1;
> +		*buf = found + 1;
> +	}
> +	if (*len && *buf[0] == ' ') {
> +		++*buf;
> +		--*len;
> +	}
> +}
> +
> +/*
> + * Trace hook for the console event. If a line comes from a task/CPU that did
> + * not send the error_report_start event, that line is ignored. Otherwise, it
> + * is stored in the report_buffer[(num_reports + 1) % 2].
> + *
> + * To save space, the leading timestamps and (when enabled) CPU/task info is
> + * stripped away. The buffer may contain newlines, so this procedure is
> + * repeated for every line.
> + */
> +static void probe_console(void *ignore, const char *buf, size_t len)
> +{
> +	int pid = atomic_read(&current_pid);
> +	size_t to_copy, cur_len;
> +	char *newline;
> +	int idx;
> +
> +	if (pid != get_encoded_pid() || truncated)
> +		return;
> +
> +	idx = (atomic_read(&num_reports) + 1) % 2;
> +	while (len) {
> +		newline = strnchr(buf, len, '\n');
> +		if (newline)
> +			cur_len = newline - buf + 1;
> +		else
> +			cur_len = len;
> +		/* Adjust len now, because skip_extra_info() may change cur_len. */
> +		len -= cur_len;
> +		skip_extra_info(&buf, &cur_len);
> +		to_copy = min(cur_len, BUF_SIZE - current_pos);
> +		memcpy(report_buffer[idx] + current_pos, buf, to_copy);
> +		current_pos += to_copy;
> +		if (cur_len > to_copy) {
> +			truncated = true;
> +			memcpy(report_buffer[idx] + current_pos - sizeof(TRUNC_MSG),
> +			       TRUNC_MSG, sizeof(TRUNC_MSG));
> +			break;
> +		}
> +		buf += cur_len;
> +	}
> +}
> +
> +static void register_tracepoints(void)
> +{
> +	register_trace_console(probe_console, NULL);
> +	register_trace_error_report_start(probe_report_start, NULL);
> +	register_trace_error_report_end(probe_report_end, NULL);
> +}
> +
> +/*
> + * read() handler for /sys/kernel/error_report/last_report.
> + * Because the number of reports can change under our feet, check it again
> + * after copying the report, and retry if the numbers mismatch.
> + */
> +static ssize_t last_report_show(struct kobject *kobj,
> +				struct kobj_attribute *attr, char *buf)
> +{
> +	ssize_t ret;
> +	int index;
> +
> +	do {
> +		/* Pairs with release in probe_report_end(). */
> +		index = atomic_read_acquire(&num_reports);
> +		/*
> +		 * If index and old_index mismatch, we might be accessing
> +		 * report_buffer concurrently with a writer thread. In that
> +		 * case the read data will be discarded.
> +		 */
> +		ret = data_race(strscpy(buf, report_buffer[index % 2], BUF_SIZE));
> +		/*
> +		 * Prevent reordering between the memcpy above and the atomic
> +		 * read below.
> +		 * See the comments in include/linux/seqlock.h for more
> +		 * details.
> +		 */
> +		smp_rmb();
> +	} while (index != atomic_read(&num_reports));

endless loops, what could go wrong...

Why are you rolling your own hacky locks in here?

And again, sysfs is "one value" not "one buffer".

> +	return ret;
> +}
> +
> +/*
> + * read() handler for /sys/kernel/error_report/report_count.
> + */
> +static ssize_t report_count_show(struct kobject *kobj,
> +				 struct kobj_attribute *attr, char *buf)
> +{
> +	return scnprintf(buf, PAGE_SIZE, "%d\n", atomic_read(&num_reports));

sysfs_emit()?

And you just read it, but what keeps it from changing?

> +}
> +
> +static struct kobj_attribute last_report_attr = __ATTR_RO(last_report);
> +static struct kobj_attribute report_count_attr = __ATTR_RO(report_count);
> +static struct attribute *error_report_sysfs_attrs[] = {
> +	&last_report_attr.attr,
> +	&report_count_attr.attr,
> +	NULL,
> +};
> +
> +static const struct attribute_group error_report_sysfs_attr_group = {
> +	.attrs = error_report_sysfs_attrs,
> +};

ATTRIBUTE_GROUPS()?

> +
> +/*
> + * Set up report notification: register tracepoints and create
> + * /sys/kernel/error_report/.
> + */
> +static void error_report_notify_setup(void)
> +{
> +	int err;
> +
> +	register_tracepoints();
> +	error_report_kobj = kobject_create_and_add("error_report", kernel_kobj);
> +	if (!error_report_kobj)
> +		goto error;
> +	err = sysfs_create_group(error_report_kobj,
> +				 &error_report_sysfs_attr_group);
> +	if (err)
> +		goto error;
> +	return;
> +
> +error:
> +	if (error_report_kobj)
> +		kobject_del(error_report_kobj);
> +}
> +late_initcall(error_report_notify_setup);

You never clean up the kobject or files?

Anyway, please move this to tracefs, that's where it belongs.

thanks,

greg k-h
