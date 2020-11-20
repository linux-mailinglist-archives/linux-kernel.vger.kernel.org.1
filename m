Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E80D12BA251
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 07:29:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726454AbgKTG2x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 01:28:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725785AbgKTG2x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 01:28:53 -0500
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04965C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 22:28:53 -0800 (PST)
Received: by mail-qv1-xf49.google.com with SMTP id v8so6414700qvq.12
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 22:28:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=tyPihTN/idUHePX8JoO4TuUmSJ4Ne3qjOe8hwcKoD1o=;
        b=EuLlgIV0OUYgy6lY6CI/Z3gNGmsK7Dgiibg3d6SVcv7GbdT4JCfha7XGI4FlToeXfN
         NPJVjt6k1hPDEQ8jcbsAkJkkOTMLOG6dTTjO9kGj6V4U1IKVYnkmHKmJclt0s3t2d2Tf
         auhoC4G5GYt1GAgLaW1UjT9qnCZCbvZ/rc7Eic9xhWgt4lCumS4smIpWdiNPV8lOLD8k
         ZBpgP/0vBMpBRUH6+/Zu9Fow5TrH7XH8UqEc3E61l/bwTZyhNTnIaI8ORi65NsrYDo1u
         HsD3ZwPX2xMDwg+V6b2zA2syKVyf7iQjZ8/3AVvV+J8+z6hO8xa9TfaAnzyBsgX+/Dwd
         nNiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=tyPihTN/idUHePX8JoO4TuUmSJ4Ne3qjOe8hwcKoD1o=;
        b=j/MxRWQ/Dlqyg/BY/TgaUP1bfj3KtXOikN99M7UN9phuPFZhheLjd6xTx/o/7G3Ndb
         6WINrHIZeO+rLZCEha9CUwSvvKigV4y0PKKrvoSWZgjKTB/i74NT+tuhUyElPUhFrQLe
         HdP6vjhZsHUMi8DW+1bIHre2cXqt/nWJpz6c279j+fKxtCjE1CprBoaF14zZR6binzrL
         eOcOGfzlI9+2xlN3crCXZPVSdyb1USgFxyCCrfFueHuErtaFfAUxmj9gb2NA8kbhlCKm
         wyWLaydNf5KAx4o3Pe/JlWa2UJk7VgoLZjiDvKJ8DlYi0qw8fHFdzSBEIXE/gGuGxvBn
         BoCA==
X-Gm-Message-State: AOAM531JDeOHME2Got4lG4+le0/9S6Hd1f1IcxiYohCBpDVhW7LIp1th
        j+IrQ3waiqwnGLJzevny8K88U7tbqXfn
X-Google-Smtp-Source: ABdhPJwOFSap1e1XkD8swWNQl8w5prm2QnO8qPSMpOt3YJuRtBZpiLtkOR66cxFUZkGP2CdM5B8xDdTzPa6P
Sender: "irogers via sendgmr" <irogers@irogers.svl.corp.google.com>
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:2:f693:9fff:fef4:4583])
 (user=irogers job=sendgmr) by 2002:a0c:e24e:: with SMTP id
 x14mr15045200qvl.13.1605853732115; Thu, 19 Nov 2020 22:28:52 -0800 (PST)
Date:   Thu, 19 Nov 2020 22:28:47 -0800
Message-Id: <20201120062847.3162992-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: [PATCH] perf docs: Add man pages to see also
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

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Documentation/perf.txt | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tools/perf/Documentation/perf.txt b/tools/perf/Documentation/perf.txt
index c130a3c46a90..c18b5872277e 100644
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
+linkperf:perf-script[1], linkperf:perf-test[1], linkperf:perf-top[1],
+linkperf:perf-trace[1], linkperf:perf-version[1]
-- 
2.29.2.454.gaff20da3a2-goog

