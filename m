Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2A132A8C40
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 02:44:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733214AbgKFBnf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 20:43:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732636AbgKFBna (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 20:43:30 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFB8EC0613CF
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 17:43:30 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id g12so2693749pgm.8
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 17:43:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sZ1TURQ8xgzvEd1kdR489mgXLXtQcjCf3w6PTpNgpNY=;
        b=QsPCp1yaDER+X/lANu6XojMrRReuVMT5RuAeqsnTKkjTdk2NbcSDTXTmYhNGjQESG7
         EKMTSy1VUVck8QhfbCFMNwGOypLwvrAjn4LAUJCXyEE5pIAfEUleXGN0eq+uX1DqZ2Mr
         3JtNeETiQ/iul2C6Q/m3STs2AVEMVJZgcHYDiQE14qvpeNr7OAuoDVOQmlMJ7Lfyv6/s
         EDvy0BGrpl/R//9XnIsEMypzKKZrLBQ+7u1or3JDBo/mKzEAdeGG14D2XtdSm4pVEaNf
         X3EnoQ7n6uggg6UeR28cE4wd/zpKNRyGUq63uaVPP6qIIxHS1mR6Jjymp6eYQ6fSVFVn
         20lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=sZ1TURQ8xgzvEd1kdR489mgXLXtQcjCf3w6PTpNgpNY=;
        b=mktFHBcQ0nlk1Vh1EGw409fHQ5t3XjnUkxs9T9QHmD4B8fGv3X4P7d+7WP0Dxptdeb
         61eSZpCIRNT0NSoleHnPoX+KeIYH/HqeoAuQmleBLP4gXpncSZLRNuZIRbEEUyc2099w
         2WBNr0UI1bY0z8EmffwW94JjKGzIcz9RwyHaQGJUVNF4wwe3uDxcpp+8LXy6H9PeBsMC
         i49oiBy0Bkp5gNgGk0NbWX5jqDo1iIsn7rbfMvNr7DNHYgBNPjkzVHWQLxbV98ogrnxV
         YkiyeE/eeTn1fnJkRcFADhkQlQ/msw82FKjXNhOwADxsheltBKF0ZRFyOhA8GMJ/NsGx
         4aVw==
X-Gm-Message-State: AOAM531a+u7nakUtp2EEZcQE62veC+palfCRRk2A0YRBDBvZ+YHJj2eo
        NPgOumu3kZLM8Ax6Y3tGPZ3GJA==
X-Google-Smtp-Source: ABdhPJyc4ZHKzmMfoaVEWA5dbjo3I96wl7d6zb9mYH8sM2qVy9aRl6G4/vfPfizIUeWvxQBHud/WrQ==
X-Received: by 2002:a17:90a:5884:: with SMTP id j4mr5116505pji.7.1604627010430;
        Thu, 05 Nov 2020 17:43:30 -0800 (PST)
Received: from localhost ([2400:8904::f03c:91ff:fe8a:adf7])
        by smtp.gmail.com with ESMTPSA id g15sm3758226pgi.89.2020.11.05.17.43.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 05 Nov 2020 17:43:29 -0800 (PST)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Andre Przywara <andre.przywara@arm.com>,
        Dave Martin <Dave.Martin@arm.com>,
        James Clark <james.clark@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Al Grant <Al.Grant@arm.com>, Wei Li <liwei391@huawei.com>,
        linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v7 15/22] perf arm-spe: Add new function arm_spe_pkt_desc_event()
Date:   Fri,  6 Nov 2020 09:41:29 +0800
Message-Id: <20201106014136.14103-16-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201106014136.14103-1-leo.yan@linaro.org>
References: <20201106014136.14103-1-leo.yan@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch moves out the event packet parsing from arm_spe_pkt_desc()
to the new function arm_spe_pkt_desc_event().

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Reviewed-by: Andre Przywara <andre.przywara@arm.com>
---
 .../arm-spe-decoder/arm-spe-pkt-decoder.c     | 63 +++++++++++--------
 1 file changed, 37 insertions(+), 26 deletions(-)

diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
index 4b58aa6a2877..a1fd7d58bf83 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
@@ -287,6 +287,42 @@ static int arm_spe_pkt_snprintf(int *err, char **buf_p, size_t *blen,
 	return ret;
 }
 
