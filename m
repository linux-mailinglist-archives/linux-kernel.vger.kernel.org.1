Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E078D29A307
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 04:12:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2443519AbgJ0DLm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 23:11:42 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:41162 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2442787AbgJ0DLl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 23:11:41 -0400
Received: by mail-pl1-f194.google.com with SMTP id w11so15099pll.8
        for <linux-kernel@vger.kernel.org>; Mon, 26 Oct 2020 20:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=crisq9nzmgUKIAMb73kKujg2PLEpBZzgpVTaowxUN5w=;
        b=I8tBpcktQU6gvBwervY2L53MCKPTmx0iib9VvlPBAvOWTVfd9iYNQ6Shds+QfnwoYu
         zfirjWmGmA/IQ3Uq2Bm66fH6DfbxbOTcjsnfVR5YTtDmqvceOukoL17m8D+gCaC7X2Y7
         WYWWlizThqLkw1gYOnFVSSayczVvvBZj4HuF/sT3C2HB1gSuTDVRpe6tqfoliq3qjRFC
         3RP1i6gHkBhV6krj7KD6STz4NDp9kSMAu3QB+QxP3OilpofaBruMEHId4Y4kwhoy/uWc
         Qt4tNgrbJPTfGWRucUa6SEUonwKU0L8LeulS2L7tok7byzHUxerPs8dJtUYjfPWBhEGl
         e4fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=crisq9nzmgUKIAMb73kKujg2PLEpBZzgpVTaowxUN5w=;
        b=MljF3joJTu7OFrW0V7BQNP8ucDXENXKaAXE7Ol4YEXZuxOuivufTXCRnluzeZ+s05D
         pkgIKOqG6FbLamQylp22E3QBJiyK/WgarmGOi7NvQopd0nMGdfhR6o0/RRsTmX2T1Rk9
         DNjtsfaFADad/Op+wlpwTxi7mCyF7ZV+aKN1l59hoAhbw127LXhUUwLAlyB4p6hAnMY/
         /5AShFS2UZFg9GaWoUjKi73H3pkmtHR7Kw6TFGnXcTxoZnqQAuTeKzN7L51njrhwERbv
         gbzMrmaQPB6yhLlSFyb5BRqlsEEWhLruKKjrauwi+SmI2IWys7I+DjIbtmoFQJqEHPV/
         ZIZw==
X-Gm-Message-State: AOAM5317Hz5NLDRQwWy6oSBFhc9t0QWhFD8HuG9tiWVXi25SpzpNyTvF
        G3RWBu6tzxtGLjZ9/LscWh8i8g==
X-Google-Smtp-Source: ABdhPJwZZRTpY3TEvJiKDBRrWuL5jvuvbGQaBOgSy/VwBzTDnfuckusJEulx8X9gIAuTf8gGpZqWDA==
X-Received: by 2002:a17:90a:cb92:: with SMTP id a18mr89144pju.136.1603768298693;
        Mon, 26 Oct 2020 20:11:38 -0700 (PDT)
Received: from localhost ([2600:3c01::f03c:91ff:fe8a:bb03])
        by smtp.gmail.com with ESMTPSA id 204sm175453pfz.74.2020.10.26.20.11.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 26 Oct 2020 20:11:38 -0700 (PDT)
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
Subject: [PATCH v4 17/21] perf arm-spe: Add new function arm_spe_pkt_desc_op_type()
Date:   Tue, 27 Oct 2020 11:09:13 +0800
Message-Id: <20201027030917.15404-18-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201027030917.15404-1-leo.yan@linaro.org>
References: <20201027030917.15404-1-leo.yan@linaro.org>
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
 .../arm-spe-decoder/arm-spe-pkt-decoder.c     | 122 ++++++++++--------
 1 file changed, 66 insertions(+), 56 deletions(-)

diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
index 74f5fcebdc56..7c6a0caed976 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
@@ -336,6 +336,70 @@ static int arm_spe_pkt_desc_event(const struct arm_spe_pkt *packet,
 	return buf_len - blen;
 }
 
