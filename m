Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE7F62B9623
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 16:26:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728612AbgKSPZ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 10:25:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728587AbgKSPZ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 10:25:26 -0500
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CE82C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 07:25:26 -0800 (PST)
Received: by mail-pl1-x641.google.com with SMTP id 18so3089639pli.13
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 07:25:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=O87RqMurf7pPIx11yyX1x4VsxqTigVqv7i7uvntvbNs=;
        b=Pfvm6bqEMnypvbHE6q7WcG1qY9swcIWDM/yRibx6LingVppXeuUoUofX/t4Y+14Wdc
         aLnIqKRMYN/r+Q1Vb90A1PSGhl8e4UX/p6DJS4mjaQ/so1VobXZGn71bzIyBjy8trYxm
         GFElnRGzdmYwhUOIkpzK6sSNuxTKBl2W1IjIf3M0X/NRRY7qNb+Ejs6/SuJPp1+fQUvL
         0X6QBG5DeZgOEH4k81x/5bQzQWlvVyEvkFEpich/d6mmu5KpcW9rl4dvaZaumbSFAiRk
         ddRjoty4gt6xywRgL+J1be80RMk3iMkIv0A6hN+X9Bpag5kMdSyz0Kyr0JNC/1cBuAHp
         OYVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=O87RqMurf7pPIx11yyX1x4VsxqTigVqv7i7uvntvbNs=;
        b=BFZRXQCfEfzbqVUcWgxRBezCCENmIuaifFucrfIl6dMf7T6eXLplwoXepO1QDhrgmC
         vmf8uwwyYY90CcyQKChIRStjA6Q7Wah5J2utRaZd73CnD+ut6uIVQI78lLIzwL88fwiD
         hqcdgJDTbp1KFZhn98GTqfrwvNDrPi/55wc0Wo7Xi18MS1dmMvj9o42HYZzVGeWDUt4s
         XtkHEePuEMao6L3p4z4wtg0xa2VZv6OI/aI7Vcf3yyvNC29Vt7SsQVe00WVGsMi997FZ
         zpb60mRhyEPWm9/9xb53NBTjW64XD0wIw14h+xmFWtbdk47c+9kp0CI6sAiaw9pUwEN4
         +PGQ==
X-Gm-Message-State: AOAM533UD1yrkTBOLm8RMU2Fr2hu4V/ujdnKB+RdkLIpw85d9pHV25yA
        pHG0h1HZm8ZeolZbiPva/nPYjQ==
X-Google-Smtp-Source: ABdhPJw2I8Tj8xztSNsYObB61zG2p7iznEGuvyZY+NqZkGZE/52RvOMfEPYEb153MIiMGV6Vjk95fA==
X-Received: by 2002:a17:902:a504:b029:d8:ebc7:a864 with SMTP id s4-20020a170902a504b02900d8ebc7a864mr9072483plq.60.1605799525723;
        Thu, 19 Nov 2020 07:25:25 -0800 (PST)
Received: from localhost ([45.137.216.7])
        by smtp.gmail.com with ESMTPSA id h127sm135416pfe.16.2020.11.19.07.25.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 19 Nov 2020 07:25:25 -0800 (PST)
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
Subject: [PATCH v9 08/16] perf arm-spe: Refactor counter packet handling
Date:   Thu, 19 Nov 2020 23:24:33 +0800
Message-Id: <20201119152441.6972-9-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201119152441.6972-1-leo.yan@linaro.org>
References: <20201119152441.6972-1-leo.yan@linaro.org>
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
index 397ade5ffdeb..52f4339b1f0c 100644
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
 		arm_spe_pkt_out_string(&err, &buf, &buf_len, "TOT");
 		break;
-	case 1:
+	case SPE_CNT_PKT_HDR_INDEX_ISSUE_LAT:
 		arm_spe_pkt_out_string(&err, &buf, &buf_len, "ISSUE");
 		break;
-	case 2:
+	case SPE_CNT_PKT_HDR_INDEX_TRANS_LAT:
 		arm_spe_pkt_out_string(&err, &buf, &buf_len, "XLAT");
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

