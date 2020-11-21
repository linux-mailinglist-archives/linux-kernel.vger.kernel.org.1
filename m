Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9EE52BBC91
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Nov 2020 04:11:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727248AbgKUDLY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 22:11:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727024AbgKUDLX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 22:11:23 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69ADCC061A47
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 19:11:23 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id x3so7794936plr.23
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 19:11:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=Y9nCqzUR00s397XbJ4MbVQrXlMlJKCQR9tfy/2YBpDw=;
        b=G+10cZhZBNjcNDMYayyrBcwRdjmzCDoI5BfPvWKZLsKDq8xkqAmgkMLRX9A3cN9Vht
         zFE3C8AFGvZE7F4VlKu8YOLDGjReIHdDv/qzJQM0TC4LXQnHWiR/GtaJx5Jh6bRB8CEb
         Q8MIMXJciGLHBvy9KH7MTInktArucVOAIcgqfB4r+fBqH6OS1iuloNzmHm1+zBy+g8NK
         5KUKPi6+YzlkUrihuXK4DALsltvekLGRQLbz0HMZCxTcxfyz6uAIhH6VAZQ7uv9qphPx
         jqpkBlrnHzqk96egvIuQFHlQV86NnlzdzZ1YzldbyK/JDTGZfRadYh32xiyUAXMVJ5o/
         DPCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=Y9nCqzUR00s397XbJ4MbVQrXlMlJKCQR9tfy/2YBpDw=;
        b=ZXN7YTJVi1U/8qN4zbjcVj+H+Dy8dqvxO5el1WExZW3yiKsNpZQfHEE0fwmhs+p3B5
         YjXtSl6x833drxCOK1p1NZoj/aOfP+frSuQd2Rbix6q3i110B6u0J6W/w7a2E/Fpyr/o
         ZhLidlEx+oKrXsVBYfx4fjKJ5cFJxdYgmZHJt/HYRTAz/0z02j9TH+iuBb5Zq9DEuCj2
         Xj33t8kP5VBrqpaVAe+j7V49xw2Zw4bmc3feQJcxm5UC15IWgzW7hyB3I3zouH7PNoex
         n+qJqqvc0Xhe9O2APMiXnPmdYOge5AlLI8UDvZKJ2Rcfnk0687KdX0mJMtLnSoZM5q+h
         ntrQ==
X-Gm-Message-State: AOAM533/W33SYqL5AUt0KJ6htrs80KR3DbvqfKnHONMG52+jIg6sYOT6
        XsAEp4hjtU/gS2AmuGTGo0mZXIJPZZzg
X-Google-Smtp-Source: ABdhPJzUvcp5hTaYjLuNdjpX0iq33Vr4pv15dTOX8kvtu+msfPlnNsUx47+E/jaAqnTXiLWG39TCyG1iFZX8
Sender: "irogers via sendgmr" <irogers@irogers.svl.corp.google.com>
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:2:f693:9fff:fef4:4583])
 (user=irogers job=sendgmr) by 2002:a17:902:ba8b:b029:d7:e6da:cd21 with SMTP
 id k11-20020a170902ba8bb02900d7e6dacd21mr16233793pls.38.1605928282856; Fri,
 20 Nov 2020 19:11:22 -0800 (PST)
Date:   Fri, 20 Nov 2020 19:11:14 -0800
Message-Id: <20201121031119.3554769-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: [PATCH v3 0/5] Don't compute events that won't be used in a metric.
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

    
For a metric like:
  EVENT1 if #smt_on else EVENT2
    
currently EVENT1 and EVENT2 will be measured and then when the metric
is reported EVENT1 or EVENT2 will be printed depending on the value
from smt_on() during the expr parsing. Computing both events is
unnecessary and can lead to multiplexing as discussed in this thread:
https://lore.kernel.org/lkml/20201110100346.2527031-1-irogers@google.com/

This change modifies expression parsing so that constants are
considered when building the set of ids (events) and only events not
contributing to a constant value are measured.

v3. fixes an assignment in patch 2/5. In patch 5/5 additional comments
are added and useless frees are replaced by asserts. A new peephole
optimization is added for the case CONST IF expr ELSE CONST, where the
the constants are identical, as we don't need to evaluate the IF
condition.

v2. is a rebase.

Ian Rogers (5):
  perf metric: Restructure struct expr_parse_ctx.
  perf metric: Use NAN for missing event IDs.
  perf metric: Rename expr__find_other.
  perf metric: Add utilities to work on ids map.
  perf metric: Don't compute unused events.

 tools/perf/tests/expr.c       | 159 +++++++++-----
 tools/perf/tests/pmu-events.c |  42 ++--
 tools/perf/util/expr.c        | 136 ++++++++++--
 tools/perf/util/expr.h        |  17 +-
 tools/perf/util/expr.l        |   9 -
 tools/perf/util/expr.y        | 376 +++++++++++++++++++++++++++-------
 tools/perf/util/metricgroup.c |  44 ++--
 tools/perf/util/stat-shadow.c |  54 +++--
 8 files changed, 623 insertions(+), 214 deletions(-)

-- 
2.29.2.454.gaff20da3a2-goog

