Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3167129A301
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 04:11:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442418AbgJ0DLH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 23:11:07 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40337 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2411605AbgJ0DLG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 23:11:06 -0400
Received: by mail-pf1-f193.google.com with SMTP id w21so75243pfc.7
        for <linux-kernel@vger.kernel.org>; Mon, 26 Oct 2020 20:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GYRdYwhERhFOA9e5oy++bAO3+3Vnt/3kzYcTCfjnYY0=;
        b=EcFMZwWEzUb1Gk30pTizDgghUF0ybUWLoU3UCA5E1Gmn80QiMPHetDW1A6uwWKCS9g
         abnafihmIcwP8t6E/ozcrgNB2XEFMbcO3gYU2+8cpGNCJeo89SZgHGuGp1rLTs64Dqg5
         FhRKq0V9awckB/lxwPovTHAKWUWA12u5lCaJ+KAu6+EPb2xEkI410K99qqcB/bHa87gz
         XW+ExESJtCe2HCjHQYd3yglL7hlouphNOHM/m34Cuf6JA3nUGq0tNYJGaKfzeRG1C/DB
         LbxyK886SEDwT2L64RwTyU3rt5ZDmc3DvbPkVGJV2nGMzt7YtD8SC6QGKUidUm6o6Qha
         j6oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GYRdYwhERhFOA9e5oy++bAO3+3Vnt/3kzYcTCfjnYY0=;
        b=Y2XU89PvIKAnBmEvhQLiKfv7AgyVoPpuVhyAnQz/TeY14Q4XSaFwUZwG/zAoRsZRIT
         PtvEmOwdnyE5SAWsabKAjm5YLYCm+wdsjJ2fjUztrytkNrXAU8uEFGlA5WoA29akyTlf
         I5GFISRTGNCPP3WCGLXsE+/xsXGtLK/7gP25HVJBdCzLKRs9MYreyfkvqaDoVZShZfb5
         qxk3dIUfm/5iIbM9wkOwIRpFH/PFF3HjJjKyhBk3XSMXbK5iD+gp9SeqWKXYC1W8AL1v
         R8z2Hu9/Uov271vef9Z74VZ9ZSh7sx9/YMXASjj/eOwFW6qwVbtDXq5Bqw0KpmcKxWFQ
         DR2Q==
X-Gm-Message-State: AOAM530GZNF4WpXAoYojBGmFTw+wAoleso2oBWg9/xgsMIFuzLVHeEqp
        aFm6CkbZp/Yys/6RDINzLw2xpQ==
X-Google-Smtp-Source: ABdhPJyiQ4AE7Fdxpr6n8HaAjbQjoGKvtAYYn6uF22hmpOwKNvDus5GbLxOtCtdOjrsGUJk7peI+lg==
X-Received: by 2002:a62:54c2:0:b029:156:4e4c:ff49 with SMTP id i185-20020a6254c20000b02901564e4cff49mr202537pfb.26.1603768265967;
        Mon, 26 Oct 2020 20:11:05 -0700 (PDT)
Received: from localhost ([2600:3c01::f03c:91ff:fe8a:bb03])
        by smtp.gmail.com with ESMTPSA id r201sm199117pfc.98.2020.10.26.20.11.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 26 Oct 2020 20:11:05 -0700 (PDT)
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
Subject: [PATCH v4 11/21] perf arm-spe: Refactor context packet handling
Date:   Tue, 27 Oct 2020 11:09:07 +0800
Message-Id: <20201027030917.15404-12-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201027030917.15404-1-leo.yan@linaro.org>
References: <20201027030917.15404-1-leo.yan@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Minor refactoring to use macro for index mask.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Reviewed-by: Andre Przywara <andre.przywara@arm.com>
---
 tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c | 2 +-
 tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h | 3 +++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
index 1218a731638f..9304dfe72ebd 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
@@ -136,7 +136,7 @@ static int arm_spe_get_context(const unsigned char *buf, size_t len,
 			       struct arm_spe_pkt *packet)
 {
 	packet->type = ARM_SPE_CONTEXT;
-	packet->index = buf[0] & 0x3;
+	packet->index = SPE_CTX_PKT_HDR_INDEX(buf[0]);
 	return arm_spe_get_payload(buf, len, 0, packet);
 }
 
diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
index f97d6840be3a..9bc876bffd35 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
@@ -79,6 +79,9 @@ struct arm_spe_pkt {
 #define SPE_ADDR_PKT_EL2			2
 #define SPE_ADDR_PKT_EL3			3
 
+/* Context packet header */
+#define SPE_CTX_PKT_HDR_INDEX(h)		((h) & GENMASK_ULL(1, 0))
+
 const char *arm_spe_pkt_name(enum arm_spe_pkt_type);
 
 int arm_spe_get_packet(const unsigned char *buf, size_t len,
-- 
2.17.1

