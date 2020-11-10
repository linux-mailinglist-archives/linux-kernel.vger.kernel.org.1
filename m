Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 376342AD310
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 11:04:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731198AbgKJKEH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 05:04:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730824AbgKJKEG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 05:04:06 -0500
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8DCBC0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 02:04:05 -0800 (PST)
Received: by mail-qv1-xf49.google.com with SMTP id s5so3939755qvm.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 02:04:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=ArCbrSx70dCIk7ufmqy+hBV5Cv+6h8puV2QoRSi5mlw=;
        b=k5Gj6viwYpUog6IR8+XtFPi7XRodJlD4YByxU8dYAz57J8ziGXu3rX6DyoWFDnQsb6
         RGZv6PJoLsD7+HEgGqXUncJbIoT+x8IqMLjMGCxHJIB8QxmbYbxDrMwqm9uWGL710H1S
         HHNoY0lK+okOJ1PeSDqqBVJTNUg/WrB8c0iZS8BZ+0CYkvMsAkb1hT0/NcTCCyjtpECy
         XYguMACE8Rw1LJGokKat44UUHEUVRBrkdj/MoC+QF46+JtDrQa0xNmtnyKtsM0IcP0uX
         CIosrUSpQzDIA388XnEuoKUrDY685Wwy7FnAoeTZ+4Huc2ZA9F4p7dN+NmEd8ayxWj+u
         3mLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ArCbrSx70dCIk7ufmqy+hBV5Cv+6h8puV2QoRSi5mlw=;
        b=BRwchv3ps0x1yayhyE77ILaSiqUzMcGfG88Fm7KngBWZPuzmQtoNn++Faw6cUsEMch
         po8mH6S2bOZc881yEJmWQwVnzA67AHNs8MWQZnM9Xtv6R6Bv+4cLfSeLix6PiPFCwnEM
         T174jPFd5Aqp4B775KEUKttxDlyVnQpYVNPhoRN6S+NFhnJPm4iKY1E+f0nfCapw/oAX
         sErqFx8Goc7phqwTuybY89Ae1vqXUHqnRmq2Pjb2y61EwdRo1cOgykSOy1KJRIqdU9iJ
         bSWFp/vmipmnj1NH35j1TEeXbT+BwPrYweCGNP15tJZX78eQekxBF8M60+j1kdnYVfzq
         I4NQ==
X-Gm-Message-State: AOAM531bHzv4SnCHF+7tNieAfugenyy8AB2J8H8PJMnUDKnMucW5TYX9
        1+VxoXyQIKeqzZ54is7fXgtZqgwbu/bz
X-Google-Smtp-Source: ABdhPJwR4wnQpYB3LFx9kyujqqW4HS+RnzUL0OWS8iwCdneKsmKeJJnwajiRcMSVY3qCdow6+/iTDXeyhwA2
Sender: "irogers via sendgmr" <irogers@irogers.svl.corp.google.com>
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:2:f693:9fff:fef4:4583])
 (user=irogers job=sendgmr) by 2002:a0c:c18a:: with SMTP id
 n10mr19061238qvh.54.1605002644810; Tue, 10 Nov 2020 02:04:04 -0800 (PST)
Date:   Tue, 10 Nov 2020 02:03:38 -0800
In-Reply-To: <20201110100346.2527031-1-irogers@google.com>
Message-Id: <20201110100346.2527031-5-irogers@google.com>
Mime-Version: 1.0
References: <20201110100346.2527031-1-irogers@google.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8-goog
Subject: [RFC PATCH 04/12] perf topdown-parser: Add a json file reader.
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        Paul Clarke <pc@us.ibm.com>, kajoljain <kjain@linux.ibm.com>
Cc:     Stephane Eranian <eranian@google.com>,
        Sandeep Dasgupta <sdasgup@google.com>,
        linux-perf-users@vger.kernel.org, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sandeep Dasgupta <sdasgup@google.com>

Wrap jsmn as a "C" library. Add some utilities for working with tokens
and to read a vector of tokens.

