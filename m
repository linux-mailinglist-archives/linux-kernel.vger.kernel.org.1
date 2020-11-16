Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 027912B438E
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 13:20:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730046AbgKPMUd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 07:20:33 -0500
Received: from mga06.intel.com ([134.134.136.31]:52142 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729933AbgKPMUd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 07:20:33 -0500
IronPort-SDR: 8l7/FAT0guZeYp8D6Lq33kOLrdPiDr+S7UpZGluJSi+Sk1qba/W8pzx0SO2dPRnxNqgeEUm+U0
 SQN7fjlkd2tg==
X-IronPort-AV: E=McAfee;i="6000,8403,9806"; a="232353911"
X-IronPort-AV: E=Sophos;i="5.77,482,1596524400"; 
   d="scan'208";a="232353911"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2020 04:20:31 -0800
IronPort-SDR: hQJs8K6uQpuZWOEnXMO48JWE3TaPEGL2D/mBJiVYlwrJBsjt0hUjCN5KDv8QvOyPD1OVOBSOgz
 16BHPESwuMoQ==
X-IronPort-AV: E=Sophos;i="5.77,482,1596524400"; 
   d="scan'208";a="543583840"
Received: from abudanko-mobl.ccr.corp.intel.com (HELO [10.249.228.209]) ([10.249.228.209])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2020 04:20:28 -0800
Subject: [PATCH v3 08/12] perf record: introduce --threads=<spec> command line
 option
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
Message-ID: <e9a74675-7323-14f4-ce60-32fa1e019111@linux.intel.com>
Date:   Mon, 16 Nov 2020 15:20:26 +0300
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


Provide --threads option in perf record command line interface.
The option can have a value in the form of masks that specify
cpus to be monitored with data streaming threads and its layout
in system topology. The masks can be filtered using cpu mask
provided via -C option.

The specification value can be user defined list of masks. Masks
separated by colon define cpus to be monitored by one thread and
affinity mask of that thread is separated by slash. For example:
<cpus mask 1>/<affinity mask 1>:<cpu mask 2>/<affinity mask 2>
specifies parallel threads layout that consists of two threads
with corresponding assigned cpus to be monitored.

The specification value can be a string e.g. "cpu", "core" or
"socket" meaning creation of data streaming thread for every
cpu or core or socket to monitor distinct cpus or cpus grouped
by core or socket.

The option provided with no or empty value defaults to per-cpu
parallel threads layout creating data streaming thread for every
cpu being monitored.

Feature design and implementation are based on prototypes [1], [2].

[1] git clone https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git -b perf/record_threads
[2] https://lore.kernel.org/lkml/20180913125450.21342-1-jolsa@kernel.org/

Suggested-by: Jiri Olsa <jolsa@kernel.org>
Suggested-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
---
 tools/include/linux/bitmap.h |  11 ++
 tools/lib/bitmap.c           |  14 ++
 tools/perf/builtin-record.c  | 308 ++++++++++++++++++++++++++++++++++-
 tools/perf/util/record.h     |   1 +
 4 files changed, 332 insertions(+), 2 deletions(-)

diff --git a/tools/include/linux/bitmap.h b/tools/include/linux/bitmap.h
index 477a1cae513f..2eb1d1084543 100644
--- a/tools/include/linux/bitmap.h
+++ b/tools/include/linux/bitmap.h
@@ -18,6 +18,8 @@ int __bitmap_and(unsigned long *dst, const unsigned long *bitmap1,
 int __bitmap_equal(const unsigned long *bitmap1,
 		   const unsigned long *bitmap2, unsigned int bits);
 void bitmap_clear(unsigned long *map, unsigned int start, int len);
+int __bitmap_intersects(const unsigned long *bitmap1,
+			const unsigned long *bitmap2, unsigned int bits);
 
 #define BITMAP_FIRST_WORD_MASK(start) (~0UL << ((start) & (BITS_PER_LONG - 1)))
 
@@ -178,4 +180,13 @@ static inline int bitmap_equal(const unsigned long *src1,
 	return __bitmap_equal(src1, src2, nbits);
 }
 
+static inline int bitmap_intersects(const unsigned long *src1,
+			const unsigned long *src2, unsigned int nbits)
+{
+	if (small_const_nbits(nbits))
+		return ((*src1 & *src2) & BITMAP_LAST_WORD_MASK(nbits)) != 0;
+	else
+		return __bitmap_intersects(src1, src2, nbits);
+}
+
 #endif /* _PERF_BITOPS_H */
diff --git a/tools/lib/bitmap.c b/tools/lib/bitmap.c
index 5043747ef6c5..3cc3a5b43bb5 100644
--- a/tools/lib/bitmap.c
+++ b/tools/lib/bitmap.c
@@ -86,3 +86,17 @@ int __bitmap_equal(const unsigned long *bitmap1,
 
 	return 1;
 }
+
+int __bitmap_intersects(const unsigned long *bitmap1,
+			const unsigned long *bitmap2, unsigned int bits)
+{
+	unsigned int k, lim = bits/BITS_PER_LONG;
+	for (k = 0; k < lim; ++k)
+		if (bitmap1[k] & bitmap2[k])
+			return 1;
+
+	if (bits % BITS_PER_LONG)
+		if ((bitmap1[k] & bitmap2[k]) & BITMAP_LAST_WORD_MASK(bits))
+			return 1;
+	return 0;
+}
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index f5e5175da6a1..fd0587d636b2 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -49,6 +49,7 @@
 #include "util/clockid.h"
 #include "asm/bug.h"
 #include "perf.h"
+#include "cputopo.h"
 
 #include <errno.h>
 #include <inttypes.h>
@@ -121,6 +122,20 @@ static const char *thread_msg_tags[THREAD_MSG__MAX] = {
 	"UNDEFINED", "READY"
 };
 
+enum thread_spec {
+	THREAD_SPEC__UNDEFINED = 0,
+	THREAD_SPEC__CPU,
+	THREAD_SPEC__CORE,
+	THREAD_SPEC__SOCKET,
+	THREAD_SPEC__NUMA,
+	THREAD_SPEC__USER,
+	THREAD_SPEC__MAX,
+};
+
+static const char *thread_spec_tags[THREAD_SPEC__MAX] = {
+	"undefined", "cpu", "core", "socket", "numa", "user"
+};
+
 struct record {
 	struct perf_tool	tool;
 	struct record_opts	opts;
@@ -2660,6 +2675,64 @@ static void record__thread_mask_free(struct thread_mask *mask)
 	record__mmap_cpu_mask_free(&mask->affinity);
 }
 
+static int record__thread_mask_or(struct thread_mask *dest, struct thread_mask *src1,
+				   struct thread_mask *src2)
+{
+	if (src1->maps.nbits != src2->maps.nbits || src1->affinity.nbits != src2->affinity.nbits ||
+	    dest->maps.nbits != src1->maps.nbits || dest->affinity.nbits != src1->affinity.nbits)
+		return -EINVAL;
+
+	bitmap_or(dest->maps.bits, src1->maps.bits, src2->maps.bits, src1->maps.nbits);
+	bitmap_or(dest->affinity.bits, src1->affinity.bits, src2->affinity.bits, src1->affinity.nbits);
+
+	return 0;
+}
+
+static int record__thread_mask_intersects(struct thread_mask *mask_1, struct thread_mask *mask_2)
+{
+	int res1, res2;
+
+	if (mask_1->maps.nbits != mask_2->maps.nbits || mask_1->affinity.nbits != mask_2->affinity.nbits)
+		return -EINVAL;
+
+	res1 = bitmap_intersects(mask_1->maps.bits, mask_2->maps.bits, mask_1->maps.nbits);
+	res2 = bitmap_intersects(mask_1->affinity.bits, mask_2->affinity.bits, mask_1->affinity.nbits);
+	if (res1 || res2)
+		return 1;
+
+	return 0;
+}
+
+static int record__parse_threads(const struct option *opt, const char *str, int unset)
+{
+	int s;
+	struct record_opts *opts = opt->value;
+
+	if (unset || !str || !strlen(str)) {
+		opts->threads_spec = THREAD_SPEC__CPU;
+	} else {
+		for (s = 1; s < THREAD_SPEC__MAX; s++) {
+			if (s == THREAD_SPEC__USER)
+			{
+				opts->threads_user_spec = strdup(str);
+				opts->threads_spec = THREAD_SPEC__USER;
+				break;
+			}
+			if (!strncasecmp(str, thread_spec_tags[s], strlen(thread_spec_tags[s]))) {
+				opts->threads_spec = s;
+				break;
+			}
+		}
+	}
+
+	pr_debug("threads_spec: %s", thread_spec_tags[opts->threads_spec]);
+	if (opts->threads_spec == THREAD_SPEC__USER)
+		pr_debug("=[%s]", opts->threads_user_spec);
+	pr_debug("\n");
+
+	return 0;
+}
+
 static int parse_output_max_size(const struct option *opt,
 				 const char *str, int unset)
 {
@@ -3084,6 +3157,9 @@ static struct option __record_options[] = {
 		     "\t\t\t  Optionally send control command completion ('ack\\n') to ack-fd descriptor.\n"
 		     "\t\t\t  Alternatively, ctl-fifo / ack-fifo will be opened and used as ctl-fd / ack-fd.",
 		      parse_control_option),
+	OPT_CALLBACK_OPTARG(0, "threads", &record.opts, NULL, "spec",
+			    "write collected trace data into several data files using parallel threads",
+			    record__parse_threads),
 	OPT_END()
 };
 
@@ -3097,6 +3173,17 @@ static void record__mmap_cpu_mask_init(struct mmap_cpu_mask *mask, struct perf_c
 		set_bit(cpus->map[c], mask->bits);
 }
 
+static void record__mmap_cpu_mask_init_spec(struct mmap_cpu_mask *mask, char *mask_spec)
+{
+	struct perf_cpu_map *cpus;
+
+	cpus = perf_cpu_map__new(mask_spec);
+	if (cpus) {
+		record__mmap_cpu_mask_init(mask, cpus);
+		free(cpus);
+	}
+}
+
 static int record__alloc_thread_masks(struct record *rec, int nr_threads, int nr_bits)
 {
 	int t, ret;
@@ -3116,6 +3203,196 @@ static int record__alloc_thread_masks(struct record *rec, int nr_threads, int nr
 
 	return 0;
 }
+
+static int record__init_thread_cpu_masks(struct record *rec, struct perf_cpu_map *cpus)
+{
+	int t, ret, nr_cpus = perf_cpu_map__nr(cpus);
+
+	ret = record__alloc_thread_masks(rec, nr_cpus, cpu__max_cpu());
+	if (ret)
+		return ret;
+
+	rec->nr_threads = nr_cpus;
+	pr_debug("threads: nr_threads=%d\n", rec->nr_threads);
+
+	for (t = 0; t < rec->nr_threads; t++) {
+		set_bit(cpus->map[t], rec->thread_masks[t].maps.bits);
+		pr_debug("thread_masks[%d]: maps mask [%d]\n", t, cpus->map[t]);
+		set_bit(cpus->map[t], rec->thread_masks[t].affinity.bits);
+		pr_debug("thread_masks[%d]: affinity mask [%d]\n", t, cpus->map[t]);
+	}
+
+	return 0;
+}
+
+static int record__init_thread_masks_spec(struct record *rec, struct perf_cpu_map *cpus,
+					  char **maps_spec, char **affinity_spec, u32 nr_spec)
+{
+	u32 s;
+	int ret, nr_threads = 0;
+	struct mmap_cpu_mask cpus_mask;
+	struct thread_mask thread_mask, full_mask;
+
+	ret = record__mmap_cpu_mask_alloc(&cpus_mask, cpu__max_cpu());
+	if (ret)
+		return ret;
+	record__mmap_cpu_mask_init(&cpus_mask, cpus);
+	ret = record__thread_mask_alloc(&thread_mask, cpu__max_cpu());
+	if (ret)
+		return ret;
+	ret = record__thread_mask_alloc(&full_mask, cpu__max_cpu());
+	if (ret)
+		return ret;
+	record__thread_mask_clear(&full_mask);
+
+	for (s = 0; s < nr_spec; s++) {
+		record__thread_mask_clear(&thread_mask);
+
+		record__mmap_cpu_mask_init_spec(&thread_mask.maps, maps_spec[s]);
+		record__mmap_cpu_mask_init_spec(&thread_mask.affinity, affinity_spec[s]);
+
+		if (!bitmap_and(thread_mask.maps.bits, thread_mask.maps.bits,
+				cpus_mask.bits, thread_mask.maps.nbits) ||
+		    !bitmap_and(thread_mask.affinity.bits, thread_mask.affinity.bits,
+				cpus_mask.bits, thread_mask.affinity.nbits))
+			continue;
+
+		ret = record__thread_mask_intersects(&thread_mask, &full_mask);
+		if (ret)
+			return ret;
+		record__thread_mask_or(&full_mask, &full_mask, &thread_mask);
+
+		rec->thread_masks = realloc(rec->thread_masks,
+					    (nr_threads + 1) * sizeof(struct thread_mask));
+		if (!rec->thread_masks) {
+			pr_err("Failed to allocate thread masks\n");
+			return -ENOMEM;
+		}
+		rec->thread_masks[nr_threads] = thread_mask;
+		pr_debug("thread_masks[%d]: addr=", nr_threads);
+		mmap_cpu_mask__scnprintf(&rec->thread_masks[nr_threads].maps, "maps");
+		pr_debug("thread_masks[%d]: addr=", nr_threads);
+		mmap_cpu_mask__scnprintf(&rec->thread_masks[nr_threads].affinity, "affinity");
+		nr_threads++;
+		ret = record__thread_mask_alloc(&thread_mask, cpu__max_cpu());
+		if (ret)
+			return ret;
+	}
+
+	rec->nr_threads = nr_threads;
+	pr_debug("threads: nr_threads=%d\n", rec->nr_threads);
+
+	record__mmap_cpu_mask_free(&cpus_mask);
+	record__thread_mask_free(&thread_mask);
+	record__thread_mask_free(&full_mask);
+
+	return 0;
+}
+
+static int record__init_thread_core_masks(struct record *rec, struct perf_cpu_map *cpus)
+{
+	int ret;
+	struct cpu_topology *topo;
+
+	topo = cpu_topology__new();
+	if (!topo)
+		return -EINVAL;
+
+	ret = record__init_thread_masks_spec(rec, cpus, topo->thread_siblings,
+					     topo->thread_siblings, topo->thread_sib);
+	cpu_topology__delete(topo);
+
+	return ret;
+}
+
+static int record__init_thread_socket_masks(struct record *rec, struct perf_cpu_map *cpus)
+{
+	int ret;
+	struct cpu_topology *topo;
+
+	topo = cpu_topology__new();
+	if (!topo)
+		return -EINVAL;
+
+	ret = record__init_thread_masks_spec(rec, cpus, topo->core_siblings,
+					     topo->core_siblings, topo->core_sib);
+	cpu_topology__delete(topo);
+
+	return ret;
+}
+
+static int record__init_thread_numa_masks(struct record *rec, struct perf_cpu_map *cpus)
+{
+	u32 s;
+	int ret;
+	char **spec;
+	struct numa_topology *topo;
+
+	topo = numa_topology__new();
+	if (!topo)
+		return -EINVAL;
+	spec = zalloc(topo->nr * sizeof(char *));
+	if (!spec)
+		return -ENOMEM;
+	for (s = 0; s < topo->nr; s++)
+		spec[s] = topo->nodes[s].cpus;
+
+	ret = record__init_thread_masks_spec(rec, cpus, spec, spec, topo->nr);
+
+	zfree(&spec);
+
+	numa_topology__delete(topo);
+
+	return ret;
+}
+
+static int record__init_thread_user_masks(struct record *rec, struct perf_cpu_map *cpus)
+{
+	int t, ret;
+	u32 s, nr_spec = 0;
+	char **maps_spec = NULL, **affinity_spec = NULL;
+	char *spec, *spec_ptr, *user_spec, *mask, *mask_ptr;
+
+	for (t = 0, user_spec = (char *)rec->opts.threads_user_spec; ;t++, user_spec = NULL) {
+		spec = strtok_r(user_spec, ":", &spec_ptr);
+		if (spec == NULL)
+			break;
+		pr_debug(" spec[%d]: %s\n", t, spec);
+		mask = strtok_r(spec, "/", &mask_ptr);
+		if (mask == NULL)
+			break;
+		pr_debug("  maps mask: %s\n", mask);
+		maps_spec = realloc(maps_spec, (nr_spec + 1) * sizeof(char *));
+		if (!maps_spec) {
+			pr_err("Failed to realloc maps_spec\n");
+			return -ENOMEM;
+		}
+		maps_spec[nr_spec] = strdup(mask);
+		mask = strtok_r(NULL, "/", &mask_ptr);
+		if (mask == NULL)
+			break;
+		pr_debug("  affinity mask: %s\n", mask);
+		affinity_spec = realloc(affinity_spec, (nr_spec + 1) * sizeof(char *));
+		if (!maps_spec) {
+			pr_err("Failed to realloc affinity_spec\n");
+			return -ENOMEM;
+		}
+		affinity_spec[nr_spec] = strdup(mask);
+		nr_spec++;
+	}
+
+	ret = record__init_thread_masks_spec(rec, cpus, maps_spec, affinity_spec, nr_spec);
+
+	for (s = 0; s < nr_spec; s++) {
+		free(maps_spec[s]);
+		free(affinity_spec[s]);
+	}
+	free(affinity_spec);
+	free(maps_spec);
+
+	return ret;
+}
+
 static int record__init_thread_default_masks(struct record *rec, struct perf_cpu_map *cpus)
 {
 	int ret;
@@ -3133,9 +3410,33 @@ static int record__init_thread_default_masks(struct record *rec, struct perf_cpu
 
 static int record__init_thread_masks(struct record *rec)
 {
+	int ret = 0;
 	struct perf_cpu_map *cpus = rec->evlist->core.cpus;
 
-	return record__init_thread_default_masks(rec, cpus);
+	if (!record__threads_enabled(rec))
+		return record__init_thread_default_masks(rec, cpus);
+
+	switch (rec->opts.threads_spec) {
+	case THREAD_SPEC__CPU:
+		ret = record__init_thread_cpu_masks(rec, cpus);
+		break;
+	case THREAD_SPEC__CORE:
+		ret = record__init_thread_core_masks(rec, cpus);
+		break;
+	case THREAD_SPEC__SOCKET:
+		ret = record__init_thread_socket_masks(rec, cpus);
+		break;
+	case THREAD_SPEC__NUMA:
+		ret = record__init_thread_numa_masks(rec, cpus);
+		break;
+	case THREAD_SPEC__USER:
+		ret = record__init_thread_user_masks(rec, cpus);
+		break;
+	default:
+		break;
+	}
+
+	return ret;
 }
 
 static int record__fini_thread_masks(struct record *rec)
@@ -3361,7 +3662,10 @@ int cmd_record(int argc, const char **argv)
 
 	err = record__init_thread_masks(rec);
 	if (err) {
-		pr_err("record__init_thread_masks failed, error %d\n", err);
+		if (err > 0)
+			pr_err("ERROR: parallel data streaming masks (--threads) intersect.\n");
+		else
+			pr_err("record__init_thread_masks failed, error %d\n", err);
 		goto out;
 	}
 
diff --git a/tools/perf/util/record.h b/tools/perf/util/record.h
index 9c13a39cc58f..7f64ff5da2b2 100644
--- a/tools/perf/util/record.h
+++ b/tools/perf/util/record.h
@@ -75,6 +75,7 @@ struct record_opts {
 	int	      ctl_fd_ack;
 	bool	      ctl_fd_close;
 	int	      threads_spec;
+	const char    *threads_user_spec;
 };
 
 extern const char * const *record_usage;
-- 
2.24.1


