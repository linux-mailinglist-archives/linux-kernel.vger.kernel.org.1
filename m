Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5369627CF90
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 15:42:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730000AbgI2Nlb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 09:41:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730589AbgI2NlB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 09:41:01 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8DCFC0613D0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 06:41:00 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id e16so5488299wrm.2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 06:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=V7t80VEGU+1flylCOo8KOXAW5s6Hsek00vMaqMhpTeI=;
        b=sfNszbkxx3u8LurR85aEnXZNb93NwDEmMbg7XKu8XgGcA/KHhd1cLZsIbkmUYnnKgy
         cpPtL3NVEx27UuFLA6+z7TKME3xTPk/fcdShOBrG1uUlVbAJLvdf5TDRIGuZGFtmqLiB
         mFtFy6N7vlXSzGIA4seYgm3seEPAJlHFTjCJKyN2G576gRX6QNmZyYYnzRRDuJMfte3l
         3J0BYCw2zUuWT1mUXd3xzU4fuG7VwsOmrOcXkzDn5z/63858LrTIewgEylxo9lZ5x9xl
         IXlw7pr+6LM+LFjclC4TOdOd70gYfZxYa8L5LpZ/1hwYj2voYb1A5FOQomDTGQir+ojF
         VQng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=V7t80VEGU+1flylCOo8KOXAW5s6Hsek00vMaqMhpTeI=;
        b=B8xRmBJnjggBO+PC42Hng55twXOzwW7dHbeT+WENvf/x6ZAGYaeypujOX/LWEu7GZf
         B/GP1cvqQ6LqhYr2Vvn9u98Ol1lK/alMMvYh8SA/TR/8WGR4zKZpMXpJVwXWM1oUHA5G
         45A06gsAvMheAKQfC0fsbYCYFYVUJUaokeXLViPYOv+pnEAb4NFrgBSYZgIP2gnoOViX
         Z1W1QRMaDzSe9WSx8jcJnmcTeTGRDuZiGHtUGTbpC6BrqsmBDdhAc1AYMzF098G4pY/q
         8/QYE0jrrJDZRl7cI5Pm/DlytnCiD2gO9uytXP6bMY4xNdS1vIOTiOBxny6LpAX/uBgC
         NZFw==
X-Gm-Message-State: AOAM530Kc3oLoFV5xYjVv8Je1ydHiL7Ml1QBTay4R227DI6wZ68XKET5
        QIusmqQFO0F7/BIaTTmYkbTEew==
X-Google-Smtp-Source: ABdhPJzUDjexixm/zpc6ox8GKRYXqB+HIzZjM/bbE9ZrlzXdr9RajzdxvwOPq0FM2CwzeoGj29Kc7g==
X-Received: by 2002:a5d:574a:: with SMTP id q10mr4367871wrw.127.1601386859434;
        Tue, 29 Sep 2020 06:40:59 -0700 (PDT)
Received: from hackbox2.linaro.org ([81.128.185.34])
        by smtp.gmail.com with ESMTPSA id q15sm5955314wrr.8.2020.09.29.06.40.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2020 06:40:58 -0700 (PDT)
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
Subject: [PATCH v2 10/14] perf arm-spe: Refactor event type handling
Date:   Tue, 29 Sep 2020 14:39:13 +0100
Message-Id: <20200929133917.9224-11-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200929133917.9224-1-leo.yan@linaro.org>
References: <20200929133917.9224-1-leo.yan@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use macros instead of the enum values for event types, this is more
directive and without bit shifting when parse packet.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 .../util/arm-spe-decoder/arm-spe-decoder.c    | 16 +++++++-------
 .../util/arm-spe-decoder/arm-spe-decoder.h    | 17 --------------
 .../arm-spe-decoder/arm-spe-pkt-decoder.c     | 22 +++++++++----------
 .../arm-spe-decoder/arm-spe-pkt-decoder.h     | 16 ++++++++++++++
 4 files changed, 35 insertions(+), 36 deletions(-)

diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
index 9d3de163d47c..ac66e7f42a58 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
@@ -168,31 +168,31 @@ static int arm_spe_read_record(struct arm_spe_decoder *decoder)
 		case ARM_SPE_OP_TYPE:
 			break;
 		case ARM_SPE_EVENTS:
-			if (payload & BIT(EV_L1D_REFILL))
+			if (payload & SPE_EVT_PKT_L1D_REFILL)
 				decoder->record.type |= ARM_SPE_L1D_MISS;
 
-			if (payload & BIT(EV_L1D_ACCESS))
+			if (payload & SPE_EVT_PKT_L1D_ACCESS)
 				decoder->record.type |= ARM_SPE_L1D_ACCESS;
 
-			if (payload & BIT(EV_TLB_WALK))
+			if (payload & SPE_EVT_PKT_TLB_WALK)
 				decoder->record.type |= ARM_SPE_TLB_MISS;
 
-			if (payload & BIT(EV_TLB_ACCESS))
+			if (payload & SPE_EVT_PKT_TLB_ACCESS)
 				decoder->record.type |= ARM_SPE_TLB_ACCESS;
 
 			if ((idx == 2 || idx == 4 || idx == 8) &&
-			    (payload & BIT(EV_LLC_MISS)))
+			    (payload & SPE_EVT_PKT_LLC_MISS))
 				decoder->record.type |= ARM_SPE_LLC_MISS;
 
 			if ((idx == 2 || idx == 4 || idx == 8) &&
-			    (payload & BIT(EV_LLC_ACCESS)))
+			    (payload & SPE_EVT_PKT_LLC_ACCESS))
 				decoder->record.type |= ARM_SPE_LLC_ACCESS;
 
 			if ((idx == 2 || idx == 4 || idx == 8) &&
-			    (payload & BIT(EV_REMOTE_ACCESS)))
+			    (payload & SPE_EVT_PKT_REMOTE_ACCESS))
 				decoder->record.type |= ARM_SPE_REMOTE_ACCESS;
 
