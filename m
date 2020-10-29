Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2E0529E3D6
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 08:23:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbgJ2HVw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 03:21:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726110AbgJ2HVS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 03:21:18 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81909C0613B1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 00:21:18 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id o3so1590326pgr.11
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 00:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2RliNxDPfPOaV79QT/JgTj7YDuXmYEtP3uBmw1frPS4=;
        b=yhWtXAqgvPvUPs16XElSgCgLbIXH5ZKJHktbENLljO6+h1FLbw3BJTMkvffFVJHmxq
         fdA3VIsP2oVkPUNeh6/ylQwzA/gf5Kq3l5xXFJ5aw2kdeMW1tInqfdJMLRB+Gllj7kz3
         qYO47dDLJojK/ujfbZwqQT0xNViZmF6eIQsQw57NnVOfWoh/CwMy9k2ks2khtCWxR7RG
         +bG8MDb/jqpK4c/h1srUdlgvmFdygf6WKGgHmujlL4J1Fc19a9ZAT1QR7//9s7qjT6cX
         3EeKeQmcjmPercDJRene8q33vUN34O0s572eohG8SfoiIXrpIoOxWT/0+saqLD4T857v
         6Lhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2RliNxDPfPOaV79QT/JgTj7YDuXmYEtP3uBmw1frPS4=;
        b=KoaAeClDg7sJt+nJmL7WxQHRssgMWVfgvJEhn/e3DesU0rhe3pomB/purtAdobX/m0
         1X99zWFuKNKTaJyfLn9qE2lAyToA68HnbHNbsxmAO4vwOD5jSAFaG2Z9OwwkkDZ2wx/l
         RgDvSZnHvY1MNc6YhvYnTm87y/RsjeR2c+s1dbyScfqXtF+jfdzutrl5NdZJGFahJjxB
         CJc+EcyngZFsPJX1eysP3yvnIuTsHO8TSIQ5TEntOTD5+Y56xbIiRH0xOnz1Wiu3SOiD
         O6nhesp7VarQe5ygc+7dDl4ZjRHm2kqdk/Kr8SXa4X6zCZHCugtjm9Xlqa5NqbMdk92O
         krRQ==
X-Gm-Message-State: AOAM531ms3o1FVZ4LuMYbr750bqia5Vw0YPz/Jy/GyxZiKSjPnj2jQG7
        e5HPUyy84+UtGyF49XlJ4ga6w+rqPwPh40Mr
X-Google-Smtp-Source: ABdhPJxtaPX1k7dJoyOOm2xYssfBnXslslUWoU/lUwxvXIrN84NaL0ZrtAzkHTyqT1Bn07k9JF1JPQ==
X-Received: by 2002:a05:6a00:1:b029:164:1cb9:8afd with SMTP id h1-20020a056a000001b02901641cb98afdmr2853799pfk.13.1603956078093;
        Thu, 29 Oct 2020 00:21:18 -0700 (PDT)
Received: from localhost ([2600:3c01::f03c:91ff:fe8a:bb03])
        by smtp.gmail.com with ESMTPSA id w6sm1479464pgr.71.2020.10.29.00.21.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 29 Oct 2020 00:21:17 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andre Przywara <andre.przywara@arm.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Wei Li <liwei391@huawei.com>,
        James Clark <james.clark@arm.com>, Al Grant <Al.Grant@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v5 20/21] perf arm_spe: Decode memory tagging properties
Date:   Thu, 29 Oct 2020 15:19:26 +0800
Message-Id: <20201029071927.9308-21-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201029071927.9308-1-leo.yan@linaro.org>
References: <20201029071927.9308-1-leo.yan@linaro.org>
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
index 70593a4e0aa5..97a47ac3aa28 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
@@ -367,6 +367,7 @@ static int arm_spe_pkt_desc_addr(const struct arm_spe_pkt *packet,
 				 char *buf, size_t buf_len)
 {
 	int ns, el, idx = packet->index;
+	int ch, pat;
 	u64 payload = packet->payload;
 	int err = 0;
 
@@ -384,9 +385,12 @@ static int arm_spe_pkt_desc_addr(const struct arm_spe_pkt *packet,
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

