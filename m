Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9EA227CF91
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 15:42:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730109AbgI2Nli (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 09:41:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730581AbgI2NlA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 09:41:00 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95528C061755
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 06:40:59 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id j2so5450170wrx.7
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 06:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rSBmGfFXyqHTgpUW8IIhJlAorkVQuHPYCj5XL7q0e2k=;
        b=NI3qmyxBT9dzQH3qwqP3zsPTjbwVAYcAGpmN9mxrLKmMLZooTK8hEBFNP7vsvOY7mC
         rAKyk5SyaNtN1vtU4S3MhNhvyitGtZj1LZaePZDytFz6d7qG60KK2p6J+djMIrj4AmmJ
         XKKCHTVlmGm9FY+fTYoBINJO0eZUjMnnb6bhbR9HOyhMxwlbiVBiVjh1HJKuINgvpvds
         Nbhj6/Cww3mn1VlMXChJ9jEfGdxEl/bqBBjeSMOj8JA2qSs5R7BpFZSwNu/pBYbwIp1P
         fm8BCu7UeMRJ7gdLZG6XaOTSLCUcOtFscq5wI8uirAjQSWjT86ZthOIZ9yzEoTs7Tovx
         brGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rSBmGfFXyqHTgpUW8IIhJlAorkVQuHPYCj5XL7q0e2k=;
        b=tPNlz7xU1DuYsYqvRmhsrkZFF3PliX6fc+wCEAjinvFu7pub8bwgjJFArxqaQfpS8R
         HTjP8bjQd6GwYI+MvzXoljX+NRYr2SI7aFXTmqSwENxSTDjDqSPSuLVXHxN7TyoK8J3j
         mQFaqeS1abejt8DrvgCbaMgVZSaXnI66mgxeubDeGZcZl4YS8ohHqpQwXE8BL9jm4ZQr
         g1l3eUrMv9L6guI9T6IGLbq7MiDkl7Y6rji9BBHvsvOs8FRlpkx1k7lb2gvHZxjxnQKF
         hEYuH1KFoOoMGTgBymCXqbtgS2tYwW5PEbOTFZfoHvSrgsYxXFh2sBnakdUmF0ZByxqg
         FQ6Q==
X-Gm-Message-State: AOAM533diqSW2ne6ZnSZfKQwCVWciszFxzB5ngRIXprvk03iXnjnz3Dk
        DhGrJ8CyHTtzpsx6uoYwxcPq2QvM/q0sK248
X-Google-Smtp-Source: ABdhPJztkYBBZ5Cb7KPeJPkCU9svNf1ynfCqJ8E6ZzP1xnTzOvG6jbziGBXR68ZiqoqJsy0NJ91cWw==
X-Received: by 2002:adf:f504:: with SMTP id q4mr4370130wro.353.1601386858165;
        Tue, 29 Sep 2020 06:40:58 -0700 (PDT)
Received: from hackbox2.linaro.org ([81.128.185.34])
        by smtp.gmail.com with ESMTPSA id q15sm5955314wrr.8.2020.09.29.06.40.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2020 06:40:57 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Wei Li <liwei391@huawei.com>,
        James Clark <james.clark@arm.com>,
        Andre Przywara <andre.przywara@arm.com>,
        Dave Martin <Dave.Martin@arm.com>,
        linux-kernel@vger.kernel.org, Al Grant <Al.Grant@arm.com>
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v2 09/14] perf arm-spe: Refactor counter packet handling
Date:   Tue, 29 Sep 2020 14:39:12 +0100
Message-Id: <20200929133917.9224-10-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200929133917.9224-1-leo.yan@linaro.org>
References: <20200929133917.9224-1-leo.yan@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch defines macros for counter packet header, and uses macro to
replace hard code values for packet parsing.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 .../util/arm-spe-decoder/arm-spe-pkt-decoder.c  | 17 ++++++++++-------
 .../util/arm-spe-decoder/arm-spe-pkt-decoder.h  |  9 +++++++++
 2 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
index 00a2cd1af422..ed0f4c74dfc5 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
@@ -150,10 +150,13 @@ static int arm_spe_get_counter(const unsigned char *buf, size_t len,
 			       const unsigned char ext_hdr, struct arm_spe_pkt *packet)
 {
 	packet->type = ARM_SPE_COUNTER;
-	if (ext_hdr)
-		packet->index = ((buf[0] & 0x3) << 3) | (buf[1] & 0x7);
-	else
-		packet->index = buf[0] & 0x7;
+	if (ext_hdr) {
+		packet->index  = (buf[1] & SPE_CNT_PKT_HDR_INDEX_MASK);
+		packet->index |= ((buf[0] & SPE_CNT_PKT_HDR_EXT_INDEX_MASK)
+			<< SPE_CNT_PKT_HDR_EXT_INDEX_SHIFT);
+	} else {
+		packet->index = buf[0] & SPE_CNT_PKT_HDR_INDEX_MASK;
+	}
 
 	return arm_spe_get_payload(buf, len, ext_hdr, packet);
 }
@@ -431,17 +434,17 @@ int arm_spe_pkt_desc(const struct arm_spe_pkt *packet, char *buf,
 			return ret;
 
 		switch (idx) {
-		case 0:
+		case SPE_CNT_PKT_HDR_INDEX_TOTAL_LAT:
 			ret = arm_spe_pkt_snprintf(&buf, &blen, "TOT");
 			if (ret < 0)
 				return ret;
 			break;
-		case 1:
+		case SPE_CNT_PKT_HDR_INDEX_ISSUE_LAT:
 			ret = arm_spe_pkt_snprintf(&buf, &blen, "ISSUE");
 			if (ret < 0)
 				return ret;
 			break;
-		case 2:
+		case SPE_CNT_PKT_HDR_INDEX_TRANS_LAT:
 			ret = arm_spe_pkt_snprintf(&buf, &blen, "XLAT");
 			if (ret < 0)
 				return ret;
diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
index 62db4ff91832..18667a63f5ba 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
@@ -89,6 +89,15 @@ struct arm_spe_pkt {
 /* Context packet header */
 #define SPE_CTX_PKT_HDR_INDEX_MASK		GENMASK_ULL(1, 0)
 
+/* Counter packet header */
+#define SPE_CNT_PKT_HDR_INDEX_MASK		GENMASK_ULL(2, 0)
+#define SPE_CNT_PKT_HDR_INDEX_TOTAL_LAT		(0x0)
+#define SPE_CNT_PKT_HDR_INDEX_ISSUE_LAT		(0x1)
+#define SPE_CNT_PKT_HDR_INDEX_TRANS_LAT		(0x2)
+
+#define SPE_CNT_PKT_HDR_EXT_INDEX_MASK		GENMASK_ULL(1, 0)
+#define SPE_CNT_PKT_HDR_EXT_INDEX_SHIFT		(3)
+
 const char *arm_spe_pkt_name(enum arm_spe_pkt_type);
 
 int arm_spe_get_packet(const unsigned char *buf, size_t len,
-- 
2.20.1

