Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 118D6285929
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 09:15:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727669AbgJGHPH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 03:15:07 -0400
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:16893 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727629AbgJGHPH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 03:15:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1602054906; x=1633590906;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=aGs1vjdgt+HPgZuMd56V1udjF34iLdlB3s97w+eUuLU=;
  b=kyLJBi3llg2Y8NPCDI+BAxvCDa1EC+LTgmFKFi//bxYdXzM7qdAFRmDl
   miYNr3hN72eEQDdWcqZe6Qd9bzojy3F1FHPIfGbpHfIhGnUVTH3+T6+Og
   DT4clhaJf6TAcSN8+vPscZDUs6luSOI2VJc0Nk0sp3f2+b0KRpvqK2jzU
   Y=;
X-IronPort-AV: E=Sophos;i="5.77,345,1596499200"; 
   d="scan'208";a="74032796"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1a-821c648d.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP; 07 Oct 2020 07:14:58 +0000
Received: from EX13D31EUA004.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
        by email-inbound-relay-1a-821c648d.us-east-1.amazon.com (Postfix) with ESMTPS id 6AF90A2290;
        Wed,  7 Oct 2020 07:14:45 +0000 (UTC)
Received: from u3f2cd687b01c55.ant.amazon.com (10.43.162.73) by
 EX13D31EUA004.ant.amazon.com (10.43.165.161) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 7 Oct 2020 07:14:28 +0000
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
Subject: [RFC v9 00/10] DAMON: Support Physical Memory Address Space Monitoring
Date:   Wed, 7 Oct 2020 09:13:59 +0200
Message-ID: <20201007071409.12174-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.162.73]
X-ClientProxiedBy: EX13D31UWA003.ant.amazon.com (10.43.160.130) To
 EX13D31EUA004.ant.amazon.com (10.43.165.161)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

NOTE: This is only an RFC for future features of DAMON patchset[1], which is
not merged in the mainline yet.  The aim of this RFC is to show how DAMON would
be evolved once it is merged in.  So, if you have some interest in this RFC,
please consider reviewing the DAMON patchset, either.

Changes from Previous Version
=============================

- s/snprintf()/scnprintf() (Marco Elver)
- Place three parts of DAMON (core, primitives, and dbgfs) in different files

Introduction
============

NOTE: This is only an RFC for future features of DAMON patchset[1], which is
not merged in the mainline yet.  The aim of this RFC is to show how DAMON would
be expanded once it is merged in.  So, if you have some interest in this RFC,
please consider reviewing DAMON, either.

DAMON[1] programming interface users can extend DAMON for any address space by
configuring the address-space specific low level primitives with appropriate
ones.  However, because only the implementation for the virtual address spaces
is available now, the users should implement their own for other address
spaces.  Worse yet, the user space users who are using the debugfs interface of
'damon-dbgfs' module or the DAMON user space tool, cannot implement their own.

This patchset implements another reference implementation of the low level
primitives for the physical memory address space.  With this change, hence, the
kernel space users can monitor both the virtual and the physical address spaces
by simply changing the configuration in the runtime.  Further, this patchset
links the implementation to the debugfs interface and the user space tool for
the user space users.

Note that the implementation supports only the online user memory, as same to
the Idle Page Tracking.

[1] https://lore.kernel.org/linux-mm/20200817105137.19296-1-sjpark@amazon.com/

Baseline and Complete Git Trees
===============================

The patches are based on the v5.8 plus DAMON v21 patchset[1] and DAMOS RFC v15
patchset[2].  You can also clone the complete git tree:

    $ git clone git://github.com/sjp38/linux -b cdamon/rfc/v9

The web is also available:
https://github.com/sjp38/linux/releases/tag/cdamon/rfc/v9

[1] https://lore.kernel.org/linux-doc/20201005105522.23841-1-sjpark@amazon.com/
[2] https://lore.kernel.org/linux-mm/20201006123931.5847-1-sjpark@amazon.com/

Sequence of Patches
===================

The sequence of patches is as follow.

