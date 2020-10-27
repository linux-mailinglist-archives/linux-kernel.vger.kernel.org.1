Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C9EC29A30A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 04:12:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2443771AbgJ0DL5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 23:11:57 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:37341 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2443654AbgJ0DLz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 23:11:55 -0400
Received: by mail-pj1-f68.google.com with SMTP id lt2so40968pjb.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Oct 2020 20:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QK7pCLsbdJrK5BSzARZ+TjRE3cayjJjSB/W1oF8mZ3Y=;
        b=PLMAZNYwQHfdAmcHmEks4oVMl83z/gGxJfaWpxBpcl7IopoYYSiRSsB796pzJVXf4f
         Cy8Y82OJjMKkKXVELcBGva2+XC4lLhjAb5xwHwNemI4OnKfjA8SGbKEnm4fXFCp39CE3
         huyll/tGaOMAWLqN1UEppv3DVc/3QGt9x0ON1mOHm0pH2tHUfnaVzFTld3lj+AYkqvDv
         K1i9pWbIOpIl4iNSwky/KSVJ6gTvwuChgoCntdnXpqfJ1UQr1wrYzpJ/JyGBIGvYDy1N
         z1oNEJfir/yCZ5pkhJ4+yct/kcd/DB/cMh2R76Tqu5J1UYTmvKhZ+2w/7JztB1f07Cxp
         gbTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=QK7pCLsbdJrK5BSzARZ+TjRE3cayjJjSB/W1oF8mZ3Y=;
        b=Ce3pV2c2ICKzyaOFRiS/xrn0HpWdpaR34WrSGvAZLm5xtESDZlUzXXOs1/MNSqycS6
         rlmsGvnyXRbyrQeAobFjsyNECKDPYFjjIFqiUn6T664EpdQyMhmZBRoFavTJezj6RK2I
         MNtOhF6yOj12JmwFSngDGI/mE/p1i5PFc5uz10+eU/MN5r6grnfIBDNIeoZTC2+bCme0
         NPUXOri3qdz4OLDSmqR6Mie3BwH5T/EGTRhP65W5uBtH6yetaQWERZ8yVYIsXXrHQXGa
         hvk3QHamGKFIodEvq8+4w+ISNaGgD8j82WqBjRdrmW0T3G6aLl3OOvRmbZqwGOfmSq8/
         q8jA==
X-Gm-Message-State: AOAM533d+SNjkJTs/fL3gB1uqNnofo/axiyjD3vOvNf2NmjWWtlBGHQs
        mXU9SJEYSv9NrN/plHTKHTBZzg==
X-Google-Smtp-Source: ABdhPJyAfBRUKmntOhRTyV2gjXa+LK6r6wtx73wD7xSba9+nVJYd3CuTELxWhLYHqGfQsU1g7DjdrA==
X-Received: by 2002:a17:90a:8b16:: with SMTP id y22mr107564pjn.46.1603768314681;
        Mon, 26 Oct 2020 20:11:54 -0700 (PDT)
Received: from localhost ([2600:3c01::f03c:91ff:fe8a:bb03])
        by smtp.gmail.com with ESMTPSA id n6sm151002pjo.31.2020.10.26.20.11.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 26 Oct 2020 20:11:54 -0700 (PDT)
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
Subject: [PATCH v4 20/21] perf arm_spe: Decode memory tagging properties
Date:   Tue, 27 Oct 2020 11:09:16 +0800
Message-Id: <20201027030917.15404-21-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201027030917.15404-1-leo.yan@linaro.org>
References: <20201027030917.15404-1-leo.yan@linaro.org>
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
index d3925521d0f4..5195ec3b1ec4 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
@@ -430,6 +430,7 @@ static int arm_spe_pkt_desc_addr(const struct arm_spe_pkt *packet,
 				 char *buf, size_t buf_len)
 {
 	int ns, el, idx = packet->index;
+	int ch, pat;
 	u64 payload = packet->payload;
 
 	switch (idx) {
@@ -446,9 +447,12 @@ static int arm_spe_pkt_desc_addr(const struct arm_spe_pkt *packet,
 					    "VA 0x%llx", payload);
 	case SPE_ADDR_PKT_HDR_INDEX_DATA_PHYS:
 		ns = !!SPE_ADDR_PKT_GET_NS(payload);
+		ch = !!SPE_ADDR_PKT_GET_CH(payload);
+		pat = SPE_ADDR_PKT_GET_PAT(payload);
 		payload = SPE_ADDR_PKT_ADDR_GET_BYTES_0_6(payload);
 		return arm_spe_pkt_snprintf(&buf, &buf_len,
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

