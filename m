Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 945231C74A5
	for <lists+linux-kernel@lfdr.de>; Wed,  6 May 2020 17:27:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730269AbgEFP1C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 May 2020 11:27:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:49920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730260AbgEFP06 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 11:26:58 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BDB8E214D8;
        Wed,  6 May 2020 15:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588778817;
        bh=jgKUSVqFbV6uXdsV3dbnJEwlcXMRJDH+HPY0MEgrnXY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Tm0T8AFIasL9lgxXEU+onr1Hon+TYVIrnquTyluovcJYAYRiTSoAMx+YTfhtgeIaJ
         s0vuosaxsCZFImDREgylfJd7Jf6Gc/kaMHnF4Y3Zxv+9OXRujH2E4sFEm3a8cOE/u8
         680omuDMAv/rhtuKJXQlfWX7FSAjbHvCnz27GYbE=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 75/91] perf evsel: Rename perf_evsel__env() to evsel__env()
Date:   Wed,  6 May 2020 12:22:18 -0300
Message-Id: <20200506152234.21977-76-acme@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200506152234.21977-1-acme@kernel.org>
References: <20200506152234.21977-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

As it is a 'struct evsel' method, not part of tools/lib/perf/, aka
libperf, to whom the perf_ prefix belongs.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 2 +-
 tools/perf/util/annotate.c | 2 +-
 tools/perf/util/evsel.c    | 2 +-
 tools/perf/util/evsel.h    | 2 +-
 tools/perf/util/machine.c  | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 025e190fd1c2..31575713ad0b 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -2382,7 +2382,7 @@ static int trace__fprintf_callchain(struct trace *trace, struct perf_sample *sam
 
 static const char *errno_to_name(struct evsel *evsel, int err)
 {
-	struct perf_env *env = perf_evsel__env(evsel);
+	struct perf_env *env = evsel__env(evsel);
 	const char *arch_name = perf_env__arch(env);
 
 	return arch_syscalls__strerrno(arch_name, err);
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index dc3342f5586b..d828c2d2edee 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -2156,7 +2156,7 @@ int symbol__annotate(struct map_symbol *ms, struct evsel *evsel,
 		.evsel		= evsel,
 		.options	= options,
 	};
-	struct perf_env *env = perf_evsel__env(evsel);
+	struct perf_env *env = evsel__env(evsel);
 	const char *arch_name = perf_env__arch(env);
 	struct arch *arch;
 	int err;
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 5908cd8761d9..32d178a3f933 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -2563,7 +2563,7 @@ int evsel__open_strerror(struct evsel *evsel, struct target *target,
 			 err, str_error_r(err, sbuf, sizeof(sbuf)), evsel__name(evsel));
 }
 
-struct perf_env *perf_evsel__env(struct evsel *evsel)
+struct perf_env *evsel__env(struct evsel *evsel)
 {
 	if (evsel && evsel->evlist)
 		return evsel->evlist->env;
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 9de7efb83ffc..d76111c2d6a8 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -401,7 +401,7 @@ static inline bool evsel__has_br_stack(const struct evsel *evsel)
 	       evsel->synth_sample_type & PERF_SAMPLE_BRANCH_STACK;
 }
 
-struct perf_env *perf_evsel__env(struct evsel *evsel);
+struct perf_env *evsel__env(struct evsel *evsel);
 
 int perf_evsel__store_ids(struct evsel *evsel, struct evlist *evlist);
 #endif /* __PERF_EVSEL_H */
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index da630e9339d3..8ed2135893bb 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -2619,7 +2619,7 @@ static int thread__resolve_callchain_sample(struct thread *thread,
 		chain_nr = chain->nr;
 
 	if (evsel__has_branch_callstack(evsel)) {
-		struct perf_env *env = perf_evsel__env(evsel);
+		struct perf_env *env = evsel__env(evsel);
 
 		err = resolve_lbr_callchain_sample(thread, cursor, sample, parent,
 						   root_al, max_stack,
-- 
2.21.1

