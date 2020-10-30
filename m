Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A599729FBCF
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 03:58:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726204AbgJ3C6C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 22:58:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726100AbgJ3C6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 22:58:01 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31EEEC0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 19:58:00 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id z1so2260286plo.12
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 19:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Re9txxlgEUEpxxffpKQDQFN978aw9VSYLQsYYRx+ZCo=;
        b=iJa/z/XtKFZHLdRuhZ+mm1s7fKkHTxZiE96ew0RJKjIjwU6TyH3aZdje6NhpoRGMgm
         Uhx8XCr5qyAZcDG/HXQ5kAcfNpF5u7Cs3paWD8ygRrS7xwtca9PQ9NJt6FfJkfMLx26N
         6kLgadONqcnqU7K8FQlj2W3c/UCUrhBSvowpHeIUHpNuLXyWtnX1tL+Xt5NtjF+FE1FV
         uhsxBXqW4HW8PXttJyF1T0O5QpCy2wuX2AV2hh0Dmlcderbuas7d9SsyMRx3vNlLe5XV
         Q3YFWxzNbsrSF7ABc57HUeIBbgor76fIIGg1aOUgkK6iu2psLD9qlLwOrC8L+9p+xb2f
         QyPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Re9txxlgEUEpxxffpKQDQFN978aw9VSYLQsYYRx+ZCo=;
        b=YPvObGwVP6fr9dahg2V7uClLmE9A6ULgy4krHPOiLYVueRT5f2qwnHdk4hWBXrNjz7
         1AHSbUgX1dAa96S5/9X6505oHdtGHcolUwAQEBXokO2fI6mHDdz4FjFghn+qgT7pjQd7
         wEO/seJZ03By5RIvWzXf2Rj1qH8wi+pIH9BJJobtU9ay8v5BcE28N3rocmD/Ad1pzpkq
         A9tBaK4Rkn/TivtKzutjkm7SoNOnk7EXD/w+sEFKJQH5P8bPDGZiBrws2zHvLRm0sb3d
         RVh9FEb1FlDXcfmBeGw/QwNaaK6dzoXRjjwR1OzLe4fzmGMmc/gm9ooR7Pe+napEtui7
         bw1Q==
X-Gm-Message-State: AOAM532bX8oLvh/jhTu79WLp1rjq/bWompeDOR4n8GYF1XxTSNVC2MO/
        es/X6am3tAbhzHASOoJ06qkd+g==
X-Google-Smtp-Source: ABdhPJzUrnHMp6WGzi+ssAQSYgXhJGm9cJTGo2Nh8p2muF/Iyo2qhT1T3xb6ECcKpCvMpSg4mEwtUQ==
X-Received: by 2002:a17:902:8493:b029:d2:42a6:238 with SMTP id c19-20020a1709028493b02900d242a60238mr7099328plo.4.1604026679778;
        Thu, 29 Oct 2020 19:57:59 -0700 (PDT)
Received: from localhost ([2600:3c01::f03c:91ff:fe8a:bb03])
        by smtp.gmail.com with ESMTPSA id a17sm4409271pfo.108.2020.10.29.19.57.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 29 Oct 2020 19:57:59 -0700 (PDT)
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
Subject: [PATCH v6 03/21] perf arm-spe: Refactor payload size calculation
Date:   Fri, 30 Oct 2020 10:57:06 +0800
Message-Id: <20201030025724.19157-4-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201030025724.19157-1-leo.yan@linaro.org>
References: <20201030025724.19157-1-leo.yan@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch defines macro to extract "sz" field from header, and renames
the function payloadlen() to arm_spe_payload_len().

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Reviewed-by: Andre Przywara <andre.przywara@arm.com>
---
 .../util/arm-spe-decoder/arm-spe-pkt-decoder.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
index 7c7b5eb09fba..06b3eec4494e 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
@@ -69,22 +69,22 @@ const char *arm_spe_pkt_name(enum arm_spe_pkt_type type)
 	return arm_spe_packet_name[type];
 }
 
-/* return ARM SPE payload size from its encoding,
- * which is in bits 5:4 of the byte.
- * 00 : byte
- * 01 : halfword (2)
- * 10 : word (4)
- * 11 : doubleword (8)
+/*
+ * Extracts the field "sz" from header bits and converts to bytes:
+ *   00 : byte (1)
+ *   01 : halfword (2)
+ *   10 : word (4)
+ *   11 : doubleword (8)
  */
-static int payloadlen(unsigned char byte)
+static unsigned int arm_spe_payload_len(unsigned char hdr)
 {
-	return 1 << ((byte & 0x30) >> 4);
+	return 1U << ((hdr & GENMASK_ULL(5, 4)) >> 4);
 }
 
 static int arm_spe_get_payload(const unsigned char *buf, size_t len,
 			       struct arm_spe_pkt *packet)
 {
-	size_t payload_len = payloadlen(buf[0]);
+	size_t payload_len = arm_spe_payload_len(buf[0]);
 
 	if (len < 1 + payload_len)
 		return ARM_SPE_NEED_MORE_BYTES;
-- 
2.17.1

