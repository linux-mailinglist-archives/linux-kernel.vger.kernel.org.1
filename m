Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5617B26D17D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 05:15:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726126AbgIQDPx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 23:15:53 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:12811 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726002AbgIQDPu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 23:15:50 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 788A67913720DC5DBE00;
        Thu, 17 Sep 2020 11:15:48 +0800 (CST)
Received: from euler.huawei.com (10.175.124.27) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.487.0; Thu, 17 Sep 2020 11:15:41 +0800
From:   Wei Li <liwei391@huawei.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        "Namhyung Kim" <namhyung@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <huawei.libin@huawei.com>,
        <guohanjun@huawei.com>
Subject: [PATCH] Revert "perf report: Treat an argument as a symbol filter"
Date:   Thu, 17 Sep 2020 11:14:14 +0800
Message-ID: <20200917031414.47498-1-liwei391@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.27]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 6db6127c4dad ("perf report: Treat an argument as a symbol
filter"), the only one unrecognized argument for perf-report is treated
as a symbol filter. This is not described in man page nor help info,
and the result is really confusing, especially when it's misspecified by
the user (e.g. missing -i for perf.data).

As we can use "--symbol-filter=" if we really want to filter a symbol,
it may be better to revert this misfeature.

Signed-off-by: Wei Li <liwei391@huawei.com>
---
 tools/perf/builtin-report.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 3c74c9c0f3c3..f57ebc1bcd20 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -1317,13 +1317,9 @@ int cmd_report(int argc, const char **argv)
 	argc = parse_options(argc, argv, options, report_usage, 0);
 	if (argc) {
 		/*
-		 * Special case: if there's an argument left then assume that
-		 * it's a symbol filter:
+		 * Any (unrecognized) arguments left?
 		 */
-		if (argc > 1)
-			usage_with_options(report_usage, options);
-
-		report.symbol_filter_str = argv[0];
+		usage_with_options(report_usage, options);
 	}
 
 	if (annotate_check_args(&report.annotation_opts) < 0)
-- 
2.17.1

