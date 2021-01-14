Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B393F2F68D6
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 19:07:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729752AbhANSDi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 13:03:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728732AbhANSDg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 13:03:36 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCA81C061757
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 10:02:55 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id 203so2642684ybz.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 10:02:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=Ia6+BdgKJznqoAV56XM07nADShC1wtvS0E8hfY7Ui6g=;
        b=Qerr03wEKvdQNuTm83dDuiWexuiTN5WnAtmfdlhZ+M+/vraHRLkJbzBlR1klsdh4e/
         2RYYwbKLa1BDaNpZ9IwhRY98LBJHVVCvtqf65RCO7qA/nRYtcAZIHHXMMlB/QhSXeNlv
         r+8tZ9iJBEgtl/esg6GnZ6NfK9n0GJSYvauCPbJMtQqilYuqEH8RyvLmRBtiYo1BSqHO
         JhVn/Pl/B1dNvSrsMCma7OHzfsXObM2mCDF+5GoZudE48Gr7dLdeqsJAWjmFD3/ax2wL
         6X20gTizpHrFEZt5oOfqgkv+x0e3inJmkoYAYzTKVl0LByvzByLGOS22wj1dpBeaAssV
         6fQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=Ia6+BdgKJznqoAV56XM07nADShC1wtvS0E8hfY7Ui6g=;
        b=Co8Dj0pCrwPsvS5T0zPkKpMsbHg9gE1M84czR0HJWxc549rcxswsiSLUjEA0oZChjk
         FrscMxaz8qqaSovj3QATTaKJI/K/fLui8qD3wEATkt2EDGYFA50ptSCDsgzQyj9oHgNQ
         xl9q39VM6Unmb1molp25VpU4ToneKy+iOZcF0rtY8wLEyL4RJagpmedcYRQVmHcgMvbS
         jMc7SDp7yklwjzgvmVe2XBjfCk/bKM6abbUwf0k1y8md5Cn4ShdwvjUmxqJCjUAQmhrN
         x5aVWtBDaQSjIyRnIYe0lNe4rsq/XBuz8vBiBSTb0omp7pgU6XfVreYh8YDQD30RwJxL
         3/Yw==
X-Gm-Message-State: AOAM531uyRrj09tXj/SDf7GDOXU+2+pOV/AaEtbq7qkvPhaJZ6z0+QZS
        sD5wjegkyW7nfH6dYkyWhP69A7A9yMqF
X-Google-Smtp-Source: ABdhPJxaQVbMa7RAw1wbTkjGS2E6tWNH6RA+cNl6fPATjtDjZmqY/9D6/v42w+pPM2bLEm3InvGSH2JJNKO1
Sender: "irogers via sendgmr" <irogers@irogers.svl.corp.google.com>
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:2:f693:9fff:fef4:4583])
 (user=irogers job=sendgmr) by 2002:a25:2456:: with SMTP id
 k83mr6487328ybk.19.1610647374936; Thu, 14 Jan 2021 10:02:54 -0800 (PST)
Date:   Thu, 14 Jan 2021 10:02:49 -0800
Message-Id: <20210114180250.3853825-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [PATCH 1/2] libperf tests: If a test fails return non-zero
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a test fails return -1 rather than 0. This is consistent with the
return value in test-cpumap.c

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/perf/tests/test-cpumap.c    | 2 +-
 tools/lib/perf/tests/test-evlist.c    | 2 +-
 tools/lib/perf/tests/test-evsel.c     | 2 +-
 tools/lib/perf/tests/test-threadmap.c | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/lib/perf/tests/test-cpumap.c b/tools/lib/perf/tests/test-cpumap.c
index c8d45091e7c2..c70e9e03af3e 100644
--- a/tools/lib/perf/tests/test-cpumap.c
+++ b/tools/lib/perf/tests/test-cpumap.c
@@ -27,5 +27,5 @@ int main(int argc, char **argv)
 	perf_cpu_map__put(cpus);
 
 	__T_END;
-	return 0;
+	return tests_failed == 0 ? 0 : -1;
 }
diff --git a/tools/lib/perf/tests/test-evlist.c b/tools/lib/perf/tests/test-evlist.c
index 6d8ebe0c2504..d913241d4135 100644
--- a/tools/lib/perf/tests/test-evlist.c
+++ b/tools/lib/perf/tests/test-evlist.c
@@ -409,5 +409,5 @@ int main(int argc, char **argv)
 	test_mmap_cpus();
 
 	__T_END;
-	return 0;
+	return tests_failed == 0 ? 0 : -1;
 }
diff --git a/tools/lib/perf/tests/test-evsel.c b/tools/lib/perf/tests/test-evsel.c
index 135722ac965b..0ad82d7a2a51 100644
--- a/tools/lib/perf/tests/test-evsel.c
+++ b/tools/lib/perf/tests/test-evsel.c
@@ -131,5 +131,5 @@ int main(int argc, char **argv)
 	test_stat_thread_enable();
 
 	__T_END;
-	return 0;
+	return tests_failed == 0 ? 0 : -1;
 }
diff --git a/tools/lib/perf/tests/test-threadmap.c b/tools/lib/perf/tests/test-threadmap.c
index 7dc4d6fbedde..384471441b48 100644
--- a/tools/lib/perf/tests/test-threadmap.c
+++ b/tools/lib/perf/tests/test-threadmap.c
@@ -27,5 +27,5 @@ int main(int argc, char **argv)
 	perf_thread_map__put(threads);
 
 	__T_END;
-	return 0;
+	return tests_failed == 0 ? 0 : -1;
 }
-- 
2.30.0.284.gd98b1dd5eaa7-goog

