Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C9C8296155
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 16:59:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S368460AbgJVO7V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 10:59:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S368383AbgJVO6s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 10:58:48 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32A1AC0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 07:58:48 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id d3so2624037wma.4
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 07:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7MTPwJWXthxRo16St0ujjTTnNYZxSdKBnSjOSsjpHGg=;
        b=GpUusQdXkPit7LpPc50rgQ3KlAfI+Blwx6wDLLJw9t5HD2g77ry41/tYYReHUshe7w
         fBF1QCnkAo8tthgh85crsWdcfDEA3KJPEFx1rTfqa2seTGcWphewv7hOi1Pi4MimMApA
         FjMGtFipTXPbn1PEL6LvYs9yEUELuQdHG7nejwWp4l1+uMk2sSy6JW+K2U7y2vyulzDC
         TxED1I4LJwISMPZHHP9c4MSjlal5ssidL7qmnwfCDDA5769/2/b7LPoRoc7UyfYyTZfR
         S1xaAmyGtRZf2l20g7m5POeWjqvyEoIg3j6XucJGjSuOyGkr27SJsxGFwbsHqoaIZvcx
         rZpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7MTPwJWXthxRo16St0ujjTTnNYZxSdKBnSjOSsjpHGg=;
        b=szUnNpTG1nl6YnRn/6Jwdg4MsqUB1j/gdXm2nJUxuaWr67c1YaYLPu8BvgpBWhj2Nl
         UskljRI+sPEV8YSekGWy89tkYhndH411H20DHKXjCVZkB3QmRunF/25cmd1hTGj7jruC
         aFss5D0ZaL5FEq/bNtWc7DAGSm05+gNd9+ASNSpHSDe+ta2XyeMJJdamIDh7v6VVQIpC
         kkmE8mAUD6fySv2YXUv0u1gjqPKk3fBarDhI0Fn5He+vvEzDMYsQNabMNN6T2COiuIbX
         t22VOIiZQjOY0atFnulab7WE/2zD0EXFpV6ZsDWDE7lh0XjFmwhLrzsIpYAtwLfz56Pn
         coAw==
X-Gm-Message-State: AOAM531YjfQPpHf9DgGxVlP+Ephg0WK1fOatl7AqCNf/m8ZWvhh+UOfm
        zDFVjpbPb+/nEkoWrQLDYeiMZQ==
X-Google-Smtp-Source: ABdhPJzb8ixvyxn11GoHeXY/Ju4kzewRajqz0J85yerajHwuGpaOvC8S5ie8TOxH+TREno+SAyG/pg==
X-Received: by 2002:a1c:9cc1:: with SMTP id f184mr2886236wme.5.1603378726834;
        Thu, 22 Oct 2020 07:58:46 -0700 (PDT)
Received: from hackbox2.linaro.org ([81.128.185.34])
        by smtp.gmail.com with ESMTPSA id 130sm4348021wmd.18.2020.10.22.07.58.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2020 07:58:46 -0700 (PDT)
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
Subject: [PATCH v3 14/20] perf arm-spe: Refactor event type handling
Date:   Thu, 22 Oct 2020 15:58:10 +0100
Message-Id: <20201022145816.14069-15-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201022145816.14069-1-leo.yan@linaro.org>
References: <20201022145816.14069-1-leo.yan@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the enums of event types to arm-spe-pkt-decoder.h, thus function
arm_spe_pkt_desc() can them for bitmasks.

Suggested-by: Andre Przywara <andre.przywara@arm.com>
Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 .../util/arm-spe-decoder/arm-spe-decoder.h    | 17 --------------
 .../arm-spe-decoder/arm-spe-pkt-decoder.c     | 22 +++++++++----------
 .../arm-spe-decoder/arm-spe-pkt-decoder.h     | 18 +++++++++++++++
 3 files changed, 29 insertions(+), 28 deletions(-)

diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
index a5111a8d4360..24727b8ca7ff 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
@@ -13,23 +13,6 @@
 
 #include "arm-spe-pkt-decoder.h"
 
