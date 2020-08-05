Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE6CE23C67F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Aug 2020 09:05:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728468AbgHEHEx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Aug 2020 03:04:53 -0400
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:59324 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728387AbgHEHEl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 03:04:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1596611080; x=1628147080;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OZo+vTKyPigtYlE9tXWQERpNEX8zpQE9PZnr8q+Ltb4=;
  b=sUA6GMFQ0kIF3/U/qhI6dmFfXUy497pbBoSUzfCYWij/oTCXD9jQf6wj
   HLLEjau5COQHttpAHkLjSjdTaOGZAJiwLnl991P7wdzsnzo+yi9GZO7cT
   P/j/N8lJigvQ4F3TjknDw7jdxtyVWl56uexxSGLd0+hy4xO2mr33Lfq4e
   Q=;
IronPort-SDR: cCGpUd6OuigIzbeDCIZdv0SZ/X1hxGWx6gKPQ7Vz5EYMYbeZ3Fb9/hrPtQyaivgBvl6A2GyGli
 L3sQsjnsqFvQ==
X-IronPort-AV: E=Sophos;i="5.75,436,1589241600"; 
   d="scan'208";a="47559040"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1e-27fb8269.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP; 05 Aug 2020 07:04:39 +0000
Received: from EX13MTAUEA002.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1e-27fb8269.us-east-1.amazon.com (Postfix) with ESMTPS id 7D2B3A056E;
        Wed,  5 Aug 2020 07:04:28 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 5 Aug 2020 07:04:27 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.160.26) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 5 Aug 2020 07:04:08 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     <akpm@linux-foundation.org>
CC:     SeongJae Park <sjpark@amazon.de>, <Jonathan.Cameron@Huawei.com>,
        <aarcange@redhat.com>, <acme@kernel.org>,
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
        <linux-damon@amazon.com>, <linux-mm@kvack.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [RFC v6 10/10] Docs/DAMON: Document physical memory monitoring support
Date:   Wed, 5 Aug 2020 08:59:51 +0200
Message-ID: <20200805065951.18221-11-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200805065951.18221-1-sjpark@amazon.com>
References: <20200805065951.18221-1-sjpark@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.43.160.26]
X-ClientProxiedBy: EX13D24UWB002.ant.amazon.com (10.43.161.159) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

This commit updates the DAMON documents for the physical memory
monitoring support.

Signed-off-by: SeongJae Park <sjpark@amazon.de>
---
 Documentation/admin-guide/mm/damon/usage.rst | 42 ++++++++++++++++----
 Documentation/vm/damon/design.rst            | 29 +++++++++-----
 Documentation/vm/damon/faq.rst               |  5 +--
 3 files changed, 54 insertions(+), 22 deletions(-)

diff --git a/Documentation/admin-guide/mm/damon/usage.rst b/Documentation/admin-guide/mm/damon/usage.rst
index cf0d44ce0ac9..88b8e9254a7e 100644
--- a/Documentation/admin-guide/mm/damon/usage.rst
+++ b/Documentation/admin-guide/mm/damon/usage.rst
@@ -10,15 +10,16 @@ DAMON provides below three interfaces for different users.
   This is for privileged people such as system administrators who want a
   just-working human-friendly interface.  Using this, users can use the DAMON’s
   major features in a human-friendly way.  It may not be highly tuned for
-  special cases, though.  It supports only virtual address spaces monitoring.
+  special cases, though.  It supports both virtual and physical address spaces
+  monitoring.
 - *debugfs interface.*
   This is for privileged user space programmers who want more optimized use of
   DAMON.  Using this, users can use DAMON’s major features by reading
   from and writing to special debugfs files.  Therefore, you can write and use
   your personalized DAMON debugfs wrapper programs that reads/writes the
   debugfs files instead of you.  The DAMON user space tool is also a reference
-  implementation of such programs.  It supports only virtual address spaces
-  monitoring.
+  implementation of such programs.  It supports both virtual and physical
+  address spaces monitoring.
 - *Kernel Space Programming Interface.*
   This is for kernel space programmers.  Using this, users can utilize every
   feature of DAMON most flexibly and efficiently by writing kernel space
@@ -49,8 +50,10 @@ Recording Data Access Pattern
 
 The ``record`` subcommand records the data access pattern of target workloads
 in a file (``./damon.data`` by default).  You can specify the target with 1)
-the command for execution of the monitoring target process, or 2) pid of
-running target process.  Below example shows a command target usage::
+the command for execution of the monitoring target process, 2) pid of running
+target process, or 3) the special keyword, 'paddr', if you want to monitor the
+system's physical memory address space.  Below example shows a command target
+usage::
 
     # cd <kernel>/tools/damon/
     # damo record "sleep 5"
@@ -61,6 +64,15 @@ of the process.  Below example shows a pid target usage::
     # sleep 5 &
     # damo record `pidof sleep`
 
+Finally, below example shows the use of the special keyword, 'paddr'::
+
+    # damo record paddr
+
+In this case, the monitoring target regions defaults to the largetst 'System
+RAM' region specified in '/proc/iomem' file.  Note that the initial monitoring
+target region is maintained rather than dynamically updated like the virtual
+memory address spaces monitoring case.
+
 The location of the recorded file can be explicitly set using ``-o`` option.
 You can further tune this by setting the monitoring attributes.  To know about
 the monitoring attributes in detail, please refer to the
