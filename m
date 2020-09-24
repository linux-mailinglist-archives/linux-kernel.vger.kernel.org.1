Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CED5527691D
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 08:39:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727009AbgIXGjz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 02:39:55 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:37837 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726885AbgIXGjy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 02:39:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1600929594; x=1632465594;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   mime-version;
  bh=PW0B655DySKTSqtBH4LuirqSOsvQ6UdGky6VjqG365Y=;
  b=vkNobJS9Yoo7KqqAJXQZR/x7nEV1B1apxzWlV4Su9MZuXqWDv2kkzjbR
   wX7hWd0V6MYmtETthFoUjVlL7cbhi/61hd/qaau/xOvEFIUAiLiQMQluo
   KyaGCNTNQ1wd0fZrHLFEZjvgTT7kvG0Hc0mWHbbPR0+bKiXKdr6Hjd30z
   U=;
X-IronPort-AV: E=Sophos;i="5.77,296,1596499200"; 
   d="scan'208";a="77594955"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2c-168cbb73.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP; 24 Sep 2020 06:39:42 +0000
Received: from EX13D31EUA004.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2c-168cbb73.us-west-2.amazon.com (Postfix) with ESMTPS id B322AA1BD4;
        Thu, 24 Sep 2020 06:39:39 +0000 (UTC)
Received: from u3f2cd687b01c55.ant.amazon.com (10.43.162.35) by
 EX13D31EUA004.ant.amazon.com (10.43.165.161) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 24 Sep 2020 06:39:19 +0000
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
        "Du, Fan" <fan.du@intel.com>, <foersleo@amazon.de>,
        Greg Thelen <gthelen@google.com>,
        Ian Rogers <irogers@google.com>, <jolsa@redhat.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        <mark.rutland@arm.com>, Mel Gorman <mgorman@suse.de>,
        Minchan Kim <minchan@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, <namhyung@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Randy Dunlap" <rdunlap@infradead.org>,
        Rik van Riel <riel@surriel.com>,
        "David Rientjes" <rientjes@google.com>,
        Steven Rostedt <rostedt@goodmis.org>, <rppt@kernel.org>,
        <sblbir@amazon.com>, <shuah@kernel.org>, <sj38.park@gmail.com>,
        <snu@amazon.de>, Vlastimil Babka <vbabka@suse.cz>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Huang Ying <ying.huang@intel.com>, <zgf574564920@gmail.com>,
        <linux-damon@amazon.com>, Linux MM <linux-mm@kvack.org>,
        <linux-doc@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v20 00/15] Introduce Data Access MONitor (DAMON)
Date:   Thu, 24 Sep 2020 08:39:03 +0200
Message-ID: <20200924063903.12432-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <CALvZod7nA+_hupDrtp-G886XrgmBVf7izs5VH+1mEj6SNnyWJw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.162.35]
X-ClientProxiedBy: EX13D43UWC002.ant.amazon.com (10.43.162.172) To
 EX13D31EUA004.ant.amazon.com (10.43.165.161)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Sep 2020 10:04:57 -0700 Shakeel Butt <shakeelb@google.com> wrote:

> On Mon, Aug 17, 2020 at 3:52 AM SeongJae Park <sjpark@amazon.com> wrote:
> >
> > From: SeongJae Park <sjpark@amazon.de>
> >
> > Changes from Previous Version
> > =============================
> >
> > - Place 'CREATE_TRACE_POINTS' after '#include' statements (Steven Rostedt)
> > - Support large record file (Alkaid)
> > - Place 'put_pid()' of virtual monitoring targets in 'cleanup' callback
> > - Avoid conflict between concurrent DAMON users
> > - Update evaluation result document
> >
> > Introduction
> > ============
> >
> > DAMON is a data access monitoring framework subsystem for the Linux kernel.
> > The core mechanisms of DAMON called 'region based sampling' and 'adaptive
> > regions adjustment' (refer to 'mechanisms.rst' in the 11th patch of this
> > patchset for the detail) make it
> >
> >  - accurate (The monitored information is useful for DRAM level memory
> >    management. It might not appropriate for Cache-level accuracy, though.),
> >  - light-weight (The monitoring overhead is low enough to be applied online
> >    while making no impact on the performance of the target workloads.), and
> >  - scalable (the upper-bound of the instrumentation overhead is controllable
> >    regardless of the size of target workloads.).
> >
> > Using this framework, therefore, the kernel's core memory management mechanisms
> > such as reclamation and THP can be optimized for better memory management.  The
> > experimental memory management optimization works that incurring high
> > instrumentation overhead will be able to have another try.  In user space,
> > meanwhile, users who have some special workloads will be able to write
> > personalized tools or applications for deeper understanding and specialized
> > optimizations of their systems.
> >
> > Evaluations
> > ===========
> >
> > We evaluated DAMON's overhead, monitoring quality and usefulness using 25
> > realistic workloads on my QEMU/KVM based virtual machine running a kernel that
> > v20 DAMON patchset is applied.
> >
> > DAMON is lightweight.  It increases system memory usage by 0.12% and slows
> > target workloads down by 1.39%.
> >
> > DAMON is accurate and useful for memory management optimizations.  An
> > experimental DAMON-based operation scheme for THP, 'ethp', removes 88.16% of
> > THP memory overheads while preserving 88.73% of THP speedup.  Another
> > experimental DAMON-based 'proactive reclamation' implementation, 'prcl',
> > reduces 91.34% of residential sets and 25.59% of system memory footprint while
> > incurring only 1.58% runtime overhead in the best case (parsec3/freqmine).
> >
> > NOTE that the experimentail THP optimization and proactive reclamation are not
> > for production but just only for proof of concepts.
> >
> > Please refer to the official document[1] or "Documentation/admin-guide/mm: Add
> > a document for DAMON" patch in this patchset for detailed evaluation setup and
> > results.
> >
> > [1] https://damonitor.github.io/doc/html/latest-damon/admin-guide/mm/damon/eval.html
> >
> 
> 
> Hi SeongJae,
> 
> Sorry for the late response. I will start looking at this series in
> more detail in the next couple of weeks.

Thank you so much!

> I have a couple of high level comments for now.
> 
> 1) Please explain in the cover letter why someone should prefer to use
> DAMON instead of Page Idle Tracking.

In short, because DAMON provides overhead-quality tradeoff and allow use of
variable monitoring primitives other than only PG_Idle and PTE Accessed bits.
I will explain this in detail in the cover letter of the next version of this
patchset.

> 
> 2) Also add what features Page Idle Tracking provides which the first
> version of DAMON does not provide (like page level tracking, physical
> or unmapped memory tracking e.t.c) and tell if you plan to add such
> features to DAMON in future. Basically giving reasons to not block the
> current version of DAMON until it is feature-rich.

In short, DAMON will provide only virtual address space monitoring by default
but I believe the lack of features because DAMON is expandable for those.
Also, I will make DAMON co-exists with Idle Page Tracking again.  I will post
another RFC patchset for this soon.  Again, I will describe this in detail in
the next version of the cover letter.

> 
> 3) I think in the first mergeable version of DAMON, I would prefer to
> have support to control (create/delete/account) the DAMON context. You
> already have a RFC series on it. I would like to have that series part
> of this one.

Ok, I will apply it here.


Thanks,
SeongJae Park
