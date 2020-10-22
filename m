Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3548529614D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 16:59:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S368406AbgJVO6z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 10:58:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S368377AbgJVO6r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 10:58:47 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2566C0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 07:58:46 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id h5so2836877wrv.7
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 07:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ESpjEueif5mtR7rJJgp6HP6oo2WROpHW2VoWCVjLokk=;
        b=ysSDJjr43O3pWBkQ6FRS9JfEZFZa77MeUXxHKCujpMvoRnVAc+LjMBk6BCDy2jSq9y
         dpBNiq3+pQJ80FjOIouKrqiXAyl3d7i/uOw7SuiMLAZzIIqVYB+TMOP2OsS6YsgelLKN
         7U++bCeG1PVxN3TIfEt8DsyeSeVwDslKYUI1uf+gj8g9/AaQJ4yDbkmOY1aaojqKYFZB
         E7IkgIOA39E8XG5OR2VHA1aNbW9nJTxU13WRdI+aN+qVdcUF5O/z38L+arpVexz59jun
         5uCQrWNIvXj9jY0MCkpS88VXXdhL6luDbui3AdYUVTve+DEJCwbiyKdTFCaBnIyrRH3x
         QQmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ESpjEueif5mtR7rJJgp6HP6oo2WROpHW2VoWCVjLokk=;
        b=AJJ8z6uqs8IDdDQbpIxr3XiMyy918j4X8rbb1ya5XWHrQl+Oo03BZHbo6M0YSYqwq/
         msml9kxEa4ZA+5WaSuS7mKyyDFtqFr9gUq0cHOYC1DkPM8Sv/4TXV+kDwVKMGgR0zVTI
         RlcbHkd1Zr074w+ld7BmGJ86itgUq/QP1P9emT9tBzA1DCLXoqj+K3lWT+nj91ep/7Bq
         WAPEr7kD0nmZOewvIiXNA+t7r58DD01jzN3o5vw1kqn0yffObZfXcKlYKQ4YFIKSbiiV
         cNQkUwK2yYwO/2c7Zeg7opYMKIp4I0Dyi5SuT00n8FVsbLM6vWjzYHNNDCRLslHIJtrj
         0VKA==
X-Gm-Message-State: AOAM533MHsy4JMa0iMpLkybpqYpAOKelM79yW+9kKTmJg1DWOmQn1Scw
        MDNkCKAsaYtRteNwAb7l/OFQFQ==
X-Google-Smtp-Source: ABdhPJzr9voH1/gTZ2TXht44kqmZWijNB9Vw2mc4pwY2q2gjYxeUSyiQwdehEKU8wR0y0qYvX7RJtg==
X-Received: by 2002:a5d:490c:: with SMTP id x12mr3159720wrq.193.1603378725652;
        Thu, 22 Oct 2020 07:58:45 -0700 (PDT)
Received: from hackbox2.linaro.org ([81.128.185.34])
        by smtp.gmail.com with ESMTPSA id 130sm4348021wmd.18.2020.10.22.07.58.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2020 07:58:45 -0700 (PDT)
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
Subject: [PATCH v3 13/20] perf arm-spe: Add new function arm_spe_pkt_desc_event()
Date:   Thu, 22 Oct 2020 15:58:09 +0100
Message-Id: <20201022145816.14069-14-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201022145816.14069-1-leo.yan@linaro.org>
References: <20201022145816.14069-1-leo.yan@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch moves out the event packet parsing from arm_spe_pkt_desc()
to the new function arm_spe_pkt_desc_event().

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 .../arm-spe-decoder/arm-spe-pkt-decoder.c     | 136 ++++++++++--------
 1 file changed, 73 insertions(+), 63 deletions(-)

diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
index 6eebd30f3d78..8a6b50f32a52 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
@@ -266,6 +266,78 @@ static int arm_spe_pkt_snprintf(char **buf_p, size_t *blen,
 	return ret;
 }
 
