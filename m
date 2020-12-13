Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3220A2D8D52
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Dec 2020 14:41:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406897AbgLMNkK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Dec 2020 08:40:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406885AbgLMNjr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Dec 2020 08:39:47 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABEFDC061794
        for <linux-kernel@vger.kernel.org>; Sun, 13 Dec 2020 05:39:06 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id 190so1185808wmz.0
        for <linux-kernel@vger.kernel.org>; Sun, 13 Dec 2020 05:39:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5arHVKjDagkeLABhmzK0pzLFYqSaaatbyWyRh7boC8k=;
        b=tYPlj9D8lwlPzpAFSJvspUH5Gn7455n6nIydemul8Oi/XZ8IOY70X6b+RVB7iuk4N5
         //s6w1noaiY7pKH1N4pd36CldofrAhaB8b+5NEzzsBe7mK2AEZCutQSJjpLPH1HJwkIH
         w+5N7obtlu2qsB9dOnEjNNYGvW+qtPst2QrpIjD1zXoBR6x1s4CjezwApneG2q+fzB0w
         7grSO2caNsj+BV0xDF/8Vixv5DXabd/rGi36rGRhNSQWc7fv0gG4YY2ElFGcyscP0V3E
         cckmDS4KBmnWYQ9Wx4lSmJDQtAV7yUqcc0RA3p5ytXMK5QJ7vK9WdP8ubU79vWd23elo
         bIyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5arHVKjDagkeLABhmzK0pzLFYqSaaatbyWyRh7boC8k=;
        b=mCbV5fcB3EiQpmuv+iXbX1TV/he8xP8uEpAzZOgRnUlhwvparfOvVncVTcFLIDMj1c
         VP+eDazmBBu/fytnzhhXl55fLw/OtJVYHKd5WOnw9GxbNPk/n6tXt0OohbhS12zTk5x4
         23hxhks4oXIq+Arispqah40YY6kXhvT+0MBoSEG5PEDNN4ikFbODc7LguaDumg4UMjcO
         d6muu3QmVfmdeMzX5kaYCyrmGXdAFBkaG3eZShrn0F/Yt2nK1Q9PLIAhZE4oLOYgGQZw
         ePIS/QFqquYmo7+OmkIazirZogV2TQG6e7mrDG8RDdQGYnjT54upq8KABxkYCU4Zgp0b
         JSAw==
X-Gm-Message-State: AOAM531BLi/lCr7GBA4vGrI4GJ3KZydlQSBym5+Qdo/yjbBbrEn4mYOs
        YpFdw693Pd9Q1Ownsc6XoPX1UQ==
X-Google-Smtp-Source: ABdhPJyb1sqUsX6riEZRewcnI8rQy6B3ZuAo94SCdP3DLaT3g1fjj4UEzBlsww7Ql29po/BOedgQYQ==
X-Received: by 2002:a1c:bd43:: with SMTP id n64mr23292504wmf.169.1607866745433;
        Sun, 13 Dec 2020 05:39:05 -0800 (PST)
Received: from hackbox2.linaro.org ([81.128.185.34])
        by smtp.gmail.com with ESMTPSA id l7sm25180387wme.4.2020.12.13.05.39.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Dec 2020 05:39:04 -0800 (PST)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Joe Mario <jmario@redhat.com>, David Ahern <dsahern@gmail.com>,
        Don Zickus <dzickus@redhat.com>, Al Grant <Al.Grant@arm.com>,
        James Clark <james.clark@arm.com>, linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v2 04/11] perf c2c: Rename for shared cache line stats
Date:   Sun, 13 Dec 2020 13:38:43 +0000
Message-Id: <20201213133850.10070-5-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201213133850.10070-1-leo.yan@linaro.org>
References: <20201213133850.10070-1-leo.yan@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For shared cache line statistics, it relies on HITM.  We can use more
general naming rather than only binding to HITM, so replace "hitm_stats"
with "shared_clines_stats" in structure perf_c2c, and rename function
resort_hitm_cb() to resort_shared_cl_cb().

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/builtin-c2c.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index 27745340c14a..580c4ead68db 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -97,8 +97,8 @@ struct perf_c2c {
 	bool			 symbol_full;
 	bool			 stitch_lbr;
 
-	/* HITM shared clines stats */
-	struct c2c_stats	hitm_stats;
+	/* Shared clines stats */
+	struct c2c_stats	shared_clines_stats;
 	int			shared_clines;
 
 	int			 display;
@@ -2251,7 +2251,7 @@ static int resort_cl_cb(struct hist_entry *he, void *arg __maybe_unused)
 {
 	struct c2c_hist_entry *c2c_he;
 	struct c2c_hists *c2c_hists;
-	bool display = he__display(he, &c2c.hitm_stats);
+	bool display = he__display(he, &c2c.shared_clines_stats);
 
 	c2c_he = container_of(he, struct c2c_hist_entry, he);
 	c2c_hists = c2c_he->hists;
@@ -2338,14 +2338,14 @@ static int setup_nodes(struct perf_session *session)
 
 #define HAS_HITMS(__h) ((__h)->stats.lcl_hitm || (__h)->stats.rmt_hitm)
 
-static int resort_hitm_cb(struct hist_entry *he, void *arg __maybe_unused)
+static int resort_shared_cl_cb(struct hist_entry *he, void *arg __maybe_unused)
 {
 	struct c2c_hist_entry *c2c_he;
 	c2c_he = container_of(he, struct c2c_hist_entry, he);
 
 	if (HAS_HITMS(c2c_he)) {
 		c2c.shared_clines++;
-		c2c_add_stats(&c2c.hitm_stats, &c2c_he->stats);
+		c2c_add_stats(&c2c.shared_clines_stats, &c2c_he->stats);
 	}
 
 	return 0;
@@ -2416,7 +2416,7 @@ static void print_c2c__display_stats(FILE *out)
 
 static void print_shared_cacheline_info(FILE *out)
 {
-	struct c2c_stats *stats = &c2c.hitm_stats;
+	struct c2c_stats *stats = &c2c.shared_clines_stats;
 	int hitm_cnt = stats->lcl_hitm + stats->rmt_hitm;
 
 	fprintf(out, "=================================================\n");
@@ -3117,7 +3117,7 @@ static int perf_c2c__report(int argc, const char **argv)
 	ui_progress__init(&prog, c2c.hists.hists.nr_entries, "Sorting...");
 
 	hists__collapse_resort(&c2c.hists.hists, NULL);
-	hists__output_resort_cb(&c2c.hists.hists, &prog, resort_hitm_cb);
+	hists__output_resort_cb(&c2c.hists.hists, &prog, resort_shared_cl_cb);
 	hists__iterate_cb(&c2c.hists.hists, resort_cl_cb);
 
 	ui_progress__finish();
-- 
2.17.1