+static int arm_spe_pkt_desc_event(const struct arm_spe_pkt *packet,
+				  char *buf, size_t buf_len)
+{
+	u64 payload = packet->payload;
+	int err = 0;
+
+	arm_spe_pkt_snprintf(&err, &buf, &buf_len, "EV");
+
+	if (payload & 0x1)
+		arm_spe_pkt_snprintf(&err, &buf, &buf_len, " EXCEPTION-GEN");
+	if (payload & 0x2)
+		arm_spe_pkt_snprintf(&err, &buf, &buf_len, " RETIRED");
+	if (payload & 0x4)
+		arm_spe_pkt_snprintf(&err, &buf, &buf_len, " L1D-ACCESS");
+	if (payload & 0x8)
+		arm_spe_pkt_snprintf(&err, &buf, &buf_len, " L1D-REFILL");
+	if (payload & 0x10)
+		arm_spe_pkt_snprintf(&err, &buf, &buf_len, " TLB-ACCESS");
+	if (payload & 0x20)
+		arm_spe_pkt_snprintf(&err, &buf, &buf_len, " TLB-REFILL");
+	if (payload & 0x40)
+		arm_spe_pkt_snprintf(&err, &buf, &buf_len, " NOT-TAKEN");
+	if (payload & 0x80)
+		arm_spe_pkt_snprintf(&err, &buf, &buf_len, " MISPRED");
+	if (packet->index > 1) {
+		if (payload & 0x100)
+			arm_spe_pkt_snprintf(&err, &buf, &buf_len, " LLC-ACCESS");
+		if (payload & 0x200)
+			arm_spe_pkt_snprintf(&err, &buf, &buf_len, " LLC-REFILL");
+		if (payload & 0x400)
+			arm_spe_pkt_snprintf(&err, &buf, &buf_len, " REMOTE-ACCESS");
+	}
+
+	return err;
+}
+
 static int arm_spe_pkt_desc_addr(const struct arm_spe_pkt *packet,
 				 char *buf, size_t buf_len)
 {
@@ -367,32 +403,7 @@ int arm_spe_pkt_desc(const struct arm_spe_pkt *packet, char *buf,
 		arm_spe_pkt_snprintf(&err, &buf, &blen, "%s", name);
 		break;
 	case ARM_SPE_EVENTS:
-		arm_spe_pkt_snprintf(&err, &buf, &blen, "EV");
-
-		if (payload & 0x1)
-			arm_spe_pkt_snprintf(&err, &buf, &blen, " EXCEPTION-GEN");
-		if (payload & 0x2)
-			arm_spe_pkt_snprintf(&err, &buf, &blen, " RETIRED");
-		if (payload & 0x4)
-			arm_spe_pkt_snprintf(&err, &buf, &blen, " L1D-ACCESS");
-		if (payload & 0x8)
-			arm_spe_pkt_snprintf(&err, &buf, &blen, " L1D-REFILL");
-		if (payload & 0x10)
-			arm_spe_pkt_snprintf(&err, &buf, &blen, " TLB-ACCESS");
-		if (payload & 0x20)
-			arm_spe_pkt_snprintf(&err, &buf, &blen, " TLB-REFILL");
-		if (payload & 0x40)
-			arm_spe_pkt_snprintf(&err, &buf, &blen, " NOT-TAKEN");
-		if (payload & 0x80)
-			arm_spe_pkt_snprintf(&err, &buf, &blen, " MISPRED");
-		if (idx > 1) {
-			if (payload & 0x100)
-				arm_spe_pkt_snprintf(&err, &buf, &blen, " LLC-ACCESS");
-			if (payload & 0x200)
-				arm_spe_pkt_snprintf(&err, &buf, &blen, " LLC-REFILL");
-			if (payload & 0x400)
-				arm_spe_pkt_snprintf(&err, &buf, &blen, " REMOTE-ACCESS");
-		}
+		err = arm_spe_pkt_desc_event(packet, buf, buf_len);
 		break;
 	case ARM_SPE_OP_TYPE:
 		switch (idx) {
-- 
2.17.1

