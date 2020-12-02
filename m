Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 883DB2CB72F
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 09:30:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387831AbgLBI3M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 03:29:12 -0500
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:9258 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728052AbgLBI3M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 03:29:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1606897749; x=1638433749;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=0DSQ2od5++p476YAby16Rk0+LHj1ymzAS3859FXXfF0=;
  b=pjDmphC1d+lvDt3p/ORQYdKsxOKEMYTQ4illeRZ/8C45NO4oBK39wD57
   8v0DvxR8HSo/GA7ORydFo/xeYFX5z1H3GYImxhuHklfI3Hdu+SmwkLR+c
   3cnUIUbaGQTNNwEzdxnCfUpIdTHDTZM5HlgVTSR2l70mJa8uQQH5dxhnd
   w=;
X-IronPort-AV: E=Sophos;i="5.78,386,1599523200"; 
   d="scan'208";a="92823194"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1e-c7f73527.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP; 02 Dec 2020 08:28:20 +0000
Received: from EX13D31EUA001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
        by email-inbound-relay-1e-c7f73527.us-east-1.amazon.com (Postfix) with ESMTPS id F1280AA476;
        Wed,  2 Dec 2020 08:28:07 +0000 (UTC)
Received: from u3f2cd687b01c55.ant.amazon.com (10.43.161.174) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 2 Dec 2020 08:27:50 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     <akpm@linux-foundation.org>
CC:     SeongJae Park <sjpark@amazon.de>, <Jonathan.Cameron@Huawei.com>,
        <aarcange@redhat.com>, <acme@kernel.org>,
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
Subject: Plans around DAMON: perf integration and a new page reclaim mechanism
Date:   Wed, 2 Dec 2020 09:27:31 +0100
Message-ID: <20201202082731.24828-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.161.174]
X-ClientProxiedBy: EX13D06UWC002.ant.amazon.com (10.43.162.205) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,


This mail describes what DAMON is, what I am trying to do with it, where the
project is now, and what are the next things I will do.  I hope to hear some
comments for refining of the plans if possible.

What DAMON is
-------------

DAMON[1] is a kernel framework for data access monitoring that scalable.  For
the scalability, it guarantees upper-bound limit of the monitoring overhead
that users can set while providing a best effort accuracy.  The kernel
programmers, hence, can easily write various data access monitoring-based
subsystems in the kernel space using DAMON.  Some of such subsystems would
export some interface to user space so that users can also get some benefit
from it.

[1] https://damonitor.github.io

What I am trying to do
----------------------

Actually, DAMON is a part of my project called Data Access-aware Operating
System (DAOS).  As the name implies, I want to improve the performance and
efficiency of systems using fine-grained data access patterns.  The
optimizations are for both kernel and user spaces.  We will therefore modify or
create kernel mechanisms, exports some of those to user space and implement
user space library / tools.  Below shows the layers and components for the
project.

---------------------------------------------------------------------------
Primitives:	PTE Accessed bit, PG_idle, rmap, (Intel CMT), ...
Framework:	DAMON
Features:	DAMOS, virtual addr, physical addr, ...
Applications:	DAMON-debugfs, (DARC), ...
^^^^^^^^^^^^^^^^^^^^^^^    KERNEL SPACE    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Raw Interface:	debugfs, (sysfs), (damonfs), tracepoints, (sys_damon), ...

vvvvvvvvvvvvvvvvvvvvvvv    USER SPACE      vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
Library:	(libdamon), ...
Tools:		DAMO, (perf), ...
---------------------------------------------------------------------------

The components in parentheses are not implemented yet but in our future plan.
IOW, those are the TODO tasks of DAOS project.  DAMOS, DARC and DAMO will be
explained in following sections.

Where the project is and how it arrived there
---------------------------------------------

The project motivated by increasing memory intensive systems.  Working set size
is continuously growing while DRAM in single system cannot follow the speed.
Fortunately, new memory devices like NVRAM are evolving.  The trend made a
number of data access pattern aware system optimization works to begin.  Most
of those works showed impressive results, but have a common problem.  Many of
their access pattern extraction schemes are impractical or incur high overhead.

Therefore I started designing a way to extract the fine-grained information in
efficient and scalable way.  It is named DAMON.  It proved its lightweight
overhead and accuracy with many environments including realistic benchmarks[1]
and a real huge production systems[2].

For rough but effective re-implementation of the previous works using DAMON
with no code, I implemented a feature called DAMON-based Operation Schemes
(DAMOS).  Using this, I implemented two well-known access-aware memory
management schemes (access-aware THP[3] and proactive reclamation[4]) in 3
lines of configurations[1] and achieved impressive memory footprint reduction
while preserving most of the performance.

