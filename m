Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDA452AE970
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 08:12:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726221AbgKKHMf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 02:12:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726202AbgKKHMc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 02:12:32 -0500
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE251C0613D1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 23:12:31 -0800 (PST)
Received: by mail-pj1-x1043.google.com with SMTP id gi3so260060pjb.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 23:12:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Re9txxlgEUEpxxffpKQDQFN978aw9VSYLQsYYRx+ZCo=;
        b=l2OJ5WqT3IbmET+eW22xEHRG0rrZbA3fy5yAKLIiAvGd+HPTS4aYzWc2Eo2Lz92A0m
         KixutGegRoLJYPP7u4wnRUjpJ6l8m+bSjZGd7L9GVEP0NSuk9OGNC7aeB0HqMHwBI7pW
         HqFb+QkptTp1Y53RHkeSugc2dtii0Msf49iyP0vX8o3pGj5Fzfb39/x9b4i7gqcLmYTc
         wwpqXlqzq+tO6M46RUXPnsX56Nm3OKSNVQTfV1Ou+jO4chQUktih9euC3rnvayq5DSx6
         mdm+nOR3iPLmgXM4fW2B33rEHmi1jUJBUB3euM1KXVqAGlh15KrPs+doBMVo4Te76sj6
         LV6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Re9txxlgEUEpxxffpKQDQFN978aw9VSYLQsYYRx+ZCo=;
        b=RZ4k5AMwpC8xTbSPOCOgC2XUyG/fd3kMFTRjdlPwDVrHfmeIRqvHCe1EZWDNcb/IKE
         McaM8xcenUUp8gHMowydBfo6CzF0JJ3bHsI45zdaJVG+tifSc2ZBw0/roixj/fcGflHg
         WyFk+frFs9tsNe03XmcWPIKzIPqb9JhAim4OPlxVbPuDQEBJhP5RTtdoiAqiUfcPjMno
         JolkPBdoKjeo//xEx1BMrhVRuSNHCtyj1KnSWvfDuyDWEKWch+jdvQInyfpxlwfacCBd
         xkeiEMtZui1URbYHyiId37XWuVGHFHdIbVGrDoEx6fjxpNw31TwUqjYwfn+YbAc2PDPb
         0w6Q==
X-Gm-Message-State: AOAM530Avt8PV31NrkhmyOsccHFLQ67ThHNbRYQbDe4J4r26z08PAyfh
        k7JhdteAwOtZbGpMQcCSQmnvyQ==
X-Google-Smtp-Source: ABdhPJy3xiQrVyDdlespsIepWnKz7vQew5L7lqmwkW32S34jRdfgs+WKE8EJtbqjGoLIPx0NJ5in7w==
X-Received: by 2002:a17:902:59cf:b029:d7:e216:9260 with SMTP id d15-20020a17090259cfb02900d7e2169260mr11275398plj.74.1605078751265;
        Tue, 10 Nov 2020 23:12:31 -0800 (PST)
Received: from localhost ([45.137.216.7])
        by smtp.gmail.com with ESMTPSA id a84sm1344116pfa.53.2020.11.10.23.12.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 10 Nov 2020 23:12:30 -0800 (PST)
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
Subject: [PATCH v8 03/22] perf arm-spe: Refactor payload size calculation
Date:   Wed, 11 Nov 2020 15:11:30 +0800
Message-Id: <20201111071149.815-4-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201111071149.815-1-leo.yan@linaro.org>
References: <20201111071149.815-1-leo.yan@linaro.org>
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

