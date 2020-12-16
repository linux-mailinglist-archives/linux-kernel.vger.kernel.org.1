Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 969D12DBDDF
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 10:47:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726123AbgLPJpG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 04:45:06 -0500
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:25103 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725889AbgLPJpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 04:45:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1608111905; x=1639647905;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=IDHkic1gYAf9g3QrAFwx1LEoduynRqvj1VEruhEXvww=;
  b=befzElxL808g/jQcflyfhZxQEx4SsaXgh/CN9GOIsPNkhUSqz2FhWeAL
   tbjRllpZJhAdFW6Id2ELucyZy7Kp7OzkDWw6lOBR/omAicpoyr6x4Bp1S
   2WsLbAyw+1OkFDS/TkQnRIpu/LFWMYLdga54YJE+r/AqOCBM8Kdlz3XdI
   U=;
X-IronPort-AV: E=Sophos;i="5.78,424,1599523200"; 
   d="scan'208";a="69703750"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-2c-579b7f5b.us-west-2.amazon.com) ([10.43.8.2])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP; 16 Dec 2020 09:44:14 +0000
Received: from EX13D31EUA001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-2c-579b7f5b.us-west-2.amazon.com (Postfix) with ESMTPS id 1C7C6A217F;
        Wed, 16 Dec 2020 09:44:14 +0000 (UTC)
Received: from u3f2cd687b01c55.ant.amazon.com (10.43.161.31) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 16 Dec 2020 09:43:56 +0000
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
Subject: [RFC v10 04/13] selftests/damon/_chk_record: Do not check number of gaps
Date:   Wed, 16 Dec 2020 10:42:12 +0100
Message-ID: <20201216094221.11898-5-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201216094221.11898-1-sjpark@amazon.com>
References: <20201216094221.11898-1-sjpark@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.161.31]
X-ClientProxiedBy: EX13D16UWB001.ant.amazon.com (10.43.161.17) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
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