-enum arm_spe_events {
-	EV_EXCEPTION_GEN	= 0,
-	EV_RETIRED		= 1,
-	EV_L1D_ACCESS		= 2,
-	EV_L1D_REFILL		= 3,
-	EV_TLB_ACCESS		= 4,
-	EV_TLB_WALK		= 5,
-	EV_NOT_TAKEN		= 6,
-	EV_MISPRED		= 7,
-	EV_LLC_ACCESS		= 8,
-	EV_LLC_MISS		= 9,
-	EV_REMOTE_ACCESS	= 10,
-	EV_ALIGNMENT		= 11,
-	EV_PARTIAL_PREDICATE	= 17,
-	EV_EMPTY_PREDICATE	= 18,
-};
-
 enum arm_spe_sample_type {
 	ARM_SPE_L1D_ACCESS	= 1 << 0,
 	ARM_SPE_L1D_MISS	= 1 << 1,
diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
index 8a6b50f32a52..58a1390b7a43 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
@@ -277,58 +277,58 @@ static int arm_spe_pkt_desc_event(const struct arm_spe_pkt *packet,
 	if (ret < 0)
 		return ret;
 
-	if (payload & 0x1) {
+	if (payload & BIT(EV_EXCEPTION_GEN)) {
 		ret = arm_spe_pkt_snprintf(&buf, &blen, " EXCEPTION-GEN");
 		if (ret < 0)
 			return ret;
 	}
-	if (payload & 0x2) {
+	if (payload & BIT(EV_RETIRED)) {
 		ret = arm_spe_pkt_snprintf(&buf, &blen, " RETIRED");
 		if (ret < 0)
 			return ret;
 	}
-	if (payload & 0x4) {
+	if (payload & BIT(EV_L1D_ACCESS)) {
 		ret = arm_spe_pkt_snprintf(&buf, &blen, " L1D-ACCESS");
 		if (ret < 0)
 			return ret;
 	}
-	if (payload & 0x8) {
+	if (payload & BIT(EV_L1D_REFILL)) {
 		ret = arm_spe_pkt_snprintf(&buf, &blen, " L1D-REFILL");
 		if (ret < 0)
 			return ret;
 	}
-	if (payload & 0x10) {
+	if (payload & BIT(EV_TLB_ACCESS)) {
 		ret = arm_spe_pkt_snprintf(&buf, &blen, " TLB-ACCESS");
 		if (ret < 0)
 			return ret;
 	}
-	if (payload & 0x20) {
+	if (payload & BIT(EV_TLB_WALK)) {
 		ret = arm_spe_pkt_snprintf(&buf, &blen, " TLB-REFILL");
 		if (ret < 0)
 			return ret;
 	}
-	if (payload & 0x40) {
+	if (payload & BIT(EV_NOT_TAKEN)) {
 		ret = arm_spe_pkt_snprintf(&buf, &blen, " NOT-TAKEN");
 		if (ret < 0)
 			return ret;
 	}
-	if (payload & 0x80) {
+	if (payload & BIT(EV_MISPRED)) {
 		ret = arm_spe_pkt_snprintf(&buf, &blen, " MISPRED");
 		if (ret < 0)
 			return ret;
 	}
 	if (packet->index > 1) {
-		if (payload & 0x100) {
+		if (payload & BIT(EV_LLC_ACCESS)) {
 			ret = arm_spe_pkt_snprintf(&buf, &blen, " LLC-ACCESS");
 			if (ret < 0)
 				return ret;
 		}
-		if (payload & 0x200) {
+		if (payload & BIT(EV_LLC_MISS)) {
 			ret = arm_spe_pkt_snprintf(&buf, &blen, " LLC-REFILL");
 			if (ret < 0)
 				return ret;
 		}
-		if (payload & 0x400) {
+		if (payload & BIT(EV_REMOTE_ACCESS)) {
 			ret = arm_spe_pkt_snprintf(&buf, &blen, " REMOTE-ACCESS");
 			if (ret < 0)
 				return ret;
diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
index 8a291f451ef8..12c344454cf1 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
@@ -92,6 +92,24 @@ struct arm_spe_pkt {
 #define SPE_CNT_PKT_HDR_INDEX_ISSUE_LAT		0x1
 #define SPE_CNT_PKT_HDR_INDEX_TRANS_LAT		0x2
 
+/* Event packet payload */
+enum arm_spe_events {
+	EV_EXCEPTION_GEN	= 0,
+	EV_RETIRED		= 1,
+	EV_L1D_ACCESS		= 2,
+	EV_L1D_REFILL		= 3,
+	EV_TLB_ACCESS		= 4,
+	EV_TLB_WALK		= 5,
+	EV_NOT_TAKEN		= 6,
+	EV_MISPRED		= 7,
+	EV_LLC_ACCESS		= 8,
+	EV_LLC_MISS		= 9,
+	EV_REMOTE_ACCESS	= 10,
+	EV_ALIGNMENT		= 11,
+	EV_PARTIAL_PREDICATE	= 17,
+	EV_EMPTY_PREDICATE	= 18,
+};
+
 const char *arm_spe_pkt_name(enum arm_spe_pkt_type);
 
 int arm_spe_get_packet(const unsigned char *buf, size_t len,
-- 
2.17.1

