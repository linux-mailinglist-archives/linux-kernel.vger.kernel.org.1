Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1174A19C379
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Apr 2020 16:01:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387652AbgDBOBD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Apr 2020 10:01:03 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:25876 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726425AbgDBOBC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 10:01:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1585836060; x=1617372060;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   mime-version;
  bh=JJOleugy6YYI1QEgrmRVgpAnJjeGFcBiu5/H6ZBTL40=;
  b=TEMVoatZELN+X8Wnjnqv9zyJ53rn1qecSb+ima6dTgIW7X7D1Ovolbk/
   fYEqs9UaEQGhnF67taNEDXXIicj4u5+GAemP754F8PzXK1tss96iBT/+3
   xs3OfcGQkgm68/aSMBlS3GZAF/ZPdlyJW/fVV21bKrV2GG9N9OcHpMKrN
   Y=;
IronPort-SDR: rSyems/IbJNfwUI6TlUTlK35mTBitFWPqs6/IseEePG4Lo1Fnvt9ut5B1lTG34ql+M3DhgM3D0
 pFtHukuh7yXg==
X-IronPort-AV: E=Sophos;i="5.72,335,1580774400"; 
   d="scan'208";a="34887686"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1e-303d0b0e.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 02 Apr 2020 14:00:55 +0000
Received: from EX13MTAUEA002.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1e-303d0b0e.us-east-1.amazon.com (Postfix) with ESMTPS id 892CAA29E0;
        Thu,  2 Apr 2020 14:00:45 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 2 Apr 2020 14:00:44 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.162.241) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 2 Apr 2020 14:00:30 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     SeongJae Park <sjpark@amazon.com>
CC:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        <akpm@linux-foundation.org>, SeongJae Park <sjpark@amazon.de>,
        <aarcange@redhat.com>, <acme@kernel.org>,
        <alexander.shishkin@linux.intel.com>, <amit@kernel.org>,
        <brendan.d.gregg@gmail.com>, <brendanhiggins@google.com>,
        <cai@lca.pw>, <colin.king@canonical.com>, <corbet@lwn.net>,
        <dwmw@amazon.com>, <jolsa@redhat.com>, <kirill@shutemov.name>,
        <mark.rutland@arm.com>, <mgorman@suse.de>, <minchan@kernel.org>,
        <mingo@redhat.com>, <namhyung@kernel.org>, <peterz@infradead.org>,
        <rdunlap@infradead.org>, <riel@surriel.com>, <rientjes@google.com>,
        <rostedt@goodmis.org>, <shuah@kernel.org>, <sj38.park@gmail.com>,
        <vbabka@suse.cz>, <vdavydov.dev@gmail.com>,
        <yang.shi@linux.alibaba.com>, <ying.huang@intel.com>,
        <linux-mm@kvack.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Re: Re: [PATCH v7 04/15] mm/damon: Implement region based sampling
Date:   Thu, 2 Apr 2020 15:59:59 +0200
Message-ID: <20200402135959.26336-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200401082222.21242-1-sjpark@amazon.com> (raw)
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.162.241]
X-ClientProxiedBy: EX13D27UWB003.ant.amazon.com (10.43.161.195) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Apr 2020 10:22:22 +0200 SeongJae Park <sjpark@amazon.com> wrote:

