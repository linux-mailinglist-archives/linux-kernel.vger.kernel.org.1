Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D01CC2A8C46
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 02:44:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732778AbgKFBoJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 20:44:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730906AbgKFBoJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 20:44:09 -0500
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DDE1C0613CF
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 17:44:09 -0800 (PST)
Received: by mail-pl1-x642.google.com with SMTP id t18so1688633plo.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 17:44:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LdpHwvSwkAX8/TcN2Q3DBfSl2iYNX3eKpngvvP3QfSg=;
        b=TYJUBBG6bE/iN3iBsYcNHbfVUzHc4fa8mducTah0xVhmjgo/kOag3WbIHZjAcIPiN8
         VlbEE6k7sHB1Nvt5VydBapPo0RbNmVdivOUpMl6Zp+ammZDEGu7Q+hkRb9SWSn1RMQkf
         JQQNqvbF8b346EvhYDvixOvneG7pm5BeqifO8OHw/afGNboOpGku/RzQrzmeB2TGqExH
         DrB8GsNu6Mrg+kdm7il/QxXKoe+QvGIYInI1NFb6XgP8sAYGKxXAcnFR3yFBmH5iXGIU
         8Q00CN28JFoYb/KKhK8KV1rgQSX+mgIMT1yvVIth7lOF1lmHgaMKpUT2ku6EnZcTx3+M
         7oLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LdpHwvSwkAX8/TcN2Q3DBfSl2iYNX3eKpngvvP3QfSg=;
        b=GuEq4RgesAqfbRsjjrOPBuMwFxm008LD39PSZr9CYK9FOxMZ+Vkv/lbi/CrX7k50lX
         dmAkPR33H6fcAjTeVeCMBUnQgOkFytz5aalA+4ihyokJNbjsWguc+0pvFeFCFrZKsVcT
         PiniBSUkMbi81CYUju/nQIFiN6WR1tgxXW85WmJyjRHjMgzuekUxk9UPrZnp+4G6uP03
         UmCDgRAXUpGAdo6ftMfMYLrZ8A8q3zp2JCZ2ZOSQOwSqOiITp3iBrot/9MKc2oVb8gBE
         fZxhxIu8/+hM73ZgXseSGFqlme6WHAlpXdt+UeOlfPe85HCA5PNoYp6+G0lm07O4hW8O
         NVeA==
X-Gm-Message-State: AOAM5332eQhapEBB51kuYx9dIq1EHW4HHZ99+f9UA7CXzxqYgnAR3xvz
        E8+mcgYl6r6u0nrtWTlEAagMDA==
X-Google-Smtp-Source: ABdhPJxRv8p0+8fQfig9wHvvZ9at3C5opiRe/gO8Eg6c8yH5so77jo9P3gwnoF7MNzo5KKBhzPCeTQ==
X-Received: by 2002:a17:902:7281:b029:d6:c8e9:da75 with SMTP id d1-20020a1709027281b02900d6c8e9da75mr4519499pll.48.1604627048672;
        Thu, 05 Nov 2020 17:44:08 -0800 (PST)
Received: from localhost ([2400:8904::f03c:91ff:fe8a:adf7])
        by smtp.gmail.com with ESMTPSA id gm12sm3722804pjb.28.2020.11.05.17.44.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 05 Nov 2020 17:44:08 -0800 (PST)
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
Subject: [PATCH v7 21/22] perf arm_spe: Decode memory tagging properties
Date:   Fri,  6 Nov 2020 09:41:35 +0800
Message-Id: <20201106014136.14103-22-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201106014136.14103-1-leo.yan@linaro.org>
References: <20201106014136.14103-1-leo.yan@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andre Przywara <andre.przywara@arm.com>

When SPE records a physical address, it can additionally tag the event
with information from the Memory Tagging architecture extension.

Decode the two additional fields in the SPE event payload.

[leoy: Refined patch to use predefined macros]

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
Signed-off-by: Leo Yan <leo.yan@linaro.org>
Reviewed-by: Dave Martin <Dave.Martin@arm.com>
---
 tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c | 6 +++++-
 tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h | 2 ++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
index ec962a9bff78..4744048478ca 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
@@ -385,6 +385,7 @@ static int arm_spe_pkt_desc_addr(const struct arm_spe_pkt *packet,
 				 char *buf, size_t buf_len)
 {
 	int ns, el, idx = packet->index;
+	int ch, pat;
 	u64 payload = packet->payload;
 	int err = 0;
 
@@ -404,9 +405,12 @@ static int arm_spe_pkt_desc_addr(const struct arm_spe_pkt *packet,
 		break;
 	case SPE_ADDR_PKT_HDR_INDEX_DATA_PHYS:
 		ns = !!SPE_ADDR_PKT_GET_NS(payload);
+		ch = !!SPE_ADDR_PKT_GET_CH(payload);
+		pat = SPE_ADDR_PKT_GET_PAT(payload);
 		payload = SPE_ADDR_PKT_ADDR_GET_BYTES_0_6(payload);
 		arm_spe_pkt_snprintf(&err, &buf, &buf_len,
-				     "PA 0x%llx ns=%d", payload, ns);
+				     "PA 0x%llx ns=%d ch=%d pat=%x",
+				     payload, ns, ch, pat);
 		break;
 	default:
 		/* Unknown index */
diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
index 7032fc141ad4..1ad14885c2a1 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
@@ -73,6 +73,8 @@ struct arm_spe_pkt {
 
 #define SPE_ADDR_PKT_GET_NS(v)			(((v) & BIT_ULL(63)) >> 63)
 #define SPE_ADDR_PKT_GET_EL(v)			(((v) & GENMASK_ULL(62, 61)) >> 61)
+#define SPE_ADDR_PKT_GET_CH(v)			(((v) & BIT_ULL(62)) >> 62)
+#define SPE_ADDR_PKT_GET_PAT(v)			(((v) & GENMASK_ULL(59, 56)) >> 56)
 
 #define SPE_ADDR_PKT_EL0			0
 #define SPE_ADDR_PKT_EL1			1
-- 
2.17.1

