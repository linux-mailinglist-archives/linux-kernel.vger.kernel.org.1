Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7946529FBDF
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 03:59:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbgJ3C7F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 22:59:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726514AbgJ3C7A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 22:59:00 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B609EC0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 19:58:59 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id 15so3956905pgd.12
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 19:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=77A45jwPdXwdCx3ogeeK/ZOPoHD7gEAhNd4CBNJfqKg=;
        b=lYLqcBwhjPdF/BY2EjsTg2F9k/5F0G5GjUgj6PsZFkDmC4jH/pKFdZURxvpn39fLpx
         iZGJ9WTQF2rL+mB9v8V/dtqd4m+zgqqSHPNWFqFjPWiFfNAr2VGTmMVfbwNnel66oJWz
         smBGt0EGqOGZVXqBmrKluudHTqI+OqLeA1ebu2tcgaIDz2E9w9j/p1f0UgqsE+BGL34K
         hgTlHscN5WwC2G6wvGbsf2tyFNF9lhpgtNfXgA91CMphpVLxDJUaXCVQDsmzRmRZNU19
         kbPfkxzpMtGJOH3+mz7Fapm5FGBGB9UDPocRjkch71p9NYzeqOxNovCTv7s7BpO/Xn5k
         Htiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=77A45jwPdXwdCx3ogeeK/ZOPoHD7gEAhNd4CBNJfqKg=;
        b=MLUU98WqE7v9SUoVAaJgr5R8rlzv5h3CZVPnqqYz4xQoClJ1N8SzLZ1SA5zRJ/Mn7y
         UYrPQ8CUUDhjeHw3nJL1KNEA3w4nhyuOjVrzqsaKlrq+1d4dqRZwTNmJkhh0w2+ewt67
         D3fs62fyEOEix/1aakglfLEUJiRGLy81hUsWZzDL76xyMEIDKcLgHZCqUGcDskJmz8SY
         lcX1KozWxU2ULRuWMLmFQrVtM89GfwDgfr7MpRIMHjlx0iqo8iNh0nR39j+mCkgcIwKD
         213b8juI4hUY3dUm7uQ49Bfn3LfDJAhYIJ7/HHgOCeLX5EPIsb+gqm11+uOX4z9ARVpi
         2Beg==
X-Gm-Message-State: AOAM531KXqrS2SP/yLRHJyLuIHF+vkW3u7zFXnJLYb6YXrKIu8CUcxSs
        QOtgswy0turi4lYNiM/KQQRB5w==
X-Google-Smtp-Source: ABdhPJwOOU3C5CSM1NLcUuKPWJ52EIVxz5ZrIfLY96+vB3A9ebyKv52jnSsi1LpW7DsPNSMymCss+Q==
X-Received: by 2002:a62:6507:0:b029:155:3b11:b458 with SMTP id z7-20020a6265070000b02901553b11b458mr7515474pfb.45.1604026739134;
        Thu, 29 Oct 2020 19:58:59 -0700 (PDT)
Received: from localhost ([2600:3c01::f03c:91ff:fe8a:bb03])
        by smtp.gmail.com with ESMTPSA id kx6sm272683pjb.46.2020.10.29.19.58.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 29 Oct 2020 19:58:58 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andre Przywara <andre.przywara@arm.com>,
        James Clark <james.clark@arm.com>,
        Dave Martin <Dave.Martin@arm.com>, Al Grant <Al.Grant@arm.com>,
        Wei Li <liwei391@huawei.com>, linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v6 14/21] perf arm-spe: Add new function arm_spe_pkt_desc_event()
Date:   Fri, 30 Oct 2020 10:57:17 +0800
Message-Id: <20201030025724.19157-15-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201030025724.19157-1-leo.yan@linaro.org>
References: <20201030025724.19157-1-leo.yan@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch moves out the event packet parsing from arm_spe_pkt_desc()
to the new function arm_spe_pkt_desc_event().

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Reviewed-by: Andre Przywara <andre.przywara@arm.com>
---
 .../arm-spe-decoder/arm-spe-pkt-decoder.c     | 66 +++++++++++--------
 1 file changed, 38 insertions(+), 28 deletions(-)

diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
index d867d7024480..04ae4b760840 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
@@ -273,6 +273,43 @@ static int arm_spe_pkt_snprintf(int *err, char **buf_p, size_t *blen,
 	return ret;
 }
 
+static int arm_spe_pkt_desc_event(const struct arm_spe_pkt *packet,
+				  char *buf, size_t buf_len)
+{
+	u64 payload = packet->payload;
+	size_t blen = buf_len;
+	int err = 0;
+
+	arm_spe_pkt_snprintf(&err, &buf, &blen, "EV");
+
+	if (payload & 0x1)
+		arm_spe_pkt_snprintf(&err, &buf, &blen, " EXCEPTION-GEN");
+	if (payload & 0x2)
+		arm_spe_pkt_snprintf(&err, &buf, &blen, " RETIRED");
+	if (payload & 0x4)
+		arm_spe_pkt_snprintf(&err, &buf, &blen, " L1D-ACCESS");
+	if (payload & 0x8)
+		arm_spe_pkt_snprintf(&err, &buf, &blen, " L1D-REFILL");
+	if (payload & 0x10)
+		arm_spe_pkt_snprintf(&err, &buf, &blen, " TLB-ACCESS");
+	if (payload & 0x20)
+		arm_spe_pkt_snprintf(&err, &buf, &blen, " TLB-REFILL");
+	if (payload & 0x40)
+		arm_spe_pkt_snprintf(&err, &buf, &blen, " NOT-TAKEN");
+	if (payload & 0x80)
+		arm_spe_pkt_snprintf(&err, &buf, &blen, " MISPRED");
+	if (packet->index > 1) {
+		if (payload & 0x100)
+			arm_spe_pkt_snprintf(&err, &buf, &blen, " LLC-ACCESS");
+		if (payload & 0x200)
+			arm_spe_pkt_snprintf(&err, &buf, &blen, " LLC-REFILL");
+		if (payload & 0x400)
+			arm_spe_pkt_snprintf(&err, &buf, &blen, " REMOTE-ACCESS");
+	}
+
+	return err ?: (int)(buf_len - blen);
+}
+
 static int arm_spe_pkt_desc_addr(const struct arm_spe_pkt *packet,
 				 char *buf, size_t buf_len)
 {
@@ -345,34 +382,7 @@ int arm_spe_pkt_desc(const struct arm_spe_pkt *packet, char *buf,
 	case ARM_SPE_END:
 		return arm_spe_pkt_snprintf(&err, &buf, &blen, "%s", name);
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
-		return err ?: (int)(buf_len - blen);
-
+		return arm_spe_pkt_desc_event(packet, buf, buf_len);
 	case ARM_SPE_OP_TYPE:
 		switch (idx) {
 		case 0:
-- 
2.17.1

