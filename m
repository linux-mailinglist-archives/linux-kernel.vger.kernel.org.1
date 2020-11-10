Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC2432AD30F
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 11:04:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730623AbgKJKEC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 05:04:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726467AbgKJKD7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 05:03:59 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99CEDC0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 02:03:59 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id x141so7063465ybe.16
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 02:03:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=J1htXOZHOWfzXZJNOKEygyiu5YzNqz1CDhOsR3ST10w=;
        b=ptF3JOz5TSHFPdQyiyb+7Fm+9wuyuxcudDQX8nKH6MPu3MC7GmMj9uCMdB0Td7Dqvd
         k2SAY5hPYhelu2FPhsqHRrUCPaZrFKfm3YBFxxArnru74/fgWl1U5E2bcDQw+7G/pOpb
         0akb3BZ2DRGcn0i/Rw9Rm+2J+2HZAHzMV1NWZeIrqWO/tnVfjanMoy6ObmrcUXwFtn+C
         K9xN1I/dXVgHUnh7x5IgAwVYkJrlIZOm6De59eUZ4odwaLYUAKbJdsq5ung3LNqccOCK
         3JzyS5G2Zxw8xBeHKvNpClW/cf5exf+fhSISyE4PokSyUPmEF3bZi5r1MclhUJcmd/Lc
         IPvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=J1htXOZHOWfzXZJNOKEygyiu5YzNqz1CDhOsR3ST10w=;
        b=R/Mm08/R9Sa7PVpIsytMqi9TefF0CXjKqK/OsJh17KMSSi8MzgeQ37LVDOUe7Q9szA
         XgnuBbBdeP/utxN0cD8s8r1nf+/xcw64c9CdxrinDuc73OArHNW/oD8gJRb9dFfovTGT
         gdvt4HO5fOQ+lz+ZeyP2CWji/KsdLWPUFw5N+D/QVPKEePuKyRP6s1cP6nS3xtMmENrk
         ScAVDcmuT/nGGWrXOtmUqROC8sk1tM4zEzG097F0n5EdTUbBVVm5G9sZiIGj2Doah7af
         1/zkan6Wx27F2P+WISReRSQvvQEcH2EydlfCmg8tCx4RTzizvftRN6U+rJQ21QujtRIh
         sAnw==
X-Gm-Message-State: AOAM532zbvUUPU9/aB+AuaFL/MUrd6Z/n2AFqlb92kO2IaSlyfnQ5gzS
        fPzeiuzSIrexQyZ9KT98Klw6FHqOA9Dj
X-Google-Smtp-Source: ABdhPJwLYM+3JNhQ9M88zN0GQ88MaSqwutTchJwrI51xXX5UIlsuRoslB6NBLq6udkmKZhFO6bgnsIIy77uX
Sender: "irogers via sendgmr" <irogers@irogers.svl.corp.google.com>
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:2:f693:9fff:fef4:4583])
 (user=irogers job=sendgmr) by 2002:a5b:d02:: with SMTP id y2mr23503458ybp.389.1605002638721;
 Tue, 10 Nov 2020 02:03:58 -0800 (PST)
Date:   Tue, 10 Nov 2020 02:03:35 -0800
In-Reply-To: <20201110100346.2527031-1-irogers@google.com>
Message-Id: <20201110100346.2527031-2-irogers@google.com>
Mime-Version: 1.0
References: <20201110100346.2527031-1-irogers@google.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8-goog
Subject: [RFC PATCH 01/12] perf topdown-parser: Add a simple logging API.
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

A logging API that is simpler but inspired by that in abseil.

Signed-off-by: Ian Rogers <irogers@google.com>
Signed-off-by: Sandeep Dasgupta <sdasgup@google.com>
---
 .../perf/pmu-events/topdown-parser/logging.h  | 25 +++++++++++++++++++
 1 file changed, 25 insertions(+)
 create mode 100644 tools/perf/pmu-events/topdown-parser/logging.h

diff --git a/tools/perf/pmu-events/topdown-parser/logging.h b/tools/perf/pmu-events/topdown-parser/logging.h
new file mode 100644
index 000000000000..9942018c4c75
--- /dev/null
+++ b/tools/perf/pmu-events/topdown-parser/logging.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+// -------------------------------------
+// File: logging.h
+// -------------------------------------
+//
+// The header provides the macro defintion for logging errors/warnings
+
+#ifndef TOPDOWN_PARSER_LOGGING_H_
+#define TOPDOWN_PARSER_LOGGING_H_
+
+#include <iostream>
+
+#define INFO(msg) std::cout << "\033[1;35mInfo: " << msg << "\033[0m\n"
+#define ERROR(msg)                                                             \
+	std::cout << __FILE__ << ":" << __LINE__                               \
+		  << " \033[1;31mError: " << msg << "\033[0m\n"
+#define FATAL(msg)                                                             \
+	do {                                                                   \
+		std::cout << __FILE__ << ":" << __LINE__                       \
+			  << " \033[1;31mFatal: " << msg << "\033[0m\n";       \
+		exit(1);                                                       \
+	} while (false)
+
+#endif // TOPDOWN_PARSER_LOGGING_H_
-- 
2.29.2.222.g5d2a92d10f8-goog

