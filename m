Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 013DB298F0C
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 15:19:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1781232AbgJZOTw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 10:19:52 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:32911 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1780640AbgJZOTs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 10:19:48 -0400
Received: by mail-pf1-f196.google.com with SMTP id j18so6289653pfa.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Oct 2020 07:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HLswEjxQbu5C8xqq9SnuF68VVU78PUgJUWGbxqPwtoA=;
        b=m6t9IQphtvIwRlk8C5fWq1mACXNIyHoLxQJ9uKsXrLTRqPykbQ/EJAbH/2/GrlhMTF
         rxeEeOJ3q4Ezx/lzKtIhBosz6kYM/iFsF6zuwzMMWyaEcm1LYXV+BV5CNqbpPmi+fbGO
         aOlhABcs6rLlz4jEZlQEr1j7sG8oNOnfTwwsxQwcUxXfzhQU5PXe/4hDZS6q3ZyQgkYq
         KdXiUjIMK654STSoLJeUFWEwFoaIFHEfLbu7WAXj1UHnfyBAIbdMeq/hizXHlyQCl2Rf
         CK7x8Sy9HD6vElcZRiEjq7XTJYhN2O0Um/Hht7UPKakFt4ibKq0xFEtdcpsCNVOWh7v5
         Ra2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=HLswEjxQbu5C8xqq9SnuF68VVU78PUgJUWGbxqPwtoA=;
        b=BRPrUzhaW0OuQxShcc7uQycjbZpiXJOXwgYCLKHAuXh8Qk88Q+yvOT88HKc/6AA5sh
         NJtpR73Ep2hPd4is/wh2QEqu1BaUFwiVOVqg/MmokSI2W+lolVSOAjKL+pW6xd4FKCSD
         /d9aKTWwaFI9WO6XkkqYywDYQU7Hqb3pHJcrrTbpICQAb7b2+6LiD62B1gGQf59GWgaq
         UvaOOPb6eELZnjJYJXWFKjXamgIH5xOKJDZS6bLX7nNP8rShSCUB2UmYP826ljgBlE1y
         Uv4fyUNrELd7JGUEoNyB2ypIHd5i1VE9Ourfn2HK/myE0mIW1CLZyShSfFtkZSA260x/
         jwbQ==
X-Gm-Message-State: AOAM532m3Vm8eo0eC4d93zohRj4qxoyYNQfXCJjk18O6/oApPt9IdLUM
        5Wc/tSPiVmfVKbwhIFvmen8=
X-Google-Smtp-Source: ABdhPJzo3qUoWNjqzKS2/K+O2xJiaPl/6SFDfs1aQ+BU/M/2t4IGZETTh89rwRnc3qXQMgHXs/lJGg==
X-Received: by 2002:a62:7d4d:0:b029:152:1b09:f34 with SMTP id y74-20020a627d4d0000b02901521b090f34mr13913830pfc.76.1603721987084;
        Mon, 26 Oct 2020 07:19:47 -0700 (PDT)
Received: from balhae.roam.corp.google.com ([101.235.31.111])
        by smtp.gmail.com with ESMTPSA id b1sm8558342pjd.11.2020.10.26.07.19.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2020 07:19:46 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andi Kleen <ak@linux.intel.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Subject: [RFC] perf evlist: Warn if event group has mixed sw/hw events
Date:   Mon, 26 Oct 2020 23:19:37 +0900
Message-Id: <20201026141937.582087-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.29.0.rc1.297.gfa9743e501-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I found that order of events in a group impacts performance during the
open.  If a group has a software event as a leader and has other
hardware events, the lead needs to be moved to a hardware context.
This includes RCU synchronization which takes about 20 msec on my
system.  And this is just for a single group, so total time increases
in proportion to the number of event groups and the number of cpus.

On my 36 cpu system, opening 3 groups system-wide takes more than 2
seconds.  You can see and compare it easily with the following:

  $ time ./perf stat -a -e '{cs,cycles},{cs,cycles},{cs,cycles}' sleep 1
  ...
       1.006333430 seconds time elapsed

  real	0m3.969s
  user	0m0.089s
  sys	0m0.074s

  $ time ./perf stat -a -e '{cycles,cs},{cycles,cs},{cycles,cs}' sleep 1
  ...
       1.006755292 seconds time elapsed

  real	0m1.144s
  user	0m0.067s
  sys	0m0.083s

