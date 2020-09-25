Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABC99278BA7
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 17:00:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729320AbgIYPAO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 11:00:14 -0400
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:12140 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728333AbgIYPAO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 11:00:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1601046014; x=1632582014;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   mime-version;
  bh=1mQoI7SbEAT3GqLVx99dh/bFDFrq0tO1gEtKJuIRcU0=;
  b=CKwbiJN6ErGcgESSDnQO1o3XAmInsa7PrDnaSqCxAK//kpBdKDbIB0vV
   dvbj97MevcXlOirnf5Jqo8Wm874BZu6GmkPSWqLDJAdxbmm0AKBQsxz/r
   xijCd96ZIvsxjYXXwO6Z/hACGyyQlVEG4oDAgmHriL2Yk7u9Ea2rXjcRR
   s=;
X-IronPort-AV: E=Sophos;i="5.77,302,1596499200"; 
   d="scan'208";a="71129605"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2b-c300ac87.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP; 25 Sep 2020 15:00:04 +0000
Received: from EX13D31EUA001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2b-c300ac87.us-west-2.amazon.com (Postfix) with ESMTPS id 04B19A0621;
        Fri, 25 Sep 2020 14:59:52 +0000 (UTC)
Received: from u3f2cd687b01c55.ant.amazon.com (10.43.162.221) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Fri, 25 Sep 2020 14:59:35 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     SeongJae Park <sjpark@amazon.com>
CC:     <aarcange@redhat.com>, <acme@kernel.org>,
        <alexander.shishkin@linux.intel.com>, <amit@kernel.org>,
        <benh@kernel.crashing.org>, <brendan.d.gregg@gmail.com>,
        <brendanhiggins@google.com>, <cai@lca.pw>,
        <colin.king@canonical.com>, <corbet@lwn.net>, <david@redhat.com>,
        <dwmw@amazon.com>, <fan.du@intel.com>, <foersleo@amazon.de>,
        <gthelen@google.com>, <irogers@google.com>, <jolsa@redhat.com>,
        <kirill@shutemov.name>, <mark.rutland@arm.com>, <mgorman@suse.de>,
        <minchan@kernel.org>, <mingo@redhat.com>, <namhyung@kernel.org>,
        <peterz@infradead.org>, <rdunlap@infradead.org>,
        <riel@surriel.com>, <rientjes@google.com>, <rostedt@goodmis.org>,
        <rppt@kernel.org>, <sblbir@amazon.com>, <shakeelb@google.com>,
        <shuah@kernel.org>, <sj38.park@gmail.com>, <snu@amazon.de>,
        <vbabka@suse.cz>, <vdavydov.dev@gmail.com>,
        <yang.shi@linux.alibaba.com>, <ying.huang@intel.com>,
        <zgf574564920@gmail.com>, <linux-damon@amazon.com>,
        <linux-mm@kvack.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v20 00/15] Introduce Data Access MONitor (DAMON)
Date:   Fri, 25 Sep 2020 16:59:19 +0200
Message-ID: <20200925145919.18515-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200831112235.2675-1-sjpark@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.162.221]
X-ClientProxiedBy: EX13D30UWC004.ant.amazon.com (10.43.162.4) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Aug 2020 13:22:35 +0200 SeongJae Park <sjpark@amazon.com> wrote:

> On Thu, 20 Aug 2020 09:27:38 +0200 SeongJae Park <sjpark@amazon.com> wrote:
> 
> > On Mon, 17 Aug 2020 12:51:22 +0200 SeongJae Park <sjpark@amazon.com> wrote:
> > 
> > > From: SeongJae Park <sjpark@amazon.de>
> > > 
[...]
> > > Introduction
> > > ============
> > > 
> > > DAMON is a data access monitoring framework subsystem for the Linux kernel.
> > > The core mechanisms of DAMON called 'region based sampling' and 'adaptive
> > > regions adjustment' (refer to 'mechanisms.rst' in the 11th patch of this
> > > patchset for the detail) make it
> > > 
> > >  - accurate (The monitored information is useful for DRAM level memory
> > >    management. It might not appropriate for Cache-level accuracy, though.),
> > >  - light-weight (The monitoring overhead is low enough to be applied online
> > >    while making no impact on the performance of the target workloads.), and
> > >  - scalable (the upper-bound of the instrumentation overhead is controllable
> > >    regardless of the size of target workloads.).
> > > 
> > > Using this framework, therefore, the kernel's core memory management mechanisms
> > > such as reclamation and THP can be optimized for better memory management.  The
> > > experimental memory management optimization works that incurring high
> > > instrumentation overhead will be able to have another try.  In user space,
> > > meanwhile, users who have some special workloads will be able to write
> > > personalized tools or applications for deeper understanding and specialized
> > > optimizations of their systems.
> > 
> > DAMON will be presented in the next week LPC[1].  To be prepared for a screen
> > sharing error (if I get no such error, I will do a live-demo), I recorded a
> > simple demo video.  I would like to share it here to help your easier
> > understanding of DAMON.
> > 
> >     https://youtu.be/l63eqbVBZRY
> > 
> > [1] https://linuxplumbersconf.org/event/7/contributions/659/
> 
> During the session, I introduced the list of future works and asked the
> audiences to vote for the priority of the tasks:
> https://youtu.be/jOBkKMA0uF0?t=13253

I also promised to make my automated tests for DAMON available as open source.
I'm happy to announce that it is not available at Github[1] under GPL v2
license.  Using that, you can easily test how well DAMON works on your machine.
Hopefully, it could be used as a getting started guide for both users and
developers of DAMON.

[1] https://github.com/awslabs/damon-tests


Thanks,
SeongJae Park

> 
> To summarize here, the tasks are (highest priority first):
> 
> 1. Make current DAMON patchset series merged in the mainline (6 votes)
> 2. User space interface improvement (4 votes)
>  - Multiple monitoring contexts
>  - Charging of the monitoring threads' CPU usage
> 3. Support more address spaces (2 votes)
>  - Cgroups, cached pages, specific file-backed pages, swap slots, ...
> 3. DAMON-based MM optimizations (2 votes)
>  - Page reclaim, THP, compaction, NUMA balancing, ...
> 4. Optimize for special use-cases (1 vote)
>  - Page granularity monitoring, accessed-or-not monitoring, ...
> 
> So, I'd like to focus on polishing current patchset so that it could be merged
> in.  For that, I'd like to ask your more reviews.
> 
> While waiting for the reviews, I will start implementing other future features
> that received many votes.  The support of multiple monitoring contexts for the
> user space would be the first one.  Once the implementation is finished, I will
> post it as separated RFC patchset (the user space interface will be compatible
> with current one).
> 
> Any comment is welcome.
> 
> 
> Thanks,
> SeongJae Park
