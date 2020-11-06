Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AC7D2A8C38
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 02:43:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733172AbgKFBmy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 20:42:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733080AbgKFBmx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 20:42:53 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C343C0613CF
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 17:42:53 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id e21so2679968pgr.11
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 17:42:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5wobiTpSQ3PfNJO9p2152mN4YxsPTZnRlLoKx/cyGVU=;
        b=OAMZM9GfasBXM8GFRY1BpHJi7eB2AReZC0oKp+tlPimtnvrSSc6Z8UIzZCxDAMThDT
         dQZOoMclMNT5/iQOFgM7W1gq9+nHo0tLeO6Cq5VsA6oSICT/qutHgT6iI74Ws/rh4vQB
         +B4tlqEJTZogdUY2uguGwPermySANVXmLXsidagneRhQhgO+dzDs9ilXF+ChEUwI/p9A
         Gtp9h9ssaCVHtrFfPOA5+OMSXlBszc097PTUFjoEJiaOhE+YGERQq6QDbFDzMh5Yzpcz
         ES6v9Eu7ILV9jt7krsgsWM7uJJS9bfh8c1JIMDVAoXkJiiVuiEzXb074nid25K/z5vQg
         5c4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5wobiTpSQ3PfNJO9p2152mN4YxsPTZnRlLoKx/cyGVU=;
        b=ZLH326dY9k6DInORc+xHt47n6c3zUYQLwyoTTt73MDQDR/CuY4ITR6Avv4W7aIrwlH
         Oo10DC3x5rdRb8UzOf7tObx2GG4YuPdQVDSfr1ZUn2Vk04k9ZI25kFUh/AXEkixIorVQ
         jINy/XQIUo878nCoPzkCmLu13PrqN/g9j7jFIw/gKiAaNsuYd4D1IBhU6uw5CYuGdZj+
         kGCmiF7tIPd4J1l3tmXwjskTC8PuNSUy+GPX0BzsMP3MgdD/DeSvVlAY6KCvS9eYYJIZ
         ATOWFBgWEfzGbyzf30eaLSapnALx6TyTfs3qVWVMU+zyVNe2qwiujNBmdKLaeQim7N3M
         A70w==
X-Gm-Message-State: AOAM532PmnRO+yG2BYHQ2oPbD+gyGbzbvkPJnVWe25yl7QZwmv9jRvyG
        nOfGUZNF4cv0Urjw8u3zqT9OGQ==
X-Google-Smtp-Source: ABdhPJyiqst+LzwyqPTGmbWM09C+s7bW7cFMoRPGAbINZcZLmJDeoa4Z8i75rUW3lRrOO6yGYiAs6w==
X-Received: by 2002:a63:1709:: with SMTP id x9mr5096242pgl.334.1604626972569;
        Thu, 05 Nov 2020 17:42:52 -0800 (PST)
Received: from localhost ([2400:8904::f03c:91ff:fe8a:adf7])
        by smtp.gmail.com with ESMTPSA id m13sm3618557pjr.30.2020.11.05.17.42.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 05 Nov 2020 17:42:52 -0800 (PST)
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
Subject: [PATCH v7 09/22] perf arm-spe: Add new function arm_spe_pkt_desc_addr()
Date:   Fri,  6 Nov 2020 09:41:23 +0800
Message-Id: <20201106014136.14103-10-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201106014136.14103-1-leo.yan@linaro.org>
References: <20201106014136.14103-1-leo.yan@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch moves out the address parsing code from arm_spe_pkt_desc()
and uses the new introduced function arm_spe_pkt_desc_addr() to process
address packet.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Reviewed-by: Andre Przywara <andre.przywara@arm.com>
---
 .../arm-spe-decoder/arm-spe-pkt-decoder.c     | 64 +++++++++++--------
 1 file changed, 38 insertions(+), 26 deletions(-)

diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
index 6608a73a7cbe..81f19966643d 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
@@ -288,10 +288,46 @@ static int arm_spe_pkt_snprintf(int *err, char **buf_p, size_t *blen,
 	return ret;
 }
 
+static int arm_spe_pkt_desc_addr(const struct arm_spe_pkt *packet,
+				 char *buf, size_t buf_len)
+{
+	int ns, el, idx = packet->index;
+	u64 payload = packet->payload;
+	int err = 0;
+
+	switch (idx) {
+	case 0:
+	case 1:
+		ns = !!(packet->payload & NS_FLAG);
+		el = (packet->payload & EL_FLAG) >> 61;
+		payload &= ~(0xffULL << 56);
+		arm_spe_pkt_snprintf(&err, &buf, &buf_len,
+				"%s 0x%llx el%d ns=%d",
+				(idx == 1) ? "TGT" : "PC", payload, el, ns);
+		break;
+	case 2:
+		arm_spe_pkt_snprintf(&err, &buf, &buf_len,
+				     "VA 0x%llx", payload);
+		break;
+	case 3:
+		ns = !!(packet->payload & NS_FLAG);
+		payload &= ~(0xffULL << 56);
+		arm_spe_pkt_snprintf(&err, &buf, &buf_len,
+				     "PA 0x%llx ns=%d", payload, ns);
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
 int arm_spe_pkt_desc(const struct arm_spe_pkt *packet, char *buf,
 		     size_t buf_len)
 {
-	int ns, el, idx = packet->index;
+	int idx = packet->index;
 	unsigned long long payload = packet->payload;
 	const char *name = arm_spe_pkt_name(packet->type);
 	char *buf_orig = buf;
@@ -373,31 +409,7 @@ int arm_spe_pkt_desc(const struct arm_spe_pkt *packet, char *buf,
 		arm_spe_pkt_snprintf(&err, &buf, &blen, "%s %lld", name, payload);
 		break;
 	case ARM_SPE_ADDRESS:
-		switch (idx) {
-		case 0:
-		case 1:
-			ns = !!(packet->payload & NS_FLAG);
-			el = (packet->payload & EL_FLAG) >> 61;
-			payload &= ~(0xffULL << 56);
-			arm_spe_pkt_snprintf(&err, &buf, &blen,
-					"%s 0x%llx el%d ns=%d",
-				        (idx == 1) ? "TGT" : "PC", payload, el, ns);
-			break;
-		case 2:
-			arm_spe_pkt_snprintf(&err, &buf, &blen,
-					     "VA 0x%llx", payload);
-			break;
-		case 3:
-			ns = !!(packet->payload & NS_FLAG);
-			payload &= ~(0xffULL << 56);
-			arm_spe_pkt_snprintf(&err, &buf, &blen,
-					     "PA 0x%llx ns=%d", payload, ns);
-			break;
-		default:
-			/* Unknown index */
-			err = -1;
-			break;
-		}
+		err = arm_spe_pkt_desc_addr(packet, buf, buf_len);
 		break;
 	case ARM_SPE_CONTEXT:
 		arm_spe_pkt_snprintf(&err, &buf, &blen, "%s 0x%lx el%d",
-- 
2.17.1

