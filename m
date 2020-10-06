Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFB10284BC3
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 14:40:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbgJFMkk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 08:40:40 -0400
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:65069 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726362AbgJFMkj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 08:40:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1601988037; x=1633524037;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=gieoERz6OSpe9+PGX9t2VgspjS9k3ZJTD8jbul5Junc=;
  b=KC79sn3kdl0/YR3eJnl7NsJJlu0A3lzsAsn/HoLBW2j2gLpRp2IYQ8bm
   NgpqRUE9kPXUwohdwDNhvzymDXuqZhyQzDpHfv1ryZa+T7MZN3bOvExbl
   KhEaPGNjaT4k81nU9Z888hGG/sVFklPxuBpS0sFRcLiN3aZ21trp6CSL2
   o=;
X-IronPort-AV: E=Sophos;i="5.77,343,1596499200"; 
   d="scan'208";a="58084298"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-2b-55156cd4.us-west-2.amazon.com) ([10.43.8.2])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP; 06 Oct 2020 12:40:32 +0000
Received: from EX13D31EUA004.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2b-55156cd4.us-west-2.amazon.com (Postfix) with ESMTPS id 0507CA1D98;
        Tue,  6 Oct 2020 12:40:29 +0000 (UTC)
Received: from u3f2cd687b01c55.ant.amazon.com (10.43.161.237) by
 EX13D31EUA004.ant.amazon.com (10.43.165.161) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 6 Oct 2020 12:40:11 +0000
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
Subject: [RFC v15 0/8] Implement Data Access Monitoring-based Memory Operation Schemes
Date:   Tue, 6 Oct 2020 14:39:23 +0200
Message-ID: <20201006123931.5847-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.43.161.237]
X-ClientProxiedBy: EX13D18UWA002.ant.amazon.com (10.43.160.199) To
 EX13D31EUA004.ant.amazon.com (10.43.165.161)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

Changes from Previous Version
=============================

- s/snprintf()/scnprintf() (Marco Elver)
- Place three parts of DAMON (core, primitives, and dbgfs) in different files

Introduction
============

DAMON[1] can be used as a primitive for data access aware memory management
optimizations.  For that, users who want such optimizations should run DAMON,
read the monitoring results, analyze it, plan a new memory management scheme,
and apply the new scheme by themselves.  Such efforts will be inevitable for
some complicated optimizations.

However, in many other cases, the users would simply want the system to apply a
memory management action to a memory region of a specific size having a
specific access frequency for a specific time.  For example, "page out a memory
region larger than 100 MiB keeping only rare accesses more than 2 minutes", or
"Do not use THP for a memory region larger than 2 MiB rarely accessed for more
than 1 seconds".

This RFC patchset makes DAMON to handle such data access monitoring-based
Operation Schemes (DAMOS).  With this change, users can do the data access
aware optimizations by simply specifying their schemes.

[1] https://lore.kernel.org/linux-doc/20201005105522.23841-1-sjpark@amazon.com/

Evaluations
===========

We evaluated DAMON's overhead, monitoring quality and usefulness using 25
realistic workloads on my QEMU/KVM based virtual machine running a kernel that
v12 of this patchset is applied.

An experimental DAMON-based operation scheme for THP, ‘ethp’, removes 31.29% of
THP memory overheads while preserving 60.64% of THP speedup. Another
experimental DAMON-based ‘proactive reclamation’ implementation, ‘prcl’,
reduces 87.95% of residential sets and 29.52% of system memory footprint while
incurring only 2.15% runtime overhead in the best case (parsec3/freqmine).

NOTE that the experimentail THP optimization and proactive reclamation are not
for production, just only for proof of concepts.

Please refer to the official document[1] or "Documentation/admin-guide/mm: Add
a document for DAMON" patch in the latest DAMON patchset for detailed
evaluation setup and results.

[1] https://damonitor.github.io/doc/html/latest-damos

More Information
================

We prepared a showcase web site[1] that you can get more information.  There
are

- the official documentations[2],
- the heatmap format dynamic access pattern of various realistic workloads for
  heap area[3], mmap()-ed area[4], and stack[5] area,
- the dynamic working set size distribution[6] and chronological working set
  size changes[7], and
- the latest performance test results[8].

[1] https://damonitor.github.io/_index
[2] https://damonitor.github.io/doc/html/latest-damos
[3] https://damonitor.github.io/test/result/visual/latest/rec.heatmap.0.html
[4] https://damonitor.github.io/test/result/visual/latest/rec.heatmap.1.html
[5] https://damonitor.github.io/test/result/visual/latest/rec.heatmap.2.html
[6] https://damonitor.github.io/test/result/visual/latest/rec.wss_sz.html
[7] https://damonitor.github.io/test/result/visual/latest/rec.wss_time.html
[8] https://damonitor.github.io/test/result/perf/latest/html/index.html

Baseline and Complete Git Tree
==============================

