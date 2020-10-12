Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0FEC28AEB4
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 09:02:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbgJLHCn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 03:02:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726789AbgJLHC1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 03:02:27 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40CF1C0613CE
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 00:02:27 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id q21so2154050pgi.13
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 00:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3zQ0ZKMTCzEt6szqzQhQ21AIFYcozsAAi+5Y7N9IeNA=;
        b=bC0mCzply++6lcw/w36QILERNw5Nv3tEF7Ie5NBSUxzlevYovh1qtqIKwU0AOa1FtL
         QgMksT/jsJgLJWGKGQBYBj/sg2g+hM5q1tFk1iuoV+Hfx6dGwVIBPXuQbaawVfjSSScM
         QZDDScImXV9rsUEnl9KZMqbWTI57XrXdHzm5Am7g9VRBgVgQD7A0jCkgSNDQ3jVvKYy9
         m47wZNS4jLlKWL7KkHWsv5vYWMKR0Lb8UgEUz16I91DHgkQKttktwA/W1uiOl9X9ny6z
         LkRk3OPv59u9eJ9hkMWxqVc7XM/d5SBH6oUCuM9U7jrQY4mDwsIa3Q2REORPAxycpY+U
         u7oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=3zQ0ZKMTCzEt6szqzQhQ21AIFYcozsAAi+5Y7N9IeNA=;
        b=CkqR3WQa2L74CIEmz411BeOT6KDxk4SQ1J3f1XjFCR/1bd2kQBs15Hc2dXtlN15Zy6
         M9Ya8KV4XMa5ta8fF36Uturfl2VpSWqqfvngOu81Vp9zkud7LmsJfNaU4y/Z4tdcPBsq
         lK9o36Gkmjm3z7knltE6D9KJoVlGmY5zh/YHuS7pqBhKZZon0lsks2Zurg15ELfYaSIq
         5L49MntCWtcTpgAvcLO78uYjw+oBMjd5fGoOVWZn51+jz0jgiUhVn6YlFghKCzVU9dbp
         lQiIH/1YDzOOmdn0j1gbCnFjhS+HEIshOZq1t+x7PoinTyllwXDxczawJmzNa/gAQMmI
         uvKg==
X-Gm-Message-State: AOAM532sjigrUTYggsC2nWEuxGTpLWa+mPAzO3puSj9tohPunX8+kqLN
        jN7EzTiiNoLP78esGkZOuvo=
X-Google-Smtp-Source: ABdhPJzYZoVzKMOmF3j+sQkLASQK6qv+0Di5+9qcl4hSCMw71gDBSWv3FqbpD2iE5UI1eV0cwbF58A==
X-Received: by 2002:aa7:8d4c:0:b029:150:f692:4129 with SMTP id s12-20020aa78d4c0000b0290150f6924129mr22408842pfe.11.1602486146817;
        Mon, 12 Oct 2020 00:02:26 -0700 (PDT)
Received: from balhae.roam.corp.google.com ([112.159.19.5])
        by smtp.gmail.com with ESMTPSA id n12sm18082556pgk.20.2020.10.12.00.02.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2020 00:02:26 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Subject: [PATCH 2/6] perf inject: Add missing callbacks in perf_tool
Date:   Mon, 12 Oct 2020 16:02:10 +0900
Message-Id: <20201012070214.2074921-3-namhyung@kernel.org>
X-Mailer: git-send-email 2.28.0.1011.ga647a8990f-goog
In-Reply-To: <20201012070214.2074921-1-namhyung@kernel.org>
References: <20201012070214.2074921-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I found some events (like PERF_RECORD_CGROUP) are not copied by perf
inject due to the missing callbacks.  Let's add them.

While at it, I've changed the order of the callbacks to match with
struct perf_tool so that we can compare them easily.

Acked-by: Jiri Olsa <jolsa@redhat.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-inject.c | 36 +++++++++++++++++++++++++++++++-----
 1 file changed, 31 insertions(+), 5 deletions(-)

diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index e4d78f11494e..2c5e23d73a8a 100644
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
@@ -707,9 +721,12 @@ int cmd_inject(int argc, const char **argv)
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
@@ -717,19 +734,28 @@ int cmd_inject(int argc, const char **argv)
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
2.28.0.1011.ga647a8990f-goog

