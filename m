Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C55F1CF3DE
	for <lists+linux-kernel@lfdr.de>; Tue, 12 May 2020 13:57:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729769AbgELL5S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 May 2020 07:57:18 -0400
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:63192 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726891AbgELL5R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 07:57:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1589284637; x=1620820637;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=TuErZGYEF/r+cILDRcbHLjrkMjcNpTWU7RttOJ6Gqis=;
  b=mBs0GJsNyuzO/StSCI01xvHXeUhFVw4n+11n9+uxxnpLkZPMKdR+SsgS
   27nyISLACZM7CDuqzoVPzd7MGPggeLmYZghlKFwX0tfDwfwKh1i38YO57
   MTZOu9UaPOF29FE7YY9bPThNZYv8XKhoGYDYjQlK46y89dp5RvrlRDp/F
   Q=;
IronPort-SDR: VWl3qAAAXMla1WDe1JTw39mfWCZTOKYjyvjS9Ed/vVzmlphe9r23FiDhX2eydYmwDFUa0I5jXn
 TC315Tp7TifQ==
X-IronPort-AV: E=Sophos;i="5.73,383,1583193600"; 
   d="scan'208";a="29889184"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2c-168cbb73.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP; 12 May 2020 11:57:13 +0000
Received: from EX13MTAUEA002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2c-168cbb73.us-west-2.amazon.com (Postfix) with ESMTPS id 3AF73A2125;
        Tue, 12 May 2020 11:57:10 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 12 May 2020 11:57:09 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.160.100) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 12 May 2020 11:56:54 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     <akpm@linux-foundation.org>
CC:     SeongJae Park <sjpark@amazon.de>, <Jonathan.Cameron@Huawei.com>,
        <aarcange@redhat.com>, <acme@kernel.org>,
        <alexander.shishkin@linux.intel.com>, <amit@kernel.org>,
        <benh@kernel.crashing.org>, <brendan.d.gregg@gmail.com>,
        <brendanhiggins@google.com>, <cai@lca.pw>,
        <colin.king@canonical.com>, <corbet@lwn.net>, <dwmw@amazon.com>,
        <irogers@google.com>, <jolsa@redhat.com>, <kirill@shutemov.name>,
        <mark.rutland@arm.com>, <mgorman@suse.de>, <minchan@kernel.org>,
        <mingo@redhat.com>, <namhyung@kernel.org>, <peterz@infradead.org>,
        <rdunlap@infradead.org>, <riel@surriel.com>, <rientjes@google.com>,
        <rostedt@goodmis.org>, <sblbir@amazon.com>, <shakeelb@google.com>,
        <shuah@kernel.org>, <sj38.park@gmail.com>, <snu@amazon.de>,
        <vbabka@suse.cz>, <vdavydov.dev@gmail.com>,
        <yang.shi@linux.alibaba.com>, <ying.huang@intel.com>,
        <linux-damon@amazon.com>, <linux-mm@kvack.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [RFC v8 5/8] mm/damon-test: Add kunit test case for regions age accounting
Date:   Tue, 12 May 2020 13:53:40 +0200
Message-ID: <20200512115343.27699-6-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200512115343.27699-1-sjpark@amazon.com>
References: <20200512115343.27699-1-sjpark@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.160.100]
X-ClientProxiedBy: EX13D17UWB003.ant.amazon.com (10.43.161.42) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

After merges of regions, each region should know their last shape in
proper way to measure the changes from the last modification and reset
the age if the changes are significant.  This commit adds kunit test
cases checking whether the regions are knowing their last shape properly
after merges of regions.

Signed-off-by: SeongJae Park <sjpark@amazon.de>
Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
---
 mm/damon-test.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/mm/damon-test.h b/mm/damon-test.h
index 851c2062a480..c7a7f3b9b57f 100644
--- a/mm/damon-test.h
+++ b/mm/damon-test.h
@@ -551,6 +551,8 @@ static void damon_test_merge_regions_of(struct kunit *test)
 
 	unsigned long saddrs[] = {0, 114, 130, 156, 170};
 	unsigned long eaddrs[] = {112, 130, 156, 170, 230};
+	unsigned long lsa[] = {0, 114, 130, 156, 184};
+	unsigned long lea[] = {100, 122, 156, 170, 230};
 	int i;
 
 	t = damon_new_task(42);
@@ -567,6 +569,9 @@ static void damon_test_merge_regions_of(struct kunit *test)
 		r = __nth_region_of(t, i);
 		KUNIT_EXPECT_EQ(test, r->vm_start, saddrs[i]);
 		KUNIT_EXPECT_EQ(test, r->vm_end, eaddrs[i]);
+		KUNIT_EXPECT_EQ(test, r->last_vm_start, lsa[i]);
+		KUNIT_EXPECT_EQ(test, r->last_vm_end, lea[i]);
+
 	}
 	damon_free_task(t);
 }
-- 
2.17.1

