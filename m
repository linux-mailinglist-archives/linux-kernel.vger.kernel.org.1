Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34A0129E3BA
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 08:21:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725942AbgJ2HUi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 03:20:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725767AbgJ2HUf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 03:20:35 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 176A0C08EAE0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 00:20:35 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id o129so1617473pfb.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 00:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KiZionDxMuzap9mqBkl5TFaeHtvNgC0mOCxeHsfq6hU=;
        b=Q/kFEIdoUAVGiNtMczHDFJgwXGycp2M4efg7rX3zWJcFo02RFIA2qo4Zp7YVeYYVdQ
         88qeyItqFkYVesspBDV7548vHARkBobHM11JwBcaF+hf8xPI9P5dlsu21ng77cH+ni9P
         yBGsPsdSo7/0EcJin2oER8LXgHdWR+eUC7TFwmvVNg1XMZZ7433dNjwr9TzR13AM1aKJ
         CGj11M9/HMJWcDJgZKy5ZqUth+i0pwqQFxqQw1WXGBQOX7A0HPp5SLhkD1yeKfd2ahE1
         B13ER6wPshvJ4yg839zvgks4TubfdTzfyOty8RfNC0FAF3cIwmZ7ENQSbxN9LHsoqlZD
         5cjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KiZionDxMuzap9mqBkl5TFaeHtvNgC0mOCxeHsfq6hU=;
        b=fZRKspP67xniy4wNAspMF9tVLdRD0sMp65wGWL7fZwE3veIJIiinnwJIoSkAGNJxtF
         gm1jsMQUTo7Up9hhvV76/JvG064df6HCDWGE2j4Pn7OcpQCS+5x/BP1d+l792LXcSq7J
         e9G+f+WQpfbsD9OsCaSfZ33yIQVVQ5QTSDdfGqs8RZpurybGEcWAFY7Fw+b/W91LVxrq
         54Zg+6DZqAykwfDzENTuiYqF5muVrnugyVmlakfnbzxPOgsTKkmjfhHcaT50OaDdKW++
         SEvDjnufopqR30kQ5ExXiB/ByH/W+m3Ny+Ueb+5vns1QWeVwPSrTBg8OxhhJY+xYlGSZ
         +J8A==
X-Gm-Message-State: AOAM532W9Jq1/fCM6lQqKW99odMkBc4nu7b8342pmDEANcBYFyc546Fv
        76XdaBRmTnj0fTzzA3L9KyBD2A==
X-Google-Smtp-Source: ABdhPJxBXCmLuznrOV9dShteldjc1LwZ2uL224cyNr2/WmNZ5tao96Fmgq1zlNe2/o71gbdlfUzALA==
X-Received: by 2002:a17:90a:2a8a:: with SMTP id j10mr3102774pjd.117.1603956034604;
        Thu, 29 Oct 2020 00:20:34 -0700 (PDT)
Received: from localhost ([2600:3c01::f03c:91ff:fe8a:bb03])
        by smtp.gmail.com with ESMTPSA id s9sm1826439pfh.67.2020.10.29.00.20.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 29 Oct 2020 00:20:34 -0700 (PDT)
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
Subject: [PATCH v5 11/21] perf arm-spe: Refactor context packet handling
Date:   Thu, 29 Oct 2020 15:19:17 +0800
Message-Id: <20201029071927.9308-12-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201029071927.9308-1-leo.yan@linaro.org>
References: <20201029071927.9308-1-leo.yan@linaro.org>
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
index 0d4b86fb8fc0..93799bf3d1ac 100644
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