+static int arm_spe_pkt_desc_op_type(const struct arm_spe_pkt *packet,
+				    char *buf, size_t buf_len)
+{
+	int ret, idx = packet->index;
+	unsigned long long payload = packet->payload;
+	size_t blen = buf_len;
+
+	switch (idx) {
+	case 0:
+		return arm_spe_pkt_snprintf(&buf, &blen,
+				payload & 0x1 ? "COND-SELECT" : "INSN-OTHER");
+	case 1:
+		ret = arm_spe_pkt_snprintf(&buf, &blen,
+					   payload & 0x1 ? "ST" : "LD");
+		if (ret < 0)
+			return ret;
+
+		if (payload & 0x2) {
+			if (payload & 0x4) {
+				ret = arm_spe_pkt_snprintf(&buf, &blen, " AT");
+				if (ret < 0)
+					return ret;
+			}
+			if (payload & 0x8) {
+				ret = arm_spe_pkt_snprintf(&buf, &blen, " EXCL");
+				if (ret < 0)
+					return ret;
+			}
+			if (payload & 0x10) {
+				ret = arm_spe_pkt_snprintf(&buf, &blen, " AR");
+				if (ret < 0)
+					return ret;
+			}
+		} else if (payload & 0x4) {
+			ret = arm_spe_pkt_snprintf(&buf, &blen, " SIMD-FP");
+			if (ret < 0)
+				return ret;
+		}
+
+		return buf_len - blen;
+
+	case 2:
+		ret = arm_spe_pkt_snprintf(&buf, &blen, "B");
+		if (ret < 0)
+			return ret;
+
+		if (payload & 0x1) {
+			ret = arm_spe_pkt_snprintf(&buf, &blen, " COND");
+			if (ret < 0)
+				return ret;
+		}
+		if (payload & 0x2) {
+			ret = arm_spe_pkt_snprintf(&buf, &blen, " IND");
+			if (ret < 0)
+				return ret;
+		}
+
+		return buf_len - blen;
+
+	default:
+		return 0;
+	}
+}
+
 static int arm_spe_pkt_desc_addr(const struct arm_spe_pkt *packet,
 				 char *buf, size_t buf_len)
 {
@@ -403,7 +467,7 @@ static int arm_spe_pkt_desc_counter(const struct arm_spe_pkt *packet,
 int arm_spe_pkt_desc(const struct arm_spe_pkt *packet, char *buf,
 		     size_t buf_len)
 {
-	int ret, idx = packet->index;
+	int idx = packet->index;
 	unsigned long long payload = packet->payload;
 	const char *name = arm_spe_pkt_name(packet->type);
 	size_t blen = buf_len;
@@ -416,61 +480,7 @@ int arm_spe_pkt_desc(const struct arm_spe_pkt *packet, char *buf,
 	case ARM_SPE_EVENTS:
 		return arm_spe_pkt_desc_event(packet, buf, buf_len);
 	case ARM_SPE_OP_TYPE:
-		switch (idx) {
-		case 0:
-			return arm_spe_pkt_snprintf(&buf, &blen,
-					payload & 0x1 ? "COND-SELECT" : "INSN-OTHER");
-		case 1:
-			ret = arm_spe_pkt_snprintf(&buf, &blen,
-						   payload & 0x1 ? "ST" : "LD");
-			if (ret < 0)
-				return ret;
-
-			if (payload & 0x2) {
-				if (payload & 0x4) {
-					ret = arm_spe_pkt_snprintf(&buf, &blen, " AT");
-					if (ret < 0)
-						return ret;
-				}
-				if (payload & 0x8) {
-					ret = arm_spe_pkt_snprintf(&buf, &blen, " EXCL");
-					if (ret < 0)
-						return ret;
-				}
-				if (payload & 0x10) {
-					ret = arm_spe_pkt_snprintf(&buf, &blen, " AR");
-					if (ret < 0)
-						return ret;
-				}
-			} else if (payload & 0x4) {
-				ret = arm_spe_pkt_snprintf(&buf, &blen, " SIMD-FP");
-				if (ret < 0)
-					return ret;
-			}
-
-			return buf_len - blen;
-
-		case 2:
-			ret = arm_spe_pkt_snprintf(&buf, &blen, "B");
-			if (ret < 0)
-				return ret;
-
-			if (payload & 0x1) {
-				ret = arm_spe_pkt_snprintf(&buf, &blen, " COND");
-				if (ret < 0)
-					return ret;
-			}
-			if (payload & 0x2) {
-				ret = arm_spe_pkt_snprintf(&buf, &blen, " IND");
-				if (ret < 0)
-					return ret;
-			}
-
-			return buf_len - blen;
-
-		default:
-			return 0;
-		}
+		return arm_spe_pkt_desc_op_type(packet, buf, buf_len);
 	case ARM_SPE_DATA_SOURCE:
 	case ARM_SPE_TIMESTAMP:
 		return arm_spe_pkt_snprintf(&buf, &blen, "%s %lld", name, payload);
-- 
2.17.1

