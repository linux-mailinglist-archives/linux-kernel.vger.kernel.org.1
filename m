Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B714B268D4F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 16:20:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726373AbgINOUJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 10:20:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726341AbgINOTG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 10:19:06 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1366C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 07:19:05 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id k14so1294878pgi.9
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 07:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vbq02amWOlur8n5qjzsFBeIYlSBzOh2W3+FsUaxeGIY=;
        b=AtCdXEhrw+93X+NcvOv3oVnTqK3rIG0EajyKRbAKoSCJCnQ4jj/h1coOzK2jfWEs1k
         Os61bVQZO0BmhbGWu+STP4DGx5bdZ0UuXGaT17jUYux7Feu2jIFwypUrR00/R/ORFkBl
         fIsNjB8Qe9NnMDosGHtvvhbMjIB9iXV/6qad8T1ACCgn8zVfHQ9shOHCrLPKkuZaeL+8
         ypvFzIiqZiHUuiVSeq+bVZWy6vVG8khHmLTDmKrNR0vDWBeuXleRNNyzYjHZ4d7PHVEL
         R3zmh9zB/SluOQaWqAquMd3MfE3w6x8NVXCGY3pMhbdFFAIaI+FF5LNiWyNy+T/TA+GR
         qXtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=vbq02amWOlur8n5qjzsFBeIYlSBzOh2W3+FsUaxeGIY=;
        b=o5b5rTg0deFeWqI5XOiN19jocPQLsJirYBzzYN7Wtwc4OBMDHrcGU20bJy945dRfRE
         b5k5wmRZgTrQNA/oXQW+lHxUx5QqUK6Oh9D+KjolSjeZKgthjJYY3LsmpbYGH6v0nYJW
         sEWtmAXLT/k29zlEk/DrvuwsQmbN6Qs0tdI6cskHVKjDu1BcwwKT2xu2m2cVa7Mr08rX
         6yFYXiZtwGGMN8iSCRkvSwl773Ev65g79FEsw7OrnT2kDvcn4v4j+HrHBhuJ5UKw7FNF
         O2TyPjqfstp2WZU6E0lmtXgbQHtT73rlaCe2btcU1Sr8KxL/a3seekO7nL+IscjSJkKD
         UB1Q==
X-Gm-Message-State: AOAM5305H/nUR7woDRB1DgpelsZXOJjVny0PHLhnWv+ifhiD2FkplYKt
        4V1FjFG1XTSzcVyIN/Az2rY=
X-Google-Smtp-Source: ABdhPJz6o2vgs2WE4O9W6/LrbXVtJv6lEsJjPrlgu+jxi/Fp0cgt9EzRbSG3jj2jOOIoshJa0fYoVQ==
X-Received: by 2002:a62:7ecb:0:b029:13e:d13d:a04c with SMTP id z194-20020a627ecb0000b029013ed13da04cmr13061926pfc.18.1600093145237;
        Mon, 14 Sep 2020 07:19:05 -0700 (PDT)
Received: from balhae.roam.corp.google.com ([101.235.31.111])
        by smtp.gmail.com with ESMTPSA id c3sm9209440pfn.23.2020.09.14.07.19.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 07:19:04 -0700 (PDT)
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>
Subject: [PATCH 1/3] perf inject: Add missing callbacks in perf_tool
Date:   Mon, 14 Sep 2020 23:18:57 +0900
Message-Id: <20200914141859.332459-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.28.0.618.gf4bc123cb7-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I found some events (like PERF_RECORD_CGROUP) are not copied by perf
inject due to the missing callbacks.  Let's add them.

While at it, I've changed the order of the callbacks to match with
struct perf_tool so that we can compare them easily.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-inject.c | 36 +++++++++++++++++++++++++++++++-----
 1 file changed, 31 insertions(+), 5 deletions(-)

diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index 6d2f410d773a..59576877c67f 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -97,6 +97,13 @@ static int perf_event__repipe_op2_synth(struct perf_session *session,
 	return perf_event__repipe_synth(session->tool, event);
 }
 
+static int perf_event__repipe_op4_synth(struct perf_session *session,
+					union perf_event *event,
+					u64 data __maybe_unused)
+{
+	return perf_event__repipe_synth(session->tool, event);
+}
+
 static int perf_event__repipe_attr(struct perf_tool *tool,
 				   union perf_event *event,
 				   struct evlist **pevlist)
@@ -115,6 +122,13 @@ static int perf_event__repipe_attr(struct perf_tool *tool,
 	return perf_event__repipe_synth(tool, event);
 }
 
+static int perf_event__repipe_event_update(struct perf_tool *tool,
+					   union perf_event *event,
+					   struct evlist **pevlist __maybe_unused)
+{
+	return perf_event__repipe_synth(tool, event);
+}
+
 #ifdef HAVE_AUXTRACE_SUPPORT
 
 static int copy_bytes(struct perf_inject *inject, int fd, off_t size)
@@ -708,9 +722,12 @@ int cmd_inject(int argc, const char **argv)
 	struct perf_inject inject = {
 		.tool = {
 			.sample		= perf_event__repipe_sample,
+			.read		= perf_event__repipe_sample,
 			.mmap		= perf_event__repipe,
 			.mmap2		= perf_event__repipe,
 			.comm		= perf_event__repipe,
+			.namespaces	= perf_event__repipe,
+			.cgroup		= perf_event__repipe,
 			.fork		= perf_event__repipe,
 			.exit		= perf_event__repipe,
 			.lost		= perf_event__repipe,
@@ -718,19 +735,28 @@ int cmd_inject(int argc, const char **argv)
 			.aux		= perf_event__repipe,
 			.itrace_start	= perf_event__repipe,
 			.context_switch	= perf_event__repipe,
-			.read		= perf_event__repipe_sample,
 			.throttle	= perf_event__repipe,
 			.unthrottle	= perf_event__repipe,
+			.ksymbol	= perf_event__repipe,
+			.bpf		= perf_event__repipe,
+			.text_poke	= perf_event__repipe,
 			.attr		= perf_event__repipe_attr,
+			.event_update	= perf_event__repipe_event_update,
 			.tracing_data	= perf_event__repipe_op2_synth,
-			.auxtrace_info	= perf_event__repipe_op2_synth,
-			.auxtrace	= perf_event__repipe_auxtrace,
-			.auxtrace_error	= perf_event__repipe_op2_synth,
-			.time_conv	= perf_event__repipe_op2_synth,
 			.finished_round	= perf_event__repipe_oe_synth,
 			.build_id	= perf_event__repipe_op2_synth,
 			.id_index	= perf_event__repipe_op2_synth,
+			.auxtrace_info	= perf_event__repipe_op2_synth,
+			.auxtrace_error	= perf_event__repipe_op2_synth,
+			.time_conv	= perf_event__repipe_op2_synth,
+			.thread_map	= perf_event__repipe_op2_synth,
+			.cpu_map	= perf_event__repipe_op2_synth,
+			.stat_config	= perf_event__repipe_op2_synth,
+			.stat		= perf_event__repipe_op2_synth,
+			.stat_round	= perf_event__repipe_op2_synth,
 			.feature	= perf_event__repipe_op2_synth,
+			.compressed	= perf_event__repipe_op4_synth,
+			.auxtrace	= perf_event__repipe_auxtrace,
 		},
 		.input_name  = "-",
 		.samples = LIST_HEAD_INIT(inject.samples),
-- 
2.28.0.618.gf4bc123cb7-goog

