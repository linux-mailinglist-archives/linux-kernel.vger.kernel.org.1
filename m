Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C15F2E1DC7
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 16:12:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbgLWPMH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Dec 2020 10:12:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725270AbgLWPMG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 10:12:06 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8801FC0613D3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Dec 2020 07:11:25 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id h205so40821280lfd.5
        for <linux-kernel@vger.kernel.org>; Wed, 23 Dec 2020 07:11:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HIWL/JuOwTs8fSjEoyIMjsDQlo0J559SpBAXOpMKZ84=;
        b=R+Ku5JqFAgCWBFSZ80Yk9xF3+a8cgUYsEXWsFWbccQjztMgznn4TWqsugoWysPaB6J
         YYxk25rjM0M6q48n5aueEeSkhB+uXtYfFnKzVMSEvicvzavGYHlXlQ7dgif8fepocsdv
         s+kVf7QhNZvwk38eYcGRXT6PG4XkgFaTAfcNf6IyBkGDXlH2YjyMNpcJOlBrwa7FEruz
         W5uy/1JDC9Jgo6tAUlDF5jGVYuHTXTpCA/5bWeyG7CaoEDGuLBdS5D+MMX9OmpaI75qH
         D/xbYHqGhPbaV1mRecOmiQGbDpyU1QdsobDNEgKC6K3h8QaTxOx0Il2h0iRhTgJbdn+/
         jlOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HIWL/JuOwTs8fSjEoyIMjsDQlo0J559SpBAXOpMKZ84=;
        b=OvuSfNVC9b7TLk6ZrHD12KK0AHzfr/gnv+uY0jwmzGgQu7zVuHbBrDV3485gRPd9gH
         HEpwZfAoGIhQ9kxMw/TnwM5mapk8pPRqmsFM5f+eqQ3Vq9XBJXYYA6vbf1Wz5qbAf1Y6
         k1AMSnki68S6D3J5VJ8mdDBG/L4J4S/grDiEFDjxbjRSS1fnpQZkvJvNJijfVr0GnZ5Z
         YGjF4zinqJiSVhr3Blux73GcsCyZdrKK7ELBKO/k9lMr/kYKPEyUUMK7KHH5dwrMLOO0
         tmPX+Wg4V70dtLNYMRZtHYDTieOB+3meVd4ebJQKdvp4pqCKdl6++BLX/6i/Yp4b77+S
         jnPw==
X-Gm-Message-State: AOAM530feJVrlDbJ3XkO85341vawc93W16pbixC2lPRMPJxM07QMeD4q
        AQDdyU89dQwBSzXLLDhIu7mQENdbhdGlE/MqIEwLPg==
X-Google-Smtp-Source: ABdhPJwS4EjI+wzXBzWy2QVUrEHYCKo49x/l4X8MVckTy3v+3Idb+SvOToYEmtWJA74wf3iDBVxQy2kOd4m1cwwqcdc=
X-Received: by 2002:a05:651c:234:: with SMTP id z20mr11568564ljn.456.1608736283508;
 Wed, 23 Dec 2020 07:11:23 -0800 (PST)
MIME-Version: 1.0
References: <20201215115448.25633-1-sjpark@amazon.com> <20201215115448.25633-2-sjpark@amazon.com>
In-Reply-To: <20201215115448.25633-2-sjpark@amazon.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Wed, 23 Dec 2020 07:11:12 -0800
Message-ID: <CALvZod5C_Pt_BAVBW7QRYLnfv9=9Qs0K5=kXqyyM=2dg6EqVXw@mail.gmail.com>
Subject: Re: [PATCH v23 01/15] mm: Introduce Data Access MONitor (DAMON)
To:     SeongJae Park <sjpark@amazon.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        SeongJae Park <sjpark@amazon.de>, Jonathan.Cameron@huawei.com,
        Andrea Arcangeli <aarcange@redhat.com>, acme@kernel.org,
        alexander.shishkin@linux.intel.com, amit@kernel.org,
        benh@kernel.crashing.org, brendan.d.gregg@gmail.com,
        Brendan Higgins <brendanhiggins@google.com>,
        Qian Cai <cai@lca.pw>,
        Colin Ian King <colin.king@canonical.com>,
        Jonathan Corbet <corbet@lwn.net>,
        David Hildenbrand <david@redhat.com>, dwmw@amazon.com,
        Marco Elver <elver@google.com>, "Du, Fan" <fan.du@intel.com>,
        foersleo@amazon.de, Greg Thelen <gthelen@google.com>,
        Ian Rogers <irogers@google.com>, jolsa@redhat.com,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Mark Rutland <mark.rutland@arm.com>,
        Mel Gorman <mgorman@suse.de>, Minchan Kim <minchan@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, namhyung@kernel.org,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Rik van Riel <riel@surriel.com>,
        David Rientjes <rientjes@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mike Rapoport <rppt@kernel.org>, sblbir@amazon.com,
        Shuah Khan <shuah@kernel.org>, sj38.park@gmail.com,
        snu@amazon.de, Vlastimil Babka <vbabka@suse.cz>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Huang Ying <ying.huang@intel.com>, zgf574564920@gmail.com,
        linux-damon@amazon.com, Linux MM <linux-mm@kvack.org>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

