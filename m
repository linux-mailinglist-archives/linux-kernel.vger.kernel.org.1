Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 222EB1CD1E1
	for <lists+linux-kernel@lfdr.de>; Mon, 11 May 2020 08:34:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728014AbgEKGdx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 May 2020 02:33:53 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:35402 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725916AbgEKGdx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 02:33:53 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id A5A8413641D030E591CA;
        Mon, 11 May 2020 14:33:49 +0800 (CST)
Received: from euler.huawei.com (10.175.100.98) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.487.0; Mon, 11 May 2020 14:33:48 +0800
From:   Wei Li <liwei391@huawei.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        "Namhyung Kim" <namhyung@kernel.org>
CC:     <linux-kernel@vger.kernel.org>
Subject: [PATCH] perf timechart: Remove redundant assignment
Date:   Mon, 11 May 2020 14:33:26 +0800
Message-ID: <20200511063326.27961-1-liwei391@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.100.98]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove redundant assignment, no functional change.

Signed-off-by: Wei Li <liwei391@huawei.com>
---
 tools/perf/builtin-timechart.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/perf/builtin-timechart.c b/tools/perf/builtin-timechart.c
index 9e84fae9b096..5e4f809d7e5d 100644
--- a/tools/perf/builtin-timechart.c
+++ b/tools/perf/builtin-timechart.c
@@ -1149,7 +1149,6 @@ static void draw_io_bars(struct timechart *tchart)
 			}
 
 			svg_box(Y, c->start_time, c->end_time, "process3");
-			sample = c->io_samples;
 			for (sample = c->io_samples; sample; sample = sample->next) {
 				double h = (double)sample->bytes / c->max_bytes;
 
-- 
2.17.1

