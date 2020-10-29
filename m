Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89FDD29E3BD
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 08:21:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726070AbgJ2HVG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 03:21:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725958AbgJ2HUr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 03:20:47 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDD62C08EBAF
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 00:20:44 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id 133so1586775pfx.11
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 00:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=T+I33x4hia0uDA4Cf+MNfqptcZoG3D45T1hFf6lFMGs=;
        b=TvOJipdXAaUQnkMJiBpR+vDmJ5Lt/vkV2iyAkmfcm2IplCceMGh7Mmh+hGpn+DueXa
         fI83amR16LwZenEoXK/UZN6KUNoqSD2JEyC19yvy7VGs5UrxpHXyRGJW7dSd9c2uOPI5
         3rxsFsIrqwxkW70awsnVt7nKu41OKjouEV0CqnHFWZnTqQksheIZnOisJ3HHILq+wFb3
         nNoIzQSLBgkPp2XVb5aeI/E8/ljw/pcvg2y18T89X89yGyhTHTAkhBzaZzW78sWj/s7g
         TGzx3XPzxtX0YEK31WHVvzI1LL0sRc6sW82YfC4+foe9Oi5x0yw4K0DS4tpKGAezXksV
         G/GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=T+I33x4hia0uDA4Cf+MNfqptcZoG3D45T1hFf6lFMGs=;
        b=bzzci5h79i8+OtXL0h0YAeCKbDKdIJg1TvphKdnHDpug4etzaTOZEBbM9vjzM9rxs3
         PKgLbYHbYenUgEwipdqs4iZPq95xUazFQvLykPp+663VRZw91CayIx/xXJkn8rpYCiK7
         6J1Rvbs3pewQbmCq1ZoopechYVGOvA+pipfnyuq+nwmzXoH7FptaaKDjCCubYdIapCkg
         0RndZeTlmABG3Cg5QWfERL4y+iCnOBsQF+rXPSCSm/Arbc8ki7nZCex53hv8fboHRdeY
         +laNSjs2L2dBdvU/XQ7b7ohqoZlVMB6qciEoCcKqMTPPJSD+zRUU+r4GnhECZxCvBMAA
         9+gA==
X-Gm-Message-State: AOAM530/hE5MgCT+2fE0uacHKHsE9Or5sIdiJVA71VdYvKUnmaH8CgJU
        ZIyc5Fl9ZnsTAh/dfVGugJBjlw==
X-Google-Smtp-Source: ABdhPJwrofyUuOd1fhH7qgo32TDTTZfNcJ1RIQu/SlLHyEGTQ8EuAZtYdR+UI3fYLAJ49MwBDLIzKg==
X-Received: by 2002:a17:90a:c087:: with SMTP id o7mr2888580pjs.155.1603956044330;
        Thu, 29 Oct 2020 00:20:44 -0700 (PDT)
Received: from localhost ([2600:3c01::f03c:91ff:fe8a:bb03])
        by smtp.gmail.com with ESMTPSA id e186sm1795576pfh.60.2020.10.29.00.20.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 29 Oct 2020 00:20:43 -0700 (PDT)
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
Subject: [PATCH v5 13/21] perf arm-spe: Refactor counter packet handling
Date:   Thu, 29 Oct 2020 15:19:19 +0800
Message-Id: <20201029071927.9308-14-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201029071927.9308-1-leo.yan@linaro.org>
References: <20201029071927.9308-1-leo.yan@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch defines macros for counter packet header, and uses macros to
replace hard code values in functions arm_spe_get_counter() and
arm_spe_pkt_desc().

In the function arm_spe_get_counter(), adds a new line for more
readable.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Reviewed-by: Andre Przywara <andre.przywara@arm.com>
---
 tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c | 11 ++++++-----
 tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h |  5 +++++
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
index 4e2f7bbd9d35..bc4b5a5a528b 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
@@ -152,10 +152,11 @@ static int arm_spe_get_counter(const unsigned char *buf, size_t len,
 			       const unsigned char ext_hdr, struct arm_spe_pkt *packet)
 {
 	packet->type = ARM_SPE_COUNTER;
+
 	if (ext_hdr)
-		packet->index = ((buf[0] & 0x3) << 3) | (buf[1] & 0x7);
+		packet->index = SPE_HDR_EXTENDED_INDEX(buf[0], buf[1]);
 	else
-		packet->index = buf[0] & 0x7;
+		packet->index = SPE_HDR_SHORT_INDEX(buf[0]);
 
 	return arm_spe_get_payload(buf, len, ext_hdr, packet);
 }
@@ -309,13 +310,13 @@ static int arm_spe_pkt_desc_counter(const struct arm_spe_pkt *packet,
 			     (unsigned short)payload);
 
 	switch (packet->index) {
-	case 0:
+	case SPE_CNT_PKT_HDR_INDEX_TOTAL_LAT:
 		arm_spe_pkt_snprintf(&err, &buf, &blen, "TOT");
 		break;
-	case 1:
+	case SPE_CNT_PKT_HDR_INDEX_ISSUE_LAT:
 		arm_spe_pkt_snprintf(&err, &buf, &blen, "ISSUE");
 		break;
-	case 2:
+	case SPE_CNT_PKT_HDR_INDEX_TRANS_LAT:
 		arm_spe_pkt_snprintf(&err, &buf, &blen, "XLAT");
 		break;
 	default:
diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
index 9bc876bffd35..7d8e34e35f05 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
@@ -82,6 +82,11 @@ struct arm_spe_pkt {
 /* Context packet header */
 #define SPE_CTX_PKT_HDR_INDEX(h)		((h) & GENMASK_ULL(1, 0))
 
+/* Counter packet header */
+#define SPE_CNT_PKT_HDR_INDEX_TOTAL_LAT		0x0
+#define SPE_CNT_PKT_HDR_INDEX_ISSUE_LAT		0x1
+#define SPE_CNT_PKT_HDR_INDEX_TRANS_LAT		0x2
+
 const char *arm_spe_pkt_name(enum arm_spe_pkt_type);
 
 int arm_spe_get_packet(const unsigned char *buf, size_t len,
-- 
2.17.1

