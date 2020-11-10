Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BA682AD30E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 11:04:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730340AbgKJKD7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 05:03:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726467AbgKJKD6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 05:03:58 -0500
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C84AC0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 02:03:57 -0800 (PST)
Received: by mail-qk1-x74a.google.com with SMTP id s128so8313538qke.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 02:03:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=9+Z5Azrmhj3misriF6374XK8m6z58w8n3ugZjk4JaN4=;
        b=V0fmKmvdi1nl1i8calDh77i6i2t9GssMH+4a/5GfKwU6Ws+P7b6OaxTUH1UadV1ZWa
         jQqEKPrxcGijkoJy+1CW+h/aEBO0zXVJF0VFoAhR3DKWjrE9YaYnLGjTaY5MMtng3h+b
         wYWSayKXnRImU5qE5ineV9AYTAdSGn94X5jwTeohA7MzM/cGZZ9wQ5rJMZJFPaMYV857
         tXFt0VGCdjLX6HN3yqJYjruKSz6UocUTuVwSNFRtxJ4ou/5AWIZQk/09q3EfeoNZcIQR
         9yy+MSeUc19KQ/N8dYxbS8E1UlXhX30sjX6prp5G4uUNI0x8OuTO4TshA1s51+0TbB2f
         29tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=9+Z5Azrmhj3misriF6374XK8m6z58w8n3ugZjk4JaN4=;
        b=egO0gHh4dqPfP2rgERQTLMDi4R5Kl8a4JWzPCT/s4xXTCj8fkCjKpOp1e2sEZWR9/X
         03uYfDYHErJgDIO3xZ8TC1XdXgEXIkr7mr3Onj6PXf+pQNHbppbd/HOzP5hIZfj5lCvi
         4w68YxbA0SMUoDYnAq+f3LQXRn5ZQoaoNj7GHcaERdD52TIOpl2nIuknjjGSVLR4HBEw
         taWZdyuapJwUrLIPCYfiwfl1hqEB2MlzB9h0+gf0APy4LNiyiZYxKUeifgKAiI1LpyaO
         7L0YMMtA+OWostDlKTrZ13DLPgTI72xa3D8bgO/5hImHf+UgaY7S5Ys0N4t7l+OT/lRa
         KqZw==
X-Gm-Message-State: AOAM530tdWbLV5WT3cgAr3DlOkUNtxR1KjVnwZuMiuoILjprNDbp8uNB
        15PP/AF72iImBIByMuUifMRv+Omv4OK4
X-Google-Smtp-Source: ABdhPJwRbo1RuEFty2F1Vzz5WibkDWFZrL4QhRKz/wrhWoDpmtO/59xyKJF37CeOzp4xxjla6h2FYe785j2s
Sender: "irogers via sendgmr" <irogers@irogers.svl.corp.google.com>
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:2:f693:9fff:fef4:4583])
 (user=irogers job=sendgmr) by 2002:a0c:8f09:: with SMTP id
 z9mr12954541qvd.3.1605002636233; Tue, 10 Nov 2020 02:03:56 -0800 (PST)
Date:   Tue, 10 Nov 2020 02:03:34 -0800
Message-Id: <20201110100346.2527031-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8-goog
Subject: [RFC PATCH 00/12] Topdown parser
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

This RFC is for a new tool that reads TMA_Metrics.csv as found on
download.01.org/perfmon and generates metrics and metric groups from
it. To show the functionality the TMA_Metrics.csv is downloaded, but
an accepted change would most likely include a copy of this file from
Intel. With this tool rather than just level 1 topdown metrics, a full
set of topdown metrics to level 4 are generated.

This change was:
Suggested-by: Stephane Eranian <eranian@google.com>

