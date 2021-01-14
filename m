Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 032C52F597A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 04:42:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727558AbhANDkq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 22:40:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727402AbhANDkl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 22:40:41 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0562C061795
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 19:40:01 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id c12so2552013pfo.10
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 19:40:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XE4Wn1yojgiJ3G0EJaKiSzR/qHIt+d7uSF/Poy1aiqo=;
        b=fLVewdU28r3KFQZyWGflIxLcGGV1ifFk3pPkfb+fWLl4IpzI8eFgQwJVe/31qFkWgh
         xp7TKo2/PLfzQqJ3o5BqePWx8DwE0teKaMHS6IUI1OYZQgHkfCq/6rEqVU/O7hCfnwWL
         HC41gnsLcrN1GvdDJwLfEznGWeEMkO7VBXFH3Q9123wrNSBAWCypbFwzE728lPW/NS9H
         NKEyWKiHocj1Lipx8hMCK/cg9weRFNHMDrJlP/0KIVinOYk5EtASoxmCGeM2DDPTPbYz
         b6g1Xn0QJTZuaZDCBl5983EpyfDB6NRtamBHKNNA0dU+UE+ddN+DLFMqOyFFFXDSfNpz
         9brQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XE4Wn1yojgiJ3G0EJaKiSzR/qHIt+d7uSF/Poy1aiqo=;
        b=tAwf3OsNbe8sc0qhKUJEYss4EiVa4xAwWXEX6I5UkyXpWNq7u86aa8K6ULHgcz7W6g
         bovArDrcNCpiNZxrFidY4+UfI5g/vJ5T2eLDzqNtyZHcJ4czqJd3N5R7tEQ4RTVBGRvl
         q+Mid3VNy6lfwJmgvEAK7Ych8Da7E3RmJnO6Ab/aZXwsQtsalVxSeVI5C7yMU26l5ybi
         jnwxQlSVmgSdSA7MYPt1osCYH3Rqwao2KnjJn0/eiCrAz7iKStBvQzbAW7DtPRQwOlHJ
         G2Hr8foKU7xVuWm/W4iz9rEmt6GlgsCKwoIZFIWiqYpB1NrBoLtSQsvquyswCgvCmK7G
         tpgQ==
X-Gm-Message-State: AOAM532x7dD7jz64nXUvcQlHezrpEATgF5gVpHohRHE5aB/w/4Kf6tWB
        cznov6paKAm3uYzPZJHUUacHgA==
X-Google-Smtp-Source: ABdhPJyVlPOADfX1A6Rd2tALX2aEBK2TgUIjMxwLV4zoP8+M602kjGPQz3tyfO0BIBseZYW6eEgOjA==
X-Received: by 2002:aa7:9848:0:b029:19d:c24b:1179 with SMTP id n8-20020aa798480000b029019dc24b1179mr5401843pfq.29.1610595601309;
        Wed, 13 Jan 2021 19:40:01 -0800 (PST)
Received: from localhost ([45.137.216.7])
        by smtp.gmail.com with ESMTPSA id z12sm3831312pfn.186.2021.01.13.19.40.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 19:40:00 -0800 (PST)
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
Subject: [PATCH v3 2/5] perf c2c: Refactor hist entry validation
Date:   Thu, 14 Jan 2021 11:39:36 +0800
Message-Id: <20210114033939.164538-3-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210114033939.164538-1-leo.yan@linaro.org>
References: <20210114033939.164538-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch has no any functionality changes but refactors hist entry
validation for cache line resorting.

It renames function "valid_hitm_or_store()" to "is_valid_hist_entry()",
changes return type from integer type to bool type.  In the function,
it uses switch-case instead of ternary operators, which is easier
to extend for more display types.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Acked-by: Jiri Olsa <jolsa@redhat.com>
---
 tools/perf/builtin-c2c.c | 30 +++++++++++++++++++++++-------
 1 file changed, 23 insertions(+), 7 deletions(-)

diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index 2d0c71300dbf..bc2ee84298ff 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -1888,16 +1888,32 @@ static bool he__display(struct hist_entry *he, struct c2c_stats *stats)
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
@@ -1951,7 +1967,7 @@ static int filter_cb(struct hist_entry *he, void *arg __maybe_unused)
 
 	calc_width(c2c_he);
 
-	if (!valid_hitm_or_store(he))
+	if (!is_valid_hist_entry(he))
 		he->filtered = HIST_FILTER__C2C;
 
 	return 0;
-- 
2.25.1

