Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA15929614C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 16:59:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S368396AbgJVO6w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 10:58:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S368372AbgJVO6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 10:58:46 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6960C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 07:58:45 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id h7so2843701wre.4
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 07:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8zX73B3PanB6PqEhgBDdzqancmA244z8GgTkYePfaug=;
        b=FloKQ87PAiXA3YS6BILgyJTlXEHA2XK82JmIcv1TvlBFzPCvbKVh0L6/rwO3cKNFme
         +5bpEc5rkTzPKw27vHeaBPcDTahjDLRvupkZTVuPcJgKXpug7d+0tFbgxISkiSXIDxc2
         VE7mfavsQIZ/dPuJKauTMsCftjzRdlT20K2RHr0UWPvDW0jq5eSc8OqW9Q6ABL2bm7FH
         G3Nuo7M3HdRT7ctQHWinXXw2dXuvs6tpSIuufBEN3xS0ukPWEoc0S+ONF2+PEk2tCxwM
         WIyQfSpKcBZxWjFqnhWci5tNhrJWZi5/UJolVnbTzivn0/rb8nJGC8BeuqSpv2wz48h6
         337Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8zX73B3PanB6PqEhgBDdzqancmA244z8GgTkYePfaug=;
        b=TaTzjIYwRm6ijUA6wJMjEKGTfdYR2R+yb+gAi9i7dl0zBhWxrlU5eof2VY3eKv4+58
         vxOp+fJzdgAuMIZ/S17qeAHpBDgKp9nehhHkddAjJ755FpICKHqUDcV2lEOewsltjmTf
         emQDb+yhQLQKVTVIm120OUaKoe5X3Pz8djOW8XuiySuo5wXhJ+ILs2VIbjgDFlTvi3Xe
         GRIJBIXM+i+mY6cjFqSh1E2ljziH54gKwBC7WuhViboPtNIB3Kh4q8dlO0xIyn6qTWDN
         TDNhZdr0p5W9mai0ZOomx7BJUhHjvE9k3AH2znNqmmhpDqylhIVB5hTSUlGrS1HiLNoJ
         ZKkg==
X-Gm-Message-State: AOAM530OmeCtRo5wRxrfeodLfm9Yrj184kMVaBDd/rwBWYYfwWexHU89
        x2lU1JH271T0wX3K1J1UVbvC0Q==
X-Google-Smtp-Source: ABdhPJxRxLZqDjxOAFvBlWzpWThj8TLPcw0AQoXEEzScWx7Go3hnCha2j4alVv72Y0l7NupjKY7B4w==
X-Received: by 2002:adf:bacc:: with SMTP id w12mr3392575wrg.66.1603378724490;
        Thu, 22 Oct 2020 07:58:44 -0700 (PDT)
Received: from hackbox2.linaro.org ([81.128.185.34])
        by smtp.gmail.com with ESMTPSA id 130sm4348021wmd.18.2020.10.22.07.58.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2020 07:58:43 -0700 (PDT)
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
        Al Grant <Al.Grant@arm.com>, Dave Martin <Dave.Martin@arm.com>,
        linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v3 12/20] perf arm-spe: Refactor counter packet handling
Date:   Thu, 22 Oct 2020 15:58:08 +0100
Message-Id: <20201022145816.14069-13-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201022145816.14069-1-leo.yan@linaro.org>
References: <20201022145816.14069-1-leo.yan@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch defines macros for counter packet header, and uses macros to
replace hard code values in functions arm_spe_get_counter() and
arm_spe_pkt_desc().

In the function arm_spe_get_counter(), adds a new line for more
readable.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c | 11 ++++++-----
 tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h |  8 ++++++++
 2 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
index 023bcc9be3cc..6eebd30f3d78 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
@@ -152,10 +152,11 @@ static int arm_spe_get_counter(const unsigned char *buf, size_t len,
 			       const unsigned char ext_hdr, struct arm_spe_pkt *packet)
 {
 	packet->type = ARM_SPE_COUNTER;
+
 	if (ext_hdr)
-		packet->index = ((buf[0] & 0x3) << 3) | (buf[1] & 0x7);
+		packet->index = SPE_CNT_PKT_HDR_EXTENDED_INDEX(buf[0], buf[1]);
 	else
-		packet->index = buf[0] & 0x7;
+		packet->index = SPE_CNT_PKT_HDR_SHORT_INDEX(buf[0]);
 
 	return arm_spe_get_payload(buf, len, ext_hdr, packet);
 }
@@ -307,17 +308,17 @@ static int arm_spe_pkt_desc_counter(const struct arm_spe_pkt *packet,
 		return ret;
 
 	switch (packet->index) {
-	case 0:
+	case SPE_CNT_PKT_HDR_INDEX_TOTAL_LAT:
 		ret = arm_spe_pkt_snprintf(&buf, &blen, "TOT");
 		if (ret < 0)
 			return ret;
 		break;
-	case 1:
+	case SPE_CNT_PKT_HDR_INDEX_ISSUE_LAT:
 		ret = arm_spe_pkt_snprintf(&buf, &blen, "ISSUE");
 		if (ret < 0)
 			return ret;
 		break;
-	case 2:
+	case SPE_CNT_PKT_HDR_INDEX_TRANS_LAT:
 		ret = arm_spe_pkt_snprintf(&buf, &blen, "XLAT");
 		if (ret < 0)
 			return ret;
diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
index 8808f2d0b6e4..8a291f451ef8 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
@@ -84,6 +84,14 @@ struct arm_spe_pkt {
 /* Context packet header */
 #define SPE_CTX_PKT_HDR_INDEX(h)		((h) & GENMASK_ULL(1, 0))
 
+/* Counter packet header */
+#define SPE_CNT_PKT_HDR_SHORT_INDEX(h)		((h) & GENMASK_ULL(2, 0))
+#define SPE_CNT_PKT_HDR_EXTENDED_INDEX(h0, h1)	(((h0) & GENMASK_ULL(1, 0)) << 3 | \
+						 SPE_ADDR_PKT_HDR_SHORT_INDEX(h1))
+#define SPE_CNT_PKT_HDR_INDEX_TOTAL_LAT		0x0
+#define SPE_CNT_PKT_HDR_INDEX_ISSUE_LAT		0x1
+#define SPE_CNT_PKT_HDR_INDEX_TRANS_LAT		0x2
+
 const char *arm_spe_pkt_name(enum arm_spe_pkt_type);
 
 int arm_spe_get_packet(const unsigned char *buf, size_t len,
-- 
2.17.1