The patches are based on the v5.8 plus v21 DAMON patchset[1] and Minchan's
``do_madvise()`` patch[2], which retrieved from the -next tree.  You can also
clone the complete git tree:

    $ git clone git://github.com/sjp38/linux -b damos/rfc/v15

The web is also available:
https://github.com/sjp38/linux/releases/tag/damos/rfc/v15

There are a couple of trees for entire DAMON patchset series that future
features are included.  The first one[3] contains the changes for latest
release, while the other one[4] contains the changes for next release.

[1] https://lore.kernel.org/linux-doc/20201005105522.23841-1-sjpark@amazon.com/
[2] https://lore.kernel.org/linux-mm/20200302193630.68771-2-minchan@kernel.org/
[3] https://github.com/sjp38/linux/tree/damon/master
[4] https://github.com/sjp38/linux/tree/damon/next

Sequence Of Patches
===================

The 1st patch accounts age of each region.  The 2nd patch implements the
handling of the schemes in DAMON core.  The 3rd patch makes 'damon-primitives',
the default primitives for the virtual address spaces monitoring to support the
schemes.  From this point, the kernel space users can use DAMOS.  The 4th patch
implements a debugfs interface for the privileged people and user programs.
The 5th patch implements schemes statistics feature for easier tuning of the
schemes and runtime access pattern analysis.  The 6th patche adds selftests for
these changes, and the 7th patch adds human friendly schemes support to the
user space tool for DAMON.  Finally, the 8th patch documents this new feature.

Patch History
=============

Changes from RFC v14
(https://lore.kernel.org/linux-mm/20200804142430.15384-1-sjpark@amazon.com/)
- s/snprintf()/scnprintf() (Marco Elver)
- Place three parts of DAMON (core, primitives, and dbgfs) in different files

Changes from RFC v13
(https://lore.kernel.org/linux-mm/20200707093805.4775-1-sjpark@amazon.com/)
- Drop loadable module support
- Use dedicated valid action checker function
- Rebase on v5.8 plus v19 DAMON

Changes from RFC v12
(https://lore.kernel.org/linux-mm/20200616073828.16509-1-sjpark@amazon.com/)
 - Wordsmith the document, comment, commit messages
 - Support a scheme of max access count 0
 - Use 'unsigned long' for (min|max)_sz_region

Changes from RFC v11
(https://lore.kernel.org/linux-mm/20200609065320.12941-1-sjpark@amazon.com/)
 - Refine the commit messages (David Hildenbrand)
 - Clean up debugfs code

Changes from RFC v10
(https://lore.kernel.org/linux-mm/20200603071138.8152-1-sjpark@amazon.com/)
 - Fix the wrong error handling for schemes debugfs file
 - Handle the schemes stats from the user space tool
 - Remove the schemes implementation plan from the document

Changes from RFC v9
(https://lore.kernel.org/linux-mm/20200526075702.27339-1-sjpark@amazon.com/)
 - Rebase on v5.7
 - Fix wrong comments and documents for schemes apply conditions

Changes from RFC v8
(https://lore.kernel.org/linux-mm/20200512115343.27699-1-sjpark@amazon.com/)
 - Rewrite the document (Stefan Nuernberger)
 - Make 'damon_for_each_*' argument order consistent (Leonard Foerster)
 - Implement statistics for schemes
 - Avoid races between debugfs readers and writers
 - Reset age for only significant access frequency changes
 - Add kernel-doc comments in damon.h

Please refer to RFC v8 for previous history

SeongJae Park (8):
  mm/damon/core: Account age of target regions
  mm/damon/core: Implement DAMON-based Operation Schemes (DAMOS)
  mm/damon/primitives: Support DAMON-based Operation Schemes
  mm/damon/dbgfs: Support DAMON-based Operation Schemes
  mm/damon/schemes: Implement statistics feature
  selftests/damon: Add 'schemes' debugfs tests
  tools/damon: Support more human friendly 'schemes' control
  Docs/admin-guide/mm/damon: Document DAMON-based Operation Schemes

 Documentation/admin-guide/mm/damon/guide.rst  |  41 ++++-
 Documentation/admin-guide/mm/damon/start.rst  |  11 ++
 Documentation/admin-guide/mm/damon/usage.rst  | 109 ++++++++++-
 Documentation/vm/damon/index.rst              |   1 -
 include/linux/damon.h                         |  90 +++++++++-
 mm/damon/core.c                               | 127 ++++++++++++-
 mm/damon/dbgfs.c                              | 170 +++++++++++++++++-
 mm/damon/primitives.c                         |  64 +++++++
 tools/damon/_convert_damos.py                 | 141 +++++++++++++++
 tools/damon/_damon.py                         |  28 ++-
 tools/damon/damo                              |   7 +
 tools/damon/schemes.py                        | 110 ++++++++++++
 .../testing/selftests/damon/debugfs_attrs.sh  |  29 +++
 13 files changed, 908 insertions(+), 20 deletions(-)
 create mode 100755 tools/damon/_convert_damos.py
 create mode 100644 tools/damon/schemes.py

-- 
2.17.1

