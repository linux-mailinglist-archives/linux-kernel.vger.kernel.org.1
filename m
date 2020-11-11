Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F92E2AE9AB
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 08:21:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbgKKHVN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 02:21:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726308AbgKKHOJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 02:14:09 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD93DC061A48
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 23:13:16 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id w11so507146pll.8
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 23:13:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rUdWJBpVQKDUuBKsRdoQ/VtGJb0BHoKqXFn1e9x1cfY=;
        b=C5mWccxYhCK5fJ3TQwrTcbmDom7OuRF51wTOVIkYv4nv6S0duM2IB3MMpqCxffCdKY
         9Qeha07SYUGOL/iFG+vwx78r5aIXD5G379ZkhFv55K7Iu1vvILg6S8BTMQ+Ffr+y+6rg
         eveSnxjEbmuB21cPUznBdvfF0diW2i+2VQeOQyui63q6YHFHx8CDUVCAaL+zXV31xZ0p
         x/+LNQvgIFHh8CkAw0xcAkC28IqHvQyJjTUpHsR+WaRGb0tPjbMwKyHzIL+iP08iWtK0
         QNaz/CcB+5Ro5vM6CkX1aPUhg6L/dotADs1LRJr8I3Ysovpck5VVJcLd+cZAoVQxoLsz
         CSwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rUdWJBpVQKDUuBKsRdoQ/VtGJb0BHoKqXFn1e9x1cfY=;
        b=IF29zeX4EIrzVDqLaMy6fGczv76vkeLBjRJBQrz/6Yelvz2iZmyLthvGqQhFb9bwxU
         fUMzHRdICV1NtM8OwqtG+0o5IusGV3nMaVuVUCsbghGwTh8QA58W/J30NPQQ6NffjdWe
         8pwROm4RgkDUzh4LDjF3bPVvLGgNv+72KWzcPUXHWLKhpKIorm5/EsMWsHX6pEF76qQw
         sv3qsvQfihmvN5TwEzHsh9Zkf9y5pwvPRZC9R1KRP/9krY0/6S6XxAJynFxXMb05cukw
         MpyhTkyot+md0rFD6sqyoirvnaOnPJI+CJ3EKpr9NZcrXC4Qi4eUD88y9Rm5WcKePfvL
         jOww==
X-Gm-Message-State: AOAM532duAtxNEFueZ3vBmFn8NS7XX/5cY29rVn11zQQL1SbFzCU6c2Z
        0X1knRLNkkzXz70LkDdu3KGdxg==
X-Google-Smtp-Source: ABdhPJz8N4iaAhbZr4mOAbJPJKXizOVhKAOejcQJj1TdqeZwYRx05etoonoox59b36rWhLFQyqG7Og==
X-Received: by 2002:a17:902:864c:b029:d8:b3b1:b91c with SMTP id y12-20020a170902864cb02900d8b3b1b91cmr3862405plt.79.1605078796252;
        Tue, 10 Nov 2020 23:13:16 -0800 (PST)
Received: from localhost ([45.137.216.7])
        by smtp.gmail.com with ESMTPSA id fh22sm1265474pjb.45.2020.11.10.23.13.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 10 Nov 2020 23:13:15 -0800 (PST)
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
        linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v8 15/22] perf arm-spe: Add new function arm_spe_pkt_desc_event()
Date:   Wed, 11 Nov 2020 15:11:42 +0800
Message-Id: <20201111071149.815-16-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201111071149.815-1-leo.yan@linaro.org>
References: <20201111071149.815-1-leo.yan@linaro.org>
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
index 5178bbe64422..af87d3c8cb50 100644
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

