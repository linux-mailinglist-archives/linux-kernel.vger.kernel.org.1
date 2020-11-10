Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF5962AD31D
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 11:05:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732067AbgKJKEr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 05:04:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731729AbgKJKER (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 05:04:17 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3A9DC0613D1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 02:04:15 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id k10so6748334pfh.17
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 02:04:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=Sh/0QbfpyBISYZm1ueGZyhZ7Zpfk7dKLcbQRbbsbtMo=;
        b=pJ4R94Wzv239XG323FxsHetBCnjilNMjZsyiA+0jlwno+xwvsQ/f4mdxhy4MJHARwC
         Z5tVO2m0q4Lv4EFIYRIB+FeMmlBp40cbaoygXQCoWDWd3U0IW8x5fj/CxOVKokr7uJ42
         SboaO9uTMUtEgMgyvYLv/FN6gnj4RycriVjcXsI9SUljb3lwZsJLStZyLdqtq0Nj5or7
         DDUeyVZ94sdOet/YnV1CkB5/WTds/MZKEWYNeiy0JdBKZuHN0kWcWAm6bVBsn3oGZpkd
         DmBk6T8+ZKpjZQXskdZY2IcHKEMhkeXNIQpwdNybPygLrTxQUuaJaImGe7Ggr0/WgH2n
         1kXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Sh/0QbfpyBISYZm1ueGZyhZ7Zpfk7dKLcbQRbbsbtMo=;
        b=LDQTov1YCSMMwi3sxFDgrvGEErBdqDycEHsvNRlnQjshTZliHdBUf0inbBsfSVKgmi
         aVIqo5wXPWeY8HJ7kLGXYzdTRH1Fe79DDoCih51Z2hX7R0PE6NVADZhXPCInoi+HkGct
         JkLewKIZdk8kH/seHy+AdKyhVKNtNMahvGjDxSSISwqwVKB3X8BsRVShWKj+NKDPQQMx
         hMUVl6/B2lRpRxwZGAPoJidWHaKXjh2gc4+WbBznw1K8rL9Y9C9FV1vbekoC5Fco6yPN
         tK+Dtg0BNgfzQTYz4j+YeAbdBwydT4Uwr4Gn00p+gFGMAwQxdffYP6Vhv6i82lUrAJTS
         szoQ==
X-Gm-Message-State: AOAM531OptDV71LffbRrwImj16mqdQOewsiupEU1c+xKxMlE/8xTPf+P
        eONNjmFqUGvO4f3mHqxbYjCyCxn0pMTK
X-Google-Smtp-Source: ABdhPJz2/m1fhmMS1qy8OhB+Nis/F8wVKzDX2s3DP8E7SVMCMk9OICU28UUxxkWVIUSsdQUx1BPB4BZ8FTtU
Sender: "irogers via sendgmr" <irogers@irogers.svl.corp.google.com>
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:2:f693:9fff:fef4:4583])
 (user=irogers job=sendgmr) by 2002:a17:90a:db96:: with SMTP id
 h22mr4244472pjv.57.1605002655221; Tue, 10 Nov 2020 02:04:15 -0800 (PST)
Date:   Tue, 10 Nov 2020 02:03:43 -0800
In-Reply-To: <20201110100346.2527031-1-irogers@google.com>
Message-Id: <20201110100346.2527031-10-irogers@google.com>
Mime-Version: 1.0
References: <20201110100346.2527031-1-irogers@google.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8-goog
Subject: [RFC PATCH 09/12] perf topdown-paser: Add code generation API.
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

Add API that is called to generate code using all registered targets.

Co-authored-by: Stephane Eranian <eranian@google.com>
Signed-off-by: Ian Rogers <irogers@google.com>
Signed-off-by: Sandeep Dasgupta <sdasgup@google.com>
---
 .../topdown-parser/code_gen_target.cpp        | 51 ++++++++++++
 .../topdown-parser/code_gen_target.h          | 77 +++++++++++++++++++
 2 files changed, 128 insertions(+)
 create mode 100644 tools/perf/pmu-events/topdown-parser/code_gen_target.cpp
 create mode 100644 tools/perf/pmu-events/topdown-parser/code_gen_target.h

