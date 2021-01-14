Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D74BB2F650D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 16:51:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727194AbhANPrh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 10:47:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725957AbhANPrg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 10:47:36 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A614FC061757
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 07:46:56 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id p18so4012968pgm.11
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 07:46:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JEIZptMsP3i/FDZXmToB0D7fOEQgkvKbzTSUeuV9O1Y=;
        b=ntfHALH/O7DbpfC9sjG7d4X6xSC4YDEAQvvW3RwnV5Fca/a8AduK32DdcH2oTgIKCm
         9uRahMjqsZW4Z1kqsaaJ3oeSwjmNiot6VOwD4kmykFI7QFjurNxF5hf2bMKWd1TNwiMG
         yZTkbKjqyFDZs0rT4bWzje2ciWsAf54mtaSPhOdrh2w4Ysrh0QqZReAqIjM80264fHNg
         4TOU24ANgdNdZZIwbrLjEOOz1wTBfx6rkPqvMH4yueNW2rJqXjQbKkpxaPcgABbMD1nA
         MaScBge5g7ivueB4HhUULrgl7Jt4U+fGpI1T0290qCoqL9bGLnxXxYZ9O+jKPn8yvpYd
         wpAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JEIZptMsP3i/FDZXmToB0D7fOEQgkvKbzTSUeuV9O1Y=;
        b=r2KfgkQjTYx+DCwJWaqvXxpsasp+WZxwHSjtnoaSL/Kb5tMhlZgzqkRdtJiO3noCw2
         s9641jGDZ/xvVI74gOjUQGD4iEyI8PbwWmqi8Woz74nws1DmVWGcDkwn4ao5GKVYhQa9
         ShkPCt+YHhE3+b4I3KxV8knpn1N3Os1YPw7DFe3+0Gi0+qR1tWL/uHu7OUcmKhZ5U2qi
         5FPzxMs1bNg7Uv3arKgoGiEPa40ou+mIC/clwRvCLmj/u8yIeu2meFDRdwYepYnPmkwr
         y2b9fBH+gYANH/leJGKIIMGn/Va/xTqEJTpyFvK62qDCQadZ4Kh/qbxUfom69VFRyKwp
         pOkA==
X-Gm-Message-State: AOAM532cipbSWrHRIhttEOX/wRarNIMgQF4AQgUVnQECPLE6OkFujPRT
        l8vLcole7jHtop4XCJU871G2Xg==
X-Google-Smtp-Source: ABdhPJzWQ7eeH5wqvejog5qT6BbRQpLpPxU1h9TYVtH3rd4WIlicnIHiisiy3i49Hqjli5Q1AFXvtQ==
X-Received: by 2002:a05:6a00:44:b029:19d:e250:1355 with SMTP id i4-20020a056a000044b029019de2501355mr8032026pfk.36.1610639216224;
        Thu, 14 Jan 2021 07:46:56 -0800 (PST)
Received: from localhost ([45.137.216.7])
        by smtp.gmail.com with ESMTPSA id a20sm5368020pfi.111.2021.01.14.07.46.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jan 2021 07:46:55 -0800 (PST)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Joe Mario <jmario@redhat.com>, David Ahern <dsahern@gmail.com>,
        Don Zickus <dzickus@redhat.com>, Joe Perches <joe@perches.com>,
        linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v4 1/6] perf c2c: Rename for shared cache line stats
Date:   Thu, 14 Jan 2021 23:46:41 +0800
Message-Id: <20210114154646.209024-2-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210114154646.209024-1-leo.yan@linaro.org>
References: <20210114154646.209024-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For shared cache line statistics, it relies on HITM.  We can use more
general naming rather than only binding to HITM, so replace "hitm_stats"
with "shared_clines_stats" in structure perf_c2c, and rename function
resort_hitm_cb() to resort_shared_cl_cb().

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Acked-by: Jiri Olsa <jolsa@redhat.com>
---
 tools/perf/builtin-c2c.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index c5babeaa3b38..2d0c71300dbf 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -97,8 +97,8 @@ struct perf_c2c {
 	bool			 symbol_full;
 	bool			 stitch_lbr;
 
-	/* HITM shared clines stats */
-	struct c2c_stats	hitm_stats;
+	/* Shared cache line stats */
+	struct c2c_stats	shared_clines_stats;
 	int			shared_clines;
 
 	int			 display;
@@ -1961,7 +1961,7 @@ static int resort_cl_cb(struct hist_entry *he, void *arg __maybe_unused)
 {
 	struct c2c_hist_entry *c2c_he;
 	struct c2c_hists *c2c_hists;
-	bool display = he__display(he, &c2c.hitm_stats);
+	bool display = he__display(he, &c2c.shared_clines_stats);
 
 	c2c_he = container_of(he, struct c2c_hist_entry, he);
 	c2c_hists = c2c_he->hists;
@@ -2048,14 +2048,14 @@ static int setup_nodes(struct perf_session *session)
 
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
@@ -2126,7 +2126,7 @@ static void print_c2c__display_stats(FILE *out)
 
 static void print_shared_cacheline_info(FILE *out)
 {
-	struct c2c_stats *stats = &c2c.hitm_stats;
+	struct c2c_stats *stats = &c2c.shared_clines_stats;
 	int hitm_cnt = stats->lcl_hitm + stats->rmt_hitm;
 
 	fprintf(out, "=================================================\n");
@@ -2827,7 +2827,7 @@ static int perf_c2c__report(int argc, const char **argv)
 	ui_progress__init(&prog, c2c.hists.hists.nr_entries, "Sorting...");
 
 	hists__collapse_resort(&c2c.hists.hists, NULL);
-	hists__output_resort_cb(&c2c.hists.hists, &prog, resort_hitm_cb);
+	hists__output_resort_cb(&c2c.hists.hists, &prog, resort_shared_cl_cb);
 	hists__iterate_cb(&c2c.hists.hists, resort_cl_cb);
 
 	ui_progress__finish();
-- 
2.25.1

