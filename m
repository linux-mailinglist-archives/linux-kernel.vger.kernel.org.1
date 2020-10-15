Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 683AE28F53B
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 16:51:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389222AbgJOOvM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 10:51:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388978AbgJOOvH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 10:51:07 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8868DC061755
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 07:51:07 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id n18so3859711wrs.5
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 07:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8iySSeQQSoSQACUEns3BYHKSfuRoDPuTxYVJFLlAmS0=;
        b=fjVU7MQmtOceKdFNRa7M2CsKwg/Zq+0i07S8SjA67rkAlU1Kn11iQvxEEUJDU2LzCJ
         MaXksWt4tlacAkFeAJd+is1C4xMfXC52BWZi/5t8/whVBJreHpZ4Yf76DMTc6krBpzVE
         nbwKl5688iM2bBxcwJDnOfTaayqHWU8Rg3JUH2CYskDwmSE9MWVc4w6DwnTtDho4eZwS
         Y8l7lP8dzmGChN3p60N0Af4qLgVsxvDT+Jrim8vLHOKu21ZVqWW+CLmOm37QMB38Ciwr
         5rMhek+DZF81M9KHi1j6rU9DM0Ekj2W6ZU9sqkQGITNe/cyZdKHj5csEf+UZpgvrazAi
         QpPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8iySSeQQSoSQACUEns3BYHKSfuRoDPuTxYVJFLlAmS0=;
        b=PKg+TlO+TxLV6a9tu6iGkcXHMiVAF3Vic35WPOOejP4FDfxO0aWW2yuZYyVu4qAm6Q
         7dn5JsqWxu19vrZbyDmkMslj4EeYn0qz391Sre2luDL36koV53tbhv1pTwiV4h0v3qCl
         OYVgEEpS3fVS/ZSSsiN6WJ4nNLwvZiUlfIPATzZM9V+2jI5+WMTom3FynskctInuTccW
         fzJlF1tg637SMINe1bxo0uIpd/rpykpgQIhoDYK6Ueknr6j7dw4zzTz44wtem5n+JDQ8
         bI6XC2kzUuLDhsvhxf/bAOGHI14DNadYg8ZyDFRFkJrzCOsNSvcJMvMXJypUuRaOt5bg
         +cKg==
X-Gm-Message-State: AOAM531fTj7QgHyVLc6uXhrYHHVc6wkfqya8b5F/HYw8vvzIyMkfAJff
        npNGxoXppfbYZcRw+61BAeRoWQ==
X-Google-Smtp-Source: ABdhPJzApvSSeYJR+4bxpyE9cc50Wwt2s+w+z2lDZUNy1aMOUMsGO/y3bLjQWobwIO1dBDDiQOB4/w==
X-Received: by 2002:adf:8362:: with SMTP id 89mr5035318wrd.280.1602773466234;
        Thu, 15 Oct 2020 07:51:06 -0700 (PDT)
Received: from hackbox2.linaro.org ([81.128.185.34])
        by smtp.gmail.com with ESMTPSA id x65sm5144733wmg.1.2020.10.15.07.51.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2020 07:51:05 -0700 (PDT)
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
Subject: [PATCH v1 4/8] perf c2c: Change to general naming for macros
Date:   Thu, 15 Oct 2020 15:50:37 +0100
Message-Id: <20201015145041.10953-5-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201015145041.10953-1-leo.yan@linaro.org>
References: <20201015145041.10953-1-leo.yan@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The display and filter macros are named with suffix "_HITM", it is bound
to HITM metrics and isn't general if we want to sort cache lines with
other metrics (like LLC load hit) rather than HITM metrics.

This patch changes to use more general naming for macros:

  s/DISPLAY_HITM/DISPLAY_ENTRY
  s/FILTER_HITM/FILTER_ENTRY

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/builtin-c2c.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index 3f6271a779c4..59f141adea3e 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -1176,7 +1176,7 @@ node_entry(struct perf_hpp_fmt *fmt __maybe_unused, struct perf_hpp *hpp,
 			ret = scnprintf(hpp->buf, hpp->size, "%2d{%2d ", node, num);
 			advance_hpp(hpp, ret);
 
-		#define DISPLAY_HITM(__h)						\
+		#define DISPLAY_ENTRY(__h)						\
 			if (c2c_he->stats.__h> 0) {					\
 				ret = scnprintf(hpp->buf, hpp->size, "%5.1f%% ",	\
 						percent(stats->__h, c2c_he->stats.__h));\
@@ -1186,18 +1186,18 @@ node_entry(struct perf_hpp_fmt *fmt __maybe_unused, struct perf_hpp *hpp,
 
 			switch (c2c.display) {
 			case DISPLAY_RMT:
-				DISPLAY_HITM(rmt_hitm);
+				DISPLAY_ENTRY(rmt_hitm);
 				break;
 			case DISPLAY_LCL:
-				DISPLAY_HITM(lcl_hitm);
+				DISPLAY_ENTRY(lcl_hitm);
 				break;
 			case DISPLAY_TOT:
-				DISPLAY_HITM(tot_hitm);
+				DISPLAY_ENTRY(tot_hitm);
 			default:
 				break;
 			}
 
-		#undef DISPLAY_HITM
+		#undef DISPLAY_ENTRY
 
 			advance_hpp(hpp, ret);
 
@@ -1984,7 +1984,7 @@ static bool he__display(struct hist_entry *he, struct c2c_stats *stats)
 
 	c2c_he = container_of(he, struct c2c_hist_entry, he);
 
-#define FILTER_HITM(__h)						\
+#define FILTER_ENTRY(__h)						\
 	if (stats->__h) {						\
 		ld_dist = ((double)c2c_he->stats.__h / stats->__h);	\
 		if (ld_dist < DISPLAY_LINE_LIMIT)			\
@@ -1995,18 +1995,18 @@ static bool he__display(struct hist_entry *he, struct c2c_stats *stats)
 
 	switch (c2c.display) {
 	case DISPLAY_LCL:
-		FILTER_HITM(lcl_hitm);
+		FILTER_ENTRY(lcl_hitm);
 		break;
 	case DISPLAY_RMT:
-		FILTER_HITM(rmt_hitm);
+		FILTER_ENTRY(rmt_hitm);
 		break;
 	case DISPLAY_TOT:
-		FILTER_HITM(tot_hitm);
+		FILTER_ENTRY(tot_hitm);
 	default:
 		break;
 	}
 
-#undef FILTER_HITM
+#undef FILTER_ENTRY
 
 	return he->filtered == 0;
 }
-- 
2.17.1

