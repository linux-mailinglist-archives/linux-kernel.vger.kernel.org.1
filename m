Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44B19304F84
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 04:20:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234843AbhA0DOr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 22:14:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:57804 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727697AbhAZT1y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 14:27:54 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D7F6E22228;
        Tue, 26 Jan 2021 19:26:53 +0000 (UTC)
Date:   Tue, 26 Jan 2021 14:26:52 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Viktor Rosendahl <Viktor.Rosendahl@bmw.de>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>
Subject: Re: [RFC PATCH 2/2] Add the latency-collector to tools
Message-ID: <20210126142652.41b961f2@gandalf.local.home>
In-Reply-To: <20210119164344.37500-3-Viktor.Rosendahl@bmw.de>
References: <20210119164344.37500-1-Viktor.Rosendahl@bmw.de>
        <20210119164344.37500-3-Viktor.Rosendahl@bmw.de>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Jan 2021 17:43:44 +0100
Viktor Rosendahl <Viktor.Rosendahl@bmw.de> wrote:

>  .PHONY: FORCE
> diff --git a/tools/tracing/Makefile b/tools/tracing/Makefile
> new file mode 100644
> index 000000000000..59cd483ab01f
> --- /dev/null
> +++ b/tools/tracing/Makefile
> @@ -0,0 +1,20 @@
> +# SPDX-License-Identifier: GPL-2.0
> +# Makefile for vm tools
> +#
> +TARGETS = latency-collector
> +CFLAGS = -Wall -Wextra -g -O2
> +LDFLAGS = -lpthread
> +
> +all: $(TARGETS)
> +
> +%: %.c
> +	$(CC) $(CFLAGS) -o $@ $< $(LDFLAGS)
> +
> +clean:
> +	$(RM) latency-collector
> +
> +sbindir ?= /usr/sbin
> +
> +install: all
> +	install -d $(DESTDIR)$(sbindir)
> +	install -m 755 -p $(TARGETS) $(DESTDIR)$(sbindir)
> diff --git a/tools/tracing/latency-collector.c b/tools/tracing/latency-collector.c
> new file mode 100644
> index 000000000000..e6e02d66b8bb
> --- /dev/null
> +++ b/tools/tracing/latency-collector.c
> @@ -0,0 +1,1212 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2017, 2018, 2019 BMW Car IT GmbH
> + * Author: Viktor Rosendahl (viktor.rosendahl@bmw.de)
> + */
> +
> +#define _GNU_SOURCE
> +#define _POSIX_C_SOURCE 200809L
> +
> +#include <stdbool.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +
> +#include <err.h>
> +#include <errno.h>
> +#include <fcntl.h>
> +#include <getopt.h>
> +#include <sched.h>
> +#include <linux/unistd.h>
> +#include <sys/inotify.h>
> +#include <unistd.h>
> +#include <pthread.h>
> +
> +static const char *prg_name;
> +static const char *prg_unknown = "unknown program name";
> +
> +static int fd_stdout;
> +
> +/* These are default values */
> +static int sched_policy;
> +static bool sched_policy_set;
> +
> +static int sched_pri;
> +static bool sched_pri_set;
> +
> +static bool trace_enable = true;
> +static bool use_random_sleep;
> +
> +static char inotify_buffer[655360];
> +
> +#define likely(x)      __builtin_expect(!!(x), 1)
> +#define unlikely(x)    __builtin_expect(!!(x), 0)
> +#define bool2str(x)    (x ? "true":"false")
> +
> +#define DEFAULT_NR_PRINTER_THREADS (3)
> +static unsigned int nr_threads = DEFAULT_NR_PRINTER_THREADS;
> +
> +#define DEFAULT_TABLE_SIZE (2)
> +static unsigned int table_startsize = DEFAULT_TABLE_SIZE;
> +
> +static int verbosity;
> +
> +#define verbose_sizechange() (verbosity >= 1)
> +#define verbose_lostevent()  (verbosity >= 2)
> +
> +static const char *debug_tracefile;
> +static const char *debug_tracefile_dflt = "/sys/kernel/debug/tracing/trace";

Can you rewrite this using libtracefs APIs:

 man pages: https://trace-cmd.org/Documentation/libtracefs/libtracefs.html

The git repo: https://git.kernel.org/pub/scm/libs/libtrace/libtracefs.git/

Which depends on libtraceevent:

  https://git.kernel.org/pub/scm/libs/libtrace/libtraceevent.git/

These are being brought over to the distros as well.

They use pkg-config to find them.

By using libtracefs, it will handle finding where tracefs is located (as
it's not always where you think it is). It can facilitate the finding of
tracefs files. It can also make it easier for you to enable a tracer.

For example:

#include <string.h>
#include <tracefs.h>

int main () {
	char **tracers;
	int i;

	tracers = tracefs_tracers(NULL);
	for (i = 0; tracers && tracers[i]; i++) {
		if (!strcmp(tracers[i],"preemptirqsoff"))
			break;
	}
	if (!tracers || !tracers[i]) {
		printf("preemptirqsoff not found\n");
		tracefs_list_free(tracers);
		return -1;
	}
	tracefs_instance_file_write(NULL, "current_tracer", tracers[i]);
	tracefs_list_free(tracers);
	return 0;
}

See how easy that was to enable the "preemptirqsoff" tracer!

We are adding more APIs to libtracefs, and if there's something you find
useful, please send a feature request here:

 https://bugzilla.kernel.org/buglist.cgi?component=Trace-cmd%2FKernelshark&product=Tools&resolution=---

And you can even help us in development by joining the mailing list:

 http://vger.kernel.org/vger-lists.html#linux-trace-devel

And IRC:  OFTC #trace-cmd

-- Steve


> +static const char *debug_maxlat_file;
> +static const char *debug_maxlat_dflt =
> +	"/sys/kernel/debug/tracing/tracing_max_latency";
> +
> +
> +#define DEV_URANDOM     "/dev/urandom"
> +#define RT_DEFAULT_PRI (99)
> +#define DEFAULT_PRI    (0)
> +
