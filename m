Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 679602AD316
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 11:04:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732041AbgKJKEg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 05:04:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731878AbgKJKEV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 05:04:21 -0500
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2199DC0613D1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 02:04:20 -0800 (PST)
Received: by mail-qk1-x749.google.com with SMTP id f9so8275335qkg.13
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 02:04:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=nrzFexJvGrTq0QIzrzo0g61dQEjFkiepI4OPSOH1Szg=;
        b=WWy2hxeqmTRKWfkhRGKk8yvm002V6UDoKI/7Gpec21YMQcMxLCkbtZiVJkYV9lEx3Z
         NfZAi5QpKOidF4FUILEV3V14CA4Cgx3YvwVsvA8cgvEvEjAStf49y/2J19+e0x+nrCBI
         094vQHO289WHFKJb46Orw3bHNl2iIRRJd6oxGqw5FAvyrjW7kP5SAVJL7Cv6A2huQGWa
         5vUznMV96uDjPxe2EjBIJJUFoKA8wnHAfMTezC4Ikc3sCw7EKmnIAsmZDU4Cc8/l9Ybp
         s9v/0Fh3XQ9bb/2j3P7572FiSIpbq1vxezMWRcs3j5+qdnZZpfXsSOGBiquqjUbuB4NW
         ufgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=nrzFexJvGrTq0QIzrzo0g61dQEjFkiepI4OPSOH1Szg=;
        b=Lxm8S1cXLASbQUusJRX+VNBGwM6NTkTT3zuuvjB8xNqMQ32NF/asATBKQwxOfu3q9t
         G/U+xH2GRo9R0II53vX/echh6FvdTdNOR1aMpl/C/X3BmrSnpDtb5nnYbV43bWdfDE6V
         XdwzkS0iyB6QLi1YeZzMQGGBviY4s9L3DxUTtftmAz1Pub/6CBzIzDaNWMsrhoLqUCiO
         70ferRh5ToAN/+dOqB2ASjTFW7SE5+A5Zj6fxkkjZc7Uvs4lELG6TGZsPnUkGO0FN7jg
         6mJNFusqz8cXDMpqPlrRKMNx8yA8OBqNVZY55i7o/+Bp7dfFvW6U8tiiby2SONzhTEK6
         Wgsg==
X-Gm-Message-State: AOAM530Po1N2I/Z5bvg1l48FTcxlXGZDHn5QEXWYG7hVmmJIl7awuopf
        LaCPRlg3Z5GFjkzDmg6hv4foOHovgNug
X-Google-Smtp-Source: ABdhPJwxjNfkabRP0BObypvYcoTgnmTl233MBUAHmWKbg0qXlO9zwmeqgIMghIw+pAkjhofFzyBQ1h9BVGTK
Sender: "irogers via sendgmr" <irogers@irogers.svl.corp.google.com>
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:2:f693:9fff:fef4:4583])
 (user=irogers job=sendgmr) by 2002:a0c:9e65:: with SMTP id
 z37mr18791387qve.39.1605002659243; Tue, 10 Nov 2020 02:04:19 -0800 (PST)
Date:   Tue, 10 Nov 2020 02:03:45 -0800
In-Reply-To: <20201110100346.2527031-1-irogers@google.com>
Message-Id: <20201110100346.2527031-12-irogers@google.com>
Mime-Version: 1.0
References: <20201110100346.2527031-1-irogers@google.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8-goog
Subject: [RFC PATCH 11/12] perf topdown-parser: Main driver.
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

Invoke the necessary configuration reading and parsing, then code
generation. Handles command line arguments.
Add a minor README.

Co-authored-by: Stephane Eranian <eranian@google.com>
Co-authored-by: Ian Rogers <irogers@google.com>
Signed-off-by: Ian Rogers <irogers@google.com>
Signed-off-by: Sandeep Dasgupta <sdasgup@google.com>
---
 tools/perf/pmu-events/topdown-parser/README   |   5 +
 .../topdown-parser/topdown_parser_main.cpp    | 155 ++++++++++++++++++
 2 files changed, 160 insertions(+)
 create mode 100644 tools/perf/pmu-events/topdown-parser/README
 create mode 100644 tools/perf/pmu-events/topdown-parser/topdown_parser_main.cpp

