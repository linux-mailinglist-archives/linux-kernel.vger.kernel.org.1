Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC7C82FA9BA
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 20:09:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407940AbhARTJD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 14:09:03 -0500
Received: from mx2.suse.de ([195.135.220.15]:56284 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390531AbhARLjS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 06:39:18 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1610969911; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6xtedIaNjz+b+7QxWbQgF/bIHTuSe3HVqTwwf9HS5dU=;
        b=t48HPYuXw4uxRx5t/ek1zX30ldUuhZF66rf6N1zeFYxiMNGHATTuTBzYZPARlf+5M48aYJ
        lWKEBtaO7514vlvYQZCmZV2I5Oi5ieQQgVfj44vOK4PXIS9DyG1mv+RrAEAcDG6FjwOYd0
        5p0byl/MPjsUKP8AyLf052W3Xg3d+mU=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5EE78ACBA;
        Mon, 18 Jan 2021 11:38:31 +0000 (UTC)
Date:   Mon, 18 Jan 2021 12:38:30 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Alexander Potapenko <glider@google.com>
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        andreyknvl@google.com, dvyukov@google.com, mingo@redhat.com,
        elver@google.com, rostedt@goodmis.org,
        sergey.senozhatsky@gmail.com, linux-mm@kvack.org
Subject: Re: [PATCH v2 2/5] lib: add error_report_notify to collect debugging
 tools' reports
Message-ID: <YAVzNrBIlp0UJKfs@alley>
References: <20210115130336.2520663-1-glider@google.com>
 <20210115130336.2520663-3-glider@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210115130336.2520663-3-glider@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2021-01-15 14:03:33, Alexander Potapenko wrote:
> With the introduction of various production error-detection tools, such as
> MTE-based KASAN and KFENCE, the need arises to efficiently notify the
> userspace OS components about kernel errors. Currently, no facility exists
> to notify userspace about a kernel error from such bug-detection tools.
> The problem is obviously not restricted to the above bug detection tools,
> and applies to any error reporting mechanism that does not panic the
> kernel; this series, however, will only add support for KASAN and KFENCE
> reporting.
> 
> +++ b/lib/error_report_notify.c
> +/*
> + * Trace hook for the error_report_start event. In an unlikely case of another
> + * task already printing a report bail out, otherwise save the current pid
> + * together with in_task() return value.

This is not reliable. Some events might get lost.

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
> +	int idx;
> +
> +	if (pid != get_encoded_pid())
> +		return;
> +
> +	idx = (atomic_read(&num_reports) + 1) % 2;
> +	if (current_pos == BUF_SIZE)
> +		report_buffer[idx][current_pos - 1] = 0;
> +	else
> +		report_buffer[idx][current_pos] = 0;
> +
> +	/* Pairs with acquire in last_report_show(). */
> +	atomic_inc_return_release(&num_reports);
> +	schedule_delayed_work(&reporting_done, 0);

Why delayed work when it gets queued immediately?

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

The timestamp can be disabled also at runtime by
/sys/module/printk/parameters/time

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

IMHO, removing the timestamp is a bad idea. It will complicate
matching the message with other events.

I am afraid that some reports would get shrunken anyway.
I suggest to use some lockless ringbuffer to store these
messages. Either ftrace or printk one.

But the biggest problem would be that console might be called
asynchronously from another process. The messages might get
lost in the meantime.

There are many other more reliable solutions:

Either add hook into vprintk_store() and make another copy of the
message into your buffer. But there will still be the problem
that you could not store more reports in parallel. So, it won't
be reliable anyway.

Or add a hook into /dev/kmsg interface. It allows to read any
stored message immediately and quickly. Well, you would need
to have your own reader of this interface.

Or add your own reader of the main printk log.

Or give up on having your own buffers. Instead just inform userspace
about a new report via the pooled interface. And get the messages
from the main log, e.g. via /dev/kmsg.


I agree with Andrew that this might be _very_ dangerous feature.
It is another way how to get messages from kernel. It looks like
a hack how to get certain messages from the main kernel log
into a separate log. This might end up with implementing
yet another printk() or trace_printk().

I suggest to integrate this better with printk():

   + We already have printk_context() that allows to handle
     messages a special way.

   + Just store extra flag into the main log buffer for these
     messages.

   + Allow to read the messages via some interface, either
     /dev/kmsg or a new one. We already store PID and context
     info into the main log buffer. It will allow to put
     relevant lines together.

   + Anyway, I strongly suggest to avoid your own buffer. It looks
     like an overhead. It it would get more complicated when
     there are more users, ...


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

I still have to think about it. This feature heavily depends on
printk(). It makes sense to integrate it there. But we also
need to keep it simple because printk() is already pretty
complicated.

Best Regards,
Petr
