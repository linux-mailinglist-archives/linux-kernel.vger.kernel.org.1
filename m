Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6479B27A915
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 09:53:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbgI1HxR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 03:53:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726552AbgI1HxP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 03:53:15 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 627ECC0613CE
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 00:53:15 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id b124so178050pfg.13
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 00:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8mk+Yopr2GhbKMLGJ3XUMfKCWFGn0bPCyIVHKo48iUw=;
        b=JiwPcD+ytOUzwLB9rPAmIAd/5wO6EZ2P9aPV5mP6b0oU0M5j2P03p1gdBJ1CgSNArU
         PVv5b5lg+2VmXY9oVJbKrQqvP6Rcjhh+XCxeYsnUYFLFUHzpqDaj+AXhwO0/3b9TbyZf
         gsvWvpkwtnbwzS0sobnBLh7s3+2rvg4j6BYgVT9q0bEeV5lZcSqDRMNp2sNrAvoLOQm2
         UccYkrI37yOGEX7cMcwj/DECjlnnHqLHn25qyRS0kjQZ0K9VkOLv1WeHe9OjfLRtQbCE
         n8wIz8od/izpIs95d1Yo0zs7UNUP/B3yvYOtnP3nKzcYnTBkDyPR4sWfYVAmDlRwm8G0
         70Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=8mk+Yopr2GhbKMLGJ3XUMfKCWFGn0bPCyIVHKo48iUw=;
        b=ZkurU6kiPFSqBOUuEdkqwepSvw1SjVslaDNPZBhjxJd9Q8se7Y1GdI44bgsVEb1+jj
         glXO56+0rzAG9KQYYAGPqOLYEIFxWi5Y+B9GKXQ0zcWz6f1UuWBFLlVuAKqrGwA4INIa
         PsnoZXgYqXLPSUmwsa8ho8wWl77ugWOE7mGN4ccPQ7KBOp9d6cKIjA1vmLbm2B5jyMUT
         xE1AEHbPDevTU+ZkqQohQCqPAy0VjjLWpGuun0v5aDTFlVQMYux0l6AJipxz9w/tZH0B
         yb9H1xnXNxl7To8ZiGnGhywSp2C4EsHy1GYsSO8/42aX3pHaDooSYvkT/lVkHvh1/a1P
         Ng7Q==
X-Gm-Message-State: AOAM530sxz0jOYmTraDvnMt8FEoBGmJpEy8FGZzj+vLErBc6L4eXZCm4
        cJ4BIVdWBRmWNsaO6PYwC+8=
X-Google-Smtp-Source: ABdhPJzQhf0/xpw3nIaCfb9nP2cOcfC3j0Nk7yBUbAk2bIICGkXbgqOyWtsabML5jUCIbS0rioSDHQ==
X-Received: by 2002:a63:2022:: with SMTP id g34mr273589pgg.378.1601279594960;
        Mon, 28 Sep 2020 00:53:14 -0700 (PDT)
Received: from balhae.roam.corp.google.com ([101.235.31.111])
        by smtp.gmail.com with ESMTPSA id 141sm520241pfb.50.2020.09.28.00.53.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2020 00:53:14 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Subject: [PATCH 4/6] perf inject: Do not load map/dso when injecting build-id
Date:   Mon, 28 Sep 2020 16:52:44 +0900
Message-Id: <20200928075246.853729-5-namhyung@kernel.org>
X-Mailer: git-send-email 2.28.0.681.g6f77f65b4e-goog
In-Reply-To: <20200928075246.853729-1-namhyung@kernel.org>
References: <20200928075246.853729-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No need to load symbols in a DSO when injecting build-id.  I guess the
reason was to check the DSO is a special file like anon files.  Use
some helper functions in map.c to check them before reading build-id.
Also pass sample event's cpumode to a new build-id event.

It brought a speedup in the benchmark of 23 -> 18 msec on my laptop.
Also the memory usage (Max RSS) went down by ~400 KB.

  # Running 'internals/inject-build-id' benchmark:
    Average build-id injection took: 18.153 msec (+- 0.073 msec)
    Average time per event: 1.780 usec (+- 0.007 usec)
    Average memory usage: 7431 KB (+- 6 KB)

Original-patch-by: Stephane Eranian <eranian@google.com>
Acked-by: Jiri Olsa <jolsa@redhat.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-inject.c | 33 ++++++++++++---------------------
 tools/perf/util/map.c       | 17 +----------------
 tools/perf/util/map.h       | 14 ++++++++++++++
 3 files changed, 27 insertions(+), 37 deletions(-)

diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index 670157db2502..248cd9f3e5bb 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -24,9 +24,10 @@
 #include "util/synthetic-events.h"
 #include "util/thread.h"
 #include "util/namespaces.h"
-#include <linux/err.h>
 
+#include <linux/err.h>
 #include <subcmd/parse-options.h>
