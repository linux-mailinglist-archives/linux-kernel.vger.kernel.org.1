Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 513E32F650E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 16:51:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729153AbhANPrl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 10:47:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725957AbhANPrk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 10:47:40 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F16BC0613C1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 07:47:00 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id g15so4021632pgu.9
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 07:47:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XE4Wn1yojgiJ3G0EJaKiSzR/qHIt+d7uSF/Poy1aiqo=;
        b=y0qRdY3txKu/DjmUPE53HjiLgv5SMzPf5d0dWdVSI1Cp1BYmduNLQO4II5Lgh5OrCZ
         SGR5zs4pM1iPEokHIcHXMbnBDMDUFrM5cK12VX08msuNphNaSRunJKMjj+AEIWV5JM2n
         o0LETmggRBEB2fgBO5mfxkTj7o+LCOiI+jLKOOYhyZv6908OgsSSWD+E7mutrpM/QLP8
         3mJG0507lnayP7RzJ9je/JbMGX4SQ0EQisdpmv93uHo55CiVk9o/h6YKPB8HolVnOSsj
         sCGQtB4oRtYRQzkYiPVhekvuIVQw2QDdWncow+Bzx2eK5gOyeo+q2/W7rsaajQQ+hW1b
         Qiyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XE4Wn1yojgiJ3G0EJaKiSzR/qHIt+d7uSF/Poy1aiqo=;
        b=qX557ZPHXXns75GGpl+S7NerZtfQCAe1/ZaMWyw6MU5xo1meLAayRkGCSs98DsD4Um
         W6FYSDzHnLYQ4nl1s7tKXbVkzm2kOzD+SnotKC5wuhKHQm0HGf6tq0fpg1xZYbbpp70I
         nYjYGzD7zvEuEj+2N0V/3iFi9ygCVL98+bMJOsguyP2UmXfame5zIYckChgH7W2416fZ
         ZfqnoV6HUPsIUg9bUFMIcjopixVAPOBc2UM69IpfaQvv9yx+sZolMiu8/6ZkeI9Y8alf
         aHHfH46EFi/Q6V7CUFUcRP0OJP8Xo/80gf+y3M1uTEW/ZuygI05oRHC66epI8JALAQsH
         ANNw==
X-Gm-Message-State: AOAM532Q3MLPhOV1wYH6+fl+l0dP21ZbbMcwdiSom0b2IIzsPDXsafY+
        lZ7Uvg2fj4wTBnczCFKnObOE4A==
X-Google-Smtp-Source: ABdhPJwcK/8Rz8LbwFXNwoYB7CdCvqarHtWkzzYGAoPsMqXX5J72XpKUNYS2LfPSb3xzNG+NWe8wjw==
X-Received: by 2002:aa7:93c3:0:b029:19d:e081:9751 with SMTP id y3-20020aa793c30000b029019de0819751mr7889206pff.73.1610639219808;
        Thu, 14 Jan 2021 07:46:59 -0800 (PST)
Received: from localhost ([45.137.216.7])
        by smtp.gmail.com with ESMTPSA id b6sm5327853pfd.43.2021.01.14.07.46.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jan 2021 07:46:59 -0800 (PST)
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
Subject: [PATCH v4 2/6] perf c2c: Refactor hist entry validation
Date:   Thu, 14 Jan 2021 23:46:42 +0800
Message-Id: <20210114154646.209024-3-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210114154646.209024-1-leo.yan@linaro.org>
References: <20210114154646.209024-1-leo.yan@linaro.org>
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