First I would like you to prune your To/CC list.

On Tue, Dec 15, 2020 at 3:56 AM SeongJae Park <sjpark@amazon.com> wrote:
>
> From: SeongJae Park <sjpark@amazon.de>
>
> DAMON is a data access monitoring framework for the Linux kernel.  The
> core mechanisms of DAMON make it
>
>  - accurate (the monitoring output is useful enough for DRAM level
>    performance-centric memory management; It might be inappropriate for
>    CPU cache levels, though),
>  - light-weight (the monitoring overhead is normally low enough to be
>    applied online), and
>  - scalable (the upper-bound of the overhead is in constant range
>    regardless of the size of target workloads).
>
> Using this framework, hence, we can easily write efficient kernel space
> data access monitoring applications.  For example, the kernel's memory
> management mechanisms can make advanced decisions using this.
> Experimental data access aware optimization works that incurring high
> access monitoring overhead could implemented again on top of this.

*could again be implemented on*

>
> Due to its simple and flexible interface, providing user space interface
> would be also easy.  Then, user space users who have some special
> workloads can write personalized applications for better understanding
> and optimizations of their workloads and systems.
>
> ---
>
> Nevertheless, this commit is defining and implementing only basic access
> check part without the overhead-accuracy handling core logic.  The basic
> access check is as below.
>
> The output of DAMON says what memory regions are how frequently accessed
> for a given duration.  The resolution of the access frequency is
> controlled by setting ``sampling interval`` and ``aggregation
> interval``.  In detail, DAMON checks access to each page per ``sampling
> interval`` and aggregates the results.  In other words, counts the
> number of the accesses to each region.  After each ``aggregation
> interval`` passes, DAMON calls callback functions that previously
> registered by users so that users can read the aggregated results and
> then clears the results.  This can be described in below simple
> pseudo-code::
>
>     while monitoring_on:
>         for page in monitoring_target:
>             if accessed(page):
>                 nr_accesses[page] += 1
>         if time() % aggregation_interval == 0:
>             for callback in user_registered_callbacks:
>                 callback(monitoring_target, nr_accesses)
>             for page in monitoring_target:
>                 nr_accesses[page] = 0
>         sleep(sampling interval)
>

The above is a good example and I was hoping to see the almost same actual code.

> The target regions constructed at the beginning of the monitoring and
> updated after each ``regions_update_interval``, because the target
> regions could be dynamically changed (e.g., mmap() or memory hotplug).
> The monitoring overhead of this mechanism will arbitrarily increase as
> the size of the target workload grows.
>
> The basic monitoring primitives for actual access check and dynamic
> target regions construction aren't in the core part of DAMON.  Instead,
> it allows users to implement their own primitives that optimized for

'that are optimized for'

