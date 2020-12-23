Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE7422E1F7D
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 17:34:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbgLWQeq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Dec 2020 11:34:46 -0500
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:40232 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725785AbgLWQep (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 11:34:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1608741284; x=1640277284;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   mime-version;
  bh=Amjf4Nd9P7yDOjz0bAkirUS++C7I5gsECdGtUXZ2REE=;
  b=DmuXmkUrzQS2wExYBys6gjmI0BysASf7I53NKIZUy7ExrwrupF1L2qXU
   9iJqmqjIbiiPqscf4thbQKhLkyOPjQJEmDSpkUSweEYkm5ar7JXi4ohVF
   +qCNwtoYo23Bt717wtc+vHMK1dViIGIiytzS15cImuJ6MLy6LvCOPPKVO
   8=;
X-IronPort-AV: E=Sophos;i="5.78,441,1599523200"; 
   d="scan'208";a="71234674"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-2a-6e2fc477.us-west-2.amazon.com) ([10.43.8.2])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP; 23 Dec 2020 16:33:50 +0000
Received: from EX13D31EUA001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-2a-6e2fc477.us-west-2.amazon.com (Postfix) with ESMTPS id 0DE89A0391;
        Wed, 23 Dec 2020 16:33:47 +0000 (UTC)
Received: from u3f2cd687b01c55.ant.amazon.com (10.43.162.211) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 23 Dec 2020 16:33:30 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     Shakeel Butt <shakeelb@google.com>
CC:     SeongJae Park <sjpark@amazon.com>,
        SeongJae Park <sjpark@amazon.de>,
        <Jonathan.Cameron@huawei.com>,
        Andrea Arcangeli <aarcange@redhat.com>, <acme@kernel.org>,
        <alexander.shishkin@linux.intel.com>, <amit@kernel.org>,
        <benh@kernel.crashing.org>, <brendan.d.gregg@gmail.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Qian Cai <cai@lca.pw>,
        Colin Ian King <colin.king@canonical.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "David Hildenbrand" <david@redhat.com>, <dwmw@amazon.com>,
        Marco Elver <elver@google.com>, "Du, Fan" <fan.du@intel.com>,
        <foersleo@amazon.de>, "Greg Thelen" <gthelen@google.com>,
        Ian Rogers <irogers@google.com>, <jolsa@redhat.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Mark Rutland <mark.rutland@arm.com>,
        Mel Gorman <mgorman@suse.de>, Minchan Kim <minchan@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, <namhyung@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Rik van Riel <riel@surriel.com>,
        David Rientjes <rientjes@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mike Rapoport <rppt@kernel.org>, <sblbir@amazon.com>,
        Shuah Khan <shuah@kernel.org>, <sj38.park@gmail.com>,
        <snu@amazon.de>, Vlastimil Babka <vbabka@suse.cz>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Huang Ying <ying.huang@intel.com>, <zgf574564920@gmail.com>,
        <linux-damon@amazon.com>, Linux MM <linux-mm@kvack.org>,
        <linux-doc@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v23 01/15] mm: Introduce Data Access MONitor (DAMON)
Date:   Wed, 23 Dec 2020 17:33:17 +0100
Message-ID: <20201223163317.25979-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <CALvZod5C_Pt_BAVBW7QRYLnfv9=9Qs0K5=kXqyyM=2dg6EqVXw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.162.211]
X-ClientProxiedBy: EX13D24UWB002.ant.amazon.com (10.43.161.159) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the valuable comments, Shakeel!

On Wed, 23 Dec 2020 07:11:12 -0800 Shakeel Butt <shakeelb@google.com> wrote:

> First I would like you to prune your To/CC list.

I will remove people not directly related with this work and didn't comment to
this series yet.

