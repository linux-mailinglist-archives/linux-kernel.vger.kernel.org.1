Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D688129A305
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 04:12:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442649AbgJ0DLa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 23:11:30 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:35359 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439307AbgJ0DL2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 23:11:28 -0400
Received: by mail-pl1-f193.google.com with SMTP id 1so26803ple.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Oct 2020 20:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=h91Hsr8JZfLshvxrremyB8PHGamrovrG5XtMYrfkTVk=;
        b=frd1X06wPFp5auDVIJNnsbpk2df7TFh7YKN6Ar+QAiy5IjP9rgoSr9laX5rUGtX7ns
         jWzTBioCZINfmpKsht5LvFaAs4wS8JWXwQOcL8blFe08vQiHyODafMGXtwtzh3K9mw7s
         p2AW9evMHu5FITFFvfK5dHfi2Zaz3jRoZMWUf6V+glmn6/iUj4xrXVauN2Y1HmdEaED0
         bkQ8MRvJZRlhdvUN4GUyHd2VTf4uDij3xEdvmEYfQ6QduXUQguf50isKuKudFJeYnSJ1
         bGVefIpsJOD53+BS0tS19CyDFKbQs59SQHSzZCw3p0s368mntOdNYkaw1ocjsz4m2sVv
         WEvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=h91Hsr8JZfLshvxrremyB8PHGamrovrG5XtMYrfkTVk=;
        b=RrQo/D9jkLc6AugX28rDLxqsq3HGXHqLE86kQUrI328Vcg8Ie35pBxQoFd8bLZ+wDU
         fXClecRnnRfhrCv4Oytui/LZW84TkONd17gKKTSohgp0V69NasTdx66RhIjcjE50ysPh
         R3ZsLu9BZ42LljePSt1gx/6QUdVbbNsLG8oGJlhuyAX66KvXq7ZM0AG32QvDHq9t7oWC
         zGRPd8QbsL0qbgJqvLK91WcYF7TExaJz2sbj54Z2B9yWojFA0G0EDfjEsuCdPDKIO7wr
         r5+/A7Fjg3LJu3J5A1U2d1BQ/kb8yRzjVY82AT5DkJIeSu1ssCRv+FqO6PnUZOzNcVYC
         PEuw==
X-Gm-Message-State: AOAM533Bz/C5bEznSlFIr/Wlqp3UmnRMOS4E8rqsMGNiHwpFPfTzsz3B
        d6XOnZDiBbpe6kKOZn3LkmCwIA==
X-Google-Smtp-Source: ABdhPJw8dbBjB8z9emWFufWDWFwU8NM+oDv8CzQ0atTRLIBQGyYZHDDb10/2dAQbI+mx+AoxT48XTg==
X-Received: by 2002:a17:90a:9b08:: with SMTP id f8mr55540pjp.227.1603768287578;
        Mon, 26 Oct 2020 20:11:27 -0700 (PDT)
Received: from localhost ([2600:3c01::f03c:91ff:fe8a:bb03])
        by smtp.gmail.com with ESMTPSA id t6sm182176pfl.50.2020.10.26.20.11.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 26 Oct 2020 20:11:27 -0700 (PDT)
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
Subject: [PATCH v4 15/21] perf arm-spe: Refactor event type handling
Date:   Tue, 27 Oct 2020 11:09:11 +0800
Message-Id: <20201027030917.15404-16-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201027030917.15404-1-leo.yan@linaro.org>
References: <20201027030917.15404-1-leo.yan@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the enums of event types to arm-spe-pkt-decoder.h, thus function
arm_spe_pkt_desc() can them for bitmasks.

Suggested-by: Andre Przywara <andre.przywara@arm.com>
Signed-off-by: Leo Yan <leo.yan@linaro.org>
Reviewed-by: Andre Przywara <andre.przywara@arm.com>
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
index 0522d28d731a..8e4c4c90eeb0 100644
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
index 7d8e34e35f05..42ed4e61ede2 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
@@ -87,6 +87,24 @@ struct arm_spe_pkt {
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

