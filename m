Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 567BC2DC0E8
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 14:16:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726255AbgLPNPn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 08:15:43 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:9456 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726137AbgLPNPn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 08:15:43 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4CwwZZ3LRWzhr76;
        Wed, 16 Dec 2020 21:14:30 +0800 (CST)
Received: from ubuntu.network (10.175.138.68) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.498.0; Wed, 16 Dec 2020 21:14:54 +0800
From:   Zheng Yongjun <zhengyongjun3@huawei.com>
To:     <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <linux-kernel@vger.kernel.org>
CC:     Zheng Yongjun <zhengyongjun3@huawei.com>
Subject: [PATCH -next] tools: perf: convert comma to semicolon
Date:   Wed, 16 Dec 2020 21:15:26 +0800
Message-ID: <20201216131526.14665-1-zhengyongjun3@huawei.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.138.68]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace a comma between expression statements by a semicolon.

Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>
---
 tools/perf/builtin-diff.c         | 4 ++--
 tools/perf/builtin-inject.c       | 2 +-
 tools/perf/ui/browsers/annotate.c | 2 +-
 tools/perf/util/annotate.c        | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/perf/builtin-diff.c b/tools/perf/builtin-diff.c
index cefc71506409..9064419b108f 100644
--- a/tools/perf/builtin-diff.c
+++ b/tools/perf/builtin-diff.c
@@ -1912,8 +1912,8 @@ static int data_init(int argc, const char **argv)
 		struct perf_data *data = &d->data;
 
 		data->path  = use_default ? defaults[i] : argv[i];
-		data->mode  = PERF_DATA_MODE_READ,
-		data->force = force,
+		data->mode  = PERF_DATA_MODE_READ;
+		data->force = force;
 
 		d->idx  = i;
 	}
diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index 0462dc8db2e3..235a91a907fd 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -747,7 +747,7 @@ static int __cmd_inject(struct perf_inject *inject)
 		inject->tool.auxtrace_info  = perf_event__process_auxtrace_info;
 		inject->tool.auxtrace	    = perf_event__process_auxtrace;
 		inject->tool.aux	    = perf_event__drop_aux;
-		inject->tool.itrace_start   = perf_event__drop_aux,
+		inject->tool.itrace_start   = perf_event__drop_aux;
 		inject->tool.ordered_events = true;
 		inject->tool.ordering_requires_timestamps = true;
 		/* Allow space in the header for new attributes */
diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
index bd77825fd5a1..3d857b1e0e62 100644
--- a/tools/perf/ui/browsers/annotate.c
+++ b/tools/perf/ui/browsers/annotate.c
@@ -928,7 +928,7 @@ int symbol__tui_annotate(struct map_symbol *ms, struct evsel *evsel,
 
 	browser.b.width = notes->max_line_len;
 	browser.b.nr_entries = notes->nr_entries;
-	browser.b.entries = &notes->src->source,
+	browser.b.entries = &notes->src->source;
 	browser.b.width += 18; /* Percentage */
 
 	if (notes->options->hide_src_code)
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 6c8575e182ed..3b4663f8229e 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -367,7 +367,7 @@ static int jump__parse(struct arch *arch, struct ins_operands *ops, struct map_s
 	}
 
 	target.addr = map__objdump_2mem(map, ops->target.addr);
-	start = map->unmap_ip(map, sym->start),
+	start = map->unmap_ip(map, sym->start);
 	end = map->unmap_ip(map, sym->end);
 
 	ops->target.outside = target.addr < start || target.addr > end;
-- 
2.22.0

