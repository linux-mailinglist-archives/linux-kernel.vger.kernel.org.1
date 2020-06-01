Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47C6E1EA75A
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jun 2020 17:52:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728120AbgFAPvy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Jun 2020 11:51:54 -0400
Received: from mga02.intel.com ([134.134.136.20]:23579 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726075AbgFAPvy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 11:51:54 -0400
IronPort-SDR: orH7nET1FFlyrmX0oIRdPYWt3Lv5j0YrL2YOq+K5QmzEqQBmFwpiGENUdcjN4BmVoLzHIj+Ebx
 xIjIZsI918eA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2020 08:51:53 -0700
IronPort-SDR: CoTntLLfTHf6yTa3VfNwPg4rBg+K37HUe0buOAYWs4DRLvuNuq+Aa0pXGXzT78QD1nCuAwNdnW
 05kzT6cBRYGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,461,1583222400"; 
   d="scan'208";a="444334490"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga005.jf.intel.com with ESMTP; 01 Jun 2020 08:51:53 -0700
Received: from [10.249.230.65] (abudanko-mobl.ccr.corp.intel.com [10.249.230.65])
        by linux.intel.com (Postfix) with ESMTP id D7AA8580378;
        Mon,  1 Jun 2020 08:51:51 -0700 (PDT)
Subject: [PATCH v5 02/13] perf evlist: introduce control file descriptors
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <e5cac8dd-7aa4-ec7c-671c-07756907acba@linux.intel.com>
Organization: Intel Corp.
Message-ID: <db5482d7-7906-6ccf-c851-e40505f2618f@linux.intel.com>
Date:   Mon, 1 Jun 2020 18:51:50 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <e5cac8dd-7aa4-ec7c-671c-07756907acba@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Define and initialize control file descriptors.

Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
---
 tools/perf/util/evlist.c | 3 +++
 tools/perf/util/evlist.h | 5 +++++
 2 files changed, 8 insertions(+)

diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 173b4f0e0e6e..47541b5cab46 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -63,6 +63,9 @@ void evlist__init(struct evlist *evlist, struct perf_cpu_map *cpus,
 	perf_evlist__set_maps(&evlist->core, cpus, threads);
 	evlist->workload.pid = -1;
 	evlist->bkw_mmap_state = BKW_MMAP_NOTREADY;
+	evlist->ctl_fd.fd = -1;
+	evlist->ctl_fd.ack = -1;
+	evlist->ctl_fd.pos = -1;
 }
 
 struct evlist *evlist__new(void)
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index b6f325dfb4d2..0d8b361f1c8e 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -74,6 +74,11 @@ struct evlist {
 		pthread_t		th;
 		volatile int		done;
 	} thread;
+	struct {
+		int	fd;
+		int	ack;
+		int	pos;
+	} ctl_fd;
 };
 
 struct evsel_str_handler {
-- 
2.24.1