Co-authored-by: Ian Rogers <irogers@google.com>
Signed-off-by: Ian Rogers <irogers@google.com>
Signed-off-by: Sandeep Dasgupta <sdasgup@google.com>
---
 .../pmu-events/topdown-parser/jsmn_extras.cpp | 199 ++++++++++++++++++
 .../pmu-events/topdown-parser/jsmn_extras.h   |  42 ++++
 2 files changed, 241 insertions(+)
 create mode 100644 tools/perf/pmu-events/topdown-parser/jsmn_extras.cpp
 create mode 100644 tools/perf/pmu-events/topdown-parser/jsmn_extras.h

diff --git a/tools/perf/pmu-events/topdown-parser/jsmn_extras.cpp b/tools/perf/pmu-events/topdown-parser/jsmn_extras.cpp
new file mode 100644
index 000000000000..83a15b636378
--- /dev/null
+++ b/tools/perf/pmu-events/topdown-parser/jsmn_extras.cpp
@@ -0,0 +1,199 @@
+#include "jsmn_extras.h"
+
+#include <cassert>
+#include <cstring>
+#include <functional>
+#include <memory>
+
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <fcntl.h>
+#include <unistd.h>
+
+#include "logging.h"
+
+namespace topdown_parser
+{
+int jsoneq(const char *json, const jsmntok_t *tok, const char *s)
+{
+	if (tok->type == JSMN_STRING &&
+	    static_cast<int>(strlen(s)) == tok->end - tok->start &&
+	    strncmp(json + tok->start, s, tok->end - tok->start) == 0) {
+		return 0;
+	}
+	return -1;
+}
+
+int get_primitive(const char *js, const jsmntok_t *t, int i,
+		  std::string *retval)
+{
+	if (t[i].type != JSMN_STRING && t[i].type != JSMN_PRIMITIVE) {
+		assert(0);
+	}
+	const jsmntok_t *g = t + i;
+	(*retval) = std::string(js + g->start, g->end - g->start);
+	return i;
+}
+
+// Parse the following pattern of key-values
+//  A:B
+int get_key_val(const char *js, const jsmntok_t *t, int i,
+		std::pair<std::string, std::string> *P)
+{
+	assert(t[i].type == JSMN_STRING);
+	i = get_primitive(js, t, i, &((*P).first));
+
+	i++;
+	i = get_primitive(js, t, i, &((*P).second));
+
+	return i;
+}
+
+int get_array_of_primitives(const char *js, const jsmntok_t *t, int i,
+			    std::vector<std::string> *V)
+{
+	int j;
+	if (t[i].type != JSMN_ARRAY) {
+		assert(0);
+	}
+	int size = t[i].size;
+	if (size == 0) {
+		return i;
+	}
+
+	i++;
+	std::string retval;
+
+	for (j = 0; j < size - 1; j++) {
+		i = get_primitive(js, t, i, &retval);
+		(*V).push_back(retval);
+		i++;
+	}
+	i = get_primitive(js, t, i, &retval);
+	(*V).push_back(retval);
+
+	return i;
+}
+
+int get_struct(const char *js, const jsmntok_t *t, int i,
+	       std::map<std::string, std::string> *data)
+{
+	int j;
+	if (t[i].type != JSMN_OBJECT) {
+		assert(0);
+	}
+
+	int size = t[i].size;
+	i++;
+
+	for (j = 0; j < size - 2; j += 2) {
+		std::pair<std::string, std::string> P;
+		i = get_key_val(js, t, i, &P);
+		(*data).insert(P);
+		i++;
+	}
+	std::pair<std::string, std::string> P;
+	i = get_key_val(js, t, i, &P);
+	(*data).insert(P);
+	return i;
+}
+
+int get_struct_of_array(
+	const char *js, const jsmntok_t *t, int i,
+	std::unordered_map<std::string, std::vector<std::string> > *data)
+{
+	if (t[i].type != JSMN_OBJECT) {
+		assert(0);
+	}
+
+	int size = t[i].size;
+	i++;
+
+	std::string key;
+	for (int j = 0; j < size - 2; j += 2) {
+		i = get_primitive(js, t, i, &key);
+		i++;
+
+		i = get_array_of_primitives(js, t, i, &((*data)[key]));
+		i++;
+	}
+	i = get_primitive(js, t, i, &key);
+	i++;
+	i = get_array_of_primitives(js, t, i, &((*data)[key]));
+	return i;
+}
+
+/**
+ * ParseJson parses a json file file 'fname' and delegate the processing of the
+ * parsed model to an external callback function 'callback' provided by the
+ * clients of the function.
+ *
+ * The clients using the following routine are:
+ * 1. ReadEventInfoFromJson: Parsing the event encoding json file for each CPU
+ *    as downloaded from  https://download.01.org/perfmon/
+ * 2. ReadConfig: Parsing the configuration.json file, which specifies the
+ *    parameters for the topdown_parser tool.
+ */
+int ParseJson(const char *fname,
+	      void (*callback)(const char *, const jsmntok_t *, int, void *),
+	      void *metainfo)
+{
+	// Read the file fully into js.
+	int fd = open(fname, O_RDONLY);
+	if (fd == -1) {
+		ERROR("Failed to open '" << fname << "': " << strerror(errno));
+		return 1;
+	}
+	struct stat statbuf;
+	if (fstat(fd, &statbuf) == -1) {
+		ERROR("Failed to stat '" << fname << "': " << strerror(errno));
+		close(fd);
+		return 2;
+	}
+
+	std::unique_ptr<char[]> js(new char[statbuf.st_size]);
+	if (read(fd, js.get(), statbuf.st_size) < 0) {
+		ERROR("Failed to read '" << fname << "': " << strerror(errno));
+		close(fd);
+		return 3;
+	}
+	close(fd);
+
+	// Prepare parser.
+	jsmn_parser p;
+	jsmn_init(&p);
+
+	// Allocate some tokens as a start then iterate until resizing is
+	// unnecessary.
+	std::vector<jsmntok_t> tok;
+	tok.resize(32);
+
+	jsmnerr_t r;
+	do {
+		r = jsmn_parse(&p, js.get(), statbuf.st_size, tok.data(),
+			       tok.size());
+		if (r == JSMN_ERROR_NOMEM) {
+			tok.resize(tok.size() * 2);
+		}
+	} while (r == JSMN_ERROR_NOMEM);
+
+	switch (r) {
+	default:
+		ERROR("Json parse error " << r << " in '" << fname << "' at "
+					  << p.pos);
+		return 4;
+	case JSMN_ERROR_INVAL:
+		ERROR("Invalid character in '" << fname << "' at " << p.pos);
+		return 5;
+	case JSMN_ERROR_PART:
+		ERROR("Incomplete json packet in '" << fname << "' at "
+						    << p.pos);
+		return 6;
+	case JSMN_SUCCESS:
+		break;
+	}
+	(*callback)(js.get(), tok.data(), p.toknext, metainfo);
+	return 0;
+}
+
+} // namespace topdown_parser
diff --git a/tools/perf/pmu-events/topdown-parser/jsmn_extras.h b/tools/perf/pmu-events/topdown-parser/jsmn_extras.h
new file mode 100644
index 000000000000..b6721e50f064
--- /dev/null
+++ b/tools/perf/pmu-events/topdown-parser/jsmn_extras.h
@@ -0,0 +1,42 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+// --------------------------------------------------
+// File: jsmn_extras.h
+// --------------------------------------------------
+//
+
+// The header provides additional helpers based on the jsmn library.
+
+#ifndef JSMN_EXTRAS_H_
+#define JSMN_EXTRAS_H_
+
+#include <cstdlib>
+extern "C" {
+#include "../jsmn.h"
+}
+#include <map>
+#include <string>
+#include <unordered_map>
+#include <vector>
+
+namespace topdown_parser
+{
+int jsoneq(const char *json, const jsmntok_t *tok, const char *s);
+int get_primitive(const char *js, const jsmntok_t *t, int i,
+		  std::string *retval);
+int get_key_val(const char *js, const jsmntok_t *t, int i,
+		std::pair<std::string, std::string> *P);
+int get_array_of_primitives(const char *js, const jsmntok_t *t, int i,
+			    std::vector<std::string> *V);
+int get_struct(const char *js, const jsmntok_t *t, int i,
+	       std::map<std::string, std::string> *data);
+int get_struct_of_array(
+	const char *js, const jsmntok_t *t, int i,
+	std::unordered_map<std::string, std::vector<std::string> > *data);
+int ParseJson(const char *fname,
+	      void (*callback)(const char *, const jsmntok_t *, int, void *),
+	      void *metainfo);
+
+} // namespace topdown_parser
+
+#endif // JSMN_EXTRAS_H_
-- 
2.29.2.222.g5d2a92d10f8-goog