@@ -319,20 +331,34 @@ check it again::
     # cat target_ids
     42 4242
 
+Users can also monitor the physical memory address space of the system by
+writing a special keyword, "``paddr\n``" to the file.  Because physical address
+space monitoring doesn't support multiple targets, reading the file will show a
+fake value, ``-1``, as below::
+
+    # cd <debugfs>/damon
+    # echo paddr > target_ids
+    # cat target_ids
+    -1
+
 Note that setting the target ids doesn't start the monitoring.
 
 
 Initial Monitoring Target Regions
 ---------------------------------
 
-In case of the debugfs based monitoring, DAMON automatically sets and updates
-the monitoring target regions so that entire memory mappings of target
-processes can be covered. However, users might want to limit the monitoring
+In case of the virtual address space monitoring, DAMON automatically sets and
+updates the monitoring target regions so that entire memory mappings of target
+processes can be covered.  However, users might want to limit the monitoring
 region to specific address ranges, such as the heap, the stack, or specific
 file-mapped area.  Or, some users might know the initial access pattern of
 their workloads and therefore want to set optimal initial regions for the
 'adaptive regions adjustment'.
 
+In contrast, DAMON do not automatically sets and updates the monitoring target
+regions in case of physical memory monitoring.  Therefore, users should set the
+monitoring target regions by themselves.
+
 In such cases, users can explicitly set the initial monitoring target regions
 as they want, by writing proper values to the ``init_regions`` file.  Each line
 of the input should represent one region in below form.::
diff --git a/Documentation/vm/damon/design.rst b/Documentation/vm/damon/design.rst
index 727d72093f8f..0666e19018fd 100644
--- a/Documentation/vm/damon/design.rst
+++ b/Documentation/vm/damon/design.rst
@@ -35,27 +35,34 @@ two parts:
 1. Identification of the monitoring target address range for the address space.
 2. Access check of specific address range in the target space.
 
-DAMON currently provides the implementation of the primitives for only the
-virtual address spaces. Below two subsections describe how it works.
+DAMON currently provides the implementations of the primitives for the physical
+and virtual address spaces. Below two subsections describe how those work.
 
 
 PTE Accessed-bit Based Access Check
 -----------------------------------
 
-The implementation for the virtual address space uses PTE Accessed-bit for
-basic access checks.  It finds the relevant PTE Accessed bit from the address
-by walking the page table for the target task of the address.  In this way, the
-implementation finds and clears the bit for next sampling target address and
-checks whether the bit set again after one sampling period.  This could disturb
-other kernel subsystems using the Accessed bits, namely Idle page tracking and
-the reclaim logic.  To avoid such disturbances, DAMON makes it mutually
-exclusive with Idle page tracking and uses ``PG_idle`` and ``PG_young`` page
-flags to solve the conflict with the reclaim logic, as Idle page tracking does.
+Both of the implementations for physical and virtual address spaces use PTE
+Accessed-bit for basic access checks.  Only one difference is the way of
+finding the relevant PTE Accessed bit(s) from the address.  While the
+implementation for the virtual address walks the page table for the target task
+of the address, the implementation for the physical address walks every page
+table having a mapping to the address.  In this way, the implementations find
+and clear the bit(s) for next sampling target address and checks whether the
+bit(s) set again after one sampling period.  This could disturb other kernel
+subsystems using the Accessed bits, namely Idle page tracking and the reclaim
+logic.  To avoid such disturbances, DAMON makes it mutually exclusive with Idle
+page tracking and uses ``PG_idle`` and ``PG_young`` page flags to solve the
+conflict with the reclaim logic, as Idle page tracking does.
 
 
 VMA-based Target Address Range Construction
 -------------------------------------------
 
+This is only for the virtual address space primitives implementation.  That for
+the physical address space simply asks users to manually set the monitoring
+target address ranges.
+
 Only small parts in the super-huge virtual address space of the processes are
 mapped to the physical memory and accessed.  Thus, tracking the unmapped
 address regions is just wasteful.  However, because DAMON can deal with some
diff --git a/Documentation/vm/damon/faq.rst b/Documentation/vm/damon/faq.rst
index 088128bbf22b..6469d54c480f 100644
--- a/Documentation/vm/damon/faq.rst
+++ b/Documentation/vm/damon/faq.rst
@@ -43,10 +43,9 @@ constructions and actual access checks can be implemented and configured on the
 DAMON core by the users.  In this way, DAMON users can monitor any address
 space with any access check technique.
 
-Nonetheless, DAMON provides vma tracking and PTE Accessed bit check based
+Nonetheless, DAMON provides vma/rmap tracking and PTE Accessed bit check based
 implementations of the address space dependent functions for the virtual memory
-by default, for a reference and convenient use.  In near future, we will
-provide those for physical memory address space.
+and the physical memory by default, for a reference and convenient use.
 
 
 Can I simply monitor page granularity?
-- 
2.17.1

