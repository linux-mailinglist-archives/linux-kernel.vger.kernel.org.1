Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73306247F67
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Aug 2020 09:27:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbgHRH1L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Aug 2020 03:27:11 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:19919 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726343AbgHRH1D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 03:27:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1597735622; x=1629271622;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=IDHkic1gYAf9g3QrAFwx1LEoduynRqvj1VEruhEXvww=;
  b=PPgev+ZQlHZYmhPlZ4sRv4XlmQ5EqQZs6dVKc/z8QNvp+94RHFNyDaZn
   fsFE7uPIgvJd/71x3Ntoy7gpR+Tu/6oEqKEzBKo4dGfI0bnXP6pkR0qQy
   FHx64yd9mqBYNzdGgGrkYZvJCTEvDQ3wETEk4QmBdP32TxEMMkvM9ooyg
   g=;
X-IronPort-AV: E=Sophos;i="5.76,326,1592870400"; 
   d="scan'208";a="68776218"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1a-67b371d8.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 18 Aug 2020 07:26:59 +0000
Received: from EX13MTAUEA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1a-67b371d8.us-east-1.amazon.com (Postfix) with ESMTPS id 9F35AA1E78;
        Tue, 18 Aug 2020 07:26:47 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 18 Aug 2020 07:26:46 +0000
Received: from u3f2cd687b01c55.ant.amazon.com (10.43.162.73) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 18 Aug 2020 07:26:30 +0000
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
        <zgf574564920@gmail.com>, <linux-damon@amazon.com>,
        <linux-mm@kvack.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [RFC v7 04/10] selftests/damon/_chk_record: Do not check number of gaps
Date:   Tue, 18 Aug 2020 09:24:55 +0200
Message-ID: <20200818072501.30396-5-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200818072501.30396-1-sjpark@amazon.com>
References: <20200818072501.30396-1-sjpark@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.162.73]
X-ClientProxiedBy: EX13D38UWB002.ant.amazon.com (10.43.161.171) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

Now the regions can be explicitly set as users want.  Therefore checking
the number of gaps doesn't make sense.  Remove the condition.

Signed-off-by: SeongJae Park <sjpark@amazon.de>
---
 tools/testing/selftests/damon/_chk_record.py | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/tools/testing/selftests/damon/_chk_record.py b/tools/testing/selftests/damon/_chk_record.py
index 73e128904319..5f11be64abed 100644
--- a/tools/testing/selftests/damon/_chk_record.py
+++ b/tools/testing/selftests/damon/_chk_record.py
@@ -37,12 +37,9 @@ def chk_task_info(f):
         print('too many regions: %d > %d' % (nr_regions, max_nr_regions))
         exit(1)
 
-    nr_gaps = 0
     eaddr = 0
     for r in range(nr_regions):
         saddr = struct.unpack('L', f.read(8))[0]
-        if eaddr and saddr != eaddr:
-            nr_gaps += 1
         eaddr = struct.unpack('L', f.read(8))[0]
         nr_accesses = struct.unpack('I', f.read(4))[0]
 
@@ -56,9 +53,6 @@ def chk_task_info(f):
                 print('too high nr_access: expected %d but %d' %
                         (max_nr_accesses, nr_accesses))
                 exit(1)
-    if nr_gaps != 2:
-        print('number of gaps are not two but %d' % nr_gaps)
-        exit(1)
 
 def parse_time_us(bindat):
     sec = struct.unpack('l', bindat[0:8])[0]
-- 
2.17.1