diff --git a/tools/perf/pmu-events/topdown-parser/README b/tools/perf/pmu-events/topdown-parser/README
new file mode 100644
index 000000000000..7f100792b00c
--- /dev/null
+++ b/tools/perf/pmu-events/topdown-parser/README
@@ -0,0 +1,5 @@
+Topdown parser and code generator
+=================================
+
+The topdown parser processes a TMA_Metrics.csv file and generates
+Intel specific metrics from the data in the spreadsheet cells.
\ No newline at end of file
diff --git a/tools/perf/pmu-events/topdown-parser/topdown_parser_main.cpp b/tools/perf/pmu-events/topdown-parser/topdown_parser_main.cpp
new file mode 100644
index 000000000000..ba9acd32726e
--- /dev/null
+++ b/tools/perf/pmu-events/topdown-parser/topdown_parser_main.cpp
@@ -0,0 +1,155 @@
+/*
+ * Copyright 2020 Google LLC.
+ * SPDX-License-Identifier: GPL-2.0
+ */
+
+#include <getopt.h>
+#include <stdlib.h>
+
+#include <iostream>
+#include <string>
+#include <unordered_map>
+#include <vector>
+
+#include "code_gen_target.h"
+#include "configuration.h"
+#include "csvreader.h"
+#include "dependence_dag_utils.h"
+#include "event_info.h"
+#include "logging.h"
+
+namespace topdown_parser
+{
+namespace
+{
+/**
+ * Printing usage model
+ */
+[[noreturn]] void ShowUsage()
+{
+	std::cout
+		<< "\n"
+		   " Usage: topdown_parser  --csv-file <csv input file>\n"
+		   "                         --events-data-dir <path of event "
+		   "encoding JSon files>\n"
+		   "                         --config-file <path to "
+		   "configuration.json>\n"
+		   "                         --output-path <path to "
+		   "output the topdown file(s)>\n"
+		   "                         [Options]\n"
+		   " Synopsis: Auto-generates topdown.c \n\n"
+		   " Options\n"
+		   "\t--dump-events :    Dump the unique events for each metric.\n"
+		   "generated topdown file. Used for testing.\n"
+		   "\t--help        :    Show help\n";
+	exit(0);
+}
+
+/**
+ * The input csv file name specifying formula encoding for topdown
+ * metric
+ */
+char *g_CsvFile = nullptr;
+
+/**
+ * ProcessArgs parses command-line arguments
+ */
+bool ProcessArgs(int argc, char **argv)
+{
+	// The following command-line arguments to the program
+	// todown_parser are required: --csv-file <file>,
+	// --events-data-dir <dir>, --config-file <file> --output-path
+	// <path>
+	if (argc < 9) {
+		ShowUsage();
+		return false;
+	}
+
+	const char *const short_opts = "f:a:z:hdt";
+	const option long_opts[] = {
+		{ "csv-file", required_argument, nullptr, 'f' },
+		{ "events-data-dir", required_argument, nullptr, 'a' },
+		{ "config-file", required_argument, nullptr, 'z' },
+		{ "output-path", required_argument, nullptr, 'o' },
+		{ "dump-events", no_argument, nullptr, 'd' },
+		{ "help", no_argument, nullptr, 'h' },
+		{ nullptr, no_argument, nullptr, 0 }
+	};
+
+	while (true) {
+		const auto opt =
+			getopt_long(argc, argv, short_opts, long_opts, nullptr);
+
+		if (opt == -1)
+			break;
+
+		switch (opt) {
+		case 'f':
+			g_CsvFile = optarg;
+			break;
+
+		case 'a':
+			kConfigParams->event_data_dir_ = optarg;
+			kConfigParams->event_data_dir_ += "/";
+			break;
+
+		case 'z':
+			kConfigParams->config_file_ = optarg;
+			break;
+
+		case 'o':
+			kConfigParams->output_path_ = optarg;
+			break;
+
+		case 'd':
+			g_DumpEvents = true;
+			break;
+
+		case 'h':
+		case '?':
+		default:
+			ShowUsage();
+			return false;
+		}
+	}
+
+	INFO("csv filename: |" << g_CsvFile << "|");
+	INFO("events data dir: |" << kConfigParams->event_data_dir_ << "|");
+	INFO("config file : |" << kConfigParams->config_file_ << "|");
+	return true;
+}
+
+} // namespace
+
+} // namespace topdown_parser
+
+/**
+ * Main driver function for generating topdown files.
+ */
+int main(int argc, char *argv[])
+{
+	bool process_arg_stat = topdown_parser::ProcessArgs(argc, argv);
+	if (!process_arg_stat) {
+		FATAL("Failed to process the command-line arguments");
+	}
+
+	// Read the configuration file "configuration.json"
+	int read_config_stat = topdown_parser::ReadConfig();
+	if (read_config_stat != 0) {
+		FATAL("Failed to read configuration file");
+	}
+
+	// Read the input csv file
+	topdown_parser::CsvReader reader(topdown_parser::g_CsvFile);
+	std::vector<std::vector<std::string> > records = reader.getData();
+	std::unordered_map<std::string, topdown_parser::MappedData>
+		dependence_dag = topdown_parser::ProcessRecords(&records);
+
+	// Read and process the json files specifying the event encodings
+	topdown_parser::ProcessEventEncodings();
+
+	// Generate topdown files for a specific target (or purpose)
+	topdown_parser::CodeGenTarget(dependence_dag);
+
+	return 0;
+}
-- 
2.29.2.222.g5d2a92d10f8-goog

