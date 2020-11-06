Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52FB22A8C3F
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 02:43:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733262AbgKFBn3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 20:43:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733218AbgKFBnZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 20:43:25 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B78D4C0613CF
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 17:43:25 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id z24so2704693pgk.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 17:43:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=d9QmvWEdefKeBf+xxwbqDSUAMpmaFxPSES1h5kQyM8w=;
        b=eU5YMHjWLUf1KN0/tMXFHDJ95sC+ryxvn5uDTv+x4D0/6QHVxM+2Iyp9aCXC4czfWu
         yLE+Yfgvhd96QPh1K9C88eT7ugBR4qg9wriNkRlck1vjoURYUK8XHlIuM7WaOeSXE0t7
         1xmqSNf8BxKgVt3PDM1cDB4eeA2plDLqxrpm+EqdgMCh+JQzMZ+riUxbH9NnHIqzSEv5
         UFrXZsUR99eTVWnODDY7DEpX2+rVLH88NcW1w4u2LHXLIIfcDPeM4oVKEDs76LK3wFa5
         VoG6U3yC3pqzVFS4W15Avu1w/+CiJMCTC7WQkL1qmcAtE8G4InCzJpcfKt5Na4UF76g/
         mXog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=d9QmvWEdefKeBf+xxwbqDSUAMpmaFxPSES1h5kQyM8w=;
        b=c16+b+orofPhBjXWHGeHAMJZxjNbT2ciphl8eejEZ4IyAsY9Hfi/mI74mpdTCJz3Vd
         eIj9yHDptoocZeITVC61OFLznH7ShOfw75ndkIokodAPyDQWsHCp2hSHNCFCpSl+ePqX
         CmAiwzL+KmqAQBFTILx3UFWftdaHr2CQNmKEwiTXGEW1RrtNZgsRqXYn/sh7a2Kf/GGI
         555CzHhFWFW7iLEKFaXlvRVkRu/0Gdr5ulC+5cutDlPqQXeaneX0Eytm+bmTQ0CqMNXi
         6Y9EgtrwiiG1Rv+LRZMGaN3uPVmJv8roAbdB3SVXcyTcV488Jxi7/fYqPF8SiVzabksV
         GATQ==
X-Gm-Message-State: AOAM531g0lvRtX1qyIT0zx4V6tDC4WTVandUcX27iACAIIc4o7pkQvaC
        DHAoD3dXsPa5mMpCKE0McRVuNw==
X-Google-Smtp-Source: ABdhPJxV74AQ0f0hw8VIF2SD+OxZTXL6vn4FhPb+5RSGN+BLNpNbJC6AS9xZPkKlcUH8qwKdRpJD5A==
X-Received: by 2002:a17:90b:4d07:: with SMTP id mw7mr726648pjb.152.1604627005292;
        Thu, 05 Nov 2020 17:43:25 -0800 (PST)
Received: from localhost ([2400:8904::f03c:91ff:fe8a:adf7])
        by smtp.gmail.com with ESMTPSA id t8sm3972335pfe.65.2020.11.05.17.43.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 05 Nov 2020 17:43:24 -0800 (PST)
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
Subject: [PATCH v7 14/22] perf arm-spe: Refactor counter packet handling
Date:   Fri,  6 Nov 2020 09:41:28 +0800
Message-Id: <20201106014136.14103-15-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201106014136.14103-1-leo.yan@linaro.org>
References: <20201106014136.14103-1-leo.yan@linaro.org>
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
index ea769e555bf5..4b58aa6a2877 100644
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
@@ -333,13 +334,13 @@ static int arm_spe_pkt_desc_counter(const struct arm_spe_pkt *packet,
 			     (unsigned short)payload);
 
 	switch (packet->index) {
-	case 0:
+	case SPE_CNT_PKT_HDR_INDEX_TOTAL_LAT:
 		arm_spe_pkt_snprintf(&err, &buf, &buf_len, "TOT");
 		break;
-	case 1:
+	case SPE_CNT_PKT_HDR_INDEX_ISSUE_LAT:
 		arm_spe_pkt_snprintf(&err, &buf, &buf_len, "ISSUE");
 		break;
-	case 2:
+	case SPE_CNT_PKT_HDR_INDEX_TRANS_LAT:
 		arm_spe_pkt_snprintf(&err, &buf, &buf_len, "XLAT");
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

