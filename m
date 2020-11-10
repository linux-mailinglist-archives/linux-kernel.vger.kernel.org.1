Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3E772AD311
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 11:04:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731421AbgKJKEN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 05:04:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731275AbgKJKEJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 05:04:09 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB9C0C0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 02:04:07 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id t10so3806977ply.9
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 02:04:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=LAkPMr/C9vJ3XvgraexiVXeAtdlD8g6fjbM+NEWJZ64=;
        b=fFT5v3ZOOG+Ca8JZYGS0z7qB/JaYwr6GkbQRGSckPK7oFGHL+10gX3aN4SEl4YCvN0
         2TCeIvLm/73SovgSqvTd44kIP7p4WTat+7JJ9tImso8im5x0logCMLVai9fkbeNSsByl
         7C1vQPp2/NeyN25rFcjdlliw9OdaYXiTUBhD9h1hpIcHnnYb96PTEKyEtGG6uaEGJ/O0
         c1OTmhrWEeh1adRl2w+6p0kPX/IgwVkKp69MeM/sJJEpOhnZXUOd4JnJiD+aCKpvy985
         NffDdPuPD0qiUcNjzYrLcPxeVkeZEULBfYSklo6U0pYu0xNqcWBZ/GfnGfgeHOs+HKX4
         OgLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=LAkPMr/C9vJ3XvgraexiVXeAtdlD8g6fjbM+NEWJZ64=;
        b=rXxn6GIzk/Uq8WFAxv8Flub1q0mnQHP8um5jUfYdcZ1WkhcMRNCen8c9YRGC8b9Xjv
         Ms8qLj53p086mbqVfgGbclzM6Xy57XXWo7sqtkXAq2D6tXjK1wD/t/CSRPYtHJM+iB9A
         spsr/LRXk9014RBxGUWa0enozAW9OLrswRCTqUzXLT5/o1xoOUouJyCSvJ+gO0nQXc9M
         N16ByyZl0Ek4K1yHfJohr10S/Qel0VtrWt6XS7ATHbWvIflfCazghjxWX59xBK6yHU7X
         z59ekYo19kw3guRlKLfO3g35asx9oEab7foUoY/Fli35q/mLZwnOo7JSwurwdgf+5ZGF
         ACbQ==
X-Gm-Message-State: AOAM530dsMxyiLeM8a+6Mbzh+U3DndPyKarMdff+zGqTkSSiZutRK/VW
        lGM6Y4nvHtnGTGt9FqgqNO1WlQAjqwYR
X-Google-Smtp-Source: ABdhPJyU+GKnonqZCgpzUHq44BlkYfvSofpMPhwQ5kaOpvdQLcSZkDySe0s/xe4PgQj8eDU/CtorQaNQbDz3
Sender: "irogers via sendgmr" <irogers@irogers.svl.corp.google.com>
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:2:f693:9fff:fef4:4583])
 (user=irogers job=sendgmr) by 2002:a62:6103:0:b029:18c:4489:b0ef with SMTP id
 v3-20020a6261030000b029018c4489b0efmr3716060pfb.4.1605002647023; Tue, 10 Nov
 2020 02:04:07 -0800 (PST)
Date:   Tue, 10 Nov 2020 02:03:39 -0800
In-Reply-To: <20201110100346.2527031-1-irogers@google.com>
Message-Id: <20201110100346.2527031-6-irogers@google.com>
Mime-Version: 1.0
References: <20201110100346.2527031-1-irogers@google.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8-goog
Subject: [RFC PATCH 05/12] perf topdown-parser: Add a configuration.
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

The configuration.json holds configuration data that will be read
into the ConfigurationParameters class in configuration.h.

