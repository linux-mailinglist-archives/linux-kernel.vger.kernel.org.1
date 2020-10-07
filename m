Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8C0A285930
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 09:16:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727756AbgJGHP5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 03:15:57 -0400
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:17138 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727635AbgJGHP4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 03:15:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1602054957; x=1633590957;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=nbNskFUf5I9SudJVFLFnLIHvjIM0C7eogr6WrZtj68U=;
  b=HfWHpnNJJSY3LIr8UNrrt8B7AVTd/ZaAh2qpL07S0E2AYoUFDVbB+BqR
   JE91DGzIOXXwrqO0E6ChUl/gsXhHz6AuWGmavEpL+/hDrOKdpj/gqFP9u
   bccm/ap4BB5ew1xoWoeJQDg2KyK8ArSJfZ54a8+SdGCN/X/1ZvwYJi55z
   w=;
X-IronPort-AV: E=Sophos;i="5.77,345,1596499200"; 
   d="scan'208";a="74032971"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1e-57e1d233.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP; 07 Oct 2020 07:15:53 +0000
Received: from EX13D31EUA004.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
        by email-inbound-relay-1e-57e1d233.us-east-1.amazon.com (Postfix) with ESMTPS id B8F73141641;
        Wed,  7 Oct 2020 07:15:40 +0000 (UTC)
Received: from u3f2cd687b01c55.ant.amazon.com (10.43.162.73) by
 EX13D31EUA004.ant.amazon.com (10.43.165.161) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 7 Oct 2020 07:15:24 +0000
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
Subject: [RFC v9 03/10] damon/dbgfs-test: Add a unit test case for 'init_regions'
Date:   Wed, 7 Oct 2020 09:14:02 +0200
Message-ID: <20201007071409.12174-4-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201007071409.12174-1-sjpark@amazon.com>
References: <20201007071409.12174-1-sjpark@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.162.73]
X-ClientProxiedBy: EX13D31UWA003.ant.amazon.com (10.43.160.130) To
 EX13D31EUA004.ant.amazon.com (10.43.165.161)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

This commit adds another test case for the new feature, 'init_regions'.

Signed-off-by: SeongJae Park <sjpark@amazon.de>
Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
---
 mm/damon/dbgfs-test.h | 55 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/mm/damon/dbgfs-test.h b/mm/damon/dbgfs-test.h
index ce9c6784ad47..2189f8f2a28e 100644
--- a/mm/damon/dbgfs-test.h
+++ b/mm/damon/dbgfs-test.h
@@ -189,12 +189,67 @@ static void damon_dbgfs_test_aggregate(struct kunit *test)
 	damon_destroy_ctx(ctx);
 }
 
+
+static void damon_dbgfs_test_set_init_regions(struct kunit *test)
+{
+	struct damon_ctx *ctx = damon_new_ctx();
+	unsigned long ids[] = {1, 2, 3};
+	/* Each line represents one region in ``<target id> <start> <end>`` */
+	char * const valid_inputs[] = {"2 10 20\n 2   20 30\n2 35 45",
+		"2 10 20\n",
+		"2 10 20\n1 39 59\n1 70 134\n  2  20 25\n",
+		""};
+	/* Reading the file again will show sorted, clean output */
+	char * const valid_expects[] = {"2 10 20\n2 20 30\n2 35 45\n",
+		"2 10 20\n",
+		"1 39 59\n1 70 134\n2 10 20\n2 20 25\n",
+		""};
+	char * const invalid_inputs[] = {"4 10 20\n",	/* target not exists */
+		"2 10 20\n 2 14 26\n",		/* regions overlap */
+		"1 10 20\n2 30 40\n 1 5 8"};	/* not sorted by address */
+	char *input, *expect;
+	int i, rc;
+	char buf[256];
+
+	damon_set_targets(ctx, ids, 3);
+
+	/* Put valid inputs and check the results */
+	for (i = 0; i < ARRAY_SIZE(valid_inputs); i++) {
+		input = valid_inputs[i];
+		expect = valid_expects[i];
+
+		rc = set_init_regions(ctx, input, strnlen(input, 256));
+		KUNIT_EXPECT_EQ(test, rc, 0);
+
+		memset(buf, 0, 256);
+		sprint_init_regions(ctx, buf, 256);
+
+		KUNIT_EXPECT_STREQ(test, (char *)buf, expect);
+	}
+	/* Put invlid inputs and check the return error code */
+	for (i = 0; i < ARRAY_SIZE(invalid_inputs); i++) {
+		input = invalid_inputs[i];
+		pr_info("input: %s\n", input);
+		rc = set_init_regions(ctx, input, strnlen(input, 256));
+		KUNIT_EXPECT_EQ(test, rc, -EINVAL);
+
+		memset(buf, 0, 256);
+		sprint_init_regions(ctx, buf, 256);
+
+		KUNIT_EXPECT_STREQ(test, (char *)buf, "");
+	}
+
+	damon_set_targets(ctx, NULL, 0);
+	damon_destroy_ctx(ctx);
+}
+
 static struct kunit_case damon_test_cases[] = {
 	KUNIT_CASE(damon_dbgfs_test_str_to_target_ids),
 	KUNIT_CASE(damon_dbgfs_test_set_targets),
 	KUNIT_CASE(damon_dbgfs_test_set_recording),
 	KUNIT_CASE(damon_dbgfs_test_write_rbuf),
 	KUNIT_CASE(damon_dbgfs_test_aggregate),
+	KUNIT_CASE(damon_dbgfs_test_set_init_regions),
 	{},
 };
 
-- 
2.17.1