The results presented in several venues including KernelSummit'19[5],
MIDDLEWARE Industry'19[6], LWN[7], a Google's internal event, and
KernelSummit'20[8].

The patches posted to LKML since January and received many reviews.  As of now,
22nd version of DAMON patchset[9], 15th version of DAMOS patchset[10], and 8th
version of a patchset[11] for a few more works are available.

[1]  https://damonitor.github.io/doc/html/next/vm/damon/eval.html
[2]  https://lore.kernel.org/linux-mm/20201117143021.11883-1-sjpark@amazon.com/
[3]  https://www.usenix.org/system/files/conference/osdi16/osdi16-kwon.pdf
[4]  https://research.google/pubs/pub48551/
[5]  https://linuxplumbersconf.org/event/4/contributions/548/
[6]  https://dl.acm.org/citation.cfm?id=3368125
[7]  https://lwn.net/Articles/812707/
[8]  https://www.linuxplumbersconf.org/event/7/contributions/659/
[9]  https://lore.kernel.org/linux-mm/20201020085940.13875-1-sjpark@amazon.com/
[10] https://lore.kernel.org/linux-mm/20201006123931.5847-1-sjpark@amazon.com/
[11] https://lore.kernel.org/linux-mm/20200831104730.28970-1-sjpark@amazon.com/

What I will do next
-------------------

In a long term, I will continue the works mentioned in 'What I am trying to do'
section.  IOW, I will implement the parentheses-wrapped components in the above
figure.  In a short term, I'd like to start with two things below.

1. Integration of DAMON user space tool in perf

The DAMON patchset introduces a kernel space DAMON application called
damon-dbgfs as a static kernel module.  It exposes DAMON interface to user
space via the debugfs and provide monitoring results recording feature, so that
users can use DAMON as a profiler or data access-aware optimization framework
(using DAMOS feature).  For easier use of the debugfs interface, the patchset
also introduces a user space tool named DAMON Operator (DAMO).  It wraps the
debugfs interface with a human friendly interface and provides a few useful
monitoring results visualization features.

Since the DAMON is presented, many people asked if it is integrated in perf or
is it able to be controlled via perf.  As perf is the must-have tool for system
admins, making it integrated in perf will make much better user experience.
For the reason, I want to integrate DAMO inside perf as yet another subcommand.
For example, users will be able to use DAMON in below way:

    # perf damon start $(pidof $my_workload)	/* Starts monitoring */
    # perf record -e damon:damon_aggregated	/* DAMON's tracepoint */
    # perf damon record $(pidof $my_workload)	/* shortcut for above two */
    # perf damon report

2. DAMON-based Page Reclamation

Page reclamation considered harmful, but the trend mentioned above in the
motivation part implies a change of the situation.  Simplest but reasonable
choice under the trend is configuring fast swap devices such as NVRAM or zram.
Pseudo-LRU, the current page replacement algorithm of the kernel, worked well
in many real world production systems, but the overhead will become more easily
viewable in frequently reclaiming systems.  I also noticed it before[1].  After
all, concerns about the algorithm have long existed[2].

I'd like to propose another Data Access-aware ReClamation algorithm (DARC)
which can be implemented on the DAMON framework.  The design is not fixed yet,
but the abstract idea is as follows.  Once a memory pressure is recognized, it
monitors the memory access pattern of the system and select eviction targets
based on both access frequency and recency.  In a detail, it would account the
age of each region based on access frequency; the age gradually increases but
becomes zero if a big access frequency change to the region is detected.  Then,
it selects pages in regions having lowest access frequency for longest time as
the first eviction candidate.

Rather than just replacing the pseudo-LRU based reclamation, I'd liket to
implement it as an optional proactive reclamation feature.  In a detail, it
will have three watermarks for each zone, that tunable via sysfs.  The lowest
watermarks will be higher than the high watermark for the original reclaim
logic.  DARC will start if the available memory becomes lower than middle
watermark, and stop if the available memory becomes >highest watermark or
<lowest watermark.  In the final case, original reclaim will do the work.

After this, we will be able to get some feedback from brave users and carefully
adjust it's activeness.

Again, the design is still not fixed.  I will post a draft of it as soon as
possible.  I'd like to discuss more detail from there, but just wanted to share
the conceptual level here.

[1] https://linuxplumbersconf.org/event/4/contributions/548/
[2] https://linux-mm.org/AdvancedPageReplacement

Conclusion
----------

I shared my goals, current status, and the short-term TODO items above.  Hope
this to help you understanding the project, avoid unnecessary conflicts and
make more comments.  If you have any question, concern or opinion, please feel
free to let me know.


Thanks,
SeongJae Park
