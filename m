Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A023A29FBE9
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 04:00:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726556AbgJ3C7h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 22:59:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726587AbgJ3C7c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 22:59:32 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2874C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 19:59:31 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id b19so2289445pld.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 19:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=z/autA3dpS9j04/HKY2NybUHkEWSNIw1CPlg1MdtfCo=;
        b=CQpncR3qGjhoTDQrXoHtaCC6njG6WoEqEKFN11tJ9DaXlK7lb4PoujaNdG3S0aJLFH
         eijMw/QuxTigS2OiqyzUlW+IwwumPIMBrVKDiXF0xyNYr/iOctZEFWD1SBETWbB0vNxm
         3wlWqvOlvSg5Fnx93WhWZIqkcj9Uf2aXuT+PNZD/yZgxDiHV3uulx2XI68sCCPYNyNXR
         YswEMD4qnKoRXRpsNVaex2EkWLQRvH8OGy+YIyCowBbS2G8BltDTM4VpqV5TRZN9h3B2
         vd2z+u2poGTi/bh9uWqiIZbAqWwXrzqwDr5HJ8Sm9sqA2me/N5sst5asyQ6SZ21GUJb/
         KsOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=z/autA3dpS9j04/HKY2NybUHkEWSNIw1CPlg1MdtfCo=;
        b=puYAc0D8KaidivauUxUO7TxJ0XHHuozCFrPFZs8Hc03h6lAislQzXNvBx6KzuK/8oP
         WtZx4WsJhakNQ7J7JGgJpQsqSvQcwPCuhsxs3gyyhVgv0gNq/A8koiydWV09P3lq25RS
         zDdUGQWyCxD2GONOlO8YOQjARW93f+Go6I0GRy6Piad9PKF0AIVHVAi5R/EK9qTiwCQF
         49gYcZZmMc/XajfJbnaMsBy36EP2jZ3XG+c34DkKv3JV4Y+h2uyCN8eYGI7vPvY779OJ
         PbrHU+iysAD/Bfbz8OJdQgmeDCQDPJFR7xxB4Ob7q+TPtitPnMHv3Di1LeHcYRQaCNw1
         X07Q==
X-Gm-Message-State: AOAM533FD8YaD8AnYSt0PS5FtYqM6t18v1ovebTMWbc4iSB83cKhINtm
        jJstrFO46pXBnaZ++JVgOEj9oA==
X-Google-Smtp-Source: ABdhPJy+y5ZqwuHabtRCUQh8IlX5Z8jRyfBRxi0jhJvWbPRk/WhJOzAf0gjSt54DLyY8Aku7uNK+ug==
X-Received: by 2002:a17:902:6a8c:b029:d5:da81:dc42 with SMTP id n12-20020a1709026a8cb02900d5da81dc42mr6942963plk.40.1604026771419;
        Thu, 29 Oct 2020 19:59:31 -0700 (PDT)
Received: from localhost ([2600:3c01::f03c:91ff:fe8a:bb03])
        by smtp.gmail.com with ESMTPSA id l199sm4395936pfd.73.2020.10.29.19.59.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 29 Oct 2020 19:59:30 -0700 (PDT)
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
Subject: [PATCH v6 20/21] perf arm_spe: Decode memory tagging properties
Date:   Fri, 30 Oct 2020 10:57:23 +0800
Message-Id: <20201030025724.19157-21-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201030025724.19157-1-leo.yan@linaro.org>
References: <20201030025724.19157-1-leo.yan@linaro.org>
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
 tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c | 6 +++++-
 tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h | 2 ++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
index 3fca65e9cbbf..9ec3057de86f 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
@@ -371,6 +371,7 @@ static int arm_spe_pkt_desc_addr(const struct arm_spe_pkt *packet,
 				 char *buf, size_t buf_len)
 {
 	int ns, el, idx = packet->index;
+	int ch, pat;
 	u64 payload = packet->payload;
 	int err = 0;
 
@@ -388,9 +389,12 @@ static int arm_spe_pkt_desc_addr(const struct arm_spe_pkt *packet,
 					    "VA 0x%llx", payload);
 	case SPE_ADDR_PKT_HDR_INDEX_DATA_PHYS:
 		ns = !!SPE_ADDR_PKT_GET_NS(payload);
+		ch = !!SPE_ADDR_PKT_GET_CH(payload);
+		pat = SPE_ADDR_PKT_GET_PAT(payload);
 		payload = SPE_ADDR_PKT_ADDR_GET_BYTES_0_6(payload);
 		return arm_spe_pkt_snprintf(&err, &buf, &buf_len,
-					    "PA 0x%llx ns=%d", payload, ns);
+					    "PA 0x%llx ns=%d ch=%d, pat=%x",
+					    payload, ns, ch, pat);
 	default:
 		return 0;
 	}
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

