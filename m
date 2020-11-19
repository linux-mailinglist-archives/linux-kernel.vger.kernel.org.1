Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52F322B962D
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 16:26:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728668AbgKSPZ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 10:25:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728658AbgKSPZz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 10:25:55 -0500
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BDC8C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 07:25:55 -0800 (PST)
Received: by mail-pl1-x642.google.com with SMTP id d17so3116880plr.5
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 07:25:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XriXkpQL1G72vRO9M8mRLCWp1zrIvKg7kWNZsHT5WPs=;
        b=BQDGR0Q0+OdUmFpR7wE36bCxAWDIjXwgKQpUH39GYWAzR/4fzjjGqt2Mt+CO0nqPdK
         pEKiEeShERFiQdXEazC+hr1KLW+Lg8Dx2ibXBt91J5X3Enfq/fUgHmeANEP7afxIoehk
         clTH0izvWsBcFUDozAu8btxrEkyBi+kzCr1OIK22F7bhpAe0v1H3XuaZzDg+gWVBZHl9
         KhzGwll9xThBP2dH7EwF4V1AnO6+ESrgQuXMBCOoWHVYpIG0/8dXtFHjgoKjax0mPPOT
         A4OOQE8n1ROES4KERF1hVPOEFRSRokvzqZBBlMJbz6Muwkap+y81Ai2mEFOxMl8EczIT
         J+HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XriXkpQL1G72vRO9M8mRLCWp1zrIvKg7kWNZsHT5WPs=;
        b=mMfZ2ormcy+BB75ZIy8GDaGozQ9AVyFZ5tA+RogDJcb7CFE0Er0Ympd5s0ZR6CCug3
         LDFQgwGfNU0UYxAF57laECpmAJykAwTPbf2aUq5JFzU6PRXUurx/YxlYik0SJPRZoKDZ
         VHj9EEZl5FX9OwvGbNom1nSGmPwzl8NzrpmRZmoTVehE9DPGlDLWCcAHynwUa3IxCu6y
         Poos+cckjU/OOK3Z08Z3E1KID53lXsYhw7DK5wbInCaW6ys5gzZ7RdxAA+suaqgQXX7M
         +0u5Fcq49rb8GZYYlTmcL6+4STEJiJEqfWF2lIyGeZJzlzqXxDVuvwWL84l9PgEI+jA/
         LJSA==
X-Gm-Message-State: AOAM531IDTKTmLjmqbClejKlZ+2Ksq7jc+42ZArt73Pqv6ukDptgj/OT
        En2GvfHOc099/9A8lcKyNIwOjOayT5CXsqiTY5Q=
X-Google-Smtp-Source: ABdhPJxPRGV+Pq3MF840qcbax5SY7e39tlgf4LWhLGW57WHmOtt0qgCDRab08is3TFqlbKbd5m/s/A==
X-Received: by 2002:a17:902:8b8c:b029:d8:de6f:ed35 with SMTP id ay12-20020a1709028b8cb02900d8de6fed35mr9466457plb.36.1605799554752;
        Thu, 19 Nov 2020 07:25:54 -0800 (PST)
Received: from localhost ([45.137.216.7])
        by smtp.gmail.com with ESMTPSA id s30sm13019761pgl.39.2020.11.19.07.25.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 19 Nov 2020 07:25:54 -0800 (PST)
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
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v9 15/16] perf arm_spe: Decode memory tagging properties
Date:   Thu, 19 Nov 2020 23:24:40 +0800
Message-Id: <20201119152441.6972-16-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201119152441.6972-1-leo.yan@linaro.org>
References: <20201119152441.6972-1-leo.yan@linaro.org>
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
index 84d661aab54f..57c01ce27915 100644
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
 		arm_spe_pkt_out_string(&err, &buf, &buf_len,
-				       "PA 0x%llx ns=%d", payload, ns);
+				       "PA 0x%llx ns=%d ch=%d pat=%x",
+				       payload, ns, ch, pat);
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