> 
> On Tue, Dec 15, 2020 at 3:56 AM SeongJae Park <sjpark@amazon.com> wrote:
> >
> > From: SeongJae Park <sjpark@amazon.de>
> >
> > DAMON is a data access monitoring framework for the Linux kernel.  The
> > core mechanisms of DAMON make it
> >
> >  - accurate (the monitoring output is useful enough for DRAM level
> >    performance-centric memory management; It might be inappropriate for
> >    CPU cache levels, though),
> >  - light-weight (the monitoring overhead is normally low enough to be
> >    applied online), and
> >  - scalable (the upper-bound of the overhead is in constant range
> >    regardless of the size of target workloads).
> >
> > Using this framework, hence, we can easily write efficient kernel space
> > data access monitoring applications.  For example, the kernel's memory
> > management mechanisms can make advanced decisions using this.
> > Experimental data access aware optimization works that incurring high
> > access monitoring overhead could implemented again on top of this.
> 
> *could again be implemented on*

Good eye!  I will fix this in the next version.

> 
> >
> > Due to its simple and flexible interface, providing user space interface
> > would be also easy.  Then, user space users who have some special
> > workloads can write personalized applications for better understanding
> > and optimizations of their workloads and systems.
> >
> > ---
> >
> > Nevertheless, this commit is defining and implementing only basic access
> > check part without the overhead-accuracy handling core logic.  The basic
> > access check is as below.
> >
> > The output of DAMON says what memory regions are how frequently accessed
> > for a given duration.  The resolution of the access frequency is
> > controlled by setting ``sampling interval`` and ``aggregation
> > interval``.  In detail, DAMON checks access to each page per ``sampling
> > interval`` and aggregates the results.  In other words, counts the
> > number of the accesses to each region.  After each ``aggregation
> > interval`` passes, DAMON calls callback functions that previously
> > registered by users so that users can read the aggregated results and
> > then clears the results.  This can be described in below simple
> > pseudo-code::
> >
> >     while monitoring_on:
> >         for page in monitoring_target:
> >             if accessed(page):
> >                 nr_accesses[page] += 1
> >         if time() % aggregation_interval == 0:
> >             for callback in user_registered_callbacks:
> >                 callback(monitoring_target, nr_accesses)
> >             for page in monitoring_target:
> >                 nr_accesses[page] = 0
> >         sleep(sampling interval)
> >
> 
> The above is a good example and I was hoping to see the almost same actual code.

Oh, this doesn't explain about the 'update'.  I will update this in the next
version.

> 
> > The target regions constructed at the beginning of the monitoring and
> > updated after each ``regions_update_interval``, because the target
> > regions could be dynamically changed (e.g., mmap() or memory hotplug).
> > The monitoring overhead of this mechanism will arbitrarily increase as
> > the size of the target workload grows.
> >
> > The basic monitoring primitives for actual access check and dynamic
> > target regions construction aren't in the core part of DAMON.  Instead,
> > it allows users to implement their own primitives that optimized for
> 
> 'that are optimized for'

Good catch!  I will fix this in the next version.