> On Tue, 31 Mar 2020 17:02:33 +0100 Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:
> 
> > On Wed, 18 Mar 2020 12:27:11 +0100
> > SeongJae Park <sjpark@amazon.com> wrote:
> > 
> > > From: SeongJae Park <sjpark@amazon.de>
> > > 
> > > This commit implements DAMON's basic access check and region based
> > > sampling mechanisms.  This change would seems make no sense, mainly
> > > because it is only a part of the DAMON's logics.  Following two commits
> > > will make more sense.
> > > 
> > > Basic Access Check
> > > ------------------
> > > 
> > > DAMON basically reports what pages are how frequently accessed.  Note
> > > that the frequency is not an absolute number of accesses, but a relative
> > > frequency among the pages of the target workloads.
> > > 
> > > Users can control the resolution of the reports by setting two time
> > > intervals, ``sampling interval`` and ``aggregation interval``.  In
> > > detail, DAMON checks access to each page per ``sampling interval``,
> > > aggregates the results (counts the number of the accesses to each page),
> > > and reports the aggregated results per ``aggregation interval``.  For
> > > the access check of each page, DAMON uses the Accessed bits of PTEs.
> > > 
> > > This is thus similar to common periodic access checks based access
> > > tracking mechanisms, which overhead is increasing as the size of the
> > > target process grows.
> > > 
> > > Region Based Sampling
> > > ---------------------
> > > 
> > > To avoid the unbounded increase of the overhead, DAMON groups a number
> > > of adjacent pages that assumed to have same access frequencies into a
> > > region.  As long as the assumption (pages in a region have same access
> > > frequencies) is kept, only one page in the region is required to be
> > > checked.  Thus, for each ``sampling interval``, DAMON randomly picks one
> > > page in each region and clears its Accessed bit.  After one more
> > > ``sampling interval``, DAMON reads the Accessed bit of the page and
> > > increases the access frequency of the region if the bit has set
> > > meanwhile.  Therefore, the monitoring overhead is controllable by
> > > setting the number of regions.
> > > 
> > > Nonetheless, this scheme cannot preserve the quality of the output if
> > > the assumption is not kept.  Following commit will introduce how we can
> > > make the guarantee with best effort.
> > > 
> > > Signed-off-by: SeongJae Park <sjpark@amazon.de>
> > 
> > Hi.
> > 
> > A few comments inline.
> > 
> > I've still not replicated your benchmarks so may well have some more
> > feedback once I've managed that on one of our servers.
> 
> Appreciate your comments.  If you need any help for the replication, please let
> me know.  I basically use my parsec3 wrapper scripts[1] to run parsec3 and
> splash2x workloads and `damo` tool, which resides in the kernel tree at
> `/tools/damon/`.
> 
> For example, below commands will reproduce ethp applied splash2x/fft run.
>     
>     $ echo "2M      null    5       null    null    null    hugepage
>     2M      null    null    5       1s      null    nohugepage" > ethp
>     $ parsec3_on_ubuntu/run.sh splash2x.fft
>     $ linux/tools/damon/damo schemes -c ethp `pidof fft`
> 
> [1] https://github.com/sjp38/parsec3_on_ubuntu
> 
> > 
> > Thanks,
> > 
> > Jonathan
> > 
> > > ---
> > >  include/linux/damon.h |  24 ++
> > >  mm/damon.c            | 553 ++++++++++++++++++++++++++++++++++++++++++
> > >  2 files changed, 577 insertions(+)
> > > 
> [...]
> > > diff --git a/mm/damon.c b/mm/damon.c
> > > index d7e6226ab7f1..018016793555 100644
> > > --- a/mm/damon.c
> > > +++ b/mm/damon.c
> > > @@ -10,8 +10,14 @@
> > >  #define pr_fmt(fmt) "damon: " fmt
> > >  
> > >  #include <linux/damon.h>
> > > +#include <linux/delay.h>
> > > +#include <linux/kthread.h>
> > >  #include <linux/mm.h>
> > >  #include <linux/module.h>
> > > +#include <linux/page_idle.h>
> > > +#include <linux/random.h>
> > > +#include <linux/sched/mm.h>
> > > +#include <linux/sched/task.h>
> > >  #include <linux/slab.h>
> > >  
> [...]
> > > +/*
> > > + * Size-evenly split a region into 'nr_pieces' small regions
> > > + *
> > > + * Returns 0 on success, or negative error code otherwise.
> > > + */
> > > +static int damon_split_region_evenly(struct damon_ctx *ctx,
> > > +		struct damon_region *r, unsigned int nr_pieces)
> > > +{
> > > +	unsigned long sz_orig, sz_piece, orig_end;
> > > +	struct damon_region *piece = NULL, *next;
> > > +	unsigned long start;
> > > +
> > > +	if (!r || !nr_pieces)
> > > +		return -EINVAL;
> > > +
> > > +	orig_end = r->vm_end;
> > > +	sz_orig = r->vm_end - r->vm_start;
> > > +	sz_piece = sz_orig / nr_pieces;
> > > +
> > > +	if (!sz_piece)
> > > +		return -EINVAL;
> > > +
> > > +	r->vm_end = r->vm_start + sz_piece;
> > > +	next = damon_next_region(r);
> > > +	for (start = r->vm_end; start + sz_piece <= orig_end;
> > > +			start += sz_piece) {
> > > +		piece = damon_new_region(ctx, start, start + sz_piece);
> > piece may be n
> 
> Yes, that name is short and more intuitive.  I will rename so.
> 
> > > +		damon_insert_region(piece, r, next);
> > > +		r = piece;
> > > +	}
> > > +	/* complement last region for possible rounding error */
> > > +	if (piece)
> > > +		piece->vm_end = orig_end;
> > 
> > Update the sampling address to ensure it's in the region?
> 
> I think `piece->vm_end` should be equal or smaller than `orig_end` and
> therefore the sampling address of `piece` will be still in the region.
> 
> > 
> > > +
> > > +	return 0;
> > > +}
> > > +
> [...]
> > > +static void damon_pte_pmd_mkold(pte_t *pte, pmd_t *pmd)
> > > +{
> > > +	if (pte) {
> > > +		if (pte_young(*pte)) {
> > > +			clear_page_idle(pte_page(*pte));
> > > +			set_page_young(pte_page(*pte));
> > > +		}
> > > +		*pte = pte_mkold(*pte);
> > > +		return;
> > > +	}
> > > +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> > > +	if (pmd) {
> > > +		if (pmd_young(*pmd)) {
> > > +			clear_page_idle(pmd_page(*pmd));
> > > +			set_page_young(pmd_page(*pmd));
> > > +		}
> > > +		*pmd = pmd_mkold(*pmd);
> > > +	}
> > > +#endif /* CONFIG_TRANSPARENT_HUGEPAGE */
> > 
> > No need to flush the TLBs?
> 
> Good point!
> 
> I have intentionally skipped TLB flushing here to minimize the performance
> effect to the target workload.  I also thought this might not degrade the
> monitoring accuracy so much because we are targetting for the DRAM level
> accesses of memory-intensive workloads, which might make TLB flood frequently.
> 
> However, your comment makes me thinking differently now.  By flushing the TLB
> here, we will increase up to `number_of_regions` TLB misses for sampling
> interval.  This might be not a huge overhead.  Also, improving the monitoring
> accuracy makes no harm at all.  I even didn't measured the overhead.
> 
> I will test the overhead and if it is not significant, I will make this code to
> flush TLB, in the next spin.

Hmm, it seems like 'page_idle.c' is also modifying the Accessed bit but doesn't
flush related TLB entries.  If I'm not missing something here, I would like to
leave this part as is to make the behavior consistent.


Thanks,
SeongJae Park

> 
> > 
> > > +}
> > > +
> [...]
> > > +/*
> > > + * The monitoring daemon that runs as a kernel thread
> > > + */
> > > +static int kdamond_fn(void *data)
> > > +{
> > > +	struct damon_ctx *ctx = data;
> > > +	struct damon_task *t;
> > > +	struct damon_region *r, *next;
> > > +	struct mm_struct *mm;
> > > +
> > > +	pr_info("kdamond (%d) starts\n", ctx->kdamond->pid);
> > > +	kdamond_init_regions(ctx);
> > 
> > We haven't called mkold on the initial regions so first check will
> > get us fairly random state.
> 
> Yes, indeed.  However, the early results will not be accurate anyway because
> the adaptive regions adjustment algorithm will not take effect yet.  I would
> like to leave this part as is but add some comments about this point to keep
> the code simple.
> 
> > 
> > > +	while (!kdamond_need_stop(ctx)) {
> > > +		damon_for_each_task(ctx, t) {
> > > +			mm = damon_get_mm(t);
> > > +			if (!mm)
> > > +				continue;
> > > +			damon_for_each_region(r, t)
> > > +				kdamond_check_access(ctx, mm, r);
> > > +			mmput(mm);
> > > +		}
> > > +
> > > +		if (kdamond_aggregate_interval_passed(ctx))
> > > +			kdamond_reset_aggregated(ctx);
> > > +
> > > +		usleep_range(ctx->sample_interval, ctx->sample_interval + 1);
> > > +	}
> > > +	damon_for_each_task(ctx, t) {
> > > +		damon_for_each_region_safe(r, next, t)
> > > +			damon_destroy_region(r);
> > > +	}
> > > +	pr_debug("kdamond (%d) finishes\n", ctx->kdamond->pid);
> > > +	mutex_lock(&ctx->kdamond_lock);
> > > +	ctx->kdamond = NULL;
> > > +	mutex_unlock(&ctx->kdamond_lock);
> > > +
> > > +	return 0;
> > > +}
> > > +
> [...]
> > > +/*
> > > + * Start or stop the kdamond
> > > + *
> > > + * Returns 0 if success, negative error code otherwise.
> > > + */
> > > +static int damon_turn_kdamond(struct damon_ctx *ctx, bool on)
> > > +{
> > > +	int err = -EBUSY;
> > > +
> > > +	mutex_lock(&ctx->kdamond_lock);
> > > +	if (!ctx->kdamond && on) {
> > 
> > Given there is very little shared code between on and off, I would
> > suggest just splitting it into two functions.
> 
> Good point, I will do so in next spin.
> 
> > 
> > > +		err = 0;
> > > +		ctx->kdamond = kthread_run(kdamond_fn, ctx, "kdamond");
> > > +		if (IS_ERR(ctx->kdamond))
> > > +			err = PTR_ERR(ctx->kdamond);
> > > +	} else if (ctx->kdamond && !on) {
> > > +		mutex_unlock(&ctx->kdamond_lock);
> > > +		kthread_stop(ctx->kdamond);
> > > +		while (damon_kdamond_running(ctx))
> > > +			usleep_range(ctx->sample_interval,
> > > +					ctx->sample_interval * 2);
> > > +		return 0;
> > > +	}
> > > +	mutex_unlock(&ctx->kdamond_lock);
> > > +
> > > +	return err;
> > > +}
> > > +
> [...]
> > > +
> > > +/*
> > 
> > Why not make these actual kernel-doc?  That way you can use the
> > kernel-doc scripts to sanity check them.
> 
> Oops, I just forgot that it should start with '/**'.  Will fix it in next spin.
> 
> 
> Thanks,
> SeongJae Park
> 
> > 
> > /**
> > 
> > > + * damon_set_attrs() - Set attributes for the monitoring.
> > > + * @ctx:		monitoring context
> > > + * @sample_int:		time interval between samplings
> > > + * @aggr_int:		time interval between aggregations
> > > + * @min_nr_reg:		minimal number of regions
> > > + *
> > > + * This function should not be called while the kdamond is running.
> > > + * Every time interval is in micro-seconds.
> > > + *
> > > + * Return: 0 on success, negative error code otherwise.
> > > + */
> > > +int damon_set_attrs(struct damon_ctx *ctx, unsigned long sample_int,
> > > +		unsigned long aggr_int, unsigned long min_nr_reg)
> > > +{
> > > +	if (min_nr_reg < 3) {
> > > +		pr_err("min_nr_regions (%lu) should be bigger than 2\n",
> > > +				min_nr_reg);
> > > +		return -EINVAL;
> > > +	}
> > > +
> > > +	ctx->sample_interval = sample_int;
> > > +	ctx->aggr_interval = aggr_int;
> > > +	ctx->min_nr_regions = min_nr_reg;
> > > +
> > > +	return 0;
> > > +}
> > > +
> > >  static int __init damon_init(void)
> > >  {
> > >  	return 0;
> > 
