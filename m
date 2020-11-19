Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 142172B8B14
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 06:43:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725930AbgKSFm5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 00:42:57 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:13576 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725648AbgKSFm5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 00:42:57 -0500
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 0AJ5doTB031930
        for <linux-kernel@vger.kernel.org>; Wed, 18 Nov 2020 21:42:52 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=JTm49y+lAk57ciIY9Gz6iLmobsbD7yy1HHzu/5kxpHk=;
 b=qbHBKQR/YgpYxYvZ31h7FqBRCep5Cy5XqBgLvneiGSuBPhxXfmQKj34yWuez/vmVmN1F
 SCLTp52tU2NbXK5PABnkIsZIDk1p11odlWJ2cQtpcfgP2w0w3ga0QOFZXVjm9VtAg8gp
 H6tXDyZLj5av7yt0IBLHGXS7Rulmg/WJbdY= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net with ESMTP id 34wfdq2cm5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 18 Nov 2020 21:42:52 -0800
Received: from intmgw001.03.ash8.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 18 Nov 2020 20:51:02 -0800
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id 838AC62E572B; Wed, 18 Nov 2020 20:50:57 -0800 (PST)
From:   Song Liu <songliubraving@fb.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <kernel-team@fb.com>, <peterz@infradead.org>, <mingo@redhat.com>,
        <acme@kernel.org>, <mark.rutland@arm.com>,
        <alexander.shishkin@linux.intel.com>, <jolsa@redhat.com>,
        <namhyung@kernel.org>, Song Liu <songliubraving@fb.com>
Subject: [RFC 2/2] perf-stat: enable counting events for BPF programs
Date:   Wed, 18 Nov 2020 20:50:46 -0800
Message-ID: <20201119045046.1491106-3-songliubraving@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20201119045046.1491106-1-songliubraving@fb.com>
References: <20201119045046.1491106-1-songliubraving@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-19_01:2020-11-17,2020-11-19 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 adultscore=0 mlxscore=0
 lowpriorityscore=0 phishscore=0 impostorscore=0 clxscore=1015
 mlxlogscore=999 malwarescore=0 bulkscore=0 suspectscore=4
 priorityscore=1501 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2011190042
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
 tools/perf/Makefile.config                    |   1 +
 tools/perf/builtin-stat.c                     |  59 ++++-
 tools/perf/util/Build                         |   1 +
 tools/perf/util/bpf_counter.c                 | 215 ++++++++++++++++++
 tools/perf/util/bpf_counter.h                 |  71 ++++++
 tools/perf/util/bpf_skel/Makefile             |   2 +-
 .../util/bpf_skel/bpf_prog_profiler.bpf.c     |  96 ++++++++
 tools/perf/util/evsel.c                       |  10 +
 tools/perf/util/evsel.h                       |   5 +
 tools/perf/util/target.h                      |   6 +
 10 files changed, 457 insertions(+), 9 deletions(-)
 create mode 100644 tools/perf/util/bpf_counter.c
 create mode 100644 tools/perf/util/bpf_counter.h
 create mode 100644 tools/perf/util/bpf_skel/bpf_prog_profiler.bpf.c

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 1c2c0f4badd85..60bcaa5af4d4c 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -624,6 +624,7 @@ ifndef NO_LIBBPF
     ifeq ($(feature-clang-bpf-co-re), 1)
       BUILD_BPF_SKEL :=3D 1
       $(call detected,CONFIG_PERF_BPF_SKEL)
+      CFLAGS +=3D -DBUILD_BPF_SKEL
     endif
   endif
 endif
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index f15b2f8aa14d8..d6df04cc24073 100644
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
@@ -738,6 +768,11 @@ static int __run_perf_stat(int argc, const char **ar=
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
@@ -851,7 +886,7 @@ static int __run_perf_stat(int argc, const char **arg=
v, int run_idx)
 	}
