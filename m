Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14C7C2AD31A
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 11:05:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731031AbgKJKEG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 05:04:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726467AbgKJKED (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 05:04:03 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7600AC0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 02:04:03 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id m64so8981887pfm.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 02:04:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=OjHoL/inWek5hCo9cit1xV61j9NIQl3A+WsFNLcr5Nw=;
        b=OUrZQnYUr6rLTUHXqt0cGvvXsY9197SeGN3MhGEsn7wKbZPINCXB214he0hJSMfX2X
         yKOj/2mZy7e2jO7PZ1XcUEoiqfV7zidE6lppx3gARM9SvRjxPIiLmVJ2ed7rhQPWRi9t
         RgACWhNaFw2L07K6FS9wngru78GSmaVoWUHZL3cIasVWT+KdfsAbqCRl5kqoyFPuqASf
         /mzVpjpBgzRz7URBY8ES29KvnwVyfIUYxL3p9mw19lGSjjhV+S33X1Iw5//beLtp4PO3
         eZ/lvN2mcj4XD4It6mI57qN6Y4VkPwKZIqrU0jyNe7e2VJh/6xOw4qixK3L/pKDfAn9N
         7gSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=OjHoL/inWek5hCo9cit1xV61j9NIQl3A+WsFNLcr5Nw=;
        b=ezH4pB0n77dQ2ztLjoFEck7lk4lJSRwb5dhMlnYLnExhlUYMo4caYXoiuOAOdaIGtP
         /9Tjik3hiBOOQIKwA1Qs/ovncw9SlA8Yf7F2ip8NRf7gPme3j+u3XyaydPiojFKsMt0A
         8rAYriiGFQFlN4aO8jh1Y9Zuuhh/tEL4CFACu25/lTmUpZlPnF6ry45n3+Gf69oLoMGK
         2UwFamHEM+inrpnpNHxs939zXmNzZcLrQu4LbTRrmqvhOjmwJYHT1i7BMG3gLiP878DZ
         MnSZ+SYrzg1tM3lWdvZZ4jcBWC0b8WX90Hct6i/mYrd0dsXaO+FaLdJTuo9+rJdAQ5nx
         fw6w==
X-Gm-Message-State: AOAM533ez5tEjv3MGKenRwvy7vKQ9UonhdKK3x6A1xsVEQ28NkV0qll2
        QOkeeOe6nOHvq5qoJT96fXXIG2u6gcaY
X-Google-Smtp-Source: ABdhPJwBBHIJmGR0jIcFpH/D4UP127WYRMb6G4wdG7MleICNp2cfTB+0QQ4sSJrQrCnTEfk7koVr6TJbUSuQ
Sender: "irogers via sendgmr" <irogers@irogers.svl.corp.google.com>
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:2:f693:9fff:fef4:4583])
 (user=irogers job=sendgmr) by 2002:a17:90b:293:: with SMTP id
 az19mr417438pjb.1.1605002642689; Tue, 10 Nov 2020 02:04:02 -0800 (PST)
Date:   Tue, 10 Nov 2020 02:03:37 -0800
In-Reply-To: <20201110100346.2527031-1-irogers@google.com>
Message-Id: <20201110100346.2527031-4-irogers@google.com>
Mime-Version: 1.0
References: <20201110100346.2527031-1-irogers@google.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8-goog
Subject: [RFC PATCH 03/12] perf topdown-paser: Add a CSV file reader.
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

Read a CSV file info a two dimensional vector of vectors. Open
parentheses are counted so that expressions like "min(a,b)" aren't
split. Escape characters and quotations aren't handled.