+static int arm_spe_pkt_desc_event(const struct arm_spe_pkt *packet,
+				  char *buf, size_t buf_len)
+{
+	u64 payload = packet->payload;
+	size_t blen = buf_len;
+	int ret;
+
+	ret = arm_spe_pkt_snprintf(&buf, &blen, "EV");
+	if (ret < 0)
+		return ret;
+
+	if (payload & 0x1) {
+		ret = arm_spe_pkt_snprintf(&buf, &blen, " EXCEPTION-GEN");
+		if (ret < 0)
+			return ret;
+	}
+	if (payload & 0x2) {
+		ret = arm_spe_pkt_snprintf(&buf, &blen, " RETIRED");
+		if (ret < 0)
+			return ret;
+	}
+	if (payload & 0x4) {
+		ret = arm_spe_pkt_snprintf(&buf, &blen, " L1D-ACCESS");
+		if (ret < 0)
+			return ret;
+	}
+	if (payload & 0x8) {
+		ret = arm_spe_pkt_snprintf(&buf, &blen, " L1D-REFILL");
+		if (ret < 0)
+			return ret;
+	}
+	if (payload & 0x10) {
+		ret = arm_spe_pkt_snprintf(&buf, &blen, " TLB-ACCESS");
+		if (ret < 0)
+			return ret;
+	}
+	if (payload & 0x20) {
+		ret = arm_spe_pkt_snprintf(&buf, &blen, " TLB-REFILL");
+		if (ret < 0)
+			return ret;
+	}
+	if (payload & 0x40) {
+		ret = arm_spe_pkt_snprintf(&buf, &blen, " NOT-TAKEN");
+		if (ret < 0)
+			return ret;
+	}
+	if (payload & 0x80) {
+		ret = arm_spe_pkt_snprintf(&buf, &blen, " MISPRED");
+		if (ret < 0)
+			return ret;
+	}
+	if (packet->index > 1) {
+		if (payload & 0x100) {
+			ret = arm_spe_pkt_snprintf(&buf, &blen, " LLC-ACCESS");
+			if (ret < 0)
+				return ret;
+		}
+		if (payload & 0x200) {
+			ret = arm_spe_pkt_snprintf(&buf, &blen, " LLC-REFILL");
+			if (ret < 0)
+				return ret;
+		}
+		if (payload & 0x400) {
+			ret = arm_spe_pkt_snprintf(&buf, &blen, " REMOTE-ACCESS");
+			if (ret < 0)
+				return ret;
+		}
+	}
+
+	return buf_len - blen;
+}
+
 static int arm_spe_pkt_desc_addr(const struct arm_spe_pkt *packet,
 				 char *buf, size_t buf_len)
 {
@@ -344,69 +416,7 @@ int arm_spe_pkt_desc(const struct arm_spe_pkt *packet, char *buf,
 	case ARM_SPE_END:
 		return arm_spe_pkt_snprintf(&buf, &blen, "%s", name);
 	case ARM_SPE_EVENTS:
-		ret = arm_spe_pkt_snprintf(&buf, &blen, "EV");
-		if (ret < 0)
-			return ret;
-
-		if (payload & 0x1) {
-			ret = arm_spe_pkt_snprintf(&buf, &blen, " EXCEPTION-GEN");
-			if (ret < 0)
-				return ret;
-		}
-		if (payload & 0x2) {
-			ret = arm_spe_pkt_snprintf(&buf, &blen, " RETIRED");
-			if (ret < 0)
-				return ret;
-		}
-		if (payload & 0x4) {
-			ret = arm_spe_pkt_snprintf(&buf, &blen, " L1D-ACCESS");
-			if (ret < 0)
-				return ret;
-		}
-		if (payload & 0x8) {
-			ret = arm_spe_pkt_snprintf(&buf, &blen, " L1D-REFILL");
-			if (ret < 0)
-				return ret;
-		}
-		if (payload & 0x10) {
-			ret = arm_spe_pkt_snprintf(&buf, &blen, " TLB-ACCESS");
-			if (ret < 0)
-				return ret;
-		}
-		if (payload & 0x20) {
-			ret = arm_spe_pkt_snprintf(&buf, &blen, " TLB-REFILL");
-			if (ret < 0)
-				return ret;
-		}
-		if (payload & 0x40) {
-			ret = arm_spe_pkt_snprintf(&buf, &blen, " NOT-TAKEN");
-			if (ret < 0)
-				return ret;
-		}
-		if (payload & 0x80) {
-			ret = arm_spe_pkt_snprintf(&buf, &blen, " MISPRED");
-			if (ret < 0)
-				return ret;
-		}
-		if (idx > 1) {
-			if (payload & 0x100) {
-				ret = arm_spe_pkt_snprintf(&buf, &blen, " LLC-ACCESS");
-				if (ret < 0)
-					return ret;
-			}
-			if (payload & 0x200) {
-				ret = arm_spe_pkt_snprintf(&buf, &blen, " LLC-REFILL");
-				if (ret < 0)
-					return ret;
-			}
-			if (payload & 0x400) {
-				ret = arm_spe_pkt_snprintf(&buf, &blen, " REMOTE-ACCESS");
-				if (ret < 0)
-					return ret;
-			}
-		}
-		return buf_len - blen;
-
+		return arm_spe_pkt_desc_event(packet, buf, buf_len);
 	case ARM_SPE_OP_TYPE:
 		switch (idx) {
 		case 0:
-- 
2.17.1

