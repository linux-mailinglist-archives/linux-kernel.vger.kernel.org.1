Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDC812B677A
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 15:34:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728768AbgKQObe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 09:31:34 -0500
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:54141 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727473AbgKQObc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 09:31:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1605623490; x=1637159490;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   mime-version;
  bh=iWr+CrWA2q5KXgNWL9K+lQgwAxxKb4wsUpuBWUhuOYI=;
  b=gtVS+oAhZvmeJ4Nc2FjugkDzGiJZo+o7iWbK+hwslRo4/4IYiSyqtpt3
   K9wNhZF2XKrcxqY6l1YetHptUJJrUzV70DfiR56b78twubTNAduhpLKkA
   ieuqYl6h1KVeglAHXDIiDOUbpy17nyZUhosz2MIEIVtVA7Glkvi2XFAjc
   0=;
X-IronPort-AV: E=Sophos;i="5.77,485,1596499200"; 
   d="scan'208";a="96180500"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1e-57e1d233.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 17 Nov 2020 14:31:06 +0000
Received: from EX13D31EUA001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
        by email-inbound-relay-1e-57e1d233.us-east-1.amazon.com (Postfix) with ESMTPS id 48AFD1415D8;
        Tue, 17 Nov 2020 14:30:53 +0000 (UTC)
Received: from u3f2cd687b01c55.ant.amazon.com (10.43.162.50) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 17 Nov 2020 14:30:37 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     SeongJae Park <sjpark@amazon.com>
CC:     <aarcange@redhat.com>, <acme@kernel.org>,
        <alexander.shishkin@linux.intel.com>, <amit@kernel.org>,
        <benh@kernel.crashing.org>, <brendan.d.gregg@gmail.com>,
        <brendanhiggins@google.com>, <cai@lca.pw>,
        <colin.king@canonical.com>, <corbet@lwn.net>, <david@redhat.com>,
        <dwmw@amazon.com>, <elver@google.com>, <fan.du@intel.com>,
        <foersleo@amazon.de>, <gthelen@google.com>, <irogers@google.com>,
        <jolsa@redhat.com>, <kirill@shutemov.name>, <mark.rutland@arm.com>,
        <mgorman@suse.de>, <minchan@kernel.org>, <mingo@redhat.com>,
        <namhyung@kernel.org>, <peterz@infradead.org>,
        <rdunlap@infradead.org>, <riel@surriel.com>, <rientjes@google.com>,
        <rostedt@goodmis.org>, <rppt@kernel.org>, <sblbir@amazon.com>,
        <shakeelb@google.com>, <shuah@kernel.org>, <sj38.park@gmail.com>,
        <snu@amazon.de>, <vbabka@suse.cz>, <vdavydov.dev@gmail.com>,
        <yang.shi@linux.alibaba.com>, <ying.huang@intel.com>,
        <zgf574564920@gmail.com>, <linux-damon@amazon.com>,
        <linux-mm@kvack.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v22 00/18] Introduce Data Access MONitor (DAMON)
Date:   Tue, 17 Nov 2020 15:30:21 +0100
Message-ID: <20201117143021.11883-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201117080539.31334-1-sjpark@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.162.50]
X-ClientProxiedBy: EX13D34UWA001.ant.amazon.com (10.43.160.173) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In addition to the ping, I'd like to share our recent real-world usecase of
DAMON.  I just hope this real user story makes more comments than previously
shared benchmark results.

DAMON as a profiler
-------------------

Recently, we analyzed characteristics of a large scale production systems
utilizing 70GB DRAM and 36 CPUs using DAMON.  From this, we were able to find
interesting things including below.

There were obviously different access pattern under idle workload and active
workload.  Under the idle workload, it accessed larger memory regions with low
frequency (resembles that of scanning workload), while the active workload
accessing smaller memory regions with high freuqnecy.

DAMON found a 7GB memory region that showing obviously high access frequency
under the active workload.  We believe this is the performance-effective
working set and need to be protected.

There was a 4KB memory region that showing highest access frequency under not
only active but also idle workloads.  I think this must be a code section like
thing.

For this analysis, DAMON used only 0.3-1% of single CPU time.  Because we used
recording-based analysis, it consumed about 3-12 MB of disk space per 20
minutes.  This is only small amount of disk space, but we can further reduce
the disk usage by using non-recording-based DAMON features.  I'd like to argue
that only DAMON can do such detailed analysis (finding 4KB highest region in
70GB memory) with the light overhead.

DAMON as a system optimization tool
-----------------------------------

We also found below potential performance problems on the systems and made
DAMON-based solutions.

The system doesn't want to make the workload suffer from the page reclamation
and thus it utilizes enough DRAM but no swap device.  However, we found the
system is actively reclaiming file-backed pages, because the system has
intensive file IO.  The file IO turned out to be not performance critical for
the workload, but we want to ensure performance critical file-backed pages like
code section to not mistakenly be evicted.

