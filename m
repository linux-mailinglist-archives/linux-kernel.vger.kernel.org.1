Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADB8F29E3C6
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 08:21:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726320AbgJ2HVg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 03:21:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725998AbgJ2HVE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 03:21:04 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1849DC08E750
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 00:21:04 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id 133so1587436pfx.11
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 00:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=x1cO/SXIOEHac6ur8/gYKQVgUWAYWu9FLKLxdsxuyZw=;
        b=IAi99Oiz1X6jeCCwME7VWHwHPQ7loIHNfhxLny7bhuNRJ5PDwvH1XseGkT56Jv93ic
         pu6RROAAG90SZVUocg8egg1j8Q9gnZ2BbfFfeuMz1TijbMlkKS0CIxs6M6QtX5ZkVkx0
         VmRo7S0p4uXxXMvh0gGkPWe8587rmxDYeaBN+ISstRgeUr8tuFnVIK517Hfkd9BW7DKi
         pIsB4llX0WTDyk9THxNM2XOIjcnSZEvvi3oPcDIc4bfzE3KELAoj0v2Qs7fu1kRUm/wL
         wjErcGGugnHdBPOeFNiBu4POE9Yqjj6Vjm+BQenuLgnmaHS/T0mYe3/Om6WzCPETq5ZV
         If2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=x1cO/SXIOEHac6ur8/gYKQVgUWAYWu9FLKLxdsxuyZw=;
        b=SRfYZJ2nZC9x5KD1Y6hJAo4fkdEmDqVhi26ANpTFcSq1rwaR2bX2K9aN8L1C4Hpo1/
         LGCWpzBvYUbbz3g9C9bqq7aMhVXBIn2SHpIEWx21ObHRyXWSv/FTQmBsKgfPurIKUbo0
         NsduX7r4iPQjs1rOfWieRhijzkklY/PDpA2aYDxOb0YvIU7UWEW2pX0AlbsaCiA+I9wg
         Ui526EJQOV+2D0xGhH6qlA+aQXApLJhof6Tlj1w4tlVC5KFfv5IGVAXmsFpfb3IdJkfi
         ElRJei/KkPM/XvkTCe9iEaqfWeAlRavReVxYLU87E2dz7q9neJZU7wNcWLhTvKUYjo51
         XL5A==
X-Gm-Message-State: AOAM532impPFrQzDPkNx25Kvn0P71tgygEJ5CGCC5uLcCKLdeo/fCuZA
        IkrBjPcV7pnNInZNZ31vEZ/4xA==
X-Google-Smtp-Source: ABdhPJzDnjXcs/FsitXS3Q4P2Qaymt1WPG1DMR48xBrCNw1ReUpt1yox0JVzeiFkSDXYlQXLcw+E4g==
X-Received: by 2002:a65:6811:: with SMTP id l17mr2981470pgt.40.1603956063588;
        Thu, 29 Oct 2020 00:21:03 -0700 (PDT)
Received: from localhost ([2600:3c01::f03c:91ff:fe8a:bb03])
        by smtp.gmail.com with ESMTPSA id n25sm1527307pgd.67.2020.10.29.00.21.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 29 Oct 2020 00:21:03 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andre Przywara <andre.przywara@arm.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Wei Li <liwei391@huawei.com>,
        James Clark <james.clark@arm.com>, Al Grant <Al.Grant@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v5 17/21] perf arm-spe: Add new function arm_spe_pkt_desc_op_type()
Date:   Thu, 29 Oct 2020 15:19:23 +0800
Message-Id: <20201029071927.9308-18-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201029071927.9308-1-leo.yan@linaro.org>
References: <20201029071927.9308-1-leo.yan@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The operation type packet is complex and contains subclass; the parsing
flow causes deep indentation; for more readable, this patch introduces
a new function arm_spe_pkt_desc_op_type() which is used for operation
type parsing.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Reviewed-by: Andre Przywara <andre.przywara@arm.com>
---
 .../arm-spe-decoder/arm-spe-pkt-decoder.c     | 78 +++++++++++--------
 1 file changed, 44 insertions(+), 34 deletions(-)

diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
index b42ba64274c1..e51b103d9973 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
@@ -304,6 +304,49 @@ static int arm_spe_pkt_desc_event(const struct arm_spe_pkt *packet,
 	return err ?: (int)(buf_len - blen);
 }
 
+static int arm_spe_pkt_desc_op_type(const struct arm_spe_pkt *packet,
+				    char *buf, size_t buf_len)
+{
+	u64 payload = packet->payload;
+	size_t blen = buf_len;
+	int err = 0;
+
+	switch (packet->index) {
+	case 0:
+		return arm_spe_pkt_snprintf(&err, &buf, &blen,
+				payload & 0x1 ? "COND-SELECT" : "INSN-OTHER");
+	case 1:
+		arm_spe_pkt_snprintf(&err, &buf, &blen,
+				     payload & 0x1 ? "ST" : "LD");
+
+		if (payload & 0x2) {
+			if (payload & 0x4)
+				arm_spe_pkt_snprintf(&err, &buf, &blen, " AT");
+			if (payload & 0x8)
+				arm_spe_pkt_snprintf(&err, &buf, &blen, " EXCL");
+			if (payload & 0x10)
+				arm_spe_pkt_snprintf(&err, &buf, &blen, " AR");
+		} else if (payload & 0x4) {
+			arm_spe_pkt_snprintf(&err, &buf, &blen, " SIMD-FP");
+		}
+
+		return err ?: (int)(buf_len - blen);
+
+	case 2:
+		arm_spe_pkt_snprintf(&err, &buf, &blen, "B");
+
+		if (payload & 0x1)
+			arm_spe_pkt_snprintf(&err, &buf, &blen, " COND");
+		if (payload & 0x2)
+			arm_spe_pkt_snprintf(&err, &buf, &blen, " IND");
+
+		return err ?: (int)(buf_len - blen);
+
+	default:
+		return 0;
+	}
+}
+
 static int arm_spe_pkt_desc_addr(const struct arm_spe_pkt *packet,
 				 char *buf, size_t buf_len)
 {
@@ -378,40 +421,7 @@ int arm_spe_pkt_desc(const struct arm_spe_pkt *packet, char *buf,
 	case ARM_SPE_EVENTS:
 		return arm_spe_pkt_desc_event(packet, buf, buf_len);
 	case ARM_SPE_OP_TYPE:
-		switch (idx) {
-		case 0:
-			return arm_spe_pkt_snprintf(&err, &buf, &blen,
-					payload & 0x1 ? "COND-SELECT" : "INSN-OTHER");
-		case 1:
-			arm_spe_pkt_snprintf(&err, &buf, &blen,
-					     payload & 0x1 ? "ST" : "LD");
-
-			if (payload & 0x2) {
-				if (payload & 0x4)
-					arm_spe_pkt_snprintf(&err, &buf, &blen, " AT");
-				if (payload & 0x8)
-					arm_spe_pkt_snprintf(&err, &buf, &blen, " EXCL");
-				if (payload & 0x10)
-					arm_spe_pkt_snprintf(&err, &buf, &blen, " AR");
-			} else if (payload & 0x4) {
-				arm_spe_pkt_snprintf(&err, &buf, &blen, " SIMD-FP");
-			}
-
-			return err ?: (int)(buf_len - blen);
-
-		case 2:
-			arm_spe_pkt_snprintf(&err, &buf, &blen, "B");
-
-			if (payload & 0x1)
-				arm_spe_pkt_snprintf(&err, &buf, &blen, " COND");
-			if (payload & 0x2)
-				arm_spe_pkt_snprintf(&err, &buf, &blen, " IND");
-
-			return err ?: (int)(buf_len - blen);
-
-		default:
-			return 0;
-		}
+		return arm_spe_pkt_desc_op_type(packet, buf, buf_len);
 	case ARM_SPE_DATA_SOURCE:
 	case ARM_SPE_TIMESTAMP:
 		return arm_spe_pkt_snprintf(&err, &buf, &blen, "%s %lld", name, payload);
-- 
2.17.1

