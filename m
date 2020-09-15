Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07F33269C76
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 05:19:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726197AbgIODTt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 23:19:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726196AbgIODTD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 23:19:03 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4BEEC06178A
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 20:19:02 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id u3so1008814pjr.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 20:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Bqc2nFfVQoyA+fxwcch9VdXdA8Cn9R6fIwtpNpLjHv0=;
        b=feJYzK4l0Du/NGZ13gYF7OWIpRFcFlxf+jaRvXSAwVOe7hjEw6k1b2Z4r65QNf+r/Z
         6oGhE2IX6OWysBGr00MOEvsqR+syyPNfihbPcYoSSH/AgRPtJzmlHYiq+AUEbqOyxZ4j
         8Ij9DWjc4A1Vpb6s0V9CbV3dbK0oipps9V8qp4ohYwv44VjDqdmMlq2YGlJRClI3d5OW
         RjAYKzWRDHJpDAI2ba3YQPcGAmFZulAdB0FJxveO4je7YxE6lYh67KU5ajelQBURigEE
         3dZ7wBHuskZrLegFXvKlkilMzSQqo4AfGGPY2SuP9HATJUYq9ZqGKsIjXzai0bov7R6F
         8fVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=Bqc2nFfVQoyA+fxwcch9VdXdA8Cn9R6fIwtpNpLjHv0=;
        b=XqhKyGGXlzxb9j1/wlhwH7CJhovwSqxBGVdrLDF0Dk9ot4K+v00d5WtA74LX2JaEzL
         fi2RmJlIhWx3rniFgTLydgTvqBYDg/qyzd9YuHwWCGjz4wRF70IBw6TUdXRtALyzOtpF
         txSPllwBWsesKsCBwqwrf426g2/JV3U5Odp41O3qu5H+d34TJKBrJIzdk704uyENSEMo
         9KKpTrfYD4VEecCyJgKNXuqzRHr7U1HE39Yulj+zgbNnyFFi+LvRXKNqGrzLrTDm4NT4
         /e3cFlMvvPglqPzRHkgZ/QR1vjaXM7V7WjbHz9pOwGixSLFUQF+vjkbz9Dbjdj/AQaoo
         vx4A==
X-Gm-Message-State: AOAM533k02j8NetWeUtP3yimCM6+04FB+FDStxXdx2Zeog20oLy9+iMf
        3rM/UVmbEVy0GfyM8bq67lY=
X-Google-Smtp-Source: ABdhPJxVsMwvnNr7dtKQLw67SGl7B0gdLLHYV466neeQof8yNvVqVn3auZSM9lj9oFZg1zimJOjPdQ==
X-Received: by 2002:a17:902:6b4c:: with SMTP id g12mr17408754plt.39.1600139942189;
        Mon, 14 Sep 2020 20:19:02 -0700 (PDT)
Received: from balhae.roam.corp.google.com ([101.235.31.111])
        by smtp.gmail.com with ESMTPSA id a24sm10584582pju.25.2020.09.14.20.18.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 20:19:01 -0700 (PDT)
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>
Subject: [PATCH 09/11] perf metric: Do not free metric when failed to resolve
Date:   Tue, 15 Sep 2020 12:18:17 +0900
Message-Id: <20200915031819.386559-10-namhyung@kernel.org>
X-Mailer: git-send-email 2.28.0.618.gf4bc123cb7-goog
In-Reply-To: <20200915031819.386559-1-namhyung@kernel.org>
References: <20200915031819.386559-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's dangerous to free the original metric when it's called from
resolve_metric() as it's already in the metric_list and might have
other resources too.  Instead, it'd better let them bail out and be
released properly at the later stage.

So add a check when it's called from metricgroup__add_metric() and
release it.  Also make sure that mp is set properly.

Acked-by: Jiri Olsa <jolsa@redhat.com>
Fixes: 83de0b7d535de ("perf metric: Collect referenced metrics in struct metric_ref_node")
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/metricgroup.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 35bcaa8d11e9..941702cb6a79 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -673,7 +673,6 @@ static int __add_metric(struct list_head *metric_list,
 		m->has_constraint = metric_no_group || metricgroup__has_constraint(pe);
 		INIT_LIST_HEAD(&m->metric_refs);
 		m->metric_refs_cnt = 0;
-		*mp = m;
 
 		parent = expr_ids__alloc(ids);
 		if (!parent) {
@@ -686,6 +685,7 @@ static int __add_metric(struct list_head *metric_list,
 			free(m);
 			return -ENOMEM;
 		}
+		*mp = m;
 	} else {
 		/*
 		 * We got here for the referenced metric, via the
@@ -720,8 +720,11 @@ static int __add_metric(struct list_head *metric_list,
 	 * all the metric's IDs and add it to the parent context.
 	 */
 	if (expr__find_other(pe->metric_expr, NULL, &m->pctx, runtime) < 0) {
-		expr__ctx_clear(&m->pctx);
-		free(m);
+		if (m->metric_refs_cnt == 0) {
+			expr__ctx_clear(&m->pctx);
+			free(m);
+			*mp = NULL;
+		}
 		return -EINVAL;
 	}
 
-- 
2.28.0.618.gf4bc123cb7-goog