This patch just added a warning before running it.  I'd really want to
fix the kernel if possible but don't have a good idea.  Thoughts?

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-record.c |  2 +
 tools/perf/builtin-stat.c   |  2 +
 tools/perf/builtin-top.c    |  2 +
 tools/perf/util/evlist.c    | 78 +++++++++++++++++++++++++++++++++++++
 tools/perf/util/evlist.h    |  1 +
 5 files changed, 85 insertions(+)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index adf311d15d3d..c0b08cacbae0 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -912,6 +912,8 @@ static int record__open(struct record *rec)
 
 	perf_evlist__config(evlist, opts, &callchain_param);
 
+	evlist__warn_mixed_group(evlist);
+
 	evlist__for_each_entry(evlist, pos) {
 try_again:
 		if (evsel__open(pos, pos->core.cpus, pos->core.threads) < 0) {
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index b01af171d94f..d5d4e02bda69 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -738,6 +738,8 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 	if (affinity__setup(&affinity) < 0)
 		return -1;
 
+	evlist__warn_mixed_group(evsel_list);
+
 	evlist__for_each_cpu (evsel_list, i, cpu) {
 		affinity__set(&affinity, cpu);
 
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 7c64134472c7..9ad319cea948 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -1027,6 +1027,8 @@ static int perf_top__start_counters(struct perf_top *top)
 
 	perf_evlist__config(evlist, opts, &callchain_param);
 
+	evlist__warn_mixed_group(evlist);
+
 	evlist__for_each_entry(evlist, counter) {
 try_again:
 		if (evsel__open(counter, top->evlist->core.cpus,
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 8bdf3d2c907c..02cff39e509e 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -28,6 +28,7 @@
 #include <unistd.h>
 #include <sched.h>
 #include <stdlib.h>
+#include <dirent.h>
 
 #include "parse-events.h"
 #include <subcmd/parse-options.h>
@@ -1980,3 +1981,80 @@ struct evsel *evlist__find_evsel(struct evlist *evlist, int idx)
 	}
 	return NULL;
 }
+
+static int *sw_types;
+static int nr_sw_types;
+
+static void collect_software_pmu_types(void)
+{
+	const char *known_sw_pmu[] = {
+		"software", "tracepoint", "breakpoint", "kprobe", "uprobe", "msr"
+	};
+	DIR *dir;
+	struct dirent *d;
+	char path[PATH_MAX];
+	int i;
+
+	if (sw_types != NULL)
+		return;
+
+	nr_sw_types = ARRAY_SIZE(known_sw_pmu);
+	sw_types = calloc(nr_sw_types, sizeof(int));
+	if (sw_types == NULL) {
+		pr_err("Memory allocation failed!\n");
+		return;
+	}
+
+	dir = opendir("/sys/bus/event_source/devices");
+	while ((d = readdir(dir)) != NULL) {
+		for (i = 0; i < nr_sw_types; i++) {
+			if (strcmp(d->d_name, known_sw_pmu[i]))
+				continue;
+
+			snprintf(path, sizeof(path), "%s/%s/type",
+				 "bus/event_source/devices", d->d_name);
+			sysfs__read_int(path, &sw_types[i]);
+		}
+	}
+	closedir(dir);
+}
+
+static bool is_software_event(struct evsel *evsel)
+{
+	int i;
+
+	for (i = 0; i < nr_sw_types; i++) {
+		if (evsel->core.attr.type == (unsigned)sw_types[i])
+			return true;
+	}
+	return false;
+}
+
+void evlist__warn_mixed_group(struct evlist *evlist)
+{
+	struct evsel *leader, *evsel;
+	bool warn = true;
+
+	collect_software_pmu_types();
+
+	/* Warn if an event group has a sw leader and hw siblings */
+	evlist__for_each_entry(evlist, leader) {
+		if (!evsel__is_group_event(leader))
+			continue;
+
+		if (!is_software_event(leader))
+			continue;
+
+		for_each_group_member(evsel, leader) {
+			if (is_software_event(evsel))
+				continue;
+			if (!warn)
+				continue;
+
+			pr_warning("WARNING: Event group has mixed hw/sw events.\n"
+				   "This will slow down the perf_event_open syscall.\n"
+				   "Consider putting a hw event as a leader.\n\n");
+			warn = false;
+		}
+	}
+}
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index e1a450322bc5..a5b0a1d03a00 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -387,4 +387,5 @@ int evlist__ctlfd_ack(struct evlist *evlist);
 #define EVLIST_DISABLED_MSG "Events disabled\n"
 
 struct evsel *evlist__find_evsel(struct evlist *evlist, int idx);
+void evlist__warn_mixed_group(struct evlist *evlist);
 #endif /* __PERF_EVLIST_H */
-- 
2.29.0.rc1.297.gfa9743e501-goog

