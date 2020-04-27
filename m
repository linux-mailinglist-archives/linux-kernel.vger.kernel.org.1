Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 223201BB062
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Apr 2020 23:20:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726866AbgD0VUC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Apr 2020 17:20:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:36284 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726030AbgD0VUA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 17:20:00 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 68A832087E;
        Mon, 27 Apr 2020 21:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588022400;
        bh=ATNvUB+RDOUU4Zw8jalEgQKIa8iNkrmEm5PCk/2EQHg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cMAnBqDMxoVHrm4PM6FFQYXmLDMe4rvE8ChQDZiXGiyiuuciKKgRrJvyuMWYlBcat
         0hUApb3k5UJwXEXtGuEwQS12ggLq6JMYhB5l849XNyitt8c8Mn196IiAeT2FeWyJG1
         THeDLAbyK6BQ5L3w6ACVltKK9Msw4pcQ+MrqalJ8=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Song Liu <songliubraving@fb.com>
Subject: [PATCH 4/7] perf bpf: Decouple creating the evlist from adding the SB event
Date:   Mon, 27 Apr 2020 18:19:32 -0300
Message-Id: <20200427211935.25789-5-acme@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200427211935.25789-1-acme@kernel.org>
References: <20200427211935.25789-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Renaming bpf_event__add_sb_event() to evlist__add_sb_event() and
requiring that the evlist be allocated beforehand.

This will allow using the same side band thread and evlist to be used
for multiple purposes in addition to react to PERF_RECORD_BPF_EVENT soon
after they are generated.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Song Liu <songliubraving@fb.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/bpf-event.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/bpf-event.h b/tools/perf/util/bpf-event.h
index 2c7a50509659..68f315c3df5b 100644
--- a/tools/perf/util/bpf-event.h
+++ b/tools/perf/util/bpf-event.h
@@ -45,7 +45,7 @@ static inline int machine__process_bpf(struct machine *machine __maybe_unused,
 	return 0;
 }
 
-static inline int evlist__add_bpf_sb_event(struct evlist **evlist __maybe_unused,
+static inline int evlist__add_bpf_sb_event(struct evlist *evlist __maybe_unused,
 					   struct perf_env *env __maybe_unused)
 {
 	return 0;
-- 
2.21.1

