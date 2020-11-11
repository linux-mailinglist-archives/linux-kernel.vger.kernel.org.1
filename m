Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F28342AE97E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 08:18:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726355AbgKKHRh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 02:17:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725916AbgKKHPK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 02:15:10 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCCC7C061A4E
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 23:13:38 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id f18so869136pgi.8
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 23:13:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Mey/603/Af9fa0SenmvdWeJX26KRCA8sZOTLF5+uncY=;
        b=XJNEO9zLi4Cyhe65faS0AsvS+9dS7+O7SlSxy/1IC8tpIfnIHgrkaEkmB05qxvSp5D
         DSOQLKb7gu36PsgqqVub9mRf2tY/NVw6QdUShOTnpolj1PxW8/yxn3hgp5NNVT06yPjK
         QnBVdck2ODBYB8X0M09jDMxU8rMkcP335K88G2Eu0L2fjc7gE2due4B6BItDf88fd0vV
         Jew/QnGT1+twTquoyppbtzkwgO4iKJJ6ngiCcWtnK8AC1w7y1hy6wPUtnAG1BaiReAw6
         ehZXNzrrJq+08Nn8QDWXmxk0AFQBAseJCeyuNInBlUBAvxBGEnBZpp5pwf/XC1FGtcYU
         Yh7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Mey/603/Af9fa0SenmvdWeJX26KRCA8sZOTLF5+uncY=;
        b=g7mvHkyoxAw0BOIAEW2qYC37K5/IGA3ZItxNBk3wb/tF7xO/RDm+lOtpCkCkWJw4QR
         QGSVblYFUSINZKrOc/alfV6KnEV70+3+NOB3iX/ZxN72KxXEYVW3vvqlnljTNpa3+n0s
         7MRZt4svxRUb+YPpy0NiKAQStZwb18BRZeQrnwpHHRDCZRPKoacqUQimAj1HWpw5Sxro
         unJDu3FYgvQYPR3evHXfEw/94LWqXZGhsDB9OmR7NJ2slxR5WGsXa9JABXdVn/YIJKBr
         5F6mpryKbIhUUfGdT6+RTjwKmFaSR2FifXd6IHxyro0ZeHOMPvRkUhycnWgOu8TDDWwO
         5/Pw==
X-Gm-Message-State: AOAM533sucWUaZilPSr0hkGpRtrW8CcdD/ZZc5wGYmTcPrGj20moQK7z
        4qxQUqkohzbFQTQtu6r2V2u9nw==
X-Google-Smtp-Source: ABdhPJzhzKnSafSp2O+Md1FzS4MwIddL165ZaDTLgQkRZrEsmk2OtWtn7FJ9gdSMGrP99vshYpuLPw==
X-Received: by 2002:a63:e0e:: with SMTP id d14mr3942781pgl.125.1605078818367;
        Tue, 10 Nov 2020 23:13:38 -0800 (PST)
Received: from localhost ([45.137.216.7])
        by smtp.gmail.com with ESMTPSA id j19sm1316517pfd.189.2020.11.10.23.13.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 10 Nov 2020 23:13:37 -0800 (PST)
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
        linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v8 21/22] perf arm_spe: Decode memory tagging properties
Date:   Wed, 11 Nov 2020 15:11:48 +0800
Message-Id: <20201111071149.815-22-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201111071149.815-1-leo.yan@linaro.org>
References: <20201111071149.815-1-leo.yan@linaro.org>
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
index 55c4bf330b96..cbbbbefdc52b 100644
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

