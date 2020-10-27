Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AE9829A304
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 04:11:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442571AbgJ0DLY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 23:11:24 -0400
Received: from mail-pj1-f49.google.com ([209.85.216.49]:33199 "EHLO
        mail-pj1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2411856AbgJ0DLX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 23:11:23 -0400
Received: by mail-pj1-f49.google.com with SMTP id k8so111468pjd.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Oct 2020 20:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=c4Lxyx3eB5SOmUrTLzWQBYrHkU0UwyY3tpdyivXHGSY=;
        b=LcetkvqduAwpUzwxvn7hg3toXq1On4lTpVWw5eokKVNHK4olCAV1LUHzPwjtfxttHj
         /bcSCk/cTP3Nc3OxWpbaX8lBO8OVf8LFwWPuYkZWsYtmMi2VYbpXAongJbrBUgDxMTRV
         M1CZ4NL/Z8SQYae/i5+jqfQ1KYgMQNFxgpYDAijJCjruwsDKL81XnM9EZPJZzCUMhP8D
         v9O4FT3c0s1R71Xx5NQnGIYEWqKZtr4w8ifHHJimOf49KNwYdMrSEYTRYmKrpn8jDcks
         RNDWtXaMPQs+WIw9ta/AH3A18eL5i70s0dqprp+FQd5vZYF3e/cZPVXWDoojwf93zEOS
         Lz2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=c4Lxyx3eB5SOmUrTLzWQBYrHkU0UwyY3tpdyivXHGSY=;
        b=QuIS6tNCAQMUeoVgzo2TGBHnRXdx2QnI/x7h1xBliIBIiLqJtMfJKVrOGO6kafsF9q
         3jTKxtNFqdF3tLylqdZ/0b82WdUPafx3ktTvPZ0rckpDTRqnfQ26hIm19Xmn6BTM+SC9
         HjOT7RneMcgL15uMIDanaV7DsXcahIlcezIJzw43G/nOSnwAQNIEPlvLFdpIF6pIhWH2
         wmdzqEFSHn27UBp+fHjFxP6cfUqn+ySmh7IBqFCPL9B56UfcG6Ef6+z0oxmqYNFFWSoM
         NkmmLU8QKQ4edUd0itFzTiHfA6OorjnUOHm0duFQRKkLhMnUtsfdyV1505XzL1ZwXcUA
         RrUg==
X-Gm-Message-State: AOAM530kH9NDp+zWbnFBWCRxAe2WDL7n1stREfoTQ9KHeDGGaVtjmFzH
        AfO1l1DBWD+0WbDN+6IidGbJJg==
X-Google-Smtp-Source: ABdhPJw8lTqmmYBgNI/cceos/298QGR77Ulzt1Sq3U0BRZztk6xBqNxkEunWgIw+/0cIfDF/1yOXrw==
X-Received: by 2002:a17:90a:fd0a:: with SMTP id cv10mr58015pjb.151.1603768282205;
        Mon, 26 Oct 2020 20:11:22 -0700 (PDT)
Received: from localhost ([2600:3c01::f03c:91ff:fe8a:bb03])
        by smtp.gmail.com with ESMTPSA id f204sm163877pfa.189.2020.10.26.20.11.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 26 Oct 2020 20:11:21 -0700 (PDT)
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
Subject: [PATCH v4 14/21] perf arm-spe: Add new function arm_spe_pkt_desc_event()
Date:   Tue, 27 Oct 2020 11:09:10 +0800
Message-Id: <20201027030917.15404-15-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201027030917.15404-1-leo.yan@linaro.org>
References: <20201027030917.15404-1-leo.yan@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch moves out the event packet parsing from arm_spe_pkt_desc()
to the new function arm_spe_pkt_desc_event().

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Reviewed-by: Andre Przywara <andre.przywara@arm.com>
---
 .../arm-spe-decoder/arm-spe-pkt-decoder.c     | 136 ++++++++++--------
 1 file changed, 73 insertions(+), 63 deletions(-)

diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
index 4be649c26002..0522d28d731a 100644
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

