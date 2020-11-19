Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 074222B9621
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 16:26:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728596AbgKSPZX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 10:25:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728588AbgKSPZW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 10:25:22 -0500
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25DDDC0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 07:25:22 -0800 (PST)
Received: by mail-pl1-x644.google.com with SMTP id 18so3089542pli.13
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 07:25:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=aO1R9Y4e/9JxiW3PDrlAXdoWdQwZ1ng9F7l0GuU1DYo=;
        b=ZXDynXQlWT9/QOLDZt7tXFzX5/a6ydFhHOVsUL4a0ccs8uVxLsIj118EfJXTOSD38n
         II5g/3+gZe+vRdME61TMoroYTW69qolhb1SfUN+1tzgtMAKk9djwm6cLZWv2/7qUzUFQ
         hYoi8T2gYRcWNMgFHQvbeVFNmvrmxk84F34rZcPtB1Sp9BqVGzdKGiiYBM3kEsvvyDiT
         XhZJDNeXCgepgR2m1TVU7qb4pSJJWGvKOGlvJ9qoW9G0cMPE87oo7jVkadM38wVtugvJ
         56YnyCB7RhPUXjevKQCR9iNlm9GSsbL51Wklnh5rt6QlBEAP4R2Rhgey7Uy/lE/M2+WZ
         0nCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=aO1R9Y4e/9JxiW3PDrlAXdoWdQwZ1ng9F7l0GuU1DYo=;
        b=gkM+SguA97FRpV3vUtlsLOS1awz3dWBHygouAfdbOuAP29zUFHFfyXE3azWbhz54hC
         4gyoa9HXpXImkpX71R5Y00tUhrokSpg35S+YBnx6en0No49rnFK4SIf+KTF9IRz+GABL
         hSNg6oApbFDKVHFFdxWdA+0wFlE7VXbkcdhj6qendjm5tLbZdoHtcINuBT8gXju0ELuy
         qQeikibqSqqnkGiR39HGViZlT/sRtgFHdCCWhNqn7klPTd/5iDPDqkFlbGvutQTtevoH
         YHv4/ZqS0jMcseHjfQfQ3NreKNID+Vdsc9iaUhNchOuK2TH+xAT8JbMDBis2ekMg4HHO
         S9qA==
X-Gm-Message-State: AOAM5331WbRwi+YOXcydiGxjDn6g4UmfLzrRCAYP777xleDW8qsnnryh
        5fOC5LDnttBNAGl7tWmsoJjNbA==
X-Google-Smtp-Source: ABdhPJwqTfqoFRngQWcM0UV4vHX8tj4w6rAzql0ryte75Ee/zzR4lqvBqAIfE1nshhVZqVAK20lwtA==
X-Received: by 2002:a17:902:6b08:b029:d6:c471:8b5b with SMTP id o8-20020a1709026b08b02900d6c4718b5bmr9565015plk.78.1605799521690;
        Thu, 19 Nov 2020 07:25:21 -0800 (PST)
Received: from localhost ([45.137.216.7])
        by smtp.gmail.com with ESMTPSA id c193sm117978pfb.78.2020.11.19.07.25.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 19 Nov 2020 07:25:21 -0800 (PST)
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
Subject: [PATCH v9 07/16] perf arm-spe: Add new function arm_spe_pkt_desc_counter()
Date:   Thu, 19 Nov 2020 23:24:32 +0800
Message-Id: <20201119152441.6972-8-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201119152441.6972-1-leo.yan@linaro.org>
References: <20201119152441.6972-1-leo.yan@linaro.org>
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
index 978f5551b82c..397ade5ffdeb 100644
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
+	arm_spe_pkt_out_string(&err, &buf, &buf_len, "%s %d ", name,
+			       (unsigned short)payload);
+
+	switch (packet->index) {
+	case 0:
+		arm_spe_pkt_out_string(&err, &buf, &buf_len, "TOT");
+		break;
+	case 1:
+		arm_spe_pkt_out_string(&err, &buf, &buf_len, "ISSUE");
+		break;
+	case 2:
+		arm_spe_pkt_out_string(&err, &buf, &buf_len, "XLAT");
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
-		arm_spe_pkt_out_string(&err, &buf, &blen, "%s %d ", name,
-				       (unsigned short)payload);
-		switch (idx) {
-		case 0:
-			arm_spe_pkt_out_string(&err, &buf, &blen, "TOT");
-			break;
-		case 1:
-			arm_spe_pkt_out_string(&err, &buf, &blen, "ISSUE");
-			break;
-		case 2:
-			arm_spe_pkt_out_string(&err, &buf, &blen, "XLAT");
-			break;
-		default:
-			break;
-		}
+		err = arm_spe_pkt_desc_counter(packet, buf, buf_len);
 		break;
 	default:
 		/* Unknown packet type */
-- 
2.17.1

