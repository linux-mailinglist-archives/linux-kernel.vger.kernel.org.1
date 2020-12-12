Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5C3B2D85FB
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Dec 2020 11:47:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438710AbgLLKp4 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 12 Dec 2020 05:45:56 -0500
Received: from us-smtp-delivery-44.mimecast.com ([207.211.30.44]:46386 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2407360AbgLLKpO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Dec 2020 05:45:14 -0500
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-559-9dBKlzBGPPWFgwAlPfgTEQ-1; Sat, 12 Dec 2020 05:44:16 -0500
X-MC-Unique: 9dBKlzBGPPWFgwAlPfgTEQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E2EEA1005504;
        Sat, 12 Dec 2020 10:44:14 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.192.32])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D912460CCE;
        Sat, 12 Dec 2020 10:44:11 +0000 (UTC)
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
Subject: [PATCH 3/8] perf tools: Add config set interface
Date:   Sat, 12 Dec 2020 11:43:53 +0100
Message-Id: <20201212104358.412065-4-jolsa@kernel.org>
In-Reply-To: <20201212104358.412065-1-jolsa@kernel.org>
References: <20201212104358.412065-1-jolsa@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jolsa@kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kernel.org
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=WINDOWS-1252
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add interface to load config set from custom file
by using perf_config_set__new_file function.

It will be used in perf daemon command to process
custom config file.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/config.c | 28 +++++++++++++++++++++++-----
 tools/perf/util/config.h |  3 +++
 2 files changed, 26 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/config.c b/tools/perf/util/config.c
index 6969f82843ee..dc3f03f8bbf5 100644
--- a/tools/perf/util/config.c
+++ b/tools/perf/util/config.c
@@ -738,6 +738,18 @@ struct perf_config_set *perf_config_set__new(void)
 	return set;
 }
 
+struct perf_config_set *perf_config_set__new_file(const char *file)
+{
+	struct perf_config_set *set = zalloc(sizeof(*set));
+
+	if (set) {
+		INIT_LIST_HEAD(&set->sections);
+		perf_config_from_file(collect_config, file, set);
+	}
+
+	return set;
+}
+
 static int perf_config__init(void)
 {
 	if (config_set == NULL)
@@ -746,17 +758,15 @@ static int perf_config__init(void)
 	return config_set == NULL;
 }
 
-int perf_config(config_fn_t fn, void *data)
+int perf_config_set(struct perf_config_set *set,
+		    config_fn_t fn, void *data)
 {
 	int ret = 0;
 	char key[BUFSIZ];
 	struct perf_config_section *section;
 	struct perf_config_item *item;
 
-	if (config_set == NULL && perf_config__init())
-		return -1;
-
-	perf_config_set__for_each_entry(config_set, section, item) {
+	perf_config_set__for_each_entry(set, section, item) {
 		char *value = item->value;
 
 		if (value) {
@@ -778,6 +788,14 @@ int perf_config(config_fn_t fn, void *data)
 	return ret;
 }
 
+int perf_config(config_fn_t fn, void *data)
+{
+	if (config_set == NULL && perf_config__init())
+		return -1;
+
+	return perf_config_set(config_set, fn, data);
+}
+
 void perf_config__exit(void)
 {
 	perf_config_set__delete(config_set);
diff --git a/tools/perf/util/config.h b/tools/perf/util/config.h
index 8c881e3a3ec3..f58b457e7e5f 100644
--- a/tools/perf/util/config.h
+++ b/tools/perf/util/config.h
@@ -30,6 +30,8 @@ typedef int (*config_fn_t)(const char *, const char *, void *);
 int perf_config_from_file(config_fn_t fn, const char *filename, void *data);
 int perf_default_config(const char *, const char *, void *);
 int perf_config(config_fn_t fn, void *);
+int perf_config_set(struct perf_config_set *set,
+		    config_fn_t fn, void *data);
 int perf_config_int(int *dest, const char *, const char *);
 int perf_config_u8(u8 *dest, const char *name, const char *value);
 int perf_config_u64(u64 *dest, const char *, const char *);
@@ -38,6 +40,7 @@ int config_error_nonbool(const char *);
 const char *perf_etc_perfconfig(void);
 
 struct perf_config_set *perf_config_set__new(void);
+struct perf_config_set *perf_config_set__new_file(const char *file);
 void perf_config_set__delete(struct perf_config_set *set);
 int perf_config_set__collect(struct perf_config_set *set, const char *file_name,
 			     const char *var, const char *value);
-- 
2.26.2

