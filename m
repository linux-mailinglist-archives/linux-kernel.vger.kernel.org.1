Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 813C02F5979
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 04:42:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727471AbhANDkk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 22:40:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727402AbhANDki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 22:40:38 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30120C061794
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 19:39:58 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id md11so2365347pjb.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 19:39:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JEIZptMsP3i/FDZXmToB0D7fOEQgkvKbzTSUeuV9O1Y=;
        b=xKSpiOXUuL2KYMPmvG+Y2ItraQlBgFse2u/vw0CAkBp9pnbyRd5mYgnVGU8XBDwsrz
         5cKGNDWDOSKz30JwwLfR8LTwGFxYdl+xx+BjRO8MYCjDzkTiCbat+P2HDlw2jHOrk7Wm
         +SZhtpGLBvooaR6SjfBmUHFWGKTUJ5tGrJ1jTa4yIFfFTpHIde3LaC34anr2jz+S3mcC
         9w8ofAP6O9ZRLz+dMM2IKyTEi9uNa1wtp6G0iwU/JKOdlcbj+96YS0x5K/Ft007wlOe7
         xhCjAeZ49LEXgoSyjYmULUe467+1YsUSZ+lNoFi13N130oebtCpBGoKNe2LiGYC72CDT
         4Ryg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JEIZptMsP3i/FDZXmToB0D7fOEQgkvKbzTSUeuV9O1Y=;
        b=PfYm0p/Aas67bACV9y4bKu7kNePnYaqkg16xg21szOcUhNcdwb4TI9Kt6Ou9m3DLtL
         TnYwJGgByMvcOGy3q85SlrjjXY3Ty+lY8osmnORxuF5NCpFCQj4exBWty2aXr7QvNIfG
         2+Rytmi2vfa+1xhPvz4MF+ckorVgIW2D/9JmgEGgH7e7W9/Uqt5K1P+VF/KJTPxX69Kn
         zfgyrY2xr+5EggCqEBvEAPWxHhMNQPBcn+sWzWIbG02gQKNlYQ7FJFqdN2QfpgV2F46k
         yuWDbDVfAuBOAD/W51VkfIv0iBRKF1C4kCVCBPe9EY3HztnVjDOuTKlhBZQvuVAfe9eC
         WPQg==
X-Gm-Message-State: AOAM530YStCwmSj/Yl6QZij/OtPZVOJgNWDPxlXp0tjpkQle7CFKKTK0
        iO6XwPsogNDOWWqmTAqbQRQsug==
X-Google-Smtp-Source: ABdhPJxXcP0Sp7uF9bd4qAk8+wFO537nAY81V3iIzT5qxF5cWToSZ3iVbYh2qNEN6EpenkHv7Yk2gA==
X-Received: by 2002:a17:90a:a608:: with SMTP id c8mr2741709pjq.61.1610595597729;
        Wed, 13 Jan 2021 19:39:57 -0800 (PST)
Received: from localhost ([45.137.216.7])
        by smtp.gmail.com with ESMTPSA id c62sm3769064pfa.116.2021.01.13.19.39.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 19:39:57 -0800 (PST)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Joe Mario <jmario@redhat.com>, David Ahern <dsahern@gmail.com>,
        Don Zickus <dzickus@redhat.com>, linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v3 1/5] perf c2c: Rename for shared cache line stats
Date:   Thu, 14 Jan 2021 11:39:35 +0800
Message-Id: <20210114033939.164538-2-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210114033939.164538-1-leo.yan@linaro.org>
References: <20210114033939.164538-1-leo.yan@linaro.org>
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

