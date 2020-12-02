Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 160BC2CC046
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 16:05:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730396AbgLBPDD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 10:03:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727753AbgLBPDC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 10:03:02 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1AAEC061A04
        for <linux-kernel@vger.kernel.org>; Wed,  2 Dec 2020 07:02:22 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id f17so1231372pge.6
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 07:02:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TCNWVU3OO9+0a2PLnvLJqeJ15b3W1+9HfAOGKsoXdvY=;
        b=R2w5VlCqnUAKCmplTH05qDd0jfpG8yXufUohoN6vsOA/O3G3StNShI30DdZ2mc3Lo1
         GpWuCAKq0Pj3ou8NZ3TcZZVSquPyOW98vOQh6SBb9qZG+UUajzNBVonxtX3FI461+yPt
         SswTzNe5G7TBFSg3H+PQmGWCNoajJ2hqBtC/M2XiRnm40zzKZHPnu2IJ9s3Tp1X818rH
         LfYqqkl1qVu0uMhUf5R57BUk1RusnOjjwvaTefze6dyDAFkRQZap9vuXyDzUy/Nabidc
         p9dVHdeTy58Pyg4fzwBw8yXeodoQU401GDzUhB8BMO3bsD52vmjW3+PAQyO7dDlaDpxy
         2BWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=TCNWVU3OO9+0a2PLnvLJqeJ15b3W1+9HfAOGKsoXdvY=;
        b=eK4zO5q+w1KzsZTY8oFQWVmThWeywGZHCK/hd0w0nmJNyqF5V3G8cvO7TNURPsGGBV
         oShLvsie3ApkxGHB3kHsmBJetu9QalJFZTVdDzKRWRHNfo0sqaeHgATX5LG0PLshwz3n
         L4yaBFeWjXBhTU4ij0hdTLcDuwN4l4px8QEpVfdtyOwuVz02tp3zTDYNSZsAbxF8NhRj
         P32p7+j+SChzl7jRYv/pU+RdGSpI2kDPRshLpA4L4nLEurN2ru8OUxEBAtx9f9JnxLrH
         aWJglZNOjH3+W43+Y3imbUv+QcO0xWG2eggGiiszlw1C5xgSHJTUB8zTZCh+El0GGcZ9
         amGw==
X-Gm-Message-State: AOAM532XnqVBSFOiYqbPyplxpKBar72SZCHhSX4anwUrZw4zPgM/bwAE
        otP//wsqj7FcxAUEJm9T/zw=
X-Google-Smtp-Source: ABdhPJxpInJ9PRuAe1FjGAwGjZAtfd5/rLzRtTqBGxdcmgAt+P12EijBSO5COpUfHZd3CvSOhyH3DQ==
X-Received: by 2002:aa7:9501:0:b029:155:3b11:d5c4 with SMTP id b1-20020aa795010000b02901553b11d5c4mr2896375pfp.76.1606921342353;
        Wed, 02 Dec 2020 07:02:22 -0800 (PST)
Received: from balhae.roam.corp.google.com ([101.235.31.111])
        by smtp.gmail.com with ESMTPSA id gz2sm82773pjb.2.2020.12.02.07.02.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 07:02:21 -0800 (PST)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: [RFC 2/2] perf tools: Add 'cgroup-switches' software event
Date:   Thu,  3 Dec 2020 00:02:05 +0900
Message-Id: <20201202150205.35750-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
In-Reply-To: <20201202150205.35750-1-namhyung@kernel.org>
References: <20201202150205.35750-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It counts how often cgroups are changed actually during the context
switches.

  # perf stat -a -e context-switches,cgroup-switches -a sleep 1

   Performance counter stats for 'system wide':

              11,267      context-switches
              10,950      cgroup-switches

         1.015634369 seconds time elapsed

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/include/uapi/linux/perf_event.h | 1 +
 tools/perf/util/parse-events.c        | 4 ++++
 tools/perf/util/parse-events.l        | 1 +
 3 files changed, 6 insertions(+)

diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
index b95d3c485d27..16559703c49c 100644
--- a/tools/include/uapi/linux/perf_event.h
+++ b/tools/include/uapi/linux/perf_event.h
@@ -112,6 +112,7 @@ enum perf_sw_ids {
 	PERF_COUNT_SW_EMULATION_FAULTS		= 8,
 	PERF_COUNT_SW_DUMMY			= 9,
 	PERF_COUNT_SW_BPF_OUTPUT		= 10,
+	PERF_COUNT_SW_CGROUP_SWITCHES		= 11,
 
 	PERF_COUNT_SW_MAX,			/* non-ABI */
 };
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 3b273580fb84..f6a5a099e143 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -145,6 +145,10 @@ struct event_symbol event_symbols_sw[PERF_COUNT_SW_MAX] = {
 		.symbol = "bpf-output",
 		.alias  = "",
 	},
+	[PERF_COUNT_SW_CGROUP_SWITCHES] = {
+		.symbol = "cgroup-switches",
+		.alias  = "",
+	},
 };
 
 #define __PERF_EVENT_FIELD(config, name) \
diff --git a/tools/perf/util/parse-events.l b/tools/perf/util/parse-events.l
index 9db5097317f4..88f203bb6fab 100644
--- a/tools/perf/util/parse-events.l
+++ b/tools/perf/util/parse-events.l
@@ -347,6 +347,7 @@ emulation-faults				{ return sym(yyscanner, PERF_TYPE_SOFTWARE, PERF_COUNT_SW_EM
 dummy						{ return sym(yyscanner, PERF_TYPE_SOFTWARE, PERF_COUNT_SW_DUMMY); }
 duration_time					{ return tool(yyscanner, PERF_TOOL_DURATION_TIME); }
 bpf-output					{ return sym(yyscanner, PERF_TYPE_SOFTWARE, PERF_COUNT_SW_BPF_OUTPUT); }
+cgroup-switches					{ return sym(yyscanner, PERF_TYPE_SOFTWARE, PERF_COUNT_SW_CGROUP_SWITCHES); }
 
 	/*
 	 * We have to handle the kernel PMU event cycles-ct/cycles-t/mem-loads/mem-stores separately.
-- 
2.29.2.454.gaff20da3a2-goog

