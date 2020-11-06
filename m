Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 671582A8C3D
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 02:43:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733246AbgKFBnV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 20:43:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733218AbgKFBnS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 20:43:18 -0500
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29E07C0613CF
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 17:43:18 -0800 (PST)
Received: by mail-pl1-x644.google.com with SMTP id t6so1669972plq.11
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 17:43:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OnwZfqydOPiZMPOM7RZO0LAw0DbjDr8laoX7giGuhaM=;
        b=MbFwgehNj1i7R70zzAyQ9940nm2jfkzX0G+LaqtrZ3mGk5eh4wiPMk0UCAJq7gsw4P
         7LI46mf2ZXV4uDtHcwXI6ezdrVX/6VGv8VCbhavx4qmQ7T61UjcYC3uwx39Bk6eecNc9
         V5pDJUaSWXmDnz2I60wa4kPBx1VEV8B2xU2/xwblpcJSbl58CsyOB3eBMfqeWd3d3xrK
         z705sKIbWSGRUKXaZkeQnVuLxcYXVxoBdGc+MVTCSXSsOrZchtcUxlvSVq4H5QzdDsM+
         IUo6pHzMwC8gowliiS2/x2G4C/C9Y91J3ichHWFD49CXrRLpcrAe+1alihr81P4/qUtm
         HhKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OnwZfqydOPiZMPOM7RZO0LAw0DbjDr8laoX7giGuhaM=;
        b=sW23pbtSZ6Sw8Z3ttcjh5y2dwTGW1wrWZ64BuLRY8fjj2ebiAkcyM5DcWjxTHyaCUc
         X5XPpCAWEUjRL6dXZV/iey3QXUS/ikaaS6CUGRY2ntYUWd/5YVqgI9McmZ4dKY9rCZVl
         lMe7oK1isQbOxCeXBpzX8Jj23KlkZ4uyWT+bw01onu2AM3ZU6m8Rw6aXRi3vEOfSWisg
         y57cBNzfoyy0JigL+VE1jCCQl2CwWdnwMXUF36Rjs+u4CUvTLzwSUTUMmzPW9l85K1X3
         ZUzYyvL2r4+bpC8hgZ0EYiPXXoy5GMpbe9peQ/M3HRuZhvfgmEkBWQpQKFOqBJoFRaDU
         rXyA==
X-Gm-Message-State: AOAM533IpsakwIK+JDPENIw88HQZBqKcOj2oubV1y0V8+Y/Y3J1WFiNW
        D5rectm1IE+D043/8m4d4Wr5uw==
X-Google-Smtp-Source: ABdhPJw8Da5QJCo4MfdPuqkr0tdM3XGvJGWjKUD0YaM55Gai5oG1n1FN5CwhQrG5vvk6lD5gwfKv5w==
X-Received: by 2002:a17:902:59cd:b029:d6:7656:af1 with SMTP id d13-20020a17090259cdb02900d676560af1mr4755568plj.43.1604626997715;
        Thu, 05 Nov 2020 17:43:17 -0800 (PST)
Received: from localhost ([2400:8904::f03c:91ff:fe8a:adf7])
        by smtp.gmail.com with ESMTPSA id h10sm3704465pgj.69.2020.11.05.17.43.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 05 Nov 2020 17:43:17 -0800 (PST)
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
Subject: [PATCH v7 13/22] perf arm-spe: Add new function arm_spe_pkt_desc_counter()
Date:   Fri,  6 Nov 2020 09:41:27 +0800
Message-Id: <20201106014136.14103-14-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201106014136.14103-1-leo.yan@linaro.org>
References: <20201106014136.14103-1-leo.yan@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch moves out the counter packet parsing code from
arm_spe_pkt_desc() to the new function arm_spe_pkt_desc_counter().

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Reviewed-by: Andre Przywara <andre.przywara@arm.com>
---
 .../arm-spe-decoder/arm-spe-pkt-decoder.c     | 43 ++++++++++++-------
 1 file changed, 28 insertions(+), 15 deletions(-)

diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
index 74be3a0d8556..ea769e555bf5 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
@@ -322,6 +322,33 @@ static int arm_spe_pkt_desc_addr(const struct arm_spe_pkt *packet,
 	return err;
 }
 
+static int arm_spe_pkt_desc_counter(const struct arm_spe_pkt *packet,
+				    char *buf, size_t buf_len)
+{
+	u64 payload = packet->payload;
+	const char *name = arm_spe_pkt_name(packet->type);
+	int err = 0;
+
+	arm_spe_pkt_snprintf(&err, &buf, &buf_len, "%s %d ", name,
+			     (unsigned short)payload);
+
+	switch (packet->index) {
+	case 0:
+		arm_spe_pkt_snprintf(&err, &buf, &buf_len, "TOT");
+		break;
+	case 1:
+		arm_spe_pkt_snprintf(&err, &buf, &buf_len, "ISSUE");
+		break;
+	case 2:
+		arm_spe_pkt_snprintf(&err, &buf, &buf_len, "XLAT");
+		break;
+	default:
+		break;
+	}
+
+	return err;
+}
+
 int arm_spe_pkt_desc(const struct arm_spe_pkt *packet, char *buf,
 		     size_t buf_len)
 {
@@ -414,21 +441,7 @@ int arm_spe_pkt_desc(const struct arm_spe_pkt *packet, char *buf,
 				     name, (unsigned long)payload, idx + 1);
 		break;
 	case ARM_SPE_COUNTER:
-		arm_spe_pkt_snprintf(&err, &buf, &blen, "%s %d ", name,
-				     (unsigned short)payload);
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
+		err = arm_spe_pkt_desc_counter(packet, buf, buf_len);
 		break;
 	default:
 		/* Unknown index */
-- 
2.17.1

