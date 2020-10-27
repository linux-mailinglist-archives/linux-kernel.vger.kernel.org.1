Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D76E29A303
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 04:11:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442551AbgJ0DLS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 23:11:18 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:41148 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2411710AbgJ0DLR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 23:11:17 -0400
Received: by mail-pl1-f196.google.com with SMTP id w11so14690pll.8
        for <linux-kernel@vger.kernel.org>; Mon, 26 Oct 2020 20:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=94uzetB6K3MwDY8Qzclg1gsV8Nv6nhE1TN87ymoe4wQ=;
        b=hHeQcMIuyYpneshK0xy4rmEGnS091bkZzIqznOjSuOgbKB2GagZlRPdbYuSF12aDDu
         FXYNMlNV3DIm3F5+43EcNqByN56dgodwMKta3HeqnOMrYtLQQ3KVrzcBxpy8hTyeJF6t
         q8GVnVqwziPW3ExhPkdbGGJVlP55R6Fo5ksCoFnoG4qFrS0naxdqcvNUEmvRyKpplmGS
         fe8UkpchJrybPahEWmsCPrS9BZSjos5od064Ey/9633aUqQShO6QAsDlomoJc3r2KiFA
         7ATG9KC1H5VR2w7L2caWpTD35poOftOQVMTOMm5auhApJB1vXrYtnWURFcfTvR5HkKxL
         lHcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=94uzetB6K3MwDY8Qzclg1gsV8Nv6nhE1TN87ymoe4wQ=;
        b=AOwS4srHLL1SO5yMy9ld4qRG4lMfHYlU6PgnLZ4wMpNSiJKjhaOlV4pTdwg0YLGVbm
         Otuv2VnC/x/bJJaoRZGG4VU/43WtWAovFoaVKwMmWL57Wxf9/V8Nv4qtN2iRYdOZnhe5
         ebZyAYJeB/X++17SJJmToncdT991mb/UpvMaXCqXGXEbpoax1pRGKiyMCEQull1d31lJ
         TpK6X5L1CvpyYd3C2Xf8OPNZhETfc1kj2xbHlwP6jXdflRGe4Eloy1UcUurVLPF5JjhE
         IfS2dComt9/DO6D8fZdzcP+5jPPZ424xf9yxlDlEuW4Uoor7X5ux0SCnbxWscLF4qEJc
         6hhA==
X-Gm-Message-State: AOAM531FTHMJ7jg3tvb7JeAlEFIG7Mpk2pzgzv1GRuD646Sra2RNKRgm
        3hbYirFJyNnDlntrZl+Vp6AX5g==
X-Google-Smtp-Source: ABdhPJzGaKUPLxNFXXm+1W2sojrrSeLytgI9MRqvg4lHrgMHYOXUEtbJyBq+zWA7fbr622yONmEsVA==
X-Received: by 2002:a17:902:6847:b029:d3:d44c:3c7b with SMTP id f7-20020a1709026847b02900d3d44c3c7bmr72162pln.53.1603768276964;
        Mon, 26 Oct 2020 20:11:16 -0700 (PDT)
Received: from localhost ([2600:3c01::f03c:91ff:fe8a:bb03])
        by smtp.gmail.com with ESMTPSA id il17sm135965pjb.39.2020.10.26.20.11.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 26 Oct 2020 20:11:16 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Andre Przywara <andre.przywara@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Wei Li <liwei391@huawei.com>,
        James Clark <james.clark@arm.com>, Al Grant <Al.Grant@arm.com>,
        Dave Martin <Dave.Martin@arm.com>, linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v4 13/21] perf arm-spe: Refactor counter packet handling
Date:   Tue, 27 Oct 2020 11:09:09 +0800
Message-Id: <20201027030917.15404-14-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201027030917.15404-1-leo.yan@linaro.org>
References: <20201027030917.15404-1-leo.yan@linaro.org>
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
 tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h |  5 +++++
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
index 8f481c6ea054..4be649c26002 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
@@ -152,10 +152,11 @@ static int arm_spe_get_counter(const unsigned char *buf, size_t len,
 			       const unsigned char ext_hdr, struct arm_spe_pkt *packet)
 {
 	packet->type = ARM_SPE_COUNTER;
+
 	if (ext_hdr)
-		packet->index = ((buf[0] & 0x3) << 3) | (buf[1] & 0x7);
+		packet->index = SPE_HDR_EXTENDED_INDEX(buf[0], buf[1]);
 	else
-		packet->index = buf[0] & 0x7;
+		packet->index = SPE_HDR_SHORT_INDEX(buf[0]);
 
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
index 9bc876bffd35..7d8e34e35f05 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
@@ -82,6 +82,11 @@ struct arm_spe_pkt {
 /* Context packet header */
 #define SPE_CTX_PKT_HDR_INDEX(h)		((h) & GENMASK_ULL(1, 0))
 
+/* Counter packet header */
+#define SPE_CNT_PKT_HDR_INDEX_TOTAL_LAT		0x0
+#define SPE_CNT_PKT_HDR_INDEX_ISSUE_LAT		0x1
+#define SPE_CNT_PKT_HDR_INDEX_TRANS_LAT		0x2
+
 const char *arm_spe_pkt_name(enum arm_spe_pkt_type);
 
 int arm_spe_get_packet(const unsigned char *buf, size_t len,
-- 
2.17.1

