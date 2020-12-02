Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D2952CB5DA
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 08:42:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387639AbgLBHkh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 02:40:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727717AbgLBHkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 02:40:37 -0500
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41BBAC0613CF
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 23:39:57 -0800 (PST)
Received: by mail-qk1-x749.google.com with SMTP id q25so565575qkm.17
        for <linux-kernel@vger.kernel.org>; Tue, 01 Dec 2020 23:39:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=HWTEGD0gHRE0W2fArZHPNDk0P/N5GTWt9YJ9YHd0/+c=;
        b=hDgtR2UjpuWad5Cd9ANDnrX2f110zFAMMdIjGZFKo4CMPRUBvhkzFUp3wbSzP+sgPn
         bNWd/NkNNtv7274z/lLmkuQQehvkdem5BfK5XDMECi+oRceb9YzNgp8KCXqFCYKKeLgs
         vg+hQ8IRGo5H/is47cQ0vmNjDbie2Q64JmUCtMaqEhPh9OmTaaKncA3vifLZa/sgRQkt
         +9CMcCSb3cchIKLj0NOMKCc46Kl1fmyw9H1rzTwOoyDRYWVVVNLG7JppZH5WPEQFGlr9
         rifUg/6ajA1M6t+PQ1widORUD2DSWqTzGTIxhmTnS8eGHXuic6R7qZf9oZ/bEwZo9rgx
         CS7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=HWTEGD0gHRE0W2fArZHPNDk0P/N5GTWt9YJ9YHd0/+c=;
        b=EKVQIscKwRb0rKx3A0rLql5nxMXU7FXEq3TZj541hdmtFumSGF5Cht2YPD5HrQpNJZ
         iaOuxGsJtBqKvoTY6sqQYypUN6R/4mrPoD42ySLy169l/tuCl79Qx8UdPgdx0crNB+BS
         TIQrqQJr/6DA3IMOzUDuZP00/g6p5wQfVRLLsa95a+VHNy6bJo5fgwxrMnHAuLcmTXs0
         0HcDmKCLU+2T2Flh8FXKtounzOiPlJbwa6fXi8O7maSNrZFHAFFNZt2Qwf9iML4b4enj
         1IHW97oT7RxNIBVh3mHPYC+u5iQucuRLjMMqDiloYmuKFrMQHf2vQws7bUA4UhW3kepz
         pTbA==
X-Gm-Message-State: AOAM532hsXu0smajCH/tQZ/rOXIAB8gQV7HfglSZShY+VmzFB5Rnp52N
        JkaFWmvXp+dH67EiFW0W7R3mRrT1yjKm
X-Google-Smtp-Source: ABdhPJwb+EpApH8Cd4sC+NlnC/rQ0AC0mOghuJl43UwrKDrFjOgdMwyRgYCCuPZajOxFRNyHSfDYM8890uXH
Sender: "irogers via sendgmr" <irogers@irogers.svl.corp.google.com>
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:2:f693:9fff:fef4:4583])
 (user=irogers job=sendgmr) by 2002:ad4:5483:: with SMTP id
 q3mr1176744qvy.24.1606894796326; Tue, 01 Dec 2020 23:39:56 -0800 (PST)
Date:   Tue,  1 Dec 2020 23:39:48 -0800
Message-Id: <20201202073953.3811709-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: [PATCH v5 0/5] Don't compute events that won't be used in a metric.
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
        Ian Rogers <irogers@google.com>
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

v5. uses macros to reduce boiler plate in patch 5/5 as suggested by
Andi Kleen <ak@linux.intel.com>.

v4. reduces references to BOTTOM/NAN in patch 5/5 by using utility
functions. It improves comments and fixes an unnecessary union in a
peephole optimization.

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

 tools/perf/tests/expr.c       | 159 +++++++++++-----
 tools/perf/tests/pmu-events.c |  42 +++--
 tools/perf/util/expr.c        | 136 ++++++++++++--
 tools/perf/util/expr.h        |  17 +-
 tools/perf/util/expr.l        |   9 -
 tools/perf/util/expr.y        | 343 ++++++++++++++++++++++++++--------
 tools/perf/util/metricgroup.c |  44 +++--
 tools/perf/util/stat-shadow.c |  54 ++++--
 8 files changed, 586 insertions(+), 218 deletions(-)

-- 
2.29.2.454.gaff20da3a2-goog

