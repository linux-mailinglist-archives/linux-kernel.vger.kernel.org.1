Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9737D29FBDE
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 03:59:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726521AbgJ3C7B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 22:59:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726501AbgJ3C6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 22:58:54 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 964D8C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 19:58:54 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id w21so4028757pfc.7
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 19:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Axrz0L3W6EVlQNnAU2/E+qReovuPXs3Rzv/RHq2QBfs=;
        b=yhb4i0LSh+Lv68tmmYlp1+G02wvL+We9eFzwTMhHL+7e+lA2vMhvTz6pir4sBWU9Nt
         hEWO8GymR+HwvolQtMgy+WsWUsvZ0sPTcZ/JuIgO3Y/gUqWIJm9/BJ1D4ugx3EnyY6cD
         er6uiTmkt6NsRvJYl5tL9aDex2wDwFnA5bL6DUDLr0uzFCeOA0XHTClnuJNTfs2MDYDh
         IR5sXIEJkeL8djxY00DVLS6E41nfXNzYJfLE31f6h+BqGREk7e9p7mXZXfGvPTHgxCel
         pRsu/UG9JTK1glbcMUvaEDm4f1ceZCVqRpxV/vmETReccshzPwLLCwqBu7fOMeR59mD/
         Ixpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Axrz0L3W6EVlQNnAU2/E+qReovuPXs3Rzv/RHq2QBfs=;
        b=RHVCXXA637NXpouCsE6Zd2HIMTePeFM0/JFHndNnDm6S3Xr52OBnWLnAis59UlCdOp
         XTfOssL9+YLhZYylQw4Q9ppUv+POzfnV2A4XUUOs/uslhKhTnt1dmbZXUNRmsJwWTjWI
         yQv62W0PscHjmJ4ZTh6R41WKZWS+DXbclofeE9CC3i6Q+mJm7wRTwTpyRhYNZgklCnez
         Y4GskCvtPKVEu4ESiRX48jAvllPhcjji33fmHw4y3afAM17nYA+O/yBlsTZb/2WmcuLU
         h4DMNmqsw6QMNRiyOwD9GAm8iZDj7e2Hnkp++x3u4h0MAXrKiOwwroswGNT7scFgw7bz
         OgKg==
X-Gm-Message-State: AOAM532myN4w0H/BYVb0To6MtQ/HeYwMLATw2NCUreEB6IxkwG2/mysn
        FGfFZh65a/0MqIaFb1rsFh1CZQ==
X-Google-Smtp-Source: ABdhPJxXVZITYBAp+KjZJF1rr15qpBl+CnKvjW6DcWzI7bqaCpGTTXzEhJ6lB/e6oXD8wTGePyVMYA==
X-Received: by 2002:a65:4cc1:: with SMTP id n1mr299972pgt.404.1604026734190;
        Thu, 29 Oct 2020 19:58:54 -0700 (PDT)
Received: from localhost ([2600:3c01::f03c:91ff:fe8a:bb03])
        by smtp.gmail.com with ESMTPSA id b2sm2259642pgg.2.2020.10.29.19.58.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 29 Oct 2020 19:58:53 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andre Przywara <andre.przywara@arm.com>,
        James Clark <james.clark@arm.com>,
        Dave Martin <Dave.Martin@arm.com>, Al Grant <Al.Grant@arm.com>,
        Wei Li <liwei391@huawei.com>, linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v6 13/21] perf arm-spe: Refactor counter packet handling
Date:   Fri, 30 Oct 2020 10:57:16 +0800
Message-Id: <20201030025724.19157-14-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201030025724.19157-1-leo.yan@linaro.org>
References: <20201030025724.19157-1-leo.yan@linaro.org>
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
index 403eb15c13d7..d867d7024480 100644
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
@@ -313,13 +314,13 @@ static int arm_spe_pkt_desc_counter(const struct arm_spe_pkt *packet,
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

