Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C8282A8C2F
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 02:42:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732951AbgKFBmP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 20:42:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732916AbgKFBmO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 20:42:14 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42355C0613CF
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 17:42:14 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id g12so2691417pgm.8
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 17:42:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Re9txxlgEUEpxxffpKQDQFN978aw9VSYLQsYYRx+ZCo=;
        b=mHxG0XucKlKyFux2FQjJ+ADBaB6fZQemguAZNDx5uyw/7MPxU1nG12pAk/yNjiA1Ow
         QvwoZ1J/OhOlnfZjnG1bjNYciLQbML0ZVcH4mRDux0+v/GDS3la6BpacKVY9XEOAtkbW
         oRde5NvD/FgF6J7Yei1at8+mV8ridgDbnEGxOsqNSzmlUAL2MOGj8wdEx8lMVoJs4Dy2
         5+B6h3/yjooEgSXdNd7nMKsZ73cBnqwLTXcDp5Q9Bu9kDpH9csnKVG+yu3NRkyiXaH8N
         vpS/EGeaBa0MPJVdT7dX55jpa9n852r9vJijhJJyM98/yY0wimJrv7sg9c86x894cRVc
         MClQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Re9txxlgEUEpxxffpKQDQFN978aw9VSYLQsYYRx+ZCo=;
        b=Me1u+g0csZFj5rPUk9bccVW/n+89gaQ9WOdhqp4bfKm8mkoQsppu3wwb1pNygq+Yqr
         VNHuK5PbwsBVZAyHmG/+sg5CQIBfVq3h8N+lW7hvxGyWQbqjqzreX5jjGMxJzl7Q/F8Z
         gqLWfWOrwuk60bwPKdSfrJKL8DxQtpOaC+y8BZAIWT4PONHSpaswFYkJtGrlYcARZoiq
         HqRefG6kTZ2ufx4hmoyju3q3l+1aKGRn+nDPYtxAWVhLmMAmUbpaNBAhWIkCBBgAJVPr
         3kNiv1860WDzkD8Y31xgMRmxtFQY4jQfE8V22C8UV6dVODiFPXB6CDmDeKYVg1KEc0JD
         9Cig==
X-Gm-Message-State: AOAM530473rh3M3j5JYH5xpJ9JghmPB0v+grXIlTNzmR9bz83j9Is4qA
        InMBwGbw0sLv5TV6NDW3iCjYJg==
X-Google-Smtp-Source: ABdhPJztO8oVJ4N/OhKO5b/hAvwEu36E6jvBK8iQZMVt7slRzrPIBabKlGtv4/dEYbdnnZ9UunreEg==
X-Received: by 2002:a63:c750:: with SMTP id v16mr5108080pgg.424.1604626933858;
        Thu, 05 Nov 2020 17:42:13 -0800 (PST)
Received: from localhost ([2400:8904::f03c:91ff:fe8a:adf7])
        by smtp.gmail.com with ESMTPSA id q23sm3996129pfg.192.2020.11.05.17.42.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 05 Nov 2020 17:42:13 -0800 (PST)
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
Subject: [PATCH v7 03/22] perf arm-spe: Refactor payload size calculation
Date:   Fri,  6 Nov 2020 09:41:17 +0800
Message-Id: <20201106014136.14103-4-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201106014136.14103-1-leo.yan@linaro.org>
References: <20201106014136.14103-1-leo.yan@linaro.org>
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

