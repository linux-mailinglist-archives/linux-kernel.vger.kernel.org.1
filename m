Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49F3126774E
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Sep 2020 04:57:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725838AbgILC5F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Sep 2020 22:57:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725765AbgILC46 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 22:56:58 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5910C061573
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 19:56:58 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id s3so10845301ybi.18
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 19:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=m07aqYCBr3BugQcnNhbXBunb8rguqcPxK+1uBceisy4=;
        b=o8gd8L6cwO7USS+zSeJvNGNPvSjkj3df9QrcXoii7Dj+MjLEgMkReLgRPFgPNejXYo
         g8ctX6BQLS0y8MwnOS362iGE3i9SUp5J8rdAlKvTa185XVXDVpcz4oY0k1uzXGqfyOfW
         AZzBINXmWkoh1485ZYyiWuYBI/48wE9i3tZEzW0MhwhDv1rTj+qkIxDXS5A1WnKz+Dxt
         s6vvazXjmoUb+Usq+xx++LL4WgmbkH6qytSUPmIKE/nmRuLZE2CNbUMo10l/uQ+meKOD
         m6W770lNlKtciQ6ta5gSZnzO5pMnznEX2vzg5toDhjVhUdVaAUk5OAlmA7QJBwfs7B+z
         4Esg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=m07aqYCBr3BugQcnNhbXBunb8rguqcPxK+1uBceisy4=;
        b=YHzzrLYokce585mh/itCuKWTnXcwkJKeubM0ck2kWziVei3KQkF3RFIgU7vhtKkfke
         +Oa7XpF8Y8s5dnkK75yOjMXYiT/lQaqYjwlmXvUtQPoLmxbbOKlWqAbaJqaKBMYOL40H
         2rD5LynPI9Ebzjl3hBKXaZty4P1iLfb4eu3WkkI8J0jn0r+xVhrf13MoUK7dA0WNw2rr
         +G3p1nikLMsw5JmIsWE4TgRLcJXqIPa6P25JuddGloL5RSDpxENloYDqEtTXuQZg7hDp
         Z8xM48aO6Sxvm+pq3v0/4+FB3J9IDPiDloz7lyuRysV0ZfDSaZtHkJQy9S+QvoZRwTas
         fQDg==
X-Gm-Message-State: AOAM533ScHBMqJZ9sqfMYG/KZ3oYPi5qEIrA2bh00NfCW7X3BvJD7kH/
        RIV2QOSbU6UUNt+c0gLU6tHL/SGZNoqV
X-Google-Smtp-Source: ABdhPJykicvlDlpk6vddU+n3i8ZICnShO591arsdtiL3sRk9G5NjJiJWw/dwGWCtCVTJAvwbSYst8tq9iAnr
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:2:f693:9fff:fef4:4583])
 (user=irogers job=sendgmr) by 2002:a25:d010:: with SMTP id
 h16mr6745698ybg.439.1599879416979; Fri, 11 Sep 2020 19:56:56 -0700 (PDT)
Date:   Fri, 11 Sep 2020 19:56:51 -0700
Message-Id: <20200912025655.1337192-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.618.gf4bc123cb7-goog
Subject: [PATCH v3 0/4] Fixes for setting event freq/periods
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some fixes that address issues for regular and pfm4 events with 2
additional perf_event_attr tests. Various authors, David Sharp isn't
currently at Google.

v3. moved a loop into a helper following Adrian Hunter's suggestion. 
v2. corrects the commit message following Athira Rajeev's suggestion.

David Sharp (1):
  perf record: Set PERF_RECORD_PERIOD if attr->freq is set.

Ian Rogers (2):
  perf record: Don't clear event's period if set by a term
  perf test: Leader sampling shouldn't clear sample period

Stephane Eranian (1):
  perf record: Prevent override of attr->sample_period for libpfm4
    events

 tools/perf/tests/attr/README             |  1 +
 tools/perf/tests/attr/test-record-group2 | 29 ++++++++++++++++++++
 tools/perf/util/evsel.c                  | 10 ++++---
 tools/perf/util/record.c                 | 34 ++++++++++++++++++------
 4 files changed, 63 insertions(+), 11 deletions(-)
 create mode 100644 tools/perf/tests/attr/test-record-group2

-- 
2.28.0.618.gf4bc123cb7-goog

