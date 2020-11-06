Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECD172A8C3C
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 02:43:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733239AbgKFBnU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 20:43:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733199AbgKFBnO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 20:43:14 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 270F3C0613CF
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 17:43:13 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id w11so1671908pll.8
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 17:43:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=l6zX0Ha6BZZILGGb5r81ziYnTli5ObjPjmlg9g0mC4U=;
        b=aZwWN8QYEXlsPuTih8cPOYxTADg8kQvrPzGl4CgtTo11534Pk6MrL9+junORDXNT+c
         7DZUsPmUqLt8lOPFLabqpA3n0DmyPkl9WwVpzpea1Lk4i/QHC7W2/2+8lAdvZOuab7J6
         kNMt7XlV9of2Lag54CD9/+ki3e22wObpaSgFnM17Lf7hQMkrGHfTvP2vtgTo0mpKZv9B
         hyO17y8Ug9nP0mx3AzAUbovoxqSpLGb8LElJOzLdn5bLdyQllDUVRBTtByFUKWzw0X4Z
         s45tKdle4xrVpqUs1t6TmWADrwU68r1pmZx4WBcxZ1Ni9a62kiHXF7gSAAdouujUX6JU
         w6Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=l6zX0Ha6BZZILGGb5r81ziYnTli5ObjPjmlg9g0mC4U=;
        b=exZ2IZaxEOh7smDqbm7WD1YnWYOtJlTW7hKG/iQEuku42kHoKnzqS1Io2RxXKQEOBM
         pUtyM9PSP1AA/2QtCdfThuTi5/qab7Sle2NSfDH2bQ5GDyeNGaNl/8/w7IuYasTNpRiL
         mkhprwVHUumQRksSsDJLSXfuN33QTCgw0u0ANkTN4BqD+V7dSWKAAEjOG7SbCcxAYfZL
         dq2DX5LaKcBMCqwdryq9RVEiB2yotmN65XhroQXNWFxQkJ5rYibYuiJLEE2FK5LxB9W5
         9XN7X/V3+t66Y9Jr1S3eoU/cKhcYHfpZRvOe8RARyhU75MNXwRNyUzG+RroOGIf04CMC
         lOiw==
X-Gm-Message-State: AOAM530eiCwNFHg9mwfhVdMf77LThZkxp7SqeqMuiUtXaud5qrvIxcUi
        vhS7g1bcIXLz+48+HNKo63OIOw==
X-Google-Smtp-Source: ABdhPJzMJ97dO1XS0GvntXy+BLJGYFI8A0iEhbPuCH/kcCMva3rQBKZx8Q8/a29xkgRf0K5EvX/L0Q==
X-Received: by 2002:a17:902:8bc6:b029:d3:d1ff:91b6 with SMTP id r6-20020a1709028bc6b02900d3d1ff91b6mr4401342plo.30.1604626992654;
        Thu, 05 Nov 2020 17:43:12 -0800 (PST)
Received: from localhost ([2400:8904::f03c:91ff:fe8a:adf7])
        by smtp.gmail.com with ESMTPSA id 198sm3896710pfz.182.2020.11.05.17.43.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 05 Nov 2020 17:43:12 -0800 (PST)
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
Subject: [PATCH v7 12/22] perf arm-spe: Refactor context packet handling
Date:   Fri,  6 Nov 2020 09:41:26 +0800
Message-Id: <20201106014136.14103-13-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201106014136.14103-1-leo.yan@linaro.org>
References: <20201106014136.14103-1-leo.yan@linaro.org>
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
index ab02fc424938..74be3a0d8556 100644
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

