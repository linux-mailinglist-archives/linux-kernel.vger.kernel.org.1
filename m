Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57C7A2BA258
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 07:31:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726335AbgKTGam (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 01:30:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725871AbgKTGal (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 01:30:41 -0500
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54087C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 22:30:41 -0800 (PST)
Received: by mail-qv1-xf49.google.com with SMTP id m11so6422182qvu.6
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 22:30:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=qOOnidrXXjJ1MPJKdWSFE6IgTc0WSkY4LjfJQ/1CawA=;
        b=Px1YFNyledDjSixhrLEa0w62whFwnKSR/ZFv+EafdAfZn2HrfFXZC4EHQRExLdZjlI
         RShiFP+kC8iyRDxVgEOFizv8TBWxoChkUAeF9bEPkrEo25ByzxUlHouRTo0JVN9uIRwa
         YOZQK36zoY476+aUmj+39ooxP5jbw003PUe28rouXlOkiJzKOMvGcmLbih4ewpPCU+MM
         WmdEoqHZeiWQbBaQHjTEVC35Ahv6ik8Cy/o9Bl4M5HimEvMSYUlB8Rjr4zrf8m9ubumX
         QQkoJ1/vPlSAcg8T/twovgO3NZx4EjKz0zxWL3yYhrNswbDnRqg8kyszfcd8w4U4uhiI
         Afog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=qOOnidrXXjJ1MPJKdWSFE6IgTc0WSkY4LjfJQ/1CawA=;
        b=HlJWN9ZByEFBWncxN6MYAHOKqWVAPughkBmbUSoED/sV4uBw93TPJhzdO34S8Nm85r
         Reqx8NGlOxVViUNZDLNeULO84X0G0Pm3NDPNReU1bOjzxZ0OaEP4aLBlNW2E0c5DT2qV
         PiQVvsZc0y4C2C7NSmcz6KvIqeeQD0fudR+UzqYb/NRpXrKCfTyviU/ol5JXef3aimKi
         p4o9TNqyaTYNQJGr1w19evsdcnvnwt2PfXbmiZCVl5xKBW/kn4u9hzDNYxJZHOIxToD3
         EwrjTddRoWjbEoVVh/mJX4Z1kxzkO3CjppzO4LzuPbc8yn0FC+yZxP3A+zIkahRqkq2G
         c07w==
X-Gm-Message-State: AOAM5330VsT9PYRqVyHrISA2Wm8VbokTUFWI6CxWAl/I+WLWl9gC3pTT
        rAtnSZVIQDXYJrzi2nqJuf5UJ9q81EKr
X-Google-Smtp-Source: ABdhPJybLKns6QBU1G6ev1Hv+oTWtD6wov14gEZQnmWmCzQARVHJNjGz0VYh79jKd4T08Fdt4/PF/l2hQv2L
Sender: "irogers via sendgmr" <irogers@irogers.svl.corp.google.com>
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:2:f693:9fff:fef4:4583])
 (user=irogers job=sendgmr) by 2002:a05:6214:b83:: with SMTP id
 fe3mr14375538qvb.24.1605853840538; Thu, 19 Nov 2020 22:30:40 -0800 (PST)
Date:   Thu, 19 Nov 2020 22:30:37 -0800
Message-Id: <20201120063037.3166069-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: [PATCH v2] perf docs: Add man pages to see also
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Cc:     Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add all other man pages to the "see also" list except for
perf-script-perl and perf-script-python that are linked to from
perf-script.

v2. Fix accidentally listing perf-top twice.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Documentation/perf.txt | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tools/perf/Documentation/perf.txt b/tools/perf/Documentation/perf.txt
index c130a3c46a90..9c330cdfa973 100644
--- a/tools/perf/Documentation/perf.txt
+++ b/tools/perf/Documentation/perf.txt
@@ -76,3 +76,15 @@ SEE ALSO
 linkperf:perf-stat[1], linkperf:perf-top[1],
 linkperf:perf-record[1], linkperf:perf-report[1],
 linkperf:perf-list[1]
+
+linkperf:perf-annotate[1],linkperf:perf-archive[1],
+linkperf:perf-bench[1], linkperf:perf-buildid-cache[1],
+linkperf:perf-buildid-list[1], linkperf:perf-c2c[1],
+linkperf:perf-config[1], linkperf:perf-data[1], linkperf:perf-diff[1],
+linkperf:perf-evlist[1], linkperf:perf-ftrace[1],
+linkperf:perf-help[1], linkperf:perf-inject[1],
+linkperf:perf-intel-pt[1], linkperf:perf-kallsyms[1],
+linkperf:perf-kmem[1], linkperf:perf-kvm[1], linkperf:perf-lock[1],
+linkperf:perf-mem[1], linkperf:perf-probe[1], linkperf:perf-sched[1],
+linkperf:perf-script[1], linkperf:perf-test[1],
+linkperf:perf-trace[1], linkperf:perf-version[1]
-- 
2.29.2.454.gaff20da3a2-goog

