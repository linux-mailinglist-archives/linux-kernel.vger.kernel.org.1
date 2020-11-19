Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 560BE2B9624
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 16:26:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728619AbgKSPZd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 10:25:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728520AbgKSPZb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 10:25:31 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7934C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 07:25:30 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id y7so4787691pfq.11
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 07:25:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Ey8d1UlWJG1Zz2Q3K1zIf680YY3GF+PiDiDzSdWK8Ls=;
        b=jOtZW9CydrxYkVP/D6zAZs/SxnrT1zzgb0ZFNqxTt2nEWp4CwmZk6wBCYH+ThpFBJA
         7V3izyv35rbsBjVOUiWk5Jgx2jVq/TPofeJ665dkM4nfvixIS5oHAuEl8smZW6PMhSFo
         u5MfGkXLOEeAeD5OKMk9sf/xHiYMq8rCRhd+e8eKjtjRAnzeIZrr6Pa1wsD2+QUx4pXr
         ngPGEZ3hAZ55VVFDrKhMNC0yXbmhW1X+Q3uNaCv54eVXAnQ6/49fM4M6QR/NbowywUk7
         LZowTZzUmxuFz+xgrSC8sCPXBhFzvRcMDehIqCTWacZpJcWgENzfO8CD2i6PKCt6uxXo
         IxMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Ey8d1UlWJG1Zz2Q3K1zIf680YY3GF+PiDiDzSdWK8Ls=;
        b=ooDa5AXpAynwkaCXdu36WiCWhei3DjAldiJBOLC9OQktEYyp8HYo/K/nyqWE5uE6jg
         dHXCX/uGFggjvY6FfwOAW44yDBbwX1tV8gf1MP9IK7kzUnCDA/bpvBhCWHl/PZTtlDg6
         sbj5vIZ4VPPazg90Q02EcZNeKPiZbVk2cMmralE4leQOWFKnR3YOlzdDtSZusOdNDkeq
         sxzNuLaZL+acm2rGAr65IAc2si6+BRNy8cLS6ualNjBQXJo9cQv7ZmvJ6BCC/knnFGIu
         Em8NQhyzu+Q2lOmyKauxlcqyWjaoBO8u7wxVO9NG6HJd9XACJd1wC8KQpfOrMhf8ngqf
         LqiQ==
X-Gm-Message-State: AOAM5337kbpKFfUFh+qD18FjLesaD+5rdjJIfdipPIf1EIiX2ks84i6S
        fb5Cd4IqnR44EEKvcdYO27cI/A==
X-Google-Smtp-Source: ABdhPJzqActfVd1qN/uFr68PlWsqyNGdCiOFpnL60hPtElLJVaz70jRInZe4qIqLXC8pf+hFg6CjFA==
X-Received: by 2002:a63:1057:: with SMTP id 23mr10286955pgq.41.1605799530395;
        Thu, 19 Nov 2020 07:25:30 -0800 (PST)
Received: from localhost ([45.137.216.7])
        by smtp.gmail.com with ESMTPSA id 6sm136156pfb.22.2020.11.19.07.25.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 19 Nov 2020 07:25:29 -0800 (PST)
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
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v9 09/16] perf arm-spe: Add new function arm_spe_pkt_desc_event()
Date:   Thu, 19 Nov 2020 23:24:34 +0800
Message-Id: <20201119152441.6972-10-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201119152441.6972-1-leo.yan@linaro.org>
References: <20201119152441.6972-1-leo.yan@linaro.org>
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
index 52f4339b1f0c..da6b9f76739c 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
@@ -287,6 +287,42 @@ static int arm_spe_pkt_out_string(int *err, char **buf_p, size_t *blen,
 	return ret;
 }
 
+static int arm_spe_pkt_desc_event(const struct arm_spe_pkt *packet,
+				  char *buf, size_t buf_len)
+{
+	u64 payload = packet->payload;
+	int err = 0;
+
+	arm_spe_pkt_out_string(&err, &buf, &buf_len, "EV");
+
+	if (payload & 0x1)
+		arm_spe_pkt_out_string(&err, &buf, &buf_len, " EXCEPTION-GEN");
+	if (payload & 0x2)
+		arm_spe_pkt_out_string(&err, &buf, &buf_len, " RETIRED");
+	if (payload & 0x4)
+		arm_spe_pkt_out_string(&err, &buf, &buf_len, " L1D-ACCESS");
+	if (payload & 0x8)
+		arm_spe_pkt_out_string(&err, &buf, &buf_len, " L1D-REFILL");
+	if (payload & 0x10)
+		arm_spe_pkt_out_string(&err, &buf, &buf_len, " TLB-ACCESS");
+	if (payload & 0x20)
+		arm_spe_pkt_out_string(&err, &buf, &buf_len, " TLB-REFILL");
+	if (payload & 0x40)
+		arm_spe_pkt_out_string(&err, &buf, &buf_len, " NOT-TAKEN");
+	if (payload & 0x80)
+		arm_spe_pkt_out_string(&err, &buf, &buf_len, " MISPRED");
+	if (packet->index > 1) {
+		if (payload & 0x100)
+			arm_spe_pkt_out_string(&err, &buf, &buf_len, " LLC-ACCESS");
+		if (payload & 0x200)
+			arm_spe_pkt_out_string(&err, &buf, &buf_len, " LLC-REFILL");
+		if (payload & 0x400)
+			arm_spe_pkt_out_string(&err, &buf, &buf_len, " REMOTE-ACCESS");
+	}
+
+	return err;
+}
+
 static int arm_spe_pkt_desc_addr(const struct arm_spe_pkt *packet,
 				 char *buf, size_t buf_len)
 {
@@ -367,32 +403,7 @@ int arm_spe_pkt_desc(const struct arm_spe_pkt *packet, char *buf,
 		arm_spe_pkt_out_string(&err, &buf, &blen, "%s", name);
 		break;
 	case ARM_SPE_EVENTS:
-		arm_spe_pkt_out_string(&err, &buf, &blen, "EV");
-
-		if (payload & 0x1)
-			arm_spe_pkt_out_string(&err, &buf, &blen, " EXCEPTION-GEN");
-		if (payload & 0x2)
-			arm_spe_pkt_out_string(&err, &buf, &blen, " RETIRED");
-		if (payload & 0x4)
-			arm_spe_pkt_out_string(&err, &buf, &blen, " L1D-ACCESS");
-		if (payload & 0x8)
-			arm_spe_pkt_out_string(&err, &buf, &blen, " L1D-REFILL");
-		if (payload & 0x10)
-			arm_spe_pkt_out_string(&err, &buf, &blen, " TLB-ACCESS");
-		if (payload & 0x20)
-			arm_spe_pkt_out_string(&err, &buf, &blen, " TLB-REFILL");
-		if (payload & 0x40)
-			arm_spe_pkt_out_string(&err, &buf, &blen, " NOT-TAKEN");
-		if (payload & 0x80)
-			arm_spe_pkt_out_string(&err, &buf, &blen, " MISPRED");
-		if (idx > 1) {
-			if (payload & 0x100)
-				arm_spe_pkt_out_string(&err, &buf, &blen, " LLC-ACCESS");
-			if (payload & 0x200)
-				arm_spe_pkt_out_string(&err, &buf, &blen, " LLC-REFILL");
-			if (payload & 0x400)
-				arm_spe_pkt_out_string(&err, &buf, &blen, " REMOTE-ACCESS");
-		}
+		err = arm_spe_pkt_desc_event(packet, buf, buf_len);
 		break;
 	case ARM_SPE_OP_TYPE:
 		switch (idx) {
-- 
2.17.1

