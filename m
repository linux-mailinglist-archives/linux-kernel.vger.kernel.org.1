Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DEDD2752D8
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 10:06:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbgIWIGD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 04:06:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726476AbgIWIF6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 04:05:58 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82B93C061755
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 01:05:58 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id k13so14048244pfg.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 01:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VjchyVySLOehpHoW3JjfG3x5Bul5CV4YSXu818GUPIY=;
        b=ULbbFqVhIZdjHGDgfHEKVqG4S2x4/xbZWSR8iYUJazMjrrLnuJ8uV3xbKTAmZzIPBs
         IVJXU7cs0uLDAeE8WZwYE1+vnmVHCFQlITVMkFJAbdp9dl9RjxgepQaysIaLUmku+BsX
         lIEMKYPq5GHLzOUZKEv62iSiY/XCPRc9LsumLFvlYss+IR7xzeRmzF4laNfS49Ct2XiB
         sKWjqVk8bd/o+hd7ZaydOBVFGXWyFh57eCtZkWFHBY3aeVdEbABv2xWVYThsQYQgqmcd
         dG/vjoL42h83V6di55ct9dV8i4kEwsae347q7ci2kqFScQnwpeCJNNIgzTzVLK1brSTl
         q2SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=VjchyVySLOehpHoW3JjfG3x5Bul5CV4YSXu818GUPIY=;
        b=BHnJ52vb59lwmhVHRljOCFym7vEVpG19N1Qd4dAgtjAVtcsTlnn9/sDR72oQcT5AL4
         flTL1rPkyPTmhfxBC5RfVnpzBG9j3t75PLM7MJxPHM3aEyfAXsGaPyBnYKofL32ty81H
         8xVacGNPdBZjCWadx/S9pWEGZ136IqIqZrMhaJeCcnJIFdImQD63Fcx7f9UiJr8rOisW
         YczBVTcYgLBIPJkyoOZ2+2EG+OVW+vQ77xjFlgFH4dtmSp0Bv/7BPzZHl6Qoe1awb5os
         N1rvYKXMzUpJl3ieSHbJkAMmqtKxoof+ii6R5/EfPcSqLKn0XttuBxM9Dx2BgoexRWQh
         SslA==
X-Gm-Message-State: AOAM533p1ACRusId5bEV8ws9e6/eq58ow8TdFBpdxZC235M69XYR7ffH
        f9/UiZIGzzYXZqq1t3TtImg=
X-Google-Smtp-Source: ABdhPJxEhEvEIxo2REkZ2SljqRFdFQHaab0KOoAmXlOgtZsYaF40YfUwjmT/Xh6Ml4/fL0qQpfQVKw==
X-Received: by 2002:a62:52d3:0:b029:142:2501:3a00 with SMTP id g202-20020a6252d30000b029014225013a00mr7435868pfb.79.1600848358072;
        Wed, 23 Sep 2020 01:05:58 -0700 (PDT)
Received: from balhae.roam.corp.google.com ([101.235.31.111])
        by smtp.gmail.com with ESMTPSA id a27sm17568441pfk.52.2020.09.23.01.05.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2020 01:05:57 -0700 (PDT)
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
Subject: [PATCH 4/7] perf inject: Do not load map/dso when injecting build-id
Date:   Wed, 23 Sep 2020 17:05:34 +0900
Message-Id: <20200923080537.155264-5-namhyung@kernel.org>
X-Mailer: git-send-email 2.28.0.681.g6f77f65b4e-goog
In-Reply-To: <20200923080537.155264-1-namhyung@kernel.org>
References: <20200923080537.155264-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No need to load symbols in a DSO when injecting build-id.  I guess the
reason was to check the DSO is a special file like anon files.  Use
some helper functions in map.c to check them before reading build-id.
Also pass sample event's cpumode to a new build-id event.

It brought a speedup in the benchmark of 22 -> 18 msec on my laptop.

  # Running 'internals/inject-build-id' benchmark:
    Average build-id injection took: 18.259 msec (+- 0.051 msec)
    Average time per event: 1.790 usec (+- 0.005 usec)

Also note that, it reduces memory footprint of perf inject.  I saw
that max RSS went down by ~27MB when processing ~300MB data file.

Original-patch-by: Stephane Eranian <eranian@google.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-inject.c | 30 ++++++++++--------------------
 tools/perf/util/map.c       | 17 +----------------
 tools/perf/util/map.h       | 14 ++++++++++++++
 3 files changed, 25 insertions(+), 36 deletions(-)

diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index 670157db2502..d0aa365e7294 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -436,21 +436,22 @@ static int dso__read_build_id(struct dso *dso)
 }
 
 static int dso__inject_build_id(struct dso *dso, struct perf_tool *tool,
-				struct machine *machine)
+				struct machine *machine, u8 cpumode)
 {
-	u16 misc = PERF_RECORD_MISC_USER;
 	int err;
 
+	if (is_anon_memory(dso->long_name))
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
@@ -477,19 +478,8 @@ int perf_event__inject_buildid(struct perf_tool *tool, union perf_event *event,
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
+					     sample->cpumode);
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

