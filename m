Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93E2F2C53A5
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 13:13:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388659AbgKZMLD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 07:11:03 -0500
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:54309 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731101AbgKZMLB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 07:11:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1606392658; x=1637928658;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   mime-version;
  bh=d+vtLeEm4g/zBm10roAQekwpF+nYbX3GqtiwCuAopjQ=;
  b=bDmUVSBXATzCjkI9IRxvrF/jpN2+TfSkAxMKDzXB6dodtnFOT1aMSqYG
   a30hBwcFq2lLp38bfyDKRgD4d85/k+qv3NmrZCXSa13dJOFRvtTpTBwMe
   GGXXUnWgq85ICPbrp1owMKfBLIaWBBDoiiP8Qe6dgdZ62ASNUbqRfuyrO
   A=;
X-IronPort-AV: E=Sophos;i="5.78,372,1599523200"; 
   d="scan'208";a="98175626"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1a-807d4a99.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP; 26 Nov 2020 12:10:43 +0000
Received: from EX13D31EUA001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
        by email-inbound-relay-1a-807d4a99.us-east-1.amazon.com (Postfix) with ESMTPS id 7423DA080E;
        Thu, 26 Nov 2020 12:10:30 +0000 (UTC)
Received: from u3f2cd687b01c55.ant.amazon.com (10.43.160.125) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 26 Nov 2020 12:10:13 +0000
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
Subject: Re: [PATCH v22 02/18] mm/damon: Implement region based sampling
Date:   Thu, 26 Nov 2020 13:09:59 +0100
Message-ID: <20201126120959.14474-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <CALvZod7CMRmM0t5NFkWdSNHkG1fPzVPJZkoaitAHSXosU2=PmQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.160.125]
X-ClientProxiedBy: EX13D01UWB001.ant.amazon.com (10.43.161.75) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Nov 2020 07:29:27 -0800 Shakeel Butt <shakeelb@google.com> wrote:

> On Tue, Oct 20, 2020 at 2:01 AM SeongJae Park <sjpark@amazon.com> wrote:
> >
> > From: SeongJae Park <sjpark@amazon.de>
> >
> > DAMON separates its monitoring target address space independent high
> > level logics
> 
> Please rewrite the above sentence to be more clear.

Yes, I will in the next version.

> 
> > from the target space dependent low level primitives for
> > flexible support of various address spaces.
> >
> > This commit implements DAMON's target address space independent high
> > level logics for basic access check and region based sampling.
> 
> Same for the above text.

Sure.

> 
> > Hence,
> > without the target address space specific parts implementations, this
> > doesn't work alone.  A reference implementation of those will be
> > provided by a later commit.
> >
> > Basic Access Check
> > ==================
> >
> > The output of DAMON says what pages are how frequently accessed for a
> > given duration.  The resolution of the access frequency is controlled by
> > setting ``sampling interval`` and ``aggregation interval``.  In detail,
> > DAMON checks access to each page per ``sampling interval`` and
> > aggregates the results.  In other words, counts the number of the
> > accesses to each page.  After each ``aggregation interval`` passes,
> > DAMON calls callback functions that previously registered by users so
> > that users can read the aggregated results and then clears the results.
> > This can be described in below simple pseudo-code::
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
> > The monitoring overhead of this mechanism will arbitrarily increase as
> > the size of the target workload grows.
> >
> 
> Please move the sampling part in a separate patch.

Ok.  I will do so by implementing 'ARBITRARY_TARGETS' type I suggested in the
reply tou your review on PATCH 1[1].

[1] https://lore.kernel.org/linux-mm/20201126115157.6888-1-sjpark@amazon.com/

