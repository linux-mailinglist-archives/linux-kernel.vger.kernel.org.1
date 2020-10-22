Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17FC2296149
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 16:59:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S368365AbgJVO6o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 10:58:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S368334AbgJVO6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 10:58:36 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0EA3C0613D2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 07:58:34 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id l15so2627957wmi.3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 07:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=njcUs+EAgE/FnSthQB374SHxmAQ7wcckE3SOsF0MTzQ=;
        b=oTXQZkJmcdKz+YGtZ8aJaiyVc22ytTvm5ackcnwS863KgjCZLrgu8Iteh8D+FofrpW
         Uet87Xy1tIC3+F8UPP0bUFDMzc1W0D/ZGNMuWF4oz89unNoaOOMHfyf06ABgyVmw+wQ4
         0CMbBIRuyGnv+/KxOvt7F13A1ZVPoyjOxtU7orugZJdlxv8Jn6sb9iJ0WlBdOHwfQAq5
         Lhh+bGCmfIWZa0HPk55yBOMdqEySNNLVWCR4X5nwB2iuvxFOKWf16HG4m/1S4bCwXaxe
         2aeZ7o5kgQH7VjiRwi535DdTT+WcDc/xTLDbe3xPsr73Wanln4/1Ry7CsOkTjFc/XAxF
         fADQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=njcUs+EAgE/FnSthQB374SHxmAQ7wcckE3SOsF0MTzQ=;
        b=By+P7hpUFYeNo0azrsraVHOfgL+mtCYBd2lKh07ko5dlefjd1wllf1Iht8X1lRPJAu
         Vi4KH8G7Kz0m8k60e8+9mslJGrQYIFuO9WX/qSPPTL6NlBvQzwePv1PPs/zhAIGEqhp4
         aq/KzqJPHQge/X/YLpxqkto4VG8uYWaeXT5f4djjE+rervKLbjixROstFLHi3x2Sofig
         KXSKjw09R2VTS/jeS26RFxDW0UxDUxmc0AbYDVEaez4avbaEroQmSrfCiybmVfSRy0SF
         32YACBWnX9gLAEUJZxKz2gbYwrKN8rOkK/o2Nyj7aDg5EWsBspiWNpdbWeX4JWxir82K
         mYuw==
X-Gm-Message-State: AOAM533zide0Y2ctv+Gf88OgXfyQ9liv5kZ/5kVXGszxI2HNVy8pOSuF
        XJ7WrrdRDmiRu4MijQJ3n5nbxg==
X-Google-Smtp-Source: ABdhPJxs7WBM7neZ/5ctClT/QEREWKpo9BwWKjLL+pcz3qEprb1gJLz/G7rZMRkuTi+J49cUMJjm/Q==
X-Received: by 2002:a1c:bdc4:: with SMTP id n187mr3091175wmf.185.1603378713386;
        Thu, 22 Oct 2020 07:58:33 -0700 (PDT)
Received: from hackbox2.linaro.org ([81.128.185.34])
        by smtp.gmail.com with ESMTPSA id 130sm4348021wmd.18.2020.10.22.07.58.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2020 07:58:32 -0700 (PDT)
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
        Al Grant <Al.Grant@arm.com>, Dave Martin <Dave.Martin@arm.com>,
        linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v3 03/20] perf arm-spe: Refactor payload size calculation
Date:   Thu, 22 Oct 2020 15:57:59 +0100
Message-Id: <20201022145816.14069-4-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201022145816.14069-1-leo.yan@linaro.org>
References: <20201022145816.14069-1-leo.yan@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch defines macro to extract "sz" field from header, and renames
the function payloadlen() to arm_spe_payload_len().

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 .../util/arm-spe-decoder/arm-spe-pkt-decoder.c | 18 +++++++++---------
 .../util/arm-spe-decoder/arm-spe-pkt-decoder.h |  3 +++
 2 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
index 7c7b5eb09fba..4294c133a465 100644
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
+	return 1 << SPE_HEADER_SZ(hdr);
 }
 
 static int arm_spe_get_payload(const unsigned char *buf, size_t len,
 			       struct arm_spe_pkt *packet)
 {
-	size_t payload_len = payloadlen(buf[0]);
+	size_t payload_len = arm_spe_payload_len(buf[0]);
 
 	if (len < 1 + payload_len)
 		return ARM_SPE_NEED_MORE_BYTES;
diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
index 4c870521b8eb..e9ea8e3ead5d 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
@@ -9,6 +9,7 @@
 
 #include <stddef.h>
 #include <stdint.h>
+#include <linux/bits.h>
 
 #define ARM_SPE_PKT_DESC_MAX		256
 
@@ -36,6 +37,8 @@ struct arm_spe_pkt {
 	uint64_t		payload;
 };
 
+#define SPE_HEADER_SZ(val)			((val & GENMASK_ULL(5, 4)) >> 4)
+
 #define SPE_ADDR_PKT_HDR_INDEX_INS		(0x0)
 #define SPE_ADDR_PKT_HDR_INDEX_BRANCH		(0x1)
 #define SPE_ADDR_PKT_HDR_INDEX_DATA_VIRT	(0x2)
-- 
2.17.1

