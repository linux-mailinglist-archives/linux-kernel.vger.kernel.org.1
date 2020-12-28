Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6FB72E69D3
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Dec 2020 18:44:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728533AbgL1RmZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Dec 2020 12:42:25 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:35936 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727739AbgL1Rlx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Dec 2020 12:41:53 -0500
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0BSHXD3P031237
        for <linux-kernel@vger.kernel.org>; Mon, 28 Dec 2020 09:41:09 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=3M1fgFTfdhUxNKn2tU9P/jvl8B345i5Yav7TseVRzdU=;
 b=lCCfJ1fdp4+4f1i/achS7zgDJQj4PGILM0z/aZmcX+1XJ/OypTp2tPBqkqci3HVu0/fM
 e0Q3UjCjmA0+xykpsleidU3ZujRfzPoounIhlYL5DfvwFBDK7oHF3P9bS9e/+LValu6Y
 Ur7x2qaWWLcDBv2l4S2s+B4iPZVYdNP8ZNw= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 35pp3cce5y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 28 Dec 2020 09:41:09 -0800
Received: from intmgw004.08.frc2.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 28 Dec 2020 09:41:09 -0800
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id 9942062E2D4B; Mon, 28 Dec 2020 09:41:06 -0800 (PST)
From:   Song Liu <songliubraving@fb.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <acme@kernel.org>, <peterz@infradead.org>, <mingo@redhat.com>,
        <alexander.shishkin@linux.intel.com>, <namhyung@kernel.org>,
        <mark.rutland@arm.com>, <jolsa@redhat.com>, <kernel-team@fb.com>,
        Song Liu <songliubraving@fb.com>
Subject: [PATCH v6 3/4] perf-stat: enable counting events for BPF programs
Date:   Mon, 28 Dec 2020 09:40:53 -0800
Message-ID: <20201228174054.907740-4-songliubraving@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20201228174054.907740-1-songliubraving@fb.com>
References: <20201228174054.907740-1-songliubraving@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-28_17:2020-12-28,2020-12-28 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 adultscore=0
 clxscore=1015 malwarescore=0 mlxscore=0 phishscore=0 mlxlogscore=999
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 spamscore=0
 bulkscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012280111
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce perf-stat -b option, which counts events for BPF programs, like=
:

[root@localhost ~]# ~/perf stat -e ref-cycles,cycles -b 254 -I 1000
     1.487903822            115,200      ref-cycles
     1.487903822             86,012      cycles
     2.489147029             80,560      ref-cycles
     2.489147029             73,784      cycles
     3.490341825             60,720      ref-cycles
     3.490341825             37,797      cycles
     4.491540887             37,120      ref-cycles
     4.491540887             31,963      cycles

The example above counts cycles and ref-cycles of BPF program of id 254.
This is similar to bpftool-prog-profile command, but more flexible.

perf-stat -b creates per-cpu perf_event and loads fentry/fexit BPF
programs (monitor-progs) to the target BPF program (target-prog). The
monitor-progs read perf_event before and after the target-prog, and
aggregate the difference in a BPF map. Then the user space reads data
from these maps.

A new struct bpf_counter is introduced to provide common interface that
uses BPF programs/maps to count perf events.

Signed-off-by: Song Liu <songliubraving@fb.com>
---
 tools/perf/Makefile.perf                      |   2 +-
 tools/perf/builtin-stat.c                     |  77 ++++-
 tools/perf/util/Build                         |   1 +
 tools/perf/util/bpf_counter.c                 | 296 ++++++++++++++++++
 tools/perf/util/bpf_counter.h                 |  72 +++++
 .../util/bpf_skel/bpf_prog_profiler.bpf.c     |  93 ++++++
 tools/perf/util/evsel.c                       |   9 +
 tools/perf/util/evsel.h                       |   6 +
 tools/perf/util/stat-display.c                |   4 +-
 tools/perf/util/stat.c                        |   2 +-
 tools/perf/util/target.c                      |  34 +-
 tools/perf/util/target.h                      |  10 +
 12 files changed, 588 insertions(+), 18 deletions(-)
 create mode 100644 tools/perf/util/bpf_counter.c
 create mode 100644 tools/perf/util/bpf_counter.h
 create mode 100644 tools/perf/util/bpf_skel/bpf_prog_profiler.bpf.c

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index d182a2dbb9bbd..8c4e039c3b813 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -1015,7 +1015,7 @@ python-clean:
=20
 SKEL_OUT :=3D $(abspath $(OUTPUT)util/bpf_skel)
 SKEL_TMP_OUT :=3D $(abspath $(SKEL_OUT)/.tmp)