> their use case and configure DAMON to use those.  In other words, users
> cannot use current version of DAMON without some additional works.
>
> Following commits will implement the core mechanisms for the
> overhead-accuracy control and default primitives implementations.
>
> Signed-off-by: SeongJae Park <sjpark@amazon.de>
> Reviewed-by: Leonard Foerster <foersleo@amazon.de>
> ---
>  include/linux/damon.h | 167 ++++++++++++++++++++++
>  mm/Kconfig            |   2 +
>  mm/Makefile           |   1 +
>  mm/damon/Kconfig      |  15 ++
>  mm/damon/Makefile     |   3 +
>  mm/damon/core.c       | 316 ++++++++++++++++++++++++++++++++++++++++++
>  6 files changed, 504 insertions(+)
>  create mode 100644 include/linux/damon.h
>  create mode 100644 mm/damon/Kconfig
>  create mode 100644 mm/damon/Makefile
>  create mode 100644 mm/damon/core.c
>
> diff --git a/include/linux/damon.h b/include/linux/damon.h
> new file mode 100644
> index 000000000000..387fa4399fc8
> --- /dev/null
> +++ b/include/linux/damon.h
> @@ -0,0 +1,167 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * DAMON api
> + *
> + * Author: SeongJae Park <sjpark@amazon.de>
> + */
> +
> +#ifndef _DAMON_H_
> +#define _DAMON_H_
> +
> +#include <linux/mutex.h>
> +#include <linux/time64.h>
> +#include <linux/types.h>
> +
> +struct damon_ctx;
> +
> +/**
> + * struct damon_primitive      Monitoring primitives for given use cases.
> + *
> + * @init_target_regions:       Constructs initial monitoring target regions.
> + * @update_target_regions:     Updates monitoring target regions.

The 'region' here still does not feel right. I prefer to rename the
above two to just init() and update().

> + * @prepare_access_checks:     Prepares next access check of target regions.
> + * @check_accesses:            Checks the access of target regions.
> + * @reset_aggregated:          Resets aggregated accesses monitoring results.
> + * @target_valid:              Determine if the target is valid.
> + * @cleanup:                   Cleans up the context.
> + *
> + * DAMON can be extended for various address spaces and usages.  For this,
> + * users should register the low level primitives for their target address
> + * space and usecase via the &damon_ctx.primitive.  Then, the monitoring thread
> + * calls @init_target_regions and @prepare_access_checks before starting the
> + * monitoring, @update_target_regions after each
> + * &damon_ctx.regions_update_interval, and @check_accesses, @target_valid and
> + * @prepare_access_checks after each &damon_ctx.sample_interval.  Finally,
> + * @reset_aggregated is called after each &damon_ctx.aggr_interval.
> + *
> + * @init_target_regions should construct proper monitoring target regions and
> + * link those to the DAMON context struct.  The regions should be defined by
> + * user and saved in @damon_ctx.target.
> + * @update_target_regions should update the monitoring target regions for
> + * current status.
> + * @prepare_access_checks should manipulate the monitoring regions to be
> + * prepared for the next access check.
> + * @check_accesses should check the accesses to each region that made after the
> + * last preparation and update the number of observed accesses of each region.
> + * @reset_aggregated should reset the access monitoring results that aggregated
> + * by @check_accesses.
> + * @target_valid should check whether the target is still valid for the
> + * monitoring.
> + * @cleanup is called from @kdamond just before its termination.  After this
> + * call, only @kdamond_lock and @kdamond will be touched.
> + */
> +struct damon_primitive {
> +       void (*init_target_regions)(struct damon_ctx *context);
> +       void (*update_target_regions)(struct damon_ctx *context);
> +       void (*prepare_access_checks)(struct damon_ctx *context);
> +       void (*check_accesses)(struct damon_ctx *context);
> +       void (*reset_aggregated)(struct damon_ctx *context);
> +       bool (*target_valid)(void *target);
> +       void (*cleanup)(struct damon_ctx *context);
> +};
> +
> +/*
> + * struct damon_callback       Monitoring events notification callbacks.
> + *
> + * @before_start:      Called before starting the monitoring.
> + * @after_sampling:    Called after each sampling.
> + * @after_aggregation: Called after each aggregation.
> + * @before_terminate:  Called before terminating the monitoring.
> + * @private:           User private data.
> + *
> + * The monitoring thread (&damon_ctx->kdamond) calls @before_start and
> + * @before_terminate just before starting and finishing the monitoring,
> + * respectively.  Therefore, those are good places for installing and cleaning
> + * @private.
> + *
> + * The monitoring thread calls @after_sampling and @after_aggregation for each
> + * of the sampling intervals and aggregation intervals, respectively.
> + * Therefore, users can safely access the monitoring results without additional
> + * protection.  For the reason, users are recommended to use these callback for
> + * the accesses to the results.
> + *
> + * If any callback returns non-zero, monitoring stops.

I am not sure if this is the right patch to add this struct. Either we
need to add text why this is needed or add this patch when the real
user i.e. debugfs interface is added.

> + */
> +struct damon_callback {
> +       void *private;
> +
> +       int (*before_start)(struct damon_ctx *context);
> +       int (*after_sampling)(struct damon_ctx *context);
> +       int (*after_aggregation)(struct damon_ctx *context);
> +       int (*before_terminate)(struct damon_ctx *context);
> +};
> +
> +/**
> + * struct damon_ctx - Represents a context for each monitoring.  This is the
> + * main interface that allows users to set the attributes and get the results
> + * of the monitoring.
> + *
> + * @sample_interval:           The time between access samplings.
> + * @aggr_interval:             The time between monitor results aggregations.
> + * @regions_update_interval:   The time between monitor regions updates.

regions_update_internal should be part of the primitive abstraction
and the update() callback internally can check this field.

> + *
> + * For each @sample_interval, DAMON checks whether each region is accessed or
> + * not.  It aggregates and keeps the access information (number of accesses to
> + * each region) for @aggr_interval time.  DAMON also checks whether the target
> + * memory regions need update (e.g., by ``mmap()`` calls from the application,
> + * in case of virtual memory monitoring) and applies the changes for each
> + * @regions_update_interval.  All time intervals are in micro-seconds.  Please
> + * refer to &struct damon_primitive and &struct damon_callback for more detail.
> + *
> + * @kdamond:           Kernel thread who does the monitoring.
> + * @kdamond_stop:      Notifies whether kdamond should stop.
> + * @kdamond_lock:      Mutex for the synchronizations with @kdamond.
> + *
> + * For each monitoring context, one kernel thread for the monitoring is
> + * created.  The pointer to the thread is stored in @kdamond.
> + *
> + * Once started, the monitoring thread runs until explicitly required to be
> + * terminated or every monitoring target is invalid.  The validity of the
> + * targets is checked via the &damon_primitive.target_valid of @primitive.  The
> + * termination can also be explicitly requested by writing non-zero to
> + * @kdamond_stop.  The thread sets @kdamond to NULL when it terminates.
> + * Therefore, users can know whether the monitoring is ongoing or terminated by
> + * reading @kdamond.  Reads and writes to @kdamond and @kdamond_stop from
> + * outside of the monitoring thread must be protected by @kdamond_lock.
> + *
> + * Note that the monitoring thread protects only @kdamond and @kdamond_stop via
> + * @kdamond_lock.  Accesses to other fields must be protected by themselves.
> + *
> + * @primitive: Set of monitoring primitives for given use cases.
> + * @callback:  Set of callbacks for monitoring events notifications.
> + *
> + * @target:    Pointer to the user-defined monitoring target.
> + */
> +struct damon_ctx {
> +       unsigned long sample_interval;
> +       unsigned long aggr_interval;
> +       unsigned long regions_update_interval;
> +
> +/* private */
> +       struct timespec64 last_aggregation;
> +       struct timespec64 last_regions_update;
> +
> +/* public */
> +       struct task_struct *kdamond;
> +       bool kdamond_stop;
> +       struct mutex kdamond_lock;
> +
> +       struct damon_primitive primitive;
> +       struct damon_callback callback;
> +
> +       void *target;
> +};
> +
> +#ifdef CONFIG_DAMON
> +
> +struct damon_ctx *damon_new_ctx(void);
> +void damon_destroy_ctx(struct damon_ctx *ctx);
> +int damon_set_attrs(struct damon_ctx *ctx, unsigned long sample_int,
> +               unsigned long aggr_int, unsigned long regions_update_int);
> +
> +int damon_start(struct damon_ctx **ctxs, int nr_ctxs);
> +int damon_stop(struct damon_ctx **ctxs, int nr_ctxs);
> +
> +#endif /* CONFIG_DAMON */
> +
> +#endif /* _DAMON_H */
> diff --git a/mm/Kconfig b/mm/Kconfig
> index 390165ffbb0f..b97f2e8ab83f 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -859,4 +859,6 @@ config ARCH_HAS_HUGEPD
>  config MAPPING_DIRTY_HELPERS
>          bool
>
> +source "mm/damon/Kconfig"
> +
>  endmenu
> diff --git a/mm/Makefile b/mm/Makefile
> index d73aed0fc99c..8022b8f04096 100644
> --- a/mm/Makefile
> +++ b/mm/Makefile
> @@ -120,3 +120,4 @@ obj-$(CONFIG_MEMFD_CREATE) += memfd.o
>  obj-$(CONFIG_MAPPING_DIRTY_HELPERS) += mapping_dirty_helpers.o
>  obj-$(CONFIG_PTDUMP_CORE) += ptdump.o
>  obj-$(CONFIG_PAGE_REPORTING) += page_reporting.o
> +obj-$(CONFIG_DAMON) += damon/
> diff --git a/mm/damon/Kconfig b/mm/damon/Kconfig
> new file mode 100644
> index 000000000000..d00e99ac1a15
> --- /dev/null
> +++ b/mm/damon/Kconfig
> @@ -0,0 +1,15 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +
> +menu "Data Access Monitoring"
> +
> +config DAMON
> +       bool "DAMON: Data Access Monitoring Framework"
> +       help
> +         This builds a framework that allows kernel subsystems to monitor
> +         access frequency of each memory region. The information can be useful
> +         for performance-centric DRAM level memory management.
> +
> +         See https://damonitor.github.io/doc/html/latest-damon/index.html for
> +         more information.
> +
> +endmenu
> diff --git a/mm/damon/Makefile b/mm/damon/Makefile
> new file mode 100644
> index 000000000000..4fd2edb4becf
> --- /dev/null
> +++ b/mm/damon/Makefile
> @@ -0,0 +1,3 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +obj-$(CONFIG_DAMON)            := core.o
> diff --git a/mm/damon/core.c b/mm/damon/core.c
> new file mode 100644
> index 000000000000..8963804efdf9
> --- /dev/null
> +++ b/mm/damon/core.c
> @@ -0,0 +1,316 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Data Access Monitor
> + *
> + * Author: SeongJae Park <sjpark@amazon.de>
> + */
> +
> +#define pr_fmt(fmt) "damon: " fmt
> +
> +#include <linux/damon.h>
> +#include <linux/delay.h>
> +#include <linux/kthread.h>
> +#include <linux/slab.h>
> +
> +static DEFINE_MUTEX(damon_lock);
> +static int nr_running_ctxs;
> +
> +struct damon_ctx *damon_new_ctx(void)
> +{
> +       struct damon_ctx *ctx;
> +
> +       ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
> +       if (!ctx)
> +               return NULL;
> +
> +       ctx->sample_interval = 5 * 1000;
> +       ctx->aggr_interval = 100 * 1000;
> +       ctx->regions_update_interval = 1000 * 1000;
> +
> +       ktime_get_coarse_ts64(&ctx->last_aggregation);
> +       ctx->last_regions_update = ctx->last_aggregation;
> +
> +       mutex_init(&ctx->kdamond_lock);
> +
> +       ctx->target = NULL;
> +
> +       return ctx;
> +}
> +
> +void damon_destroy_ctx(struct damon_ctx *ctx)
> +{
> +       kfree(ctx);
> +}
> +
> +/**
> + * damon_set_attrs() - Set attributes for the monitoring.
> + * @ctx:               monitoring context
> + * @sample_int:                time interval between samplings
> + * @aggr_int:          time interval between aggregations
> + * @regions_update_int:        time interval between target regions update
> + *
> + * This function should not be called while the kdamond is running.
> + * Every time interval is in micro-seconds.
> + *
> + * Return: 0 on success, negative error code otherwise.
> + */
> +int damon_set_attrs(struct damon_ctx *ctx, unsigned long sample_int,
> +                   unsigned long aggr_int, unsigned long regions_update_int)
> +{
> +       ctx->sample_interval = sample_int;
> +       ctx->aggr_interval = aggr_int;
> +       ctx->regions_update_interval = regions_update_int;
> +
> +       return 0;
> +}
> +
> +static bool damon_kdamond_running(struct damon_ctx *ctx)
> +{
> +       bool running;
> +
> +       mutex_lock(&ctx->kdamond_lock);
> +       running = ctx->kdamond != NULL;
> +       mutex_unlock(&ctx->kdamond_lock);
> +
> +       return running;
> +}
> +
> +static int kdamond_fn(void *data);
> +
> +/*
> + * __damon_start() - Starts monitoring with given context.
> + * @ctx:       monitoring context
> + *
> + * This function should be called while damon_lock is hold.
> + *
> + * Return: 0 on success, negative error code otherwise.
> + */
> +static int __damon_start(struct damon_ctx *ctx)
> +{
> +       int err = -EBUSY;
> +
> +       mutex_lock(&ctx->kdamond_lock);
> +       if (!ctx->kdamond) {
> +               err = 0;
> +               ctx->kdamond_stop = false;
> +               ctx->kdamond = kthread_create(kdamond_fn, ctx, "kdamond.%d",
> +                               nr_running_ctxs);
> +               if (IS_ERR(ctx->kdamond))
> +                       err = PTR_ERR(ctx->kdamond);
> +               else
> +                       wake_up_process(ctx->kdamond);
> +       }
> +       mutex_unlock(&ctx->kdamond_lock);
> +
> +       return err;
> +}
> +
> +/**
> + * damon_start() - Starts the monitorings for a given group of contexts.
> + * @ctxs:      an array of the pointers for contexts to start monitoring
> + * @nr_ctxs:   size of @ctxs
> + *
> + * This function starts a group of monitoring threads for a group of monitoring
> + * contexts.  One thread per each context is created and run in parallel.  The
> + * caller should handle synchronization between the threads by itself.  If a
> + * group of threads that created by other 'damon_start()' call is currently
> + * running, this function does nothing but returns -EBUSY.
> + *
> + * Return: 0 on success, negative error code otherwise.
> + */
> +int damon_start(struct damon_ctx **ctxs, int nr_ctxs)
> +{
> +       int i;
> +       int err = 0;
> +
> +       mutex_lock(&damon_lock);
> +       if (nr_running_ctxs) {
> +               mutex_unlock(&damon_lock);
> +               return -EBUSY;
> +       }
> +
> +       for (i = 0; i < nr_ctxs; i++) {
> +               err = __damon_start(ctxs[i]);
> +               if (err)
> +                       break;
> +               nr_running_ctxs++;
> +       }
> +       mutex_unlock(&damon_lock);
> +
> +       return err;
> +}
> +
> +/*
> + * __damon_stop() - Stops monitoring of given context.
> + * @ctx:       monitoring context
> + *
> + * Return: 0 on success, negative error code otherwise.
> + */
> +static int __damon_stop(struct damon_ctx *ctx)
> +{
> +       mutex_lock(&ctx->kdamond_lock);
> +       if (ctx->kdamond) {
> +               ctx->kdamond_stop = true;
> +               mutex_unlock(&ctx->kdamond_lock);
> +               while (damon_kdamond_running(ctx))
> +                       usleep_range(ctx->sample_interval,
> +                                       ctx->sample_interval * 2);
> +               return 0;
> +       }
> +       mutex_unlock(&ctx->kdamond_lock);
> +
> +       return -EPERM;
> +}
> +
> +/**
> + * damon_stop() - Stops the monitorings for a given group of contexts.
> + * @ctxs:      an array of the pointers for contexts to stop monitoring
> + * @nr_ctxs:   size of @ctxs
> + *
> + * Return: 0 on success, negative error code otherwise.
> + */
> +int damon_stop(struct damon_ctx **ctxs, int nr_ctxs)
> +{
> +       int i, err = 0;
> +
> +       for (i = 0; i < nr_ctxs; i++) {
> +               /* nr_running_ctxs is decremented in kdamond_fn */
> +               err = __damon_stop(ctxs[i]);
> +               if (err)
> +                       return err;
> +       }
> +
> +       return err;
> +}
> +
> +/*
> + * damon_check_reset_time_interval() - Check if a time interval is elapsed.
> + * @baseline:  the time to check whether the interval has elapsed since
> + * @interval:  the time interval (microseconds)
> + *
> + * See whether the given time interval has passed since the given baseline
> + * time.  If so, it also updates the baseline to current time for next check.
> + *
> + * Return:     true if the time interval has passed, or false otherwise.
> + */
> +static bool damon_check_reset_time_interval(struct timespec64 *baseline,
> +               unsigned long interval)
> +{
> +       struct timespec64 now;
> +
> +       ktime_get_coarse_ts64(&now);
> +       if ((timespec64_to_ns(&now) - timespec64_to_ns(baseline)) <
> +                       interval * 1000)
> +               return false;
> +       *baseline = now;
> +       return true;
> +}
> +
> +/*
> + * Check whether it is time to flush the aggregated information
> + */
> +static bool kdamond_aggregate_interval_passed(struct damon_ctx *ctx)
> +{
> +       return damon_check_reset_time_interval(&ctx->last_aggregation,
> +                       ctx->aggr_interval);
> +}
> +
> +/*
> + * Check whether it is time to check and apply the target monitoring regions
> + *
> + * Returns true if it is.
> + */
> +static bool kdamond_need_update_regions(struct damon_ctx *ctx)
> +{
> +       return damon_check_reset_time_interval(&ctx->last_regions_update,
> +                       ctx->regions_update_interval);
> +}
> +
> +/*
> + * Check whether current monitoring should be stopped
> + *
> + * The monitoring is stopped when either the user requested to stop, or all
> + * monitoring targets are invalid.
> + *
> + * Returns true if need to stop current monitoring.
> + */
> +static bool kdamond_need_stop(struct damon_ctx *ctx)
> +{
> +       bool stop;
> +
> +       mutex_lock(&ctx->kdamond_lock);
> +       stop = ctx->kdamond_stop;
> +       mutex_unlock(&ctx->kdamond_lock);
> +       if (stop)
> +               return true;
> +
> +       if (!ctx->primitive.target_valid)
> +               return false;
> +
> +       return !ctx->primitive.target_valid(ctx->target);
> +}
> +
> +static void set_kdamond_stop(struct damon_ctx *ctx)
> +{
> +       mutex_lock(&ctx->kdamond_lock);
> +       ctx->kdamond_stop = true;
> +       mutex_unlock(&ctx->kdamond_lock);
> +}
> +
> +/*
> + * The monitoring daemon that runs as a kernel thread
> + */
> +static int kdamond_fn(void *data)
> +{
> +       struct damon_ctx *ctx = (struct damon_ctx *)data;
> +
> +       pr_info("kdamond (%d) starts\n", ctx->kdamond->pid);
> +
> +       if (ctx->primitive.init_target_regions)
> +               ctx->primitive.init_target_regions(ctx);
> +       if (ctx->callback.before_start && ctx->callback.before_start(ctx))
> +               set_kdamond_stop(ctx);
> +
> +       while (!kdamond_need_stop(ctx)) {
> +               if (ctx->primitive.prepare_access_checks)
> +                       ctx->primitive.prepare_access_checks(ctx);
> +               if (ctx->callback.after_sampling &&
> +                               ctx->callback.after_sampling(ctx))
> +                       set_kdamond_stop(ctx);

Is 'break' needed here? Or do we want to complete this iteration (same
for the set_kdamond_stop() below)?

> +
> +               usleep_range(ctx->sample_interval, ctx->sample_interval + 1);
> +
> +               if (ctx->primitive.check_accesses)
> +                       ctx->primitive.check_accesses(ctx);
> +
> +               if (kdamond_aggregate_interval_passed(ctx)) {
> +                       if (ctx->callback.after_aggregation &&
> +                                       ctx->callback.after_aggregation(ctx))
> +                               set_kdamond_stop(ctx);
> +                       if (ctx->primitive.reset_aggregated)
> +                               ctx->primitive.reset_aggregated(ctx);
> +               }
> +

The following 'if' can be done in ctx->primitive.update() callback.

> +               if (kdamond_need_update_regions(ctx)) {
> +                       if (ctx->primitive.update_target_regions)
> +                               ctx->primitive.update_target_regions(ctx);
> +               }
> +       }
> +
> +       if (ctx->callback.before_terminate &&
> +                       ctx->callback.before_terminate(ctx))
> +               set_kdamond_stop(ctx);
> +       if (ctx->primitive.cleanup)
> +               ctx->primitive.cleanup(ctx);
> +
> +       pr_debug("kdamond (%d) finishes\n", ctx->kdamond->pid);
> +       mutex_lock(&ctx->kdamond_lock);
> +       ctx->kdamond = NULL;
> +       mutex_unlock(&ctx->kdamond_lock);
> +
> +       mutex_lock(&damon_lock);
> +       nr_running_ctxs--;
> +       mutex_unlock(&damon_lock);
> +
> +       do_exit(0);
> +}
> --
> 2.17.1
>

Overall the patch looks good to me. Two concerns I have are if we
should damon_callback here or with the real user and the regions part
of primitive abstraction. For the first one, I don't have any strong
opinion but for the second one I do.

More specifically the question is if sampling and adaptive region
adjustment are general enough to be part of core monitoring context?
Can you give an example of a different primitive/use-case where these
would be beneficial.
