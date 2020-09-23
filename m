Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C8622752D7
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 10:06:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726514AbgIWIFz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 04:05:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgIWIFv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 04:05:51 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 535A2C061755
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 01:05:51 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id n14so14549378pff.6
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 01:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ipZsPpI1l949+Y00OB2mGaurslBcQWaHB7GJebVoy64=;
        b=Fhx25evd0gTbMs0TQJFRvgiGLkKdVGnMhSZLB4nU2aSOcqHm039XmhGtL8Ws8xd1CP
         Ifd2usDE125buCsohzqTps6i43cAnaPNaNrCd1VJ6jcEDdbQvlDWWAWHKhWd2wJ6XkkJ
         Qm0ol4GUuZiSjRnnmCdiCuwtbuEPjlweL1ae3sE78wIG88YjzHHdKlzDHHK2QmrdZzpX
         F4k0zGK5kvFINzuFZkEr01S0wm/USWZbBAHDD/vGNOk2nuJ0xfCR0tKXmHUKhZV6cULm
         JXCszKmoytOFM35iem9Y8AUbE5cMlnjqgE2thxhr5zjkIHo0dMu3WxArv7yiGHqpVtJI
         +gMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=ipZsPpI1l949+Y00OB2mGaurslBcQWaHB7GJebVoy64=;
        b=GBAyEfplQNm2inhsNibyQTnhbt5CJhP4m+ybY3Anogo0FLwDH/N8bOIT07q7Xb4iUM
         qRlUo99G7395pNh9eYiVhYd9Rj9uOEGPV1hJdiJkLNVSL7XYMPNDBz20tTTJfNR1OKIE
         SmW0o3RvsK8AwCVYKT4LdpgRB77zC5HjEFisV7a5jBDLFUKU/92kUtZFRan14Gz7VTFb
         K2+CR/zFCejh0HyJ335QGfEYWJpp8TAdLvCWJ+FHFpH5oVrnnFDQ/0NpBYclJBl6b/oP
         zwf0RCMy1r1yAIHCKyvKudUSkAZu5/tA7hB8NFcTotVKK6mIIg489l78gsDj1NsuuXNk
         TrvQ==
X-Gm-Message-State: AOAM5302JPGj/yy2FkPahWioWAzhrt5hO17obXLkRqB2QzKXmXK04QBq
        ZVBggiGgflVbAOICDSmiCJM=
X-Google-Smtp-Source: ABdhPJx+G42X5EmcRswfQQXBMtEN2tKWyi2EjphtYjaGA1a13gxMdpU6qJ+YBBIr8pOoMtmk21WtIg==
X-Received: by 2002:a62:bd0e:0:b029:142:2501:35e7 with SMTP id a14-20020a62bd0e0000b0290142250135e7mr7516071pff.71.1600848350828;
        Wed, 23 Sep 2020 01:05:50 -0700 (PDT)
Received: from balhae.roam.corp.google.com ([101.235.31.111])
        by smtp.gmail.com with ESMTPSA id a27sm17568441pfk.52.2020.09.23.01.05.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2020 01:05:50 -0700 (PDT)
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
Subject: [PATCH 2/7] perf inject: Add missing callbacks in perf_tool
Date:   Wed, 23 Sep 2020 17:05:32 +0900
Message-Id: <20200923080537.155264-3-namhyung@kernel.org>
X-Mailer: git-send-email 2.28.0.681.g6f77f65b4e-goog
In-Reply-To: <20200923080537.155264-1-namhyung@kernel.org>
References: <20200923080537.155264-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
2.28.0.681.g6f77f65b4e-goog

