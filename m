Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33E0127CF8A
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 15:41:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730724AbgI2NlW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 09:41:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730645AbgI2NlF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 09:41:05 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8063DC0613D4
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 06:41:04 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id v12so4847323wmh.3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 06:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UdmZsvd94qZRdYTMmc9us+fuJhBNcvdhUkZcSKO5qj8=;
        b=ajJAy4E9+f1Vk0A5GMtdDc/4Tm7PgwhM6tUfnw6n6QEOWHK/J480/aA0epmtIrbtlK
         aO+E3n5ain/Xg8lJ8wUDqo93MYKiRq5pKK+NrB0qxeDMgA6B3h3zvRfZ3yvl4zNu5/7x
         sugeGxIlcz66TgaaBx9qtSgzgWYbPoZp+2ucuksMx2IQD2h+A+VMhMz3/BzEGvAdstie
         /Slnn47Ucf+vuArVOBT55zc/iXG54+zSek+BOyJSm+OTsPv+de9dMa89qRl1l6SSKw5c
         ydkJERR7SBka/IGv6Zc7Y9M4FD1s25NecC6+I9NRV08Vrtw4VAMTT/UtGtsNb5L9400a
         d9Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UdmZsvd94qZRdYTMmc9us+fuJhBNcvdhUkZcSKO5qj8=;
        b=mRIy/F0/5hfpxdCo/MtsruMziwJcBx/JOivQ9Z8vVX73uUX+6EQL4EdN1ki5u7SK4W
         HFggI/94pDtzKLg/5zzYq7/0xnIhguBksYHizJMunT+Pk5RZ+af2xWIQAmc0FWFXzqQu
         bVlidJ8fyIGU8v6jWPetyH0/UXoHe6NewsfoqvP3LFOwcODAJQJls23BubQaGg3hzru3
         /z50aXLs2WqjgxtPoUwF3OPKD9tFzC83OywMhsxV2lvT8pDGUpJJ0xUNIwf73itx4hT/
         /kuPJ9zQLDTvmaZ+yLnqocppXtuFkGvGk4fY2mtnX3Ey7h32dMZ/5SqLR/9x/PBAq876
         +BnA==
X-Gm-Message-State: AOAM531p5a3627DCSwbsAgWxi3ZcrecNHg4+C+hl4nxcOoOzAfIPl9rb
        dzL0EelrRRYal9SC/YFtlUIX9g==
X-Google-Smtp-Source: ABdhPJyOIRJEszQqHsIwcxntvQH3KjqpQgCoVQro8lbglVLjvyfWM7QpmJYpHWKf84fBovzaK8r24Q==
X-Received: by 2002:a1c:9c13:: with SMTP id f19mr4460892wme.97.1601386863136;
        Tue, 29 Sep 2020 06:41:03 -0700 (PDT)
Received: from hackbox2.linaro.org ([81.128.185.34])
        by smtp.gmail.com with ESMTPSA id q15sm5955314wrr.8.2020.09.29.06.41.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2020 06:41:02 -0700 (PDT)
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
        Dave Martin <Dave.Martin@arm.com>,
        linux-kernel@vger.kernel.org, Al Grant <Al.Grant@arm.com>
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v2 13/14] perf arm_spe: Decode memory tagging properties
Date:   Tue, 29 Sep 2020 14:39:16 +0100
Message-Id: <20200929133917.9224-14-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200929133917.9224-1-leo.yan@linaro.org>
References: <20200929133917.9224-1-leo.yan@linaro.org>
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
---
 tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c | 7 ++++++-
 tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h | 2 ++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
index 57a2d5494838..05a4c74399d7 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
@@ -270,6 +270,7 @@ int arm_spe_pkt_desc(const struct arm_spe_pkt *packet, char *buf,
 		     size_t buf_len)
 {
 	int ret, ns, el, idx = packet->index;
+	int ch, pat;
 	unsigned long long payload = packet->payload;
 	const char *name = arm_spe_pkt_name(packet->type);
 	size_t blen = buf_len;
@@ -438,9 +439,13 @@ int arm_spe_pkt_desc(const struct arm_spe_pkt *packet, char *buf,
 						    "VA 0x%llx", payload);
 		case SPE_ADDR_PKT_HDR_INDEX_DATA_PHYS:
 			ns = !!(packet->payload & SPE_ADDR_PKT_INST_VA_NS);
+			ch = !!(packet->payload & SPE_ADDR_PKT_DATA_PA_CH);
+			pat = (packet->payload & SPE_ADDR_PKT_DATA_PA_PAT_MASK)
+				>> SPE_ADDR_PKT_DATA_PA_PAT_SHIFT;
 			payload &= SPE_ADDR_PKT_ADDR_MASK;
 			return arm_spe_pkt_snprintf(&buf, &blen,
-						    "PA 0x%llx ns=%d", payload, ns);
+						    "PA 0x%llx ns=%d ch=%d, pat=%x",
+						    payload, ns, ch, pat);
 		default:
 			return 0;
 		}
diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
index 2c4086bf3149..1847cad517db 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
@@ -76,6 +76,8 @@ struct arm_spe_pkt {
 
 #define SPE_ADDR_PKT_DATA_PA_NS			BIT(63)
 #define SPE_ADDR_PKT_DATA_PA_CH			BIT(62)
+#define SPE_ADDR_PKT_DATA_PA_PAT_SHIFT          (56)
+#define SPE_ADDR_PKT_DATA_PA_PAT_MASK           GENMASK_ULL(59, 56)
 
 /* Address packet payload for instrcution virtual address */
 #define SPE_ADDR_PKT_INST_VA_NS			BIT(63)
-- 
2.20.1

