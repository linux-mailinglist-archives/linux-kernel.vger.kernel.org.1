Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B6D22E88CB
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Jan 2021 23:06:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbhABWF5 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 2 Jan 2021 17:05:57 -0500
Received: from us-smtp-delivery-44.mimecast.com ([207.211.30.44]:31562 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726686AbhABWF4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jan 2021 17:05:56 -0500
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-27-ys6yUxg-Pr2T3sB4BieA8A-1; Sat, 02 Jan 2021 17:05:00 -0500
X-MC-Unique: ys6yUxg-Pr2T3sB4BieA8A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AC125800D62;
        Sat,  2 Jan 2021 22:04:58 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.192.22])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B666D19727;
        Sat,  2 Jan 2021 22:04:55 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>,
        Alexei Budankov <abudankov@huawei.com>
Subject: [PATCH 04/22] perf tools: Add perf_home_perfconfig function
Date:   Sat,  2 Jan 2021 23:04:23 +0100
Message-Id: <20210102220441.794923-5-jolsa@kernel.org>
In-Reply-To: <20210102220441.794923-1-jolsa@kernel.org>
References: <20210102220441.794923-1-jolsa@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jolsa@kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kernel.org
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=WINDOWS-1252
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Factor out the perf_home_perfconfig, that looks for
.perfconfig in home directory including check for
PERF_CONFIG_NOGLOBAL and for proper permission.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/config.c | 89 ++++++++++++++++++++++++----------------
 tools/perf/util/config.h |  1 +
 2 files changed, 54 insertions(+), 36 deletions(-)

diff --git a/tools/perf/util/config.c b/tools/perf/util/config.c
index 222cb2e2de25..34fe80ccdad1 100644
--- a/tools/perf/util/config.c
+++ b/tools/perf/util/config.c
@@ -531,6 +531,56 @@ static int perf_config_global(void)
 	return !perf_env_bool("PERF_CONFIG_NOGLOBAL", 0);
 }
 
+static char *home_perfconfig(void)
+{
+	const char *home = NULL;
+	char *config;
+	struct stat st;
+
+	home = getenv("HOME");
+
+	/*
+	 * Skip reading user config if:
+	 *   - there is no place to read it from (HOME)
+	 *   - we are asked not to (PERF_CONFIG_NOGLOBAL=1)
+	 */
+	if (!home || !*home || !perf_config_global())
+		return NULL;
+
+	config = strdup(mkpath("%s/.perfconfig", home));
+	if (config == NULL) {
+		pr_warning("Not enough memory to process %s/.perfconfig, ignoring it.", home);
+		return NULL;
+	}
+
+	if (stat(config, &st) < 0)
+		goto out_free;
+
+	if (st.st_uid && (st.st_uid != geteuid())) {
+		pr_warning("File %s not owned by current user or root, ignoring it.", config);
+		goto out_free;
+	}
+
+	if (st.st_size)
+		return config;
+
+out_free:
+	free(config);
+	return NULL;
+}
+
+const char *perf_home_perfconfig(void)
+{
+	static const char *config;
+	static bool failed;
+
+	config = failed ? NULL : home_perfconfig();
+	if (!config)
+		failed = true;
+
+	return config;
+}
+
 static struct perf_config_section *find_section(struct list_head *sections,
 						const char *section_name)
 {
@@ -676,9 +726,6 @@ int perf_config_set__collect(struct perf_config_set *set, const char *file_name,
 static int perf_config_set__init(struct perf_config_set *set)
 {
 	int ret = -1;
-	const char *home = NULL;
-	char *user_config;
-	struct stat st;
 
 	/* Setting $PERF_CONFIG makes perf read _only_ the given config file. */
 	if (config_exclusive_filename)
@@ -687,41 +734,11 @@ static int perf_config_set__init(struct perf_config_set *set)
 		if (perf_config_from_file(collect_config, perf_etc_perfconfig(), set) < 0)
 			goto out;
 	}
-
-	home = getenv("HOME");
-
-	/*
-	 * Skip reading user config if:
-	 *   - there is no place to read it from (HOME)
-	 *   - we are asked not to (PERF_CONFIG_NOGLOBAL=1)
-	 */
-	if (!home || !*home || !perf_config_global())
-		return 0;
-
-	user_config = strdup(mkpath("%s/.perfconfig", home));
-	if (user_config == NULL) {
-		pr_warning("Not enough memory to process %s/.perfconfig, ignoring it.", home);
-		goto out;
-	}
-
-	if (stat(user_config, &st) < 0) {
-		if (errno == ENOENT)
-			ret = 0;
-		goto out_free;
-	}
-
-	ret = 0;
-
-	if (st.st_uid && (st.st_uid != geteuid())) {
-		pr_warning("File %s not owned by current user or root, ignoring it.", user_config);
-		goto out_free;
+	if (perf_config_global() && perf_home_perfconfig()) {
+		if (perf_config_from_file(collect_config, perf_home_perfconfig(), set) < 0)
+			goto out;
 	}
 
-	if (st.st_size)
-		ret = perf_config_from_file(collect_config, user_config, set);
-
-out_free:
-	free(user_config);
 out:
 	return ret;
 }
diff --git a/tools/perf/util/config.h b/tools/perf/util/config.h
index ee5a242446e9..d6c4f80f367c 100644
--- a/tools/perf/util/config.h
+++ b/tools/perf/util/config.h
@@ -37,6 +37,7 @@ int perf_config_u64(u64 *dest, const char *, const char *);
 int perf_config_bool(const char *, const char *);
 int config_error_nonbool(const char *);
 const char *perf_etc_perfconfig(void);
+const char *perf_home_perfconfig(void);
 
 struct perf_config_set *perf_config_set__new(void);
 struct perf_config_set *perf_config_set__load_file(const char *file);
-- 
2.26.2

