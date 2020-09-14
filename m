Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 974B7268D55
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 16:20:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbgINOUo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 10:20:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726743AbgINOTP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 10:19:15 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECFD9C061788
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 07:19:14 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id n14so12763137pff.6
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 07:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=95cfA1yTaY+9Nluh9izZpcVnPxKuRp3WYjl2ZT5oewQ=;
        b=XE6pTn0abYaa4eC9E4gPJTaMaTtumX0ZxLLhlLYHSJywhNlp5pqUBGTrswKvjTBZ//
         6WBPio7VGUVsak8SWifSe1Hz7tW6QYb9so+LTm6kMb5taEz3NYhBWh+U64bS6RBjvthw
         6tfUpoK83T//1GdqzNq3Y394Hh50XrYm6/HuaV3LW4Hm9yaVJq1Ripb1ffKmcq2BstUd
         iTpSqTTgBp2eVRwXpB8aDt3gUhXWSQ7S60k+gUqSRn13udg/ejPRC0R+QxGZWmYNUNkW
         XdWm/5KwS7vQpqXfkS5b0JpR3fZh88ncTF+BdvQ0s+CbozN6TUHnWK283qzkI4ACN9C5
         xhFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=95cfA1yTaY+9Nluh9izZpcVnPxKuRp3WYjl2ZT5oewQ=;
        b=g4wOk+u5lRgamDdy1KBcM9vh+veDVp/ftRVolamxWtP1M7dTk+CWHGXYbuuAXXOfah
         rnxp8y3Aj9L7eWSQOsAOKVxFRS9Gm0S8KozSf9p25Z2OkiznnCi8daYdduHlZJ/i7v3y
         WQ6m37+1D/OUK2tP/YtsQBXLRwlhvUO4llc1aLk6ATbF2hYTxvGbYvrYUa2//3R+e2Vb
         8hEXmrXuAbX8rX8gENlkJNJ6GLX0Nbjk3JSIl8D5ktqA9QfAuealsDBCrFxSdVoiA4TH
         05mFnpnwe5dhUtuYiT2CAmSegGWdFN50rRWdXGkOlie7hULVRrMUXagUbicSdxdx32lM
         WajA==
X-Gm-Message-State: AOAM53078XEVhnx/EbLThAscWNJHJKnMoSJ3N3LwbvarwWjVrM6f9FNZ
        f2Rypk52KE6biw5POgIyt1c=
X-Google-Smtp-Source: ABdhPJzoAqdCxihFBQrXKz5whRGt3wRxg6dAaXFbvVW3PfA/Gn45mYzisJD4hoQ10atoSfxD632CLA==
X-Received: by 2002:a17:902:8303:: with SMTP id bd3mr2719465plb.86.1600093154213;
        Mon, 14 Sep 2020 07:19:14 -0700 (PDT)
Received: from balhae.roam.corp.google.com ([101.235.31.111])
        by smtp.gmail.com with ESMTPSA id c3sm9209440pfn.23.2020.09.14.07.19.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 07:19:13 -0700 (PDT)
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>
Subject: [PATCH 3/3] perf inject: Do not load map/dso when injecting build-id
Date:   Mon, 14 Sep 2020 23:18:59 +0900
Message-Id: <20200914141859.332459-3-namhyung@kernel.org>
X-Mailer: git-send-email 2.28.0.618.gf4bc123cb7-goog
In-Reply-To: <20200914141859.332459-1-namhyung@kernel.org>
References: <20200914141859.332459-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No need to load symbols in a DSO when injecting build-id.  I guess the
reason was to check the DSO is a special file like anon files.  Use
some helper functions in map.c to check them before reading build-id.
Also pass sample event's cpumode to a new build-id event.

Original-patch-by: Stephane Eranian <eranian@google.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-inject.c | 30 ++++++++++--------------------
 tools/perf/util/map.c       | 17 +----------------
 tools/perf/util/map.h       | 14 ++++++++++++++
 3 files changed, 25 insertions(+), 36 deletions(-)

diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index a2804d906d2a..6d4e6833efed 100644
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
@@ -478,19 +479,8 @@ static int perf_event__inject_buildid(struct perf_tool *tool,
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
2.28.0.618.gf4bc123cb7-goog