-			if (payload & BIT(EV_MISPRED))
+			if (payload & SPE_EVT_PKT_MISPREDICTED)
 				decoder->record.type |= ARM_SPE_BRANCH_MISS;
 
 			break;
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
index ed0f4c74dfc5..b8f343320abf 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
@@ -284,58 +284,58 @@ int arm_spe_pkt_desc(const struct arm_spe_pkt *packet, char *buf,
 		if (ret < 0)
 			return ret;
 
-		if (payload & 0x1) {
+		if (payload & SPE_EVT_PKT_GEN_EXCEPTION) {
 			ret = arm_spe_pkt_snprintf(&buf, &blen, " EXCEPTION-GEN");
 			if (ret < 0)
 				return ret;
 		}
-		if (payload & 0x2) {
+		if (payload & SPE_EVT_PKT_ARCH_RETIRED) {
 			ret = arm_spe_pkt_snprintf(&buf, &blen, " RETIRED");
 			if (ret < 0)
 				return ret;
 		}
-		if (payload & 0x4) {
+		if (payload & SPE_EVT_PKT_L1D_ACCESS) {
 			ret = arm_spe_pkt_snprintf(&buf, &blen, " L1D-ACCESS");
 			if (ret < 0)
 				return ret;
 		}
-		if (payload & 0x8) {
+		if (payload & SPE_EVT_PKT_L1D_REFILL) {
 			ret = arm_spe_pkt_snprintf(&buf, &blen, " L1D-REFILL");
 			if (ret < 0)
 				return ret;
 		}
-		if (payload & 0x10) {
+		if (payload & SPE_EVT_PKT_TLB_ACCESS) {
 			ret = arm_spe_pkt_snprintf(&buf, &blen, " TLB-ACCESS");
 			if (ret < 0)
 				return ret;
 		}
-		if (payload & 0x20) {
+		if (payload & SPE_EVT_PKT_TLB_WALK) {
 			ret = arm_spe_pkt_snprintf(&buf, &blen, " TLB-REFILL");
 			if (ret < 0)
 				return ret;
 		}
-		if (payload & 0x40) {
+		if (payload & SPE_EVT_PKT_NOT_TAKEN) {
 			ret = arm_spe_pkt_snprintf(&buf, &blen, " NOT-TAKEN");
 			if (ret < 0)
 				return ret;
 		}
-		if (payload & 0x80) {
+		if (payload & SPE_EVT_PKT_MISPREDICTED) {
 			ret = arm_spe_pkt_snprintf(&buf, &blen, " MISPRED");
 			if (ret < 0)
 				return ret;
 		}
 		if (idx > 1) {
-			if (payload & 0x100) {
+			if (payload & SPE_EVT_PKT_LLC_ACCESS) {
 				ret = arm_spe_pkt_snprintf(&buf, &blen, " LLC-ACCESS");
 				if (ret < 0)
 					return ret;
 			}
-			if (payload & 0x200) {
+			if (payload & SPE_EVT_PKT_LLC_MISS) {
 				ret = arm_spe_pkt_snprintf(&buf, &blen, " LLC-REFILL");
 				if (ret < 0)
 					return ret;
 			}
-			if (payload & 0x400) {
+			if (payload & SPE_EVT_PKT_REMOTE_ACCESS) {
 				ret = arm_spe_pkt_snprintf(&buf, &blen, " REMOTE-ACCESS");
 				if (ret < 0)
 					return ret;
diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
index 18667a63f5ba..e9a88cf685bb 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
@@ -98,6 +98,22 @@ struct arm_spe_pkt {
 #define SPE_CNT_PKT_HDR_EXT_INDEX_MASK		GENMASK_ULL(1, 0)
 #define SPE_CNT_PKT_HDR_EXT_INDEX_SHIFT		(3)
 
+/* Event packet payload */
+#define SPE_EVT_PKT_SVE_EMPTY_PREDICATE		BIT(18)
+#define SPE_EVT_PKT_SVE_PARTIAL_PREDICATE	BIT(17)
+#define SPE_EVT_PKT_ALIGNMENT			BIT(11)
+#define SPE_EVT_PKT_REMOTE_ACCESS		BIT(10)
+#define SPE_EVT_PKT_LLC_MISS			BIT(9)
+#define SPE_EVT_PKT_LLC_ACCESS			BIT(8)
+#define SPE_EVT_PKT_MISPREDICTED		BIT(7)
+#define SPE_EVT_PKT_NOT_TAKEN			BIT(6)
+#define SPE_EVT_PKT_TLB_WALK			BIT(5)
+#define SPE_EVT_PKT_TLB_ACCESS			BIT(4)
+#define SPE_EVT_PKT_L1D_REFILL			BIT(3)
+#define SPE_EVT_PKT_L1D_ACCESS			BIT(2)
+#define SPE_EVT_PKT_ARCH_RETIRED		BIT(1)
+#define SPE_EVT_PKT_GEN_EXCEPTION		BIT(0)
+
 const char *arm_spe_pkt_name(enum arm_spe_pkt_type);
 
 int arm_spe_get_packet(const unsigned char *buf, size_t len,
-- 
2.20.1

