Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 588C027A913
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 09:53:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726774AbgI1HxK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 03:53:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726552AbgI1HxH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 03:53:07 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3391BC0613CE
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 00:53:07 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id k8so222933pfk.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 00:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WtfZRGGrwIs72AeLiYs+sPxaS7Li3SUsP+N6qVwz88Y=;
        b=s7Sdd1pjgK/mtxEuIwnDZbEEC554RkczJJ88b0rdRVbh53TiaUtT1WDGloL1ZnzxsF
         AA9A+RUKLwkBaAl/SXv3X6OqP/J+SUCsu65BhL5YsexrTBqqOBYCrqNSDLbOOn6FjriN
         fzTxc9hSffe3Hc8H8sZxCMfihQVcpPW4sDZc103t1yPhjOtdgzSfO4E+sdqnvaUqKZrf
         jCY8CXDEjIgo3cMJ0QRMLSSznzQYZNcFRkzErTf9VGLHum2NXgoS+Qr+fdydCqNyAn0r
         1ZOOE4EJdG5iephPndVGQXmqu+Qh0UEPH6jYU9voij4okJQhgRiKtWFcJlR0Tnhn68dU
         5L6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=WtfZRGGrwIs72AeLiYs+sPxaS7Li3SUsP+N6qVwz88Y=;
        b=ID80Qfl6GzqxvvBVa4HeM/F7TQrUDSyVeOOkRikL/cAXHV2kWJ/KRVdZ//EdSM5CQp
         6oEZrRo1obmDdROwhfK0mdlDtN+ti0MqJm0NnPRCQmHDccGdScSq2ZkkdPqOP+4LNYad
         itrk5U0z/1+a7KaSIfoxXtzhlhQR4gsKqNlJXXvQLYF3kWCX84S0JyKdwhoG58XdsXvH
         X+3f0LesTTmRJNWL3CnwUM/8P+cH/SVHrvgQiwlYurKwDAyMCHwoeRhCD4izl3prt8m3
         WCq9g0k8EhgVNfP5wX27jq4L6xz6EPOzueF/uucupTwyc13+3q4qPKyc9HGPuL6PPd45
         36gA==
X-Gm-Message-State: AOAM532MMc2z1NluphpXqTSd9YSp4hMEeiy/fLnmMORt5VIDltCXUbMG
        7Qbgw4xeJz3+Qwv3NSYi45w=
X-Google-Smtp-Source: ABdhPJxqb2UJY1EzwBSIpaOe9gEZzmk3x4G6OcY40BL2etnjbiV66Z6SiImt/+m0WSA8P7YLL/uNgQ==
X-Received: by 2002:a17:902:c394:b029:d2:4ca:2e22 with SMTP id g20-20020a170902c394b02900d204ca2e22mr437600plg.77.1601279586792;
        Mon, 28 Sep 2020 00:53:06 -0700 (PDT)
Received: from balhae.roam.corp.google.com ([101.235.31.111])
        by smtp.gmail.com with ESMTPSA id 141sm520241pfb.50.2020.09.28.00.53.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2020 00:53:06 -0700 (PDT)
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
Date:   Mon, 28 Sep 2020 16:52:42 +0900
Message-Id: <20200928075246.853729-3-namhyung@kernel.org>
X-Mailer: git-send-email 2.28.0.681.g6f77f65b4e-goog
In-Reply-To: <20200928075246.853729-1-namhyung@kernel.org>
References: <20200928075246.853729-1-namhyung@kernel.org>
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
2.28.0.681.g6f77f65b4e-goog

