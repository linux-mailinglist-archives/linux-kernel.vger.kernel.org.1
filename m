Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1941827ABF2
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 12:37:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbgI1Khk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 06:37:40 -0400
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:52851 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726576AbgI1Khk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 06:37:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1601289458; x=1632825458;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=tdNdw6IfHLO/vMz+dCnfV6saHBkcPkuM1L7pDo6BFss=;
  b=FMq3kve59mMh30uA204nEgDsLNGwdyqquVWL7EmgYlSre4hIVmcjGwyP
   wXW/0FVcxmtAoWvfBwq6GbNwcpbpMdZR0VlDufqmLbNuqJTg2T4I7Pfrs
   cObjnqv7ubsvq0H5DwXHFEddf9HiZpORoepcRQ87cWHEkEayMZ8bQYP8J
   Y=;
X-IronPort-AV: E=Sophos;i="5.77,313,1596499200"; 
   d="scan'208";a="56682864"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1a-16acd5e0.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP; 28 Sep 2020 10:37:37 +0000
Received: from EX13D31EUA001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
        by email-inbound-relay-1a-16acd5e0.us-east-1.amazon.com (Postfix) with ESMTPS id 09157A1F79;
        Mon, 28 Sep 2020 10:37:24 +0000 (UTC)
Received: from u3f2cd687b01c55.ant.amazon.com (10.43.161.237) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 28 Sep 2020 10:37:06 +0000
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
Subject: [RFC PATCH 4/5] mm/page_idle: Avoid interferences from concurrent users
Date:   Mon, 28 Sep 2020 12:35:27 +0200
Message-ID: <20200928103528.4256-5-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200928103528.4256-1-sjpark@amazon.com>
References: <20200928103528.4256-1-sjpark@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.161.237]
X-ClientProxiedBy: EX13D10UWA003.ant.amazon.com (10.43.160.248) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

Concurrent Idle Page Tracking users can interfere each other because the
interface doesn't provide a central rule for synchronization between the
users.  Users could implement their own synchronization rule, but even
in that case, applications developed by different users would not know
how to synchronize with others.  To help this situation, this commit
introduces a centralized synchronization infrastructure of Idle Page
Tracking.

In detail, this commit introduces a mutex lock for Idle Page Tracking,
called 'page_idle_lock'.  It is exposed to user space via a new bool
sysfs file, '/sys/kernel/mm/page_idle/lock'.  By writing to and reading
from the file, users can hold/release and read status of the mutex.
Writes to the Idle Page Tracking 'bitmap' file fails if the lock is not
held, while reads of the file can be done regardless of the lock status.

Note that users could still interfere each other if they abuse this
locking rule.  Nevertheless, this change will let them notice the rule.

Signed-off-by: SeongJae Park <sjpark@amazon.de>
---
 .../admin-guide/mm/idle_page_tracking.rst     | 22 +++++++---
 mm/page_idle.c                                | 40 +++++++++++++++++++
 2 files changed, 56 insertions(+), 6 deletions(-)

diff --git a/Documentation/admin-guide/mm/idle_page_tracking.rst b/Documentation/admin-guide/mm/idle_page_tracking.rst
index df9394fb39c2..3f5e7a8b5b78 100644
--- a/Documentation/admin-guide/mm/idle_page_tracking.rst
+++ b/Documentation/admin-guide/mm/idle_page_tracking.rst
@@ -21,13 +21,13 @@ User API
 ========
 
 The idle page tracking API is located at ``/sys/kernel/mm/page_idle``.
-Currently, it consists of the only read-write file,
-``/sys/kernel/mm/page_idle/bitmap``.
+Currently, it consists of two read-write file,
+``/sys/kernel/mm/page_idle/bitmap`` and ``/sys/kernel/mm/page_idle/lock``.
 