Co-authored-by: Ian Rogers <irogers@google.com>
Signed-off-by: Ian Rogers <irogers@google.com>
Signed-off-by: Sandeep Dasgupta <sdasgup@google.com>
---
 .../pmu-events/topdown-parser/csvreader.cpp   | 49 ++++++++++++++++++
 .../pmu-events/topdown-parser/csvreader.h     | 51 +++++++++++++++++++
 2 files changed, 100 insertions(+)
 create mode 100644 tools/perf/pmu-events/topdown-parser/csvreader.cpp
 create mode 100644 tools/perf/pmu-events/topdown-parser/csvreader.h

diff --git a/tools/perf/pmu-events/topdown-parser/csvreader.cpp b/tools/perf/pmu-events/topdown-parser/csvreader.cpp
new file mode 100644
index 000000000000..142e0e7e5ce7
--- /dev/null
+++ b/tools/perf/pmu-events/topdown-parser/csvreader.cpp
@@ -0,0 +1,49 @@
+/*
+ * Copyright 2020 Google LLC.
+ * SPDX-License-Identifier: GPL-2.0
+ */
+
+#include "csvreader.h"
+
+#include <cassert>
+#include <algorithm>
+#include <fstream>
+
+#include "general_utils.h"
+#include "logging.h"
+
+namespace topdown_parser
+{
+std::vector<std::vector<std::string> > CsvReader::getData() const
+{
+	std::vector<std::vector<std::string> > dataList;
+	std::ifstream file(file_name_);
+	std::string line = "";
+	assert(file.is_open() && "unable to open csv file");
+
+	while (getline(file, line)) {
+		std::vector<std::string> tokens;
+		int opens = 0;
+		int closes = 0;
+		for (const std::string &str : Split(line, delimeter_)) {
+			std::string stripped_str = Strip(str, '"');
+			if (opens > closes) {
+				tokens.back() += ", " + stripped_str;
+			} else {
+				tokens.push_back(stripped_str);
+			}
+			opens += std::count(str.begin(), str.end(), '(');
+			closes += std::count(str.begin(), str.end(), ')');
+		}
+
+		dataList.push_back(tokens);
+	}
+
+	if (dataList.empty()) {
+		FATAL("Empty csv file" << file_name_);
+	}
+
+	return dataList;
+}
+
+} // namespace topdown_parser
diff --git a/tools/perf/pmu-events/topdown-parser/csvreader.h b/tools/perf/pmu-events/topdown-parser/csvreader.h
new file mode 100644
index 000000000000..a82470041145
--- /dev/null
+++ b/tools/perf/pmu-events/topdown-parser/csvreader.h
@@ -0,0 +1,51 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+// ---------------------------------------------
+// File: csvheader.h
+// ---------------------------------------------
+//
+// The header file provides the interface for parsing csv file using
+// CsvReader::delimeter_ as the delimiter for parsing each line.
+//
+// The library provides the following utilities:
+//  `getData`: Reads the input csv file `file_name_` and parses its
+//             contents, based on the delimeter `delimeter_`, as strings.
+//             The parsed data is returned as a 2D vector, V, of strings such
+//             that V[r][c] is same as the value of the input csv file at row r
+//             and column c.
+//
+//             For example, with the following content of a csv file,
+//             a,b,c,
+//             1,2,3
+//             and delimiter as ',', the return value is
+//
+//             {
+//               {"a", "b", "c"},
+//               {"1", "2", "3"}
+//             }
+
+#ifndef TOPDOWN_PARSER_CSV_READER_H_
+#define TOPDOWN_PARSER_CSV_READER_H_
+
+#include <string>
+#include <vector>
+
+namespace topdown_parser
+{
+class CsvReader {
+    public:
+	explicit CsvReader(std::string fname, char delm = ',')
+		: file_name_(fname), delimeter_(delm)
+	{
+	}
+
+	std::vector<std::vector<std::string> > getData() const;
+
+    private:
+	const std::string file_name_;
+	const char delimeter_;
+};
+
+} // namespace topdown_parser
+
+#endif // TOPDOWN_PARSER_CSV_READER_H_
-- 
2.29.2.222.g5d2a92d10f8-goog

