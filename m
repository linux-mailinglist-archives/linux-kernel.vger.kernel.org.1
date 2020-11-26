Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3739D2C5349
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 12:53:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387535AbgKZLwx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 06:52:53 -0500
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:20398 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387504AbgKZLww (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 06:52:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1606391571; x=1637927571;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   mime-version;
  bh=LVzyqzcGOHq/lPo7TqlyXt1Tku8FZUsCf1O0EHMX9B8=;
  b=oj7m4NlJ2DSRCJJwLlk0nwaxJo8FNeuTQuuoJVzWSnbGifonNfJ+C/lB
   ZW+X89vhSYpJLU7A/Kn6bxrbc4gRCcm41HF3qNYKf9nNufhKRmF7kHJvg
   DVKnbh/vCJPPDmVyqqu7aT1gaCmJsaJLFV6VLG5+Jxz+oiv1TTDj1zFVk
   o=;
X-IronPort-AV: E=Sophos;i="5.78,372,1599523200"; 
   d="scan'208";a="99435090"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1a-e34f1ddc.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 26 Nov 2020 11:52:42 +0000
Received: from EX13D31EUA001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
        by email-inbound-relay-1a-e34f1ddc.us-east-1.amazon.com (Postfix) with ESMTPS id 0CE9EA1AB8;
        Thu, 26 Nov 2020 11:52:29 +0000 (UTC)
Received: from u3f2cd687b01c55.ant.amazon.com (10.43.160.67) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 26 Nov 2020 11:52:12 +0000
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
Subject: Re: [PATCH v22 01/18] mm: Introduce Data Access MONitor (DAMON)
Date:   Thu, 26 Nov 2020 12:51:57 +0100
Message-ID: <20201126115157.6888-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <CALvZod5rALTNRzK2w-y7AJMxFfBV9upJECPvCjhF=iFcDFt-5g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.160.67]
X-ClientProxiedBy: EX13D23UWC002.ant.amazon.com (10.43.162.22) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shakeel,


Thanks for the review! :D

On Wed, 25 Nov 2020 07:29:10 -0800 Shakeel Butt <shakeelb@google.com> wrote:

> On Tue, Oct 20, 2020 at 2:01 AM SeongJae Park <sjpark@amazon.com> wrote:
> >
> > From: SeongJae Park <sjpark@amazon.de>
> >
> > DAMON is a data access monitoring framework for the Linux kernel.  The
> > core mechanisms of DAMON make it
> >
> >  - accurate (the monitoring output is useful enough for DRAM level
> >    performance-centric memory management; It might be inappropriate for
> >    CPU Cache levels, though),
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
> >
> > Due to its simple and flexible interface, providing user space interface
> > would be also easy.  Then, user space users who have some special
> > workloads can write personalized applications for better understanding
> > and optimizations of their workloads and systems.
> >
> > That said, this commit is implementing only basic data structures and
> > simple manipulation functions of the structures.  The core mechanisms of
> > DAMON will be implemented by following commits.
> >
> > Signed-off-by: SeongJae Park <sjpark@amazon.de>
> > Reviewed-by: Leonard Foerster <foersleo@amazon.de>
> > Reviewed-by: Varad Gautam <vrd@amazon.de>
> 
> I don't see any benefit of this patch on its own. Some of this should
> be part of the main damon context patch.

Agreed.  Will change so in the next version.

> I would suggest to separate
> the core (damon context) from the target related structs (target,
> region, addr range).

To be honest, I unsure if I'm fully understanding what specific change you want
to make.  So if I'm misunderstanding your point below, please let me know.

Seems like you are concerning for future support of special kind use cases that
don't need targets/regions/addresses, such as page granularity monitoring that
having interest in only if the pages accessed or not, rather than access
frequency.  In the context, your suggestion makes sense as the region
abstraction is only burden in the case, as I also mentioned in the cover
letter.  This could be done via idle pages tracking, but DAMON will be able to
do this faster by reducing the number of user-kernel context switches.

I once considered adding some change in the core part for efficient support of
such use cases, but resulted in believing that the best way for that is
implementing another primitive for the case and use it in a controlled way.

In a high level, it should disable the 'adaptive regions adjustment' feature
and define it's own targets structs other than the damon_target.  Then, your
implementation of the primitive callbacks should use your own targets.

In more detail, the 'adaptive regions adjustment' can be disabled by setting
the min_nr_regions and max_nr_regions of the damon_ctx with same value, say, 0.
Your own targets structs could be stored in 'damon_callback->private'.  Or, we
could add another 'private' field in damon_ctx for that.

I think this will work, but I also admit that this could look like a hairy
hack to someone.  Fundamentally, this is because the region based
overhead/accuracy handling is strongly coupled in the design.  So, I think what
you are really suggesting is making DAMON more general by default and
supporting the region based overhead/accuracy handling additionally.

If I'm understanding correctly, how about below like change?  Obviously this
should be cleaned up a lot, but I just want to quickly share my idea and
discuss.  Also note that it's based on the damon/next tree[1].

[1] https://github.com/sjp38/linux/tree/damon/next

+enum damon_type {
+       ARBITRARY_TARGETS,
+       ADAPTIVE_REGIONS,
+};
+
+struct damon_adaptive_regions_ctx {
+       unsigned long min_nr_regions;
+       unsigned long max_nr_regions;
+       struct list_head targets;
+       struct list_head schemes;
+};
+
 /**
  * struct damon_ctx - Represents a context for each monitoring.  This is the
  * main interface that allows users to set the attributes and get the results
@@ -243,8 +255,6 @@ struct damon_ctx {
        unsigned long sample_interval;
        unsigned long aggr_interval;
        unsigned long regions_update_interval;
-       unsigned long min_nr_regions;
-       unsigned long max_nr_regions;

        struct timespec64 last_aggregation;
        struct timespec64 last_regions_update;
@@ -253,11 +263,14 @@ struct damon_ctx {
        bool kdamond_stop;
        struct mutex kdamond_lock;

-       struct list_head targets_list;  /* 'damon_target' objects */
-       struct list_head schemes_list;  /* 'damos' objects */
-
        struct damon_primitive primitive;
        struct damon_callback callback;
+
+       enum damon_type type;
+       union {
+               struct damon_adaptive_regions_ctx arctx;
+               void *targets;
+       };
 };

The patchset will first introduce DAMON as only ARBITRARY_TARGETS (or, would
TINY be a better name?) type supporting form.  After that, following patch will
add ADAPTIVE_REGIONS type support.  Do you think I'm correctly understanding
your point and above suggestion makes sense?

> 
> Also I would prefer the code be added with the actual usage otherwise
> it is hard to review.

Agreed.  Will do so in the next version.

> 
> > ---
> [snip]
> > +unsigned int damon_nr_regions(struct damon_target *t)
> > +{
> > +       struct damon_region *r;
> > +       unsigned int nr_regions = 0;
> > +
> > +       damon_for_each_region(r, t)
> > +               nr_regions++;
> > +
> > +       return nr_regions;
> > +}
> 
> Why not keep a count instead of traversing to get the size?

First of all, because this makes code simpler while this is not confirmed as
bottleneck, yet.  Because users can set the max_nr_regions, I think this will
not be real problem in the region based overhead/accuracy handling case.  In
case of the 'ARBITRARY_TARGETS', this will not used at all.  I also prefer this
because the user could add/remove regions on their own inside their callbacks.


Thanks,
SeongJae Park