Sandeep Dasgupta (12):
  perf topdown-parser: Add a simple logging API.
  perf topdown-parser: Add utility functions.
  perf topdown-paser: Add a CSV file reader.
  perf topdown-parser: Add a json file reader.
  perf topdown-parser: Add a configuration.
  perf topdown-parser: Interface for TMA_Metrics.csv.
  perf topdown-parser: Metric expression parser.
  perf topdown-parser: Add event interface.
  perf topdown-paser: Add code generation API.
  perf topdown-parser: Add json metric code generation.
  perf topdown-parser: Main driver.
  perf pmu-events: Topdown parser tool

 tools/perf/Makefile.perf                      |  13 +-
 tools/perf/pmu-events/Build                   |  50 +-
 tools/perf/pmu-events/topdown-parser/README   |   5 +
 .../topdown-parser/code_gen_target.cpp        |  51 +
 .../topdown-parser/code_gen_target.h          |  77 ++
 .../code_gen_target_perf_json.cpp             | 546 ++++++++++
 .../code_gen_target_perf_json.h               |  25 +
 .../topdown-parser/configuration.cpp          | 198 ++++
 .../pmu-events/topdown-parser/configuration.h | 181 ++++
 .../topdown-parser/configuration.json         |  72 ++
 .../pmu-events/topdown-parser/csvreader.cpp   |  49 +
 .../pmu-events/topdown-parser/csvreader.h     |  51 +
 .../topdown-parser/dependence_dag_utils.cpp   | 984 ++++++++++++++++++
 .../topdown-parser/dependence_dag_utils.h     | 178 ++++
 .../pmu-events/topdown-parser/event_info.cpp  | 443 ++++++++
 .../pmu-events/topdown-parser/event_info.h    | 114 ++
 .../pmu-events/topdown-parser/expr_parser.y   | 224 ++++
 .../topdown-parser/general_utils.cpp          | 173 +++
 .../pmu-events/topdown-parser/general_utils.h | 131 +++
 .../pmu-events/topdown-parser/jsmn_extras.cpp | 199 ++++
 .../pmu-events/topdown-parser/jsmn_extras.h   |  42 +
 .../perf/pmu-events/topdown-parser/logging.h  |  25 +
 .../topdown-parser/topdown_parser_main.cpp    | 155 +++
 23 files changed, 3981 insertions(+), 5 deletions(-)
 create mode 100644 tools/perf/pmu-events/topdown-parser/README
 create mode 100644 tools/perf/pmu-events/topdown-parser/code_gen_target.cpp
 create mode 100644 tools/perf/pmu-events/topdown-parser/code_gen_target.h
 create mode 100644 tools/perf/pmu-events/topdown-parser/code_gen_target_perf_json.cpp
 create mode 100644 tools/perf/pmu-events/topdown-parser/code_gen_target_perf_json.h
 create mode 100644 tools/perf/pmu-events/topdown-parser/configuration.cpp
 create mode 100644 tools/perf/pmu-events/topdown-parser/configuration.h
 create mode 100644 tools/perf/pmu-events/topdown-parser/configuration.json
 create mode 100644 tools/perf/pmu-events/topdown-parser/csvreader.cpp
 create mode 100644 tools/perf/pmu-events/topdown-parser/csvreader.h
 create mode 100644 tools/perf/pmu-events/topdown-parser/dependence_dag_utils.cpp
 create mode 100644 tools/perf/pmu-events/topdown-parser/dependence_dag_utils.h
 create mode 100644 tools/perf/pmu-events/topdown-parser/event_info.cpp
 create mode 100644 tools/perf/pmu-events/topdown-parser/event_info.h
 create mode 100644 tools/perf/pmu-events/topdown-parser/expr_parser.y
 create mode 100644 tools/perf/pmu-events/topdown-parser/general_utils.cpp
 create mode 100644 tools/perf/pmu-events/topdown-parser/general_utils.h
 create mode 100644 tools/perf/pmu-events/topdown-parser/jsmn_extras.cpp
 create mode 100644 tools/perf/pmu-events/topdown-parser/jsmn_extras.h
 create mode 100644 tools/perf/pmu-events/topdown-parser/logging.h
 create mode 100644 tools/perf/pmu-events/topdown-parser/topdown_parser_main.cpp

-- 
2.29.2.222.g5d2a92d10f8-goog

