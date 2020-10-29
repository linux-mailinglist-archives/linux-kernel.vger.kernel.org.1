Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6C5E29E450
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 08:38:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727916AbgJ2HYy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 03:24:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726923AbgJ2HYg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 03:24:36 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AFB0C08EADA
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 00:19:54 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id r10so1594984pgb.10
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 00:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Re9txxlgEUEpxxffpKQDQFN978aw9VSYLQsYYRx+ZCo=;
        b=u0Su94Zy4x5rNgKQtTGB+RRHpIbhGnnmuoEvN4z9vQtePikRfYwaS86EOg6G/SpzdF
         fPJzqIrtivWZgYV96No16Wen8G3mJZj23ZOR6DKv/0W9RYR13mfcs0wpkfnFJw8iPmlc
         K3EUkyIjVdUcXokV+65u6qmzZWwQdv5Gp2TBIc/KfDJvwydySNyq3EzOnMF3SBDvWBKm
         TPEG8PgljPDdadux5CLh6GXvjvPB7XrxSh8xAXYr2WGkBWlnJVL+rvR7in6uwpJvrL6l
         AompBT8Xki8IRv34ApQ10AwFurJZXRdldYiA4HkEpJrL42Bi9lpipKO8+ThHxRcuNgjm
         4W7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Re9txxlgEUEpxxffpKQDQFN978aw9VSYLQsYYRx+ZCo=;
        b=ppi3j72fnsbWHPVqx/Taw9R8vnY7RaMEWHYz+H90bYU+Z5OPYKKD7ovq99/f0YCjYK
         kr2WtJL3BVSovnjcsLWnGb2XIsdn7mfAndZfX9skJ5yu2aaSlF9cUEB6Xl6P4rtJ2AX9
         lcJMloyXv4jypTlHbbxJbCChmJ1oAz+WcVnScfY1J21xtmcOQyiOLfn8BOxAHPcLV6il
         NX82M3+bHOuqmcONVATBVKRUgDE2NgIr6WhsfjVMfdjP0Qh4LpEWE0FcxvGd7G2REkU9
         wWxew3vQCwoFWxko8ux1ORzcWEFccAhYOF1mSl+UzXrP8elAJ8DZmqbx7imcRE6ljzoU
         6bLQ==
X-Gm-Message-State: AOAM5316eRYW/jQZHSfScBi0WCHKgMT2t/IoOszjUq07+j0ne7TMOC6a
        oiri9x8uLJc44JvhtZ/kFxvLug==
X-Google-Smtp-Source: ABdhPJwwQU57BnsZwBN7bJfFxA5hlkPTq/WO7dbiAg+n5iB9g78aAFaOhf22ZaCJvi2gs4eS/qprig==
X-Received: by 2002:a17:90b:4a83:: with SMTP id lp3mr3080982pjb.138.1603955994124;
        Thu, 29 Oct 2020 00:19:54 -0700 (PDT)
Received: from localhost ([2600:3c01::f03c:91ff:fe8a:bb03])
        by smtp.gmail.com with ESMTPSA id gm14sm1700126pjb.2.2020.10.29.00.19.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 29 Oct 2020 00:19:53 -0700 (PDT)
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
Subject: [PATCH v5 03/21] perf arm-spe: Refactor payload size calculation
Date:   Thu, 29 Oct 2020 15:19:09 +0800
Message-Id: <20201029071927.9308-4-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201029071927.9308-1-leo.yan@linaro.org>
References: <20201029071927.9308-1-leo.yan@linaro.org>
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