> 
> > their use case and configure DAMON to use those.  In other words, users
> > cannot use current version of DAMON without some additional works.
> >
> > Following commits will implement the core mechanisms for the
> > overhead-accuracy control and default primitives implementations.
> >
> > Signed-off-by: SeongJae Park <sjpark@amazon.de>
> > Reviewed-by: Leonard Foerster <foersleo@amazon.de>
> > ---
> >  include/linux/damon.h | 167 ++++++++++++++++++++++
> >  mm/Kconfig            |   2 +
> >  mm/Makefile           |   1 +
> >  mm/damon/Kconfig      |  15 ++
> >  mm/damon/Makefile     |   3 +
> >  mm/damon/core.c       | 316 ++++++++++++++++++++++++++++++++++++++++++
> >  6 files changed, 504 insertions(+)
> >  create mode 100644 include/linux/damon.h
> >  create mode 100644 mm/damon/Kconfig
> >  create mode 100644 mm/damon/Makefile
> >  create mode 100644 mm/damon/core.c
> >
> > diff --git a/include/linux/damon.h b/include/linux/damon.h
> > new file mode 100644
> > index 000000000000..387fa4399fc8
> > --- /dev/null
> > +++ b/include/linux/damon.h
> > @@ -0,0 +1,167 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * DAMON api
> > + *
> > + * Author: SeongJae Park <sjpark@amazon.de>
> > + */
> > +
> > +#ifndef _DAMON_H_
> > +#define _DAMON_H_
> > +
> > +#include <linux/mutex.h>
> > +#include <linux/time64.h>
> > +#include <linux/types.h>
> > +
> > +struct damon_ctx;
> > +
> > +/**
> > + * struct damon_primitive      Monitoring primitives for given use cases.
> > + *
> > + * @init_target_regions:       Constructs initial monitoring target regions.
> > + * @update_target_regions:     Updates monitoring target regions.
> 
> The 'region' here still does not feel right. I prefer to rename the
> above two to just init() and update().

Agreed.  I will rename so in the next version.

> 
> > + * @prepare_access_checks:     Prepares next access check of target regions.
> > + * @check_accesses:            Checks the access of target regions.
> > + * @reset_aggregated:          Resets aggregated accesses monitoring results.
> > + * @target_valid:              Determine if the target is valid.
> > + * @cleanup:                   Cleans up the context.
> > + *
> > + * DAMON can be extended for various address spaces and usages.  For this,
> > + * users should register the low level primitives for their target address
> > + * space and usecase via the &damon_ctx.primitive.  Then, the monitoring thread
> > + * calls @init_target_regions and @prepare_access_checks before starting the
> > + * monitoring, @update_target_regions after each
> > + * &damon_ctx.regions_update_interval, and @check_accesses, @target_valid and
> > + * @prepare_access_checks after each &damon_ctx.sample_interval.  Finally,
> > + * @reset_aggregated is called after each &damon_ctx.aggr_interval.
> > + *
> > + * @init_target_regions should construct proper monitoring target regions and
> > + * link those to the DAMON context struct.  The regions should be defined by
> > + * user and saved in @damon_ctx.target.
> > + * @update_target_regions should update the monitoring target regions for
> > + * current status.
> > + * @prepare_access_checks should manipulate the monitoring regions to be
> > + * prepared for the next access check.
> > + * @check_accesses should check the accesses to each region that made after the
> > + * last preparation and update the number of observed accesses of each region.
> > + * @reset_aggregated should reset the access monitoring results that aggregated
> > + * by @check_accesses.
> > + * @target_valid should check whether the target is still valid for the
> > + * monitoring.
> > + * @cleanup is called from @kdamond just before its termination.  After this
> > + * call, only @kdamond_lock and @kdamond will be touched.
> > + */
> > +struct damon_primitive {
> > +       void (*init_target_regions)(struct damon_ctx *context);
> > +       void (*update_target_regions)(struct damon_ctx *context);
> > +       void (*prepare_access_checks)(struct damon_ctx *context);
> > +       void (*check_accesses)(struct damon_ctx *context);
> > +       void (*reset_aggregated)(struct damon_ctx *context);
> > +       bool (*target_valid)(void *target);
> > +       void (*cleanup)(struct damon_ctx *context);
> > +};
> > +
> > +/*
> > + * struct damon_callback       Monitoring events notification callbacks.
> > + *
> > + * @before_start:      Called before starting the monitoring.
> > + * @after_sampling:    Called after each sampling.
> > + * @after_aggregation: Called after each aggregation.
> > + * @before_terminate:  Called before terminating the monitoring.
> > + * @private:           User private data.
> > + *
> > + * The monitoring thread (&damon_ctx->kdamond) calls @before_start and
> > + * @before_terminate just before starting and finishing the monitoring,
> > + * respectively.  Therefore, those are good places for installing and cleaning
> > + * @private.
> > + *
> > + * The monitoring thread calls @after_sampling and @after_aggregation for each
> > + * of the sampling intervals and aggregation intervals, respectively.
> > + * Therefore, users can safely access the monitoring results without additional
> > + * protection.  For the reason, users are recommended to use these callback for
> > + * the accesses to the results.
> > + *
> > + * If any callback returns non-zero, monitoring stops.
> 
> I am not sure if this is the right patch to add this struct. Either we
> need to add text why this is needed or add this patch when the real
> user i.e. debugfs interface is added.

I think this is better to be here to let people know how DAMON API users can
access to the monitoring result.

> 
> > + */
> > +struct damon_callback {
> > +       void *private;
> > +
> > +       int (*before_start)(struct damon_ctx *context);
> > +       int (*after_sampling)(struct damon_ctx *context);
> > +       int (*after_aggregation)(struct damon_ctx *context);
> > +       int (*before_terminate)(struct damon_ctx *context);
> > +};
> > +
> > +/**
> > + * struct damon_ctx - Represents a context for each monitoring.  This is the
> > + * main interface that allows users to set the attributes and get the results
> > + * of the monitoring.
> > + *
> > + * @sample_interval:           The time between access samplings.
> > + * @aggr_interval:             The time between monitor results aggregations.
> > + * @regions_update_interval:   The time between monitor regions updates.
> 
> regions_update_internal should be part of the primitive abstraction
> and the update() callback internally can check this field.

I think the field should be renamed to be independent from the 'region'
concept.

However, if we agree that the 'update()' is general concept (I assume
so because you didn't object to adding 'update()' callback), I believe this
should be here, because the interval is the part of the monitoring request.
Also, I unsure how the monitoring thread could know when to call 'update()'
callback if this field is not here.

[...]
> > diff --git a/mm/Kconfig b/mm/Kconfig
> > index 390165ffbb0f..b97f2e8ab83f 100644
> > --- a/mm/Kconfig
> > +++ b/mm/Kconfig
> > @@ -859,4 +859,6 @@ config ARCH_HAS_HUGEPD
> >  config MAPPING_DIRTY_HELPERS
> >          bool
> >
> > +source "mm/damon/Kconfig"
> > +
> >  endmenu
> > diff --git a/mm/Makefile b/mm/Makefile
> > index d73aed0fc99c..8022b8f04096 100644
> > --- a/mm/Makefile
> > +++ b/mm/Makefile
> > @@ -120,3 +120,4 @@ obj-$(CONFIG_MEMFD_CREATE) += memfd.o
> >  obj-$(CONFIG_MAPPING_DIRTY_HELPERS) += mapping_dirty_helpers.o
> >  obj-$(CONFIG_PTDUMP_CORE) += ptdump.o
> >  obj-$(CONFIG_PAGE_REPORTING) += page_reporting.o
> > +obj-$(CONFIG_DAMON) += damon/
> > diff --git a/mm/damon/Kconfig b/mm/damon/Kconfig
> > new file mode 100644
> > index 000000000000..d00e99ac1a15
> > --- /dev/null
> > +++ b/mm/damon/Kconfig
> > @@ -0,0 +1,15 @@
> > +# SPDX-License-Identifier: GPL-2.0-only
> > +
> > +menu "Data Access Monitoring"
> > +
> > +config DAMON
> > +       bool "DAMON: Data Access Monitoring Framework"
> > +       help
> > +         This builds a framework that allows kernel subsystems to monitor
> > +         access frequency of each memory region. The information can be useful
> > +         for performance-centric DRAM level memory management.
> > +
> > +         See https://damonitor.github.io/doc/html/latest-damon/index.html for
> > +         more information.
> > +
> > +endmenu
> > diff --git a/mm/damon/Makefile b/mm/damon/Makefile
> > new file mode 100644
> > index 000000000000..4fd2edb4becf
> > --- /dev/null
> > +++ b/mm/damon/Makefile
> > @@ -0,0 +1,3 @@
> > +# SPDX-License-Identifier: GPL-2.0
> > +
> > +obj-$(CONFIG_DAMON)            := core.o
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > new file mode 100644
> > index 000000000000..8963804efdf9
> > --- /dev/null
> > +++ b/mm/damon/core.c
[...]
> > +/*
> > + * The monitoring daemon that runs as a kernel thread
> > + */
> > +static int kdamond_fn(void *data)
> > +{
> > +       struct damon_ctx *ctx = (struct damon_ctx *)data;
> > +
> > +       pr_info("kdamond (%d) starts\n", ctx->kdamond->pid);
> > +
> > +       if (ctx->primitive.init_target_regions)
> > +               ctx->primitive.init_target_regions(ctx);
> > +       if (ctx->callback.before_start && ctx->callback.before_start(ctx))
> > +               set_kdamond_stop(ctx);
> > +
> > +       while (!kdamond_need_stop(ctx)) {
> > +               if (ctx->primitive.prepare_access_checks)
> > +                       ctx->primitive.prepare_access_checks(ctx);
> > +               if (ctx->callback.after_sampling &&
> > +                               ctx->callback.after_sampling(ctx))
> > +                       set_kdamond_stop(ctx);
> 
> Is 'break' needed here? Or do we want to complete this iteration (same
> for the set_kdamond_stop() below)?

My intention was to complete this iteration.  I think it could give slightly
simpler view to primitives and callbacks implementing people, because they can
assume callbacks in each iteration will be called.

> 
> > +
> > +               usleep_range(ctx->sample_interval, ctx->sample_interval + 1);
> > +
> > +               if (ctx->primitive.check_accesses)
> > +                       ctx->primitive.check_accesses(ctx);
> > +
> > +               if (kdamond_aggregate_interval_passed(ctx)) {
> > +                       if (ctx->callback.after_aggregation &&
> > +                                       ctx->callback.after_aggregation(ctx))
> > +                               set_kdamond_stop(ctx);
> > +                       if (ctx->primitive.reset_aggregated)
> > +                               ctx->primitive.reset_aggregated(ctx);
> > +               }
> > +
> 
> The following 'if' can be done in ctx->primitive.update() callback.

I think this could be common to multiple primitives, so I'd like to let it be
here to minimize code duplication.

> 
> > +               if (kdamond_need_update_regions(ctx)) {
> > +                       if (ctx->primitive.update_target_regions)
> > +                               ctx->primitive.update_target_regions(ctx);
> > +               }
> > +       }
> > +
> > +       if (ctx->callback.before_terminate &&
> > +                       ctx->callback.before_terminate(ctx))
> > +               set_kdamond_stop(ctx);
> > +       if (ctx->primitive.cleanup)
> > +               ctx->primitive.cleanup(ctx);
> > +
> > +       pr_debug("kdamond (%d) finishes\n", ctx->kdamond->pid);
> > +       mutex_lock(&ctx->kdamond_lock);
> > +       ctx->kdamond = NULL;
> > +       mutex_unlock(&ctx->kdamond_lock);
> > +
> > +       mutex_lock(&damon_lock);
> > +       nr_running_ctxs--;
> > +       mutex_unlock(&damon_lock);
> > +
> > +       do_exit(0);
> > +}
> > --
> > 2.17.1
> >
> 
> Overall the patch looks good to me. Two concerns I have are if we
> should damon_callback here or with the real user and the regions part
> of primitive abstraction. For the first one, I don't have any strong
> opinion but for the second one I do.

I'd like to keep 'damon_callback' part here, to let API users know how the
monitoring result will be available to them.

For the 'regions' part, I will rename relevant things as below in the next
version, to reduce any confusion.

init_target_regions() -> init()
update_target_regions() -> update()
regions_update_interval -> update_interval
last_regions_update -> last_update

> 
> More specifically the question is if sampling and adaptive region
> adjustment are general enough to be part of core monitoring context?
> Can you give an example of a different primitive/use-case where these
> would be beneficial.

I think all adress spaces having some spatial locality and monitoring requests
that need to have upper-bound overhead and best-effort accuracy could get
benefit from it.  The primitives targetting 'virtual address spaces' and the
'physical address space' clearly showed the benefit.
