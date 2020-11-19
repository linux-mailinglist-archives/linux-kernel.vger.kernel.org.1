Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8847D2B9629
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 16:26:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728646AbgKSPZq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 10:25:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728635AbgKSPZn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 10:25:43 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E05BEC0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 07:25:42 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id m9so4504051pgb.4
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 07:25:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=eryxeHiT/KAiiehli8L2CTDZzn3NZF9ONjOE5TeFEnY=;
        b=MZAAWdRNUNIOzvxmmP8KXuqqfOb77EQoiC7N8URwtWbA2xYlrgxSBJm2R858TnbITz
         csuI7Xoa15s/xqB5q05QA2HmsXcc0t6IHoZkIeY9PA3bDgYsi78fa3gXW0fqMt+6nBoe
         GPbJo4pYi0TL4Ps43wnGH+97FnRbNdFm0yOoa3Aw8U+1ceU315C4fh4TBZjmnPahv+ck
         SmqMFHNjiZZ2JUC1F/pyuN4AwVgjyavlGSWNrwhenC+8zh1vT+qtUDsFLzvNhqy1Ufj9
         MfSQG5WiXs6mOr/KowyQbzvczHDCD+H3eUly9yuGR318+hz3K4JQXMwGTFylbcrcuAbz
         85aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=eryxeHiT/KAiiehli8L2CTDZzn3NZF9ONjOE5TeFEnY=;
        b=pm9+VgqfEwrTghyNc53kZnMtq1SEoZ9GWaIT2y4kCc8S3WCnec8GmSInlhvYg4yMgt
         90CpjAag0LUD53caJ5etaBIQGqzZcwTbaNIh4N2xJGHUuCd9i3P6zXjOhDEdycpq56QP
         HdJlPbL838eRyWg35nURCsa/QNeWFrcYSCzxYW60X35BU9jZRDwVNgr9/D5kqTo7xfJ1
         DQhhQvmO/ujs2l8S6mLCm32lIC8kSGF5DQbXuAOyY4Dtkv83rc1EW31+YJUw1uYr4tS/
         Gw3CS5lnSLLl+m9xFwA7mFYQokMCc9iyECgpBeB4PQzW3twvKA4akNEssyfdRyLGWfTR
         7tdg==
X-Gm-Message-State: AOAM532nh9Id1E3nrNUNon+U4yli+VS5OAsayztVv9lYFn7RnzpB1sgV
        0XvL/+dAychzEompIkjno6YTZA==
X-Google-Smtp-Source: ABdhPJzPAmmCs4kh1UJ5ecGJmST0qv0tBkNJ71nexwuD/JbbmXrqsX/Q39s+LchXBpC/dEFiNbh5MA==
X-Received: by 2002:aa7:9a5b:0:b029:197:c897:23b4 with SMTP id x27-20020aa79a5b0000b0290197c89723b4mr1703530pfj.77.1605799542382;
        Thu, 19 Nov 2020 07:25:42 -0800 (PST)
Received: from localhost ([45.137.216.7])
        by smtp.gmail.com with ESMTPSA id f1sm118013pfc.56.2020.11.19.07.25.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 19 Nov 2020 07:25:41 -0800 (PST)
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
Subject: [PATCH v9 12/16] perf arm-spe: Add new function arm_spe_pkt_desc_op_type()
Date:   Thu, 19 Nov 2020 23:24:37 +0800
Message-Id: <20201119152441.6972-13-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201119152441.6972-1-leo.yan@linaro.org>
References: <20201119152441.6972-1-leo.yan@linaro.org>
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
 .../arm-spe-decoder/arm-spe-pkt-decoder.c     | 79 +++++++++++--------
 1 file changed, 45 insertions(+), 34 deletions(-)

diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
index 88bcf7e5be76..d6c060f119b4 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
@@ -321,6 +321,50 @@ static int arm_spe_pkt_desc_event(const struct arm_spe_pkt *packet,
 	return err;
 }
 
+static int arm_spe_pkt_desc_op_type(const struct arm_spe_pkt *packet,
+				    char *buf, size_t buf_len)
+{
+	u64 payload = packet->payload;
+	int err = 0;
+
+	switch (packet->index) {
+	case 0:
+		arm_spe_pkt_out_string(&err, &buf, &buf_len,
+				payload & 0x1 ? "COND-SELECT" : "INSN-OTHER");
+		break;
+	case 1:
+		arm_spe_pkt_out_string(&err, &buf, &buf_len,
+				       payload & 0x1 ? "ST" : "LD");
+
+		if (payload & 0x2) {
+			if (payload & 0x4)
+				arm_spe_pkt_out_string(&err, &buf, &buf_len, " AT");
+			if (payload & 0x8)
+				arm_spe_pkt_out_string(&err, &buf, &buf_len, " EXCL");
+			if (payload & 0x10)
+				arm_spe_pkt_out_string(&err, &buf, &buf_len, " AR");
+		} else if (payload & 0x4) {
+			arm_spe_pkt_out_string(&err, &buf, &buf_len, " SIMD-FP");
+		}
+		break;
+	case 2:
+		arm_spe_pkt_out_string(&err, &buf, &buf_len, "B");
+
+		if (payload & 0x1)
+			arm_spe_pkt_out_string(&err, &buf, &buf_len, " COND");
+		if (payload & 0x2)
+			arm_spe_pkt_out_string(&err, &buf, &buf_len, " IND");
+
+		break;
+	default:
+		/* Unknown index */
+		err = -1;
+		break;
+	}
+
+	return err;
+}
+
 static int arm_spe_pkt_desc_addr(const struct arm_spe_pkt *packet,
 				 char *buf, size_t buf_len)
 {
@@ -404,40 +448,7 @@ int arm_spe_pkt_desc(const struct arm_spe_pkt *packet, char *buf,
 		err = arm_spe_pkt_desc_event(packet, buf, buf_len);
 		break;
 	case ARM_SPE_OP_TYPE:
-		switch (idx) {
-		case 0:
-			arm_spe_pkt_out_string(&err, &buf, &blen,
-					payload & 0x1 ? "COND-SELECT" : "INSN-OTHER");
-			break;
-		case 1:
-			arm_spe_pkt_out_string(&err, &buf, &blen,
-					       payload & 0x1 ? "ST" : "LD");
-
-			if (payload & 0x2) {
-				if (payload & 0x4)
-					arm_spe_pkt_out_string(&err, &buf, &blen, " AT");
-				if (payload & 0x8)
-					arm_spe_pkt_out_string(&err, &buf, &blen, " EXCL");
-				if (payload & 0x10)
-					arm_spe_pkt_out_string(&err, &buf, &blen, " AR");
-			} else if (payload & 0x4) {
-				arm_spe_pkt_out_string(&err, &buf, &blen, " SIMD-FP");
-			}
-			break;
-		case 2:
-			arm_spe_pkt_out_string(&err, &buf, &blen, "B");
-
-			if (payload & 0x1)
-				arm_spe_pkt_out_string(&err, &buf, &blen, " COND");
-			if (payload & 0x2)
-				arm_spe_pkt_out_string(&err, &buf, &blen, " IND");
-
-			break;
-		default:
-			/* Unknown index */
-			err = -1;
-			break;
-		}
+		err = arm_spe_pkt_desc_op_type(packet, buf, buf_len);
 		break;
 	case ARM_SPE_DATA_SOURCE:
 	case ARM_SPE_TIMESTAMP:
-- 
2.17.1