diff --git a/tools/perf/pmu-events/topdown-parser/code_gen_target.cpp b/tools/perf/pmu-events/topdown-parser/code_gen_target.cpp
new file mode 100644
index 000000000000..c6d7ce8eb661
--- /dev/null
+++ b/tools/perf/pmu-events/topdown-parser/code_gen_target.cpp
@@ -0,0 +1,51 @@
+/*
+ * Copyright 2020 Google LLC.
+ * SPDX-License-Identifier: GPL-2.0
+ */
+
+#include "code_gen_target.h"
+
+#include "configuration.h"
+
+namespace topdown_parser
+{
+/**
+ * Dump event list. Used for testing of auto-generation.
+ */
+bool g_DumpEvents = false;
+
+namespace
+{
+/**
+ * `kRegisteredTargets` enumerates all the target supported by the
+ * topdown generator tool. Each target is responsible for generating a
+ * "code", which essentially encodes the topdown metric expressions, in
+ * a particular language or format support.
+ */
+TargetInfo *kRegisteredTargets[] = {
+	&kTargetPerfJson /* target to generate JSon code */,
+};
+
+} // namespace
+
+void CodeGenTarget(
+	const std::unordered_map<std::string, MappedData> &dependence_dag)
+{
+	for (size_t i = 0;
+	     i < sizeof(kRegisteredTargets) / sizeof(TargetInfo *); ++i) {
+		const std::string &target_name = kRegisteredTargets[i]->name;
+
+		if (target_name == kConfigParams->target_) {
+			kRegisteredTargets[i]->codegen_entry_point(
+				dependence_dag);
+			if (kRegisteredTargets[i]
+				    ->codegen_test_harness_entry_point) {
+				kRegisteredTargets[i]
+					->codegen_test_harness_entry_point();
+			}
+			break;
+		}
+	}
+}
+
+} // namespace topdown_parser
diff --git a/tools/perf/pmu-events/topdown-parser/code_gen_target.h b/tools/perf/pmu-events/topdown-parser/code_gen_target.h
new file mode 100644
index 000000000000..ab3e2b48bebc
--- /dev/null
+++ b/tools/perf/pmu-events/topdown-parser/code_gen_target.h
@@ -0,0 +1,77 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+// --------------------------------------------------
+// File: code_gen_target.h
+// --------------------------------------------------
+//
+
+// The header provides the interface `CodeGenTarget` to generate code, encoding
+// the topdown metric expressions, using the data `dependence_dag` read from
+// the input csv file. The language or format of the generated code is the one
+// supported by a specific project (e.g. perf or projects using perf ) to encode
+// the topdown metric metric expressions. We define a `target` as a specific
+// project and use that to guide generation of topdown code in a language
+// supported by the project.
+
+#ifndef TOPDOWN_PARSER_CODE_GEN_TARGET_H_
+#define TOPDOWN_PARSER_CODE_GEN_TARGET_H_
+
+#include <string>
+#include <unordered_map>
+
+namespace topdown_parser
+{
+class MappedData;
+
+/**
+ * Dump event list. Used for testing of auto-generation.
+ */
+extern bool g_DumpEvents;
+
+/**
+ * The structure `TargetInfo` is used to specify a target.
+ */
+struct TargetInfo {
+	/**
+	 * Name of the target. This will be used to invoke code generation for a
+	 * particular target.
+	 */
+	std::string name;
+
+	/**
+	 * Descriptive information of the target (Optional).
+	 */
+	std::string description;
+
+	/**
+	 * The entry point function for generating code.
+	 */
+	void (*codegen_entry_point)(
+		const std::unordered_map<std::string, MappedData>
+			&dependence_dag);
+
+	/**
+	 * Function to generate golden reference for testing the auto-generated
+	 * code.
+	 * (Optional)
+	 */
+	void (*codegen_test_harness_entry_point)();
+};
+
+/**
+ * Target information for generating JSon code for perf encoding the topdown
+ * metric expressions.
+ */
+extern TargetInfo kTargetPerfJson;
+
+/**
+ * `CodeGenTarget` dispatches an appropriate callback, based on the
+ * configuration variable `kConfigParams->target_`, to generate  "code" for a
+ * particular target.
+ */
+void CodeGenTarget(
+	const std::unordered_map<std::string, MappedData> &dependence_dag);
+
+} // namespace topdown_parser
+
+#endif // TOPDOWN_PARSER_CODE_GEN_TARGET_H_
-- 
2.29.2.222.g5d2a92d10f8-goog