=20
 	if (STAT_RECORD) {
-		int err, fd =3D perf_data__fd(&perf_stat.data);
+		int fd =3D perf_data__fd(&perf_stat.data);
=20
 		if (is_pipe) {
 			err =3D perf_header__write_pipe(perf_data__fd(&perf_stat.data));
@@ -877,7 +912,9 @@ static int __run_perf_stat(int argc, const char **arg=
v, int run_idx)
=20
 	if (forks) {
 		perf_evlist__start_workload(evsel_list);
-		enable_counters();
+		err =3D enable_counters();
+		if (err)
+			return -1;
=20
 		if (interval || timeout || evlist__ctlfd_initialized(evsel_list))
 			status =3D dispatch_events(forks, timeout, interval, &times);
@@ -896,7 +933,9 @@ static int __run_perf_stat(int argc, const char **arg=
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
@@ -1087,6 +1126,10 @@ static struct option stat_options[] =3D {
 		   "stat events on existing process id"),
 	OPT_STRING('t', "tid", &target.tid, "tid",
 		   "stat events on existing thread id"),
+#ifdef BUILD_BPF_SKEL
+	OPT_STRING('b', "bpf-prog", &target.bpf_prog_id, "bpf-prog-id",
+		   "stat events on existing bpf program id"),
+#endif
 	OPT_BOOLEAN('a', "all-cpus", &target.system_wide,
 		    "system-wide collection from all CPUs"),
 	OPT_BOOLEAN('g', "group", &group,
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
index 0000000000000..25456a179af26
--- /dev/null
+++ b/tools/perf/util/bpf_counter.c
@@ -0,0 +1,215 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/* Copyright (c) 2019 Facebook */
+
+#include <limits.h>
+#include <sys/time.h>
+#include <sys/resource.h>
+#include <linux/err.h>
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
+		pr_debug2("failed to get info_linear for prog FD %d", tgt_fd);
+		return NULL;
+	}
+
+	if (info_linear->info.btf_id =3D=3D 0 ||
+	    btf__get_from_id(info_linear->info.btf_id, &btf)) {
+		pr_debug2("prog FD %d doesn't have valid btf", tgt_fd);
+		goto out;
+	}
+
+	func_info =3D u64_to_ptr(info_linear->info.func_info);
+	t =3D btf__type_by_id(btf, func_info[0].type_id);
+	if (!t) {
+		pr_debug2("btf %d doesn't have type %d",
+		      info_linear->info.btf_id, func_info[0].type_id);
+		goto out;
+	}
+	name =3D strdup(btf__name_by_offset(btf, t->name_off));
+out:
+	free(info_linear);
+	return name;
+}
+
+static void set_max_rlimit(void)
+{
+	struct rlimit rinf =3D { RLIM_INFINITY, RLIM_INFINITY };
+
+	setrlimit(RLIMIT_MEMLOCK, &rinf);
+}
+
+static int bpf_program_profiler__load(struct evsel *evsel, struct target=
 *target)
+{
+	struct bpf_prog_profiler_bpf *skel;
+	struct bpf_program *prog;
+	char *prog_name;
+	char *end_ptr;
+	u32 prog_id;
+	int prog_fd;
+	int err;
+
+	prog_id =3D strtoul(target->bpf_prog_id, &end_ptr, 10);
+	if (prog_id =3D=3D 0 || prog_id =3D=3D UINT_MAX || *end_ptr !=3D '\0') =
{
+		pr_debug("Failed to parse bpf prog id %s\n", target->bpf_prog_id);
+		return -1;
+	}
+	prog_fd =3D bpf_prog_get_fd_by_id(prog_id);
+	if (prog_fd < 0) {
+		pr_debug("Failed to open fd for bpf prog %u\n", prog_id);
+		return -1;
+	}
+
+	skel =3D bpf_prog_profiler_bpf__open();
+	if (!skel) {
+		pr_debug("Failed to load bpf skeleton\n");
+		return -1;
+	}
+	skel->rodata->num_cpu =3D evsel__nr_cpus(evsel);
+
+	bpf_map__resize(skel->maps.events, evsel__nr_cpus(evsel));
+	bpf_map__resize(skel->maps.fentry_readings, 1);
+	bpf_map__resize(skel->maps.accum_readings, 1);
+
+	prog_name =3D bpf_target_prog_name(prog_fd);
+
+	bpf_object__for_each_program(prog, skel->obj) {
+		err =3D bpf_program__set_attach_target(prog, prog_fd, prog_name);
+		if (err)
+			pr_debug("bpf_program__set_attach_target failed\n");
+	}
+	set_max_rlimit();
+	err =3D bpf_prog_profiler_bpf__load(skel);
+	if (err)
+		pr_debug("bpf_prog_profiler_bpf__load failed\n");
+
+	evsel->bpf_counter.skel =3D skel;
+	return 0;
+}
+
+static int bpf_program_profiler__enable(struct evsel *evsel)
+{
+	struct bpf_prog_profiler_bpf *skel =3D evsel->bpf_counter.skel;
+
+	return bpf_prog_profiler_bpf__attach(skel);
+}
+
+static int bpf_program_profiler__read(struct evsel *evsel)
+{
+	struct bpf_prog_profiler_bpf *skel =3D evsel->bpf_counter.skel;
+	int num_cpu =3D evsel__nr_cpus(evsel);
+	struct bpf_perf_event_value values[num_cpu];
+	int reading_map_fd;
+	__u32 key =3D 0;
+	int err, cpu;
+
+	if (!skel)
+		return -EAGAIN;
+
+	reading_map_fd =3D bpf_map__fd(skel->maps.accum_readings);
+
+	err =3D bpf_map_lookup_elem(reading_map_fd, &key, values);
+	if (err) {
+		fprintf(stderr, "failed to read value\n");
+		return err;
+	}
+
+	for (cpu =3D 0; cpu < num_cpu; cpu++) {
+		perf_counts(evsel->counts, cpu, 0)->val =3D values[cpu].counter;
+		perf_counts(evsel->counts, cpu, 0)->ena =3D values[cpu].enabled;
+		perf_counts(evsel->counts, cpu, 0)->run =3D values[cpu].running;
+	}
+
+	return 0;
+}
+
+static int bpf_program_profiler__destroy(struct evsel *evsel)
+{
+	struct bpf_prog_profiler_bpf *skel =3D evsel->bpf_counter.skel;
+
+	bpf_prog_profiler_bpf__destroy(skel);
+	return 0;
+}
+
+static int bpf_program_profiler__install_pe(struct evsel *evsel, int cpu=
,
+					    int fd)
+{
+	struct bpf_prog_profiler_bpf *skel =3D evsel->bpf_counter.skel;
+
+	return bpf_map_update_elem(bpf_map__fd(skel->maps.events),
+				   &cpu, &fd, BPF_ANY);
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
+	if (!evsel->bpf_counter.skel)
+		return 0;
+	return evsel->bpf_counter.ops->install_pe(evsel, cpu, fd);
+}
+
+int bpf_counter__load(struct evsel *evsel, struct target *target)
+{
+	if (target__has_bpf(target))
+		evsel->bpf_counter.ops =3D &bpf_program_profiler_ops;
+
+	if (evsel->bpf_counter.ops)
+		return evsel->bpf_counter.ops->load(evsel, target);
+	return 0;
+}
+
+int bpf_counter__enable(struct evsel *evsel)
+{
+	if (!evsel->bpf_counter.skel)
+		return 0;
+	return evsel->bpf_counter.ops->enable(evsel);
+}
+
+int bpf_counter__read(struct evsel *evsel)
+{
+	if (!evsel->bpf_counter.skel)
+		return -EAGAIN;
+	return evsel->bpf_counter.ops->read(evsel);
+}
+
+int bpf_counter__destroy(struct evsel *evsel)
+{
+	if (!evsel->bpf_counter.skel)
+		return 0;
+	evsel->bpf_counter.ops->destroy(evsel);
+	evsel->bpf_counter.skel =3D NULL;
+	evsel->bpf_counter.ops =3D NULL;
+	return 0;
+}
diff --git a/tools/perf/util/bpf_counter.h b/tools/perf/util/bpf_counter.=
h
new file mode 100644
index 0000000000000..9f8f9bd3ec6e2
--- /dev/null
+++ b/tools/perf/util/bpf_counter.h
@@ -0,0 +1,71 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __PERF_BPF_COUNTER_H
+#define __PERF_BPF_COUNTER_H 1
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
+	struct bpf_counter_ops *ops;
+};
+
+#ifdef BUILD_BPF_SKEL
+
+int bpf_counter__load(struct evsel *evsel, struct target *target);
+int bpf_counter__enable(struct evsel *evsel);
+int bpf_counter__read(struct evsel *evsel);
+int bpf_counter__destroy(struct evsel *evsel);
+int bpf_counter__install_pe(struct evsel *evsel, int cpu, int fd);
+
+#else
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
+static inline int bpf_counter__destroy(struct evsel *evsel __maybe_unuse=
d)
+{
+	return 0;
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
+#endif /* BUILD_BPF_SKEL */
+
+#endif /* __PERF_BPF_COUNTER_H */
diff --git a/tools/perf/util/bpf_skel/Makefile b/tools/perf/util/bpf_skel=
/Makefile
index 853bece088f4b..9e942f280c713 100644
--- a/tools/perf/util/bpf_skel/Makefile
+++ b/tools/perf/util/bpf_skel/Makefile
@@ -28,7 +28,7 @@ MAKEFLAGS +=3D --no-print-directory
 submake_extras :=3D feature_display=3D0
 endif
=20
-SKELETONS :=3D $(SKEL_OUTPUT)/dummy.skel.h
+SKELETONS :=3D $(SKEL_OUTPUT)/dummy.skel.h $(SKEL_OUTPUT)/bpf_prog_profi=
ler.skel.h
=20
 .DELETE_ON_ERROR:
=20
diff --git a/tools/perf/util/bpf_skel/bpf_prog_profiler.bpf.c b/tools/per=
f/util/bpf_skel/bpf_prog_profiler.bpf.c
new file mode 100644
index 0000000000000..41714bc436656
--- /dev/null
+++ b/tools/perf/util/bpf_skel/bpf_prog_profiler.bpf.c
@@ -0,0 +1,96 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+// Copyright (c) 2020 Facebook
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+/* map of perf event fds, num_cpu * num_metric entries */
+struct {
+	__uint(type, BPF_MAP_TYPE_PERF_EVENT_ARRAY);
+	__uint(key_size, sizeof(u32));
+	__uint(value_size, sizeof(int));
+} events SEC(".maps");
+
+/* readings at fentry */
+struct {
+	__uint(type, BPF_MAP_TYPE_PERCPU_ARRAY);
+	__uint(key_size, sizeof(u32));
+	__uint(value_size, sizeof(struct bpf_perf_event_value));
+	__uint(max_entries, 1);
+} fentry_readings SEC(".maps");
+
+/* accumulated readings */
+struct {
+	__uint(type, BPF_MAP_TYPE_PERCPU_ARRAY);
+	__uint(key_size, sizeof(u32));
+	__uint(value_size, sizeof(struct bpf_perf_event_value));
+	__uint(max_entries, 1);
+} accum_readings SEC(".maps");
+
+const volatile __u32 num_cpu =3D 1;
+
+SEC("fentry/XXX")
+int BPF_PROG(fentry_XXX)
+{
+	u32 key =3D bpf_get_smp_processor_id();
+	struct bpf_perf_event_value reading;
+	struct bpf_perf_event_value *ptr;
+	u32 zero =3D 0;
+	long err;
+
+	/* look up before reading, to reduce error */
+	ptr =3D bpf_map_lookup_elem(&fentry_readings, &zero);
+	if (!ptr)
+		return 0;
+
+	err =3D bpf_perf_event_read_value(&events, key, &reading,
+					sizeof(reading));
+	if (err)
+		return 0;
+
+	*ptr =3D reading;
+	return 0;
+}
+
+static inline void
+fexit_update_maps(struct bpf_perf_event_value *after)
+{
+	struct bpf_perf_event_value *before, diff, *accum;
+	u32 zero =3D 0;
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
+	u32 cpu =3D bpf_get_smp_processor_id();
+	u32 one =3D 1, zero =3D 0;
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
index 1cad6051d8b08..6376b8db58e09 100644
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
@@ -1365,6 +1370,7 @@ void evsel__exit(struct evsel *evsel)
 {
 	assert(list_empty(&evsel->core.node));
 	assert(evsel->evlist =3D=3D NULL);
+	bpf_counter__destroy(evsel);
 	evsel__free_counts(evsel);
 	perf_evsel__free_fd(&evsel->core);
 	perf_evsel__free_id(&evsel->core);
@@ -1770,6 +1776,8 @@ static int evsel__open_cpu(struct evsel *evsel, str=
uct perf_cpu_map *cpus,
 		evsel->core.attr.sample_id_all =3D 0;
=20
 	display_attr(&evsel->core.attr);
+	if (evsel->bpf_counter.skel)
+		evsel->core.attr.inherit =3D 0;
=20
 	for (cpu =3D start_cpu; cpu < end_cpu; cpu++) {
=20
@@ -1788,6 +1796,8 @@ static int evsel__open_cpu(struct evsel *evsel, str=
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
index 79a860d8e3eef..3a44f7b25726c 100644
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
+struct bpf_counter;
+struct target;
=20
 typedef int (evsel__sb_cb_t)(union perf_event *event, void *data);
=20
@@ -127,6 +130,7 @@ struct evsel {
 	 * See also evsel__has_callchain().
 	 */
 	__u64			synth_sample_type;
+	struct bpf_counter	bpf_counter;
 };
=20
 struct perf_missing_features {
@@ -423,4 +427,5 @@ static inline bool evsel__is_dummy_event(struct evsel=
 *evsel)
 struct perf_env *evsel__env(struct evsel *evsel);
=20
 int evsel__store_ids(struct evsel *evsel, struct evlist *evlist);
+
 #endif /* __PERF_EVSEL_H */
diff --git a/tools/perf/util/target.h b/tools/perf/util/target.h
index 6ef01a83b24e9..cdaa7510f918b 100644
--- a/tools/perf/util/target.h
+++ b/tools/perf/util/target.h
@@ -10,6 +10,7 @@ struct target {
 	const char   *tid;
 	const char   *cpu_list;
 	const char   *uid_str;
+	const char   *bpf_prog_id;
 	uid_t	     uid;
 	bool	     system_wide;
 	bool	     uses_mmap;
@@ -59,6 +60,11 @@ static inline bool target__has_cpu(struct target *targ=
et)
 	return target->system_wide || target->cpu_list;
 }
=20
+static inline bool target__has_bpf(struct target *target)
+{
+	return target->bpf_prog_id;
+}
+
 static inline bool target__none(struct target *target)
 {
 	return !target__has_task(target) && !target__has_cpu(target);
--=20
2.24.1

