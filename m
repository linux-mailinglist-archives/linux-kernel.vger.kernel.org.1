Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4300228F53F
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 16:51:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389309AbgJOOvX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 10:51:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389034AbgJOOvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 10:51:09 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A548C061755
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 07:51:09 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id e17so3802291wru.12
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 07:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6xBdrHy1LL/3Y4JacfVYIbVFRHuR3SpJExsOTG9b1Ak=;
        b=q64p8iZD1HFpthSkqalxb+dULeQ7lXJNj96/EAj0it741uIbBeZ3Nc8k6Bt4MQGRpY
         KghsLBd+hEueKePhCu4tnShYuMAgH9Jc9BQNl8uWCu1Q5JQIQdKqcGWyeUCx8qJMcBOZ
         a8aj24pu/L78qVsWzvmGRQ9QPuwEgmadcYDn6yaxLYcnGi0YPwuzhVpb5WyFrHhmpifK
         NwePufIY00ZpgTZYH8B5RS/Kql4rSgFlrL3VE2L0W40BbFa6l83F/aYkscmNRNn/UhgZ
         vzWFoRz1UdcmBYpvgn1FEPTGfLBxQCBPmovSFYsEJ7hmTOF1r/UQc7PFWGNnhxq6wwyd
         DuPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6xBdrHy1LL/3Y4JacfVYIbVFRHuR3SpJExsOTG9b1Ak=;
        b=NcPVj1NzRtA+4a8QWEm5XNG9uCbWbcgBZZsAmKoTCIbJdxq5A6eIsCLWs/046lwDpH
         atDBWP42nW1XN9tQMxdI1msJXr97ZPD6/gdMFbwgyqA7y2aIaLMWA07Fl58jQDZoUFXk
         PHTxdRwyP8JZGmGVhMuO15vVXdPor9N2CFHZiOcZP5jCbqbdwOOxtOMItVce7K2O11vV
         k9nMrVE4emkBCw3HFG8N9FbJBcnCLli+p0+At22Ua7n9f+ohVqLqBlLBMJ/kBHRML/3c
         dKIQ4WjywCiaiKEZSp6yQG40KnOn5HLuaPXfo2tJEF8YX7asQSh4kTmpAG5M7qvm3GHR
         N3vA==
X-Gm-Message-State: AOAM531i2xRM2z4GolxM813ScCjLR4ILB4HyWgaK0IpnBcEk0buMx979
        tWlAL/+zvfCLHPaUZfjuXiW7Lw==
X-Google-Smtp-Source: ABdhPJytiB8PcMozrJ5b71Kt0tkddlKcgpoSrbriO5CWg13eg5+yYXWxDk7Mn/NJAVVs/WxtaDMVbg==
X-Received: by 2002:adf:bacc:: with SMTP id w12mr5176748wrg.66.1602773467689;
        Thu, 15 Oct 2020 07:51:07 -0700 (PDT)
Received: from hackbox2.linaro.org ([81.128.185.34])
        by smtp.gmail.com with ESMTPSA id x65sm5144733wmg.1.2020.10.15.07.51.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2020 07:51:07 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>, Joe Mario <jmario@redhat.com>,
        David Ahern <dsahern@gmail.com>,
        Don Zickus <dzickus@redhat.com>, Al Grant <Al.Grant@arm.com>,
        James Clark <james.clark@arm.com>, linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v1 5/8] perf c2c: Rename for shared cache line stats
Date:   Thu, 15 Oct 2020 15:50:38 +0100
Message-Id: <20201015145041.10953-6-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201015145041.10953-1-leo.yan@linaro.org>
References: <20201015145041.10953-1-leo.yan@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the structure perf_c2c for shared cache line stats, replace
"hitm_stats" with "shared_clines_stats", and rename function
resort_hitm_cb() to resort_shared_cl_cb().

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/builtin-c2c.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index 59f141adea3e..7962cc70b855 100644
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
@@ -2084,7 +2084,7 @@ static int resort_cl_cb(struct hist_entry *he, void *arg __maybe_unused)
 {
 	struct c2c_hist_entry *c2c_he;
 	struct c2c_hists *c2c_hists;
-	bool display = he__display(he, &c2c.hitm_stats);
+	bool display = he__display(he, &c2c.shared_clines_stats);
 
 	c2c_he = container_of(he, struct c2c_hist_entry, he);
 	c2c_hists = c2c_he->hists;
@@ -2171,14 +2171,14 @@ static int setup_nodes(struct perf_session *session)
 
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
@@ -2249,7 +2249,7 @@ static void print_c2c__display_stats(FILE *out)
 
 static void print_shared_cacheline_info(FILE *out)
 {
-	struct c2c_stats *stats = &c2c.hitm_stats;
+	struct c2c_stats *stats = &c2c.shared_clines_stats;
 	int hitm_cnt = stats->lcl_hitm + stats->rmt_hitm;
 
 	fprintf(out, "=================================================\n");
@@ -2942,7 +2942,7 @@ static int perf_c2c__report(int argc, const char **argv)
 	ui_progress__init(&prog, c2c.hists.hists.nr_entries, "Sorting...");
 
 	hists__collapse_resort(&c2c.hists.hists, NULL);
-	hists__output_resort_cb(&c2c.hists.hists, &prog, resort_hitm_cb);
+	hists__output_resort_cb(&c2c.hists.hists, &prog, resort_shared_cl_cb);
 	hists__iterate_cb(&c2c.hists.hists, resort_cl_cb);
 
 	ui_progress__finish();
-- 
2.17.1

