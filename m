Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3404429A2F9
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 04:10:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439180AbgJ0DKZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 23:10:25 -0400
Received: from mail-pj1-f67.google.com ([209.85.216.67]:38726 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439073AbgJ0DKV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 23:10:21 -0400
Received: by mail-pj1-f67.google.com with SMTP id gi3so36814pjb.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Oct 2020 20:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=o97OOvu5aPB6s29tkPVEXGaffWrcPza9gusl2q67U6Y=;
        b=XkqzIOC9XwBxXI86BOT3T1vDDPpWYTrFk7UMvJLkuyE5cxTGNsJ/vZTpkGOVG8mpA7
         55w4tAKBdqS3+D8beKMFqjB5dRnrkDod0oKRdry66eQfg9ThS6rATq+QvKc3/5Nrkxsi
         q/M35Sr2CW2vxYvHcWb4gE9bm+uOiK05JCEs+jGfMWKJOa2xF5BsgaDIdGZ2x5R/2h41
         QlN6eoJ2Gj6g+8M5wRd9HQh/5Qhrv9WrxTaem/NGgqjZuLeRPhFxtTjL8odmhiueeHbC
         USjSblzKh3vn/tGAI2j2kV5oXluiH8AclGC39BEGYXLEJrZGaApoHdqXLSvOfrXgmom2
         h0JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=o97OOvu5aPB6s29tkPVEXGaffWrcPza9gusl2q67U6Y=;
        b=VtEyJ6eP22XjGHjKD8Nv2NKy5A36c9uOhme4H0zBaNp0dflRNdT5KNRrCYON9Z9Not
         xY2IldW3dqFwrhuIbc6jHduD1urJsCinn9lIyqN0uS2UqJ5JhTTmE2wVwnEsWq1Ny1DV
         hbB3Gpm1gjNrlyCpIZ4KbVeC6XGnw+O9yjp90IxlcIEPxgKpCK1EsoBct4ieYIdmQpUX
         e2GGzvUe2nxbx9wDsVnW7ukzz5WGnk8q96ZxF747/ABZDNbm5SMD0LwSMENadKa0oVju
         MSG107lO7e8QfDe0U7cPXoohxfqRPUUBEzNpdO1J6vaHZzb1PObnm2KWlgxYUkwXKrwf
         RY3g==
X-Gm-Message-State: AOAM533Fxu7Kj4VWB0dPLhn/1MqNirjmbgYbENGzd23QikgiTaOuEN+3
        AzmEiPytaRC6418kjGWU4GbguQ==
X-Google-Smtp-Source: ABdhPJzjTGcBhLTbQb/MsbDDifk6pmfNerbGF8SLfjK3YzeiR03zYHyS2Fpa7RU5GBX9cD/liumwfw==
X-Received: by 2002:a17:90b:124b:: with SMTP id gx11mr67740pjb.27.1603768220724;
        Mon, 26 Oct 2020 20:10:20 -0700 (PDT)
Received: from localhost ([2600:3c01::f03c:91ff:fe8a:bb03])
        by smtp.gmail.com with ESMTPSA id nm11sm153812pjb.24.2020.10.26.20.10.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 26 Oct 2020 20:10:20 -0700 (PDT)
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
Subject: [PATCH v4 03/21] perf arm-spe: Refactor payload size calculation
Date:   Tue, 27 Oct 2020 11:08:59 +0800
Message-Id: <20201027030917.15404-4-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201027030917.15404-1-leo.yan@linaro.org>
References: <20201027030917.15404-1-leo.yan@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch defines macro to extract "sz" field from header, and renames
the function payloadlen() to arm_spe_payload_len().

Signed-off-by: Leo Yan <leo.yan@linaro.org>
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

