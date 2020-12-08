Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0EBC2D24C5
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 08:44:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727728AbgLHHnW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 02:43:22 -0500
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:59625 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727483AbgLHHnW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 02:43:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1607413401; x=1638949401;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   mime-version;
  bh=5nAvOheFRPFgUtfiqscEViDDQqJQXvSdA1jrKPlN6VQ=;
  b=mjj98C2/qWoijXbUL7qyAtiipAB96ZUOlbGkx6no5yVZdU6LTQiTZ/nK
   MhLkQRJ4ozQJna0LI7OUwQhZkgvhGtC68wn9843M1H4h8XcghojgGcz++
   Qgm4LdBsVTB39e2nIH83pXkeQBi7Dgu+JKmMKQjXZ226A/NpV7xDDakYm
   M=;
X-IronPort-AV: E=Sophos;i="5.78,401,1599523200"; 
   d="scan'208";a="102504134"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2c-87a10be6.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 08 Dec 2020 07:42:34 +0000
Received: from EX13D31EUA001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-2c-87a10be6.us-west-2.amazon.com (Postfix) with ESMTPS id A2109A1D31;
        Tue,  8 Dec 2020 07:42:31 +0000 (UTC)
Received: from u3f2cd687b01c55.ant.amazon.com (10.43.161.43) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 8 Dec 2020 07:42:13 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     SeongJae Park <sjpark@amazon.com>
CC:     Shakeel Butt <shakeelb@google.com>,
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
Date:   Tue, 8 Dec 2020 08:41:59 +0100
Message-ID: <20201208074159.25172-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201126115157.6888-1-sjpark@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.161.43]
X-ClientProxiedBy: EX13D13UWB002.ant.amazon.com (10.43.161.21) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Nov 2020 12:51:57 +0100 SeongJae Park <sjpark@amazon.com> wrote:

> Hi Shakeel,
> 
> 
> Thanks for the review! :D
> 
> On Wed, 25 Nov 2020 07:29:10 -0800 Shakeel Butt <shakeelb@google.com> wrote:
> 
> > On Tue, Oct 20, 2020 at 2:01 AM SeongJae Park <sjpark@amazon.com> wrote:
> > >
> > > From: SeongJae Park <sjpark@amazon.de>
> > >
> > > DAMON is a data access monitoring framework for the Linux kernel.  The
> > > core mechanisms of DAMON make it
> > >
> > >  - accurate (the monitoring output is useful enough for DRAM level
> > >    performance-centric memory management; It might be inappropriate for
> > >    CPU Cache levels, though),
> > >  - light-weight (the monitoring overhead is normally low enough to be
> > >    applied online), and
> > >  - scalable (the upper-bound of the overhead is in constant range
> > >    regardless of the size of target workloads).
> > >
> > > Using this framework, hence, we can easily write efficient kernel space
> > > data access monitoring applications.  For example, the kernel's memory
> > > management mechanisms can make advanced decisions using this.
> > > Experimental data access aware optimization works that incurring high
> > > access monitoring overhead could implemented again on top of this.
> > >
> > > Due to its simple and flexible interface, providing user space interface
> > > would be also easy.  Then, user space users who have some special
> > > workloads can write personalized applications for better understanding
> > > and optimizations of their workloads and systems.
> > >
> > > That said, this commit is implementing only basic data structures and
> > > simple manipulation functions of the structures.  The core mechanisms of
> > > DAMON will be implemented by following commits.
> > >
> > > Signed-off-by: SeongJae Park <sjpark@amazon.de>
> > > Reviewed-by: Leonard Foerster <foersleo@amazon.de>
> > > Reviewed-by: Varad Gautam <vrd@amazon.de>
> > 
[...]
> > I would suggest to separate
> > the core (damon context) from the target related structs (target,
> > region, addr range).
> 
> To be honest, I unsure if I'm fully understanding what specific change you want
> to make.  So if I'm misunderstanding your point below, please let me know.
> 
> Seems like you are concerning for future support of special kind use cases that
> don't need targets/regions/addresses, such as page granularity monitoring that
> having interest in only if the pages accessed or not, rather than access
> frequency.  In the context, your suggestion makes sense as the region
> abstraction is only burden in the case, as I also mentioned in the cover
> letter.  This could be done via idle pages tracking, but DAMON will be able to
> do this faster by reducing the number of user-kernel context switches.
> 
> I once considered adding some change in the core part for efficient support of
> such use cases, but resulted in believing that the best way for that is
> implementing another primitive for the case and use it in a controlled way.
> 
> In a high level, it should disable the 'adaptive regions adjustment' feature
> and define it's own targets structs other than the damon_target.  Then, your
> implementation of the primitive callbacks should use your own targets.
> 
> In more detail, the 'adaptive regions adjustment' can be disabled by setting
> the min_nr_regions and max_nr_regions of the damon_ctx with same value, say, 0.
> Your own targets structs could be stored in 'damon_callback->private'.  Or, we
> could add another 'private' field in damon_ctx for that.
> 
> I think this will work, but I also admit that this could look like a hairy
> hack to someone.  Fundamentally, this is because the region based
> overhead/accuracy handling is strongly coupled in the design.  So, I think what
> you are really suggesting is making DAMON more general by default and
> supporting the region based overhead/accuracy handling additionally.
> 
> If I'm understanding correctly, how about below like change?  Obviously this
> should be cleaned up a lot, but I just want to quickly share my idea and
> discuss.  Also note that it's based on the damon/next tree[1].
> 
> [1] https://github.com/sjp38/linux/tree/damon/next
> 
> +enum damon_type {
> +       ARBITRARY_TARGETS,
> +       ADAPTIVE_REGIONS,
> +};
> +
> +struct damon_adaptive_regions_ctx {
> +       unsigned long min_nr_regions;
> +       unsigned long max_nr_regions;
> +       struct list_head targets;
> +       struct list_head schemes;
> +};
> +
>  /**
>   * struct damon_ctx - Represents a context for each monitoring.  This is the
>   * main interface that allows users to set the attributes and get the results
> @@ -243,8 +255,6 @@ struct damon_ctx {
>         unsigned long sample_interval;
>         unsigned long aggr_interval;
>         unsigned long regions_update_interval;
> -       unsigned long min_nr_regions;
> -       unsigned long max_nr_regions;
> 
>         struct timespec64 last_aggregation;
>         struct timespec64 last_regions_update;
> @@ -253,11 +263,14 @@ struct damon_ctx {
>         bool kdamond_stop;
>         struct mutex kdamond_lock;
> 
> -       struct list_head targets_list;  /* 'damon_target' objects */
> -       struct list_head schemes_list;  /* 'damos' objects */
> -
>         struct damon_primitive primitive;
>         struct damon_callback callback;
> +
> +       enum damon_type type;
> +       union {
> +               struct damon_adaptive_regions_ctx arctx;
> +               void *targets;
> +       };
>  };
> 
> The patchset will first introduce DAMON as only ARBITRARY_TARGETS (or, would
> TINY be a better name?) type supporting form.  After that, following patch will
> add ADAPTIVE_REGIONS type support.  Do you think I'm correctly understanding
> your point and above suggestion makes sense?

In a private message, Shakeel confirmed I'm correnctly understanding his
intention and asked next version.  I will post next version soon.


Thanks,
SeongJae Park
