Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A2C72B436C
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 13:16:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729918AbgKPMO5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 07:14:57 -0500
Received: from mga07.intel.com ([134.134.136.100]:32675 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727895AbgKPMO5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 07:14:57 -0500
IronPort-SDR: voSIYMugpXKQtIK4VUEV7E1cpsHft+qPBi6MFalRijbhkVvjkgZu04qjWnqPf2bhpbzqeLKQK1
 ndRgHYWC/6dA==
X-IronPort-AV: E=McAfee;i="6000,8403,9806"; a="234889752"
X-IronPort-AV: E=Sophos;i="5.77,482,1596524400"; 
   d="scan'208";a="234889752"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2020 04:14:55 -0800
IronPort-SDR: B+3mx4uj/VQNno/47KSRH4PCCVE6HiU6RqcRiXd/e82TH9gIXI0Z49ZqfS5kBLwTC6XV5KVxT/
 PFPijW79kdew==
X-IronPort-AV: E=Sophos;i="5.77,482,1596524400"; 
   d="scan'208";a="543582249"
Received: from abudanko-mobl.ccr.corp.intel.com (HELO [10.249.228.209]) ([10.249.228.209])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2020 04:14:52 -0800
Subject: [PATCH v3 01/12] perf record: introduce thread affinity and mmap
 masks
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Alexander Antonov <alexander.antonov@linux.intel.com>
References: <7d197a2d-56e2-896d-bf96-6de0a4db1fb8@linux.intel.com>
Organization: Intel Corp.
Message-ID: <e92d3f86-baa5-0e62-50bd-151f33969baa@linux.intel.com>
Date:   Mon, 16 Nov 2020 15:14:50 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <7d197a2d-56e2-896d-bf96-6de0a4db1fb8@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Introduce affinity and mmap thread masks. Thread affinity mask
defines cpus that a thread is allowed to run on. Thread maps
mask defines mmap data buffers the thread serves to stream
profiling data from.

Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
---
 tools/perf/builtin-record.c | 116 ++++++++++++++++++++++++++++++++++++
 1 file changed, 116 insertions(+)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index adf311d15d3d..82f009703ad7 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -85,6 +85,11 @@ struct switch_output {
 	int		 cur_file;
 };
 
+struct thread_mask {
+	struct mmap_cpu_mask	maps;
+	struct mmap_cpu_mask	affinity;
+};
+
 struct record {
 	struct perf_tool	tool;
 	struct record_opts	opts;
@@ -108,6 +113,8 @@ struct record {
 	unsigned long long	samples;
 	struct mmap_cpu_mask	affinity_mask;
 	unsigned long		output_max_size;	/* = 0: unlimited */
+	struct thread_mask	*thread_masks;
+	int			nr_threads;
 };
 
 static volatile int done;
@@ -2174,6 +2181,45 @@ static int record__parse_affinity(const struct option *opt, const char *str, int
 	return 0;
 }
 
+static int record__mmap_cpu_mask_alloc(struct mmap_cpu_mask *mask, int nr_bits)
+{
+	mask->nbits = nr_bits;
+	mask->bits = bitmap_alloc(mask->nbits);
+	if (!mask->bits) {
+		pr_err("Failed to allocate mmap_cpu mask\n");
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
+static void record__mmap_cpu_mask_free(struct mmap_cpu_mask *mask)
+{
+	bitmap_free(mask->bits);
+	mask->nbits = 0;
+}
+
+static void record__thread_mask_clear(struct thread_mask *mask)
+{
+	bitmap_zero(mask->maps.bits, mask->maps.nbits);
+	bitmap_zero(mask->affinity.bits, mask->affinity.nbits);
+}
+
+static int record__thread_mask_alloc(struct thread_mask *mask, int nr_bits)
+{
+	if (record__mmap_cpu_mask_alloc(&mask->maps, nr_bits) ||
+	    record__mmap_cpu_mask_alloc(&mask->affinity, nr_bits))
+		return -ENOMEM;
+
+	return 0;
+}
+
+static void record__thread_mask_free(struct thread_mask *mask)
+{
+	record__mmap_cpu_mask_free(&mask->maps);
+	record__mmap_cpu_mask_free(&mask->affinity);
+}
+
 static int parse_output_max_size(const struct option *opt,
 				 const char *str, int unset)
 {
@@ -2603,6 +2649,69 @@ static struct option __record_options[] = {
 
 struct option *record_options = __record_options;
 
+static void record__mmap_cpu_mask_init(struct mmap_cpu_mask *mask, struct perf_cpu_map *cpus)
+{
+	int c;
+
+	for (c = 0; c < cpus->nr; c++)
+		set_bit(cpus->map[c], mask->bits);
+}
+
+static int record__alloc_thread_masks(struct record *rec, int nr_threads, int nr_bits)
+{
+	int t, ret;
+
+	rec->thread_masks = zalloc(nr_threads * sizeof(*(rec->thread_masks)));
+	if (!rec->thread_masks) {
+		pr_err("Failed to allocate thread masks\n");
+		return -ENOMEM;
+	}
+
+	for (t = 0; t < nr_threads; t++) {
+		ret = record__thread_mask_alloc(&rec->thread_masks[t], nr_bits);
+		if (ret)
+			return ret;
+		record__thread_mask_clear(&rec->thread_masks[t]);
+	}
+
+	return 0;
+}
+static int record__init_thread_default_masks(struct record *rec, struct perf_cpu_map *cpus)
+{
+	int ret;
+
+	ret = record__alloc_thread_masks(rec, 1, cpu__max_cpu());
+	if (ret)
+		return ret;
+
+	record__mmap_cpu_mask_init(&rec->thread_masks->maps, cpus);
+
+	rec->nr_threads = 1;
+
+	return 0;
+}
+
+static int record__init_thread_masks(struct record *rec)
+{
+	struct perf_cpu_map *cpus = rec->evlist->core.cpus;
+
+	return record__init_thread_default_masks(rec, cpus);
+}
+
+static int record__fini_thread_masks(struct record *rec)
+{
+	int t;
+
+	for (t = 0; t < rec->nr_threads; t++)
+		record__thread_mask_free(&rec->thread_masks[t]);
+
+	zfree(&rec->thread_masks);
+
+	rec->nr_threads = 0;
+
+	return 0;
+}
+
 int cmd_record(int argc, const char **argv)
 {
 	int err;
@@ -2821,6 +2930,12 @@ int cmd_record(int argc, const char **argv)
 		goto out;
 	}
 
+	err = record__init_thread_masks(rec);
+	if (err) {
+		pr_err("record__init_thread_masks failed, error %d\n", err);
+		goto out;
+	}
+
 	if (rec->opts.nr_cblocks > nr_cblocks_max)
 		rec->opts.nr_cblocks = nr_cblocks_max;
 	pr_debug("nr_cblocks: %d\n", rec->opts.nr_cblocks);
@@ -2839,6 +2954,7 @@ int cmd_record(int argc, const char **argv)
 	symbol__exit();
 	auxtrace_record__free(rec->itr);
 out_opts:
+	record__fini_thread_masks(rec);
 	evlist__close_control(rec->opts.ctl_fd, rec->opts.ctl_fd_ack, &rec->opts.ctl_fd_close);
 	return err;
 }
-- 
2.24.1