The first 5 patches allow the user space users manually set the monitoring
regions.  The 1st and 2nd patches implements the features in the 'damon-dbgfs'
and the user space tool, respectively.  Following two patches update
unittests (the 3rd patch) and selftests (the 4th patch) for the new feature.
Finally, the 5th patch documents this new feature.

Following 5 patches implement the physical memory monitoring.  The 6th patch
implements the primitives for the physical memory address.  The 7th and the 8th
patches links the primitives to the 'damon-dbgfs' and the user space tool,
respectively.  The 9th patch further implement a handy NUMA specific memory
monitoring feature on the user space tool.  Finally, the 10th patch documents
this new features.

Patch History
=============

Changes from RFC v8
(https://lore.kernel.org/linux-mm/20200831104730.28970-1-sjpark@amazon.com/)
- s/snprintf()/scnprintf() (Marco Elver)
- Place three parts of DAMON (core, primitives, and dbgfs) in different files

Changes from RFC v7
(https://lore.kernel.org/linux-mm/20200818072501.30396-1-sjpark@amazon.com/)
- Add missed 'put_page()' calls
- Support unmapped LRU pages

Changes from RFC v6
(https://lore.kernel.org/linux-mm/20200805065951.18221-1-sjpark@amazon.com/)
- Use 42 as the fake target id for paddr instead of -1
- Fix typo

Changes from RFC v5
(https://lore.kernel.org/linux-mm/20200707144540.21216-1-sjpark@amazon.com/)
- Support nested iomem sections (Du Fan)
- Rebase on v5.8

Changes from RFC v4
(https://lore.kernel.org/linux-mm/20200616140813.17863-1-sjpark@amazon.com/)
 - Support NUMA specific physical memory monitoring

Changes from RFC v3
(https://lore.kernel.org/linux-mm/20200609141941.19184-1-sjpark@amazon.com/)
 - Export rmap functions
 - Reorganize for physical memory monitoring support only
 - Clean up debugfs code

Changes from RFC v2
(https://lore.kernel.org/linux-mm/20200603141135.10575-1-sjpark@amazon.com/)
 - Support the physical memory monitoring with the user space tool
 - Use 'pfn_to_online_page()' (David Hildenbrand)
 - Document more detail on random 'pfn' and its safeness (David Hildenbrand)

Changes from RFC v1
(https://lore.kernel.org/linux-mm/20200409094232.29680-1-sjpark@amazon.com/)
 - Provide the reference primitive implementations for the physical memory
 - Connect the extensions with the debugfs interface

SeongJae Park (10):
  damon/dbgfs: Allow users to set initial monitoring target regions
  tools/damon: Support init target regions specification
  damon/dbgfs-test: Add a unit test case for 'init_regions'
  selftests/damon/_chk_record: Do not check number of gaps
  Docs/admin-guide/mm/damon: Document 'init_regions' feature
  damon/primitives: Implement callbacks for physical address space
    monitoring
  damon/dbgfs: Support physical memory monitoring
  tools/damon/record: Support physical memory monitoring
  tools/damon/record: Support NUMA specific recording
  Docs/DAMON: Document physical memory monitoring support

 Documentation/admin-guide/mm/damon/usage.rst |  77 +++++-
 Documentation/vm/damon/design.rst            |  29 ++-
 Documentation/vm/damon/faq.rst               |   5 +-
 include/linux/damon.h                        |   9 +-
 mm/damon/dbgfs-test.h                        |  55 +++++
 mm/damon/dbgfs.c                             | 171 +++++++++++++-
 mm/damon/primitives.c                        | 236 +++++++++++++++++++
 tools/damon/_damon.py                        |  41 ++++
 tools/damon/_paddr_layout.py                 | 147 ++++++++++++
 tools/damon/record.py                        |  57 ++++-
 tools/damon/schemes.py                       |  12 +-
 tools/testing/selftests/damon/_chk_record.py |   6 -
 12 files changed, 799 insertions(+), 46 deletions(-)
 create mode 100644 tools/damon/_paddr_layout.py

-- 
2.17.1

