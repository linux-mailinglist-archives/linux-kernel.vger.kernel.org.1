Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72FB928F53D
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 16:51:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389388AbgJOOvS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 10:51:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389119AbgJOOvL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 10:51:11 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86D9BC0613D3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 07:51:10 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id e17so3802400wru.12
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 07:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7cicsW6Li2DqvBdneepFP2/mKSl/GNLOAR6RTpCOJCs=;
        b=uDW3hfYA61HwBotGREnzjHEJ/YDWly8W5WOOEzSgiWkZpVIbH4zamH6iDyr8ynhTU9
         vc69E/j0FAbT8fo+3AnpoHB+9La1gCGQ1HvTbrm+dPKntzfXTKwxQWt00SB+sGXqDpyO
         Vvb2JJz52ttYUGj496KpBi25f6yge0U2zIgiIfn9tfe2PKz2j9rRJjfQ4l7DLJk2h2nJ
         s8noNTxnKXDN4f3eNCFnw99CC0jFdGBf21gb0SxBbTJB2grsrmVl3yvTniEHPG9OMLFa
         9izWmXfF7RnjYK8JZR0WVGJn0mkc/cV/0+5LhzjcpjlI19YGKqYcJjSL4xdNVZrksRIC
         1R9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7cicsW6Li2DqvBdneepFP2/mKSl/GNLOAR6RTpCOJCs=;
        b=hT7zHTUoj4QHn1U6CSnbSMYzaN9K6NO3gYASzHK2oOhyNuL53RuSvVo1JtTmlL9Zc2
         khVLf4K7s9JG70mayjKqYWvYCxac9BmJfJ7buUnG4uAFQLu9C5JfubfYCIJfEf9/T50d
         9fYMdIF8/kRmFEfY0BTXrjU7zvfCh5BnyssXYFfBDeHwpUpyRjYDRkj9XWPhV7pwmgP3
         0V/ajk1RvTCWO9lOJsum3xOB8TLvIswNce1/TUjc31zhqEUyA0U4i0whAGdlDEVdvda8
         BOd0dmtaaOG32GtwIYQt/76Df//o7UdqtcJ5c+TnK6myIVPJOyRYRQlBS79smhIAOMsa
         Md5Q==
X-Gm-Message-State: AOAM531/QWqzg7RYEaLRhbvD0EME2QRRv/l/tehp2N3LsXAnuHB0Bv5n
        07879PJUyV1cHiYnmVAbLFWwqw==
X-Google-Smtp-Source: ABdhPJxsVlxEZ3hxB1PWjsAulBHpXPAbHgqMyRH1jWdiMf4zKdur0te7B5ghDguFbH0PKPHzhcPa1A==
X-Received: by 2002:a5d:6744:: with SMTP id l4mr4948264wrw.18.1602773469195;
        Thu, 15 Oct 2020 07:51:09 -0700 (PDT)
Received: from hackbox2.linaro.org ([81.128.185.34])
        by smtp.gmail.com with ESMTPSA id x65sm5144733wmg.1.2020.10.15.07.51.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2020 07:51:08 -0700 (PDT)
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
Subject: [PATCH v1 6/8] perf c2c: Refactor hist entry validation
Date:   Thu, 15 Oct 2020 15:50:39 +0100
Message-Id: <20201015145041.10953-7-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201015145041.10953-1-leo.yan@linaro.org>
References: <20201015145041.10953-1-leo.yan@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch has no any functionality change but only refactors hist entry
validation for cacheline resorting.

It renames function "valid_hitm_or_store()" to "is_valid_hist_entry()",
changes return type from integer type to bool type.  In the function,
it uses switch-case instead of ternary operators for better readability.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/builtin-c2c.c | 30 +++++++++++++++++++++++-------
 1 file changed, 23 insertions(+), 7 deletions(-)

diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index 7962cc70b855..d15a6220bfd0 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -2011,16 +2011,32 @@ static bool he__display(struct hist_entry *he, struct c2c_stats *stats)
 	return he->filtered == 0;
 }
 
-static inline int valid_hitm_or_store(struct hist_entry *he)
+static inline bool is_valid_hist_entry(struct hist_entry *he)
 {
 	struct c2c_hist_entry *c2c_he;
-	bool has_hitm;
+	bool has_record = false;
 
 	c2c_he = container_of(he, struct c2c_hist_entry, he);
-	has_hitm = c2c.display == DISPLAY_TOT ? c2c_he->stats.tot_hitm :
-		   c2c.display == DISPLAY_LCL ? c2c_he->stats.lcl_hitm :
-						c2c_he->stats.rmt_hitm;
-	return has_hitm || c2c_he->stats.store;
+
+	/* It's a valid entry if contains stores */
+	if (c2c_he->stats.store)
+		return true;
+
+	switch (c2c.display) {
+	case DISPLAY_LCL:
+		has_record = !!c2c_he->stats.lcl_hitm;
+		break;
+	case DISPLAY_RMT:
+		has_record = !!c2c_he->stats.rmt_hitm;
+		break;
+	case DISPLAY_TOT:
+		has_record = !!c2c_he->stats.tot_hitm;
+		break;
+	default:
+		break;
+	}
+
+	return has_record;
 }
 
 static void set_node_width(struct c2c_hist_entry *c2c_he, int len)
@@ -2074,7 +2090,7 @@ static int filter_cb(struct hist_entry *he, void *arg __maybe_unused)
 
 	calc_width(c2c_he);
 
-	if (!valid_hitm_or_store(he))
+	if (!is_valid_hist_entry(he))
 		he->filtered = HIST_FILTER__C2C;
 
 	return 0;
-- 
2.17.1