-SKELETONS :=3D
+SKELETONS :=3D $(SKEL_OUT)/bpf_prog_profiler.skel.h
=20
 ifdef BUILD_BPF_SKEL
 BPFTOOL :=3D $(SKEL_TMP_OUT)/bootstrap/bpftool
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 8cc24967bc273..09bffb3fbcdd4 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -67,6 +67,7 @@
 #include "util/top.h"
 #include "util/affinity.h"
 #include "util/pfm.h"
+#include "util/bpf_counter.h"
 #include "asm/bug.h"
=20
 #include <linux/time64.h>
@@ -409,12 +410,31 @@ static int read_affinity_counters(struct timespec *=
rs)
 	return 0;
 }
=20
+static int read_bpf_map_counters(void)
+{
+	struct evsel *counter;
+	int err;
+
+	evlist__for_each_entry(evsel_list, counter) {
+		err =3D bpf_counter__read(counter);
+		if (err)
+			return err;
+	}
+	return 0;
+}
+
 static void read_counters(struct timespec *rs)
 {
 	struct evsel *counter;
+	int err;
=20
-	if (!stat_config.stop_read_counter && (read_affinity_counters(rs) < 0))
-		return;
+	if (!stat_config.stop_read_counter) {
+		err =3D read_bpf_map_counters();
+		if (err =3D=3D -EAGAIN)
+			err =3D read_affinity_counters(rs);
+		if (err < 0)
+			return;
+	}
=20
 	evlist__for_each_entry(evsel_list, counter) {
 		if (counter->err)
@@ -496,11 +516,20 @@ static bool handle_interval(unsigned int interval, =
int *times)
 	return false;
 }
=20
-static void enable_counters(void)
+static int enable_counters(void)
 {
+	struct evsel *evsel;
+	int err;
+
+	evlist__for_each_entry(evsel_list, evsel) {
+		err =3D bpf_counter__enable(evsel);
+		if (err)
+			return err;
+	}
+
 	if (stat_config.initial_delay < 0) {
 		pr_info(EVLIST_DISABLED_MSG);
-		return;
+		return 0;
 	}
=20
 	if (stat_config.initial_delay > 0) {
@@ -518,6 +547,7 @@ static void enable_counters(void)
 		if (stat_config.initial_delay > 0)
 			pr_info(EVLIST_ENABLED_MSG);
 	}
+	return 0;
 }
=20
 static void disable_counters(void)
@@ -720,7 +750,7 @@ static int __run_perf_stat(int argc, const char **arg=
v, int run_idx)
 	const bool forks =3D (argc > 0);
 	bool is_pipe =3D STAT_RECORD ? perf_stat.data.is_pipe : false;
 	struct affinity affinity;
-	int i, cpu;
+	int i, cpu, err;
 	bool second_pass =3D false;
=20
 	if (forks) {
@@ -737,6 +767,11 @@ static int __run_perf_stat(int argc, const char **ar=
gv, int run_idx)
 	if (affinity__setup(&affinity) < 0)
 		return -1;
=20
+	evlist__for_each_entry(evsel_list, counter) {
+		if (bpf_counter__load(counter, &target))
+			return -1;
+	}
+
 	evlist__for_each_cpu (evsel_list, i, cpu) {
 		affinity__set(&affinity, cpu);
=20
@@ -850,7 +885,7 @@ static int __run_perf_stat(int argc, const char **arg=
v, int run_idx)
 	}
=20
 	if (STAT_RECORD) {
-		int err, fd =3D perf_data__fd(&perf_stat.data);
+		int fd =3D perf_data__fd(&perf_stat.data);
=20
 		if (is_pipe) {
 			err =3D perf_header__write_pipe(perf_data__fd(&perf_stat.data));
@@ -876,7 +911,9 @@ static int __run_perf_stat(int argc, const char **arg=
v, int run_idx)
=20
 	if (forks) {
 		evlist__start_workload(evsel_list);
-		enable_counters();
+		err =3D enable_counters();
+		if (err)
+			return -1;
=20
 		if (interval || timeout || evlist__ctlfd_initialized(evsel_list))
 			status =3D dispatch_events(forks, timeout, interval, &times);
@@ -895,7 +932,9 @@ static int __run_perf_stat(int argc, const char **arg=
v, int run_idx)
 		if (WIFSIGNALED(status))
 			psignal(WTERMSIG(status), argv[0]);
 	} else {
-		enable_counters();
+		err =3D enable_counters();
+		if (err)
+			return -1;
 		status =3D dispatch_events(forks, timeout, interval, &times);
 	}
=20
@@ -1085,6 +1124,10 @@ static struct option stat_options[] =3D {
 		   "stat events on existing process id"),
 	OPT_STRING('t', "tid", &target.tid, "tid",
 		   "stat events on existing thread id"),
+#ifdef HAVE_BPF_SKEL
+	OPT_STRING('b', "bpf-prog", &target.bpf_str, "bpf-prog-id",
+		   "stat events on existing bpf program id"),
+#endif
 	OPT_BOOLEAN('a', "all-cpus", &target.system_wide,
 		    "system-wide collection from all CPUs"),
 	OPT_BOOLEAN('g', "group", &group,
@@ -2064,11 +2107,12 @@ int cmd_stat(int argc, const char **argv)
 		"perf stat [<options>] [<command>]",
 		NULL
 	};
-	int status =3D -EINVAL, run_idx;
+	int status =3D -EINVAL, run_idx, err;
 	const char *mode;
 	FILE *output =3D stderr;
 	unsigned int interval, timeout;
 	const char * const stat_subcommands[] =3D { "record", "report" };
+	char errbuf[BUFSIZ];
=20
 	setlocale(LC_ALL, "");
=20
@@ -2179,6 +2223,12 @@ int cmd_stat(int argc, const char **argv)
 	} else if (big_num_opt =3D=3D 0) /* User passed --no-big-num */
 		stat_config.big_num =3D false;
=20
+	err =3D target__validate(&target);
+	if (err) {
+		target__strerror(&target, err, errbuf, BUFSIZ);
+		pr_warning("%s\n", errbuf);
+	}
+
 	setup_system_wide(argc);
=20
 	/*
@@ -2252,8 +2302,6 @@ int cmd_stat(int argc, const char **argv)
 		}
 	}
=20
-	target__validate(&target);
-
 	if ((stat_config.aggr_mode =3D=3D AGGR_THREAD) && (target.system_wide))
 		target.per_thread =3D true;
=20
@@ -2384,9 +2432,10 @@ int cmd_stat(int argc, const char **argv)
 		 * tools remain  -acme
 		 */
 		int fd =3D perf_data__fd(&perf_stat.data);
-		int err =3D perf_event__synthesize_kernel_mmap((void *)&perf_stat,
-							     process_synthesized_event,
-							     &perf_stat.session->machines.host);
+
+		err =3D perf_event__synthesize_kernel_mmap((void *)&perf_stat,
+							 process_synthesized_event,
+							 &perf_stat.session->machines.host);
 		if (err) {
 			pr_warning("Couldn't synthesize the kernel mmap record, harmless, "
 				   "older tools may produce warnings about this file\n.");
diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index e2563d0154eb6..188521f343470 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -135,6 +135,7 @@ perf-y +=3D clockid.o
=20
 perf-$(CONFIG_LIBBPF) +=3D bpf-loader.o
 perf-$(CONFIG_LIBBPF) +=3D bpf_map.o
+perf-$(CONFIG_PERF_BPF_SKEL) +=3D bpf_counter.o
 perf-$(CONFIG_BPF_PROLOGUE) +=3D bpf-prologue.o
 perf-$(CONFIG_LIBELF) +=3D symbol-elf.o
 perf-$(CONFIG_LIBELF) +=3D probe-file.o
diff --git a/tools/perf/util/bpf_counter.c b/tools/perf/util/bpf_counter.=
c
new file mode 100644
index 0000000000000..f2cb86a40c882
--- /dev/null
+++ b/tools/perf/util/bpf_counter.c
@@ -0,0 +1,296 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/* Copyright (c) 2019 Facebook */
+
+#include <limits.h>
+#include <unistd.h>
+#include <sys/time.h>
+#include <sys/resource.h>
+#include <linux/err.h>
+#include <linux/zalloc.h>
+#include <bpf/bpf.h>
+#include <bpf/btf.h>
+#include <bpf/libbpf.h>
+
+#include "bpf_counter.h"
+#include "counts.h"
+#include "debug.h"
+#include "evsel.h"
+#include "target.h"
+
+#include "bpf_skel/bpf_prog_profiler.skel.h"
+
+static inline void *u64_to_ptr(__u64 ptr)
+{
+	return (void *)(unsigned long)ptr;
+}
+
+static void set_max_rlimit(void)
+{
+	struct rlimit rinf =3D { RLIM_INFINITY, RLIM_INFINITY };
+
+	setrlimit(RLIMIT_MEMLOCK, &rinf);
+}
+
+static struct bpf_counter *bpf_counter_alloc(void)
+{
+	struct bpf_counter *counter;
+
+	counter =3D zalloc(sizeof(*counter));
+	if (counter)
+		INIT_LIST_HEAD(&counter->list);
+	return counter;
+}
+
+static int bpf_program_profiler__destroy(struct evsel *evsel)
+{
+	struct bpf_counter *counter;
+
+	list_for_each_entry(counter, &evsel->bpf_counter_list, list)
+		bpf_prog_profiler_bpf__destroy(counter->skel);
+	INIT_LIST_HEAD(&evsel->bpf_counter_list);
+	return 0;
+}
+
+static char *bpf_target_prog_name(int tgt_fd)
+{
+	struct bpf_prog_info_linear *info_linear;
+	struct bpf_func_info *func_info;
+	const struct btf_type *t;
+	char *name =3D NULL;
+	struct btf *btf;
+
+	info_linear =3D bpf_program__get_prog_info_linear(
+		tgt_fd, 1UL << BPF_PROG_INFO_FUNC_INFO);
+	if (IS_ERR_OR_NULL(info_linear)) {
+		pr_debug("failed to get info_linear for prog FD %d\n", tgt_fd);
+		return NULL;
+	}
+
+	if (info_linear->info.btf_id =3D=3D 0 ||
+	    btf__get_from_id(info_linear->info.btf_id, &btf)) {
+		pr_debug("prog FD %d doesn't have valid btf\n", tgt_fd);
+		goto out;
+	}
+
+	func_info =3D u64_to_ptr(info_linear->info.func_info);
+	t =3D btf__type_by_id(btf, func_info[0].type_id);
+	if (!t) {
+		pr_debug("btf %d doesn't have type %d\n",
+			 info_linear->info.btf_id, func_info[0].type_id);
+		goto out;
+	}
+	name =3D strdup(btf__name_by_offset(btf, t->name_off));
+out:
+	free(info_linear);
+	return name;
+}
+
+static int bpf_program_profiler_load_one(struct evsel *evsel, u32 prog_i=
d)
+{
+	struct bpf_prog_profiler_bpf *skel;
+	struct bpf_counter *counter;
+	struct bpf_program *prog;
+	char *prog_name;
+	int prog_fd;
+	int err;
+
+	prog_fd =3D bpf_prog_get_fd_by_id(prog_id);
+	if (prog_fd < 0) {
+		pr_err("Failed to open fd for bpf prog %u\n", prog_id);
+		return -1;
+	}
+	counter =3D bpf_counter_alloc();
+	if (!counter) {
+		close(prog_fd);
+		return -1;
+	}
+
+	skel =3D bpf_prog_profiler_bpf__open();
+	if (!skel) {
+		pr_err("Failed to open bpf skeleton\n");
+		goto err_out;
+	}
+	skel->rodata->num_cpu =3D evsel__nr_cpus(evsel);
+
+	bpf_map__resize(skel->maps.events, evsel__nr_cpus(evsel));
+	bpf_map__resize(skel->maps.fentry_readings, 1);
+	bpf_map__resize(skel->maps.accum_readings, 1);
+
+	prog_name =3D bpf_target_prog_name(prog_fd);
+	if (!prog_name) {
+		pr_err("Failed to get program name for bpf prog %u. Does it have BTF?\=
n", prog_id);
+		goto err_out;
+	}
+
+	bpf_object__for_each_program(prog, skel->obj) {
+		err =3D bpf_program__set_attach_target(prog, prog_fd, prog_name);
+		if (err) {
+			pr_err("bpf_program__set_attach_target failed.\n"
+			       "Does bpf prog %u have BTF?\n", prog_id);
+			goto err_out;
+		}
+	}
+	set_max_rlimit();
+	err =3D bpf_prog_profiler_bpf__load(skel);
+	if (err) {
+		pr_err("bpf_prog_profiler_bpf__load failed\n");
+		goto err_out;
+	}
+
+	counter->skel =3D skel;
+	list_add(&counter->list, &evsel->bpf_counter_list);
+	close(prog_fd);
+	return 0;
+err_out:
+	free(counter);
+	close(prog_fd);
+	return -1;
+}
+
+static int bpf_program_profiler__load(struct evsel *evsel, struct target=
 *target)
+{
+	char *bpf_str, *bpf_str_, *tok, *saveptr =3D NULL, *p;
+	u32 prog_id;
+	int ret;
+
+	bpf_str_ =3D bpf_str =3D strdup(target->bpf_str);
+	if (!bpf_str)
+		return -1;
+
+	while ((tok =3D strtok_r(bpf_str, ",", &saveptr)) !=3D NULL) {
+		prog_id =3D strtoul(tok, &p, 10);
+		if (prog_id =3D=3D 0 || prog_id =3D=3D UINT_MAX ||
+		    (*p !=3D '\0' && *p !=3D ',')) {
+			pr_err("Failed to parse bpf prog ids %s\n",
+			       target->bpf_str);
+			return -1;
+		}
+
+		ret =3D bpf_program_profiler_load_one(evsel, prog_id);
+		if (ret) {
+			bpf_program_profiler__destroy(evsel);
+			free(bpf_str_);
+			return -1;
+		}
+		bpf_str =3D NULL;
+	}
+	free(bpf_str_);
+	return 0;
+}
+
+static int bpf_program_profiler__enable(struct evsel *evsel)
+{
+	struct bpf_counter *counter;
+	int ret;
+
+	list_for_each_entry(counter, &evsel->bpf_counter_list, list) {
+		ret =3D bpf_prog_profiler_bpf__attach(counter->skel);
+		if (ret) {
+			bpf_program_profiler__destroy(evsel);
+			return ret;
+		}
+	}
+	return 0;
+}
+
+static int bpf_program_profiler__read(struct evsel *evsel)
+{
+	int num_cpu =3D evsel__nr_cpus(evsel);
+	struct bpf_perf_event_value values[num_cpu];
+	struct bpf_counter *counter;
+	int reading_map_fd;
+	__u32 key =3D 0;
+	int err, cpu;
+
+	if (list_empty(&evsel->bpf_counter_list))
+		return -EAGAIN;
+
+	for (cpu =3D 0; cpu < num_cpu; cpu++) {
+		perf_counts(evsel->counts, cpu, 0)->val =3D 0;
+		perf_counts(evsel->counts, cpu, 0)->ena =3D 0;
+		perf_counts(evsel->counts, cpu, 0)->run =3D 0;
+	}
+	list_for_each_entry(counter, &evsel->bpf_counter_list, list) {
+		struct bpf_prog_profiler_bpf *skel =3D counter->skel;
+
+		reading_map_fd =3D bpf_map__fd(skel->maps.accum_readings);
+
+		err =3D bpf_map_lookup_elem(reading_map_fd, &key, values);
+		if (err) {
+			fprintf(stderr, "failed to read value\n");
+			return err;
+		}
+
+		for (cpu =3D 0; cpu < num_cpu; cpu++) {
+			perf_counts(evsel->counts, cpu, 0)->val +=3D values[cpu].counter;
+			perf_counts(evsel->counts, cpu, 0)->ena +=3D values[cpu].enabled;
+			perf_counts(evsel->counts, cpu, 0)->run +=3D values[cpu].running;
+		}
+	}
+	return 0;
+}
+
+static int bpf_program_profiler__install_pe(struct evsel *evsel, int cpu=
,
+					    int fd)
+{
+	struct bpf_prog_profiler_bpf *skel;
+	struct bpf_counter *counter;
+	int ret;
+
+	list_for_each_entry(counter, &evsel->bpf_counter_list, list) {
+		skel =3D counter->skel;
+		ret =3D bpf_map_update_elem(bpf_map__fd(skel->maps.events),
+					  &cpu, &fd, BPF_ANY);
+		if (ret)
+			return ret;
+	}
+	return 0;
+}
+
+struct bpf_counter_ops bpf_program_profiler_ops =3D {
+	.load       =3D bpf_program_profiler__load,
+	.enable	    =3D bpf_program_profiler__enable,
+	.read       =3D bpf_program_profiler__read,
+	.destroy    =3D bpf_program_profiler__destroy,
+	.install_pe =3D bpf_program_profiler__install_pe,
+};
+
+int bpf_counter__install_pe(struct evsel *evsel, int cpu, int fd)
+{
+	if (list_empty(&evsel->bpf_counter_list))
+		return 0;
+	return evsel->bpf_counter_ops->install_pe(evsel, cpu, fd);
+}
+
+int bpf_counter__load(struct evsel *evsel, struct target *target)
+{
+	if (target__has_bpf(target))
+		evsel->bpf_counter_ops =3D &bpf_program_profiler_ops;
+
+	if (evsel->bpf_counter_ops)
+		return evsel->bpf_counter_ops->load(evsel, target);
+	return 0;
+}
+
+int bpf_counter__enable(struct evsel *evsel)
+{
+	if (list_empty(&evsel->bpf_counter_list))
+		return 0;
+	return evsel->bpf_counter_ops->enable(evsel);
+}
+
+int bpf_counter__read(struct evsel *evsel)
+{
+	if (list_empty(&evsel->bpf_counter_list))
+		return -EAGAIN;
+	return evsel->bpf_counter_ops->read(evsel);
+}
+
+void bpf_counter__destroy(struct evsel *evsel)
+{
+	if (list_empty(&evsel->bpf_counter_list))
+		return;
+	evsel->bpf_counter_ops->destroy(evsel);
+	evsel->bpf_counter_ops =3D NULL;
+}
diff --git a/tools/perf/util/bpf_counter.h b/tools/perf/util/bpf_counter.=
h
new file mode 100644
index 0000000000000..2eca210e5dc16
--- /dev/null
+++ b/tools/perf/util/bpf_counter.h
@@ -0,0 +1,72 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __PERF_BPF_COUNTER_H
+#define __PERF_BPF_COUNTER_H 1
+
+#include <linux/list.h>
+
+struct evsel;
+struct target;
+struct bpf_counter;
+
+typedef int (*bpf_counter_evsel_op)(struct evsel *evsel);
+typedef int (*bpf_counter_evsel_target_op)(struct evsel *evsel,
+					   struct target *target);
+typedef int (*bpf_counter_evsel_install_pe_op)(struct evsel *evsel,
+					       int cpu,
+					       int fd);
+
+struct bpf_counter_ops {
+	bpf_counter_evsel_target_op load;
+	bpf_counter_evsel_op enable;
+	bpf_counter_evsel_op read;
+	bpf_counter_evsel_op destroy;
+	bpf_counter_evsel_install_pe_op install_pe;
+};
+
+struct bpf_counter {
+	void *skel;
+	struct list_head list;
+};
+
+#ifdef HAVE_BPF_SKEL
+
+int bpf_counter__load(struct evsel *evsel, struct target *target);
+int bpf_counter__enable(struct evsel *evsel);
+int bpf_counter__read(struct evsel *evsel);
+void bpf_counter__destroy(struct evsel *evsel);
+int bpf_counter__install_pe(struct evsel *evsel, int cpu, int fd);
+
+#else /* HAVE_BPF_SKEL */
+
+#include<linux/err.h>
+
+static inline int bpf_counter__load(struct evsel *evsel __maybe_unused,
+				    struct target *target __maybe_unused)
+{
+	return 0;
+}
+
+static inline int bpf_counter__enable(struct evsel *evsel __maybe_unused=
)
+{
+	return 0;
+}
+
+static inline int bpf_counter__read(struct evsel *evsel __maybe_unused)
+{
+	return -EAGAIN;
+}
+
+static inline void bpf_counter__destroy(struct evsel *evsel __maybe_unus=
ed)
+{
+}
+
+static inline int bpf_counter__install_pe(struct evsel *evsel __maybe_un=
used,
+					  int cpu __maybe_unused,
+					  int fd __maybe_unused)
+{
+	return 0;
+}
+
+#endif /* HAVE_BPF_SKEL */
+
+#endif /* __PERF_BPF_COUNTER_H */
diff --git a/tools/perf/util/bpf_skel/bpf_prog_profiler.bpf.c b/tools/per=
f/util/bpf_skel/bpf_prog_profiler.bpf.c
new file mode 100644
index 0000000000000..c7cec92d02360
--- /dev/null
+++ b/tools/perf/util/bpf_skel/bpf_prog_profiler.bpf.c
@@ -0,0 +1,93 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+// Copyright (c) 2020 Facebook
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+/* map of perf event fds, num_cpu * num_metric entries */
+struct {
+	__uint(type, BPF_MAP_TYPE_PERF_EVENT_ARRAY);
+	__uint(key_size, sizeof(__u32));
+	__uint(value_size, sizeof(int));
+} events SEC(".maps");
+
+/* readings at fentry */
+struct {
+	__uint(type, BPF_MAP_TYPE_PERCPU_ARRAY);
+	__uint(key_size, sizeof(__u32));
+	__uint(value_size, sizeof(struct bpf_perf_event_value));
+	__uint(max_entries, 1);
+} fentry_readings SEC(".maps");
+
+/* accumulated readings */
+struct {
+	__uint(type, BPF_MAP_TYPE_PERCPU_ARRAY);
+	__uint(key_size, sizeof(__u32));
+	__uint(value_size, sizeof(struct bpf_perf_event_value));
+	__uint(max_entries, 1);
+} accum_readings SEC(".maps");
+
+const volatile __u32 num_cpu =3D 1;
+
+SEC("fentry/XXX")
+int BPF_PROG(fentry_XXX)
+{
+	__u32 key =3D bpf_get_smp_processor_id();
+	struct bpf_perf_event_value *ptr;
+	__u32 zero =3D 0;
+	long err;
+
+	/* look up before reading, to reduce error */
+	ptr =3D bpf_map_lookup_elem(&fentry_readings, &zero);
+	if (!ptr)
+		return 0;
+
+	err =3D bpf_perf_event_read_value(&events, key, ptr, sizeof(*ptr));
+	if (err)
+		return 0;
+
+	return 0;
+}
+
+static inline void
+fexit_update_maps(struct bpf_perf_event_value *after)
+{
+	struct bpf_perf_event_value *before, diff, *accum;
+	__u32 zero =3D 0;
+
+	before =3D bpf_map_lookup_elem(&fentry_readings, &zero);
+	/* only account samples with a valid fentry_reading */
+	if (before && before->counter) {
+		struct bpf_perf_event_value *accum;
+
+		diff.counter =3D after->counter - before->counter;
+		diff.enabled =3D after->enabled - before->enabled;
+		diff.running =3D after->running - before->running;
+
+		accum =3D bpf_map_lookup_elem(&accum_readings, &zero);
+		if (accum) {
+			accum->counter +=3D diff.counter;
+			accum->enabled +=3D diff.enabled;
+			accum->running +=3D diff.running;
+		}
+	}
+}
+
+SEC("fexit/XXX")
+int BPF_PROG(fexit_XXX)
+{
+	struct bpf_perf_event_value reading;
+	__u32 cpu =3D bpf_get_smp_processor_id();
+	__u32 one =3D 1, zero =3D 0;
+	int err;
+
+	/* read all events before updating the maps, to reduce error */
+	err =3D bpf_perf_event_read_value(&events, cpu, &reading, sizeof(readin=
g));
+	if (err)
+		return 0;
+
+	fexit_update_maps(&reading);
+	return 0;
+}
+
+char LICENSE[] SEC("license") =3D "Dual BSD/GPL";
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index c26ea82220bd8..7265308765d73 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -25,6 +25,7 @@
 #include <stdlib.h>
 #include <perf/evsel.h>
 #include "asm/bug.h"
+#include "bpf_counter.h"
 #include "callchain.h"
 #include "cgroup.h"
 #include "counts.h"
@@ -51,6 +52,10 @@
 #include <internal/lib.h>
=20
 #include <linux/ctype.h>
+#include <bpf/bpf.h>
+#include <bpf/libbpf.h>
+#include <bpf/btf.h>
+#include "rlimit.h"
=20
 struct perf_missing_features perf_missing_features;
=20
@@ -247,6 +252,7 @@ void evsel__init(struct evsel *evsel,
 	evsel->bpf_obj	   =3D NULL;
 	evsel->bpf_fd	   =3D -1;
 	INIT_LIST_HEAD(&evsel->config_terms);
+	INIT_LIST_HEAD(&evsel->bpf_counter_list);
 	perf_evsel__object.init(evsel);
 	evsel->sample_size =3D __evsel__sample_size(attr->sample_type);
 	evsel__calc_id_pos(evsel);
@@ -1366,6 +1372,7 @@ void evsel__exit(struct evsel *evsel)
 {
 	assert(list_empty(&evsel->core.node));
 	assert(evsel->evlist =3D=3D NULL);
+	bpf_counter__destroy(evsel);
 	evsel__free_counts(evsel);
 	perf_evsel__free_fd(&evsel->core);
 	perf_evsel__free_id(&evsel->core);
@@ -1781,6 +1788,8 @@ static int evsel__open_cpu(struct evsel *evsel, str=
uct perf_cpu_map *cpus,
=20
 			FD(evsel, cpu, thread) =3D fd;
=20
+			bpf_counter__install_pe(evsel, cpu, fd);
+
 			if (unlikely(test_attr__enabled)) {
 				test_attr__open(&evsel->core.attr, pid, cpus->map[cpu],
 						fd, group_fd, flags);
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index cd1d8dd431997..40e3946cd7518 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -10,6 +10,7 @@
 #include <internal/evsel.h>
 #include <perf/evsel.h>
 #include "symbol_conf.h"
+#include "bpf_counter.h"
 #include <internal/cpumap.h>
=20
 struct bpf_object;
@@ -17,6 +18,8 @@ struct cgroup;
 struct perf_counts;
 struct perf_stat_evsel;
 union perf_event;
+struct bpf_counter_ops;
+struct target;
=20
 typedef int (evsel__sb_cb_t)(union perf_event *event, void *data);
=20
@@ -127,6 +130,8 @@ struct evsel {
 	 * See also evsel__has_callchain().
 	 */
 	__u64			synth_sample_type;
+	struct list_head	bpf_counter_list;
+	struct bpf_counter_ops	*bpf_counter_ops;
 };
=20
 struct perf_missing_features {
@@ -424,4 +429,5 @@ static inline bool evsel__is_dummy_event(struct evsel=
 *evsel)
 struct perf_env *evsel__env(struct evsel *evsel);
=20
 int evsel__store_ids(struct evsel *evsel, struct evlist *evlist);
+
 #endif /* __PERF_EVSEL_H */
diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-displa=
y.c
index 583ae4f09c5d1..cce7a76d6473c 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -1045,7 +1045,9 @@ static void print_header(struct perf_stat_config *c=
onfig,
 	if (!config->csv_output) {
 		fprintf(output, "\n");
 		fprintf(output, " Performance counter stats for ");
-		if (_target->system_wide)
+		if (_target->bpf_str)
+			fprintf(output, "\'BPF program(s) %s", _target->bpf_str);
+		else if (_target->system_wide)
 			fprintf(output, "\'system wide");
 		else if (_target->cpu_list)
 			fprintf(output, "\'CPU(s) %s", _target->cpu_list);
diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
index 8ce1479c98f03..0b3957323f668 100644
--- a/tools/perf/util/stat.c
+++ b/tools/perf/util/stat.c
@@ -527,7 +527,7 @@ int create_perf_stat_counter(struct evsel *evsel,
 	if (leader->core.nr_members > 1)
 		attr->read_format |=3D PERF_FORMAT_ID|PERF_FORMAT_GROUP;
=20
-	attr->inherit =3D !config->no_inherit;
+	attr->inherit =3D !config->no_inherit && list_empty(&evsel->bpf_counter=
_list);
=20
 	/*
 	 * Some events get initialized with sample_(period/type) set,
diff --git a/tools/perf/util/target.c b/tools/perf/util/target.c
index a3db13dea937c..0f383418e3df5 100644
--- a/tools/perf/util/target.c
+++ b/tools/perf/util/target.c
@@ -56,6 +56,34 @@ enum target_errno target__validate(struct target *targ=
et)
 			ret =3D TARGET_ERRNO__UID_OVERRIDE_SYSTEM;
 	}
=20
+	/* BPF and CPU are mutually exclusive */
+	if (target->bpf_str && target->cpu_list) {
+		target->cpu_list =3D NULL;
+		if (ret =3D=3D TARGET_ERRNO__SUCCESS)
+			ret =3D TARGET_ERRNO__BPF_OVERRIDE_CPU;
+	}
+
+	/* BPF and PID/TID are mutually exclusive */
+	if (target->bpf_str && target->tid) {
+		target->tid =3D NULL;
+		if (ret =3D=3D TARGET_ERRNO__SUCCESS)
+			ret =3D TARGET_ERRNO__BPF_OVERRIDE_PID;
+	}
+
+	/* BPF and UID are mutually exclusive */
+	if (target->bpf_str && target->uid_str) {
+		target->uid_str =3D NULL;
+		if (ret =3D=3D TARGET_ERRNO__SUCCESS)
+			ret =3D TARGET_ERRNO__BPF_OVERRIDE_UID;
+	}
+
+	/* BPF and THREADS are mutually exclusive */
+	if (target->bpf_str && target->per_thread) {
+		target->per_thread =3D false;
+		if (ret =3D=3D TARGET_ERRNO__SUCCESS)
+			ret =3D TARGET_ERRNO__BPF_OVERRIDE_THREAD;
+	}
+
 	/* THREAD and SYSTEM/CPU are mutually exclusive */
 	if (target->per_thread && (target->system_wide || target->cpu_list)) {
 		target->per_thread =3D false;
@@ -109,6 +137,10 @@ static const char *target__error_str[] =3D {
 	"PID/TID switch overriding SYSTEM",
 	"UID switch overriding SYSTEM",
 	"SYSTEM/CPU switch overriding PER-THREAD",
+	"BPF switch overriding CPU",
+	"BPF switch overriding PID/TID",
+	"BPF switch overriding UID",
+	"BPF switch overriding THREAD",
 	"Invalid User: %s",
 	"Problems obtaining information for user %s",
 };
@@ -134,7 +166,7 @@ int target__strerror(struct target *target, int errnu=
m,
=20
 	switch (errnum) {
 	case TARGET_ERRNO__PID_OVERRIDE_CPU ...
-	     TARGET_ERRNO__SYSTEM_OVERRIDE_THREAD:
+	     TARGET_ERRNO__BPF_OVERRIDE_THREAD:
 		snprintf(buf, buflen, "%s", msg);
 		break;
=20
diff --git a/tools/perf/util/target.h b/tools/perf/util/target.h
index 6ef01a83b24e9..f132c6c2eef81 100644
--- a/tools/perf/util/target.h
+++ b/tools/perf/util/target.h
@@ -10,6 +10,7 @@ struct target {
 	const char   *tid;
 	const char   *cpu_list;
 	const char   *uid_str;
+	const char   *bpf_str;
 	uid_t	     uid;
 	bool	     system_wide;
 	bool	     uses_mmap;
@@ -36,6 +37,10 @@ enum target_errno {
 	TARGET_ERRNO__PID_OVERRIDE_SYSTEM,
 	TARGET_ERRNO__UID_OVERRIDE_SYSTEM,
 	TARGET_ERRNO__SYSTEM_OVERRIDE_THREAD,
+	TARGET_ERRNO__BPF_OVERRIDE_CPU,
+	TARGET_ERRNO__BPF_OVERRIDE_PID,
+	TARGET_ERRNO__BPF_OVERRIDE_UID,
+	TARGET_ERRNO__BPF_OVERRIDE_THREAD,
=20
 	/* for target__parse_uid() */
 	TARGET_ERRNO__INVALID_UID,
@@ -59,6 +64,11 @@ static inline bool target__has_cpu(struct target *targ=
et)
 	return target->system_wide || target->cpu_list;
 }
=20
+static inline bool target__has_bpf(struct target *target)
+{
+	return target->bpf_str;
+}
+
 static inline bool target__none(struct target *target)
 {
 	return !target__has_task(target) && !target__has_cpu(target);
--=20
2.24.1