+#include <uapi/linux/mman.h> /* To get things like MAP_HUGETLB even on older libc headers */
 
 #include <linux/list.h>
 #include <errno.h>
@@ -436,21 +437,22 @@ static int dso__read_build_id(struct dso *dso)
 }
 
 static int dso__inject_build_id(struct dso *dso, struct perf_tool *tool,
-				struct machine *machine)
+				struct machine *machine, u8 cpumode, u32 flags)
 {
-	u16 misc = PERF_RECORD_MISC_USER;
 	int err;
 
+	if (is_anon_memory(dso->long_name) || flags & MAP_HUGETLB)
+		return 0;
+	if (is_no_dso_memory(dso->long_name))
+		return 0;
+
 	if (dso__read_build_id(dso) < 0) {
 		pr_debug("no build_id found for %s\n", dso->long_name);
 		return -1;
 	}
 
-	if (dso->kernel)
-		misc = PERF_RECORD_MISC_KERNEL;
-
-	err = perf_event__synthesize_build_id(tool, dso, misc, perf_event__repipe,
-					      machine);
+	err = perf_event__synthesize_build_id(tool, dso, cpumode,
+					      perf_event__repipe, machine);
 	if (err) {
 		pr_err("Can't synthesize build_id event for %s\n", dso->long_name);
 		return -1;
@@ -477,19 +479,8 @@ int perf_event__inject_buildid(struct perf_tool *tool, union perf_event *event,
 	if (thread__find_map(thread, sample->cpumode, sample->ip, &al)) {
 		if (!al.map->dso->hit) {
 			al.map->dso->hit = 1;
-			if (map__load(al.map) >= 0) {
-				dso__inject_build_id(al.map->dso, tool, machine);
-				/*
-				 * If this fails, too bad, let the other side
-				 * account this as unresolved.
-				 */
-			} else {
-#ifdef HAVE_LIBELF_SUPPORT
-				pr_warning("no symbols found in %s, maybe "
-					   "install a debug package?\n",
-					   al.map->dso->long_name);
-#endif
-			}
+			dso__inject_build_id(al.map->dso, tool, machine,
+					     sample->cpumode, al.map->flags);
 		}
 	}
 
diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
index cc0faf8f1321..8b305e624124 100644
--- a/tools/perf/util/map.c
+++ b/tools/perf/util/map.c
@@ -27,21 +27,6 @@
 
 static void __maps__insert(struct maps *maps, struct map *map);
 
-static inline int is_anon_memory(const char *filename, u32 flags)
-{
-	return flags & MAP_HUGETLB ||
-	       !strcmp(filename, "//anon") ||
-	       !strncmp(filename, "/dev/zero", sizeof("/dev/zero") - 1) ||
-	       !strncmp(filename, "/anon_hugepage", sizeof("/anon_hugepage") - 1);
-}
-
-static inline int is_no_dso_memory(const char *filename)
-{
-	return !strncmp(filename, "[stack", 6) ||
-	       !strncmp(filename, "/SYSV",5)   ||
-	       !strcmp(filename, "[heap]");
-}
-
 static inline int is_android_lib(const char *filename)
 {
 	return strstarts(filename, "/data/app-lib/") ||
@@ -158,7 +143,7 @@ struct map *map__new(struct machine *machine, u64 start, u64 len,
 		int anon, no_dso, vdso, android;
 
 		android = is_android_lib(filename);
-		anon = is_anon_memory(filename, flags);
+		anon = is_anon_memory(filename) || flags & MAP_HUGETLB;
 		vdso = is_vdso_map(filename);
 		no_dso = is_no_dso_memory(filename);
 		map->prot = prot;
diff --git a/tools/perf/util/map.h b/tools/perf/util/map.h
index c2f5d28fe73a..b1c0686db1b7 100644
--- a/tools/perf/util/map.h
+++ b/tools/perf/util/map.h
@@ -171,4 +171,18 @@ static inline bool is_bpf_image(const char *name)
 	return strncmp(name, "bpf_trampoline_", sizeof("bpf_trampoline_") - 1) == 0 ||
 	       strncmp(name, "bpf_dispatcher_", sizeof("bpf_dispatcher_") - 1) == 0;
 }
+
+static inline int is_anon_memory(const char *filename)
+{
+	return !strcmp(filename, "//anon") ||
+	       !strncmp(filename, "/dev/zero", sizeof("/dev/zero") - 1) ||
+	       !strncmp(filename, "/anon_hugepage", sizeof("/anon_hugepage") - 1);
+}
+
+static inline int is_no_dso_memory(const char *filename)
+{
+	return !strncmp(filename, "[stack", 6) ||
+	       !strncmp(filename, "/SYSV", 5)  ||
+	       !strcmp(filename, "[heap]");
+}
 #endif /* __PERF_MAP_H */
-- 
2.28.0.681.g6f77f65b4e-goog