> 
> > Region Based Sampling
> > =====================
> >
> > To avoid the unbounded increase of the overhead, DAMON groups adjacent
> > pages that assumed to have the same access frequencies into a region.
> > As long as the assumption (pages in a region have the same access
> > frequencies) is kept, only one page in the region is required to be
> > checked.  Thus, for each ``sampling interval``, DAMON randomly picks one
> > page in each region, waits for one ``sampling interval``, checks whether
> > the page is accessed meanwhile, and increases the access frequency of
> > the region if so.  Therefore, the monitoring overhead is controllable by
> > setting the number of regions.  DAMON allows users to set the minimum
> > and the maximum number of regions for the trade-off.
> >
> > This scheme, however, cannot preserve the quality of the output if the
> > assumption is not guaranteed.  Next commit will address this problem.
> >
> > Signed-off-by: SeongJae Park <sjpark@amazon.de>
> > Reviewed-by: Leonard Foerster <foersleo@amazon.de>
> > ---
> >  include/linux/damon.h | 133 ++++++++++++++++-
> >  mm/damon/core.c       | 333 ++++++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 465 insertions(+), 1 deletion(-)
> >
> > diff --git a/include/linux/damon.h b/include/linux/damon.h
> > index 183e0edd7f43..1f7b095646c2 100644
> > --- a/include/linux/damon.h
> > +++ b/include/linux/damon.h
> > @@ -8,6 +8,8 @@
> >  #ifndef _DAMON_H_
> >  #define _DAMON_H_
> >
> > +#include <linux/mutex.h>
> > +#include <linux/time64.h>
> >  #include <linux/types.h>
> >
> >  /**
> > @@ -23,11 +25,13 @@ struct damon_addr_range {
> >  /**
> >   * struct damon_region - Represents a monitoring target region.
> >   * @ar:                        The address range of the region.
> > + * @sampling_addr:     Address of the sample for the next access check.
> >   * @nr_accesses:       Access frequency of this region.
> >   * @list:              List head for siblings.
> >   */
> >  struct damon_region {
> >         struct damon_addr_range ar;
> > +       unsigned long sampling_addr;
> >         unsigned int nr_accesses;
> >         struct list_head list;
> >  };
> > @@ -50,12 +54,130 @@ struct damon_target {
> >         struct list_head list;
> >  };
> >
> > +struct damon_ctx;
> > +
> >  /**
> > - * struct damon_ctx - Represents a context for each monitoring.
> > + * struct damon_primitive      Monitoring primitives for given use cases.
> > + *
> > + * @init_target_regions:       Constructs initial monitoring target regions.
> > + * @prepare_access_checks:     Prepares next access check of target regions.
> > + * @check_accesses:            Checks the access of target regions.
> > + * @target_valid:              Determine if the target is valid.
> > + * @cleanup:                   Cleans up the context.
> > + *
> > + * DAMON can be extended for various address spaces and usages.  For this,
> > + * users should register the low level primitives for their target address
> > + * space and usecase via the &damon_ctx.primitive.  Then, the monitoring thread
> > + * calls @init_target_regions before starting the monitoring and
> > + * @prepare_access_checks, @check_accesses, and @target_valid for each
> > + * @sample_interval.
> > + *
> > + * @init_target_regions should construct proper monitoring target regions and
> > + * link those to the DAMON context struct.
> > + * @prepare_access_checks should manipulate the monitoring regions to be
> > + * prepare for the next access check.
> > + * @check_accesses should check the accesses to each region that made after the
> > + * last preparation and update the `->nr_accesses` of each region.  It should
> > + * also return max &damon_region.nr_accesses that made as a result of its
> > + * update.
> > + * @target_valid should check whether the target is still valid for the
> > + * monitoring.
> > + * @cleanup is called from @kdamond just before its termination.  After this
> > + * call, only @kdamond_lock and @kdamond will be touched.
> > + */
> > +struct damon_primitive {
> > +       void (*init_target_regions)(struct damon_ctx *context);
> > +       void (*prepare_access_checks)(struct damon_ctx *context);
> > +       unsigned int (*check_accesses)(struct damon_ctx *context);
> > +       bool (*target_valid)(struct damon_target *target);
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
> > + * @before_terminate just before starting the monitoring and just before
> > + * finishing the monitoring.  Therefore, those are good places for installing
> > + * and cleaning @private.
> > + *
> > + * The monitoring thread calls @after_sampling and @after_aggregation for each
> > + * of the sampling intervals and aggregation intervals, respectively.
> > + * Therefore, users can safely access the monitoring results via
> > + * &damon_ctx.targets_list without additional protection of
> > + * damon_ctx.kdamond_lock.  For the reason, users are recommended to use these
> > + * callback for the accesses to the results.
> > + *
> > + * If any callback returns non-zero, monitoring stops.
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
> > + * @nr_regions:                        The number of monitoring regions.
> > + *
> > + * For each @sample_interval, DAMON checks whether each region is accessed or
> > + * not.  It aggregates and keeps the access information (number of accesses to
> > + * each region) for @aggr_interval time.  All time intervals are in
> > + * micro-seconds.
> > + *
> > + * @kdamond:           Kernel thread who does the monitoring.
> > + * @kdamond_stop:      Notifies whether kdamond should stop.
> > + * @kdamond_lock:      Mutex for the synchronizations with @kdamond.
> > + *
> > + * For each monitoring context, one kernel thread for the monitoring is
> > + * created.  The pointer to the thread is stored in @kdamond.
> > + *
> > + * Once started, the monitoring thread runs until explicitly required to be
> > + * terminated or every monitoring target is invalid.  The validity of the
> > + * targets is checked via the @target_valid callback.  The termination can also
> > + * be explicitly requested by writing non-zero to @kdamond_stop.  The thread
> > + * sets @kdamond to NULL when it terminates.  Therefore, users can know whether
> > + * the monitoring is ongoing or terminated by reading @kdamond.  Reads and
> > + * writes to @kdamond and @kdamond_stop from outside of the monitoring thread
> > + * must be protected by @kdamond_lock.
> > + *
> > + * Note that the monitoring thread protects only @kdamond and @kdamond_stop via
> > + * @kdamond_lock.  Accesses to other fields must be protected by themselves.
> > + *
> >   * @targets_list:      Head of monitoring targets (&damon_target) list.
> > + *
> > + * @primitive: Set of monitoring primitives for given use cases.
> > + * @callback:  Set of callbacks for monitoring events notifications.
> >   */
> >  struct damon_ctx {
> > +       unsigned long sample_interval;
> > +       unsigned long aggr_interval;
> > +       unsigned long nr_regions;
> 
> IMO region is the property of the target being monitored. There might
> be multiple types of target which might need the same abstraction like
> damon_region and damon_addr_range but that sharing can be done at that
> time.

I think this is same to the suggestion you gave as a reply to the PATCH 1.
Please refer to my answer there:
https://lore.kernel.org/linux-mm/20201126115157.6888-1-sjpark@amazon.com/

> 
> > +
> > +       struct timespec64 last_aggregation;
> > +
> > +       struct task_struct *kdamond;
> > +       bool kdamond_stop;
> > +       struct mutex kdamond_lock;
> > +
> >         struct list_head targets_list;  /* 'damon_target' objects */
> > +
> > +       struct damon_primitive primitive;
> > +       struct damon_callback callback;
> >  };
> >
> >  #define damon_next_region(r) \
> > @@ -90,6 +212,15 @@ void damon_free_target(struct damon_target *t);
> >  void damon_destroy_target(struct damon_target *t);
> >  unsigned int damon_nr_regions(struct damon_target *t);
> >
> > +int damon_set_targets(struct damon_ctx *ctx,
> > +               unsigned long *ids, ssize_t nr_ids);
> > +int damon_set_attrs(struct damon_ctx *ctx, unsigned long sample_int,
> > +               unsigned long aggr_int, unsigned long nr_reg);
> > +
> > +int damon_nr_running_ctxs(void);
> > +int damon_start(struct damon_ctx **ctxs, int nr_ctxs);
> > +int damon_stop(struct damon_ctx **ctxs, int nr_ctxs);
> > +
> >  #endif /* CONFIG_DAMON */
> >
> >  #endif
> > diff --git a/mm/damon/core.c b/mm/damon/core.c
> > index 4562b2458719..eb4ebeaa064d 100644
> > --- a/mm/damon/core.c
> > +++ b/mm/damon/core.c
> > @@ -8,12 +8,20 @@
> >  #define pr_fmt(fmt) "damon: " fmt
> >
> >  #include <linux/damon.h>
> > +#include <linux/delay.h>
> > +#include <linux/kthread.h>
> >  #include <linux/slab.h>
> >
> > +/* Minimal region size.  Every damon_region is aligned by this. */
> > +#define MIN_REGION PAGE_SIZE
> > +
> >  /*
> >   * Functions and macros for DAMON data structures
> >   */
> >
> > +static DEFINE_MUTEX(damon_lock);
> > +static int nr_running_ctxs;
> > +
> >  /*
> >   * Construct a damon_region struct
> >   *
> > @@ -119,3 +127,328 @@ unsigned int damon_nr_regions(struct damon_target *t)
> >
> >         return nr_regions;
> >  }
> > +
> > +/**
> > + * damon_set_targets() - Set monitoring targets.
> > + * @ctx:       monitoring context
> > + * @ids:       array of target ids
> > + * @nr_ids:    number of entries in @ids
> > + *
> > + * This function should not be called while the kdamond is running.
> > + *
> > + * Return: 0 on success, negative error code otherwise.
> > + */
> > +int damon_set_targets(struct damon_ctx *ctx,
> > +                     unsigned long *ids, ssize_t nr_ids)
> > +{
> > +       ssize_t i;
> > +       struct damon_target *t, *next;
> > +
> > +       damon_for_each_target_safe(t, next, ctx)
> > +               damon_destroy_target(t);
> > +
> > +       for (i = 0; i < nr_ids; i++) {
> > +               t = damon_new_target(ids[i]);
> > +               if (!t) {
> > +                       pr_err("Failed to alloc damon_target\n");
> > +                       return -ENOMEM;
> > +               }
> > +               damon_add_target(ctx, t);
> > +       }
> > +
> > +       return 0;
> > +}
> 
> This function looks weird and without usage. I suppose this is called
> when a user requests to set up monitoring targets. I would change this
> to add targets one by one. At the moment, it removes the older targets
> and adds newer ones which can fail and will leave the context in a
> weird state.

Agreed on the weird state after the failure, but I think allowing only one-time
setup makes things much simple.  Also, as this function returns error code, the
callers can clean up the state in that case if they want.  So, if you are ok,
I'd like to keep this as is.

> 
> BTW this function should come in the patch which introduces the user interface.

Agreed, this was only accidentally introduced earlier.

> 
> > +
> > +/**
> > + * damon_set_attrs() - Set attributes for the monitoring.
> > + * @ctx:               monitoring context
> > + * @sample_int:                time interval between samplings
> > + * @aggr_int:          time interval between aggregations
> > + * @nr_reg:            number of regions
> > + *
> > + * This function should not be called while the kdamond is running.
> > + * Every time interval is in micro-seconds.
> > + *
> > + * Return: 0 on success, negative error code otherwise.
> > + */
> > +int damon_set_attrs(struct damon_ctx *ctx, unsigned long sample_int,
> > +                   unsigned long aggr_int, unsigned long nr_reg)
> > +{
> > +       if (nr_reg < 3) {
> > +               pr_err("nr_regions (%lu) must be at least 3\n",
> > +                               nr_reg);
> > +               return -EINVAL;
> > +       }
> > +
> > +       ctx->sample_interval = sample_int;
> > +       ctx->aggr_interval = aggr_int;
> > +       ctx->nr_regions = nr_reg;
> > +
> > +       return 0;
> > +}
> > +
> > +static bool damon_kdamond_running(struct damon_ctx *ctx)
> > +{
> > +       bool running;
> > +
> > +       mutex_lock(&ctx->kdamond_lock);
> > +       running = ctx->kdamond != NULL;
> > +       mutex_unlock(&ctx->kdamond_lock);
> > +
> > +       return running;
> > +}
> > +
> > +static int kdamond_fn(void *data);
> > +
> > +/*
> > + * __damon_start() - Starts monitoring with given context.
> > + * @ctx:       monitoring context
> > + *
> > + * This function should be called while damon_lock is hold.
> > + *
> > + * Return: 0 on success, negative error code otherwise.
> > + */
> > +static int __damon_start(struct damon_ctx *ctx)
> > +{
> > +       int err = -EBUSY;
> > +
> > +       mutex_lock(&ctx->kdamond_lock);
> > +       if (!ctx->kdamond) {
> > +               err = 0;
> > +               ctx->kdamond_stop = false;
> > +               ctx->kdamond = kthread_create(kdamond_fn, ctx, "kdamond.%d",
> > +                               nr_running_ctxs);
> > +               if (IS_ERR(ctx->kdamond))
> > +                       err = PTR_ERR(ctx->kdamond);
> > +               else
> > +                       wake_up_process(ctx->kdamond);
> > +       }
> > +       mutex_unlock(&ctx->kdamond_lock);
> > +
> > +       return err;
> > +}
> > +
> > +/**
> > + * damon_start() - Starts the monitorings for a given group of contexts.
> > + * @ctxs:      an array of the pointers for contexts to start monitoring
> > + * @nr_ctxs:   size of @ctxs
> > + *
> > + * This function starts a group of monitoring threads for a group of monitoring
> > + * contexts.  One thread per each context is created and run in parallel.  The
> > + * caller should handle synchronization between the threads by itself.  If a
> > + * group of threads that created by other 'damon_start()' call is currently
> > + * running, this function does nothing but returns -EBUSY.
> > + *
> > + * Return: 0 on success, negative error code otherwise.
> > + */
> > +int damon_start(struct damon_ctx **ctxs, int nr_ctxs)
> > +{
> > +       int i;
> > +       int err = 0;
> > +
> > +       mutex_lock(&damon_lock);
> > +       if (nr_running_ctxs) {
> 
> What is this checking?

Checks if previous caller requested monitoring works are still running.  If so,
because different callers might set the target regions to overlap and result in
interfering each other's monitoring results, we reject the currently requested
monitoring.

> 
> > +               mutex_unlock(&damon_lock);
> > +               return -EBUSY;
> > +       }
> > +
> > +       for (i = 0; i < nr_ctxs; i++) {
> > +               err = __damon_start(ctxs[i]);
> > +               if (err)
> > +                       break;
> > +               nr_running_ctxs++;
> > +       }
> > +       mutex_unlock(&damon_lock);
> > +
> > +       return err;
> > +}
> > +
> > +/*
> > + * __damon_stop() - Stops monitoring of given context.
> > + * @ctx:       monitoring context
> > + *
> > + * Return: 0 on success, negative error code otherwise.
> > + */
> > +static int __damon_stop(struct damon_ctx *ctx)
> > +{
> > +       mutex_lock(&ctx->kdamond_lock);
> > +       if (ctx->kdamond) {
> > +               ctx->kdamond_stop = true;
> > +               mutex_unlock(&ctx->kdamond_lock);
> > +               while (damon_kdamond_running(ctx))
> > +                       usleep_range(ctx->sample_interval,
> > +                                       ctx->sample_interval * 2);
> > +               return 0;
> > +       }
> > +       mutex_unlock(&ctx->kdamond_lock);
> > +
> > +       return -EPERM;
> > +}
> > +
> > +/**
> > + * damon_stop() - Stops the monitorings for a given group of contexts.
> > + * @ctxs:      an array of the pointers for contexts to stop monitoring
> > + * @nr_ctxs:   size of @ctxs
> > + *
> > + * Return: 0 on success, negative error code otherwise.
> > + */
> > +int damon_stop(struct damon_ctx **ctxs, int nr_ctxs)
> > +{
> > +       int i, err = 0;
> > +
> > +       for (i = 0; i < nr_ctxs; i++) {
> > +               /* nr_running_ctxs is decremented in kdamond_fn */
> > +               err = __damon_stop(ctxs[i]);
> > +               if (err)
> > +                       return err;
> > +       }
> > +
> > +       return err;
> > +}
> > +
> > +/*
> > + * Functions for DAMON core logics
> > + */
> > +
> > +/*
> > + * damon_check_reset_time_interval() - Check if a time interval is elapsed.
> > + * @baseline:  the time to check whether the interval has elapsed since
> > + * @interval:  the time interval (microseconds)
> > + *
> > + * See whether the given time interval has passed since the given baseline
> > + * time.  If so, it also updates the baseline to current time for next check.
> > + *
> > + * Return:     true if the time interval has passed, or false otherwise.
> > + */
> > +static bool damon_check_reset_time_interval(struct timespec64 *baseline,
> > +               unsigned long interval)
> > +{
> > +       struct timespec64 now;
> > +
> > +       ktime_get_coarse_ts64(&now);
> > +       if ((timespec64_to_ns(&now) - timespec64_to_ns(baseline)) <
> > +                       interval * 1000)
> > +               return false;
> > +       *baseline = now;
> > +       return true;
> > +}
> > +
> > +/*
> > + * Check whether it is time to flush the aggregated information
> > + */
> > +static bool kdamond_aggregate_interval_passed(struct damon_ctx *ctx)
> > +{
> > +       return damon_check_reset_time_interval(&ctx->last_aggregation,
> > +                       ctx->aggr_interval);
> > +}
> > +
> > +/*
> > + * Reset the aggregated monitoring results ('nr_accesses' of each region).
> > + */
> > +static void kdamond_reset_aggregated(struct damon_ctx *c)
> > +{
> > +       struct damon_target *t;
> > +
> > +       damon_for_each_target(t, c) {
> > +               struct damon_region *r;
> > +
> > +               damon_for_each_region(r, t)
> > +                       r->nr_accesses = 0;
> > +       }
> > +}
> > +
> > +/*
> > + * Check whether current monitoring should be stopped
> > + *
> > + * The monitoring is stopped when either the user requested to stop, or all
> > + * monitoring targets are invalid.
> > + *
> > + * Returns true if need to stop current monitoring.
> > + */
> > +static bool kdamond_need_stop(struct damon_ctx *ctx)
> > +{
> > +       struct damon_target *t;
> > +       bool stop;
> > +
> > +       mutex_lock(&ctx->kdamond_lock);
> > +       stop = ctx->kdamond_stop;
> > +       mutex_unlock(&ctx->kdamond_lock);
> > +       if (stop)
> > +               return true;
> > +
> > +       if (!ctx->primitive.target_valid)
> > +               return false;
> > +
> > +       damon_for_each_target(t, ctx) {
> > +               if (ctx->primitive.target_valid(t))
> > +                       return false;
> > +       }
> 
> Why check for valid target? Are we gonna create a new kthread when the
> user set the new target?

No, we don't create a new kthread.  This is for self termination of the
monitoring.  Let's suppose the targets are processes.  We define the target as
invalid if the process is terminated.  If all target processes are terminated,
the monitoring thread don't need to continue, so stop.

> 
> > +
> > +       return true;
> > +}
> > +
> > +static void set_kdamond_stop(struct damon_ctx *ctx, bool stop)
> > +{
> > +       mutex_lock(&ctx->kdamond_lock);
> > +       ctx->kdamond_stop = stop;
> > +       mutex_unlock(&ctx->kdamond_lock);
> > +}
> > +
> > +#define kdamond_call_prmt(ctx, fn)                     \
> > +       do {                                            \
> > +               if (ctx->primitive.fn)                  \
> > +                       ctx->primitive.fn(ctx);         \
> > +       } while (0)
> > +
> > +#define kdamond_callback(ctx, fn)                              \
> > +       do {                                                    \
> > +               if (ctx->callback.fn && ctx->callback.fn(ctx))  \
> > +                       set_kdamond_stop(ctx, true);            \
> > +       } while (0)
> 
> I don't think these macros are helpful rather they make code harder to
> grasp. Also don't hide the function call like set_kdamond_stop() in a
> macro.

Ok, I will wrote down the code explicitly.

> 
> > +
> > +/*
> > + * The monitoring daemon that runs as a kernel thread
> > + */
> > +static int kdamond_fn(void *data)
> > +{
> > +       struct damon_ctx *ctx = (struct damon_ctx *)data;
> > +       struct damon_target *t;
> > +       struct damon_region *r, *next;
> > +
> > +       pr_info("kdamond (%d) starts\n", ctx->kdamond->pid);
> > +
> 
> Call the callbacks explicitly.

Agreed.


Thanks,
SeongJae Park
[...]
