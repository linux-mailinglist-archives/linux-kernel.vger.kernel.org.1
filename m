Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B69628AEB9
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 09:03:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726778AbgJLHD0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 03:03:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726810AbgJLHCe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 03:02:34 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CECA6C0613CE
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 00:02:33 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id g29so13401478pgl.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 00:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mH8SU4hAVkL7Rdbm2MRjfbzrzKE4MYbiCh+pP1beozU=;
        b=r743UYkb8hh2nB1qUqmwz3Sutz8tRnFEmOA3pvhk7YRK/SkZiN/8ERWEvvYGZvmuuc
         g1Jcd1cRAr3TNsXvZXfgOlPMLpOCPFjgGKf/9iBh8UfX+i0OdSXaCOlNRWOL1/hG71C1
         Fpg3niVBPVw4OxObGWb4J1jrANoASo9qpObBjwXQDXoqe+mocJHQonCgZnXUdZb1UNKw
         +sBz+zVj5mrp6V4Btd7d40Q+pGTlT7u9lYNudeCyo1OR567EWOb8g49tdDCDWqKl0aIG
         YQfgC/IkTl9ptYBP9ebiq8wWu/Lfdskt8WNSuJBO7DRpUy5jPd3KnXfdSKQbwsX5PWcR
         mojg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=mH8SU4hAVkL7Rdbm2MRjfbzrzKE4MYbiCh+pP1beozU=;
        b=RftwSkzs+mMsSWzwaKdmJ0W6UWgFr7ZkT4G7+JCWROG8kkMlMTYnoV43SJpqSf9RXV
         OBx3q0d4n05FempNVAqLAXV11ohVSEWpZXFbDkzR5w03KDj5Yf2siIuxY/ZnxmYE5Zf7
         2G9twhhi+tDlNgtPk9c2A8SLARDK/CCF6WHb9tO5kfFjk3iwOZBPM9ouJLfEqx8o0Ykg
         KgxbDBgsirRVzX3fiyuLUzoD8r8b47swzQAKhkOL4zKvye5CeqffVZvHw1FGzIL8U66W
         F2Cl/iSiXJtog81oaHjDjxccr6JU6wvQt8SxWyI3y2Qk04BNnMOgR9LtvK2hPfWsWNeR
         PpSQ==
X-Gm-Message-State: AOAM532Wz2GUzqQax5zvBj9SxRb5Al+sC83wXnygP/AaQNKc+4veqeVS
        27PtNxeLkV7nH5DoM0HMjUc=
X-Google-Smtp-Source: ABdhPJx9xzBeq2PcEVWvDb5cAf+IhcuvnBCtIwn/JWP354UXz5GB9MdnhyYA5lGIuhhvi0WuqszJ5w==
X-Received: by 2002:a17:90b:8c:: with SMTP id bb12mr18419523pjb.48.1602486153348;
        Mon, 12 Oct 2020 00:02:33 -0700 (PDT)
Received: from balhae.roam.corp.google.com ([112.159.19.5])
        by smtp.gmail.com with ESMTPSA id n12sm18082556pgk.20.2020.10.12.00.02.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2020 00:02:32 -0700 (PDT)
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
Date:   Mon, 12 Oct 2020 16:02:12 +0900
Message-Id: <20201012070214.2074921-5-namhyung@kernel.org>
X-Mailer: git-send-email 2.28.0.1011.ga647a8990f-goog
In-Reply-To: <20201012070214.2074921-1-namhyung@kernel.org>
References: <20201012070214.2074921-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No need to load symbols in a DSO when injecting build-id.  I guess the
reason was to check the DSO is a special file like anon files.  Use
some helper functions in map.c to check them before reading build-id.
Also pass sample event's cpumode to a new build-id event.

It brought a speedup in the benchmark of 25 -> 21 msec on my laptop.
Also the memory usage (Max RSS) went down by ~200 KB.

  # Running 'internals/inject-build-id' benchmark:
    Average build-id injection took: 21.389 msec (+- 0.138 msec)
    Average time per event: 2.097 usec (+- 0.014 usec)
    Average memory usage: 8225 KB (+- 0 KB)

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
2.28.0.1011.ga647a8990f-goog