Co-authored-by: Ian Rogers <irogers@google.com>
Signed-off-by: Ian Rogers <irogers@google.com>
Signed-off-by: Sandeep Dasgupta <sdasgup@google.com>
---
 .../topdown-parser/configuration.cpp          | 198 ++++++++++++++++++
 .../pmu-events/topdown-parser/configuration.h | 181 ++++++++++++++++
 .../topdown-parser/configuration.json         |  72 +++++++
 3 files changed, 451 insertions(+)
 create mode 100644 tools/perf/pmu-events/topdown-parser/configuration.cpp
 create mode 100644 tools/perf/pmu-events/topdown-parser/configuration.h
 create mode 100644 tools/perf/pmu-events/topdown-parser/configuration.json

diff --git a/tools/perf/pmu-events/topdown-parser/configuration.cpp b/tools/perf/pmu-events/topdown-parser/configuration.cpp
new file mode 100644
index 000000000000..6cb4dffe7755
--- /dev/null
+++ b/tools/perf/pmu-events/topdown-parser/configuration.cpp
@@ -0,0 +1,198 @@
+/*
+ * Copyright 2020 Google LLC.
+ * SPDX-License-Identifier: GPL-2.0
+ */
+
+#include "configuration.h"
+
+#include <cassert>
+
+#include "jsmn_extras.h"
+#include "logging.h"
+
+namespace topdown_parser
+{
+/**
+ * kConfigParams is the set of all the parameters defined by the
+ * configuration.json file.
+ */
+ConfigurationParameters *const kConfigParams =
+	ConfigurationParameters::GetConfigurationParameters();
+
+ConfigurationParameters *ConfigurationParameters::config_param_instance_ =
+	nullptr;
+
+namespace
+{
+/**
+ * Parse the 'configuration.json' file to populate the configuration
+ * parameters `kConfigParams`. Each key in the Json file corresponds to
+ * a parameter in `kConfigParams`.
+ */
+void ParseConfigJson(const char *js, const jsmntok_t *t, int r,
+		     void *metainfo __attribute__((unused)))
+{
+	for (int i = 1; i < r; ++i) {
+		if (jsoneq(js, &t[i], "configuration") == 0) {
+			i++;
+			assert(t[i].type == JSMN_OBJECT);
+			continue;
+		}
+
+		if (jsoneq(js, &t[i], "_COMMENT_") == 0) {
+			i++;
+			continue;
+		}
+
+		if (jsoneq(js, &t[i], "target") == 0) {
+			i++;
+			std::string retval;
+			i = get_primitive(js, t, i, &retval);
+			kConfigParams->target_ = retval;
+			continue;
+		}
+
+		if (jsoneq(js, &t[i], "metric_max_header") == 0) {
+			i++;
+			std::string retval;
+			i = get_primitive(js, t, i, &retval);
+			if (!retval.empty()) {
+				kConfigParams->metric_max_header_ =
+					stoi(retval);
+			}
+			continue;
+		}
+
+		if (jsoneq(js, &t[i], "header_row") == 0) {
+			i++;
+			std::string retval;
+			i = get_primitive(js, t, i, &retval);
+			if (!retval.empty()) {
+				kConfigParams->header_row = stoi(retval) - 1;
+			}
+			continue;
+		}
+
+		if (jsoneq(js, &t[i], "formula_start_colm") == 0) {
+			i++;
+			std::string retval;
+			i = get_primitive(js, t, i, &retval);
+			if (!retval.empty()) {
+				kConfigParams->formula_start_colm_ =
+					retval[0] - 'A';
+			}
+			continue;
+		}
+
+		if (jsoneq(js, &t[i], "formula_end_colm") == 0) {
+			i++;
+			std::string retval;
+			i = get_primitive(js, t, i, &retval);
+			if (!retval.empty()) {
+				kConfigParams->formula_end_colm_ =
+					retval[0] - 'A';
+			}
+			continue;
+		}
+
+		if (jsoneq(js, &t[i], "server_identifier_row") == 0) {
+			i++;
+			std::string retval;
+			i = get_primitive(js, t, i, &retval);
+			if (!retval.empty()) {
+				kConfigParams->server_identifier_row_ =
+					stoi(retval) - 1;
+			}
+			continue;
+		}
+
+		if (jsoneq(js, &t[i], "first_level") == 0) {
+			i++;
+			std::string retval;
+			i = get_primitive(js, t, i, &retval);
+			if (!retval.empty()) {
+				kConfigParams->first_level_ = stoi(retval);
+			}
+			continue;
+		}
+
+		if (jsoneq(js, &t[i], "last_level") == 0) {
+			i++;
+			std::string retval;
+			i = get_primitive(js, t, i, &retval);
+			if (!retval.empty()) {
+				kConfigParams->first_last_ = stoi(retval);
+			}
+			continue;
+		}
+
+		if (jsoneq(js, &t[i], "json_filename_hints") == 0) {
+			i++;
+			i = get_struct(js, t, i,
+				       &(kConfigParams->json_filename_hints_));
+			continue;
+		}
+
+		if (jsoneq(js, &t[i], "output_directory_per_cpu") == 0) {
+			i++;
+			i = get_struct(
+				js, t, i,
+				&(kConfigParams->output_directory_per_cpu_));
+			continue;
+		}
+
+		if (jsoneq(js, &t[i], "perf_stat_switch_names") == 0) {
+			i++;
+			i = get_struct(
+				js, t, i,
+				&(kConfigParams->perf_stat_switch_names_));
+			continue;
+		}
+
+		if (jsoneq(js, &t[i], "filenames_for_fixed_events_vals") == 0) {
+			i++;
+			i = get_struct(
+				js, t, i,
+				&(kConfigParams
+					  ->filenames_for_fixed_events_vals_));
+			continue;
+		}
+
+		if (jsoneq(js, &t[i], "cpu_to_model_number") == 0) {
+			i++;
+			i = get_struct_of_array(
+				js, t, i,
+				&(kConfigParams->cpu_to_model_number_));
+			continue;
+		}
+
+		if (jsoneq(js, &t[i], "selected_cpus") == 0) {
+			i++;
+			i = get_array_of_primitives(
+				js, t, i, &(kConfigParams->selected_cpus_));
+			continue;
+		}
+
+		if (jsoneq(js, &t[i], "dont_care_cpus") == 0) {
+			i++;
+			std::vector<std::string> retval;
+			i = get_array_of_primitives(js, t, i, &retval);
+			kConfigParams->dont_care_cpus_.insert(retval.begin(),
+							      retval.end());
+			continue;
+		}
+
+		FATAL("Unexpected json key: "
+		      << std::string(js + t[i].start, t[i].end - t[i].start));
+	}
+}
+
+} // namespace
+
+int ReadConfig()
+{
+	return ParseJson(kConfigParams->config_file_.c_str(), ParseConfigJson,
+			 nullptr);
+}
+
+} // namespace topdown_parser
diff --git a/tools/perf/pmu-events/topdown-parser/configuration.h b/tools/perf/pmu-events/topdown-parser/configuration.h
new file mode 100644
index 000000000000..4b0767c0c3ef
--- /dev/null
+++ b/tools/perf/pmu-events/topdown-parser/configuration.h
@@ -0,0 +1,181 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+// -----------------------------------------------
+// File: configurations.h
+// -----------------------------------------------
+//
+// The configuration file "configuration.json" mentions a set of parameters for
+// the client to control (1) Generation of auto-generated code, and (2)
+// Parsing of the input csv file.
+// This header file provides the interface `ConfigurationParameters` to access
+// all those parameters.
+// Following is the list of variables defining each configuration parameter.
+//  * output_path_
+//  * filenames_for_fixed_events_vals_
+//  * target_
+//  * selected_cpus_
+//  * dont_care_cpus_
+//  * metric_max_header_
+//  * header_row;
+//  * formula_start_colm_;
+//  * formula_end_colm_;
+//  * server_identifier_row_;
+//  * first_level_;
+//  * first_last_;
+//  * cpu_to_model_number_;
+//  * json_filename_hints_;
+//  * output_directory_per_cpu_;
+//  * perf_stat_switch_names_;
+//
+//  The implementation of interface `ConfigurationParameters` restricts its
+//  instantiation to one object `kConfigParams`
+
+#ifndef TOPDOWN_PARSER_CONFIGURATION_H_
+#define TOPDOWN_PARSER_CONFIGURATION_H_
+
+#include <climits>
+#include <map>
+#include <string>
+#include <unordered_map>
+#include <unordered_set>
+#include <vector>
+
+namespace topdown_parser
+{
+/**
+ *  Read configuration file "configuration.json"
+ */
+int ReadConfig();
+
+class ConfigurationParameters {
+    public:
+	/**
+	 * The input configuration file name
+	 */
+	std::string config_file_;
+
+	/**
+	 * The path name of directory containing event encoding files
+	 */
+	std::string event_data_dir_;
+
+	/**
+	 * The directory to output the auto-generated file(s)
+	 */
+	std::string output_path_;
+
+	/**
+	 * Per CPU filename for reading fixed event values. Used in testing mode
+	 */
+	std::map<std::string, std::string> filenames_for_fixed_events_vals_;
+
+	/**
+	 * Generate topdown file for different projects or targets
+	 */
+	std::string target_;
+
+	/**
+	 * Generate topdown information only for selected CPUs
+	 */
+	std::vector<std::string> selected_cpus_;
+
+	/**
+	 * The CPUs to ignore
+	 */
+	std::unordered_set<std::string> dont_care_cpus_;
+
+	/**
+	 * Maximum length of the header printed on executing 'perf stat' command
+	 */
+	size_t metric_max_header_;
+
+	/**
+	 * 'header_row' is the row number of the header. The header of the input
+	 * csv file specifies the information like level numbers, CPU product
+	 * names, Metric Description etc.  A typical header row looks like:
+	 * Key | Level1 | Level2 | Level3 |  SKX |  SKL | ...
+	 */
+	size_t header_row;
+
+	/**
+	 * 'formula_start_colm_' is first column number specifying a formula
+	 */
+	size_t formula_start_colm_;
+
+	/**
+	 * 'formula_end_colm_' is last column number specifying a formula
+	 */
+	size_t formula_end_colm_;
+
+	/**
+	 * Row number of input csv file which identifies if a
+	 * CPU product is a client or server.
+	 */
+	size_t server_identifier_row_;
+
+	/**
+	 * First and last topdown levels.
+	 * A typical header row looks like:
+	 * Key | Level1 | Level2 | Level3 |  SKX |  SKL | ...
+	 *
+	 * first_level_ specifies a number [1-UINT_MAX] to specify the first
+	 * level.
+	 * g_LasttLevel specifies a number [1-UINT_MAX] to specify the last
+	 * level.
+	 */
+	size_t first_level_;
+	size_t first_last_;
+
+	/**
+	 * Model numbers of CPUs
+	 */
+	std::unordered_map<std::string, std::vector<std::string> >
+		cpu_to_model_number_;
+
+	/**
+	 * Hints for event encoding JSon filenames
+	 */
+	std::map<std::string, std::string> json_filename_hints_;
+
+	/**
+	 * Hints for event encoding JSon filenames
+	 */
+	std::map<std::string, std::string> output_directory_per_cpu_;
+
+	/**
+	 * The perf stat switch names for each top level metric
+	 */
+	std::map<std::string, std::string> perf_stat_switch_names_;
+
+	/**
+	 * GetConfigurationParameters return a single instance of
+	 * ConfigurationParameters
+	 */
+	static ConfigurationParameters *GetConfigurationParameters(void)
+	{
+		if (config_param_instance_ == nullptr)
+			config_param_instance_ = new ConfigurationParameters();
+
+		return config_param_instance_;
+	}
+
+    private:
+	static ConfigurationParameters *config_param_instance_;
+
+	ConfigurationParameters()
+	{
+		metric_max_header_ = UINT_MAX;
+		header_row = UINT_MAX;
+		formula_start_colm_ = UINT_MAX;
+		formula_end_colm_ = UINT_MAX;
+		server_identifier_row_ = UINT_MAX;
+		first_level_ = UINT_MAX;
+		first_last_ = UINT_MAX;
+	}
+};
+
+extern ConfigurationParameters *const kConfigParams;
+
+} // namespace topdown_parser
+
+#endif // TOPDOWN_PARSER_CONFIGURATION_H_
diff --git a/tools/perf/pmu-events/topdown-parser/configuration.json b/tools/perf/pmu-events/topdown-parser/configuration.json
new file mode 100644
index 000000000000..a9fddb54c8a1
--- /dev/null
+++ b/tools/perf/pmu-events/topdown-parser/configuration.json
@@ -0,0 +1,72 @@
+{
+  "configuration" : {
+    "_COMMENT_":"Generate topdown file for specific project or target.",
+      "target":"perf_json",
+
+    "_COMMENT_":"Hints for event encoding JSon filenames",
+    "json_filename_hints": {
+         "BDW":"broadwell",
+         "BDW-DE":"broadwellde"
+         "BDW-EP":"broadwellx",
+         "BDX":"broadwellx",
+         "CLX":"cascadelakex",
+         "HSW":"haswell",
+         "HSX":"haswellx",
+         "ICL":"icelake",
+         "IVB":"ivybridge",
+         "IVB-EP":"ivytown",
+         "IVT":"ivytown",
+         "JKT":"jaketown",
+         "SKL":"skylake",
+         "SKL-EP":"skylakex",
+         "SKX":"skylakex",
+         "SNB":"sandybridge",
+         "SNB-EP":"jaketown",
+      },
+
+      "_COMMENT_":"Output directory for perf-metric json files for each cpu",
+      "output_directory_per_cpu": {
+         "BDW":"broadwell",
+         "BDW-DE":"broadwellde"
+         "BDX":"broadwellx",
+         "CLX":"cascadelakex",
+         "HSW":"haswell",
+         "HSX":"haswellx",
+  	 "ICL":"icelake",
+         "IVB":"ivybridge",
+         "IVT":"ivytown",
+         "JKT":"jaketown",
+         "SKL":"skylake",
+         "SKX":"skylakex",
+         "SNB":"sandybridge",
+      },
+
+      "_COMMENT_":"Generate topdown information only for selected CPUs.",
+      "_COMMENT_":"The CPU name must confirm to the naming convention in input csv file",
+      "_COMMENT_":"Recommended: Leave blank. The names is will inferred from input csv file.",
+      "selected_cpus":[ ],
+
+      "_COMMENT_":"The CPU names to ignore",
+      "dont_care_cpus":[ "CPX", "JKT", "CNL", "KBL", "KBLR", "CFL", "SNB-EP", "TGL" ],
+
+      "_COMMENT_":"header row is the row number of the header [1 - UINT_MAX]",
+      "header_row":"",
+
+      "_COMMENT_":"Formula start colm is first column number specifying a formula [A - Z]",
+      "formula_start_colm":"",
+
+      "_COMMENT_":"Formula end colm is last column number specifying a formula [A - Z]",
+      "formula_end_colm":"",
+
+      "_COMMENT_":"Row number of the input csv file specifying if a column is for Server or Client [1 - UINT_MAX]",
+      "server_identifier_row":"",
+
+      "_COMMENT_":"The first topdown level [1 - #Levels]",
+      "_COMMENT_":"All the levels before first_level will be ignored",
+      "first_level":"",
+
+      "_COMMENT_":"The last topdown level [1 - #Levels]",
+      "_COMMENT_":"All the levels after 'last_level' will be ignored",
+      "last_level":""
+  }
+}
-- 
2.29.2.222.g5d2a92d10f8-goog