Straightforward solution should be using direct IO, but modifying the workload
is not so easy.  We also considered `mlockall()`, but we couldn't use that
because VSZ of the workload is much larger than the physical DRAM.  Finding the
region and calling `mlock()` might be a right solution, but modifying the
system is still not easy.

We found the fact that the DAMON-based operation scheme[1] could be used.  By
using it, we can ask DAMON to track access frequency of each region and make
'process_madvise(MADV_WILLNEED)[2]' call for regions having specific size and
access frequency for a time interval.

We also found the system is having high number of TLB misses.  We tried
'always' THP enabled policy and it greatly reduced TLB misses, but the page
reclamation also been more frequent due to the THP internal fragmentation
caused memory bloat.  We will try another DAMON-based operation scheme for
applying 'MADV_HUGEPAGE' to memory regions having >=2MB size and high access
frequency, while applying 'MADV_NOHUGEPAGE' to regions having <2MB size and low
access frequency.

We do not own the systems so we only reported the analysis results and possible
optimization solutions to the owners.  The owners satisfied about the analysis
results and promised to try the optimization guides.

[1] https://lore.kernel.org/linux-mm/20201006123931.5847-1-sjpark@amazon.com/
[2] https://lore.kernel.org/linux-api/20200622192900.22757-4-minchan@kernel.org/


In summary, DAMON has used on production systems and proved its usefulness.


Thanks,
SeongJae Park


On Tue, 17 Nov 2020 09:05:39 +0100 SeongJae Park <sjpark@amazon.com> wrote:

> Another week, another ping.  I'm waiting for _any_ comments.
> 
> 
> Thanks,
> SeongJae Park
> 
> On Wed, 11 Nov 2020 17:41:13 +0100 SeongJae Park <sjpark@amazon.com> wrote:
> 
> > Hi, I'd like to remind you that I'm still waiting more reviews.  Any comments
> > are welcome.
> > 
> > 
> > Thanks,
> > SeongJae Park
> > 
> > On Tue, 20 Oct 2020 10:59:22 +0200 SeongJae Park <sjpark@amazon.com> wrote:
> > 
> > > From: SeongJae Park <sjpark@amazon.de>
> > > 
> > > Changes from Previous Version (v21)
> > > ===================================
> > > 
> > > This version contains below minor changes.
> > > 
> > > - Fix build warnings and errors (kernel test robot)
> > > - Fix a memory leak (kmemleak)
> > > - Respect KUNIT_ALL_TESTS
> > > - Rebase on v5.9
> > > - Update the evaluation results
> > > 
> > > Introduction
> > > ============
> > > 
> > > DAMON is a data access monitoring framework for the Linux kernel.  The core
> > > mechanisms of DAMON called 'region based sampling' and 'adaptive regions
> > > adjustment' (refer to 'mechanisms.rst' in the 11th patch of this patchset for
> > > the detail) make it
> > > 
> > >  - accurate (The monitored information is useful for DRAM level memory
> > >    management. It might not appropriate for Cache-level accuracy, though.),
> > >  - light-weight (The monitoring overhead is low enough to be applied online
> > >    while making no impact on the performance of the target workloads.), and
> > >  - scalable (the upper-bound of the instrumentation overhead is controllable
> > >    regardless of the size of target workloads.).
> > > 
> > > Using this framework, therefore, several memory management mechanisms such as
> > > reclamation and THP can be optimized to aware real data access patterns.
> > > Experimental access pattern aware memory management optimization works that
> > > incurring high instrumentation overhead will be able to have another try.
> > > 
> > > Though DAMON is for kernel subsystems, it can be easily exposed to the user
> > > space by writing a DAMON-wrapper kernel subsystem.  Then, user space users who
> > > have some special workloads will be able to write personalized tools or
> > > applications for deeper understanding and specialized optimizations of their
> > > systems.
> > > 
> > > Evaluations
> > > ===========
> > > 
> > > We evaluated DAMON's overhead, monitoring quality and usefulness using 24
> > > realistic workloads on my QEMU/KVM based virtual machine running a kernel that
> > > v22 DAMON patchset is applied.
> > > 
> > > DAMON is lightweight.  It increases system memory usage by 0.25% and slows
> > > target workloads down by 0.89%.
> > > 
> > > DAMON is accurate and useful for memory management optimizations.  An
> > > experimental DAMON-based operation scheme for THP, 'ethp', removes 81.73% of
> > > THP memory overheads while preserving 95.29% of THP speedup.  Another
> > > experimental DAMON-based 'proactive reclamation' implementation, 'prcl',
> > > reduces 91.30% of residential sets and 23.45% of system memory footprint while
> > > incurring only 2.08% runtime overhead in the best case (parsec3/freqmine).
> > > 
> > > NOTE that the experimentail THP optimization and proactive reclamation are not
> > > for production but only for proof of concepts.
> > > 
> > > Please refer to the official document[1] or "Documentation/admin-guide/mm: Add
> > > a document for DAMON" patch in this patchset for detailed evaluation setup and
> > > results.
> > > 
> > > [1] https://damonitor.github.io/doc/html/latest-damon/admin-guide/mm/damon/eval.html
> > > 
