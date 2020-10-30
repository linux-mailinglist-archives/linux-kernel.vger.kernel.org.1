Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B81529FBDD
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 03:59:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbgJ3C6z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 22:58:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726484AbgJ3C6t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 22:58:49 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 541E9C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 19:58:49 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id a200so4018388pfa.10
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 19:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pS9XdOLbJHpuKlHgCrbW+hsWKUwN/7ia83bAZD2a/rU=;
        b=s4HtKNU8OyZs886MweCgXt/hxbrPpv9/lhviss7FzgUcvd3yRtyAaDIDIcHe19/4uW
         c3Kur73G1SV3BhqPDKPzI1oLVJqt6sCeziaJ3XguaZPvS9H+EcxtfGkt2ejDw2dcXHZc
         k62zcZGylzLSDLiM9DWhaE8ggRKbRJr67mPjHYsPQ9uenqPpX8vA/NaPMd9ngMxqDqmw
         M5gP8B408lPSUuovjBqVPWc7KMNzy54e1+ExA32ONXiD73gkF3QNXhxyuQfGyI1NtJUf
         XFdSjITy4JAMcuJzWo0tmvQ//dBS3sycmUXTg7nzcyYPOmNZJzJvFlvPDnmWZTArTOLX
         eD6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pS9XdOLbJHpuKlHgCrbW+hsWKUwN/7ia83bAZD2a/rU=;
        b=HvKvsuH8Zqd+a2IE3FieGUxR0X4cP4NJwgpO4SkMRlprB8kjdvvvRjz5+gmxPHfzF8
         ahJ3JiCsigNx61OaX0JRfWwuisVO97gM8fyy0P0poBy0o9VNe2LLoZUcFtCsD5Waux0G
         bSmiIvLsUQ8tHnp0MVAn0Y47ssXFsLaXgNA1ztgF9g9fD2rW8zKby/ANZBoOI0uQ8EJT
         grb9hCzrh4Bzvs81NQHgqy106Xu4aH2v+8FHGAR5lSx4iTt5yA3Iw2AvZlhs+hkGBH/s
         fCV2GQhbIMVpwKsyyXa6VTdywj5iuA2Ma+Ece+CVJUl+zJD/BOjPseYEpayZSmU31ep4
         s1/A==
X-Gm-Message-State: AOAM530RPH4XWw0Z1gpk7Sfp0qKs+lPo5uShivaC9N9xPvmDRM+ipxJ/
        pzjcB1JRrS8T4JZxyV25yeIqNw==
X-Google-Smtp-Source: ABdhPJySGmkKntAwQ5bCrg7SCg3n9M6viJDGlqaWrHaVQuzBv+bEpXTzAcKmsL4rpCCcgWlrHwvQEQ==
X-Received: by 2002:a17:90a:8c94:: with SMTP id b20mr219607pjo.55.1604026728928;
        Thu, 29 Oct 2020 19:58:48 -0700 (PDT)
Received: from localhost ([2600:3c01::f03c:91ff:fe8a:bb03])
        by smtp.gmail.com with ESMTPSA id gb13sm1192339pjb.55.2020.10.29.19.58.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 29 Oct 2020 19:58:48 -0700 (PDT)
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
Subject: [PATCH v6 12/21] perf arm-spe: Add new function arm_spe_pkt_desc_counter()
Date:   Fri, 30 Oct 2020 10:57:15 +0800
Message-Id: <20201030025724.19157-13-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201030025724.19157-1-leo.yan@linaro.org>
References: <20201030025724.19157-1-leo.yan@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch moves out the counter packet parsing code from
arm_spe_pkt_desc() to the new function arm_spe_pkt_desc_counter().

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Reviewed-by: Andre Przywara <andre.przywara@arm.com>
---
 .../arm-spe-decoder/arm-spe-pkt-decoder.c     | 48 +++++++++++--------
 1 file changed, 29 insertions(+), 19 deletions(-)

diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
index e4ab43ba80bd..403eb15c13d7 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
@@ -301,6 +301,34 @@ static int arm_spe_pkt_desc_addr(const struct arm_spe_pkt *packet,
 	}
 }
 
+static int arm_spe_pkt_desc_counter(const struct arm_spe_pkt *packet,
+				    char *buf, size_t buf_len)
+{
+	u64 payload = packet->payload;
+	const char *name = arm_spe_pkt_name(packet->type);
+	size_t blen = buf_len;
+	int err = 0;
+
+	arm_spe_pkt_snprintf(&err, &buf, &blen, "%s %d ", name,
+			     (unsigned short)payload);
+
+	switch (packet->index) {
+	case 0:
+		arm_spe_pkt_snprintf(&err, &buf, &blen, "TOT");
+		break;
+	case 1:
+		arm_spe_pkt_snprintf(&err, &buf, &blen, "ISSUE");
+		break;
+	case 2:
+		arm_spe_pkt_snprintf(&err, &buf, &blen, "XLAT");
+		break;
+	default:
+		break;
+	}
+
+	return err ?: (int)(buf_len - blen);
+}
+
 int arm_spe_pkt_desc(const struct arm_spe_pkt *packet, char *buf,
 		     size_t buf_len)
 {
@@ -388,25 +416,7 @@ int arm_spe_pkt_desc(const struct arm_spe_pkt *packet, char *buf,
 		return arm_spe_pkt_snprintf(&err, &buf, &blen, "%s 0x%lx el%d",
 					    name, (unsigned long)payload, idx + 1);
 	case ARM_SPE_COUNTER:
-		arm_spe_pkt_snprintf(&err, &buf, &blen, "%s %d ", name,
-				     (unsigned short)payload);
-
-		switch (idx) {
-		case 0:
-			arm_spe_pkt_snprintf(&err, &buf, &blen, "TOT");
-			break;
-		case 1:
-			arm_spe_pkt_snprintf(&err, &buf, &blen, "ISSUE");
-			break;
-		case 2:
-			arm_spe_pkt_snprintf(&err, &buf, &blen, "XLAT");
-			break;
-		default:
-			break;
-		}
-
-		return err ?: (int)(buf_len - blen);
-
+		return arm_spe_pkt_desc_counter(packet, buf, buf_len);
 	default:
 		break;
 	}
-- 
2.17.1