-The file implements a bitmap where each bit corresponds to a memory page. The
-bitmap is represented by an array of 8-byte integers, and the page at PFN #i is
-mapped to bit #i%64 of array element #i/64, byte order is native. When a bit is
-set, the corresponding page is idle.
+The ``bitmap`` file implements a bitmap where each bit corresponds to a memory
+page. The bitmap is represented by an array of 8-byte integers, and the page at
+PFN #i is mapped to bit #i%64 of array element #i/64, byte order is native.
+When a bit is set, the corresponding page is idle.
 
 A page is considered idle if it has not been accessed since it was marked idle
 (for more details on what "accessed" actually means see the :ref:`Implementation
@@ -74,6 +74,16 @@ See :ref:`Documentation/admin-guide/mm/pagemap.rst <pagemap>` for more
 information about ``/proc/pid/pagemap``, ``/proc/kpageflags``, and
 ``/proc/kpagecgroup``.
 
+The ``lock`` file is for avoidance of interference from concurrent users.  If
+the content of the ``lock`` file is ``1``, it means the ``bitmap`` file is
+currently being used by someone.  While the content of the ``lock`` file is
+``1``, writing ``1`` to the file fails.  Therefore, users should first
+successfully write ``1`` to the ``lock`` file before starting use of ``bitmap``
+file and write ``0`` to the ``lock`` file after they finished use of the
+``bitmap`` file.  If a user writes the ``bitmap`` file while the ``lock`` is
+``0``, the write fails.  Meanwhile, reads of the ``bitmap`` file success
+regardless of the ``lock`` status.
+
 .. _impl_details:
 
 Implementation Details
diff --git a/mm/page_idle.c b/mm/page_idle.c
index 144fb4ed961d..0aa45f848570 100644
--- a/mm/page_idle.c
+++ b/mm/page_idle.c
@@ -16,6 +16,8 @@
 #define BITMAP_CHUNK_SIZE	sizeof(u64)
 #define BITMAP_CHUNK_BITS	(BITMAP_CHUNK_SIZE * BITS_PER_BYTE)
 
+static DEFINE_MUTEX(page_idle_lock);
+
 /*
  * Idle page tracking only considers user memory pages, for other types of
  * pages the idle flag is always unset and an attempt to set it is silently
@@ -169,6 +171,9 @@ static ssize_t page_idle_bitmap_write(struct file *file, struct kobject *kobj,
 	unsigned long pfn, end_pfn;
 	int bit;
 
+	if (!mutex_is_locked(&page_idle_lock))
+		return -EPERM;
+
 	if (pos % BITMAP_CHUNK_SIZE || count % BITMAP_CHUNK_SIZE)
 		return -EINVAL;
 
@@ -197,17 +202,52 @@ static ssize_t page_idle_bitmap_write(struct file *file, struct kobject *kobj,
 	return (char *)in - buf;
 }
 
+static ssize_t page_idle_lock_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	return sprintf(buf, "%d\n", mutex_is_locked(&page_idle_lock));
+}
+
+static ssize_t page_idle_lock_store(struct kobject *kobj,
+		struct kobj_attribute *attr, const char *buf, size_t count)
+{
+	bool do_lock;
+	int ret;
+
+	ret = kstrtobool(buf, &do_lock);
+	if (ret < 0)
+		return ret;
+
+	if (do_lock) {
+		if (!mutex_trylock(&page_idle_lock))
+			return -EBUSY;
+	} else {
+		mutex_unlock(&page_idle_lock);
+	}
+
+	return count;
+}
+
 static struct bin_attribute page_idle_bitmap_attr =
 		__BIN_ATTR(bitmap, 0600,
 			   page_idle_bitmap_read, page_idle_bitmap_write, 0);
 
+static struct kobj_attribute page_idle_lock_attr =
+		__ATTR(lock, 0600, page_idle_lock_show, page_idle_lock_store);
+
 static struct bin_attribute *page_idle_bin_attrs[] = {
 	&page_idle_bitmap_attr,
 	NULL,
 };
 
+static struct attribute *page_idle_lock_attrs[] = {
+	&page_idle_lock_attr.attr,
+	NULL,
+};
+
 static const struct attribute_group page_idle_attr_group = {
 	.bin_attrs = page_idle_bin_attrs,
+	.attrs = page_idle_lock_attrs,
 	.name = "page_idle",
 };
 
-- 
2.17.1

